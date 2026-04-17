-- =============================================================================
--  schema_dump.sql  –  Template applied to every new tenant database.
--  The literal string {{SCHEMA_NAME}} is replaced at runtime with the
--  sanitised axiacid value before this file is executed.
-- =============================================================================

-- Set the default search path for this session
SET search_path TO {{SCHEMA_NAME}};

-- ---------------------------------------------------------------------------
-- Users
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {{SCHEMA_NAME}}.users (
    id          BIGSERIAL       PRIMARY KEY,
    username    VARCHAR(100)    NOT NULL UNIQUE,
    email       VARCHAR(255)    NOT NULL UNIQUE,
    is_active   BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Settings  (key-value store per tenant)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {{SCHEMA_NAME}}.settings (
    id          BIGSERIAL       PRIMARY KEY,
    key         VARCHAR(100)    NOT NULL UNIQUE,
    value       TEXT,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Audit log  (append-only; never update or delete rows here)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS {{SCHEMA_NAME}}.audit_log (
    id          BIGSERIAL       PRIMARY KEY,
    actor       VARCHAR(255)    NOT NULL,
    action      VARCHAR(100)    NOT NULL,
    entity      VARCHAR(100),
    entity_id   BIGINT,
    detail      JSONB,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Indexes
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS ix_audit_log_actor      ON {{SCHEMA_NAME}}.audit_log (actor);
CREATE INDEX IF NOT EXISTS ix_audit_log_created_at ON {{SCHEMA_NAME}}.audit_log (created_at DESC);

-- ---------------------------------------------------------------------------
-- Seed data  (optional – comment out if not needed)
-- ---------------------------------------------------------------------------
INSERT INTO {{SCHEMA_NAME}}.settings (key, value)
VALUES
    ('provisioned_at', NOW()::TEXT),
    ('schema_version', '1.0.0')
ON CONFLICT (key) DO NOTHING;

-- =============================================================================
-- Add more tables / indexes / functions below as the schema evolves.
-- =============================================================================
