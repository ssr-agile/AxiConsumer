//using Microsoft.Extensions.Logging;
//using Microsoft.Extensions.Options;
//using Npgsql;
//using AxiConsumer.Configuration;
//using AxiConsumer.Models;
//using AxiConsumer.Services.Interfaces;
//using System.Net.Http;
//using System.Net.Http.Json;
//using Polly;

//namespace AxiConsumer.Services;

//public sealed class DatabaseService : IDatabaseService
//{
//    private readonly DatabaseSettings _settings;
//    private readonly ILogger<DatabaseService> _logger;
//    private readonly IHttpClientFactory _httpClientFactory;
//    //private readonly NpgsqlDataSource _adminDb;

//    public DatabaseService(
//        IOptions<DatabaseSettings> settings,
//        ILogger<DatabaseService> logger,
//        IHttpClientFactory httpClientFactory)
//        //NpgsqlDataSource adminDb)
//    {
//        _settings = settings.Value;
//        _logger = logger;
//        _httpClientFactory = httpClientFactory;
//        //_adminDb = adminDb;
//    }

//    public async Task<bool> CreateDatabaseAndSchemaAsync(string axiaAcId, string email, CancellationToken ct)
//    {
//        if (string.IsNullOrWhiteSpace(axiaAcId))
//            throw new ArgumentException("axiaAcId cannot be empty.", nameof(axiaAcId));

//        // Sanitise: only lowercase letters, digits, underscores
//        var identifier = Sanitise(axiaAcId);

//        try
//        {
//            // 1. Clone the DB (Admin Connection)
//            var retryPolicy = Policy
//                .Handle<NpgsqlException>(ex => ex.IsTransient)
//                .Or<TimeoutException>()
//                .WaitAndRetryAsync(3, retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)));

//            await retryPolicy.ExecuteAsync(async () =>
//            {
//                await CloneDatabaseFromTemplateAsync(identifier, ct);
//            });

//            // 2. Setup Schema & Initial User (Tenant Connection)
//            await ApplyPostCloneFixesAndSeedAsync(identifier, email, ct);

//            // 3. License Activation (External API)
//            var license = await ActivateLicenseAsync(identifier, email, ct);

//            // 4. Update Keys in the new DB
//            await UpdateUserKeysAsync(identifier, email, license.AuthKey, license.UserKey, ct);

//            _logger.LogInformation("Provisioning and Activation successful for {Id}", identifier);
//            return true;
//        }
//        catch (Exception ex)
//        {
//            _logger.LogError(ex, "Provisioning failed for {Id}. Initiating rollback/cleanup.", identifier);
//            await CleanupDatabaseAndRoleAsync(identifier, ct);
//            throw; // Re-throw to inform the consumer service
//        }
//    }

//    // ── Steps ────────────────────────────────────────────────────────────────
//    private async Task CloneDatabaseFromTemplateAsync(string dbName, CancellationToken ct)
//    {
//        var template = Sanitise(_settings.TemplateDatabaseName);

//        await using var conn = new NpgsqlConnection(_settings.BuildConnectionString(_settings.AdminDatabase));
//        await conn.OpenAsync(ct);

//        // ── 1. Guard: target already exists ──────────────────────────────────
//        await using (var chk = conn.CreateCommand())
//        {
//            chk.CommandText = "SELECT 1 FROM pg_database WHERE datname = @n";
//            chk.Parameters.AddWithValue("n", dbName);
//            if (await chk.ExecuteScalarAsync(ct) is not null)
//            {
//                _logger.LogWarning("Database '{Db}' already exists – skipping clone.", dbName);
//                return;
//            }
//        }

//        // ── 2. Guard: template must exist ─────────────────────────────────────
//        await using (var chk = conn.CreateCommand())
//        {
//            chk.CommandText = "SELECT 1 FROM pg_database WHERE datname = @n";
//            chk.Parameters.AddWithValue("n", template);
//            if (await chk.ExecuteScalarAsync(ct) is null)
//                throw new InvalidOperationException($"Template database '{template}' does not exist.");
//        }

//        // ── 3. Create role (idempotent) ───────────────────────────────────────
//        // DO $$ block runs as a single statement — no extra round-trips
//        await using (var cmd = conn.CreateCommand())
//        {
//            cmd.CommandText = $"""
//            DO $$
//            BEGIN
//                IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '{dbName}') THEN
//                    CREATE ROLE "{dbName}" LOGIN PASSWORD '{_settings.DefaultRolePassword}';
//                END IF;
//            END
//            $$;
//            """;
//            await cmd.ExecuteNonQueryAsync(ct);
//            _logger.LogInformation("Role '{Role}' ensured.", dbName);
//        }

