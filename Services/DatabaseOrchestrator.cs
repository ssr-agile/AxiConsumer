using Microsoft.Extensions.Options;
using Npgsql;
using Polly;
using AxiConsumer.Configuration;
using AxiConsumer.Services.Interfaces;

namespace AxiConsumer.Services;

public sealed class DatabaseOrchestrator : IDatabaseOrchestrator
{
    private readonly IAdminDbService _admin;
    private readonly ITenantProvisionService _tenant;
    //private readonly ITenantDbService _tenant;
    private readonly ILicenseService _license;
    private readonly DatabaseSettings _settings;
    private readonly ILogger<DatabaseOrchestrator> _logger;

    public DatabaseOrchestrator(
        IAdminDbService admin, //ITenantDbService tenant,
        ITenantProvisionService tenent,
        ILicenseService license, IOptions<DatabaseSettings> settings,
        ILogger<DatabaseOrchestrator> logger)
    {
        _admin = admin;
        _tenant = tenent;
        _license = license;
        _settings = settings.Value;
        _logger = logger;
        //_provisioning = provision;
    }

    public async Task<bool> ProvisionTenantAsync(string axiaAcId, string email, CancellationToken ct)
    {
        var id = Sanitise(axiaAcId);

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

            // 3. Seed initial user into the new schema
            await _tenant.SeedUserAsync(id, email, ct);

            // 4. External license activation
            var lic = await _license.ActivateAsync(id, email, ct);

            // 5. Write license keys into tenant schema
            await _tenant.UpdateUserKeysAsync(id, email, lic.AuthKey!, lic.UserKey!, ct);

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
