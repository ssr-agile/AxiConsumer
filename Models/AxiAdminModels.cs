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

    [JsonPropertyName("email")]
    public string Email { get; init; } = string.Empty;

    [JsonPropertyName("orgname")]
    public string OrgName { get; init; } = string.Empty;

    [JsonPropertyName("axiaccid")]
    public string AxiAccId { get; init; } = string.Empty;
    [JsonPropertyName("nickname")]
    public string NickName { get; init; } = string.Empty;

    [JsonPropertyName("contactpersonname")]
    public string ContactPersonName { get; init; } = string.Empty;

    [JsonPropertyName("mobileno")]
    public string MobileNo { get; init; } = string.Empty;

    [JsonPropertyName("taxno")]
    public string TaxNo { get; init; } = string.Empty;

    [JsonPropertyName("state")]
    public string State { get; init; } = string.Empty;

    [JsonPropertyName("country")]
    public string Country { get; init; } = string.Empty;

    [JsonPropertyName("address")]
    public string Address { get; init; } = string.Empty;

    [JsonPropertyName("countrycode")]
    public string CountryCode { get; init; } = string.Empty;

    [JsonPropertyName("region")]
    public string Region { get; init; } = string.Empty;

    [JsonPropertyName("isverified")]
    public string IsVerified { get; init; } = string.Empty;

    [JsonPropertyName("authprovider")]
    public string AuthProvider { get; init; } = string.Empty;

    [JsonPropertyName("ssoid")]
    public string SsoId { get; init; } = string.Empty;

    [JsonPropertyName("schemaname")]
    public string SchemaName { get; init; } = string.Empty;

    [JsonPropertyName("databasename")]
    public string DatabaseName { get; init; } = string.Empty;

    [JsonPropertyName("axirediskey")]
    public string AxiRedisKey { get; init; } = string.Empty;
}
