-- Tenant ownership and isolation permissions.
-- This script must run after tables, sequences, constraints, indexes, views, functions, and triggers are created.

ALTER SCHEMA {schema} OWNER TO {schema};

DO $$
DECLARE
    v_schema text := {schema_name};
    r record;
BEGIN
    -- 1) Fix schema owner
    IF EXISTS (
        SELECT 1
        FROM pg_namespace n
        JOIN pg_roles ro ON ro.oid = n.nspowner
        WHERE n.nspname = v_schema
          AND ro.rolname <> v_schema
    ) THEN
        EXECUTE format('ALTER SCHEMA %I OWNER TO %I', v_schema, v_schema);
    END IF;

    -- 2) Fix tables / partitioned tables / views / materialized views / foreign tables
    FOR r IN
        SELECT c.relkind, n.nspname AS schema_name, c.relname AS object_name
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        JOIN pg_roles ro ON ro.oid = c.relowner
        WHERE n.nspname = v_schema
          AND ro.rolname <> v_schema
          AND c.relkind IN ('r','p','v','m','f')
        ORDER BY c.relkind, c.relname
    LOOP
        IF r.relkind IN ('r','p') THEN
            EXECUTE format('ALTER TABLE %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
        ELSIF r.relkind = 'v' THEN
            EXECUTE format('ALTER VIEW %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
        ELSIF r.relkind = 'm' THEN
            EXECUTE format('ALTER MATERIALIZED VIEW %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
        ELSIF r.relkind = 'f' THEN
            EXECUTE format('ALTER FOREIGN TABLE %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
        END IF;
    END LOOP;

    -- 3) Fix sequences, including owned/identity sequences
    FOR r IN
        SELECT n.nspname AS schema_name, c.relname AS object_name
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        JOIN pg_roles ro ON ro.oid = c.relowner
        WHERE n.nspname = v_schema
          AND ro.rolname <> v_schema
          AND c.relkind = 'S'
        ORDER BY c.relname
    LOOP
        EXECUTE format('ALTER SEQUENCE %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
    END LOOP;

    -- 4) Fix routines: functions, procedures, aggregates, window functions
    FOR r IN
        SELECT n.nspname AS schema_name,
               p.proname AS object_name,
               pg_get_function_identity_arguments(p.oid) AS args
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        JOIN pg_roles ro ON ro.oid = p.proowner
        WHERE n.nspname = v_schema
          AND ro.rolname <> v_schema
        ORDER BY p.proname
    LOOP
        EXECUTE format('ALTER ROUTINE %I.%I(%s) OWNER TO %I',
                       r.schema_name, r.object_name, r.args, v_schema);
    END LOOP;

    -- 5) Fix user-defined types and domains. Exclude table row types and array types.
    FOR r IN
        SELECT n.nspname AS schema_name, t.typname AS object_name
        FROM pg_type t
        JOIN pg_namespace n ON n.oid = t.typnamespace
        JOIN pg_roles ro ON ro.oid = t.typowner
        WHERE n.nspname = v_schema
          AND ro.rolname <> v_schema
          AND t.typtype IN ('d','e','r','m')
          AND t.typname NOT LIKE '\_%'
        ORDER BY t.typname
    LOOP
        EXECUTE format('ALTER TYPE %I.%I OWNER TO %I', r.schema_name, r.object_name, v_schema);
    END LOOP;

    RAISE NOTICE 'Ownership fix completed for schema: %', v_schema;
END $$;

-- Remove inherited/default public access.
REVOKE ALL ON SCHEMA {schema} FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA {schema} FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA {schema} FROM PUBLIC;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA {schema} FROM PUBLIC;

-- Grant access only to matching tenant role.
GRANT USAGE, CREATE ON SCHEMA {schema} TO {schema};
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
ON ALL TABLES IN SCHEMA {schema}
TO {schema};
GRANT USAGE, SELECT, UPDATE
ON ALL SEQUENCES IN SCHEMA {schema}
TO {schema};
GRANT EXECUTE
ON ALL FUNCTIONS IN SCHEMA {schema}
TO {schema};

-- Default privileges for future objects created by tenant role in this schema.
ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
REVOKE ALL ON TABLES FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
REVOKE ALL ON SEQUENCES FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
REVOKE ALL ON FUNCTIONS FROM PUBLIC;

ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER ON TABLES TO {schema};
ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO {schema};
ALTER DEFAULT PRIVILEGES FOR ROLE {schema} IN SCHEMA {schema}
GRANT EXECUTE ON FUNCTIONS TO {schema};

ALTER ROLE {schema} SET search_path = {schema};
