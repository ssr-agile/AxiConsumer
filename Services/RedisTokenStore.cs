using AxiConsumer.Configuration;
using AxiConsumer.Models;
using AxiConsumer.Services.Interfaces;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Options;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text.Json;

namespace AxiConsumer.Services;

/// <summary>
/// Redis-backed token store.
///
///   GetAsync  → read sessionId from request cookie
///             → lookup JWT in Redis (returns null if missing or expired)
/// </summary>
public sealed class RedisTokenStore(
    IDistributedCache redis,
    IOptions<RedisSettings> redisOpts,
    ILogger<RedisTokenStore> logger) : ITokenStore
{
    private static readonly JsonSerializerOptions _json =
        new() { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };

    private readonly TimeSpan _ttl =
        TimeSpan.FromMinutes(redisOpts.Value.AbsoluteTimeoutMinutes);

    // ── Write ─────────────────────────────────────────────────────────────────
    //public async Task SetAsync(string token, CancellationToken ct = default)
    //{
    //    if (string.IsNullOrWhiteSpace(token))
    //        throw new ArgumentException("Token must not be empty.", nameof(token));

    //    var sessionId = GenerateSessionId();
    //    var redisKey = redisOpts.Value.RedisPrefix + sessionId;

    //    // Store JWT in Redis with sliding expiry
    //    await redis.SetStringAsync(redisKey, token, new DistributedCacheEntryOptions
    //    {
    //        SlidingExpiration = _ttl
    //    }, ct);

    //    // Set sessionId in HttpOnly cookie – JS cannot read this
    //    Ctx.Response.Cookies.Append(sessionOpts.Value.CookieName, sessionId, new CookieOptions
    //    {
    //        HttpOnly = true,
    //        Secure = true,
    //        SameSite = SameSiteMode.Strict,
    //        MaxAge = _ttl,
    //        Path = "/"
    //    });

    //    logger.LogInformation("Session created. TTL={TTL}min", _ttl.TotalMinutes);
    //}

    // ── Read ──────────────────────────────────────────────────────────────────
    public async Task<SessionData?> GetAsync(string sessionId, CancellationToken ct = default)
    {
        var raw = await redis.GetStringAsync(redisOpts.Value.RedisPrefix + sessionId, ct);

        if (raw is null)
        {
            logger.LogWarning("Session {Prefix}*** not found in Redis.",
                sessionId[..Math.Min(8, sessionId.Length)]);
            return null;
        }

        return JsonSerializer.Deserialize<SessionData>(raw, _json);
    }

    // ── Patch (add/edit fields without replacing the whole object) ────────────
    public async Task<bool> UpdateAsync(Action<SessionData> mutate, string sessionId, CancellationToken ct = default)
    {
        //if (!Ctx.Request.Cookies.TryGetValue(sessionOpts.Value.CookieName, out var sessionId)
        //    || string.IsNullOrWhiteSpace(sessionId))
        //    return false;

        var redisKey = redisOpts.Value.RedisPrefix + sessionId;
        var raw = await redis.GetStringAsync(redisKey, ct);
        if (raw is null) return false;

        var session = JsonSerializer.Deserialize<SessionData>(raw, _json)!;
        mutate(session);                                        // caller mutates in place

        await redis.SetStringAsync(redisKey,
            JsonSerializer.Serialize(session, _json), ct);

        return true;
    }

    // ── Delete ────────────────────────────────────────────────────────────────
    //public async Task ClearAsync(CancellationToken ct = default)
    //{
    //    if (Ctx.Request.Cookies.TryGetValue(sessionOpts.Value.CookieName, out var sessionId)
    //        && !string.IsNullOrWhiteSpace(sessionId))
    //    {
    //        await redis.RemoveAsync(redisOpts.Value.RedisPrefix + sessionId, ct);
    //        logger.LogInformation("Session removed from Redis.");
    //    }

    //    // Expire the cookie immediately on the client
    //    Ctx.Response.Cookies.Append(sessionOpts.Value.CookieName, string.Empty, new CookieOptions
    //    {
    //        HttpOnly = true,
    //        Secure = true,
    //        SameSite = SameSiteMode.Strict,
    //        MaxAge = TimeSpan.Zero,
    //        Path = "/"
    //    });
    //}

    /// <summary>Reads request cookie; throws 401 if none exists (SECURE endpoints).</summary>
    //public string GetSessionIdAsync(CancellationToken ct = default)
    //{
    //    if (!Ctx.Request.Cookies.TryGetValue(sessionOpts.Value.CookieName, out var sessionId)
    //|| string.IsNullOrWhiteSpace(sessionId))
    //    {
    //        logger.LogDebug("No session cookie present.");
    //        throw new UnauthorizedAccessException("No active session. Unauthorized error.");
    //    }
    //    return sessionId;
    //}

    //public async Task<bool> HasTokenAsync(CancellationToken ct = default) =>
    //    !string.IsNullOrWhiteSpace(await GetAsync(ct));
}
