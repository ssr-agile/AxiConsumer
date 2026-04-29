# Tenant Provisioning Output

Generated from `axigoldendump.sql`.

## Object classification

- Tables: 319
- Sequences: 26
- Functions/procedures: 112
- Views: 19
- Triggers: 30
- Indexes: 7
- Constraints: 159
- COPY data blocks: 319
- Sequence setvals: 26

## Migration order

1. `001_create_schema.sql`
2. `002_tables.sql`
3. `003_sequences.sql`
4. `004_constraints.sql`
5. `005_indexes.sql`
6. `006_views.sql`
7. `007_functions.sql`
8. `008_triggers.sql`
9. `009_permissions.sql`
10. `100_seed_data.sql`

## Important implementation notes

- All explicit `axigolden` references were replaced with `{schema}`.
- Every migration sets `SET LOCAL search_path = {schema}, pg_catalog`.
- Functions are generated with `SET search_path = {schema}, pg_catalog` so unqualified table names inside PL/pgSQL resolve to the tenant schema at runtime.
- `100_seed_data.sql` includes all COPY data blocks from the golden dump; no table-name heuristic exclusions are applied.
- Seed data is emitted as idempotent `INSERT ... ON CONFLICT DO NOTHING` statements.
- Dynamic SQL functions still need application-level input restrictions where they accept raw SQL, especially `axi_firesql`, `axi_firesql_v2`, `execute_sql_list`, and `pr_bulkexecute`.

## Deployment checklist

- Create `app_role` before provisioning tenants.
- Run provisioning with a database role that can create schemas and objects.
- Application connections should use least privilege through `app_role`.
- Do not grant access to tenant schemas to `PUBLIC`.
- Validate tenant names before provisioning; the included .NET service enforces PostgreSQL-safe identifiers.
- Take backups before first production rollout and test restore on a staging copy.


## Seed data split update

`100_seed_data.sql` has been split into sequential files:

```text
100_seed_data_001.sql
100_seed_data_002.sql
100_seed_data_003.sql
...
```

The split preserves the original seed block order exactly. The .NET provisioning service now discovers all `.sql` files recursively and executes them by normalized relative filename order, so the seed files run sequentially after `009_permissions.sql`.

Do not rename seed files without keeping zero-padded numbering, because filename order is the execution order.

# Tenant Provisioning Package - User Role, Ownership and Permission Enabled

This version provisions a tenant schema and a matching PostgreSQL login role.

Example:

```text
schemaName = tenant001
db user    = tenant001
```

## Main changes in this version

- `001_create_schema.sql` now creates or updates the tenant DB login role.
- Password is passed at runtime through `{user_password}`.
- Schema is created as `AUTHORIZATION {schema}`.
- `009_permissions.sql` now includes:
  - schema owner fix
  - table/view/materialized view/foreign table owner fix
  - sequence owner fix
  - routine/function/procedure owner fix
  - type/domain owner fix
  - PUBLIC revokes
  - grants only to the matching tenant role
  - tenant role `search_path` set to its schema
- `.NET` signature updated to:

```csharp
PrepareAppSpaceForNewUser(
    string dbConnection,
    string schemaName,
    string userPassword,
    CancellationToken cancellationToken = default)
```

## Runtime placeholders

The .NET service replaces these safely during execution:

```text
{schema}        -> quoted identifier, for example "tenant001"
{schema_name}   -> quoted SQL string literal, for example 'tenant001'
{user_password} -> quoted SQL string literal, for example 'StrongPassword'
```

## Execution order

All `.sql` files are executed sequentially by filename order, including split seed files:

```text
001_create_schema.sql
002_tables.sql
003_sequences.sql
004_constraints.sql
005_indexes.sql
006_views.sql
007_functions.sql
008_triggers.sql
009_permissions.sql
100_seed_data_001.sql
...
100_seed_data_011.sql
```

## Required database privilege

The connection used for provisioning must be able to:

- create roles
- create schemas
- create database objects
- alter owners
- grant/revoke privileges

Usually this should be a controlled admin/provisioning DB user, not the tenant user.

## Important security note

Cross-schema isolation requires every tenant schema to follow the same rule:

```text
tenant001 role -> tenant001 schema only
tenant002 role -> tenant002 schema only
```

This package revokes PUBLIC access and grants access only to the matching tenant role for the newly created schema.
