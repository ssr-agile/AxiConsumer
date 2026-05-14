-- ============================================================================
-- Safe Re-runnable SQL Script
-- Changes applied:
-- 1. CREATE TABLE/SEQUENCE -> IF NOT EXISTS
-- 2. CREATE VIEW/FUNCTION/PROCEDURE -> OR REPLACE
-- 3. DROP statements -> IF EXISTS
-- 4. ALTER TABLE ADD COLUMN -> IF NOT EXISTS
-- 5. ALTER TABLE DROP COLUMN -> IF EXISTS
-- Note: ALTER TABLE ADD CONSTRAINT is left unchanged because PostgreSQL does
-- not support IF NOT EXISTS for constraints directly.
-- ============================================================================

-- 010_axi_cmd_pallate_specific_permissions.sql
-- Combined SQL file generated from axi_axdirectsql_tables.sql, axi_command_tables.sql, axi_dependent_tables.sql, axi_functions.sql
-- SQL wrapper markers were removed and statements were normalized with semicolon terminators.

-- ============================================================================
-- Section: axi_axdirectsql_tables.sql
-- ============================================================================

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990001;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990002;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990003;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990004;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990005;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990006;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990007;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990008;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990009;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990010;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990011;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990012;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990013;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990014;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990015;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990016;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990017;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990018;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990019;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990020;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990021;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990022;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990023;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990024;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990025;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990026;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990027;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990028;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990029;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990030;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990031;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990032;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990033;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990034;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990035;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990036;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990037;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990038;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990039;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990040;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990041;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990042;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990043;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990044;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990045;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990046;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990047;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990048;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990049;

DELETE FROM {schema}.axdirectsql where axdirectsqlid = 99999999990050;

-- axdirectsql DDL

CREATE TABLE IF NOT EXISTS {schema}.axdirectsql (
	axdirectsqlid numeric(16) NOT NULL,
	cancel varchar(1) NULL,
	sourceid numeric(16) NULL,
	mapname varchar(20) NULL,
	username varchar(50) NULL,
	modifiedon timestamp NULL,
	createdby varchar(50) NULL,
	createdon timestamp NULL,
	wkid varchar(15) NULL,
	app_level numeric(3) NULL,
	app_desc numeric(1) NULL,
	app_slevel numeric(3) NULL,
	cancelremarks varchar(150) NULL,
	wfroles varchar(250) NULL,
	sqlname varchar(50) NULL,
	ddldatatype varchar(20) NULL,
	sqlsrc varchar(30) NULL,
	sqlsrccnd numeric(10) NULL,
	sqltext text NULL,
	paramcal varchar(200) NULL,
	sqlparams varchar(2000) NULL,
	accessstring varchar(500) NULL,
	groupname varchar(50) NULL,
	sqlquerycols varchar(4000) NULL,
	cachedata varchar(1) NULL,
	cacheinterval varchar(10) NULL,
	encryptedflds varchar(4000) NULL,
	adsdesc text NULL,
	CONSTRAINT aglaxdirectsqlid PRIMARY KEY (axdirectsqlid)
);

ALTER TABLE {schema}.axdirectsql ADD COLUMN IF NOT EXISTS cachedata varchar(1) NULL;

ALTER TABLE {schema}.axdirectsql ADD COLUMN IF NOT EXISTS cacheinterval varchar(10) NULL;

ALTER TABLE {schema}.axdirectsql ADD COLUMN IF NOT EXISTS encryptedflds varchar(4000) NULL;

ALTER TABLE {schema}.axdirectsql ADD COLUMN IF NOT EXISTS adsdesc text NULL;

CREATE TABLE IF NOT EXISTS {schema}.axdirectsql_metadata (
	axdirectsql_metadataid numeric(16) NOT NULL,
	axdirectsqlid numeric(16) NULL,
	axdirectsql_metadatarow int4 NULL,
	fldname varchar(100) NULL,
	fldcaption varchar(100) NULL,
	"normalized" varchar(3) NULL,
	sourcetable varchar(50) NULL,
	sourcefld varchar(50) NULL,
	CONSTRAINT aglaxdirectsql_metadataid PRIMARY KEY (axdirectsql_metadataid)
);

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS tbl_normalizedsource varchar(2000) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS tbl_hyperlink varchar(8000) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS hyp_struct varchar(500) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS hyp_structtype varchar(20) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS hyp_transid varchar(100) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS datatypeui varchar(20) NULL;

ALTER TABLE {schema}.axdirectsql_metadata ADD COLUMN IF NOT EXISTS fdatatype varchar(2) NULL;

-- axdirectsql UPDATE

UPDATE {schema}.axdirectsql SET sqlname='axi_smartlist_ads_metadata', sqltext='select
	a1.sqlname,
	a1.sqltext,
	a1.sqlparams,
	a1.sqlquerycols,
	a1.encryptedflds,
	a1.cachedata,
	a1.cacheinterval,
	b.fldname,
	b.fldcaption,
	b."normalized" ,
	b.sourcetable ,
	b.sourcefld ,
	hl.hyp_structtype,
	hl.hyp_transid,
	hl.tbl_hyperlink,hl.hyp_inline,
	case
		when lower(sqltext) like ''%--axp_filter%'' then ''T''
		else ''F''
	end as filters
from {schema}.axdirectsql a1
join axpdef_smartlist a on a1.sqlname = a.adsname
join axpdef_smartlist_mdata b on a.axpdef_smartlistid =b.axpdef_smartlistid
left join(select axpdef_smartlistid,hfldname,hyp_structtype,hyp_transid, tbl_hyperlink,hyp_inline from axpdef_smartlist_hlink)hl
on hl.axpdef_smartlistid=a.axpdef_smartlistid and b.fldname = hl.hfldname
where a.adsname = :adsname
order by b.axpdef_smartlist_mdatarow ' WHERE sqlname='axi_smartlist_ads_metadata';

