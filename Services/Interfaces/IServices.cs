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

//public interface IDatabaseService
//{
//    /// <summary>
//    /// Creates a PostgreSQL database named <paramref name="axiaAcId"/>,
//    /// a matching schema, and applies the SQL dump template.
//    /// </summary>
//    Task<bool> CreateDatabaseAndSchemaAsync(string axiaAcId, string email, CancellationToken cancellationToken);
//}

public interface IDatabaseOrchestrator
{
    Task<bool> ProvisionTenantAsync(string axiaAcId, string email, CancellationToken ct);
}

public interface ITenantProvisionService
{
    Task ProvisionSchemaAsync(string schemaName, string userPassword, CancellationToken ct);
    Task CleanupSchemaAsync(string schemaName, CancellationToken ct);
    Task SeedUserAsync(string dbName, string email, CancellationToken ct);
    Task UpdateUserKeysAsync(string dbName, string email, string authKey, string userKey, CancellationToken ct);
}

public interface IAdminDbService
{
    Task<bool> DatabaseExistsAsync(string dbName, CancellationToken ct);
    Task EnsureRoleAsync(string roleName, string password, CancellationToken ct);
    Task CleanupAsync(string identifier, CancellationToken ct);  // rollback
}

public interface ITenantDbService
{
//    Task SeedUserAsync(string dbName, string email, CancellationToken ct);
//    Task UpdateUserKeysAsync(string dbName, string email, string authKey, string userKey, CancellationToken ct);
}

public interface ILicenseService
{
    Task<LicenseResponse> ActivateAsync(string dbName, string email, CancellationToken ct);
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