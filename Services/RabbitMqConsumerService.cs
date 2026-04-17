using System.Text;
using System.Text.Json;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using RmqConsumerService.Configuration;
using RmqConsumerService.Models;
using RmqConsumerService.Services.Interfaces;

namespace RmqConsumerService.Services;

/// <summary>
/// Maintains a persistent RabbitMQ connection and consumes messages one at a time (prefetch=1).
/// A fresh DI scope is created per message so all scoped/transient services are isolated.
/// </summary>
public sealed class RabbitMqConsumerService : IRabbitMqConsumer, IAsyncDisposable
{
    private static readonly JsonSerializerOptions JsonOpts = new() { PropertyNameCaseInsensitive = true };

    private readonly RabbitMqSettings _settings;
    private readonly IServiceScopeFactory _scopeFactory;
    private readonly ILogger<RabbitMqConsumerService> _logger;

    private IConnection? _connection;
    private IChannel? _channel;

    public RabbitMqConsumerService(
        IOptions<RabbitMqSettings> settings,
        IServiceScopeFactory scopeFactory,
        ILogger<RabbitMqConsumerService> logger)
    {
        _settings    = settings.Value;
        _scopeFactory = scopeFactory;
        _logger      = logger;
    }

    // ── Public API ────────────────────────────────────────────────────────────

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("RabbitMQ Consumer starting – Host={Host} Queue={Queue}",
            _settings.Host, _settings.QueueName);

        await ConnectWithRetryAsync(cancellationToken);
    }

    public async Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("RabbitMQ Consumer stopping...");
        await DisposeAsync();
    }

    // ── Connection / setup ───────────────────────────────────────────────────

    private async Task ConnectWithRetryAsync(CancellationToken cancellationToken)
    {
        for (int attempt = 1; ; attempt++)
        {
            try
            {
                await InitialiseAsync(cancellationToken);
                return; // success
            }
            catch (OperationCanceledException)
            {
                throw;
            }
            catch (Exception ex) when (attempt < _settings.MaxRetryAttempts)
            {
                _logger.LogWarning(ex,
                    "RabbitMQ connection attempt {Attempt}/{Max} failed. Retrying in {Delay}s...",
                    attempt, _settings.MaxRetryAttempts, _settings.RetryIntervalSeconds);

                await Task.Delay(TimeSpan.FromSeconds(_settings.RetryIntervalSeconds), cancellationToken);
            }
            catch (Exception ex)
            {
                _logger.LogCritical(ex,
                    "RabbitMQ connection failed after {Max} attempts. Service cannot start.", _settings.MaxRetryAttempts);
                throw;
            }
        }
    }

    private async Task InitialiseAsync(CancellationToken cancellationToken)
    {
        var factory = new ConnectionFactory
        {
            HostName              = _settings.Host,
            Port                  = _settings.Port,
            UserName              = _settings.Username,
            Password              = _settings.Password,
            VirtualHost           = _settings.VirtualHost,
            AutomaticRecoveryEnabled = true,
            NetworkRecoveryInterval  = TimeSpan.FromSeconds(_settings.RetryIntervalSeconds)
        };

        _connection = await factory.CreateConnectionAsync(cancellationToken);
        _channel    = await _connection.CreateChannelAsync(cancellationToken: cancellationToken);

        // Durable queue – survives broker restart
        await _channel.QueueDeclareAsync(
            queue:      _settings.QueueName,
            durable:    true,
            exclusive:  false,
            autoDelete: false,
            arguments:  null,
            cancellationToken: cancellationToken);

        // Process one message at a time – ensures fair dispatch and easy back-pressure
        await _channel.BasicQosAsync(
            prefetchSize:  0,
            prefetchCount: _settings.PrefetchCount,
            global:        false,
            cancellationToken: cancellationToken);

        var consumer = new AsyncEventingBasicConsumer(_channel);
        consumer.ReceivedAsync += OnMessageReceivedAsync;

        await _channel.BasicConsumeAsync(
            queue:     _settings.QueueName,
            autoAck:   false,           // manual ack for guaranteed delivery
            consumer:  consumer,
            cancellationToken: cancellationToken);

        _logger.LogInformation("Now listening on queue: {Queue}", _settings.QueueName);
    }

    // ── Message handling ─────────────────────────────────────────────────────

    private async Task OnMessageReceivedAsync(object sender, BasicDeliverEventArgs args)
    {
        var raw = Encoding.UTF8.GetString(args.Body.ToArray());

        _logger.LogInformation("Message received – DeliveryTag={Tag}", args.DeliveryTag);
        _logger.LogDebug("Raw message body: {Body}", raw);

        try
        {
            var message = JsonSerializer.Deserialize<QueueMessage>(raw, JsonOpts);

            if (message is null)
            {
                _logger.LogError("Deserialisation returned null – message will be dead-lettered");
                await _channel!.BasicNackAsync(args.DeliveryTag, multiple: false, requeue: false);
                return;
            }

            // Set the ApiName from the first key of QueueData
            if (message != null && string.IsNullOrEmpty(message.ApiName) && !string.IsNullOrEmpty(message.QueueData))
            {
                try
                {
                    var queueDataObj = JsonSerializer.Deserialize<Dictionary<string, object>>(message.QueueData);
                    message.ApiName = queueDataObj?.Keys.FirstOrDefault() ?? string.Empty;
                }
                catch (JsonException)
                {
                    // Handle invalid JSON in QueueData
                    message.ApiName = string.Empty;
                }
            }

            _logger.LogInformation(
                "Parsed message – ApiName={ApiName} QueueName={QueueName} Delay={Delay}ms",
                message.ApiName, message.QueueName, message.TimespanDelay);

            // Optional per-message delay (e.g. for rate-limiting or scheduling)
            //if (int.TryParse(message.TimespanDelay, out int delayMs) && delayMs > 0)
            if (message.TimespanDelay > 0)
            {
                _logger.LogDebug("Applying configured delay of {Delay}ms", message.TimespanDelay);
                await Task.Delay(message.TimespanDelay);
            }

            // New scope per message → clean, isolated dependencies
            await using var scope = _scopeFactory.CreateAsyncScope();
            var processor = scope.ServiceProvider.GetRequiredService<IMessageProcessor>();
            await processor.ProcessAsync(message, CancellationToken.None);

            await _channel!.BasicAckAsync(args.DeliveryTag, multiple: false);
            _logger.LogInformation("Message acknowledged – DeliveryTag={Tag}", args.DeliveryTag);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled error processing message – sending to dead-letter. DeliveryTag={Tag}", args.DeliveryTag);
            await _channel!.BasicNackAsync(args.DeliveryTag, multiple: false, requeue: false);
        }
    }

    // ── Cleanup ───────────────────────────────────────────────────────────────

    public async ValueTask DisposeAsync()
    {
        if (_channel is not null) { await _channel.DisposeAsync(); _channel = null; }
        if (_connection is not null) { await _connection.DisposeAsync(); _connection = null; }
    }
}
