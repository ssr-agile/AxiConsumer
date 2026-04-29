using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Npgsql;
using RmqConsumerService.Configuration;
using RmqConsumerService.Services.Interfaces;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace RmqConsumerService.Services;

public sealed class TenantProvisionService : ITenantProvisionService
{
    // Identical rule to the orchestrator's Sanitise — belt-and-braces at the service boundary
    private static readonly Regex SafeIdentifier =
        new(@"^[a-z_][a-z0-9_]{0,62}$", RegexOptions.Compiled | RegexOptions.CultureInvariant);

    private readonly NpgsqlDataSource _sharedDs;
    private readonly string _migrationsPath;
    private readonly ILogger<TenantProvisionService> _logger;

    public TenantProvisionService(
        [FromKeyedServices("shared")] NpgsqlDataSource sharedDs,
        IOptions<DatabaseSettings> settings,
        ILogger<TenantProvisionService> logger)
    {
        _sharedDs = sharedDs;
        _migrationsPath = Path.GetFullPath(settings.Value.MigrationsPath);
        _logger = logger;
    }

    public async Task ProvisionSchemaAsync(string schemaName, string userPassword, CancellationToken ct)
    {
        ValidateIdentifier(schemaName);

        if (string.IsNullOrWhiteSpace(userPassword))
            throw new ArgumentException("Tenant database user password is required.", nameof(userPassword));

        var scripts = LoadScripts();
        _logger.LogInformation("Provisioning schema '{Schema}' with {Count} scripts.", schemaName, scripts.Length);

        await using var conn = await _sharedDs.OpenConnectionAsync(ct);
        await using var tx = await conn.BeginTransactionAsync(ct);

        try
        {
            await EnsureMigrationLogAsync(conn, tx, ct);

            foreach (var (relativeName, fullPath) in scripts)
            {
                var raw = await File.ReadAllTextAsync(fullPath, ct);
                var checksum = ComputeChecksum(raw);
                var sql = RenderTenantSql(raw, schemaName, userPassword);
                // var sql = raw.Replace("{schema}", QuoteIdentifier(schemaName), StringComparison.Ordinal);

                // Skip if already applied for this schema (idempotent re-runs)
                if (await IsAlreadyAppliedAsync(conn, tx, schemaName, relativeName, ct))
                {
                    _logger.LogDebug("Script '{Script}' already applied for '{Schema}' — skipping.", relativeName, schemaName);
                    continue;
                }

                _logger.LogInformation("Executing '{Script}' for schema '{Schema}'.", relativeName, schemaName);

                try
                {
                    await using var cmd = new NpgsqlCommand(sql, conn, tx) { CommandTimeout = 0 };
                    await cmd.ExecuteNonQueryAsync(ct);
                }
                catch (Exception ex)
                {
                    // Wrap with script name so the log makes the failure immediately actionable
                    throw new InvalidOperationException(
                        $"Script '{relativeName}' failed for schema '{schemaName}': {ex.Message}", ex);
                }

                await LogMigrationAsync(conn, tx, schemaName, relativeName, checksum, ct);
            }

            await tx.CommitAsync(ct);
            _logger.LogInformation("Schema '{Schema}' provisioned successfully.", schemaName);
        }
        catch
        {
            await tx.RollbackAsync(ct);
            // PG DDL is transactional — schema won't exist after rollback.
            // Defensive drop handles edge cases where a future script breaks the assumption.
            await using var drop = new NpgsqlCommand(
                $"DROP SCHEMA IF EXISTS {QuoteIdentifier(schemaName)} CASCADE;", conn);
            await drop.ExecuteNonQueryAsync(ct);

            _logger.LogError("Schema '{Schema}' provisioning rolled back.", schemaName);
            throw;
        }
    }

    private static string RenderTenantSql(string sql, string schemaName, string userPassword)
    {
        return sql
            .Replace("{schema_name}", QuoteLiteral(schemaName), StringComparison.Ordinal)
            .Replace("{user_password}", QuoteLiteral(userPassword), StringComparison.Ordinal)
            .Replace("{schema}", QuoteIdentifier(schemaName), StringComparison.Ordinal);
    }

    public async Task CleanupSchemaAsync(string schemaName, CancellationToken ct)
    {
        ValidateIdentifier(schemaName);
        try
        {
            await using var conn = await _sharedDs.OpenConnectionAsync(ct);

            await using var dropSchema = new NpgsqlCommand(
                $"DROP SCHEMA IF EXISTS {QuoteIdentifier(schemaName)} CASCADE;", conn);
            await dropSchema.ExecuteNonQueryAsync(ct);

            // Remove from migration log so re-provisioning is clean
            await using var dropLog = new NpgsqlCommand(
                "DELETE FROM public.__schema_migrations WHERE schema_name = @s;", conn);
            dropLog.Parameters.AddWithValue("s", schemaName);
            await dropLog.ExecuteNonQueryAsync(ct);

            _logger.LogWarning("Schema '{Schema}' dropped (cleanup).", schemaName);
        }
        catch (Exception ex)
        {
            _logger.LogCritical(ex, "CRITICAL: Failed to clean up schema '{Schema}'. Manual cleanup required.", schemaName);
        }
    }

