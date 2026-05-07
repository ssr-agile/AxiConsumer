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

    //private readonly IDatabaseService _db;
    private readonly IDatabaseOrchestrator _db;
    private readonly IEmailService _email;
    private readonly ILogger<AxiAdminHandler> _logger;
    private readonly DatabaseSettings _settings;
    private readonly IConfigurationFileService _configFiles;
    private readonly IIISService _iis;


    public AxiAdminHandler(IDatabaseOrchestrator db, IEmailService email, ILogger<AxiAdminHandler> logger, IOptions<DatabaseSettings> settings, IConfigurationFileService configFiles, IIISService iis)
    {
        _db    = db;
        _email = email;
        _logger = logger;
        _settings = settings.Value;
        _configFiles = configFiles;
        _iis = iis;
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

        _logger.LogInformation(
            "AxiAdmin payload parsed – OrgName={OrgName} AxiAcId={AxiAcId} Email={Email}",
            data.OrgName, data.AxiAcId, data.Email);

        bool success;
        string? failureReason = null;

        try
        {
            //_logger.LogInformation("Step 1/2 – Provisioning database for AxiAcId={AxiAcId}", data.AxiAcId);
            //_logger.LogInformation("Step 1/3 – Cloning template '{Template}' → database '{Db}'", _settings.TemplateDatabaseName, data.AxiAcId);
            _logger.LogInformation("Step 1/4 – Cloning schema '{schema}'", data.AxiAcId);
            //success = await _db.CreateDatabaseAndSchemaAsync(data.AxiAcId, data.Email, cancellationToken);
            success = await _db.ProvisionTenantAsync(data.AxiAcId, data.Email, cancellationToken);

            if (!success)
                throw new InvalidOperationException("Tenent provision returned false without throwing.");

            //_logger.LogInformation("Step 1/2 – Database provisioned successfully for AxiAcId={AxiAcId}", data.AxiAcId);
            _logger.LogInformation("Step 1/4 – Cloned schema successfully '{schema}'", data.AxiAcId);
        }
        catch (Exception ex)
        {
            success = false;
            failureReason = ex.Message;
            //_logger.LogError(ex, "Step 1/2 – Database provisioning failed for AxiAcId={AxiAcId}", data.AxiAcId);
            _logger.LogInformation("Step 1/4 – schema Cloning failed for '{schema}'", data.AxiAcId);

        }

        try
        {
            if (success)
            {
                _logger.LogInformation("Step 2/4 – Updating configuration files for {AxiAcId}", data.AxiAcId);
                success = await _configFiles.UpdateConfigsAsync(data.AxiAcId, cancellationToken);
                if (!success)
                    throw new InvalidOperationException("Connection configuration returned false without throwing.");

            }
        }
        catch (Exception ex)
        {
            success = false;
            failureReason = ex.Message;
            _logger.LogError(ex, "Step 2/4 – Failed to update configuration files. Manual intervention required.");
            // Decide if this should fail the whole process or just log a warning
        }

        if (success)
        {
            _logger.LogInformation("Step 3/4 – Recycling IIS application pools.");
            await _iis.IISRecyclePoolsAsync(cancellationToken);
        }

        // Step 2 always runs – user must know either way
        try
        {
            _logger.LogInformation("Step 4/4 – Sending {Status} email to {Email}", success ? "success" : "failure", data.Email);

            if (success)
                await _email.SendSuccessAsync(data.Email, data.OrgName, data.AxiAcId, cancellationToken);
            else
                await _email.SendFailureAsync(data.Email, data.OrgName, data.AxiAcId, failureReason!, cancellationToken);

            _logger.LogInformation("Step 4/4 – Email sent to {Email}", data.Email);
        }
        catch (Exception ex)
        {
            // Email failure must not crash the handler – log and move on
            _logger.LogError(ex, "Step 4/4 – Email sending failed for {Email}", data.Email);
        }

        if (!success)
            throw new InvalidOperationException($"AxiAdmin cloning failed: {failureReason}");
    }
}
