namespace AxiConsumer.Configuration;

public sealed class LogSettings
{
    public bool EnableDebug { get; init; } = false;
    public string LogDirectory { get; init; } = "Logs";
    public string LogFilePrefix { get; init; } = "rmq-consumer";
    public string RollingInterval { get; init; } = "Day";
    public int RetainedFileCount { get; init; } = 30;
    public int FileSizeLimitMB { get; init; } = 10;
}
