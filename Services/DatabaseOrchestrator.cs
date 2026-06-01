using Microsoft.Extensions.Options;
using Npgsql;
using Polly;
using AxiConsumer.Configuration;
using AxiConsumer.Services.Interfaces;
using AxiConsumer.Models;

namespace AxiConsumer.Services;

public sealed class DatabaseOrchestrator : IDatabaseOrchestrator
{
    private readonly IAdminDbService _admin;
    private readonly ITenantProvisionService _tenant;
    //private readonly ITenantDbService _tenant;
    private readonly DatabaseSettings _settings;
    private readonly ILogger<DatabaseOrchestrator> _logger;

    public DatabaseOrchestrator(
        IAdminDbService admin, //ITenantDbService tenant,
        ITenantProvisionService tenent,
        IOptions<DatabaseSettings> settings,
        ILogger<DatabaseOrchestrator> logger)
    {
        _admin = admin;
        _tenant = tenent;
        _settings = settings.Value;
        _logger = logger;
        //_provisioning = provision;
    }

    public async Task<bool> ProvisionTenantAsync(AxiAdminData data, string hashedPassword, CancellationToken ct)
    {
        var id = Sanitise(data.AxiAccId);

        try
        {
            // 1. Role (admin DB) — retried on transient failures
            var retry = Policy
                .Handle<NpgsqlException>(ex => ex.IsTransient)
                .Or<TimeoutException>()
                .WaitAndRetryAsync(3, i => TimeSpan.FromSeconds(Math.Pow(2, i)));

            //await retry.ExecuteAsync(async () =>
            //    await _admin.EnsureRoleAsync(id, _settings.DefaultRolePassword, ct));

            // 2. Schema + all migration scripts (shared DB)
            await _tenant.ProvisionSchemaAsync(id, _settings.DefaultRolePassword, ct);

            // 3. Add account & user into the control schema
            await _tenant.AddAccountAsync(data, ct);

            // 4. Seed initial user into the new schema
            await _tenant.SeedUserAsync(id, data.Email, data.Username, data.NickName, hashedPassword, ct);

            // 5. External license activation
            var lic = await _tenant.ActivateAsync(id, data.Email, ct);

            // 6. Write license keys into tenant schema
            await _tenant.UpdateUserKeysAsync(id, data.Email, lic.AuthKey!, lic.UserKey!, ct);

            _logger.LogInformation("Provisioning complete for '{Id}'.", id);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Provisioning failed for '{Id}' — rolling back.", id);

            // Cleanup order matters: schema first, then role
            await _tenant.CleanupSchemaAsync(id, ct);
            await _admin.CleanupAsync(id, ct);
            throw;
        }
    }

    private static string Sanitise(string input) =>
        new string(input.ToLower().Where(c => char.IsAsciiLetterOrDigit(c) || c == '_').ToArray());
}
