namespace AxiConsumer.Configuration;

public sealed class AppConnectionSettings
{
    public string AxpertWebScriptsPath { get; init; } = string.Empty;
    public string ARMWebScriptsPath { get; init; } = string.Empty;
    public string ARMPath { get; init; } = string.Empty;
    public string BackupFolderName { get; init; } = string.Empty;
    public string AppLoginUrl { get; init; } = string.Empty;
    public string SupportUrl { get; init; } = string.Empty; 
}
