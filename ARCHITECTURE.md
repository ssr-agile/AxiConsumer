# RMQ Consumer Service – Architecture & Developer Guide

## Overview

A **.NET 8 Worker Service** that runs as a Windows background service (or console app during development).  
It connects to **RabbitMQ**, consumes messages one at a time, dispatches them to the correct handler, provisions a **PostgreSQL tenant schema** inside a shared database by replaying ordered SQL migrations, updates application connection files, and sends an **HTML status email** via SMTP.

---

## Folder Structure

```
RmqConsumerService/
│
├── axiglobalconfig.json            ← All configuration (RMQ, DB, SMTP, Logging, AppConnection)
│
├── Program.cs                      ← Host bootstrap, DI registration, Serilog + DataSource setup
├── Worker.cs                       ← BackgroundService entry-point
├── RmqConsumerService.csproj
│
├── Configuration/                  ← Strongly-typed settings (bound from axiglobalconfig.json)
│   ├── RabbitMqSettings.cs
│   ├── DatabaseSettings.cs         ← AdminDatabase, SharedDatabase, MigrationsPath, DefaultRolePassword, etc.
│   ├── SmtpSettings.cs
│   ├── LogSettings.cs
│   └── AppConnectionSettings.cs
│
├── Models/                         ← Pure data models, no logic
│   ├── QueueMessage.cs             ← Outer RMQ envelope
│   ├── AxiAdminModels.cs           ← axiadmin payload (email, orgname, axiacid)
│   └── LicenseModels.cs            ← LicenseRequest / LicenseResponse
│
├── Services/
│   ├── Interfaces/
│   │   └── IServices.cs            ← All service interfaces in one file
│   │                                  IRabbitMqConsumer, IMessageProcessor,
│   │                                  IDatabaseOrchestrator,
│   │                                  IAdminDbService, ITenantProvisioningService,
│   │                                  ITenantDbService, ILicenseService,
│   │                                  IEmailService, IConfigurationFileService
│   │
│   ├── RabbitMqConsumerService.cs  ← Connection lifecycle, retry, ack/nack, DI scope per message
│   ├── MessageProcessorService.cs  ← Dispatches to IQueueHandler by ApiName
│   │
│   ├── Database/
│   │   ├── AdminDbService.cs       ← Role management (CREATE/DROP ROLE) via admin NpgsqlDataSource
│   │   ├── TenantProvisioningService.cs  ← Runs ordered SQL migrations into the tenant schema
│   │   ├── TenantDbService.cs      ← SeedUser, UpdateUserKeys via shared NpgsqlDataSource
│   │   ├── LicenseService.cs       ← External HTTP license activation
│   │   └── DatabaseOrchestrator.cs ← Coordinates all DB steps; owns retry + rollback logic
│   │
│   ├── ConfigurationFileService.cs ← Clones keys in AppSettings.ini & axapps.xml; backs up files
│   └── EmailService.cs             ← MailKit SMTP sender
│
├── Handlers/
│   ├── IQueueHandler.cs            ← Contract every handler must implement
│   └── AxiAdminHandler.cs          ← Orchestrates DB + config files + email for ApiName="axiadmin"
│
├── Templates/
│   └── EmailTemplates.cs           ← Self-contained HTML email builder (success / failure)
│
├── Migrations/                     ← SQL scripts executed in ordinal filename order per tenant
│   ├── 001_create_schema.sql
│   ├── 002_tables.sql
│   ├── 003_sequences.sql
│   ├── 004_constraints.sql
│   ├── 005_indexes.sql
│   ├── 006_views.sql
│   ├── 007_functions.sql
│   ├── 008_triggers.sql
│   ├── 009_permissions.sql
│   └── 100_seed_data_001.sql ...   ← Split seed files; run in filename order after permissions
│
└── Logs/                           ← Auto-created at runtime by Serilog
    └── rmq-consumer-YYYYMMDD.log
```

---

## Architecture Diagram

