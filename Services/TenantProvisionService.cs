using AxiConsumer.Configuration;
using AxiConsumer.Models;
using AxiConsumer.Services.Interfaces;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Npgsql;
using Org.BouncyCastle.Crypto;
using System.Diagnostics.Metrics;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Runtime;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using static System.Runtime.InteropServices.JavaScript.JSType;


namespace AxiConsumer.Services;

public sealed class TenantProvisionService : ITenantProvisionService
{
    // Identical rule to the orchestrator's Sanitise — belt-and-braces at the service boundary
    private static readonly Regex SafeIdentifier =
        new(@"^[a-z_][a-z0-9_]{0,62}$", RegexOptions.Compiled | RegexOptions.CultureInvariant);

    private readonly NpgsqlDataSource _sharedDs;
    private readonly string _migrationsPath;
    private readonly ILogger<TenantProvisionService> _logger; 
    private readonly IHttpClientFactory _factory;
    private readonly DatabaseSettings _settings;
    private readonly ITokenStore _tokenStore;

    public TenantProvisionService(
        [FromKeyedServices("shared")] NpgsqlDataSource sharedDs,
        IOptions<DatabaseSettings> settings,
        IHttpClientFactory factory, 
        ILogger<TenantProvisionService> logger,
        ITokenStore tokenStore)
    {
        _sharedDs = sharedDs;
        _migrationsPath = Path.GetFullPath(settings.Value.MigrationsPath);
        _logger = logger;
        _factory = factory;
        _settings = settings.Value;
        _tokenStore = tokenStore;
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

    public async Task SeedUserAsync(string dbName, string email, string userName, string nickName, string hashedPassword, CancellationToken ct)
    {
        await using var conn = await _sharedDs.OpenConnectionAsync(ct);

        var uname = !string.IsNullOrEmpty(userName) ? 
                            userName : email.Contains('@') 
                            ? email[..email.IndexOf('@')] : email;
        var nname = !string.IsNullOrEmpty(nickName) ? nickName : uname;

        await using var cmd = new NpgsqlCommand($"SELECT \"{dbName}\".setup_new_user(@u, @e, @n, @p)", conn);
        cmd.Parameters.AddWithValue("u", uname);
        cmd.Parameters.AddWithValue("e", email);
        cmd.Parameters.AddWithValue("n", nname);
        cmd.Parameters.AddWithValue("p", hashedPassword);
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

    public async Task<bool> AddAccountAsync(AxiAdminData data, CancellationToken ct)
    {
        var client = _factory.CreateClient("AxiClient");
        string url = "api/AxiClient/AddAxiAccount";
        var payload = new {
            Username = data.Username,
            Email = data.Email,
            OrgName = data.OrgName,
            NickName = string.IsNullOrEmpty(data.NickName) ? data.Username : data.NickName,
            AxiAccId = data.AxiAccId,
            ContactPersonName = data.ContactPersonName,
            MobileNo = data.MobileNo,
            TaxNo = data.TaxNo,
            State = data.State,
            Country = data.Country,
            Address = data.Address,
            CountryCode = data.CountryCode,
            Region = data.Region,
            IsVerified = data.IsVerified,
            AuthProvider = data.AuthProvider,
            SsoId = data.SsoId,
            SchemaName  = data.SchemaName,
            DatabaseName = data.DatabaseName,
            AxiRedisKey = data.AxiRedisKey
        };

        _logger.LogInformation("Creating Axi Account & User for '{AxiAccountId}' / '{Email}'.", data.AxiAccId, data.Email);

        string token = await RequireTokenAsync(data.AxiRedisKey, ct);

        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await client.PostAsJsonAsync(url, payload, ct);
        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<ApiResponse<object>>(cancellationToken: ct);

        if (result is null || !result.Success)
            throw new InvalidOperationException($"Account creation failed: {result?.Message ?? "empty response"}");
        return true;
    }

    public async Task<LicenseResponse> ActivateAsync(string dbName, string email, CancellationToken ct)
    {
        var client = _factory.CreateClient("AxiClient");
        string url = "api/AxiClient/AxiPrimaryUser";
        var payload = new LicenseRequest { UserName = email, SchemaName = dbName, AppDomain = _settings.AppDomain };

        _logger.LogInformation("Activating license for '{Db}' / '{Email}'.", dbName, email);

        //string token = await RequireTokenAsync(data.AxiRedisKey, ct);

        //client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

        var response = await client.PostAsJsonAsync(url, payload, ct);
        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<LicenseResponse>(cancellationToken: ct);

        if (result is null || string.IsNullOrEmpty(result.AuthKey) || string.IsNullOrEmpty(result.UserKey))
            throw new InvalidOperationException($"License activation failed: {result?.Message ?? "empty response"}");

        return result;
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

    /// <summary>Reads session token; throws 401 if none exists (SECURE endpoints).</summary>
    private async Task<string> RequireTokenAsync(string sessionId, CancellationToken ct)
    {
        var session = await _tokenStore.GetAsync(sessionId, ct);
        if (session is null || string.IsNullOrEmpty(session.Token))
            throw new UnauthorizedAccessException("Token not found, unauthorized access.");
        return session.Token;
    }
}