//        // ── 4. Terminate active connections on template ───────────────────────
//        //      PostgreSQL refuses to clone a template that has active sessions.
//        await using (var cmd = conn.CreateCommand())
//        {
//            cmd.CommandText = """
//            SELECT COUNT(pg_terminate_backend(pid))
//            FROM   pg_stat_activity
//            WHERE datname = @n 
//            AND pid <> pg_backend_pid()
//            AND usename NOT IN ('maintenance_admin', 'backup_service', 'readonly_dev');
//            """;
//            cmd.Parameters.AddWithValue("n", template);
//            var killed = Convert.ToInt64(await cmd.ExecuteScalarAsync(ct) ?? 0L);
//            //var Terminated = (bool?)(await killCmd.ExecuteScalarAsync(ct)) ?? false;
//            if (killed > 0)
//                _logger.LogWarning("Terminated {N} connection(s) on template before clone.", killed);
//        }

//        // ── 5. Clone — must be outside transaction ────────────────────────────
//        await using (var cmd = conn.CreateCommand())
//        {
//            cmd.CommandTimeout = 300; // 5 minutes
//            cmd.CommandText = $"CREATE DATABASE \"{dbName}\" TEMPLATE \"{template}\" OWNER = \"{dbName}\"";
//            await cmd.ExecuteNonQueryAsync(ct);
//            _logger.LogInformation("Database '{Db}' cloned from '{Template} & set OWNER to '{owner}'.", dbName, template, dbName);
//        }
//    }

//    private async Task ApplyPostCloneFixesAndSeedAsync(string dbName, string email, CancellationToken ct)
//    {
//        var templateSchema = Sanitise(_settings.TemplateSchemaName);
//        await using var conn = new NpgsqlConnection(_settings.BuildConnectionString(dbName));
//        await conn.OpenAsync(ct);
//        await using var tx = await conn.BeginTransactionAsync(ct);

//        try
//        {
//            // STEP 1: Rename Schema and Reassign Ownership FIRST
//            // This ensures the functions now live in a namespace called 'dbName'
//            await using var setupCmd = new NpgsqlCommand($$"""
//            -- 1. Rename schema (template name → tenant name)
//            ALTER SCHEMA "{{templateSchema}}" RENAME TO "{{dbName}}";

//            -- 2. Reassign ownership (assuming the template objects were owned by the templateSchema role)
//            REASSIGN OWNED BY "{{templateSchema}}" TO "{{dbName}}";
//            ALTER SCHEMA "{{dbName}}" OWNER TO "{{dbName}}";
//            ALTER SCHEMA public OWNER TO "{{dbName}}";

//            -- 3. Database & Object Privileges
//            GRANT ALL PRIVILEGES ON DATABASE "{{dbName}}" TO "{{dbName}}";
//            GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA "{{dbName}}" TO "{{dbName}}";
//            GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "{{dbName}}" TO "{{dbName}}";
//            GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA "{{dbName}}" TO "{{dbName}}";

//            -- 4. Search Path
//            ALTER DATABASE "{{dbName}}" SET search_path TO "{{dbName}}", public;
//            SET search_path TO "{{dbName}}", public; -- current connection
//            """, conn, tx);

//            await setupCmd.ExecuteNonQueryAsync(ct);

//            // STEP 2: Now that the schema is renamed, fix the function bodies
//            await using var rewriteCmd = new NpgsqlCommand($$"""
//            DO $$
//            DECLARE
//                r RECORD;
//                v_def TEXT;
//            BEGIN
//                FOR r IN
//                    SELECT oid, proname
//                    FROM   pg_proc
//                    WHERE  pronamespace = (SELECT oid FROM pg_namespace WHERE nspname = '{{dbName}}')
//                LOOP
//                    v_def := pg_get_functiondef(r.oid);
                    
//                    -- Only rewrite if the template schema name exists inside the definition
//                    IF v_def LIKE '%{{templateSchema}}.%' THEN
//                        EXECUTE replace(v_def, '{{templateSchema}}.', '{{dbName}}.');
//                    END IF;
//                END LOOP;
//            END
//            $$;
//            """, conn, tx);

//            await rewriteCmd.ExecuteNonQueryAsync(ct);

