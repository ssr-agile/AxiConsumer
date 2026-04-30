using AxiConsumer.Models;

namespace AxiConsumer.Handlers;

/// <summary>
/// Implement this interface for every new API/handler you want to support.
/// Register it in DI and it will be auto-dispatched based on ApiName.
/// </summary>
public interface IQueueHandler
{
    /// <summary>Must match <see cref="QueueMessage.ApiName"/> (case-insensitive).</summary>
    string ApiName { get; }

    Task HandleAsync(QueueMessage message, CancellationToken cancellationToken);
}
