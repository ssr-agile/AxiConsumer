using RmqConsumerService.Models;

namespace RmqConsumerService.Services.Interfaces;

public interface IRabbitMqConsumer
{
    Task StartAsync(CancellationToken cancellationToken);
    Task StopAsync(CancellationToken cancellationToken);
}

public interface IMessageProcessor
{
    Task ProcessAsync(QueueMessage message, CancellationToken cancellationToken);
}

public interface IDatabaseService
{
    /// <summary>
    /// Creates a PostgreSQL database named <paramref name="axiaAcId"/>,
    /// a matching schema, and applies the SQL dump template.
    /// </summary>
    Task<bool> CreateDatabaseAndSchemaAsync(string axiaAcId, string email, CancellationToken cancellationToken);
}

public interface IEmailService
{
    Task SendSuccessAsync(string toEmail, string orgName, string axiaAcId, CancellationToken cancellationToken);
    Task SendFailureAsync(string toEmail, string orgName, string axiaAcId, string reason, CancellationToken cancellationToken);
}

public interface IConfigurationFileService
{
    Task<bool> UpdateConfigsAsync(string newAxiAcId, CancellationToken ct);
}