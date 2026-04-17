using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using MimeKit;
using RmqConsumerService.Configuration;
using RmqConsumerService.Services.Interfaces;
using RmqConsumerService.Templates;

namespace RmqConsumerService.Services;

public sealed class EmailService : IEmailService
{
    private readonly SmtpSettings _emailSettings;
    private readonly AppConnectionSettings _appConnSettings;
    private readonly ILogger<EmailService> _logger;

    public EmailService(IOptions<SmtpSettings> emailSettings, IOptions<AppConnectionSettings> appConnSettings, ILogger<EmailService> logger)
    {
        _emailSettings = emailSettings.Value;
        _appConnSettings = appConnSettings.Value;
        _logger   = logger;
    }

    public Task SendSuccessAsync(string toEmail, string orgName, string axiaAcId, CancellationToken ct) =>
        SendAsync(
            toEmail,
            subject:  $"✅ AXI Provisioning Complete – {orgName}",
            htmlBody: EmailTemplates.Success(toEmail, orgName, axiaAcId, _appConnSettings.AppLoginUrl + axiaAcId),
            ct);

    public Task SendFailureAsync(string toEmail, string orgName, string axiaAcId, string reason, CancellationToken ct) =>
        SendAsync(
            toEmail,
            subject:  $"❌ AXI Provisioning Failed – {orgName}",
            htmlBody: EmailTemplates.Failure(toEmail, orgName, axiaAcId, reason, _appConnSettings.SupportUrl),
            ct);

    // ── Core sender ──────────────────────────────────────────────────────────

    private async Task SendAsync(string toEmail, string subject, string htmlBody, CancellationToken ct)
    {
        _logger.LogInformation("Sending email → {To} | Subject: {Subject}", toEmail, subject);

        var mime = new MimeMessage();
        mime.From.Add(new MailboxAddress(_emailSettings.FromName, _emailSettings.FromEmail));
        mime.To.Add(MailboxAddress.Parse(toEmail));
        mime.Subject = subject;
        mime.Body    = new BodyBuilder { HtmlBody = htmlBody }.ToMessageBody();

        using var smtp = new SmtpClient();
        try
        {
            var socketOptions = _emailSettings.EnableSsl
                ? SecureSocketOptions.StartTls
                : SecureSocketOptions.None;

            await smtp.ConnectAsync(_emailSettings.Host, _emailSettings.Port, socketOptions, ct);
            await smtp.AuthenticateAsync(_emailSettings.Username, _emailSettings.Password, ct);
            await smtp.SendAsync(mime, ct);
            await smtp.DisconnectAsync(quit: true, ct);

            _logger.LogInformation("Email sent to {To}", toEmail);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send email to {To}", toEmail);
            throw;
        }
    }
}
