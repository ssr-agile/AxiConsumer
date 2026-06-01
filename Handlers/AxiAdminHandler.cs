using AxiConsumer.Configuration;
using AxiConsumer.Models;
using AxiConsumer.Services;
using AxiConsumer.Services.Interfaces;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Runtime;
using System.Text.Json;

namespace AxiConsumer.Handlers;

/// <summary>
/// Handles messages where ApiName == "axiadmin".
/// Provisions a PostgreSQL database+schema and notifies the user by email.
/// </summary>
public sealed class AxiAdminHandler : IQueueHandler
{
    public string ApiName => "axiadmin";

    private static readonly JsonSerializerOptions JsonOpts = new() { PropertyNameCaseInsensitive = true };

    private readonly IDatabaseOrchestrator _db;
    private readonly IEmailService _email;
    private readonly ILogger<AxiAdminHandler> _logger;
    private readonly DatabaseSettings _settings;
    private readonly IConfigurationFileService _configFiles;
    private readonly ITokenStore _tokenStore;
    private readonly IPasswordService _pwd;


    public AxiAdminHandler(IDatabaseOrchestrator db, IEmailService email, ILogger<AxiAdminHandler> logger, IOptions<DatabaseSettings> settings, IConfigurationFileService configFiles, ITokenStore tokenStore, IPasswordService pwd)
    {
        _db = db;
        _email = email;
        _logger = logger;
        _settings = settings.Value;
        _configFiles = configFiles;
        _tokenStore = tokenStore;
        _pwd = pwd;
    }

    public async Task HandleAsync(QueueMessage message, CancellationToken cancellationToken)
    {
        _logger.LogDebug("AxiAdminHandler: deserializing queuedata");

        var payload = JsonSerializer.Deserialize<AxiAdminPayload>(message.QueueData, JsonOpts);

        if (payload?.AxiAdmin is not { } data)
        {
            _logger.LogError("AxiAdminHandler: invalid payload structure – 'axiadmin' key missing or null");
            throw new InvalidOperationException("Missing 'axiadmin' object in queuedata.");
        }

        if (string.IsNullOrEmpty(data?.AxiRedisKey))
        {
            _logger.LogError("AxiAdminHandler: invalid payload structure – 'axirediskey' key missing or null");
            throw new InvalidOperationException("Missing 'axirediskey' object in queuedata.");
        }

        _logger.LogInformation(
            "AxiAdmin payload parsed – OrgName={OrgName} AxiAccId={AxiAccId} Email={Email} Username={Username} RedisKey={AxiRedisKey}",
            data.OrgName, data.AxiAccId, data.Email, data.Username, data.AxiRedisKey);

        bool success;
        string? failureReason = null;
        string password = "";

        try
        {
            //_logger.LogInformation("Step 1/2 – Provisioning database for AxiAccId={AxiAccId}", data.AxiAccId);
            //_logger.LogInformation("Step 1/3 – Cloning template '{Template}' → database '{Db}'", _settings.TemplateDatabaseName, data.AxiAccId);
            _logger.LogInformation("Step 1/3 – Cloning schema '{schema}'", data.AxiAccId);
            //success = await _db.CreateDatabaseAndSchemaAsync(data.AxiAccId, data.Email, cancellationToken);
            password = _pwd.GenerateRandomPassword(10);
            var hashedPassword = _pwd.HashPassword(password);
            success = await _db.ProvisionTenantAsync(data, hashedPassword, cancellationToken);

            if (!success)
                throw new InvalidOperationException("Tenent provision returned false without throwing.");

            //_logger.LogInformation("Step 1/2 – Database provisioned successfully for AxiAccId={AxiAccId}", data.AxiAccId);
            _logger.LogInformation("Step 1/3 – Cloned schema successfully '{schema}'", data.AxiAccId);
        }
        catch (Exception ex)
        {
            success = false;
            failureReason = ex.Message;
            //_logger.LogError(ex, "Step 1/2 – Database provisioning failed for AxiAccId={AxiAccId}", data.AxiAccId);
            _logger.LogInformation("Step 1/3 – schema Cloning failed for '{schema}'", data.AxiAccId);

        }

        try
        {
            if (success)
            {
                _logger.LogInformation("Step 2/3 – Updating configuration files for {AxiAccId}", data.AxiAccId);
                success = await _configFiles.UpdateConfigsAsync(data.AxiAccId, cancellationToken);
                if (!success)
                    throw new InvalidOperationException("Connection configuration returned false without throwing.");

                await _tokenStore.UpdateAsync(s =>
                {
                    s.Email = data.Email;
                    s.AxiAccId = data.AxiAccId;
                    s.IsPrimary = "T";
                    s.UserName = data.Username;
                }, data.AxiRedisKey, cancellationToken);

            }
        }
        catch (Exception ex)
        {
            success = false;
            failureReason = ex.Message;
            _logger.LogError(ex, "Step 2/3 – Failed to update configuration files. Manual intervention required.");
            // Decide if this should fail the whole process or just log a warning
        }

        try
        {
            _logger.LogInformation("Step 3/3 – Sending {Status} email to {Email}", success ? "success" : "failure", data.Email);

            if (success)
                await _email.SendSuccessAsync(data.Email, data.OrgName, data.AxiAccId, data.Username, data.AxiRedisKey, password, cancellationToken);
            else
                await _email.SendFailureAsync(data.Email, data.OrgName, data.AxiAccId, data.Username, failureReason!, cancellationToken);

            _logger.LogInformation("Step 3/3 – Email sent to {Email}", data.Email);
        }
        catch (Exception ex)
        {
            // Email failure must not crash the handler – log and move on
            _logger.LogError(ex, "Step 3/3 – Email sending failed for {Email}", data.Email);
        }

        if (!success)
        {
            await _tokenStore.UpdateAsync(s =>
            {
                s.Error = failureReason;
            }, data.AxiRedisKey, cancellationToken);
            throw new InvalidOperationException($"AxiAdmin cloning failed: {failureReason}");
        }

    }
}
