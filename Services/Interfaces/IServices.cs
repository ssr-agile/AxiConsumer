using AxiConsumer.Models;

namespace AxiConsumer.Services.Interfaces;

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
    Task<bool> ProvisionTenantAsync(string axiaAcId, string email, string userName, CancellationToken ct);
}

public interface ITenantProvisionService
{
    Task ProvisionSchemaAsync(string schemaName, string userPassword, CancellationToken ct);
    Task CleanupSchemaAsync(string schemaName, CancellationToken ct);
    Task SeedUserAsync(string dbName, string email, string userName, CancellationToken ct);
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

public interface IIISService
{
    /// <summary>
    /// Recycles all configured application pools in parallel.
    /// Logs per-pool success/failure without throwing — a pool failure
    /// must not block email or ack.
    /// </summary>
    Task IISRecyclePoolsAsync(CancellationToken ct);
}

public interface IConfigurationFileService
{
    Task<bool> UpdateConfigsAsync(string newAxiAcId, CancellationToken ct);
}

public interface IEmailService
{
    Task SendSuccessAsync(string toEmail, string orgName, string axiaAcId, string userName, CancellationToken cancellationToken);
    Task SendFailureAsync(string toEmail, string orgName, string axiaAcId, string userName, string reason, CancellationToken cancellationToken);
}