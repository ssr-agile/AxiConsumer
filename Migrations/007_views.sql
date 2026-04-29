-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE VIEW {schema}.ax_inbound_status AS
 SELECT a.filename,
    (a.recdon)::date AS recdon,
    (a.recdon)::date AS indate,
    a.transid,
    b.caption AS tstructname,
    a.instatus
   FROM {schema}.inbound a,
    {schema}.tstructs b
  WHERE ((a.transid)::text = (b.name)::text);

CREATE VIEW {schema}.ax_outbound_status AS
 SELECT a.recordid AS filename,
    (a.senton)::date AS senton,
    (a.senton)::date AS outdate,
    a.transid,
    b.caption AS tstructname,
        CASE
            WHEN (a.senton IS NULL) THEN 'Pending'::text
            ELSE 'Sent'::text
        END AS outstatus
   FROM {schema}.outbound a,
    {schema}.tstructs b
  WHERE ((a.transid)::text = (b.name)::text);

CREATE VIEW {schema}.axp_vw_menu AS
 SELECT replace(replace((COALESCE(h.caption, ''::text) || COALESCE(('\'::text || (g.caption)::text), ''::text)), '\\\'::text, '\'::text), '\\'::text, '\'::text) AS menupath,
    g.caption,
    g.name,
    g.ordno,
    g.levelno,
    g.parent,
    g.type,
    g.pagetype,
    replace(replace(((COALESCE(('\'::text || (g.visible)::text), 'F'::text) || COALESCE(('\'::text || h.visible), ''::text)) || '\'::text), '\\\'::text, '\'::text), '\\'::text, '\'::text) AS visible,
    g.websubtype
   FROM ({schema}.axpages g
     LEFT JOIN ( SELECT (COALESCE(f.caption, ''::text) || COALESCE(('\'::text || (e.caption)::text), ''::text)) AS caption,
            e.parent,
            e.name,
            ((COALESCE(('\'::text || f.visible), ''::text) || COALESCE(('\'::text || (e.visible)::text), ''::text)) || '\'::text) AS visible
           FROM ({schema}.axpages e
             LEFT JOIN ( SELECT (((COALESCE(d.caption, ''::character varying))::text || '\'::text) || (COALESCE(c.caption, ''::character varying))::text) AS caption,
                    c.name,
                    ((COALESCE(('\'::text || d.visible), ''::text) || COALESCE(('\'::text || (c.visible)::text), ''::text)) || '\'::text) AS visible
                   FROM ({schema}.axpages c
                     LEFT JOIN ( SELECT a.name,
                            a.parent,
                            a.caption,
                            a.levelno,
                            a.ordno,
                            1 AS levlno,
                            (('\'::text || (a.visible)::text) || '\'::text) AS visible
                           FROM {schema}.axpages a
                          WHERE (a.levelno = (0)::numeric)
                          ORDER BY a.levelno, a.ordno) d ON (((c.parent)::text = (d.name)::text)))
                  WHERE (c.levelno = ANY (ARRAY[(1)::numeric, (0)::numeric]))) f ON (((e.parent)::text = (f.name)::text)))
          WHERE (e.levelno = ANY (ARRAY[(1)::numeric, (0)::numeric, (2)::numeric]))) h ON (((g.parent)::text = (h.name)::text)))
  WHERE (g.levelno <= (3)::numeric)
  ORDER BY g.ordno, g.levelno;

CREATE VIEW {schema}.axp_appsearch_data_new AS
 SELECT 2 AS slno,
    axp_appsearch_data_v2.hltype,
    axp_appsearch_data_v2.structname,
    btrim(replace((axp_appsearch_data_v2.searchtext)::text, 'View'::text, ' '::text)) AS searchtext,
    axp_appsearch_data_v2.params,
    a.oldappurl
   FROM ({schema}.axp_appsearch_data_v2
     JOIN {schema}.axpages a ON (((
        CASE axp_appsearch_data_v2.hltype
            WHEN 'iview'::text THEN (('i'::text || (axp_appsearch_data_v2.structname)::text))::character varying
            WHEN 'tstruct'::text THEN (('t'::text || (axp_appsearch_data_v2.structname)::text))::character varying
            ELSE axp_appsearch_data_v2.structname
        END)::text = (
        CASE
            WHEN ((axp_appsearch_data_v2.hltype)::text = 'Page'::text) THEN a.name
            ELSE a.pagetype
        END)::text)))
  WHERE (lower((axp_appsearch_data_v2.params)::text) !~~ '%current_date%'::text)
UNION ALL
 SELECT 1.9 AS slno,
    a.hltype,
    a.structname,
    btrim(replace((a.searchtext)::text, 'View'::text, ' '::text)) AS searchtext,
    a.params,
    p.oldappurl
   FROM ({schema}.axp_appsearch_data a
     JOIN {schema}.axpages p ON (((
        CASE a.hltype
            WHEN 'iview'::text THEN (('i'::text || (a.structname)::text))::character varying
            WHEN 'tstruct'::text THEN (('t'::text || (a.structname)::text))::character varying
            ELSE a.structname
        END)::text = (
        CASE
            WHEN ((a.hltype)::text = 'Page'::text) THEN p.name
            ELSE p.pagetype
        END)::text)))
  WHERE (NOT (EXISTS ( SELECT 'x'::text AS text
           FROM {schema}.axp_appsearch_data_v2 b
          WHERE (((a.structname)::text = (b.structname)::text) AND ((a.params)::text = (b.params)::text)))))
UNION ALL
 SELECT 2 AS slno,
    axp_appsearch_data_v2.hltype,
    axp_appsearch_data_v2.structname,
    btrim(replace((axp_appsearch_data_v2.searchtext)::text, 'View'::text, ' '::text)) AS searchtext,
    replace(replace(replace(replace(replace(replace(replace(replace(replace(replace((axp_appsearch_data_v2.params)::text, 'date_trunc(''month'',current_date)'::text, btrim(to_char(date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone), 'dd/mm/yyyy'::text))), 'date_trunc(''month'',(add_months(current_date,0-1)))'::text, btrim(to_char(date_trunc('month'::text, ({schema}.add_months(CURRENT_DATE, (0 - 1)))::timestamp with time zone), 'dd/mm/yyyy'::text))), 'date_trunc(''month'', current_date) + interval ''0 month'' - interval ''1 day'''::text, btrim(to_char(((date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) + '00:00:00'::interval) - '1 day'::interval), 'dd/mm/yyyy'::text))), 'date_trunc(''week'',current_date)'::text, btrim(to_char(date_trunc('week'::text, (CURRENT_DATE)::timestamp with time zone), 'dd/mm/yyyy'::text))), 'date_trunc(''week'',current_date-7)+ interval ''6 day'''::text, btrim(to_char((date_trunc('week'::text, ((CURRENT_DATE - 7))::timestamp with time zone) + '6 days'::interval), 'dd/mm/yyyy'::text))), 'date_trunc(''week'',current_date-7)'::text, btrim(to_char(date_trunc('week'::text, ((CURRENT_DATE - 7))::timestamp with time zone), 'dd/mm/yyyy'::text))), 'date_trunc(''month'',current_date)'::text, btrim(to_char(date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone), 'dd/mm/yyyy'::text))), 'current_date-1'::text, btrim(to_char(((CURRENT_DATE - 1))::timestamp with time zone, 'dd/mm/yyyy'::text))), 'current_date'::text, btrim(to_char((CURRENT_DATE)::timestamp with time zone, 'dd/mm/yyyy'::text))), ' &'::text, '&'::text) AS params,
    a.oldappurl
   FROM ({schema}.axp_appsearch_data_v2
     JOIN {schema}.axpages a ON (((
        CASE axp_appsearch_data_v2.hltype
            WHEN 'iview'::text THEN (('i'::text || (axp_appsearch_data_v2.structname)::text))::character varying
            WHEN 'tstruct'::text THEN (('t'::text || (axp_appsearch_data_v2.structname)::text))::character varying
            ELSE axp_appsearch_data_v2.structname
        END)::text = (
        CASE
            WHEN ((axp_appsearch_data_v2.hltype)::text = 'Page'::text) THEN a.name
            ELSE a.pagetype
        END)::text)))
  WHERE (lower((axp_appsearch_data_v2.params)::text) ~~ '%current_date%'::text)
UNION ALL
 SELECT 1 AS slno,
    'tstruct'::character varying AS hltype,
    t.name AS structname,
    t.caption AS searchtext,
    NULL::character varying AS params,
    p.oldappurl
   FROM ({schema}.tstructs t
     JOIN {schema}.axpages p ON ((('t'::text || (t.name)::text) = (p.pagetype)::text)))
  WHERE ((t.blobno = (1)::numeric) AND (EXISTS ( SELECT 'x'::text AS text
           FROM {schema}.axp_vw_menu x
          WHERE (((x.pagetype)::text ~~ 't%'::text) AND (btrim(substr((x.pagetype)::text, 2, 20)) = (t.name)::text) AND (x.visible !~~ '%F%'::text)))))
UNION ALL
 SELECT 0 AS slno,
    'iview'::character varying AS hltype,
    i.name AS structname,
    i.caption AS searchtext,
    NULL::character varying AS params,
    p.oldappurl
   FROM ({schema}.iviews i
     JOIN {schema}.axpages p ON ((('i'::text || (i.name)::text) = (p.pagetype)::text)))
  WHERE ((i.blobno = (1)::numeric) AND (EXISTS ( SELECT 'x'::text AS text
           FROM {schema}.axp_vw_menu x
          WHERE (((x.pagetype)::text ~~ 'i%'::text) AND (btrim(substr((x.pagetype)::text, 2, 20)) = (i.name)::text) AND (x.visible !~~ '%F%'::text)))))
UNION ALL
 SELECT 3 AS slno,
    'Page'::character varying AS hltype,
    axp_vw_menu.name AS structname,
    axp_vw_menu.caption AS searchtext,
    NULL::character varying AS params,
    p.oldappurl
   FROM ({schema}.axp_vw_menu
     JOIN {schema}.axpages p ON (((axp_vw_menu.name)::text = (p.name)::text)))
  WHERE ((axp_vw_menu.pagetype)::text = 'web'::text)
  ORDER BY 1;

CREATE VIEW {schema}.axp_appsearch AS
 SELECT DISTINCT a.searchtext,
    ((a.params)::text ||
        CASE
            WHEN ((a.params IS NOT NULL) AND (lower((a.params)::text) !~~ '%~act%'::text)) THEN '~act=load'::text
            ELSE NULL::text
        END) AS params,
    a.hltype,
    a.structname,
    a.username,
    a.oldappurl
   FROM ( SELECT s.slno,
            s.searchtext,
            s.params,
            s.hltype,
            s.structname,
            lg.username,
            s.oldappurl
           FROM {schema}.axp_appsearch_data_new s,
            {schema}.axuseraccess a_1,
            {schema}.axusergroups g,
            {schema}.axusergroupsdetail g1,
            {schema}.axuserlevelgroups lg
          WHERE (((a_1.sname)::text = (s.structname)::text) AND (g.axusergroupsid = g1.axusergroupsid) AND ((g.groupname)::text = (lg.usergroup)::text) AND ((a_1.rname)::text = (g1.roles_id)::text) AND ((s.structname)::text <> 'axurg'::text) AND ((a_1.stype)::text = ANY (ARRAY[('t'::character varying)::text, ('i'::character varying)::text])))
          GROUP BY s.searchtext, s.params, s.hltype, s.structname, lg.username, s.slno, s.oldappurl
        UNION
         SELECT b.slno,
            b.searchtext,
            b.params,
            b.hltype,
            b.structname,
            lg.username,
            b.oldappurl
           FROM {schema}.axuserlevelgroups lg,
            ( SELECT DISTINCT s.searchtext,
                    s.params,
                    s.hltype,
                    s.structname,
                    0 AS slno,
                    s.oldappurl
                   FROM ({schema}.axp_appsearch_data_new s
                     LEFT JOIN {schema}.axuseraccess a_1 ON ((((s.structname)::text = (a_1.sname)::text) AND ((a_1.stype)::text = ANY (ARRAY[('t'::character varying)::text, ('i'::character varying)::text])))))) b
          WHERE (((lg.usergroup)::text = 'default'::text) AND ((b.structname)::text <> 'axurg'::text))
  ORDER BY 1, 6) a;

CREATE VIEW {schema}.axp_vw_menulist AS
 SELECT replace(replace((COALESCE(('\'::text || h.caption), ''::text) || COALESCE(('\'::text || (g.caption)::text), ''::text)), '\\\'::text, '\'::text), '\\'::text, '\'::text) AS menupath,
    g.name,
    g.ordno,
    g.levelno,
    g.parent,
    g.type,
    g.pagetype
   FROM ({schema}.axpages g
     LEFT JOIN ( SELECT (COALESCE(('\'::text || f.caption), ''::text) || COALESCE(('\'::text || (e.caption)::text), ''::text)) AS caption,
            e.parent,
            e.name
           FROM ({schema}.axpages e
             LEFT JOIN ( SELECT ((COALESCE(('\'::text || (d.caption)::text), ''::text) || '\'::text) || (COALESCE(c.caption, ''::character varying))::text) AS caption,
                    c.name
                   FROM ({schema}.axpages c
                     LEFT JOIN ( SELECT a.name,
                            a.parent,
                            a.caption,
                            a.levelno,
                            a.ordno,
                            1 AS levlno
                           FROM {schema}.axpages a
                          WHERE (a.levelno = (0)::numeric)
                          ORDER BY a.levelno, a.ordno) d ON (((c.parent)::text = (d.name)::text)))
                  WHERE (c.levelno = ANY (ARRAY[(1)::numeric, (0)::numeric]))) f ON (((e.parent)::text = (f.name)::text)))
          WHERE (e.levelno = ANY (ARRAY[(1)::numeric, (0)::numeric, (2)::numeric]))) h ON (((g.parent)::text = (h.name)::text)))
  WHERE (COALESCE(g.levelno, (0)::numeric) <= (3)::numeric)
  ORDER BY g.ordno, g.levelno;

CREATE VIEW {schema}.vw_axlanguage_export AS
 SELECT 'tstruct'::text AS comptype,
    0 AS ord,
    ('t'::text || (tstructs.name)::text) AS ntransid,
    'x__headtext'::character varying AS compname,
    tstructs.caption,
    0 AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.tstructs
UNION ALL
 SELECT 'tstruct'::text AS comptype,
    1 AS ord,
    ('t'::text || (axpdc.tstruct)::text) AS ntransid,
    axpdc.dname AS compname,
    axpdc.caption,
    ("substring"((axpdc.dname)::text, 3))::numeric AS ord2,
    ("substring"((axpdc.dname)::text, 3))::numeric AS ord3,
    'NA'::text AS hidden
   FROM {schema}.axpdc
UNION ALL
 SELECT 'tstruct'::text AS comptype,
    2 AS ord,
    ('t'::text || (axpflds.tstruct)::text) AS ntransid,
    axpflds.fname AS compname,
    axpflds.caption,
    ("substring"((axpflds.dcname)::text, 3))::numeric AS ord2,
    axpflds.ordno AS ord3,
        CASE
            WHEN ((axpflds.hidden)::text = 'TRUE'::text) THEN 'Yes'::text
            ELSE 'No'::text
        END AS hidden
   FROM {schema}.axpflds
UNION ALL
 SELECT 'tstruct'::text AS comptype,
    4 AS ord,
    ('t'::text || (axtoolbar.name)::text) AS ntransid,
    axtoolbar.key AS compname,
    axtoolbar.title AS caption,
    '100'::numeric AS ord2,
    axtoolbar.ordno AS ord3,
    'NA'::text AS hidden
   FROM {schema}.axtoolbar
  WHERE ((axtoolbar.stype)::text = 'tstruct'::text)
UNION ALL
 SELECT 'tstruct'::text AS comptype,
    5 AS ord,
    ('t'::text || (b.name)::text) AS ntransid,
    a.ctype AS compname,
    a.ccaption AS caption,
    a.ord AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM ( SELECT 'pop1'::text AS ctype,
            'Remove'::text AS ccaption,
            10001 AS ord
        UNION ALL
         SELECT 'pop2'::text AS text,
            'Print'::text AS text,
            10002
        UNION ALL
         SELECT 'pop3'::text AS text,
            'Preview'::text AS text,
            10003
        UNION ALL
         SELECT 'pop4'::text AS text,
            'Regenerate Packets'::text AS text,
            10004
        UNION ALL
         SELECT 'pop5'::text AS text,
            'View History'::text AS text,
            10005
        UNION ALL
         SELECT 'lpop1'::text AS text,
            'Remove'::text AS text,
            10006
        UNION ALL
         SELECT 'lpop2'::text AS text,
            'Print'::text AS text,
            10007
        UNION ALL
         SELECT 'lpop3'::text AS text,
            'Preview'::text AS text,
            10008
        UNION ALL
         SELECT 'lpop4'::text AS text,
            'Params'::text AS text,
            10009
        UNION ALL
         SELECT 'lpop5'::text AS text,
            'Preview Form'::text AS text,
            10010
        UNION ALL
         SELECT 'lpop6'::text AS text,
            'Print Form'::text AS text,
            10011
        UNION ALL
         SELECT 'lpop7'::text AS text,
            'PDF'::text AS text,
            10012
        UNION ALL
         SELECT 'lpop8'::text AS text,
            'Regenerate Packets'::text AS text,
            10013
        UNION ALL
         SELECT 'lpop9'::text AS text,
            'Save As'::text AS text,
            10014
        UNION ALL
         SELECT 'lpop10'::text AS text,
            'To XL'::text AS text,
            10015
        UNION ALL
         SELECT 'lpop11'::text AS text,
            'Rapid XL Export'::text AS text,
            10016
        UNION ALL
         SELECT 'lpop12'::text AS text,
            'View Attachment'::text AS text,
            10017
        UNION ALL
         SELECT 'lblSearh'::text AS text,
            'Search For'::text AS text,
            10018
        UNION ALL
         SELECT 'lblWith'::text AS text,
            'With'::text AS text,
            10019) a,
    {schema}.tstructs b
UNION ALL
 SELECT 'AxPages'::text AS comptype,
    axpages.levelno AS ord,
    NULL::character varying AS ntransid,
    axpages.name AS compname,
    axpages.caption,
    axpages.ordno AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.axpages
UNION ALL
 SELECT 'iview'::text AS comptype,
    0 AS ord,
    ('i'::text || (iviews.name)::text) AS ntransid,
    'x__head'::character varying AS compname,
    iviews.caption,
    1 AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.iviews
UNION ALL
 SELECT 'iview'::text AS comptype,
    1 AS ord,
    ('i'::text || (iviewmain.iname)::text) AS ntransid,
    'RH1'::character varying AS compname,
    iviewmain.header1 AS caption,
    2 AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.iviewmain
UNION ALL
 SELECT 'iview'::text AS comptype,
    2 AS ord,
    ('i'::text || (iviewparams.iname)::text) AS ntransid,
    iviewparams.pname AS compname,
    iviewparams.pcaption AS caption,
    iviewparams.ordno AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.iviewparams
UNION ALL
 SELECT 'iview'::text AS comptype,
    3 AS ord,
    ('i'::text || (iviewcols.iname)::text) AS ntransid,
    iviewcols.f_name AS compname,
    iviewcols.f_caption AS caption,
    iviewcols.ordno AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.iviewcols
UNION ALL
 SELECT 'iview'::text AS comptype,
    4 AS ord,
    ('i'::text || (axtoolbar.name)::text) AS ntransid,
    axtoolbar.key AS compname,
    axtoolbar.title AS caption,
    axtoolbar.ordno AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.axtoolbar
  WHERE ((axtoolbar.stype)::text = 'iview'::text)
UNION ALL
 SELECT 'iview'::text AS comptype,
    5 AS ord,
    ('i'::text || (b.name)::text) AS ntransid,
    a.ctype AS compname,
    a.ccaption AS caption,
    a.ord AS ord2,
    0 AS ord3,
    'NA'::text AS hidden
   FROM {schema}.iviews b,
    ( SELECT 'anac1'::text AS ctype,
            'Column Heading'::text AS ccaption,
            1 AS ord
        UNION ALL
         SELECT 'anac2'::text AS text,
            'Operator'::text AS text,
            2
        UNION ALL
         SELECT 'anac3'::text AS text,
            'Value (s)'::text AS text,
            3
        UNION ALL
         SELECT 'anac4'::text AS text,
            'Relations'::text AS text,
            4
        UNION ALL
         SELECT 'pop1'::text AS text,
            'Delete'::text AS text,
            5
        UNION ALL
         SELECT 'pop2'::text AS text,
            'New'::text AS text,
            6
        UNION ALL
         SELECT 'pop3'::text AS text,
            'Params'::text AS text,
            7
        UNION ALL
         SELECT 'pop4'::text AS text,
            'Preview Form'::text AS text,
            8
        UNION ALL
         SELECT 'pop5'::text AS text,
            'Print Form'::text AS text,
            9
        UNION ALL
         SELECT 'pop6'::text AS text,
            'PDF'::text AS text,
            10
        UNION ALL
         SELECT 'pop7'::text AS text,
            'Regenerate Packets'::text AS text,
            11
        UNION ALL
         SELECT 'pop8'::text AS text,
            'Save As'::text AS text,
            12
        UNION ALL
         SELECT 'pop9'::text AS text,
            'To XL'::text AS text,
            13
        UNION ALL
         SELECT 'pop10'::text AS text,
            'Rapid XL Export'::text AS text,
            14
        UNION ALL
         SELECT 'pop11'::text AS text,
            'View Attachment'::text AS text,
            15) a;

CREATE VIEW {schema}.vw_cards_calendar_data AS
 SELECT DISTINCT a.uname,
    a.axcalendarid,
    a.eventname,
    a.sendername,
    a.messagetext,
    a.eventtype,
    a.startdate,
    COALESCE(a.axptm_starttime, '00:00'::character varying) AS axptm_starttime,
    a.enddate,
        CASE
            WHEN ((COALESCE(a.axptm_endtime, '00:00'::character varying))::text = '00:00'::text) THEN '23:59'::character varying
            ELSE a.axptm_endtime
        END AS axptm_endtime,
    a.location,
    a.status,
    b.eventcolor,
        CASE
            WHEN (a.sourceid = (0)::numeric) THEN a.axcalendarid
            ELSE a.sourceid
        END AS recordid,
    a.eventstatus,
    c.eventstatcolor,
    "substring"((a.mapname)::text, 1, 5) AS mapname
   FROM (({schema}.axcalendar a
     JOIN {schema}.axpdef_axcalendar_event b ON ((a.axpdef_axcalendar_eventid = b.axpdef_axcalendar_eventid)))
     LEFT JOIN ( SELECT axpdef_axcalendar_eventstatus.axpdef_axcalendar_eventid,
            axpdef_axcalendar_eventstatus.eventstatus,
            axpdef_axcalendar_eventstatus.eventstatcolor
           FROM {schema}.axpdef_axcalendar_eventstatus) c ON (((a.axpdef_axcalendar_eventid = c.axpdef_axcalendar_eventid) AND ((a.eventstatus)::text = (c.eventstatus)::text))))
  WHERE (((a.cancel)::text = 'F'::text) AND (a.parenteventid > (0)::numeric))
UNION ALL
 SELECT DISTINCT a.sendername AS uname,
    a.axcalendarid,
    a.eventname,
    a.sendername,
    a.messagetext,
    a.eventtype,
    a.startdate,
    COALESCE(a.axptm_starttime, '00:00'::character varying) AS axptm_starttime,
        CASE
            WHEN (a.recurring IS NULL) THEN a.enddate
            ELSE a.startdate
        END AS enddate,
        CASE
            WHEN ((COALESCE(a.axptm_endtime, '00:00'::character varying))::text = '00:00'::text) THEN '23:59'::character varying
            ELSE a.axptm_endtime
        END AS axptm_endtime,
    a.location,
    a.status,
    b.eventcolor,
        CASE
            WHEN (a.sourceid = (0)::numeric) THEN a.axcalendarid
            ELSE a.sourceid
        END AS recordid,
    a.eventstatus,
    c.eventstatcolor,
    "substring"((a.mapname)::text, 1, 5) AS mapname
   FROM (({schema}.axcalendar a
     JOIN {schema}.axpdef_axcalendar_event b ON ((a.axpdef_axcalendar_eventid = b.axpdef_axcalendar_eventid)))
     LEFT JOIN ( SELECT axpdef_axcalendar_eventstatus.axpdef_axcalendar_eventid,
            axpdef_axcalendar_eventstatus.eventstatus,
            axpdef_axcalendar_eventstatus.eventstatcolor
           FROM {schema}.axpdef_axcalendar_eventstatus) c ON (((a.axpdef_axcalendar_eventid = c.axpdef_axcalendar_eventid) AND ((a.eventstatus)::text = (c.eventstatus)::text))))
  WHERE (((a.cancel)::text = 'F'::text) AND (a.parenteventid = (0)::numeric))
  ORDER BY 7;

CREATE VIEW {schema}.vw_cards_dashboard AS
 SELECT a.cardtype,
    a.cardname,
    a.cardicon,
    a.charttype,
    a.pluginname,
        CASE
            WHEN (a.pluginname IS NULL) THEN a.html_editor_card
            ELSE h.htmltext
        END AS htmltext,
    a.card_datasource,
    s.sqltext,
    a.width,
    a.height,
    a.autorefresh,
    unnest(string_to_array((a.accessstringui)::text, ','::text)) AS uroles,
    a.axp_cardsid,
    h.context,
    a.orderno,
    a.chartjson
   FROM (({schema}.axp_cards a
     LEFT JOIN {schema}.ax_htmlplugins h ON (((a.pluginname)::text = (h.name)::text)))
     LEFT JOIN {schema}.axdirectsql s ON (((a.card_datasource)::text = (s.sqlname)::text)))
  WHERE ((a.indashboard)::text = 'T'::text);

CREATE VIEW {schema}.vw_cards_homepages AS
 SELECT a.cardtype,
    a.cardname,
    a.cardicon,
    a.charttype,
    a.pluginname,
        CASE
            WHEN (a.pluginname IS NULL) THEN a.html_editor_card
            ELSE h.htmltext
        END AS htmltext,
    a.card_datasource,
    s.sqltext,
    a.width,
    a.height,
    a.autorefresh,
    unnest(string_to_array((a.accessstringui)::text, ','::text)) AS uroles,
    a.axp_cardsid,
    h.context,
    a.orderno,
    a.chartjson
   FROM (({schema}.axp_cards a
     LEFT JOIN {schema}.ax_htmlplugins h ON (((a.pluginname)::text = (h.name)::text)))
     LEFT JOIN {schema}.axdirectsql s ON (((a.card_datasource)::text = (s.sqlname)::text)))
  WHERE ((a.inhomepage)::text = 'T'::text);

CREATE VIEW {schema}.vw_entityrelations AS
 SELECT DISTINCT nextval('{schema}.ax_entity_relseq'::regclass) AS axentityrelationsid,
    'F'::text AS cancel,
    'admin'::text AS username,
    CURRENT_TIMESTAMP AS modifiedon,
    'admin'::text AS createdby,
    CURRENT_TIMESTAMP AS createdon,
    1 AS app_level,
    1 AS app_desc,
    a.rtype,
    a.mstruct,
    a.mfield,
    m.tablename AS mtable,
    dc.tablename AS primarytable,
    a.dstruct,
    a.dfield,
    d.tablename AS dtable,
    'Dropdown'::text AS rtypeui,
    concat(mt.caption, '-(', mt.name, ')') AS mstructui,
    concat(m.caption, '-(', m.fname, ')') AS mfieldui,
    concat(dt.caption, '-(', dt.name, ')') AS dstructui,
    concat(d.caption, '-(', d.fname, ')') AS dfieldui,
    ddc.tablename AS dprimarytable
   FROM ((((((( SELECT DISTINCT axrelations.mstruct,
            axrelations.dstruct,
            axrelations.mfield,
            axrelations.dfield,
            axrelations.rtype
           FROM {schema}.axrelations) a
     JOIN {schema}.tstructs mt ON (((a.mstruct)::text = (mt.name)::text)))
     JOIN {schema}.tstructs dt ON (((a.dstruct)::text = (dt.name)::text)))
     LEFT JOIN {schema}.axpflds m ON ((((a.mstruct)::text = (m.tstruct)::text) AND ((a.mfield)::text = (m.fname)::text))))
     LEFT JOIN {schema}.axpflds d ON ((((a.dstruct)::text = (d.tstruct)::text) AND ((a.dfield)::text = (d.fname)::text))))
     LEFT JOIN {schema}.axpdc dc ON ((((a.mstruct)::text = (dc.tstruct)::text) AND ((dc.dname)::text = 'dc1'::text))))
     LEFT JOIN {schema}.axpdc ddc ON ((((a.dstruct)::text = (ddc.tstruct)::text) AND ((ddc.dname)::text = 'dc1'::text))))
  WHERE ((a.rtype)::text = 'md'::text)
UNION ALL
 SELECT DISTINCT nextval('{schema}.ax_entity_relseq'::regclass) AS axentityrelationsid,
    'F'::text AS cancel,
    'admin'::text AS username,
    CURRENT_TIMESTAMP AS modifiedon,
    'admin'::text AS createdby,
    CURRENT_TIMESTAMP AS createdon,
    1 AS app_level,
    1 AS app_desc,
    'gm'::character varying AS rtype,
    a.tstruct AS mstruct,
    concat(sd.tablename, 'id') AS mfield,
    sd.tablename AS mtable,
    pd.tablename AS primarytable,
    a.targettstr AS dstruct,
    'sourceid'::character varying AS dfield,
    td.tablename AS dtable,
    'Genmap'::text AS rtypeui,
    concat(mt.caption, '-(', mt.name, ')') AS mstructui,
    NULL::text AS mfieldui,
    concat(dt.caption, '-(', dt.name, ')') AS dstructui,
    NULL::text AS dfieldui,
    td.tablename AS dprimarytable
   FROM ((((({schema}.axpgenmaps a
     JOIN {schema}.tstructs mt ON (((a.tstruct)::text = (mt.name)::text)))
     JOIN {schema}.tstructs dt ON (((a.targettstr)::text = (dt.name)::text)))
     LEFT JOIN {schema}.axpdc sd ON ((((a.tstruct)::text = (sd.tstruct)::text) AND ((sd.dname)::text = (a.basedondc)::text))))
     LEFT JOIN {schema}.axpdc td ON ((((a.targettstr)::text = (td.tstruct)::text) AND ((td.dname)::text = 'dc1'::text))))
     LEFT JOIN {schema}.axpdc pd ON ((((a.tstruct)::text = (pd.tstruct)::text) AND ((pd.dname)::text = 'dc1'::text))));

CREATE VIEW {schema}.vw_pegv2_activetasks AS
 SELECT DISTINCT a.touser,
    a.processname,
    a.taskname,
    a.taskid,
    a.tasktype,
    a.eventdatetime AS edatetime,
    to_char(to_timestamp((a.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    a.fromuser,
    a.fromrole,
    a.displayicon,
    a.displaytitle,
    a.displaymcontent,
    a.displaycontent,
    a.displaybuttons,
    a.keyfield,
    a.keyvalue,
    a.transid,
    a.priorindex,
    a.indexno,
    a.subindexno,
    a.approvereasons,
    a.defapptext,
    a.returnreasons,
    a.defrettext,
    a.rejectreasons,
    a.defregtext,
    aa.recordid,
    a.approvalcomments,
    a.rejectcomments,
    a.returncomments,
    'PEG'::text AS rectype,
    'NA'::text AS msgtype,
    a.returnable,
    a.initiator,
    a.initiator_approval,
    a.displaysubtitle,
    p.amendment,
    a.allowsend,
    a.allowsendflg,
    b.cmsg_appcheck,
    b.cmsg_return,
    b.cmsg_reject,
    b.showbuttons,
    NULL::text AS hlink,
    NULL::text AS hlink_transid,
    NULL::text AS hlink_params
   FROM ((({schema}.axactivetasks a
     JOIN {schema}.axprocessdefv2 b ON ((((a.processname)::text = (b.processname)::text) AND ((a.taskname)::text = (b.taskname)::text))))
     JOIN {schema}.axpdef_peg_processmaster p ON (((a.processname)::text = (p.caption)::text)))
     LEFT JOIN {schema}.axactivetasks aa ON ((((a.processname)::text = (aa.processname)::text) AND ((a.keyvalue)::text = (aa.keyvalue)::text) AND ((a.transid)::text = (aa.transid)::text) AND ((aa.tasktype)::text = 'Make'::text) AND (aa.recordid IS NOT NULL))))
  WHERE ((NOT (EXISTS ( SELECT b_1.taskid
           FROM {schema}.axactivetaskstatus b_1
          WHERE ((a.taskid)::text = (b_1.taskid)::text)))) AND ((a.removeflg)::text = 'F'::text))
UNION ALL
 SELECT axactivemessages.touser,
    axactivemessages.processname,
    axactivemessages.taskname,
    axactivemessages.taskid,
    axactivemessages.tasktype,
    axactivemessages.eventdatetime AS edatetime,
    to_char(to_timestamp((axactivemessages.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    axactivemessages.fromuser,
    NULL::character varying AS fromrole,
    axactivemessages.displayicon,
    axactivemessages.displaytitle,
    NULL::text AS displaymcontent,
    axactivemessages.displaycontent,
    NULL::character varying AS displaybuttons,
    axactivemessages.keyfield,
    axactivemessages.keyvalue,
    axactivemessages.transid,
    0 AS priorindex,
    axactivemessages.indexno,
    0 AS subindexno,
    NULL::character varying AS approvereasons,
    NULL::character varying AS defapptext,
    NULL::character varying AS returnreasons,
    NULL::character varying AS defrettext,
    NULL::character varying AS rejectreasons,
    NULL::character varying AS defregtext,
    0 AS recordid,
    NULL::character varying AS approvalcomments,
    NULL::character varying AS rejectcomments,
    NULL::character varying AS returncomments,
    'MSG'::text AS rectype,
    axactivemessages.msgtype,
    'F'::character varying AS returnable,
    NULL::character varying AS initiator,
    NULL::character varying AS initiator_approval,
    NULL::character varying AS displaysubtitle,
    p.amendment,
    'F'::character varying AS allowsend,
    'F'::character varying AS allowsendflg,
    NULL::text AS cmsg_appcheck,
    NULL::text AS cmsg_return,
    NULL::text AS cmsg_reject,
    NULL::character varying AS showbuttons,
    axactivemessages.hlink,
    axactivemessages.hlink_transid,
    axactivemessages.hlink_params
   FROM ({schema}.axactivemessages
     LEFT JOIN {schema}.axpdef_peg_processmaster p ON (((axactivemessages.processname)::text = (p.caption)::text)))
  WHERE (NOT (EXISTS ( SELECT b.taskid
           FROM {schema}.axactivetaskstatus b
          WHERE ((axactivemessages.taskid)::text = (b.taskid)::text))));

CREATE VIEW {schema}.vw_pegv2_alltasks AS
 SELECT DISTINCT a.touser,
    a.processname,
    a.taskname,
    a.taskid,
    a.tasktype,
    a.eventdatetime AS edatetime,
    to_char(to_timestamp((a.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    a.fromuser,
    a.fromrole,
    a.displayicon,
    a.displaytitle,
    a.displaymcontent,
    a.displaycontent,
    a.displaybuttons,
    a.keyfield,
    a.keyvalue,
    a.transid,
    a.priorindex,
    a.indexno,
    a.subindexno,
    a.approvereasons,
    a.defapptext,
    a.returnreasons,
    a.defrettext,
    a.rejectreasons,
    a.defregtext,
    aa.recordid,
    a.approvalcomments,
    a.rejectcomments,
    a.returncomments,
    'PEG'::text AS rectype,
    'NA'::text AS msgtype,
    a.returnable,
    a.initiator,
    a.initiator_approval,
    a.displaysubtitle,
    p.amendment,
    a.allowsend,
    a.allowsendflg,
    b.cmsg_appcheck,
    b.cmsg_return,
    b.cmsg_reject,
    b.showbuttons,
    NULL::text AS hlink,
    NULL::text AS hlink_transid,
    NULL::text AS hlink_params,
    NULL::text AS taskstatus,
    NULL::text AS statusreason,
    NULL::text AS statustext,
    NULL::text AS cancelremarks,
    NULL::text AS cancelledby,
    NULL::text AS cancelledon,
    NULL::text AS cancel,
    NULL::text AS username,
    'Active'::text AS cstatus
   FROM ((({schema}.axactivetasks a
     JOIN {schema}.axprocessdefv2 b ON ((((a.processname)::text = (b.processname)::text) AND ((a.taskname)::text = (b.taskname)::text))))
     JOIN {schema}.axpdef_peg_processmaster p ON (((a.processname)::text = (p.caption)::text)))
     LEFT JOIN {schema}.axactivetasks aa ON ((((a.processname)::text = (aa.processname)::text) AND ((a.keyvalue)::text = (aa.keyvalue)::text) AND ((a.transid)::text = (aa.transid)::text) AND ((aa.tasktype)::text = 'Make'::text) AND (aa.recordid IS NOT NULL))))
  WHERE ((NOT (EXISTS ( SELECT b_1.taskid
           FROM {schema}.axactivetaskstatus b_1
          WHERE ((a.taskid)::text = (b_1.taskid)::text)))) AND ((a.removeflg)::text = 'F'::text))
UNION ALL
 SELECT axactivemessages.touser,
    axactivemessages.processname,
    axactivemessages.taskname,
    axactivemessages.taskid,
    axactivemessages.tasktype,
    axactivemessages.eventdatetime AS edatetime,
    to_char(to_timestamp((axactivemessages.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    axactivemessages.fromuser,
    NULL::character varying AS fromrole,
    axactivemessages.displayicon,
    axactivemessages.displaytitle,
    NULL::text AS displaymcontent,
    axactivemessages.displaycontent,
    NULL::character varying AS displaybuttons,
    axactivemessages.keyfield,
    axactivemessages.keyvalue,
    axactivemessages.transid,
    0 AS priorindex,
    axactivemessages.indexno,
    0 AS subindexno,
    NULL::character varying AS approvereasons,
    NULL::character varying AS defapptext,
    NULL::character varying AS returnreasons,
    NULL::character varying AS defrettext,
    NULL::character varying AS rejectreasons,
    NULL::character varying AS defregtext,
    0 AS recordid,
    NULL::character varying AS approvalcomments,
    NULL::character varying AS rejectcomments,
    NULL::character varying AS returncomments,
    'MSG'::text AS rectype,
    axactivemessages.msgtype,
    'F'::character varying AS returnable,
    NULL::character varying AS initiator,
    NULL::character varying AS initiator_approval,
    NULL::character varying AS displaysubtitle,
    p.amendment,
    'F'::character varying AS allowsend,
    'F'::character varying AS allowsendflg,
    NULL::text AS cmsg_appcheck,
    NULL::text AS cmsg_return,
    NULL::text AS cmsg_reject,
    NULL::character varying AS showbuttons,
    axactivemessages.hlink,
    axactivemessages.hlink_transid,
    axactivemessages.hlink_params,
    NULL::text AS taskstatus,
    NULL::text AS statusreason,
    NULL::text AS statustext,
    NULL::text AS cancelremarks,
    NULL::text AS cancelledby,
    NULL::text AS cancelledon,
    NULL::text AS cancel,
    NULL::text AS username,
    'Active'::text AS cstatus
   FROM ({schema}.axactivemessages
     LEFT JOIN {schema}.axpdef_peg_processmaster p ON (((axactivemessages.processname)::text = (p.caption)::text)))
  WHERE (NOT (EXISTS ( SELECT b.taskid
           FROM {schema}.axactivetaskstatus b
          WHERE ((axactivemessages.taskid)::text = (b.taskid)::text))))
UNION ALL
 SELECT a.touser,
    a.processname,
    a.taskname,
    a.taskid,
    a.tasktype,
    a.eventdatetime AS edatetime,
    to_char(to_timestamp((a.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    a.fromuser,
    a.fromrole,
    a.displayicon,
    a.displaytitle,
    a.displaymcontent,
    a.displaycontent,
    a.displaybuttons,
    a.keyfield,
    a.keyvalue,
    a.transid,
    a.priorindex,
    a.indexno,
    a.subindexno,
    a.approvereasons,
    a.defapptext,
    a.returnreasons,
    a.defrettext,
    a.rejectreasons,
    a.defregtext,
    a.recordid,
    a.approvalcomments,
    a.rejectcomments,
    a.returncomments,
    'PEG'::text AS rectype,
    'NA'::text AS msgtype,
    a.returnable,
    a.initiator,
    a.initiator_approval,
    a.displaysubtitle,
    NULL::character varying AS amendment,
    a.allowsend,
    a.allowsendflg,
    NULL::text AS cmsg_appcheck,
    NULL::text AS cmsg_return,
    NULL::text AS cmsg_reject,
    NULL::character varying AS showbuttons,
    NULL::text AS hlink,
    NULL::text AS hlink_transid,
    NULL::text AS hlink_params,
    {schema}.pr_pegv2_transcurstatus(a.transid, a.keyvalue, a.processname) AS taskstatus,
    b.statusreason,
    b.statustext,
    b.cancelremarks,
    b.cancelledby,
    (b.cancelledon)::character varying AS cancelledon,
    b.cancel,
        CASE
            WHEN (a.indexno = (1)::numeric) THEN a.fromuser
            ELSE a.touser
        END AS username,
    'Completed'::text AS cstatus
   FROM ({schema}.axactivetasks a
     JOIN {schema}.axactivetaskstatus b ON (((a.taskid)::text = (b.taskid)::text)));

CREATE VIEW {schema}.vw_pegv2_completed_tasks AS
 SELECT a.processname,
    a.taskname,
    a.tasktype,
    to_char(to_timestamp((b.eventdatetime)::text, 'YYYYMMDDHH24MISSSSS'::text), 'dd/mm/yyyy hh24:mi:ss'::text) AS eventdatetime,
    a.eventdatetime AS edatetime,
    a.fromuser,
    a.displayicon,
    a.displaytitle,
    a.taskid,
    a.keyfield,
    a.keyvalue,
    a.recordid,
    a.transid,
    a.displaycontent,
    a.indexno,
    b.taskstatus,
    b.statusreason,
    b.statustext,
    b.cancelremarks,
    b.cancelledby,
    b.cancelledon,
    b.cancel,
    b.username
   FROM ({schema}.axactivetasks a
     JOIN {schema}.axactivetaskstatus b ON ((((a.taskid)::text = (b.taskid)::text) AND ((
        CASE
            WHEN (a.indexno = (1)::numeric) THEN a.fromuser
            ELSE a.touser
        END)::text = (b.username)::text))));

CREATE VIEW {schema}.vw_pegv2_global_cards AS
 WITH a AS (
         SELECT a_1.card,
            a_1.ctype,
            a_1.axprocessdefv2id,
            a_1.processname,
            a_1.taskname
           FROM ( SELECT "substring"(unnest(string_to_array((a_2.cards)::text, ','::text)), ("position"(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text) + 2), abs((("position"(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text) + 2) - length("substring"(unnest(string_to_array((a_2.cards)::text, ','::text)), 1, length(unnest(string_to_array((a_2.cards)::text, ','::text)))))))) AS card,
                    split_part(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text, 1) AS ctype,
                    b_1.axprocessdefv2id,
                    b_1.processname,
                    b_1.taskname
                   FROM {schema}.axpdef_peg_processmaster a_2,
                    {schema}.axprocessdefv2 b_1
                  WHERE (((a_2.caption)::text = (b_1.processname)::text) AND ((b_1.stransid)::text <> 'pgv2c'::text))) a_1
          WHERE (a_1.ctype = 'Global'::text)
        ), b AS (
         SELECT a_1.hidecard,
            a_1.ctype,
            a_1.axprocessdefv2id,
            a_1.processname,
            a_1.taskname
           FROM ( SELECT "substring"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), ("position"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text) + 2), abs((("position"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text) + 2) - length("substring"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), 1, length(unnest(string_to_array((b_1.hidecards)::text, ','::text)))))))) AS hidecard,
                    split_part(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text, 1) AS ctype,
                    b_1.axprocessdefv2id,
                    b_1.processname,
                    b_1.taskname
                   FROM {schema}.axprocessdefv2 b_1
                  WHERE ((b_1.stransid)::text <> 'pgv2c'::text)) a_1
          WHERE (a_1.ctype = 'Global'::text)
        )
 SELECT a.axprocessdefv2id,
    a.processname,
    a.taskname,
    d.cardname,
    d.axp_cardsid AS cardsid,
    d.sql_editor_cardsql AS cardsql,
    d.cardtype,
    d.charttype,
    d.chartjson,
    'col-md-12'::text AS width,
    'Global'::text AS ctype,
    'NA'::text AS accessstring
   FROM ((a
     LEFT JOIN b ON ((((a.processname)::text = (b.processname)::text) AND ((a.taskname)::text = (b.taskname)::text) AND (a.card = b.hidecard))))
     JOIN {schema}.axp_cards d ON ((a.card = (d.cardname)::text)))
  WHERE (b.hidecard IS NULL);

CREATE VIEW {schema}.vw_pegv2_process_cards AS
 WITH a AS (
         SELECT a_1.card,
            a_1.ctype,
            a_1.axprocessdefv2id,
            a_1.processname,
            a_1.taskname
           FROM ( SELECT "substring"(unnest(string_to_array((a_2.cards)::text, ','::text)), ("position"(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text) + 2), abs((("position"(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text) + 2) - length("substring"(unnest(string_to_array((a_2.cards)::text, ','::text)), 1, length(unnest(string_to_array((a_2.cards)::text, ','::text)))))))) AS card,
                    split_part(unnest(string_to_array((a_2.cards)::text, ','::text)), '-('::text, 1) AS ctype,
                    b_1.axprocessdefv2id,
                    b_1.processname,
                    b_1.taskname
                   FROM {schema}.axpdef_peg_processmaster a_2,
                    {schema}.axprocessdefv2 b_1
                  WHERE (((a_2.caption)::text = (b_1.processname)::text) AND ((b_1.stransid)::text <> 'pgv2c'::text))) a_1
          WHERE (a_1.ctype = 'Process'::text)
        ), b AS (
         SELECT a_1.hidecard,
            a_1.ctype,
            a_1.axprocessdefv2id,
            a_1.processname,
            a_1.taskname
           FROM ( SELECT "substring"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), ("position"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text) + 2), abs((("position"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text) + 2) - length("substring"(unnest(string_to_array((b_1.hidecards)::text, ','::text)), 1, length(unnest(string_to_array((b_1.hidecards)::text, ','::text)))))))) AS hidecard,
                    split_part(unnest(string_to_array((b_1.hidecards)::text, ','::text)), '-('::text, 1) AS ctype,
                    b_1.axprocessdefv2id,
                    b_1.processname,
                    b_1.taskname
                   FROM {schema}.axprocessdefv2 b_1
                  WHERE ((b_1.stransid)::text <> 'pgv2c'::text)) a_1
          WHERE (a_1.ctype = 'Process'::text)
        )
 SELECT a.axprocessdefv2id,
    a.processname,
    a.taskname,
    d.cardname,
    d.axpdef_prcardsid AS cardsid,
    d.sql_editor_cardsql AS cardsql,
    d.cardtype,
    d.charttype,
    d.chartjson,
    'col-md-12'::text AS width,
    'Process'::text AS ctype,
    'NA'::text AS accessstring
   FROM ((a
     LEFT JOIN b ON ((((a.processname)::text = (b.processname)::text) AND ((a.taskname)::text = (b.taskname)::text) AND (a.card = b.hidecard))))
     JOIN {schema}.axpdef_prcards d ON ((a.card = (d.cardname)::text)))
  WHERE (b.hidecard IS NULL);

CREATE VIEW {schema}.vw_pegv2_processdef_cards AS
 WITH a AS (
         SELECT a_1.caption,
            c.taskname,
            regexp_split_to_table((a_1.cards)::text, ','::text) AS card,
            c.axprocessdefv2id
           FROM {schema}.axpdef_peg_processmaster a_1,
            {schema}.axprocessdefv2 c
          WHERE (a_1.axpdef_peg_processmasterid = c.axpdef_peg_processmasterid)
        ), b AS (
         SELECT axprocessdefv2.processname,
            axprocessdefv2.taskname,
            regexp_split_to_table((COALESCE(axprocessdefv2.hidecards, 'NA'::character varying))::text, ','::text) AS hidecard
           FROM {schema}.axprocessdefv2
        )
 SELECT a.axprocessdefv2id,
    a.caption AS processname,
    a.taskname,
    d.cardname,
    d.axp_cardsid,
    d.sql_editor_cardsql,
    d.cardtype,
    d.chartjson,
    d.pagecaption,
    d.pagename,
    d.hcaption,
    d.htype,
    d.htransid
   FROM ((a
     LEFT JOIN b ON ((((a.caption)::text = (b.processname)::text) AND ((a.taskname)::text = (b.taskname)::text) AND (a.card = b.hidecard))))
     JOIN {schema}.axp_cards d ON ((a.card = (d.cardname)::text)))
  WHERE (b.hidecard IS NULL);

CREATE VIEW {schema}.vw_pegv2_processdef_tree AS
 SELECT axprocessdefv2.processname,
    axprocessdefv2.taskname,
    axprocessdefv2.tasktype,
    axprocessdefv2.taskgroupname AS taskgroup,
    axprocessdefv2.active AS taskactive,
    axprocessdefv2.indexno,
    axprocessdefv2.subindexno AS subindex,
    axprocessdefv2.groupwithprior AS details,
    axprocessdefv2.transid,
    axprocessdefv2.axprocessdefv2id AS recordid,
    axprocessdefv2.displayicon,
    axprocessdefv2.groupwithprior,
    axprocessdefv2.keyfield
   FROM {schema}.axprocessdefv2;

CREATE VIEW {schema}.vw_username_role_menu_access AS
 SELECT a2.username,
    a3.groupname,
    a5.rname,
    a5.sname,
    a5.stype,
        CASE a5.stype
            WHEN 't'::text THEN t.caption
            WHEN 'i'::text THEN i.caption
            WHEN 'p'::text THEN p.caption
            ELSE NULL::character varying
        END AS caption
   FROM (((((({schema}.axusergroups a3
     JOIN {schema}.axusergroupsdetail a4 ON ((a3.axusergroupsid = a4.axusergroupsid)))
     JOIN {schema}.axuseraccess a5 ON (((a4.roles_id)::text = (a5.rname)::text)))
     LEFT JOIN {schema}.axuserlevelgroups a2 ON ((((a2.usergroup)::text = (a3.groupname)::text) AND ((a2.usergroup)::text <> 'default'::text))))
     LEFT JOIN {schema}.tstructs t ON ((((a5.sname)::text = (t.name)::text) AND (t.blobno = (1)::numeric))))
     LEFT JOIN {schema}.iviews i ON (((a5.sname)::text = (i.name)::text)))
     LEFT JOIN {schema}.axpages p ON ((((a5.sname)::text = (p.name)::text) AND ((p.pagetype)::text = 'web'::text))))
UNION ALL
 SELECT DISTINCT a2.username,
    'default'::text AS groupname,
    'default'::text AS rname,
    t.name AS sname,
    't'::text AS stype,
    t.caption
   FROM ({schema}.tstructs t
     LEFT JOIN {schema}.axuserlevelgroups a2 ON (((a2.usergroup)::text = 'default'::text)))
  WHERE (t.blobno = (1)::numeric)
UNION ALL
 SELECT DISTINCT a2.username,
    'default'::text AS groupname,
    'default'::text AS rname,
    i.name AS sname,
    'i'::text AS stype,
    i.caption
   FROM ({schema}.iviews i
     LEFT JOIN {schema}.axuserlevelgroups a2 ON (((a2.usergroup)::text = 'default'::text)))
UNION ALL
 SELECT DISTINCT a2.username,
    'default'::text AS groupname,
    'default'::text AS rname,
    p.name AS sname,
    'p'::text AS stype,
    p.caption
   FROM ({schema}.axpages p
     LEFT JOIN {schema}.axuserlevelgroups a2 ON (((a2.usergroup)::text = 'default'::text)))
  WHERE ((p.pagetype)::text = 'web'::text);