-- axdirectsql INSERT

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990001, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_jobnameslist', NULL, 'Metadata', 5, 'select jname as displaydata from axpdef_jobs', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990002, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_formnotifylist', NULL, 'Metadata', 5, 'select form as displaydata,stransid name from axformnotify', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990003, 'F', 0, NULL, 'admin', '2025-12-24 19:34:05.000', 'admin', '2025-12-24 19:34:05.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_userlist', NULL, 'Metadata', 5, 'select username as displaydata from axusers', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990004, 'F', 0, NULL, 'admin', '2025-12-23 20:50:43.000', 'admin', '2025-12-23 20:50:43.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_fieldvaluelist', NULL, 'Metadata', 5, 'SELECT * FROM {schema}.get_dynamic_field(:param1, :param2) as displaydata;', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990005, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_tstructlist', NULL, 'Metadata', 5, 'select caption||'' (''||name||'')'' displaydata, caption, name from tstructs', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990006, 'F', 0, NULL, 'admin', '2025-12-22 14:31:09.000', 'admin', '2025-12-20 16:20:58.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_adslist', NULL, 'Metadata', 5, 'select sqlname||'' (''||sqlsrc||'')'' displaydata,sqlname name,sqlsrc  from {schema}.axdirectsql a', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990007, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_apinameslist', NULL, 'Metadata', 5, 'select execapidefname as displaydata from executeapidef', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990008, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_iviewlist', NULL, 'Metadata', 5, 'select caption||'' (''||name||'')'' displaydata, caption, name from Iviews', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990009, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_pegnotifylist', NULL, 'Metadata', 5, 'select name as displaydata from axnotificationdef', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990010, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_rulenameslist', NULL, 'Metadata', 5, 'select rulename as displaydata from axpdef_ruleeng', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990011, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_schedulenotifylist', NULL, 'Metadata', 5, 'select name as displaydata from axperiodnotify', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990012, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_peglist', NULL, 'Metadata', 5, 'select caption as displaydata from axpdef_peg_processmaster', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990013, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_actorlist', NULL, 'Metadata', 5, 'select actorname as displaydata from axpdef_peg_actor', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990014, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_cardlist', NULL, 'Metadata', 5, 'select cardname as displaydata from axp_cards', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990015, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_printformlist', NULL, 'Metadata', 5, 'select template_name as displaydata from ax_configure_fast_prints', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990016, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_servernamelist', NULL, 'Metadata', 5, 'select servername as displaydata from dwb_publishprops', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990017, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_usergrouplist', NULL, 'Metadata', 5, 'select users_group_name as displaydata from axpdef_usergroups', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990018, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_rolelist', NULL, 'Metadata', 5, 'select groupname as displaydata from axusergroups', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990019, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_dimensionlist', NULL, 'Metadata', 5, 'select grpcaption ||'' ('' || grpname ||'')'' as displaydata, grpname as caption,grpname as name from axgroupingmst order by grpcaption asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990020, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_pagelist', NULL, 'Metadata', 5, 'select caption as displaydata,props as requesturl from axpages where pagetype = ''web''', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990021, 'F', 0, NULL, 'admin', '2025-12-23 13:35:16.000', 'admin', '2025-12-22 16:01:14.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_keyfieldlist', NULL, 'Metadata', 5, 'SELECT keyfield FROM (SELECT keyfield, 1 AS priority, NULL AS modeofentry, NULL AS allowduplicate, NULL AS datatype, NULL AS ordno FROM {schema}.axp_tstructprops WHERE name = :param1 UNION ALL SELECT fname AS keyfield, 2 AS priority, modeofentry, allowduplicate, datatype, ordno FROM axpflds WHERE tstruct = :param1 and dcname = ''dc1'' AND (modeofentry = ''autogenerate'' OR ((LOWER(allowduplicate) = ''f'' OR datatype = ''c'') AND LOWER(hidden) = ''f''))) t ORDER BY priority, CASE WHEN modeofentry = ''autogenerate'' THEN 1 WHEN LOWER(allowduplicate) = ''f'' THEN 2 WHEN datatype = ''c'' THEN 3 ELSE 4 END, ordno ASC LIMIT 1', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990022, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_viewlist', NULL, 'Metadata', 5, 'SELECT * FROM {schema}.axi_fn_getaxobjectlist(:param1)', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990023, 'F', 0, NULL, 'admin', '2026-01-30 00:00:00.000', 'admin', '2026-01-30 00:00:00.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_smartlist_ads_metadata', NULL, 'Metadata', 0, 'select a.sqlname,a.sqltext,a.sqlparams, a.sqlquerycols,a.encryptedflds,a.cachedata,a.cacheinterval, b.fldname,b.fldcaption,b."normalized" ,b.sourcetable ,b.sourcefld ,hyp_structtype,b.hyp_transid, b.tbl_hyperlink, CASE WHEN lower(sqltext) LIKE ''%--axp_filter%'' THEN ''T'' ELSE ''F'' END AS filters from {schema}.axdirectsql a left join {schema}.axdirectsql_metadata b on a.axdirectsqlid =b.axdirectsqlid where sqlname = :adsname', 'adsname', 'adsname~Character~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990024, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_fieldvalueswithkeysuffixlist', NULL, 'Metadata', 5, 'select * from {schema}.fn_axi_get_fieldvalues_with_keysuffix_list(:param1, :param2)', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990025, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_keyvalueswithfieldnameslist', NULL, 'Metadata', 5, 'select * from {schema}.fn_axi_getkeyvalueswithfieldnameslist(:param1, :param2)', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990026, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_tstructprops_insupd', NULL, 'Metadata', 5, 'select * from {schema}.fn_upsert_config_by_condition(:param1,:param2,:param3,:param4)', 'param1,param2,param3,param4', 'param1~~,param2~~,param3~~,param4~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990027, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_adsfilteroperators', NULL, 'Metadata', 5, 'SELECT ''='' AS displaydata, ''='' AS name UNION ALL SELECT ''<'',''<'' UNION ALL SELECT ''>'',''>'' UNION ALL SELECT ''<='',''<='' UNION ALL SELECT ''>='',''>='' UNION ALL SELECT ''between'',''between''', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990028, 'F', 0, NULL, 'admin', '2026-01-30 00:00:00.000', 'admin', '2026-01-30 00:00:00.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_adscolumnlist', NULL, 'Metadata', 0, 'select b.fldcaption || ''(''||b.fldname||'')'' displaydata,b.fldname name,b.fldcaption caption,b.normalized,b.fdatatype, b.sourcetable,b.sourcefld , CASE WHEN lower(sqltext) LIKE ''%--axp_filter%'' THEN ''T'' ELSE ''F'' END AS filters from {schema}.axdirectsql a left join {schema}.axdirectsql_metadata b on a.axdirectsqlid =b.axdirectsqlid where sqlname = :param1', 'param1', 'param1~Character~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990029, 'F', 0, NULL, 'admin', '2025-12-23 13:35:16.000', 'admin', '2025-12-22 16:01:14.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_fieldlist', NULL, 'Metadata', 5, 'select caption||'' (''||fname||'')'' displaydata, caption, fname name, tstruct,substring(modeofentry,1,1) moe,"datatype",fldsql,dcname,asgrid,listvalues fromlist,srckey normalized from axpflds where tstruct = :param1 and dcname = ''dc1'' and hidden = ''F'' and modeofentry in (''accept'',''select'')and savevalue = ''T'' and "datatype" <> ''i'' order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990030, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_adsdropdowntokens', NULL, 'Metadata', 5, 'select * from {schema}.get_ads_dropdown_data(:param1,:param2)', 'param1,param2', 'param1~~,param2~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990031, 'F', 0, NULL, 'admin', '2025-12-23 13:35:16.000', 'admin', '2025-12-22 16:01:14.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_setfieldlist', NULL, 'Metadata', 5, 'select caption||'' (''||fname||'')'' displaydata, caption, fname name, tstruct,substring(modeofentry,1,1) moe,"datatype",fldsql sql from axpflds where tstruct = :param1 and dcname = ''dc1'' and hidden = ''F'' and savevalue = ''T'' and modeofentry in (''accept'',''select'') and "datatype" <> ''i'' order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990032, 'F', 0, NULL, 'admin', '2025-12-24 19:34:05.000', 'admin', '2025-12-24 19:34:05.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_analyticslist', NULL, 'Metadata', 5, 'SELECT t.caption || '' ('' || t.name || '')'' AS displaydata,t.caption,t.name FROM tstructs t JOIN ax_userconfigdata u ON t.name = ANY (string_to_array(u.value, '','')) WHERE Upper(u.page) = ''ANALYTICS'' and Upper(u.keyname) = ''ENTITIES'' AND (u.username = :param1 OR u.username = ''All'')', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990033, 'F', 0, NULL, 'admin', '2025-12-23 20:50:43.000', 'admin', '2025-12-23 20:50:43.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_firesql', NULL, 'Metadata', 5, 'select * from {schema}.axi_firesql_v2(:param1,:param2,:param3,:param4)', 'param1,param2,param3,param4', 'param1~~,param2~~,param3~~,param4~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990034, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_userpwd', NULL, 'Metadata', 5, 'select password  from axusers where username = :param1', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990035, 'F', 0, NULL, 'admin', '2025-12-23 13:35:16.000', 'admin', '2025-12-22 16:01:14.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_primaryfieldlist', NULL, 'Metadata', 5, 'SELECT caption||'' (''||fname||'')'' displaydata, caption, fname name FROM axpflds WHERE tstruct = :param1 and dcname = ''dc1'' AND (modeofentry = ''autogenerate'' OR ((LOWER(allowduplicate) = ''f'' OR datatype = ''c'') AND LOWER(hidden) = ''f'')) order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990036, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_structlist', NULL, 'Metadata', 5, 'select * from {schema}.axi_fn_getstructlist(:param1,:param2,:param3)', 'param1,param2,param3', 'param1~~,param2~~,param3~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990037, 'F', 0, NULL, 'admin', '2025-12-23 13:35:16.000', 'admin', '2025-12-22 16:01:14.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_nongridfieldlist', NULL, 'Metadata', 5, 'select caption||'' (''||fname||'')'' displaydata, caption, fname name, tstruct,substring(modeofentry,1,1) moe,"datatype",fldsql,dcname,asgrid,listvalues fromlist,srckey normalized from axpflds where tstruct = :param1 and asgrid = ''F'' and hidden = ''F'' and modeofentry in (''accept'',''select'')and savevalue = ''T'' and "datatype" <> ''i'' order by ordno asc', 'param1', 'param1', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990038, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_structmetalist', NULL, 'Metadata', 5, 'SELECT * from {schema}.fn_axi_getstructures_meta(:param1,:param2,:param3,:param4,:param5)', 'param1,param2,param3,param4,param5', 'param1~~,param2~~,param3~~,param4~~,param5~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990039, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_getstructsdata', NULL, 'Metadata', 5, 'select * from {schema}.fn_axi_getstructs_obj(:param1, :param2, :param3, :param4, :param5, :param6, :param7, :param8, :param9, :param10)', 'param1,param2,param3,param4,param5,param6,param7,param8,param9,param10', 'param1~~,param2~~,param3~~,param4~~,param5~~param6~~,param7~~,param8~~,param9~~,param10~~', 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990040, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_resposibilitylist', NULL, 'Metadata', 5, 'select distinct rname displaydata, rname caption, rname name from axuseraccess order by rname', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990041, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_newsandannounce', NULL, 'Metadata', 5, 'select title as displaydata,title as caption,title as name from axpdef_news_events order by title asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990042, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_publishapi', NULL, 'Metadata', 5, 'select publickey || '' '' || ''(''||apitype||'')'' as displaydata,publickey caption,publickey name from axpdef_publishapi  order by publickey asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990043, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_jobs', NULL, 'Metadata', 5, 'select jname || '' ('' || jobid ||'')'' as displaydata, jobid as caption,jobid as name from axpdef_jobs order by jname asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990044, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_language', NULL, 'Metadata', 5, 'select language as displaydata, language as caption from axpdef_language order by language asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990045, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_customtype', NULL, 'Metadata', 5, 'select typename || '' (''||datatype||'')'' as displaydata,typename as caption,typename as name from axp_customdatatype order by typename asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990046, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_emaildef', NULL, 'Metadata', 5, 'select emaildefname || '' (''||emailwhat||'')'' as displaydata,emaildefname as caption,emaildefname as name from emaildef order by emaildefname asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990047, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_tabledesc', NULL, 'Metadata', 5, 'select dname as displaydata,dname as caption from axp_tabledescriptor order by dname asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990048, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_inbound', NULL, 'Metadata', 5, 'select axqueuename as displaydata,axqueuename as caption from AxInQueues order by axqueuename asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990049, 'F', 0, NULL, 'admin', '2025-12-23 13:22:07.000', 'admin', '2025-12-19 16:06:57.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_outbound', NULL, 'Metadata', 5, 'select axqueuename as displaydata,axqueuename as caption from AxOutQueuesmst order by axqueuename asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

INSERT INTO {schema}.axdirectsql
(axdirectsqlid, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, sqlname, ddldatatype, sqlsrc, sqlsrccnd, sqltext, paramcal, sqlparams, accessstring, groupname, sqlquerycols, cachedata, cacheinterval, encryptedflds, adsdesc, smartlistcnd)
VALUES(99999999990050, 'F', 0, NULL, 'admin', '2025-12-24 19:34:05.000', 'admin', '2025-12-24 19:34:05.000', NULL, 1, 1, NULL, NULL, NULL, 'axi_useractivation', NULL, 'Metadata', 5, 'select pusername as displaydata from axuseractivations order by pusername asc', NULL, NULL, 'ALL', NULL, NULL, 'F', '6 Hr', NULL, NULL, NULL);

-- ============================================================================
-- Section: axi_command_tables.sql
-- ============================================================================

DROP TABLE IF EXISTS {schema}.axi_commands;

DROP TABLE IF EXISTS {schema}.axi_command_prompts;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS {schema}.axi_commands (
	cmdtoken int4 NOT NULL,
	command_group varchar(50) NOT NULL,
	command varchar(50) NOT NULL,
	active varchar(1) NULL DEFAULT 'T'::character varying,
	CONSTRAINT axi_commands_pkey PRIMARY KEY (cmdtoken)
);

CREATE TABLE IF NOT EXISTS {schema}.axi_command_prompts (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	cmdtoken int4 NULL,
	wordpos int4 NULL,
	prompt varchar(200) NULL,
	promptsource varchar(500) NULL,
	promptparams varchar(100) NULL,
	promptvalues varchar(500) NULL,
	props varchar(100) NULL,
	extraparams varchar(1000) NULL,
	requesturl varchar(2000) NULL,
	CONSTRAINT axi_command_prompts_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS {schema}.axp_tstructprops (
	"name" varchar(5) NULL,
	caption varchar(500) NULL,
	keyfield varchar(200) NULL,
	userconfigured bpchar(1) NULL,
	createdon varchar(30) NULL,
	updatedon varchar(30) NULL,
	createdby varchar(100) NULL,
	updatedby varchar(100) NULL
);

--axi_commands starts here

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(1, 'Create', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(2, 'Edit', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(3, 'View', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(4, 'Configure', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(5, 'Upload', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(6, 'Download', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(7, 'DevTools', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(9, 'Run', '', 'T');

INSERT INTO {schema}.axi_commands
(cmdtoken, command_group, command, active)
VALUES(10, 'Analyse', '', 'T');

--axi_command_prompts starts here

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('b767f878-6f6f-4d72-8a52-f987d5dc9064'::uuid, 1, 2, 'tstruct name', 'axi_structmetalist', NULL, NULL, NULL, ':username,:userroles,:userresp,:mode,:structtype', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('8faae04b-af25-4be7-b97c-de72815255f4'::uuid, 2, 2, 'tstruct name', 'axi_structmetalist', NULL, NULL, NULL, ':username,:userroles,:userresp,:mode,:structtype', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('29ce28d9-72f1-41ff-b872-faf9107774b6'::uuid, 2, 3, 'search value', 'axi_getstructsdata', '', NULL, NULL, ':cmd,:username,:userrole,:transid,:selectedfield,:dimension,:permission,:keyfield,:primarytable,:globalvars', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('8faae04b-af25-4be7-b97c-de72815267f5'::uuid, 2, 4, 'object name', 'axi_getstructsdata', '', NULL, NULL, ':cmd,:username,:userrole,:transid,:selectedfield,:dimension,:permission,:keyfield,:primarytable,:globalvars', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('7faae15b-af25-4be7-b86c-de73925267f5'::uuid, 2, 5, 'with values', '', '', 'With', NULL, '', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('b878f939-6f7f-4d72-8a78-f912d5dc9669'::uuid, 2, 6, 'field name', 'axi_nongridfieldlist', '2', NULL, NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('46647ef0-f107-4551-8379-3b844d430016'::uuid, 3, 2, 'object name', 'axi_structmetalist', NULL, 'Tstruct,Iview,Ads,Page', NULL, ':username,:userroles,:userresp,:mode,:structtype', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('46d7bb0e-12e4-4249-b508-f9e824717957'::uuid, 3, 3, 'search value', 'axi_getstructsdata,axi_dummylist,axi_adscolumnlist,axi_dummylist', '', NULL, NULL, ':cmd,:username,:userrole,:transid,:selectedfield,:dimension,:permission,:keyfield,:primarytable,:globalvars', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('8faae09b-af52-4be8-b97c-de72815276f4'::uuid, 3, 4, 'object name', 'axi_getstructsdata', '', NULL, NULL, ':cmd,:username,:userrole,:transid,:selectedfield,:dimension,:permission,:keyfield,:primarytable,:globalvars', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('10655119-ba93-42e8-8aef-0aefccae5a80'::uuid, 4, 2, 'object type', '', NULL, 'PEG,Form Notification,Scheduled Notification,Peg Form Notification,Rule,KeyField,News And Announcement,User,Users,User Permission,User Permissions,User Activation,User Group,Role,Roles,Role Permissions,Actor,Actors,Publish Axpert API,Publish Config Studio,Card,Responsibility,Responsibilities,Dimension,Application Properties,Settings', NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('0f99d918-0caa-4523-9260-f18b5bd162bf'::uuid, 4, 3, 'object name', 'Axi_PegList,Axi_FormNotifyList,Axi_ScheduleNotifyList,Axi_PEGNotifyList,Axi_RuleNamesList,axi_structlist,axi_newsandannounce,Axi_Dummy,Axi_Dummy,axi_userlist,axi_userlist,axi_useractivation,axi_usergrouplist,Axi_Dummy,Axi_Dummy,axi_rolelist,axi_actorlist,Axi_Dummy,axi_publishapi,Axi_ServernameList,axi_cardlist,axi_resposibilitylist,Axi_Dummy,axi_dimensionlist,Axi_Dummy,Axi_Dummy', NULL, '', NULL, ':userresp,:mode,:structtype', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('0f67d918-0caa-4523-9260-f18b5bd982fb'::uuid, 4, 4, 'key field', 'axi_primaryfieldlist', '3', '', NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('b148e471-7ace-49e7-a7ab-16d3338908cf'::uuid, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('3ddb84e6-6e76-48c8-8dd5-4d46fc4f9542'::uuid, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('369efe5f-7e05-4b00-b2fd-10fae4bd3f72'::uuid, 7, 2, 'type', NULL, NULL, 'Tstruct,Iview,Axpert Data Sources,Page,Arrange Menu,Dev Option,App Variables,Db Explorer,API Plugin,Axpert Job,Language,Publish,Custom Data Type,Email Definition,Table Field Descriptor,Custom Plugin,Queue Listing,Out Bound Queue,In Bound Queue,Mem DB Console', NULL, NULL, NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('4aa86d11-a357-4ba1-ab1d-b4251676ba8f'::uuid, 7, 3, 'name', 'axi_structmetalist,axi_structmetalist,axi_structmetalist,axi_structmetalist,Axi_Dummy,Axi_Dummy,Axi_Dummy,Axi_Dummy,Axi_APINamesList,axi_jobs,axi_language,Axi_Dummy,axi_customtype,axi_emaildef,axi_tabledesc,Axi_Dummy,Axi_Dummy,axi_outbound,axi_inbound,Axi_Dummy', NULL, NULL, NULL, ':username,:userroles,:userresp,:mode,:structtype', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('8fbbe05b-af25-4be7-b97c-de71825267f6'::uuid, 8, 2, 'field name', 'Axi_SetFieldList', NULL, NULL, NULL, ':transid', NULL);

INSERT INTO {schema}.axi_command_prompts
(id, cmdtoken, wordpos, prompt, promptsource, promptparams, promptvalues, props, extraparams, requesturl)
VALUES('8fbbe05b-af25-4be7-b97c-de71825267f7'::uuid, 10, 2, 'entity name', 'axi_structmetalist', NULL, NULL, NULL, ':username,:userroles,:userresp,:mode,:structtype', NULL);

-- ============================================================================
-- Section: axi_dependent_tables.sql
-- ============================================================================

CREATE TABLE IF NOT EXISTS {schema}.Axi_UserFavourites (
    Id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    UserName VARCHAR(255) NOT NULL,
    CommandText TEXT NOT NULL,
    TargetURL VARCHAR(4000) NOT NULL,
    FavOrder INT,
    CreatedOn TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_user_command UNIQUE (UserName, CommandText)
);

ALTER TABLE {schema}.axi_userfavourites ADD COLUMN IF NOT EXISTS originalcommandtext varchar(500) NULL;

CREATE TABLE IF NOT EXISTS {schema}.axiconfig (axienabled varchar(1), mainpagetemplate varchar(255));

INSERT INTO {schema}.axiconfig (axienabled, mainpagetemplate) VALUES ('T','AxiCMDMainPage.html');

-- ============================================================================
-- Section: axi_functions.sql
-- ============================================================================

DROP FUNCTION IF EXISTS {schema}.fn_axi_get_fieldvalues_with_keysuffix_list;

DROP FUNCTION IF EXISTS {schema}.fn_axi_getkeyvalueswithfieldnameslist;

DROP FUNCTION IF EXISTS {schema}.fn_upsert_config_by_condition;

DROP FUNCTION IF EXISTS {schema}.get_ads_dropdown_data;

DROP FUNCTION IF EXISTS {schema}.get_dynamic_field;

DROP FUNCTION IF EXISTS {schema}.populate_axdirectsql_metadata;

DROP FUNCTION IF EXISTS {schema}.fn_axi_metadata;

DROP FUNCTION IF EXISTS {schema}.fn_axi_struct_metadata;

DROP FUNCTION IF EXISTS {schema}.axi_firesql_v2;

DROP FUNCTION IF EXISTS {schema}.axi_fn_getstructlist;

DROP FUNCTION IF EXISTS {schema}.axi_fn_getaxobjectlist;

DROP FUNCTION IF EXISTS {schema}.fn_axi_getstructures_meta;

DROP FUNCTION IF EXISTS {schema}.fn_permissions_getpermission;

DROP FUNCTION IF EXISTS {schema}.fn_axi_getstructs_obj;

CREATE OR REPLACE FUNCTION {schema}.fn_axi_get_fieldvalues_with_keysuffix_list
(
    p_tstruct text,
    p_fieldname text
) 
RETURNS TABLE(displaydata text, id text, caption text) 
LANGUAGE plpgsql AS
$function$
DECLARE 
    v_sql text; 
    v_tablename text; 
    v_sourcekey text; 
    v_srcfld text; 
    v_srctf text; 
    v_keyfield text; 
BEGIN 
    p_fieldname := lower(p_fieldname);
    SELECT keyfield INTO v_keyfield 
    FROM {schema}.axp_tstructprops 
    WHERE name = p_tstruct 
    LIMIT 1; 
    IF v_keyfield IS NULL THEN 
        SELECT fname INTO v_keyfield
        FROM axpflds
        WHERE tstruct = p_tstruct
          AND dcname = 'dc1'
        ORDER BY
            CASE 
                WHEN modeofentry = 'autogenerate' THEN 1
                WHEN LOWER(allowduplicate) = 'f' 
                     AND LOWER(allowempty) = 'f' 
                     AND datatype = 'c' 
                     AND LOWER(hidden) = 'f' THEN 2
                WHEN LOWER(hidden) = 'f'
                     AND datatype = 'c' THEN 3
                ELSE 4
            END,
            ordno ASC
        LIMIT 1;
    END IF; 
    SELECT tablename INTO v_tablename 
    FROM axpdc 
    WHERE tstruct = p_tstruct 
      AND dname = 'dc1'; 
    SELECT srckey, srcfld, srctf INTO v_sourcekey, v_srcfld, v_srctf 
    FROM axpflds 
    WHERE tstruct = p_tstruct 
      AND lower(fname) = lower(p_fieldname); 
    IF v_keyfield IS NULL
       OR v_tablename IS NULL
       OR v_sourcekey IS NULL THEN
        RETURN;
    END IF;
    IF v_sourcekey = 'F' THEN
        v_sql := format(
            'SELECT (%I || ''['' || %I || '']'')::text AS displaydata,
                    ''0''::text AS id,
                    %I::text AS caption
             FROM %I
             WHERE %I IS NOT NULL
             ORDER BY displaydata ASC',
            p_fieldname,
            v_keyfield,
            v_keyfield,
            v_tablename,
            p_fieldname
        );
    ELSE
           v_sql := format(
			'SELECT (s.%I || ''['' || t.%I || '']'')::text AS displaydata,
					s.%I::text AS id,
					t.%I::text AS caption
			 FROM %I s
			 JOIN %I t ON s.%I = t.%I
			 WHERE s.%I IS NOT NULL
			 ORDER BY displaydata ASC',
			v_srcfld,                -- s.source field
			v_keyfield,              -- t.key field
			lower(v_srctf) || 'id',  -- caption field 
			v_keyfield,              -- id from key table -- caption field
			lower(v_srctf),          -- main table
			v_tablename,             -- key table
			--lower(v_srctf) || 'id',  -- join column in main table
			lower(v_srctf) || 'id',  -- join column in key table (adjust if different)
			p_fieldname,
			--p_fieldname              -- not null field from main table
			v_srcfld
		);
    END IF;
    RETURN QUERY EXECUTE v_sql; 
END; 
$function$;

CREATE OR REPLACE FUNCTION {schema}.fn_axi_getkeyvalueswithfieldnameslist(p_tstruct text, p_fieldname text)
 RETURNS TABLE(displaydata text, id text, caption text, isfield text)
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_sql        text;
  v_tablename  text;
  v_sourcekey  text;
  v_srcfld     text;
  v_srctf      text;
  v_keyfield   text;
BEGIN
    SELECT keyfield
    INTO v_keyfield
    FROM {schema}.axp_tstructprops
    WHERE lower(name) = lower(p_tstruct)
    LIMIT 1;
    IF v_keyfield IS NULL then
        SELECT fname INTO v_keyfield
        FROM axpflds
        WHERE lower(tstruct) = lower(p_tstruct)
          AND dcname = 'dc1'
        ORDER BY
            CASE 
                WHEN modeofentry = 'autogenerate' THEN 1
                WHEN LOWER(allowduplicate) = 'f' 
                     AND LOWER(allowempty) = 'f' 
                     AND datatype = 'c' 
                     AND LOWER(hidden) = 'f' THEN 2
                WHEN LOWER(hidden) = 'f'
                     AND datatype = 'c' THEN 3
                ELSE 4
            END,
            ordno ASC
        LIMIT 1;
    END IF;
  SELECT tablename
  INTO v_tablename
  FROM axpdc
  WHERE tstruct = p_tstruct
    AND dname = 'dc1';
  SELECT srckey, srcfld, srctf
  INTO v_sourcekey, v_srcfld, v_srctf
  FROM axpflds
  WHERE lower(tstruct) = lower(p_tstruct)
    AND lower(fname)   = lower(p_fieldname);
 IF v_keyfield IS NULL THEN
    RAISE EXCEPTION 'Key field could not be determined for tstruct %', p_tstruct;
END IF;
IF v_tablename IS NULL THEN
    RAISE EXCEPTION 'Base table not found for tstruct %', p_tstruct;
END IF;
IF v_sourcekey IS NULL THEN
    RAISE EXCEPTION 'Source metadata not found for field % in tstruct %',
        p_fieldname, p_tstruct;
END IF;
IF v_sourcekey <> 'F' AND (v_srcfld IS NULL OR v_srctf IS NULL) THEN
    RAISE EXCEPTION 'Source table/field missing for field % in tstruct %',
        p_fieldname, p_tstruct;
END IF;
--Need to remove lowercase convertion , currently axpflds takes user entered mixed case
--but db tables have lowercase fieldnames, this cuases issue with dynamic sql , so added lower()
p_fieldname = lower(p_fieldname);
v_keyfield = lower(v_keyfield);
IF v_sourcekey = 'F' THEN
    v_sql := format(
    $sql$
    SELECT (%I)::text AS displaydata,
           '0'::text AS id,
           %I::text AS caption,
           'f'::text AS isfield
    FROM %I
    WHERE %I IS NOT NULL
    UNION ALL
    SELECT (caption || ' (' || fname || ')' || ' [' || 'field' || ']')::text AS displaydata,
           '0'::text AS id,
           caption::text AS caption,
           't'::text AS isfield  
    FROM axpflds
    WHERE tstruct = %L
      AND lower(hidden) = 'f'
      AND lower(savevalue) = 't'
	  AND lower(asgrid) = 'f'
    ORDER BY isfield ASC, displaydata ASC
    $sql$,
    p_fieldname,
    v_keyfield,
    v_tablename,
    p_fieldname,
    p_tstruct
);
ELSE
    v_sql := format(
    $sql$
    SELECT (%I)::text AS displaydata,
           %I::text AS id,
           %I::text AS caption,
           'f'::text AS isfield
    FROM %I
    WHERE %I IS NOT NULL
    UNION ALL
    SELECT (caption || ' (' || fname || ') [' || 'field' || ']')::text AS displaydata,
           '0'::text AS id,
           caption::text AS caption,
           't'::text AS isfield
    FROM axpflds
    WHERE tstruct = %L
      AND lower(hidden) = 'f'
      AND lower(savevalue) = 't'
	  AND lower(asgrid) = 'f'
    ORDER BY isfield ASC, displaydata ASC
    $sql$,
    v_srcfld,
    lower(v_srctf) || 'id',
    v_keyfield,
    lower(v_srctf),
    p_fieldname,
    p_tstruct
);
END IF;
  RETURN QUERY EXECUTE v_sql;
END;
$function$;

CREATE OR REPLACE FUNCTION {schema}.fn_upsert_config_by_condition(
    p_tablename      text,
    p_fieldnames     text,
    p_fieldvalues    text,
    p_where_clause   text
)
RETURNS TABLE(status text)
LANGUAGE plpgsql
AS $function$
DECLARE
    v_exists     boolean;
    v_set_clause text;
    v_cols_arr   text[];
    v_vals_arr   text[];
BEGIN
    v_cols_arr := string_to_array(p_fieldnames, ',');
    v_vals_arr := string_to_array(p_fieldvalues, ',');
    IF array_length(v_cols_arr, 1)
       IS DISTINCT FROM
       array_length(v_vals_arr, 1) THEN
        RAISE EXCEPTION
            'Field names and values count mismatch';
    END IF;
    SELECT string_agg(
               format('%I=%s', trim(col), trim(val)),
               ', '
           )
    INTO v_set_clause
    FROM unnest(v_cols_arr, v_vals_arr) AS t(col, val)
    WHERE col IS NOT NULL
      AND trim(col) <> '';
    EXECUTE format(
        'SELECT EXISTS (SELECT 1 FROM %I WHERE %s)',
        p_tablename,
        p_where_clause
    )
    INTO v_exists;
    IF v_exists THEN
        EXECUTE format(
            'UPDATE %I SET %s WHERE %s',
            p_tablename,
            v_set_clause,
            p_where_clause
        );
    ELSE
        EXECUTE format(
            'INSERT INTO %I (%s) VALUES (%s)',
            p_tablename,
            p_fieldnames,
            p_fieldvalues
        );
    END IF;
END;
$function$;

CREATE OR REPLACE FUNCTION {schema}.get_ads_dropdown_data(
    p_tablename  TEXT,
    p_fieldname  TEXT
)
RETURNS TABLE (
    displaydata TEXT,
    name        TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY EXECUTE format(
        'SELECT %I::text AS displaydata, %I::text AS name FROM %I',
        p_fieldname,
        p_fieldname,
        p_tablename
    );
END;
$$;

CREATE OR REPLACE FUNCTION {schema}.get_dynamic_field(p_tstruct text, p_fieldname text)
 RETURNS TABLE(displaydata text, id text)
 LANGUAGE plpgsql
AS $function$
DECLARE
  v_sql        text;
  v_tablename  text;
  v_sourcekey  text;
  v_srcfld     text;
  v_srctf      text;
BEGIN
  SELECT tablename
  INTO v_tablename
  FROM axpdc
  WHERE tstruct = p_tstruct
    AND dname = 'dc1';
  SELECT srckey, srcfld, srctf
  INTO v_sourcekey, v_srcfld, v_srctf
  FROM axpflds
  WHERE tstruct = p_tstruct
    AND fname   = p_fieldname;
  IF v_sourcekey = 'F' THEN
    v_sql := format(
      'SELECT %I::text, ''0''::text AS id FROM %I',
      p_fieldname,
      v_tablename
    );
  ELSE
    v_sql := format(
      'SELECT %I::text AS displaydata, %I::text AS id FROM %I',
      v_srcfld,
      lower(v_srctf)||'id',
      lower(v_srctf)
    );
  END IF;
  RETURN QUERY EXECUTE v_sql;
END;
$function$;

CREATE OR REPLACE FUNCTION {schema}.populate_axdirectsql_metadata()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
    cols TEXT;
    col TEXT;
    row_no INT;
BEGIN
    FOR r IN
        SELECT axdirectsqlid, sqltext
        FROM {schema}.axdirectsql
    LOOP
        cols :=
            substring(
                r.sqltext
                FROM '(?i)select\s+(.*?)\s+from'
            );
        row_no := 1;
        FOR col IN
            SELECT trim(value)
            FROM regexp_split_to_table(cols, ',') AS value
        LOOP
            IF col ~* '\s+as\s+' THEN
                col := regexp_replace(col, '.*\s+as\s+', '', 'i');
            ELSIF col ~ '\s' THEN
                col := split_part(col, ' ', array_length(string_to_array(col, ' '), 1));
            END IF;
            INSERT INTO {schema}.axdirectsql_metadata (
                axdirectsql_metadataid,
                axdirectsqlid,
                axdirectsql_metadatarow,
                fldname,
                fldcaption,
                normalized,
                datatypeui,
                fdatatype
            )
            VALUES (
                CAST(
                    '2' || lpad(nextval('{schema}.axdirectsql_metadata_seq')::text, 14, '0')
                    AS BIGINT
                ),
                r.axdirectsqlid,
                row_no,
                col,
                col,
                'F',
                'character',
                'c'
            );
            row_no := row_no + 1;
        END LOOP;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION {schema}.fn_axi_metadata(pstructtype character varying, pusername character varying)
 RETURNS TABLE(structtype text, caption text, transid character varying)
 LANGUAGE plpgsql
AS $function$
declare 
declare v_sql varchar;
begin
 if pstructtype='tstructs' then
  v_sql = 'select ''tstruct'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join tstructs t on a5.sname = t.name
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where t.blobno =1 and ag.username =$1
 union all
 select ''tstruct'',caption || ''-('' || name || '')'' cap,name
 from tstructs t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.blobno =1 and ag.username =$1
 union all
       SELECT ''tstruct'',caption || ''-('' || name || '')'' cap,name from tstructs t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.blobno =1';        
 elsif pstructtype='iviews' then
  v_sql = 'select ''iview'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join iviews t on a5.sname = t.name
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where t.blobno =1 and ag.username =$1
 union all
 select ''iview'',caption || ''-('' || name || '')'' cap,name
 from iviews t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.blobno =1 and ag.username =$1
 union all
       SELECT ''iview'',caption || ''-('' || name || '')'' cap,name from iviews t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.blobno =1';
elsif pstructtype='pages' then 
 v_sql = 'select ''page'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join axpages p on a5.sname = p.name and p.pagetype =''web''
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where ag.username =$1
 union all
 select ''page'',caption || ''-('' || name || '')'' cap,name
 from axpages t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.pagetype =''web'' and ag.username =$1
 union all
       SELECT ''page'',caption || ''-('' || name || '')'' cap,name from axpages t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.pagetype =''web''';   