```
RabbitMQ Broker
      │
      │  (durable queue, prefetch=1, manual ack)
      ▼
┌──────────────────────────────────────────────────────────────────┐
│                    Worker  (BackgroundService)                    │
│                                                                  │
│  RabbitMqConsumerService                                         │
│  ├── Persistent connection + channel (auto-recovery)             │
│  ├── Deserialise QueueMessage envelope                           │
│  ├── Apply optional timespanDelay                                │
│  └── Create DI scope per message ──────────────────────────────┐ │
│                                                                │ │
│      MessageProcessorService                                   │ │
│      └── Resolve IQueueHandler by ApiName                      │ │
│          │                                                     │ │
│          ▼  ApiName == "axiadmin"                              │ │
│      AxiAdminHandler                                           │ │
│      │                                                         │ │
│      ├── DatabaseOrchestrator ─────────────────────────────┐  │ │
│      │   ├── AdminDbService        → admin NpgsqlDataSource │  │ │
│      │   │   └── EnsureRole (CREATE ROLE IF NOT EXISTS)     │  │ │
│      │   │                                                  │  │ │
│      │   ├── TenantProvisioningService → shared DataSource  │  │ │
│      │   │   └── Run ordered .sql migrations                │  │ │
│      │   │       (single transaction, checksum logged)      │  │ │
│      │   │                                                  │  │ │
│      │   ├── TenantDbService         → shared DataSource    │  │ │
│      │   │   ├── SeedUserAsync (calls setup_new_user fn)    │  │ │
│      │   │   └── UpdateUserKeysAsync (authkey, userkey)     │  │ │
│      │   │                                                  │  │ │
│      │   ├── LicenseService          → External HTTP API    │  │ │
│      │   │                                                  │  │ │
│      │   └── On failure → CleanupAsync                      │  │ │
│      │       ├── TenantProvisioningService.CleanupSchemaAsync│  │ │
│      │       └── AdminDbService.CleanupAsync (DROP ROLE)    │  │ │
│      │                                                      └──┘ │
│      ├── ConfigurationFileService                               │ │
│      │   ├── Clone axiadmin section in AppSettings.ini          │ │
│      │   ├── Clone <axiadmin> node in axapps.xml                │ │
│      │   ├── Backup existing files (timestamped)                │ │
│      │   └── Write to all configured destination paths          │ │
│      │                                                          │ │
│      └── EmailService → SMTP                                    │ │
│          └── SendSuccessAsync / SendFailureAsync                └─┘
└──────────────────────────────────────────────────────────────────┘

PostgreSQL (single server)
├── postgres (admin DB)           ← Used only for CREATE/DROP ROLE
│   └── public.__schema_migrations ← Migration audit log (all tenants)
└── axi_shared (shared DB)        ← All tenant schemas live here
    ├── axiadmin   (golden schema — never modified at runtime)
    ├── nexcore    (tenant schema)
    ├── clientabc  (tenant schema)
    └── ...
```

---

## Provisioning Flow (step by step)

```
 1. RMQ delivers message → OnMessageReceivedAsync
 2. Deserialise JSON → QueueMessage envelope
 3. Apply optional timespanDelay
 4. Create DI scope (isolates all services per message)
 5. MessageProcessorService resolves handler by ApiName
 6. AxiAdminHandler.HandleAsync
 7.   → Deserialise queuedata → AxiAdminData (email, orgname, axiacid)
 8.   → DatabaseOrchestrator.ProvisionTenantAsync(axiacid, email)
 9.       a. AdminDbService.EnsureRoleAsync       [admin DataSource]
              → CREATE ROLE "<axiacid>" LOGIN PASSWORD '...' (idempotent)
10.       b. TenantProvisioningService.ProvisionSchemaAsync  [shared DataSource]
              → Open single connection + transaction
              → EnsureMigrationLogAsync (CREATE TABLE IF NOT EXISTS public.__schema_migrations)
              → For each .sql file in Migrations/ (ordinal order):
                  - Skip if already logged for this schema (idempotent re-run)
                  - Replace {schema} → "<axiacid>"
                  - Execute (CommandTimeout = 0 — large schemas can take time)
                  - Log to __schema_migrations with SHA-256 checksum
              → COMMIT
11.       c. TenantDbService.SeedUserAsync        [shared DataSource]
              → Calls <schema>.setup_new_user(username, email, nickname)
12.       d. LicenseService.ActivateAsync         [named HttpClient]
              → POST to external license API
              → Validate AuthKey + UserKey in response
13.       e. TenantDbService.UpdateUserKeysAsync  [shared DataSource]
              → UPDATE <schema>.axusers SET authkey, userkey WHERE email = ...
14.       On any failure → rollback:
              → TenantProvisioningService.CleanupSchemaAsync (DROP SCHEMA CASCADE + clear log)
              → AdminDbService.CleanupAsync (DROP ROLE IF EXISTS)
              → Re-throw (handler sends failure email)
15.   → ConfigurationFileService.UpdateConfigsAsync
          → Clone axiadmin section in AppSettings.ini (JSON)
          → Clone <axiadmin> node in axapps.xml
          → Backup existing files with timestamp
          → Write to AxpertWebScriptsPath, ARMWebScriptsPath, ARMAPIPath
16.   → EmailService.SendSuccessAsync / SendFailureAsync
          → Build HTML from EmailTemplates
          → Connect SMTP, authenticate, send, disconnect
17. BasicAck → message removed from queue
    (BasicNack + requeue:false on unhandled exception → dead-letter)
```

