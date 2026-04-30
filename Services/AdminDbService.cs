using Microsoft.Extensions.Options;
using Npgsql;
using AxiConsumer.Configuration;
using AxiConsumer.Services.Interfaces;

namespace AxiConsumer.Services;

public sealed class AdminDbService : IAdminDbService
{
    private readonly NpgsqlDataSource _sharedDs;
    private readonly DatabaseSettings _settings;
    private readonly ILogger<AdminDbService> _logger;

    public AdminDbService([FromKeyedServices("admin")] NpgsqlDataSource sharedDs, IOptions<DatabaseSettings> settings, ILogger<AdminDbService> logger)
    {
        _sharedDs = sharedDs;
        _settings = settings.Value;
        _logger = logger;
    }

    public async Task<bool> DatabaseExistsAsync(string dbName, CancellationToken ct)
    {
        await using var cmd = _sharedDs.CreateCommand("SELECT 1 FROM pg_database WHERE datname = $1");
        cmd.Parameters.AddWithValue(dbName);
        return await cmd.ExecuteScalarAsync(ct) is not null;
    }
    // Note: NpgsqlDataSource.CreateCommand() handles open/close internally — no conn.OpenAsync() needed

    public async Task EnsureRoleAsync(string roleName, string password, CancellationToken ct)
    {
        // DO $$ can't use parameters for identifiers — sanitised upstream
        await using var cmd = _sharedDs.CreateCommand($"""
            DO $$
            BEGIN
                IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '{roleName}') THEN
                    CREATE ROLE "{roleName}" LOGIN PASSWORD '{password}';
                END IF;
            END $$;
            """);
        await cmd.ExecuteNonQueryAsync(ct);
        _logger.LogInformation("Role '{Role}' ensured.", roleName);
    }

    public async Task CleanupAsync(string roleName, CancellationToken ct)
    {
        try
        {
            _logger.LogWarning("Dropping role '{Role}' (rollback cleanup).", roleName);
            await using var cmd = _sharedDs.CreateCommand($"DROP ROLE IF EXISTS \"{roleName}\"");
            await cmd.ExecuteNonQueryAsync(ct);
        }
        catch (Exception ex)
        {
            _logger.LogCritical(ex, "CRITICAL: Failed to drop role '{Role}'. Manual cleanup required.", roleName);
        }
    }
}