elsif pstructtype='ads' then  
v_sql = 'select ''ADS'',sqlname::text,sqlname from {schema}.axdirectsql';
else
v_sql = 'select ''tstruct'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join tstructs t on a5.sname = t.name
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where t.blobno =1 and ag.username =$1
 union all
 select ''tstruct'',caption || ''-('' || name || '')'' cap,name
 from tstructs t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.blobno =1 and ag.username =$1
 union all
       SELECT ''tstruct'',caption || ''-('' || name || '')'' cap,name from tstructs t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.blobno =1
union all  
select ''iview'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join iviews t on a5.sname = t.name
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where t.blobno =1 and ag.username =$1
 union all
 select ''iview'',caption || ''-('' || name || '')'' cap,name
 from iviews t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.blobno =1 and ag.username =$1
 union all
       SELECT ''iview'',caption || ''-('' || name || '')'' cap,name from iviews t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.blobno =1
union all
select ''page'',caption || ''-('' || name || '')'' cap,name
 from axusergroups a3 join axusergroupsdetail a4 on a3.axusergroupsid = a4.axusergroupsid
 join axuseraccess a5 on a4.roles_id = a5.rname
 join axpages p on a5.sname = p.name and p.pagetype =''web''
 join axuserlevelgroups ag on a3.groupname = ag.usergroup 
 where ag.username =$1
 union all
 select ''page'',caption || ''-('' || name || '')'' cap,name
 from axpages t 
 join axuserlevelgroups ag on ag.usergroup =''default''
 where t.pagetype =''web'' and ag.username =$1
 union all
       SELECT ''page'',caption || ''-('' || name || '')'' cap,name from axpages t 
       JOIN axuserlevelgroups u on u.USERNAME = $1
     join axusergroups a ON a.groupname = u.usergroup 
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        where b.ROLES_ID =''default'' and t.pagetype =''web''
union all
select ''ADS'',sqlname::text,sqlname from {schema}.axdirectsql';
end if;
return query execute v_sql using pusername;
END; 
$function$;

