namespace RmqConsumerService.Configuration;

public sealed class RabbitMqSettings
{
    public string Host { get; init; } = "localhost";
    public int Port { get; init; } = 5672;
    public string Username { get; init; } = "guest";
    public string Password { get; init; } = "guest";
    public string VirtualHost { get; init; } = "/";
    public string QueueName { get; init; } = string.Empty;
    public ushort PrefetchCount { get; init; } = 1;
    public int RetryIntervalSeconds { get; init; } = 5;
    public int MaxRetryAttempts { get; init; } = 5;
}
