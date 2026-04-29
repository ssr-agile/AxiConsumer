-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE SEQUENCE {schema}.ax_entity_relseq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_homebuild_master_homebuild_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_homebuild_master_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_homebuild_saved_homebuild_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_homebuild_saved_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_layoutdesign_saved_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_layoutdesign_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_notify_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_page_saved_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_page_template_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_pages_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_widg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_widget_publish_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_widget_saved_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.ax_widget_widget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axdsignmail_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axp_mailjobsid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axpdef_genseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axsms_recordid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axsms_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.axsmsid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.connectnoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999
    CACHE 1
    CYCLE;

CREATE SEQUENCE {schema}.inbound_inboundid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.inbound_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.outbound_outboundid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE {schema}.outbound_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE {schema}.ax_homebuild_master_homebuild_id_seq OWNED BY {schema}.ax_homebuild_master.homebuild_id;

ALTER SEQUENCE {schema}.ax_homebuild_saved_homebuild_id_seq OWNED BY {schema}.ax_homebuild_saved.homebuild_id;

ALTER SEQUENCE {schema}.ax_widget_widget_id_seq OWNED BY {schema}.ax_widget.widget_id;

ALTER SEQUENCE {schema}.axsms_recordid_seq OWNED BY {schema}.axsms.recordid;

ALTER SEQUENCE {schema}.inbound_inboundid_seq OWNED BY {schema}.inbound.inboundid;

ALTER SEQUENCE {schema}.outbound_outboundid_seq OWNED BY {schema}.outbound.outboundid;

ALTER TABLE ONLY {schema}.ax_homebuild_master ALTER COLUMN homebuild_id SET DEFAULT nextval('{schema}.ax_homebuild_master_homebuild_id_seq'::regclass);

ALTER TABLE ONLY {schema}.ax_homebuild_saved ALTER COLUMN homebuild_id SET DEFAULT nextval('{schema}.ax_homebuild_saved_homebuild_id_seq'::regclass);

ALTER TABLE ONLY {schema}.ax_widget ALTER COLUMN widget_id SET DEFAULT nextval('{schema}.ax_widget_widget_id_seq'::regclass);

ALTER TABLE ONLY {schema}.axsms ALTER COLUMN recordid SET DEFAULT nextval('{schema}.axsms_recordid_seq'::regclass);

ALTER TABLE ONLY {schema}.inbound ALTER COLUMN inboundid SET DEFAULT nextval('{schema}.inbound_inboundid_seq'::regclass);

ALTER TABLE ONLY {schema}.outbound ALTER COLUMN outboundid SET DEFAULT nextval('{schema}.outbound_outboundid_seq'::regclass);

SELECT pg_catalog.setval('{schema}.ax_entity_relseq', 1244, true);

SELECT pg_catalog.setval('{schema}.ax_homebuild_master_homebuild_id_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_homebuild_master_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_homebuild_saved_homebuild_id_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_homebuild_saved_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_layoutdesign_saved_seq', 78, true);

SELECT pg_catalog.setval('{schema}.ax_layoutdesign_seq', 78, true);

SELECT pg_catalog.setval('{schema}.ax_notify_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_page_saved_seq', 1, true);

SELECT pg_catalog.setval('{schema}.ax_page_template_seq', 9, true);

SELECT pg_catalog.setval('{schema}.ax_pages_seq', 10, false);

SELECT pg_catalog.setval('{schema}.ax_widg_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_widget_publish_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_widget_saved_seq', 1, false);

SELECT pg_catalog.setval('{schema}.ax_widget_widget_id_seq', 1, false);

SELECT pg_catalog.setval('{schema}.axdsignmail_seq', 1, false);

SELECT pg_catalog.setval('{schema}.axp_mailjobsid', 1, false);

SELECT pg_catalog.setval('{schema}.axpdef_genseq', 1, false);

SELECT pg_catalog.setval('{schema}.axsms_recordid_seq', 1, false);

SELECT pg_catalog.setval('{schema}.axsms_seq', 1, false);

SELECT pg_catalog.setval('{schema}.axsmsid', 1, false);

SELECT pg_catalog.setval('{schema}.connectnoseq', 119, true);

SELECT pg_catalog.setval('{schema}.inbound_inboundid_seq', 1, false);

SELECT pg_catalog.setval('{schema}.inbound_seq', 1, false);

SELECT pg_catalog.setval('{schema}.outbound_outboundid_seq', 1, false);

SELECT pg_catalog.setval('{schema}.outbound_seq', 1, false);
