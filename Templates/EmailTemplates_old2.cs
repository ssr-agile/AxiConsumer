//using System.Net;
//using System.Text;

//namespace RmqConsumerService.Templates;

//public static class EmailTemplates
//{
//    private static bool ShowSocialLogin = true;

//    public static string Success(string email, string orgName, string axiaAcId, string loginUrl)
//        => Wrap("#4f46e5", "Welcome to AXI",
//            $"""
//            <p style="font-size:20px;font-weight:600;margin-bottom:10px;">
//                Welcome to AXI, {Enc(orgName)} 👋
//            </p>

//            <p>
//                Your application environment is ready. Start building and scaling your apps with AXI.
//            </p>

//            {PrimaryButton("🚀 Launch Your App", loginUrl)}

//            {InfoCard("#4f46e5", new[]
//            {
//                ("Account Email", email),
//                ("Organisation", orgName),
//                ("Account ID", axiaAcId),
//                ("Environment", "Production Ready"),
//                ("Status", "Active"),
//            })}

//            {SocialSection()}

//            <p style="margin-top:20px;">Need help? Our support team is always available.</p>
//            <p>— Team AXI</p>
//            """);

//    public static string Failure(string email, string orgName, string axiaAcId, string reason, string supportUrl)
//        => Wrap("#ef4444", "Action Required",
//            $"""
//            <p style="font-size:20px;font-weight:600;">Hi {Enc(orgName)},</p>

//            <p>
//                We encountered an issue while setting up your environment.
//                Our team is already working on it.
//            </p>

//            {InfoCard("#ef4444", new[]
//            {
//                ("Account Email", email),
//                ("Organisation", orgName),
//                ("Account ID", axiaAcId),
//                ("Status", "Setup Failed"),
//                ("Issue", reason),
//            })}

//            {PrimaryButton("Contact Support", supportUrl)}

//            <p style="margin-top:20px;">We’ll resolve this as quickly as possible.</p>
//            <p>— AXI Support</p>
//            """);


//    private static string PrimaryButton(string text, string url) => $"""
//        <table cellpadding="0" cellspacing="0" style="margin:24px 0;">
//            <tr>
//                <td align="center" bgcolor="#4f46e5" style="border-radius:8px;">
//                    <a href="{Enc(url)}"
//                       style="display:inline-block;padding:14px 26px;
//                              color:#ffffff;text-decoration:none;font-weight:600;
//                              font-size:14px;">
//                        {Enc(text)}
//                    </a>
//                </td>
//            </tr>
//        </table>
//    """;

//    private static string InfoCard(string color, (string Label, string Value)[] rows)
//    {
//        var sb = new StringBuilder();

//        foreach (var r in rows)
//        {
//            sb.Append($"""
//            <tr>
//                <td style="padding:10px;color:#6b7280;font-size:13px;">{Enc(r.Label)}</td>
//                <td style="padding:10px;font-weight:600;font-size:13px;">{Enc(r.Value)}</td>
//            </tr>
//            """);
//        }

//        return $"""
//        <table width="100%" style="border-left:4px solid {color};
//               background:#f9fafb;margin:20px 0;border-collapse:collapse;border-radius:8px;">
//            {sb}
//        </table>
//        """;
//    }

//    private static string SocialSection()
//    {
//        if (!ShowSocialLogin) return "";

//        return """
//        <div style="margin-top:25px;">
//            <p style="font-size:13px;color:#6b7280;">Or continue with</p>
//            <div>
//                <a href="#" style="margin-right:10px;text-decoration:none;">🔵 Google</a>
//                <a href="#" style="margin-right:10px;text-decoration:none;">⚫ GitHub</a>
//                <a href="#" style="text-decoration:none;">🔷 Microsoft</a>
//            </div>
//        </div>
//        """;
//    }

//    private static string Wrap(string color, string title, string body) => $"""
//    <!DOCTYPE html>
//    <html>
//    <body style="margin:0;background:#f3f4f6;font-family:'Segoe UI',Arial;">

//    <table width="100%" cellpadding="0" cellspacing="0">
//    <tr><td align="center" style="padding:40px 15px;">

//    <table width="600" style="background:#ffffff;border-radius:14px;
//           overflow:hidden;box-shadow:0 8px 30px rgba(0,0,0,0.08);">

//    <!-- HEADER -->
//    <tr>
//        <td style="background:linear-gradient(135deg,{color},{Darken(color)});
//                   padding:30px;text-align:center;color:white;">
            
//            <!-- AXI LOGO -->
//            <div style="font-size:26px;font-weight:700;letter-spacing:1px;">
//                AXI
//            </div>

//            <p style="margin:5px 0 0;font-size:14px;opacity:0.9;">
//                Cloud Application Platform
//            </p>

//            <h2 style="margin-top:15px;">{title}</h2>
//        </td>
//    </tr>

//    <!-- BODY -->
//    <tr>
//        <td style="padding:32px;color:#374151;font-size:15px;line-height:1.7;">
//            {body}
//        </td>
//    </tr>

//    <!-- FOOTER -->
//    <tr>
//        <td style="padding:20px;text-align:center;background:#f9fafb;
//                   font-size:12px;color:#9ca3af;">
            
//            <p style="margin:0;">
//                This is an automated message from <strong>AXI Platform</strong>.
//                Please do not reply.
//            </p>

//            <p style="margin:6px 0 0;">
//                © AXI • All rights reserved
//            </p>

//            <p style="margin:6px 0 0;font-size:11px;color:#d1d5db;">
//                {DateTime.UtcNow:yyyy-MM-dd HH:mm:ss} UTC
//            </p>

//        </td>
//    </tr>

//    </table>

//    </td></tr>
//    </table>

//    </body>
//    </html>
//    """;


//    private static string Enc(string s) => WebUtility.HtmlEncode(s);

//    private static string Darken(string hex) => hex switch
//    {
//        "#4f46e5" => "#4338ca",
//        "#ef4444" => "#dc2626",
//        _ => hex
//    };
//}