//            int index = email.IndexOf('@');
//            string nickname = index > -1 ? email.Substring(0, index) : email;
//            await using var insertNewUserCmd = new NpgsqlCommand($"SELECT {dbName}.setup_new_user(@u, @e, @n)", conn, tx);
//            insertNewUserCmd.Parameters.AddWithValue("u", email);
//            insertNewUserCmd.Parameters.AddWithValue("e", email);
//            insertNewUserCmd.Parameters.AddWithValue("n", nickname);
//            await insertNewUserCmd.ExecuteNonQueryAsync(ct);

//            await tx.CommitAsync(ct);
//            _logger.LogInformation("Database '{Db}' fully provisioned.", dbName);
//        }
//        catch (Exception ex)
//        {
//            await tx.RollbackAsync(ct);
//            _logger.LogError(ex, "Failed to provision database '{Db}'", dbName);
//            throw;
//        }
//    }

//    private async Task<LicenseResponse> ActivateLicenseAsync(string dbName, string email, CancellationToken ct)
//    {
//        var client = _httpClientFactory.CreateClient();
//        var payload = new LicenseRequest
//        {
//            UserName = email,
//            SchemaName = dbName,
//            AppDomain = _settings.AppDomain // Pull from config
//        };

//        var response = await client.PostAsJsonAsync(_settings.LicenseApiUrl, payload, ct);
//        var result = await response.Content.ReadFromJsonAsync<LicenseResponse>(cancellationToken: ct);

//        //if (result == null || !result.Success)
//        if (result == null || string.IsNullOrEmpty(result.AuthKey) || string.IsNullOrEmpty(result.UserKey))
//        {
//            throw new InvalidOperationException($"License activation failed: {result?.Message ?? "Unknown Error"}");
//        }

//        return result;
//    }

//    private async Task UpdateUserKeysAsync(string dbName, string email, string? authKey, string? userKey, CancellationToken ct)
//    {
//        await using var conn = new NpgsqlConnection(_settings.BuildConnectionString(dbName));
//        await conn.OpenAsync(ct);

//        var sql = $"UPDATE {dbName}.axusers SET authkey = @ak, userkey = @uk WHERE email = @u";
//        await using var cmd = new NpgsqlCommand(sql, conn);
//        cmd.Parameters.AddWithValue("ak", authKey ?? (object)DBNull.Value);
//        cmd.Parameters.AddWithValue("uk", userKey ?? (object)DBNull.Value);
//        cmd.Parameters.AddWithValue("u", email);

//        var affected = await cmd.ExecuteNonQueryAsync(ct);
//        if (affected == 0)
//            throw new Exception($"Failed to update keys: User {email} not found in {dbName}.axusers");
//    }

//    private async Task CleanupDatabaseAndRoleAsync(string identifier, CancellationToken ct)
//    {
//        try
//        {
//            _logger.LogWarning("Cleaning up database and role for {Id} due to failure.", identifier);
//            await using var conn = new NpgsqlConnection(_settings.BuildConnectionString(_settings.AdminDatabase));
//            await conn.OpenAsync(ct);

//            // 1. Terminate connections to the new DB so it can be dropped
//            await using (var cmd = conn.CreateCommand())
//            {
//                cmd.CommandText = "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = @n";
//                cmd.Parameters.AddWithValue("n", identifier);
//                await cmd.ExecuteNonQueryAsync(ct);
//            }

//            // 2. Drop Database
//            await using (var cmd = conn.CreateCommand())
//            {
//                cmd.CommandText = $"DROP DATABASE IF EXISTS \"{identifier}\"";
//                await cmd.ExecuteNonQueryAsync(ct);
//            }

//            // 3. Drop Role (Postgres roles are global)
//            await using (var cmd = conn.CreateCommand())
//            {
//                cmd.CommandText = $"DROP ROLE IF EXISTS \"{identifier}\"";
//                await cmd.ExecuteNonQueryAsync(ct);
//            }
//        }
//        catch (Exception ex)
//        {
//            _logger.LogCritical(ex, "CRITICAL: Manual cleanup required for {Id}. Cleanup attempt failed.", identifier);
//        }
//    }

//    // ── Helpers ───────────────────────────────────────────────────────────────

//    /// <summary>Strips any character that is not [a-z0-9_] to prevent injection.</summary>
//    private static string Sanitise(string input) =>
//        new string(input.ToLower().Where(c => char.IsAsciiLetterOrDigit(c) || c == '_').ToArray());
//}