CREATE OR REPLACE FUNCTION {schema}.fn_axi_struct_metadata(pstructtype character varying, ptransid character varying, pobjtype character varying)
 RETURNS TABLE(objtype character varying, objcaption text, objname character varying, dcname character varying, asgrid character varying)
 LANGUAGE plpgsql
AS $function$
declare 
declare v_sql varchar;
begin
 if pstructtype='tstruct' then
  if pobjtype = 'fields' then 
  v_sql = 'select ''Field''::varchar,caption||''(''||fname||'')'',fname,dcname,asgrid from axpflds where tstruct =$1';
  elsif pobjtype = 'genmaps' then 
  v_sql = 'select ''Genmap''::varchar,caption||''(''||gname||'')'',gname,null::varchar,null::varchar from axpgenmaps where tstruct =$1';
  elsif pobjtype = 'mdmaps' then 
  v_sql = 'select ''MDmap''::varchar,caption||''(''||mname||'')'',mname,null::varchar,null::varchar from axpmdmaps where tstruct =$1';  
  end if;
 elsif pstructtype='iview' then
  if pobjtype = 'columns' then
  v_sql = 'select ''Column''::varchar,f_caption||''(''||f_name||'')'',f_name,null::varchar,null::varchar from iviewcols where iname =$1';  
  elsif pobjtype = 'params' then
  v_sql = 'select ''Param''::varchar,pcaption||''(''||pname||'')'',pname,null::varchar,null::varchar from iviewparams where iname =$1';  
  end if; 
