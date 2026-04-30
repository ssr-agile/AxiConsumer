namespace AxiConsumer.Configuration;

public sealed class DatabaseSettings
{
    public string Host { get; init; } = "localhost";
    public int Port { get; init; } = 5432;
    public string Username { get; init; } = "postgres";
    public string Password { get; init; } = string.Empty;
    public string AdminDatabase { get; init; } = "postgres";
    public string SharedDatabase { get; init; } = "axidb";
    public string MigrationsPath { get; init; } = "Migrations";
    public string AxiControlSchemaName { get; init; } = "axiadmin";
    public string DefaultRolePassword { get; init; } = "log";
    public string LicenseApiUrl { get; init; } = string.Empty;
    public string AppDomain { get; init; } = string.Empty;
    public string BuildConnectionString(string database) =>
        $"Host={Host};Port={Port};Username={Username};Password={Password};Database={database};Pooling=true;";
}
