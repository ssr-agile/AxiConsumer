using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AxiConsumer.Configuration;

public sealed class RedisSettings
{
    public string Host { get; init; } = string.Empty;
    public string Port { get; init; } = string.Empty;
    public string Pwd { get; init; } = string.Empty;
    public string RedisPrefix { get; init; } = "axi:session:";
    public int IdleTimeoutMinutes { get; init; } = 0;
    public int AbsoluteTimeoutMinutes { get; init; } = 5;
    public string GetConnectionString =>
    string.IsNullOrWhiteSpace(Pwd)
        ? $"{Host}:{Port}"
        : $"{Host}:{Port},password={Pwd}";
}
