using Microsoft.Extensions.Logging;
using AxiConsumer.Handlers;
using AxiConsumer.Models;
using AxiConsumer.Services.Interfaces;

namespace AxiConsumer.Services;

/// <summary>
/// Resolves the correct <see cref="IQueueHandler"/> by ApiName and delegates to it.
/// Adding support for a new API only requires implementing IQueueHandler and registering it in DI.
/// </summary>
public sealed class MessageProcessorService : IMessageProcessor
{
    private readonly IEnumerable<IQueueHandler> _handlers;
    private readonly ILogger<MessageProcessorService> _logger;

    public MessageProcessorService(IEnumerable<IQueueHandler> handlers, ILogger<MessageProcessorService> logger)
    {
        _handlers = handlers;
        _logger   = logger;
    }

    public async Task ProcessAsync(QueueMessage message, CancellationToken cancellationToken)
    {
        _logger.LogDebug("Resolving handler for ApiName={ApiName}", message.ApiName);

        var handler = _handlers.FirstOrDefault(h =>
            h.ApiName.Equals(message.ApiName, StringComparison.OrdinalIgnoreCase));

        if (handler is null)
        {
            _logger.LogWarning("No handler registered for ApiName={ApiName}. Message will be skipped.", message.ApiName);
            return;
        }

        _logger.LogInformation("Dispatching to {Handler}", handler.GetType().Name);
        await handler.HandleAsync(message, cancellationToken);
    }
}