end if;
return query execute v_sql using ptransid;
END; 
$function$;

CREATE OR REPLACE FUNCTION {schema}.axi_firesql_v2(
    p_sql TEXT,
    p_param_string TEXT,
    p_sourcekey TEXT,
    p_fromlist TEXT
)
RETURNS TABLE (
    id TEXT,
    displaydata TEXT
)
LANGUAGE plpgsql
AS
$$
DECLARE
    v_sql TEXT := p_sql;
    v_pair TEXT;
    v_pairs TEXT[];
    v_param_name TEXT;
    v_param_value TEXT;
BEGIN
    IF p_param_string IS NOT NULL
       AND trim(p_param_string) <> ''
       AND position(':' IN v_sql) > 0
    THEN
        v_pairs := string_to_array(p_param_string, ';');

        FOREACH v_pair IN ARRAY v_pairs
        LOOP
            IF trim(v_pair) = '' THEN
                CONTINUE;
            END IF;

            v_param_name  := trim(split_part(v_pair, '~', 1));
            v_param_value := trim(split_part(v_pair, '~', 2));

            IF v_param_name <> '' THEN
                v_sql := replace(
                            v_sql,
                            ':' || v_param_name,
                            quote_literal(v_param_value)
                         );
            END IF;
        END LOOP;
    END IF;
    IF p_fromlist IS NOT NULL AND trim(p_fromlist) <> '' AND trim(p_fromlist) <> 'null' THEN

        RETURN QUERY EXECUTE
        'SELECT 
             ''0'' AS id,
             trim(value) AS displaydata
         FROM unnest(string_to_array(' || quote_literal(p_fromlist) || ', '','')) AS value
		 WHERE value IS NOT NULL
           AND trim(value) <> ''''';
    ELSE        
        IF upper(coalesce(p_sourcekey,'F')) = 'T' THEN

            RETURN QUERY EXECUTE
            'SELECT 
                 col1::text AS id,
                 trim(trailing ''.'' from trim(trailing ''0'' from col2::text)) AS displaydata
             FROM (
                 SELECT *
                 FROM (' || v_sql || ') q
             ) sub(col1, col2) WHERE col2 IS NOT NULL
               AND trim(col2::text) <> ''''';        
        ELSE

            RETURN QUERY EXECUTE
            'SELECT 
                 ''0'' AS id,
                 trim(trailing ''.'' from trim(trailing ''0'' from col1::text)) AS displaydata
             FROM (
                 SELECT *
                 FROM (' || v_sql || ') q
             ) sub(col1) WHERE col1 IS NOT NULL
               AND trim(col1::text) <> ''''';

        END IF;

    END IF;

END;
$$;

CREATE OR REPLACE FUNCTION {schema}.axi_fn_getstructlist(
    p_roles text,
    p_mode text,
    p_structtype text
)
RETURNS TABLE (
    displaydata text,
    caption text,
    name text
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_roles text[];
BEGIN
    v_roles := string_to_array(p_roles, ',');

    IF lower(p_structtype) = 'i' THEN
        RETURN QUERY
        SELECT DISTINCT
               (a.caption || ' (' || a.name || ')')::text,
               a.caption::text,
               a.name::text
        FROM iviews a
        JOIN axpages b ON b.pagetype = 'i' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name
        WHERE (lower(p_mode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(v_roles)
                OR (ua.stype = 'i' AND ua.rname = ANY(v_roles))
              )
        ORDER BY 2;

    ELSE
        RETURN QUERY
        SELECT DISTINCT
               (a.caption || ' (' || a.name || ')')::text,
               a.caption::text,
               a.name::text
        FROM tstructs a
        JOIN axpages b ON b.pagetype = 't' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name
        WHERE (lower(p_mode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(v_roles)
                OR (ua.stype = 't' AND ua.rname = ANY(v_roles))
              )
        ORDER BY 2;
    END IF;

END;
$$;

CREATE OR REPLACE FUNCTION {schema}.axi_fn_getaxobjectlist(p_userroles text)
RETURNS TABLE (
    displaydata text,
    caption text,
    name text
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_roles text[];
BEGIN
    v_roles := string_to_array(p_userroles, ',');

    RETURN QUERY
    SELECT *
    FROM (

        -- TSTRUCT
        SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [tstruct]')::text AS displaydata,
               a.caption::text AS caption,
               a.name::text AS name
        FROM tstructs a
        JOIN axpages b
             ON b.pagetype = 't' || a.name
        LEFT JOIN axuseraccess ua
             ON ua.sname = a.name
        WHERE b.visible = 'T'
          AND (
                'default' = ANY(v_roles)
                OR (ua.stype = 't' AND ua.rname = ANY(v_roles))
              )

        UNION

        -- IVIEW
        SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [iview]')::text displaydata,
               a.caption::text caption,
               a.name::text name
        FROM iviews a
        JOIN axpages b
             ON b.pagetype = 'i' || a.name
        LEFT JOIN axuseraccess ua
             ON ua.sname = a.name
        WHERE b.visible = 'T'
          AND (
                'default' = ANY(v_roles)
                OR (ua.stype = 'i' AND ua.rname = ANY(v_roles))
              )

        UNION

        -- PAGE
        SELECT DISTINCT
               (p.caption || ' [page]')::text displaydata,
               p.caption::text caption,
               p.props::text name
        FROM axpages p
        LEFT JOIN axuseraccess ua
             ON ua.sname = p.props
        WHERE p.pagetype = 'web'
          AND p.visible = 'T'
          AND p.props IS NOT NULL
          AND p.props <> ''
          AND (
                'default' = ANY(v_roles)
                OR (ua.stype = 'p' AND ua.rname = ANY(v_roles))
              )

        UNION

        -- ADS (no role check)
        SELECT
               (a.sqlname || ' (' || a.sqlsrc || ') [ads]')::text displaydata,
               a.sqlsrc::text caption,
               a.sqlname::text name
        FROM {schema}.axdirectsql a
        WHERE EXISTS (
                SELECT 1
                FROM {schema}.axdirectsql_metadata m
                WHERE m.axdirectsqlid = a.axdirectsqlid
              )

        UNION

        -- Inbox
        SELECT
               'Inbox'::text displaydata,
               'Inbox'::text caption,
               'Inbox'::text name

    ) src
    ORDER BY displaydata;

END;
$$;

--fn_permissions_getpermission | to be removed from axi , as this will be added to product code.

CREATE OR REPLACE FUNCTION {schema}.fn_permissions_getpermission(pmode character varying, ptransid character varying, pusername character varying, proles character varying DEFAULT 'All'::character varying, pglobalvars character varying DEFAULT 'NA'::character varying)
 RETURNS TABLE(transid character varying, fullcontrol character varying, userrole character varying, allowcreate character varying, view_access character varying, view_includedc character varying, view_excludedc character varying, view_includeflds character varying, view_excludeflds character varying, edit_access character varying, edit_includedc character varying, edit_excludedc character varying, edit_includeflds character varying, edit_excludeflds character varying, maskedflds character varying, filtercnd text, encryptedflds character varying, permissiontype character varying, viewctrl character varying, editctrl character varying)
 LANGUAGE plpgsql
AS $function$
declare 
rec record;
rolesql text;
v_permissionsql text;
v_permissionexists numeric;
v_menuaccess numeric;
rec_transid record;
v_final_conditions text[] DEFAULT  ARRAY[]::text[];
rec_glovars record;
rec_glovars_varname varchar;
rec_glovars_varvalue varchar;
rec_dbconditions record;
v_dimensionsexists numeric;
v_applypermissions numeric;
v_matched varchar;
v_condition varchar;
v_used_vars varchar[] DEFAULT  ARRAY[]::varchar[];
v_usercondition text;
begin


select count(*) into v_applypermissions from axgrouptstructs where ftransid = ptransid;

if v_applypermissions > 0 then

select  case when length(cnd1)>2 then 1 else 0 end,cnd1 into v_dimensionsexists,v_usercondition from axusergrouping a 
 join axusers b on a.axusersid = b.axusersid 
 join axgrouptstructs a2 on a2.ftransid=ptransid
 where b.username  = {schema}.fn_permissions_getpermission.pusername;


if pglobalvars !='NA' then

FOR rec_glovars IN
    SELECT unnest(string_to_array(pglobalvars,'~~')) glovars
LOOP

    rec_glovars_varname  := split_part(rec_glovars.glovars,'=',1);
    rec_glovars_varvalue := split_part(rec_glovars.glovars,'=',2);

   v_condition := concat('{primarytable.}',rec_glovars_varname,' in (',rec_glovars_varvalue,',''All'')');

        v_final_conditions := array_append(v_final_conditions, v_condition);

END LOOP;

else 


v_condition := v_usercondition;
v_final_conditions :=array_append(v_final_conditions, v_condition);

end if;

end if;

for rec_transid in(select unnest(string_to_array(ptransid,',')) transid) loop

select sum(cnt) into v_menuaccess from 
(select 1 cnt from axusergroups a join axusergroupsdetail b on a.axusergroupsid = b.axusergroupsid
join axuseraccess a2 on b.roles_id = a2.rname and stype ='t' 
where a2.sname = rec_transid.transid
and exists(select 1 from unnest(string_to_array(proles,',')) val where val = a.groupname)
union all
select 1 from dual where proles like '%default%'
union all
select 1 from axuserlevelgroups where username = pusername and usergroup='default'
union all
select 1 cnt from axusergroups a join axusergroupsdetail b on a.axusergroupsid = b.axusergroupsid
join axuseraccess a2 on b.roles_id = a2.rname and stype ='t'
join axuserlevelgroups u on a.groupname = u.usergroup and u.username = pusername 
where a2.sname = ptransid and proles = 'All'
   UNION ALL
        SELECT 1 AS cnt FROM axusergroups a
        JOIN axusergroupsdetail b ON a.axusergroupsid = b.axusergroupsid        
        JOIN axuserlevelgroups u ON a.groupname = u.usergroup 
        where b.ROLES_ID ='default' AND u.USERNAME = pusername
)a;

if proles='All' then 
rolesql := 'select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd1 cnd,viewctrl,allowcreate,editctrl,''Role'' permissiontype 
from AxPermissions a 
join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
join axusers u on a2.axusersid = u.axusersid  
left join axusergrouping b on u.axusersid = b.axusersid
where a.formtransid='''||rec_transid.transid||''' and u.username = '''||pusername||''' 
union all 
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl,''User'' permissiontype 
from AxPermissions a 
left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||rec_transid.transid||'''';

