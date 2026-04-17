using System.Net;
using System.Text;

namespace RmqConsumerService.Templates;

public static class EmailTemplates
{
    public static string Success(string email, string orgName, string axiaAcId, string loginUrl)
        => Wrap("#4f46e5", "#4338ca", "Welcome to AXI 🚀",
            $"""
            <p style="font-size:18px;font-weight:600;margin-bottom:10px;color:#ffffff;">
                Welcome to AXI, {Enc(orgName)}
            </p>

            <p style="color:#d1d5db;font-size:14px;line-height:1.6;">
                Your workspace for <b>{Enc(orgName)}</b> is ready. <br/>
                Start building apps instantly — no setup required.
            </p>

            {PrimaryButton("Access Workspace", loginUrl, "#4f46e5")}

            <p style="font-size:11px;color:#9ca3af;margin-bottom:15px;">
                Secure • Fast • Ready in seconds
            </p>

            {CompactInfoBox(new[]
            {
                ("Email", email),
                ("Account ID", axiaAcId),
                ("Status", "Active"),
            })}
            """);

    public static string Failure(string email, string orgName, string refId, string reason, string retryUrl)
        => Wrap("#ef4444", "#b91c1c", "Something went wrong ⚠️",
            $"""
            <p style="font-size:18px;font-weight:600;margin-bottom:10px;color:#ffffff;">
                Hi {Enc(orgName)},
            </p>

            <p style="color:#d1d5db;font-size:14px;line-height:1.6;">
                We couldn’t complete your request for <b>{Enc(orgName)}</b>.<br/>
                Please try again or contact support if the issue persists.
            </p>

            {PrimaryButton("Retry Action", retryUrl, "#ef4444")}

            {CompactInfoBox(new[]
            {
                ("Error", reason),
                ("Reference ID", refId),
                ("Status", "Failed"),
            }, isError: true)}
            """);

    private static string PrimaryButton(string text, string url, string bgColor) => $"""
        <table cellpadding="0" cellspacing="0" style="margin:20px auto;">
            <tr>
                <td align="center" bgcolor="{bgColor}" style="border-radius:8px;">
                    <a href="{url}"
                       style="display:inline-block;padding:12px 24px;
                              color:#ffffff;text-decoration:none;font-weight:600;
                              font-size:14px;">
                        {Enc(text)}
                    </a>
                </td>
            </tr>
        </table>
    """;

    private static string CompactInfoBox((string Label, string Value)[] rows, bool isError = false)
    {
        var sb = new StringBuilder();
        var textColor = isError ? "#fca5a5" : "#d1d5db";

        foreach (var r in rows)
        {
            sb.Append($"""
                <div style="margin-bottom:4px;">
                    <b style="color:#ffffff;">{Enc(r.Label)}:</b> {Enc(r.Value)}
                </div>
            """);
        }

        return $"""
        <div style="background:#111827;padding:15px;border-radius:8px;
                    text-align:left;font-size:12px;color:{textColor};line-height:1.5;">
            {sb}
        </div>
        """;
    }

    private static string Wrap(string startColor, string endColor, string title, string body) => $"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body style="margin:0;background:#0b1220;font-family:Arial,Helvetica,sans-serif;">

    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td align="center" style="padding:40px 10px;">

            <table width="100%" style="max-width:480px;background:#1f2937;border-radius:12px;
                       overflow:hidden;border-collapse:collapse;color:#ffffff;">

                <tr>
                    <td align="center" style="background:linear-gradient(135deg,{startColor},{endColor});padding:25px;">
                        <div style="font-size:22px;font-weight:700;letter-spacing:1px;margin-bottom:4px;">AXI</div>
                        <div style="font-size:12px;opacity:0.85;">Cloud Application Platform</div>
                    </td>
                </tr>

                <tr>
                    <td style="padding:30px;text-align:center;">
                        <h1 style="font-size:20px;margin:0 0 15px 0;color:#ffffff;">{title}</h1>
                        {body}
                    </td>
                </tr>

                <tr>
                    <td style="padding:20px;text-align:center;border-top:1px solid rgba(255,255,255,0.05);
                               font-size:11px;color:#9ca3af;line-height:1.6;">
                        This is an automated message from <strong>AXI Platform</strong>.<br/>
                        Need help? <a href="#" style="color:#4f46e5;text-decoration:none;">Contact support</a><br/><br/>
                        © AXI • All rights reserved<br/>
                        <span style="font-size:10px;opacity:0.5;">{DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC</span>
                    </td>
                </tr>

            </table>

        </td>
    </tr>
    </table>

    </body>
    </html>
    """;

    private static string Enc(string s) => WebUtility.HtmlEncode(s ?? string.Empty);
}