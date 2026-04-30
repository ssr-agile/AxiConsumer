using Microsoft.Extensions.Options;
using Npgsql;
using AxiConsumer.Configuration;
using AxiConsumer.Services.Interfaces;

namespace AxiConsumer.Services;

public sealed class TenantDbService : ITenantDbService
{
    private readonly DatabaseSettings _settings;
    private readonly ILogger<TenantDbService> _logger;
    private readonly NpgsqlDataSource _sharedDs;

    public TenantDbService(
        [FromKeyedServices("shared")] NpgsqlDataSource sharedDs,
        IOptions<DatabaseSettings> settings,
        ILogger<TenantDbService> logger)
    {
        _sharedDs = sharedDs;
        _settings = settings.Value;
        _logger = logger;
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
        await conn.OpenAsync(ct);

        await using var cmd = new NpgsqlCommand(
            $"UPDATE \"{dbName}\".axusers SET authkey = @ak, userkey = @uk WHERE email = @u", conn);
        cmd.Parameters.AddWithValue("ak", authKey);
        cmd.Parameters.AddWithValue("uk", userKey);
        cmd.Parameters.AddWithValue("u", email);

        var affected = await cmd.ExecuteNonQueryAsync(ct);
        if (affected == 0)
            throw new InvalidOperationException($"User '{email}' not found in {dbName}.axusers — keys not updated.");
    }

}
