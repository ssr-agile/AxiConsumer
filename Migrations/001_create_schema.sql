DO $$
DECLARE
    v_schema text := {schema_name};
    v_password text := {user_password};
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = v_schema
    ) THEN
        EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L', v_schema, v_password);
    ELSE
        EXECUTE format('ALTER ROLE %I LOGIN PASSWORD %L', v_schema, v_password);
    END IF;

    -- Important: allow provisioning user to act as tenant role
    EXECUTE format('GRANT %I TO CURRENT_USER', v_schema);

    -- Now this should work
    EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I AUTHORIZATION %I', v_schema, v_schema);

    EXECUTE format('REVOKE ALL ON SCHEMA %I FROM PUBLIC', v_schema);
    EXECUTE format('GRANT USAGE, CREATE ON SCHEMA %I TO %I', v_schema, v_schema);

    EXECUTE format('ALTER ROLE %I SET search_path = %I', v_schema, v_schema);
END $$;