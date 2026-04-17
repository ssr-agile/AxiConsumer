using System.Text.Json.Serialization;

namespace RmqConsumerService.Models;

/// <summary>
/// Top-level envelope received from RabbitMQ.
/// </summary>
public sealed class QueueMessage
{
    [JsonPropertyName("queuename")]
    public string QueueName { get; init; } = string.Empty;

    [JsonPropertyName("apiname")]
    public string ApiName { get; set; } = string.Empty;

    /// <summary>JSON-encoded payload; deserialized by each handler.</summary>
    [JsonPropertyName("queuedata")]
    public string QueueData { get; init; } = string.Empty;

    [JsonPropertyName("timespandelay")]
    public int TimespanDelay { get; init; } = 0;
}
