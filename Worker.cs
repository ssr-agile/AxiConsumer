using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using AxiConsumer.Services.Interfaces;

namespace AxiConsumer;

/// <summary>
/// .NET hosted background service entry-point.
/// Starts the RabbitMQ consumer and keeps it alive until the host shuts down.
/// </summary>
public sealed class Worker : BackgroundService
{
    private readonly IRabbitMqConsumer _consumer;
    private readonly ILogger<Worker> _logger;

    public Worker(IRabbitMqConsumer consumer, ILogger<Worker> logger)
    {
        _consumer = consumer;
        _logger   = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Worker starting at {Time:u}", DateTimeOffset.UtcNow);

        try
        {
            await _consumer.StartAsync(stoppingToken);

            // Park here until the host requests cancellation
            await Task.Delay(Timeout.Infinite, stoppingToken);
        }
        catch (OperationCanceledException)
        {
            _logger.LogInformation("Worker stopping gracefully.");
        }
        catch (Exception ex)
        {
            _logger.LogCritical(ex, "Worker encountered a fatal error and will exit.");
            throw; // propagate so the host exits with non-zero code
        }
    }

    public override async Task StopAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("Worker stop requested at {Time:u}", DateTimeOffset.UtcNow);
        await _consumer.StopAsync(cancellationToken);
        await base.StopAsync(cancellationToken);
    }
}
