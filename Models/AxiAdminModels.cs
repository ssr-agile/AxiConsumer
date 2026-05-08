using System.Text.Json.Serialization;

namespace AxiConsumer.Models;

/// <summary>
/// Wrapper that matches the outer "axiadmin" key in queuedata JSON.
/// </summary>
public sealed class AxiAdminPayload
{
    [JsonPropertyName("axiadmin")]
    public AxiAdminData? AxiAdmin { get; init; }
}

public sealed class AxiAdminData
{
    [JsonPropertyName("username")]
    public string Username { get; init; } = string.Empty;

    [JsonPropertyName("emailid")]
    public string Email { get; init; } = string.Empty;

    [JsonPropertyName("orgname")]
    public string OrgName { get; init; } = string.Empty;

    [JsonPropertyName("axiaccid")]
    public string AxiAcId { get; init; } = string.Empty;
}