---

## Key Design Decisions

| Concern | Decision | Rationale |
|---|---|---|
| **Tenant isolation** | Schema-per-tenant inside one shared DB | Cheaper than DB-per-tenant; PG schema isolation is strong; easier backups |
| **Schema creation** | Ordered SQL migration scripts | Declarative, version-controlled, auditable; matches your existing tooling |
| **Migration log** | `public.__schema_migrations` with SHA-256 checksum | Idempotent re-runs; drift detection if scripts change after provisioning |
| **Connection pools** | Two keyed `NpgsqlDataSource` singletons (admin + shared) | One pool per logical DB; no re-auth overhead; thread-safe; shared across all messages |
| **Tenant connections** | `NpgsqlDataSource.OpenConnectionAsync()` | Borrows from pool cleanly; `await using` guarantees return |
| **Extensibility** | `IQueueHandler` per API | New API → new handler + 1 DI line; zero changes to infrastructure |
| **Message isolation** | New DI scope per message | No shared state between concurrent or sequential messages |
| **Reliability** | Manual ack/nack | Message removed from queue only after full success |
| **Retry** | Polly exponential backoff in Orchestrator (not in services) | Retry is an orchestration concern; services stay simple and testable |
| **Rollback** | Schema drop + role drop on any failure | Atomic provisioning — no half-provisioned tenants |
| **Dead-letter** | `BasicNack(requeue: false)` on unhandled exception | Poison messages don't loop; inspectable in RMQ management UI |
| **Security** | Identifier regex `^[a-z_][a-z0-9_]{0,62}$` at service boundary | PostgreSQL-safe; prevents injection even if Sanitise upstream is bypassed |
| **Logging** | Serilog, `EnableDebug` flag, structured properties | Zero-cost debug path in prod; easy to add Graylog/Wazuh sink |

---

## Connection Pool Architecture

```
Program.cs registers two keyed NpgsqlDataSource singletons:

  services.AddKeyedNpgsqlDataSource(adminConnStr,  serviceKey: "admin");
  services.AddKeyedNpgsqlDataSource(sharedConnStr, serviceKey: "shared");

Injection:
  AdminDbService([FromKeyedServices("admin")] NpgsqlDataSource ds)
  TenantProvisioningService([FromKeyedServices("shared")] NpgsqlDataSource ds)
  TenantDbService([FromKeyedServices("shared")] NpgsqlDataSource ds)

Why two, not one?
  - Admin operations (CREATE ROLE, DROP ROLE) must target the admin/postgres DB
  - Tenant operations must target the shared DB where schemas live
  - Keeping pools separate avoids cross-DB command accidents
  - Each pool is pre-configured once at startup (SSL, auth, timeouts)
```

---

## Migration Script Rules

| Rule | Reason |
|---|---|
| Filenames must be zero-padded (e.g. `001_`, `100_seed_001_`) | Execution order = lexicographic sort order |
| Every script must use `{schema}` — never hardcode schema names | `TenantProvisioningService` replaces it with the quoted tenant identifier |
| Every script should set `SET LOCAL search_path = {schema}, pg_catalog;` | Unqualified identifiers inside functions resolve correctly |
| Seed files must use `INSERT ... ON CONFLICT DO NOTHING` | Idempotent re-runs don't duplicate data |
| Never rename a script after it has run in production | The migration log tracks by filename; a rename = re-execution |

---

## Configuration Reference (`axiglobalconfig.json`)

