-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE INDEX ord_formname_ix_axtsuserconfig ON {schema}.axtsuserconfig USING btree (username, formname);

CREATE INDEX ord_reptname_ix_axivuserconfig ON {schema}.axivuserconfig USING btree (username, reportname);

CREATE INDEX ord_transid_ix_searchdef ON {schema}.searchdef USING btree (username, transid);

CREATE INDEX ord_username_ix_axappconfig ON {schema}.axappconfig USING btree (username);

CREATE INDEX ui_axactivetasks_keyvalue ON {schema}.axactivetasks USING btree (keyvalue);

CREATE INDEX ui_axactivetasks_transid ON {schema}.axactivetasks USING btree (transid);

CREATE INDEX username_idx ON {schema}.axpdef_peg_usergroups USING btree (username);
