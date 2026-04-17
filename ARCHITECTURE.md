# RMQ Consumer Service – Architecture & Developer Guide

## Overview

A **.NET 8 Worker Service** that runs as a Windows background service (or console app during development).  
It connects to **RabbitMQ**, consumes messages one at a time, dispatches them to the correct handler, provisions a **PostgreSQL** database, updates connection files and sends an **HTML email** to the user via SMTP.

---

## Folder Structure

```
RmqConsumerService/
│
├── appsettings.json               ← All configuration (RMQ, DB, SMTP, Logging)
│
├── Program.cs                     ← Host bootstrap, DI registration, Serilog setup
├── Worker.cs                      ← BackgroundService entry-point
├── RmqConsumerService.csproj
│
├── Configuration/                 ← Strongly-typed settings (bound from appsettings)
│   ├── RabbitMqSettings.cs
│   ├── DatabaseSettings.cs
│   ├── SmtpSettings.cs
│   └── LogSettings.cs
│
├── Models/                        ← Plain data models (no logic)
│   ├── QueueMessage.cs            ← Outer RMQ envelope
│   └── AxiAdminModels.cs          ← axiadmin-specific payload
│
├── Services/
│   ├── Interfaces/
│   │   └── IServices.cs           ← IRabbitMqConsumer, IMessageProcessor,
│   │                                 IDatabaseService, IEmailService,
│   │                                 IConfigurationService
│   │
│   ├── RabbitMqConsumerService.cs ← Connection, retry, ack/nack, scope-per-message
│   ├── MessageProcessorService.cs ← Dispatches to IQueueHandler by ApiName
│   ├── DatabaseService.cs         ← PostgreSQL provisioning (create DB + schema + dump)
│   ├── ConfigurationFileService.cs ← Clones & renames keys in AppSettings.ini & axapps.xml
│   └── EmailService.cs            ← MailKit SMTP sender
│
├── Handlers/
│   ├── IQueueHandler.cs           ← Contract every handler must implement
│   └── AxiAdminHandler.cs         ← Orchestrates DB provisioning + email for "axiadmin"
│
├── Templates/
│   └── EmailTemplates.cs          ← Self-contained HTML email builder (success / failure)
│
├── SqlDumps/
│   └── schema_dump.sql            ← Template applied to every new tenant DB
│
└── Logs/                          ← Auto-created at runtime by Serilog
    └── rmq-consumer-YYYYMMDD.log
```

---

## Architecture Diagram

```
RabbitMQ Broker
      │
      │  (durable queue, prefetch=1)
      ▼
┌─────────────────────────────────────────────────────────────┐
│                     Worker  (BackgroundService)             │
│                                                             │
│   RabbitMqConsumerService                                   │
│   ├── Connection + Channel (auto-recovery)                  │
│   ├── Deserialise QueueMessage                              │
│   ├── Create DI scope per message                           │
│   │                                                         │
│   └── MessageProcessorService                               │
│       └── Resolves IQueueHandler by ApiName                 │
│           │                                                 │
│           ▼  (ApiName == "axiadmin")                        │
│       AxiAdminHandler                                       │
│       ├── DatabaseService   → PostgreSQL                    │
│       ├── ConfigFileService   → Connection files            │
│       └── EmailService      → SMTP Server                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Design Decisions

| Concern | Decision | Why |
|---|---|---|
| **Extensibility** | `IQueueHandler` per API | Add a new handler → register in DI; zero changes elsewhere |
| **Isolation** | New DI scope per message | Clean, no shared state between messages |
| **Reliability** | Manual ack / nack | Message only removed from queue after successful processing |
| **Retry** | `AutomaticRecoveryEnabled` on RMQ client + startup retry loop | Handles broker restarts transparently |
| **Dead-letter** | `BasicNack(requeue: false)` on error | Poison messages don't loop forever |
| **Security** | Identifier sanitised to `[a-z0-9_]` | Prevents SQL injection via axiaAcId |
| **SQL atomicity** | Transaction wraps entire SQL dump | Partial schema application is impossible |
| **Logging** | Serilog with conditional Debug level | `EnableDebug: false` in prod for performance |

---

## Message Flow (step by step)

```
1. RMQ delivers message → OnMessageReceivedAsync
2. Deserialise JSON  →  QueueMessage
3. Apply optional timespanDelay
4. Create DI scope
5. MessageProcessorService.ProcessAsync
6.   → Find IQueueHandler where ApiName == message.ApiName
7.   → AxiAdminHandler.HandleAsync
8.       → Deserialise queuedata  →  AxiAdminData
9.       → DatabaseService.CreateDatabaseAndSchemaAsync(axiaAcId)
10.          a. Open admin DB connection
11.          b. Check if DB exists  →  CREATE DATABASE if not
12.          c. Open new DB connection  →  CREATE SCHEMA IF NOT EXISTS
13.          d. Read schema_dump.sql, replace {{SCHEMA_NAME}}, execute in transaction / clones a template
14.      → EmailService.SendSuccessAsync  (or SendFailureAsync)
15.          a. Build HTML via EmailTemplates
16.          b. Connect to SMTP, authenticate, send, disconnect
17. BasicAck  →  message removed from queue
```

---

## Configuration File Service

```
Handles the secondary provisioning step for legacy application compatibility:

