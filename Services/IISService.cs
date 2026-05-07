using AxiConsumer.Configuration;
using AxiConsumer.Services.Interfaces;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Web.Administration;
using AxiConsumer.Configuration;


namespace AxiConsumer.Services;

public sealed class IISService : IIISService
{
    // Safe pool name: letters, digits, spaces, hyphens, underscores — no shell-injectable chars
    private static readonly System.Text.RegularExpressions.Regex SafePoolName =
        new(@"^[\w\s\-]{1,64}$",
            System.Text.RegularExpressions.RegexOptions.Compiled |
            System.Text.RegularExpressions.RegexOptions.CultureInvariant);

    private readonly AppConnectionSettings _settings;
    private readonly ILogger<IISService> _logger;

    public IISService(IOptions<AppConnectionSettings> settings, ILogger<IISService> logger)
    {
        _settings = settings.Value;
        _logger = logger;
    }

    public async Task IISRecyclePoolsAsync(CancellationToken ct)
    {
        var pools = _settings.IISAppPools;

        if (pools is not { Length: > 0 })
        {
            _logger.LogWarning("IISService: No app pools configured — skipping recycle.");
            return;
        }

        // Validate all pool names before touching IIS
        var invalid = pools.Where(p => !SafePoolName.IsMatch(p)).ToArray();
        if (invalid.Length > 0)
        {
            _logger.LogError("IIS recycle aborted — invalid pool name(s): {Names}. " +
                             "Only letters, digits, spaces, hyphens, underscores allowed.",
                string.Join(", ", invalid));
            return;
        }

        _logger.LogInformation("Recycling {Count} IIS app pool(s): {Pools}",
            pools.Length, string.Join(", ", pools));

        // Recycle all pools in parallel — independent operations, no ordering needed
        var tasks = pools.Select(p => RecycleOneAsync(p, ct)).ToArray();
        await Task.WhenAll(tasks);

        _logger.LogInformation("IIS pool recycle sweep complete.");
    }

    // ── Per-pool ──────────────────────────────────────────────────────────────

    private async Task RecycleOneAsync(string poolName, CancellationToken ct)
    {
        // ServerManager opens the IIS config store — requires admin privilege
        // Wrap synchronous IIS API in Task.Run so it doesn't block the async pipeline
        await Task.Run(() =>
        {
            try
            {
                using var iis = new ServerManager();

                var pool = iis.ApplicationPools[poolName];

                if (pool is null)
                {
                    _logger.LogWarning("IIS pool '{Pool}' not found — skipping.", poolName);
                    return;
                }

                var state = pool.State;

                if (state == ObjectState.Stopped || state == ObjectState.Stopping)
                {
                    _logger.LogWarning("IIS pool '{Pool}' is {State} — skipping recycle.", poolName, state);
                    return;
                }

                _logger.LogInformation("Recycling IIS pool '{Pool}' (current state: {State}).", poolName, state);

                pool.Recycle();

                _logger.LogInformation("IIS pool '{Pool}' recycled successfully.", poolName);
            }
            catch (UnauthorizedAccessException ex)
            {
                // Clear actionable message — admin privilege is the most likely cause
                _logger.LogError(ex,
                    "IIS pool '{Pool}' recycle denied — service must run as administrator or Local System.", poolName);
            }
            catch (Exception ex)
            {
                // Per-pool failure is logged but never re-thrown
                // One bad pool must not block the others or the ack
                _logger.LogError(ex, "IIS pool '{Pool}' recycle failed.", poolName);
            }
        }, ct);
    }
}