### `RabbitMq`
| Key | Default | Description |
|---|---|---|
| `Host` | `localhost` | Broker hostname |
| `Port` | `5672` | AMQP port |
| `Username` / `Password` | `guest` / `guest` | Credentials |
| `VirtualHost` | `/` | RMQ vhost |
| `QueueName` | — | Queue to consume |
| `PrefetchCount` | `1` | In-flight messages per consumer |
| `RetryIntervalSeconds` | `5` | Delay between startup retries |
| `MaxRetryAttempts` | `5` | Max connection attempts before fatal exit |

### `Database`
| Key | Description |
|---|---|
| `Host` / `Port` | PostgreSQL server |
| `Username` / `Password` | Superuser (for admin operations) |
| `AdminDatabase` | Used for CREATE/DROP ROLE (typically `postgres`) |
| `SharedDatabase` | DB where all tenant schemas are provisioned |
| `DefaultRolePassword` | Temporary password for new tenant roles — rotate via secrets manager |
| `MigrationsPath` | Relative path to the folder containing `.sql` migration scripts |
| `AppDomain` | Passed to the license activation API |
| `LicenseApiUrl` | Full URL of the external license endpoint |

### `Smtp`
| Key | Description |
|---|---|
| `Host` / `Port` | SMTP server (`587` = STARTTLS, `465` = SSL) |
| `Username` / `Password` | SMTP credentials |
| `FromEmail` / `FromName` | Sender identity |
| `EnableSsl` | `true` → STARTTLS |

### `AppConnection`
| Key | Description |
|---|---|
| `AxpertWebScriptsPath` | Primary path for AppSettings.ini and axapps.xml |
| `ARMWebScriptsPath` | Secondary destination for config files |
| `ARMAPIPath` | API service config destination |
| `BackupFolderName` | Sub-folder name for timestamped backups |
| `AppLoginUrl` | Base URL prepended with axiacid in success email |
| `SupportUrl` | Support link included in failure email |

### `Logging`
| Key | Description |
|---|---|
| `EnableDebug` | `true` → emit Debug-level entries (disable in prod) |
| `LogDirectory` | Output folder (`Logs/`) |
| `LogFilePrefix` | Log filename prefix |
| `RollingInterval` | `Day` / `Hour` / `Month` |
| `RetainedFileCount` | Rotated file retention count |
| `FileSizeLimitMB` | Max file size before roll-on-size |

---

## Adding a New Handler

1. Create `Handlers/MyNewHandler.cs` implementing `IQueueHandler`.
2. Set `ApiName => "mynewapi"`.
3. Inject whatever services you need in the constructor.
4. Register in `Program.cs`:
   ```csharp
   services.AddTransient<IQueueHandler, MyNewHandler>();
   ```

Zero changes to infrastructure. `MessageProcessorService` dispatches by `ApiName` automatically.

---

## Running Locally (Development)

```bash
dotnet restore
dotnet run
# Live logs in console; Logs/ folder also written
```

## Install as Windows Service (Production)

```powershell
# 1. Publish
dotnet publish -c Release -r win-x64 --self-contained true -o C:\Services\RmqConsumer

# 2. Create service
sc.exe create "RmqConsumerService" binPath="C:\Services\RmqConsumer\RmqConsumerService.exe" start=auto

# 3. Manage
sc.exe start  "RmqConsumerService"
sc.exe stop   "RmqConsumerService"
sc.exe delete "RmqConsumerService"
```

`UseWindowsService()` in `Program.cs` means the same binary runs cleanly as a service or in a terminal — no changes needed between environments.

---

## Future Enhancement Points

| Area | How to extend |
|---|---|
| **Logging sinks** | Add `.WriteTo.Graylog(...)` or `.WriteTo.Seq(...)` in `Program.cs` — Serilog sink, one line |
| **Secrets management** | Replace plaintext passwords with Azure Key Vault / HashiCorp Vault via `AddAzureKeyVault()` |
| **Multiple queues** | Register additional `IRabbitMqConsumer` instances with named `IOptions<RabbitMqSettings>` |
| **Schema drift detection** | Query `__schema_migrations` and compare checksums against files on disk at startup |
| **Health checks** | `services.AddHealthChecks().AddNpgsql(...).AddRabbitMQ(...)` |
| **Linux / Docker** | Guard `UseWindowsService()` with `OperatingSystem.IsWindows()` |
| **Migration rollback** | Add `down_*.sql` scripts and a `RollbackSchemaAsync` method on `ITenantProvisioningService` |
| **Observability** | Add OpenTelemetry tracing — Npgsql and HttpClient have native OTEL instrumentation |