    public async Task SeedUserAsync(string dbName, string email, CancellationToken ct)
    {
        await using var conn = await _sharedDs.OpenConnectionAsync(ct);

        var nickname = email.Contains('@') ? email[..email.IndexOf('@')] : email;
        await using var cmd = new NpgsqlCommand($"SELECT \"{dbName}\".setup_new_user(@u, @e, @n)", conn);
        cmd.Parameters.AddWithValue("u", email);
        cmd.Parameters.AddWithValue("e", email);
        cmd.Parameters.AddWithValue("n", nickname);
        await cmd.ExecuteNonQueryAsync(ct);
        _logger.LogInformation("Seed user created in '{Db}'.", dbName);
    }

    public async Task UpdateUserKeysAsync(string dbName, string email, string authKey, string userKey, CancellationToken ct)
    {
        await using var conn = await _sharedDs.OpenConnectionAsync(ct);
        //await conn.OpenAsync(ct);

        await using var cmd = new NpgsqlCommand(
            $"UPDATE \"{dbName}\".axusers SET authkey = @ak, userkey = @uk WHERE email = @u", conn);
        cmd.Parameters.AddWithValue("ak", authKey);
        cmd.Parameters.AddWithValue("uk", userKey);
        cmd.Parameters.AddWithValue("u", email);

        var affected = await cmd.ExecuteNonQueryAsync(ct);
        if (affected == 0)
            throw new InvalidOperationException($"User '{email}' not found in {dbName}.axusers — keys not updated.");
    }


    // ── Private helpers ───────────────────────────────────────────────────────

    private (string RelativeName, string FullPath)[] LoadScripts()
    {
        if (!Directory.Exists(_migrationsPath))
            throw new DirectoryNotFoundException($"Migrations folder not found: '{_migrationsPath}'.");

        var scripts = Directory.GetFiles(_migrationsPath, "*.sql", SearchOption.AllDirectories)
            .Select(p => (
                RelativeName: Path.GetRelativePath(_migrationsPath, p)
                    .Replace(Path.DirectorySeparatorChar, '/')
                    .Replace(Path.AltDirectorySeparatorChar, '/'),
                FullPath: p))
            .OrderBy(x => x.RelativeName, StringComparer.Ordinal)
            .ToArray();

        if (scripts.Length == 0)
            throw new InvalidOperationException($"No .sql files found in '{_migrationsPath}'.");

        return scripts;
    }

    private static async Task EnsureMigrationLogAsync(
        NpgsqlConnection conn, NpgsqlTransaction tx, CancellationToken ct)
    {
        const string sql = """
            CREATE TABLE IF NOT EXISTS public.__schema_migrations
            (
                id          bigserial    PRIMARY KEY,
                schema_name text         NOT NULL,
                script_name text         NOT NULL,
                checksum    text         NOT NULL,
                executed_at timestamptz  NOT NULL DEFAULT now(),
                UNIQUE(schema_name, script_name)
            );
            REVOKE ALL ON public.__schema_migrations FROM PUBLIC;
            GRANT SELECT, INSERT, DELETE ON public.__schema_migrations TO CURRENT_USER;
            """;

        await using var cmd = new NpgsqlCommand(sql, conn, tx);
        await cmd.ExecuteNonQueryAsync(ct);
    }

    private static async Task<bool> IsAlreadyAppliedAsync(
        NpgsqlConnection conn, NpgsqlTransaction tx,
        string schemaName, string scriptName, CancellationToken ct)
    {
        const string sql = """
            SELECT 1 FROM public.__schema_migrations
            WHERE schema_name = @s AND script_name = @n
            LIMIT 1;
            """;
        await using var cmd = new NpgsqlCommand(sql, conn, tx);
        cmd.Parameters.AddWithValue("s", schemaName);
        cmd.Parameters.AddWithValue("n", scriptName);
        return await cmd.ExecuteScalarAsync(ct) is not null;
    }

    private static async Task LogMigrationAsync(
        NpgsqlConnection conn, NpgsqlTransaction tx,
        string schemaName, string scriptName, string checksum, CancellationToken ct)
    {
        const string sql = """
            INSERT INTO public.__schema_migrations(schema_name, script_name, checksum)
            VALUES (@s, @n, @c)
            ON CONFLICT(schema_name, script_name) DO NOTHING;
            """;
        await using var cmd = new NpgsqlCommand(sql, conn, tx);
        cmd.Parameters.AddWithValue("s", schemaName);
        cmd.Parameters.AddWithValue("n", scriptName);
        cmd.Parameters.AddWithValue("c", checksum);
        await cmd.ExecuteNonQueryAsync(ct);
    }

    private static string ComputeChecksum(string content)
    {
        var hash = SHA256.HashData(Encoding.UTF8.GetBytes(content));
        return Convert.ToHexString(hash).ToLowerInvariant();
    }

    private static void ValidateIdentifier(string name)
    {
        if (!SafeIdentifier.IsMatch(name))
            throw new ArgumentException(
                "Invalid schema name. Use lowercase letters, digits, underscores; start with letter/underscore; max 63 chars.",
                nameof(name));
    }

    private static string QuoteIdentifier(string id) =>
        "\"" + id.Replace("\"", "\"\"", StringComparison.Ordinal) + "\"";

    private static string QuoteLiteral(string value) =>
        "'" + value.Replace("'", "''", StringComparison.Ordinal) + "'";
}