Fetch: Reads AppSettings.ini (JSON) and axapps.xml (XML) from a master template directory defined in appsettings.json.

Clone & Mutate: * In the .ini (JSON), it duplicates the axiadmin section under the new AxiAccountId key.

In the .xml, it clones the <axiadmin> node and renames it.

Backup & Distribute: * Creates a timestamped backup of existing config files in a ./axconnections/ sub-folder.

Writes the updated files to multiple destination paths simultaneously to keep different app instances in sync.

```

---

## Database Service

```
Admin Connection: Used for CREATE DATABASE and managing the AdminDB registry.

Tenant Connection: Used for executing internal setup functions (e.g., setup_new_user) and schema-level permissions.

Safety: Implements a "Maintenance Role Exclusion" list in the connection terminator to ensure that high-availability tools are not disconnected during the cloning process.

Registry: Tracks all successful provisions in a central AdminDB to facilitate global management and logging.

```

---

## Configuration Reference (`appsettings.json`)

### `RabbitMq`
| Key | Default | Description |
|---|---|---|
| `Host` | `localhost` | Broker hostname or IP |
| `Port` | `5672` | AMQP port |
| `Username` | `guest` | RMQ user |
| `Password` | `guest` | RMQ password |
| `VirtualHost` | `/` | RMQ vhost |
| `QueueName` | — | Queue to consume |
| `PrefetchCount` | `1` | Messages in-flight per consumer |
| `RetryIntervalSeconds` | `5` | Delay between connection retries |
| `MaxRetryAttempts` | `5` | Max startup connection attempts |

### `Database`
| Key | Description |
|---|---|
| `Host` | PostgreSQL host |
| `Port` | PostgreSQL port (default 5432) |
| `Username` | Superuser or DB owner |
| `Password` | Credential |
| `AdminDatabase` | DB used to issue `CREATE DATABASE` (typically `postgres`) |
| `SqlDumpPath` | Relative path to the SQL template |

### `Smtp`
| Key | Description |
|---|---|
| `Host` | SMTP server hostname |
| `Port` | `587` for STARTTLS, `465` for SSL |
| `Username` / `Password` | SMTP credentials |
| `FromEmail` / `FromName` | Sender identity |
| `EnableSsl` | `true` → STARTTLS |

### `Logging`
| Key | Description |
|---|---|
| `EnableDebug` | `true` → write Debug-level entries |
| `LogDirectory` | Folder for log files |
| `LogFilePrefix` | File name prefix (e.g. `rmq-consumer`) |
| `RollingInterval` | `Day` / `Hour` / `Month` |
| `RetainedFileCount` | How many rotated files to keep |
| `FileSizeLimitMB` | Max size before roll-on-size kicks in |

---

## SQL Dump Template (`SqlDumps/schema_dump.sql`)

- Use `{{SCHEMA_NAME}}` anywhere you need the tenant identifier.
- The service replaces it with the sanitised `axiaAcId` at runtime.
- The entire file runs inside a **single transaction** — it either fully applies or fully rolls back.
- To evolve the schema: edit the file, or add a migration runner later.

---

## How to Add a New Handler

1. Create `Handlers/MyNewHandler.cs` implementing `IQueueHandler`.
2. Set `ApiName => "mynewapi"`.
3. Inject whatever services you need via constructor.
4. Register in `Program.cs`:
   ```csharp
   services.AddTransient<IQueueHandler, MyNewHandler>();
   ```
That's it. The dispatcher picks it up automatically.

---

## Running Locally (Development)

```bash
# 1. Restore packages
dotnet restore

# 2. Run
dotnet run

# Console shows live logs; Logs/ folder is also written.
```

## Install as Windows Service (Production)

```powershell
# 1. Publish self-contained
dotnet publish -c Release -r win-x64 --self-contained true -o C:\Services\RmqConsumer

# 2. Create Windows Service
sc.exe create "RmqConsumerService" `
    binPath="C:\Services\RmqConsumer\RmqConsumerService.exe" `
    start=auto

# 3. Start
sc.exe start "RmqConsumerService"

# 4. Stop / Remove
sc.exe stop   "RmqConsumerService"
sc.exe delete "RmqConsumerService"
```

> `UseWindowsService()` in `Program.cs` means the same binary runs cleanly both in a terminal and as a service — no code changes needed.

---

## Future Enhancement Points

| Area | How to extend |
|---|---|
| **Logging sinks** | Add `.WriteTo.Graylog(...)` or `.WriteTo.Wazuh(...)` to `LoggerConfiguration` in `Program.cs` |
| **New queue handler** | Implement `IQueueHandler` + 1-line DI registration |
| **Multiple queues** | Run multiple `RabbitMqConsumerService` instances with different `IOptions<RabbitMqSettings>` named options |
| **Secrets** | Replace plaintext passwords with `dotnet user-secrets`, Azure Key Vault, or HashiCorp Vault |
| **Schema migrations** | Replace the static SQL dump with FluentMigrator or DbUp |
| **Linux / Docker** | Remove `UseWindowsService()` or guard it with `RuntimeInformation.IsOSPlatform(OSPlatform.Windows)` |
| **Health checks** | Add `services.AddHealthChecks()` with RMQ + Postgres probes |
