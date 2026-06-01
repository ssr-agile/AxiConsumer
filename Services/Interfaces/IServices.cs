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
    Task<bool> ProvisionTenantAsync(AxiAdminData data, string hashedPassword, CancellationToken ct);
}

public interface ITenantProvisionService
{
    Task ProvisionSchemaAsync(string schemaName, string userPassword, CancellationToken ct);
    Task CleanupSchemaAsync(string schemaName, CancellationToken ct);
    Task<bool> AddAccountAsync(AxiAdminData data, CancellationToken ct);
    Task SeedUserAsync(string dbName, string email, string userName, string nickName, string hashedPassword, CancellationToken ct);
    Task<LicenseResponse> ActivateAsync(string dbName, string email, CancellationToken ct);
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

public interface IConfigurationFileService
{
    Task<bool> UpdateConfigsAsync(string newAxiAccId, CancellationToken ct);
}

public interface IEmailService
{
    Task SendSuccessAsync(string toEmail, string orgName, string axiaAcId, string userName, string sessionId, string password, CancellationToken cancellationToken);
    Task SendFailureAsync(string toEmail, string orgName, string axiaAcId, string userName, string reason, CancellationToken cancellationToken);
}

/// <summary>
/// Abstracts token storage.
/// </summary>
public interface ITokenStore
{
    //Task SetAsync(SessionData session, CancellationToken ct = default);
    Task<SessionData?> GetAsync(string sesstionId, CancellationToken ct = default);
    Task<bool> UpdateAsync(Action<SessionData> mutate, string sessionId, CancellationToken ct = default); // ← patch in-place
    //Task ClearAsync(CancellationToken ct = default);
    //string GetSessionIdAsync(CancellationToken ct = default);
    //Task<bool> HasTokenAsync(CancellationToken ct = default);
}

/// <summary>
/// Generates random password
/// hashes given password
/// </summary>
public interface IPasswordService
{
    string GenerateRandomPassword(int length);
    string HashPassword(string password);
    bool VerifyPassword(string password, string hashedPassword);
}