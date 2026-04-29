using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting.WindowsServices;
using Npgsql;
using RmqConsumerService;
using RmqConsumerService.Configuration;
using RmqConsumerService.Handlers;
using RmqConsumerService.Services;
using RmqConsumerService.Services.Interfaces;
using Serilog;
using Serilog.Events;
using System.Net.Http;


// ── Bootstrap configuration (needed before Host is built) ────────────────────
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("axiglobalconfig.json", optional: false, reloadOnChange: true)
    .AddEnvironmentVariables()           // env vars override appsettings (12-factor)
    .Build();

var logCfg = configuration.GetSection("Logging").Get<LogSettings>() ?? new LogSettings();

// ── Configure Serilog ─────────────────────────────────────────────────────────
// Sinks are structured so adding Wazuh/Graylog later is a one-liner.
Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Is(logCfg.EnableDebug ? LogEventLevel.Debug : LogEventLevel.Information)
    .MinimumLevel.Override("Microsoft", LogEventLevel.Warning)
    .MinimumLevel.Override("RabbitMQ",  LogEventLevel.Warning)
    .Enrich.FromLogContext()
    .Enrich.WithMachineName()
    .WriteTo.Console(
        outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj}{NewLine}{Exception}")
    .WriteTo.File(
        path:                  Path.Combine(logCfg.LogDirectory, $"{logCfg.LogFilePrefix}-.log"),
        rollingInterval:       Enum.Parse<RollingInterval>(logCfg.RollingInterval, ignoreCase: true),
        retainedFileCountLimit: logCfg.RetainedFileCount,
        fileSizeLimitBytes:    (long)logCfg.FileSizeLimitMB * 1024 * 1024,
        rollOnFileSizeLimit:   true,
        outputTemplate:        "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{Exception}")
    .CreateLogger();

// ── Host ─────────────────────────────────────────────────────────────────────
try
{
    Log.Information("═══════════════════════════════════════════");
    Log.Information("  RMQ Consumer Service  –  Starting up");
    Log.Information("═══════════════════════════════════════════");

    await Host.CreateDefaultBuilder(args)
        .ConfigureAppConfiguration((context, config) =>
        {
            config.Sources.Clear(); // optional but recommended to avoid conflicts
            config.SetBasePath(Directory.GetCurrentDirectory());
            config.AddJsonFile("axiglobalconfig.json", optional: false, reloadOnChange: true);
            config.AddEnvironmentVariables();
        }).UseSerilog()
        .UseWindowsService()                    // runs cleanly as a Windows Service or console app
        .ConfigureServices((ctx, services) =>
        {
            // ── Settings ──────────────────────────────────────────────────────
            services.Configure<RabbitMqSettings>(ctx.Configuration.GetSection("RabbitMq"));
            services.Configure<DatabaseSettings>(ctx.Configuration.GetSection("Database"));
            services.Configure<SmtpSettings>(ctx.Configuration.GetSection("Smtp"));
            services.Configure<LogSettings>(ctx.Configuration.GetSection("Logging"));
            services.Configure<AppConnectionSettings>(ctx.Configuration.GetSection("AppConnection"));

            var dbSettings = configuration
                .GetSection("Database")
                .Get<DatabaseSettings>();
            var adminConnStr = dbSettings.BuildConnectionString(dbSettings.AdminDatabase);

            // ── Core services ─────────────────────────────────────────────────
            // Singleton: shared across the lifetime of the app
            services.AddSingleton<IRabbitMqConsumer, RabbitMqConsumerService>();
            //services.AddHttpClient();
            services.AddHttpClient("LicenseClient", client =>
            {
                // base address + timeout set once here, not scattered in service
                client.Timeout = TimeSpan.FromSeconds(30);
            });
            // Singleton DataSource for admin DB — one pool, shared safely
            //services.AddNpgsqlDataSource(adminConnStr);

            // Admin DataSource — role management, global PG operations
            services.AddNpgsqlDataSource(
                dbSettings.BuildConnectionString(dbSettings.AdminDatabase), serviceKey: "admin");

            // Shared DataSource — all tenant schema operations (one pool, reused)
            services.AddNpgsqlDataSource(
                dbSettings.BuildConnectionString(dbSettings.SharedDatabase), serviceKey: "shared");

            // Transient: fresh instance per message (created inside a DI scope)
            services.AddTransient<IMessageProcessor, MessageProcessorService>();
            //services.AddTransient<IDatabaseService,  DatabaseService>();
            services.AddTransient<IEmailService,     EmailService>();
            services.AddTransient<IAdminDbService, AdminDbService>();
            //services.AddTransient<ITenantDbService, TenantDbService>();
            services.AddTransient<ITenantProvisionService, TenantProvisionService>();
            services.AddTransient<ILicenseService, LicenseService>();
            services.AddTransient<IDatabaseOrchestrator, DatabaseOrchestrator>();

            // ── Handlers ──────────────────────────────────────────────────────
            services.AddTransient<IQueueHandler, AxiAdminHandler>();
            services.AddTransient<IConfigurationFileService, ConfigurationFileService>();

            // ── Hosted worker ─────────────────────────────────────────────────
            services.AddHostedService<Worker>();
        })
        .Build()
        .RunAsync();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Host terminated unexpectedly.");
    return 1;
}
finally
{
    Log.Information("RMQ Consumer Service shut down.");
    await Log.CloseAndFlushAsync();
}

return 0;