v_permissionsql := 'select count(cnt) from(select 1 cnt
from AxPermissions a 
join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
join axusers u on a2.axusersid = u.axusersid  
left join axusergrouping b on u.axusersid = b.axusersid
where a.formtransid='''||rec_transid.transid||''' and u.username = '''||pusername||''' 
union all 
select 1 cnt 
from AxPermissions a 
left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||rec_transid.transid||''')a';

else

rolesql := 'select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl,''Role'' permissiontype 
from AxPermissions a 
left join (
select a2.usergroup ,b.cnd1 cnd from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
where exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
and a.formtransid='''||rec_transid.transid||'''   
union all
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl,''User'' permissiontype 
from AxPermissions a left join axuserDpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||rec_transid.transid||'''';

v_permissionsql :='select count(cnt) from(select 1 cnt
from AxPermissions a 
left join (
select a2.usergroup ,b.cnd1 cnd,a.axusersid from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
left join axusers u on b.axusersid = u.axusersid  and u.username = '''||pusername||'''
where exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
and a.formtransid='''||rec_transid.transid||'''   
union all
select 1 cnt
from AxPermissions a left join axuserDpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||rec_transid.transid||''')a'; 

end if;

execute v_permissionsql into  v_permissionexists;



if v_menuaccess > 0 and v_permissionexists = 0 then 

fullcontrol:= 'T';
transid := rec_transid.transid;
userrole := null;
view_includedc  :=null;
view_excludedc  :=null;   
view_includeflds:=null;
view_excludeflds :=null;
edit_includedc :=null;
edit_excludedc :=null;   
edit_includeflds :=null;
edit_excludeflds :=null;
maskedflds := null;    
view_access := null;
edit_access := null;
view_includeflds := null;  
view_includedc :=null;
allowcreate := null;
filtercnd := case when v_applypermissions > 0 then array_to_string(v_final_conditions,' and ') else null end;
viewctrl := '0';
editctrl :='0';
select string_agg(fname,',') into encryptedflds  from axpflds where tstruct=rec_transid.transid and encrypted='T'; 
 
return next;

else

for rec in execute rolesql
loop 
  transid := rec_transid.transid;
  userrole := rec.axuserrole;
  select string_agg(dname,',') into view_includedc  from axpdc where tstruct=rec_transid.transid and exists (select 1 from unnest(string_to_array( concat('dc1,',rec.view_includedflds),',')) val where val = dname);
  select string_agg(dname,',') into view_excludedc  from axpdc where tstruct=rec_transid.transid and exists (select 1 from unnest(string_to_array( rec.view_excludedflds,',')) val where val = dname);   
  select string_agg(fname,',') into view_includeflds  from axpflds where tstruct=rec_transid.transid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.view_includedflds,',')) val where val = fname);
  select string_agg(fname,',') into view_excludeflds  from axpflds where tstruct=rec_transid.transid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.view_excludedflds,',')) val where val = fname);
  select string_agg(dname,',') into edit_includedc  from axpdc where tstruct=rec_transid.transid and exists (select 1 from unnest(string_to_array( rec.edit_includedflds,',')) val where val = dname);
  select string_agg(dname,',') into edit_excludedc  from axpdc where tstruct=rec_transid.transid and exists (select 1 from unnest(string_to_array( rec.edit_excludedflds,',')) val where val = dname);   
  select string_agg(fname,',') into edit_includeflds  from axpflds where tstruct=rec_transid.transid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.edit_includedflds,',')) val where val = fname);
  select string_agg(fname,',') into edit_excludeflds  from axpflds where tstruct=rec_transid.transid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.edit_excludedflds,',')) val where val = fname);
  maskedflds := rec.fieldmaskstr;    
  view_access := case when rec.viewctrl='4' then 'None' else null end;
  edit_access := case when rec.editctrl='4' then 'None' else null end;
  view_includeflds := case when rec.viewctrl='0' then view_includeflds else concat(view_includeflds,',',edit_includeflds) end;  
  view_includedc :=case when rec.viewctrl='0' then view_includedc else  concat(view_includedc,',',edit_includedc) end;
  allowcreate := rec.allowcreate;
  --filtercnd := rec.cnd;
filtercnd := array_to_string(v_final_conditions,' and ');
  select string_agg(fname,',') into encryptedflds  from axpflds  where tstruct=rec_transid.transid and encrypted='T' and exists (select 1 from unnest(string_to_array(view_includeflds,',')) val where val = fname);
  fullcontrol:= null;
  permissiontype := rec.permissiontype;
viewctrl := rec.viewctrl;
editctrl :=rec.editctrl;
  return next;

end loop;

end if;

end loop;
 
return;
 
END; 
$function$;

--fn_axi_getstructures_meta with userpermission meta data

CREATE OR REPLACE FUNCTION {schema}.fn_axi_getstructures_meta(pusername character varying, puserrole character varying, presponsiblity character varying, pmode character varying, pstype character varying)
 RETURNS TABLE(displaydata character varying, caption character varying, name character varying, stype character varying, dimension character varying, permission character varying, createallowed character varying, viewallowed character varying, keyfield character varying, primarytable character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN

if pstype='t' then
    RETURN QUERY
SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [tstruct]')::varchar,
               a.caption tcaption,
               a.name transid,'t'::varchar stype,coalesce(g.dimensions,'F')::varchar dimensions,
    coalesce(p.permissions,'F')::varchar,coalesce(p.newrecord,'T')::varchar,coalesce(p.viewctrl,'T')::varchar,kf.kfld,d.tablename
        FROM tstructs a
join axpdc d on a.name = d.tstruct and d.dname='dc1'
        left JOIN axpages b ON b.pagetype = 't' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name
left join (SELECT DISTINCT ON (combined_results.name) 
    combined_results.name tstruct,  
    kfld, 
    ord
FROM (
    SELECT 
        a.name,
        a.keyfield AS kfld,
        1 AS ord       
    FROM {schema}.axp_tstructprops a 
    UNION ALL
    SELECT 
        tstruct AS name,
        fname AS kfld,
        CASE 
            WHEN modeofentry = 'autogenerate' THEN 2
            WHEN LOWER(allowduplicate) = 'f' AND LOWER(allowempty) = 'f' AND datatype = 'c' AND LOWER(hidden) = 'f' THEN 3
            WHEN LOWER(hidden) = 'f' AND datatype = 'c' THEN 4
            ELSE 5
        END AS ord       
    FROM axpflds
    WHERE dcname = 'dc1'
) combined_results
ORDER BY combined_results.name, ord ASC)kf on kf.tstruct = a.name
        left join (select ftransid,'T' dimensions from axgrouptstructs)g on a."name" = g.ftransid
        left join (SELECT DISTINCT ON (formtransid) 
    formtransid, 
    newrecord, 
    permissions,viewctrl
FROM (
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'U' as type, 1 as ord ,'T'permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axusername = pusername AND comptype = 'Form'
    UNION ALL
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'R' as type, 2 as ord ,'T' permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axuserrole = ANY(string_to_array(puserrole, ',')) and  comptype = 'Form'
) combined_permissions
ORDER BY formtransid, ord ASC)p on a.name=p.formtransid
        WHERE (pmode = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.stype = 't' AND ua.rname = ANY(string_to_array(presponsiblity,','))
              )) order by 1; 

elsif pstype='i' then
  RETURN QUERY
SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [iview]')::varchar,
               a.caption,
               a.name,'i'::varchar stype,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar
        FROM iviews a
        left JOIN axpages b ON b.pagetype = 'i' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name     
        WHERE (lower(pmode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.stype = 'i' AND ua.rname = ANY(string_to_array(presponsiblity,','))
              ))order by 1;
elsif pstype='p' then
  RETURN QUERY
 SELECT DISTINCT
               (b.caption || ' [page]')::varchar,
               b.caption,
               b.props::varchar name,'p'::varchar stype,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar
        FROM  axpages b 
        left JOIN axuseraccess ua ON ua.sname = b.name     
        WHERE b.pagetype='web'
        and (lower(pmode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.rname = ANY(string_to_array(presponsiblity,','))
              ))order by 1; 

elsif pstype='ads' then
  RETURN QUERY
select (a.sqlname || ' (' || a.sqlsrc || ') [ads]')::varchar displaydata,sqlname caption,sqlname name,'ads'::varchar stype,'NA'::varchar dimension,
case when a2.axpermissionsid>0 then 'T' else 'NA' end::varchar permission,
'NA'::varchar createallowed,
case when a2.axpermissionsid>0 or a.createdby=pusername or 'default' = ANY(string_to_array(puserrole,',')) then 'T' else 'NA' end::varchar viewallowed,
'NA'::varchar keyfield,'NA'::varchar primarytable
from {schema}.axdirectsql a
left join axpermissions a2 on a.sqlname =a2.formcap and (a2.axusername = pusername or a2.axuserrole = ANY(string_to_array(puserrole,',')))
where sqlsrc !='Metadata'
order by 1;

elsif pstype='all' then

return query
select * from(SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [tstruct]')::varchar,
               a.caption tcaption,
               a.name transid,'t'::varchar stype,coalesce(g.dimensions,'F')::varchar dimensions,
    coalesce(p.permissions,'F')::varchar,coalesce(p.newrecord,'T')::varchar,coalesce(p.viewctrl,'T')::varchar,kf.kfld,d.tablename
        FROM tstructs a
join axpdc d on a.name = d.tstruct and d.dname='dc1'
        left JOIN axpages b ON b.pagetype = 't' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name
left join (SELECT DISTINCT ON (combined_results.name) 
    combined_results.name tstruct,  
    kfld, 
    ord
FROM (
    SELECT 
        a.name,
        a.keyfield AS kfld,
        1 AS ord       
    FROM {schema}.axp_tstructprops a 
    UNION ALL
    SELECT 
        tstruct AS name,
        fname AS kfld,
        CASE 
            WHEN modeofentry = 'autogenerate' THEN 2
            WHEN LOWER(allowduplicate) = 'f' AND LOWER(allowempty) = 'f' AND datatype = 'c' AND LOWER(hidden) = 'f' THEN 3
            WHEN LOWER(hidden) = 'f' AND datatype = 'c' THEN 4
            ELSE 5
        END AS ord       
    FROM axpflds
    WHERE dcname = 'dc1'
) combined_results
ORDER BY combined_results.name, ord ASC)kf on kf.tstruct = a.name
        left join (select ftransid,'T' dimensions from axgrouptstructs)g on a."name" = g.ftransid
        left join (SELECT DISTINCT ON (formtransid) 
    formtransid, 
    newrecord, 
    permissions,viewctrl
FROM (
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'U' as type, 1 as ord ,'T'permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axusername = pusername AND comptype = 'Form'
    UNION ALL
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'R' as type, 2 as ord ,'T' permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axuserrole = ANY(string_to_array(puserrole, ',')) and  comptype = 'Form'
) combined_permissions
ORDER BY formtransid, ord ASC)p on a.name=p.formtransid
        WHERE (pmode = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.stype = 't' AND ua.rname = ANY(string_to_array(presponsiblity,','))
              ))
union all
SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [iview]')::varchar,
               a.caption,
               a.name,'i'::varchar stype,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar
        FROM iviews a
        left JOIN axpages b ON b.pagetype = 'i' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name     
        WHERE (lower(pmode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.stype = 'i' AND ua.rname = ANY(string_to_array(presponsiblity,','))
              ))
union all
 SELECT DISTINCT
               (b.caption || ' [page]')::varchar,
               b.caption,
               b.props,'p'::varchar stype,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar,'NA'::varchar
        FROM  axpages b 
        left JOIN axuseraccess ua ON ua.sname = b.name     
        WHERE b.pagetype='web'
        and (lower(pmode) = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.rname = ANY(string_to_array(presponsiblity,','))
              ))
union all
select (a.sqlname || ' (' || a.sqlsrc || ') [ads]')::varchar displaydata,sqlname caption,sqlname name,'ads'::varchar stype,'NA'::varchar dimension,
case when a2.axpermissionsid>0 then 'T' else 'NA' end::varchar permission,
'NA'::varchar createallowed,
case when a2.axpermissionsid>0 or a.createdby=pusername or 'default' = ANY(string_to_array(puserrole,',')) then 'T' else 'NA' end::varchar viewallowed,
'NA'::varchar keyfield,'NA'::varchar primarytable
from {schema}.axdirectsql a
left join axpermissions a2 on a.sqlname =a2.formcap and (a2.axusername = pusername or a2.axuserrole = ANY(string_to_array(puserrole,',')))
where sqlsrc !='Metadata'
union all
SELECT
               'Inbox'::varchar displaydata,
               'Inbox'::varchar caption,
               'Inbox'::varchar name,'Inbox'::varchar stype,'NA','NA','NA','NA','NA','NA')a order by 1;
elsif pstype='analyse' then 
RETURN QUERY
SELECT DISTINCT
               (a.caption || ' (' || a.name || ') [tstruct]')::varchar,
               a.caption tcaption,
               a.name transid,'t'::varchar stype,coalesce(g.dimensions,'F')::varchar dimensions,
    coalesce(p.permissions,'F')::varchar,coalesce(p.newrecord,'T')::varchar,coalesce(p.viewctrl,'T')::varchar,kf.kfld,d.tablename
        FROM tstructs a
join axpdc d on a.name = d.tstruct and d.dname='dc1'
        left JOIN axpages b ON b.pagetype = 't' || a.name
        LEFT JOIN axuseraccess ua ON ua.sname = a.name
left join (SELECT DISTINCT ON (combined_results.name) 
    combined_results.name tstruct,  
    kfld, 
    ord
FROM (
    SELECT 
        a.name,
        a.keyfield AS kfld,
        1 AS ord       
    FROM {schema}.axp_tstructprops a 
    UNION ALL
    SELECT 
        tstruct AS name,
        fname AS kfld,
        CASE 
            WHEN modeofentry = 'autogenerate' THEN 2
            WHEN LOWER(allowduplicate) = 'f' AND LOWER(allowempty) = 'f' AND datatype = 'c' AND LOWER(hidden) = 'f' THEN 3
            WHEN LOWER(hidden) = 'f' AND datatype = 'c' THEN 4
            ELSE 5
        END AS ord       
    FROM axpflds
    WHERE dcname = 'dc1'
) combined_results
ORDER BY combined_results.name, ord ASC)kf on kf.tstruct = a.name
        left join (select ftransid,'T' dimensions from axgrouptstructs)g on a."name" = g.ftransid
        left join (SELECT DISTINCT ON (formtransid) 
    formtransid, 
    newrecord, 
    permissions,viewctrl
FROM (
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'U' as type, 1 as ord ,'T'permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axusername = pusername AND comptype = 'Form'
    UNION ALL
    SELECT formtransid, case when allowcreate='Yes' then 'T' else 'F' end newrecord, 'R' as type, 2 as ord ,'T' permissions,case when viewctrl='4' then 'F' else 'T' end viewctrl
    FROM axpermissions
    WHERE axuserrole = ANY(string_to_array(puserrole, ',')) and  comptype = 'Form'
) combined_permissions
ORDER BY formtransid, ord ASC)p on a.name=p.formtransid
        WHERE (pmode = 'dev' OR b.visible = 'T')
          AND (
                'default' = ANY(string_to_array(presponsiblity,','))
                OR (ua.stype = 't' AND ua.rname = ANY(string_to_array(presponsiblity,','))
              ))
union all
select (a.sqlname || ' (' || a.sqlsrc || ') [ads]')::varchar displaydata,sqlname caption,sqlname name,'ads'::varchar stype,'NA'::varchar dimension,
case when a2.axpermissionsid>0 then 'T' else 'NA' end::varchar permission,
'NA'::varchar createallowed,
case when a2.axpermissionsid>0 or a.createdby=pusername or 'default' = ANY(string_to_array(puserrole,',')) then 'T' else 'NA' end::varchar viewallowed,
'NA'::varchar keyfield,'NA'::varchar primarytable
from {schema}.axdirectsql a
left join axpermissions a2 on a.sqlname =a2.formcap and (a2.axusername = pusername or a2.axuserrole = ANY(string_to_array(puserrole,',')))
where sqlsrc !='Metadata'
order by 1;
end if;
 
END;
$function$;

-- fn_axi_getstructs_obj | replace for primaryfieldvalue+fieldnames and selected fieldvalue with primary fieldvalue suffix

CREATE OR REPLACE FUNCTION {schema}.fn_axi_getstructs_obj(pcmd character varying, pusername character varying, puserrole character varying, ptransid character varying, pselectedfield character varying, pdimension character varying, ppermission character varying, pkeyfield character varying, pprimarytable character varying, pglobalvars character varying)
 RETURNS TABLE(displaydata text, id text, caption text, isfield text)
 LANGUAGE plpgsql
AS $function$
declare 
v_sql text;
v_keyfield_normalized varchar;
v_keyfield_srctbl varchar;
v_keyfield_srcfld varchar;
v_keyfield_sql text;
v_selectedfld_normalized varchar;
v_selectedfld_srctbl varchar;
v_selectedfld_srcfld varchar;
v_selectedfld_sql text;
v_dimension_filter text;
v_includedcomps text;
v_excludedcomps text;
v_viewctrl varchar;
v_editctrl varchar;
v_finalcomps text;
v_fullcontrol varchar;
v_fieldlist_sql text;
begin
------Get flds metadata for keyfield
select srckey,lower(srctf),lower(srcfld)
into v_keyfield_normalized,v_keyfield_srctbl,v_keyfield_srcfld
from axpflds
where tstruct = ptransid and lower(fname) = lower(pkeyfield);

------Get flds metadata for selected field
select srckey,lower(srctf),lower(srcfld)
into v_selectedfld_normalized,v_selectedfld_srctbl,v_selectedfld_srcfld
from axpflds
where tstruct = ptransid and lower(fname)= lower(pselectedfield); 

------Get dimensions filter condition
if pdimension = 'T' then

 SELECT filtercnd into v_dimension_filter 
 from {schema}.fn_permissions_getpermission('axi', ptransid, pusername, puserrole, pglobalvars);

 v_dimension_filter := case when length(v_dimension_filter) > 2 then concat(' and ',replace(v_dimension_filter,'{primarytable.}','p.')) end;

end if;

-----Get included and excluded dcs, fields 
if ppermission = 'T' then 

 SELECT lower(concat(view_includedc,view_includeflds)),lower(concat(view_excludedc,view_excludeflds)),viewctrl,editctrl,fullcontrol
 into v_includedcomps,v_excludedcomps,v_viewctrl,v_editctrl ,v_fullcontrol
 from {schema}.fn_permissions_getpermission('axi', ptransid, pusername, puserrole, pglobalvars);

 if v_fullcontrol = 'T' or v_viewctrl = '0' then
  v_fieldlist_sql := format($sql$
           SELECT (caption || ' (' || fname || ')' || ' [' || 'field' || ']')::text AS displaydata,
                 '0'::text AS id,
                 caption::text AS caption,
                 't'::text AS isfield
            FROM axpflds
            WHERE tstruct = %L
         and dcname='dc1'
            AND hidden = 'F'
            AND savevalue = 'T'       
         $sql$,
         ptransid);
 elsif coalesce(v_fullcontrol,'F') = 'F' and v_viewctrl = '1' then
  v_fieldlist_sql := format($sql$
           SELECT (caption || ' (' || fname || ')' || ' [' || 'field' || ']')::text AS displaydata,
                 '0'::text AS id,
                 caption::text AS caption,
                 't'::text AS isfield,2::numeric ord 
            FROM axpflds
            WHERE tstruct = %L
         and dcname='dc1'
            AND hidden = 'F'
            AND savevalue = 'T' 
         and lower(fname) = ANY(string_to_array(%L,','))       
         $sql$,
         ptransid,
         lower(v_includedcomps));
 elsif coalesce(v_fullcontrol,'F') = 'F' and v_viewctrl = '2' then
   v_fieldlist_sql := format($sql$
            SELECT (caption || ' (' || fname || ')' || ' [' || 'field' || ']')::text AS displaydata,
                  '0'::text AS id,
                  caption::text AS caption,
                  't'::text AS isfield
             FROM axpflds
             WHERE tstruct = %L
          and dcname='dc1'
             AND hidden = 'F'
             AND savevalue = 'T' 
          and lower(fname) != ALL(string_to_array(%L,','))         
          $sql$,
          ptransid,
          v_excludedcomps);

 end if;
else  
 v_fieldlist_sql := format($sql$
      SELECT (caption || ' (' || fname || ')' || ' [' || 'field' || ']')::text AS displaydata,
      '0'::text AS id,
      caption::text AS caption,
      't'::text AS isfield 
      FROM axpflds
      WHERE tstruct = %L
      and dcname='dc1'
      AND hidden = 'F'
      AND savevalue = 'T'          
      $sql$,
      ptransid);

end if;

if v_keyfield_normalized = 'T' then 

v_keyfield_sql := format(
    $sql$
    SELECT   (s.%I)::text AS displaydata,
           '0'::text AS id,
           (s.%I)::text AS caption,
           'f'::text AS isfield
    FROM %I p 
    JOIN %I s ON p.%I = s.%I
    WHERE p.%I IS NOT NULL
 %s
 order by p.modifiedon desc
    $sql$,
 v_keyfield_srcfld,
    v_keyfield_srcfld,          
    lower(pprimarytable), 
    v_keyfield_srctbl, 
    lower(pkeyfield),   
    v_keyfield_srctbl||'id',   
 lower(pkeyfield), 
 v_dimension_filter    
);
else
v_keyfield_sql := format(
    $sql$
    SELECT (p.%I)::text AS displaydata,
           '0'::text AS id,
           p.%I::text AS caption,
           'f'::text AS isfield
    FROM %I p
    WHERE p.%I IS NOT NULL
 %s
 order by p.modifiedon desc
$sql$,
    lower(pkeyfield),
    lower(pkeyfield),
    lower(pprimarytable),
    lower(pkeyfield),
 v_dimension_filter
);

end if;

if pselectedfield!='0' then 
 if v_selectedfld_normalized = 'T' then 
  v_selectedfld_sql := case when v_keyfield_normalized='F' then
         format(
            $sql$
            SELECT --distinct on (p.%I,s.%I) 
           (s.%I || '[' || p.%I || ']')::text AS displaydata,
                   '0'::text AS id,
                   (s.%I)::text AS caption,
                   'f'::text AS isfield
            FROM %I p 
            JOIN %I s ON p.%I = s.%I
            WHERE p.%I IS NOT NULL
         %s  
         order by p.modifiedon desc      
            $sql$, 
         lower(pkeyfield),
         v_selectedfld_srcfld,
         v_selectedfld_srcfld,     
         lower(pkeyfield),
            v_selectedfld_srcfld,     
            lower(pprimarytable), 
            v_selectedfld_srctbl, 
            lower(pselectedfield),   
            v_selectedfld_srctbl||'id',   
            lower(pselectedfield),
         v_dimension_filter  
        ) 
       when v_keyfield_normalized='T' then 
        format(
            $sql$
            SELECT --distinct on (s.%I,k.%I) 
           (s.%I || '[' || k.%I || ']')::text AS displaydata,
                   '0'::text AS id,
                   (s.%I)::text AS caption,
                   'f'::text AS isfield
            FROM %I p 
            JOIN %I s ON p.%I = s.%I
         join %I k on p.%I = k.%I
            WHERE p.%I IS NOT NULL
         %s
         order by p.modifiedon desc 
            $sql$,
         v_selectedfld_srcfld,
         v_keyfield_srcfld,
         v_selectedfld_srcfld,     
         v_keyfield_srcfld,
            v_selectedfld_srcfld,     
            lower(pprimarytable), 
            v_selectedfld_srctbl, 
            lower(pselectedfield),   
            v_selectedfld_srctbl||'id',   
         v_keyfield_srctbl,
         lower(pkeyfield),
         v_keyfield_srctbl||'id',
            lower(pselectedfield),
         v_dimension_filter    
        )
end;
 else
  v_selectedfld_sql := case when v_keyfield_normalized='F' then 
        format(
           $sql$
           SELECT  (p.%I || '[' || p.%I || ']')::text AS displaydata,
                  '0'::text AS id,
                  p.%I::text AS caption,
                  'f'::text AS isfield
           FROM %I p
           WHERE p.%I IS NOT NULL
        %s
        order by p.modifiedon desc,p.%I
       $sql$,
           lower(pselectedfield),
        lower(pkeyfield),
           lower(pselectedfield),
           lower(pprimarytable),
           lower(pselectedfield),
        v_dimension_filter,
        lower(pselectedfield)
       )
       when v_keyfield_normalized='T' then 
        format(
           $sql$
           SELECT (p.%I || '[' || s.%I || ']')::text AS displaydata,
                  '0'::text AS id,
                  p.%I::text AS caption,
                  'f'::text AS isfield
           FROM %I p
        join %I s on p.%I = s.%I
           WHERE p.%I IS NOT NULL
        %s
        order by p.modifiedon desc
        $sql$,
           lower(pselectedfield),
        v_keyfield_srcfld,
        lower(pselectedfield),
        lower(pprimarytable),
        v_keyfield_srctbl,
           lower(pkeyfield),
        v_keyfield_srctbl||'id',
        lower(pkeyfield),
        v_dimension_filter
       ) end;
      
 end if;
end if;


if pselectedfield='0' then
v_sql := concat(' select * from(',v_keyfield_sql,')a',' union all',v_fieldlist_sql);
else
v_sql := v_selectedfld_sql;
end if;
return query execute v_sql;

END; $function$;

-- =============================================================================
-- SECTION: OWNERSHIP AND PERMISSIONS FOR OBJECTS CREATED IN THIS SCRIPT
-- =============================================================================
-- Note: Only tables and functions created in this SQL file are included below.

-- Table ownership and grants
ALTER TABLE {schema}.Axi_UserFavourites OWNER TO {schema};
GRANT ALL ON TABLE {schema}.Axi_UserFavourites TO {schema};
ALTER TABLE {schema}.axiconfig OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axiconfig TO {schema};
ALTER TABLE {schema}.axi_commands OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axi_commands TO {schema};
ALTER TABLE {schema}.axi_command_prompts OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axi_command_prompts TO {schema};
ALTER TABLE {schema}.axp_tstructprops OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axp_tstructprops TO {schema};
ALTER TABLE {schema}.axdirectsql OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axdirectsql TO {schema};
ALTER TABLE {schema}.axdirectsql_metadata OWNER TO {schema};
GRANT ALL ON TABLE {schema}.axdirectsql_metadata TO {schema};

-- Function ownership and grants
ALTER FUNCTION {schema}.fn_axi_get_fieldvalues_with_keysuffix_list(text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_get_fieldvalues_with_keysuffix_list(text, text) TO {schema};
ALTER FUNCTION {schema}.fn_axi_getkeyvalueswithfieldnameslist(text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_getkeyvalueswithfieldnameslist(text, text) TO {schema};
ALTER FUNCTION {schema}.fn_upsert_config_by_condition(text, text, text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_upsert_config_by_condition(text, text, text, text) TO {schema};
ALTER FUNCTION {schema}.get_ads_dropdown_data(text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.get_ads_dropdown_data(text, text) TO {schema};
ALTER FUNCTION {schema}.get_dynamic_field(text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.get_dynamic_field(text, text) TO {schema};
ALTER FUNCTION {schema}.populate_axdirectsql_metadata() OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.populate_axdirectsql_metadata() TO {schema};
ALTER FUNCTION {schema}.fn_axi_metadata(VARCHAR, VARCHAR) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_metadata(VARCHAR, VARCHAR) TO {schema};
ALTER FUNCTION {schema}.fn_axi_struct_metadata(VARCHAR, VARCHAR, VARCHAR) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_struct_metadata(VARCHAR, VARCHAR, VARCHAR) TO {schema};
ALTER FUNCTION {schema}.axi_firesql_v2(TEXT, TEXT, TEXT, TEXT) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.axi_firesql_v2(TEXT, TEXT, TEXT, TEXT) TO {schema};
ALTER FUNCTION {schema}.axi_fn_getstructlist(text, text, text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.axi_fn_getstructlist(text, text, text) TO {schema};
ALTER FUNCTION {schema}.axi_fn_getaxobjectlist(text) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.axi_fn_getaxobjectlist(text) TO {schema};
ALTER FUNCTION {schema}.fn_permissions_getpermission(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_permissions_getpermission(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) TO {schema};
ALTER FUNCTION {schema}.fn_axi_getstructures_meta(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_getstructures_meta(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) TO {schema};
ALTER FUNCTION {schema}.fn_axi_getstructs_obj(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) OWNER TO {schema};
GRANT EXECUTE ON FUNCTION {schema}.fn_axi_getstructs_obj(VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR) TO {schema};
