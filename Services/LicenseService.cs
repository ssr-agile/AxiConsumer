using Microsoft.Extensions.Options;
using AxiConsumer.Configuration;
using AxiConsumer.Models;
using AxiConsumer.Services.Interfaces;
using System.Net.Http.Json;

namespace AxiConsumer.Services;

public sealed class LicenseService : ILicenseService
{
    private readonly IHttpClientFactory _factory;
    private readonly DatabaseSettings _settings;
    private readonly ILogger<LicenseService> _logger;

    public LicenseService(IHttpClientFactory factory, IOptions<DatabaseSettings> settings, ILogger<LicenseService> logger)
    {
        _factory = factory;
        _settings = settings.Value;
        _logger = logger;
    }

    public async Task<LicenseResponse> ActivateAsync(string dbName, string email, CancellationToken ct)
    {
        var client = _factory.CreateClient("LicenseClient");
        var payload = new LicenseRequest { UserName = email, SchemaName = dbName, AppDomain = _settings.AppDomain };

        _logger.LogInformation("Activating license for '{Db}' / '{Email}'.", dbName, email);

        var response = await client.PostAsJsonAsync(_settings.LicenseApiUrl, payload, ct);
        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<LicenseResponse>(cancellationToken: ct);

        if (result is null || string.IsNullOrEmpty(result.AuthKey) || string.IsNullOrEmpty(result.UserKey))
            throw new InvalidOperationException($"License activation failed: {result?.Message ?? "empty response"}");

        return result;
    }
}
