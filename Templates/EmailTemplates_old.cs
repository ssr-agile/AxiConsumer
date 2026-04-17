//using System.Net;

//namespace RmqConsumerService.Templates;

///// <summary>
///// Self-contained HTML email templates.
///// All user-supplied strings are HTML-encoded before injection.
///// </summary>
//public static class EmailTemplates
//{
//    public static string Success(string email, string orgName, string axiaAcId) =>
//        Wrap(
//            headerColor: "#10b981",
//            headerIcon:  "✅",
//            headerTitle: "Provisioning Complete",
//            body: $"""
//                <p>Hello <strong>{Enc(orgName)}</strong>,</p>
//                <p>Your AXI environment has been provisioned and is ready to use.</p>
//                {InfoCard("#10b981", new[]
//                {
//                    ("Email",           email),
//                    ("Password",        "Agile"),
//                    ("Organisation",    orgName),
//                    ("AXI Account ID",  axiaAcId),
//                    ("Database",        axiaAcId),
//                    ("Schema",          axiaAcId),
//                    ("Status",          "✅ Active"),
//                })}
//                <p style="margin-top:20px;">You can now sign in using your credentials. If you have any questions, please contact support.</p>
//            """);

//    public static string Failure(string email, string orgName, string axiaAcId, string reason) =>
//        Wrap(
//            headerColor: "#ef4444",
//            headerIcon:  "❌",
//            headerTitle: "Provisioning Failed",
//            body: $"""
//                <p>Hello <strong>{Enc(orgName)}</strong>,</p>
//                <p>We encountered an issue while provisioning your AXI environment.</p>
//                {InfoCard("#ef4444", new[]
//                {
//                    ("Email",           email),
//                    ("Organisation",    orgName),
//                    ("AXI Account ID",  axiaAcId),
//                    ("Status",          "❌ Failed"),
//                    ("Error",           reason),
//                })}
//                <p style="margin-top:20px;">Our team has been notified. Please contact support and quote your Account ID for faster resolution.</p>
//            """);

//    // ── Shared layout helpers ─────────────────────────────────────────────────

//    private static string InfoCard(string accentColor, (string Label, string Value)[] rows)
//    {
//        var rowsHtml = string.Concat(rows.Select(r => $"""
//            <tr>
//                <td style="padding:8px 12px;color:#6b7280;font-size:13px;border-bottom:1px solid #e5e7eb;">{Enc(r.Label)}</td>
//                <td style="padding:8px 12px;font-weight:600;color:#111827;font-size:13px;border-bottom:1px solid #e5e7eb;">{Enc(r.Value)}</td>
//            </tr>
//        """));

//        return $"""
//            <table width="100%" cellpadding="0" cellspacing="0"
//                   style="border-left:4px solid {accentColor};border-radius:8px;background:#f8fafc;margin:24px 0;border-collapse:collapse;">
//                <tbody>{rowsHtml}</tbody>
//            </table>
//        """;
//    }

//    private static string Wrap(string headerColor, string headerIcon, string headerTitle, string body) => $"""
//        <!DOCTYPE html>
//        <html lang="en">
//        <head>
//          <meta charset="UTF-8"/>
//          <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
//        </head>
//        <body style="margin:0;padding:0;background:#f0f2f5;font-family:'Segoe UI',Arial,sans-serif;">
//          <table width="100%" cellpadding="0" cellspacing="0">
//            <tr><td align="center" style="padding:40px 16px;">
//              <table width="600" cellpadding="0" cellspacing="0"
//                     style="background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,.08);">

//                <!-- Header -->
//                <tr>
//                  <td align="center"
//                      style="background:linear-gradient(135deg,{headerColor},{Darken(headerColor)});padding:36px 40px;">
//                    <div style="font-size:36px;">{headerIcon}</div>
//                    <h1 style="margin:12px 0 0;color:#fff;font-size:20px;font-weight:700;letter-spacing:-.3px;">{headerTitle}</h1>
//                  </td>
//                </tr>

//                <!-- Body -->
//                <tr>
//                  <td style="padding:32px 40px;color:#374151;line-height:1.7;font-size:15px;">
//                    {body}
//                  </td>
//                </tr>

//                <!-- Footer -->
//                <tr>
//                  <td style="padding:20px 40px;background:#f8fafc;text-align:center;">
//                    <p style="margin:0;color:#9ca3af;font-size:12px;">
//                      This is an automated message from <strong>AXI System</strong>. Please do not reply.
//                    </p>
//                    <p style="margin:6px 0 0;color:#d1d5db;font-size:11px;">
//                      {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC
//                    </p>
//                  </td>
//                </tr>

//              </table>
//            </td></tr>
//          </table>
//        </body>
//        </html>
//        """;

//    private static string Enc(string s) => WebUtility.HtmlEncode(s);

//    /// <summary>Simple darkening – returns a slightly darker hex for the gradient.</summary>
//    private static string Darken(string hex)
//    {
//        // Predefined pairs to keep it simple and dependency-free
//        return hex switch
//        {
//            "#10b981" => "#059669",
//            "#ef4444" => "#dc2626",
//            _         => hex
//        };
//    }
//}
