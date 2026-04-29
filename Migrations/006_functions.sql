-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE FUNCTION {schema}.add_months(start date, months integer) RETURNS date
    LANGUAGE sql IMMUTABLE
    SET search_path = {schema}, pg_catalog
    AS $$
  SELECT (start + (months || ' months')::INTERVAL)::DATE
$$;

CREATE FUNCTION {schema}.axi_firesql(p_sql text, p_param_string text) RETURNS json
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
    v_sql TEXT := p_sql;
    v_pair TEXT;
    v_pairs TEXT[];
    v_param_name TEXT;
    v_param_value TEXT;
    v_final_sql TEXT;
    v_result JSON;
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
    v_final_sql := '
        SELECT json_build_object(
            ''data'',
            COALESCE(json_agg(row_data), ''[]''::json)
        )
        FROM (
            SELECT row_id,
                   json_object_agg(
                       CASE 
                           WHEN ordinality = 1 THEN ''displaydata''
                           ELSE key
                       END,
                       COALESCE(value, '''')
                       ORDER BY ordinality
                   ) AS row_data
            FROM (
                SELECT 
                    row_number() OVER () AS row_id,
                    js
                FROM (
                    SELECT row_to_json(q) AS js
                    FROM (' || v_sql || ') q
                ) x
            ) r,
            LATERAL json_each_text(r.js) WITH ORDINALITY
            GROUP BY row_id
        ) s
    ';
    EXECUTE v_final_sql INTO v_result;
    RETURN v_result;
END;
$$;

CREATE FUNCTION {schema}.axi_firesql_v2(p_sql text, p_param_string text, p_sourcekey text, p_fromlist text) RETURNS TABLE(id text, displaydata text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
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
         FROM unnest(string_to_array(' || quote_literal(p_fromlist) || ', '','')) AS value';
    ELSE        
        IF upper(coalesce(p_sourcekey,'F')) = 'T' THEN

            RETURN QUERY EXECUTE
            'SELECT 
                 col1::text AS id,
                 col2::text AS displaydata
             FROM (
                 SELECT *
                 FROM (' || v_sql || ') q
             ) sub(col1, col2)';        
        ELSE

            RETURN QUERY EXECUTE
            'SELECT 
                 ''0'' AS id,
                 col1::text AS displaydata
             FROM (
                 SELECT *
                 FROM (' || v_sql || ') q
             ) sub(col1)';

        END IF;

    END IF;

END;
$$;

CREATE FUNCTION {schema}.axp_pr_page_creation(pname character varying, pcaption character varying, ppagetype character varying, pparentname character varying, paction character varying, props character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
   pparent    VARCHAR (50);
   pordno     NUMERIC (15);
   plevelno   NUMERIC (15);
   psysdate   VARCHAR (30);

BEGIN

    IF LOWER (paction) <> 'delete' THEN
      --Page Creation before or after

      SELECT parent, ordno, levelno INTO pparent, pordno, plevelno
        FROM (SELECT parent,CASE WHEN LOWER (paction) = 'before' THEN ordno ELSE ordno + 1 END ordno, levelno
                FROM axp_vw_menulist
               WHERE name = pparentname AND TYPE = 'p'
              UNION ALL
               SELECT a.name,MAX (b.ordno) + 1 AS ordno,a.levelno + 1 AS levelno
                  FROM axp_vw_menulist a, axp_vw_menulist b
                 WHERE a.name = pparentname AND b.menupath LIKE replace(a.menupath,'\','\\') || '%'  AND a.TYPE = 'h'
              GROUP BY a.name, a.levelno) a;

      psysdate := TRIM (TO_CHAR (SYSDATE(), 'dd/mm/yyyy hh24:mi:ss'));

      UPDATE axpages SET ordno = ordno + 1 WHERE ordno >= pordno;

      INSERT INTO axpages (name,caption,blobno,visible,TYPE,parent,props,ordno,levelno,pagetype,createdon,
							updatedon,importedon)
           VALUES (pname,pcaption,1,'T','p',pparent,props,pordno,plevelno,ppagetype,psysdate,psysdate,psysdate);

     
   ELSE
      --Page Deleting
      SELECT ordno INTO pordno FROM axp_vw_menulist WHERE name = pname AND TYPE = 'p';

      DELETE FROM axpages WHERE name = pname; 

      UPDATE axpages SET ordno = ordno - 1 WHERE ordno >= pordno and pordno>0 ;

	

   END IF;

END;
$$;

CREATE FUNCTION {schema}.axp_tr_search_appsearch() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    BEGIN
    if TG_OP = 'INSERT' or TG_OP = 'UPDATE' then
    if  new.periodically ='T' or new.srctable is  null or new.srcfield is  null then
if TG_OP = 'INSERT'   then 
insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values(new.hltype,new.structname, case when new.periodically ='T' then new.searchtext else  new.caption end ,new.params,new.docid);
else if TG_OP = 'UPDATE'  then
insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values(old.hltype,old.structname, case when old.periodically ='T' then old.searchtext else  old.caption end ,old.params,old.docid);
 end if;
  end if; 
  
  END IF;
  end if;

if TG_OP = 'DELETE'  then 
   delete from axp_appsearch_data_v2 where docid = old.docid;
    execute 'drop trigger IF EXISTS axp_sch_'||old.docid|| ' ON '||OLD.srctable||';';
     execute 'DROP FUNCTION IF EXISTS '||'axp_sch_'||old.docid||';';
end if;

  RETURN NEW;
 exception
      when unique_violation then
      update axp_appsearch_data_v2 set  hltype= new.hltype , structname = new.structname,searchtext = case when new.periodically ='T' then new.searchtext else  new.caption end  ,params=new.params where docid= new.docid;
         RETURN NEW;
    END;
$$;

CREATE FUNCTION {schema}.count_dcs(p_transid character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare 
    l_result varchar(15);
begin
select string_agg(b.name,', ' order by stransid) dcs into l_result
  from axpdef_dc b
  where b.stransid =p_transid  ;
    return l_result;
end; $$;

CREATE FUNCTION {schema}.datediff(units character varying, start_t timestamp without time zone, end_t timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
diff_interval INTERVAL; 
diff INT = 0;
years_diff INT = 0;
BEGIN
IF units IN ('yy', 'yyyy', 'year', 'mm', 'm', 'month') THEN
years_diff = DATE_PART('year', end_t) - DATE_PART('year', start_t);
IF units IN ('yy', 'yyyy', 'year') THEN
RETURN years_diff;
ELSE
RETURN years_diff * 12 + (DATE_PART('month', end_t) - DATE_PART('month', start_t)); 
END IF;
END IF;
diff_interval = end_t - start_t;
diff = diff + DATE_PART('day', diff_interval);
IF units IN ('wk', 'ww', 'week') THEN
diff = diff/7;
RETURN diff;
END IF;
IF units IN ('dd', 'd', 'day') THEN
RETURN diff;
END IF;
diff = diff * 24 + DATE_PART('hour', diff_interval); 
IF units IN ('hh', 'hour') THEN
RETURN diff;
END IF;
diff = diff * 60 + DATE_PART('minute', diff_interval);
IF units IN ('mi', 'n', 'minute') THEN
 RETURN diff;
END IF;
diff = diff * 60 + DATE_PART('second', diff_interval);
RETURN diff;
END;
$$;

CREATE FUNCTION {schema}.execute_sql_list(sql_list text, sql_separator character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
    query text;
BEGIN
    query := replace(sql_list, sql_separator, E';\n');
    IF query IS NOT NULL AND query <> '' THEN
        EXECUTE query;
    END IF;
END;
$$;

CREATE FUNCTION {schema}.fn_ax_homebuild_master() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
	select nextval('ax_homebuild_master_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.HOMEBUILD_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_layoutdesign() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	declare 
	v_sid numeric(15);
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		select nextval('ax_layoutdesign_seq') into v_sid; 
		
		NEW.DESIGN_ID = v_sid;
		
		return new;
	end if;
		
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_layoutdesign_saved() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	declare 
	v_sid numeric(15);
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		select nextval('ax_layoutdesign_saved_seq') into v_sid; 
		
		NEW.DESIGN_ID = v_sid;
		
		return new;
	end if;
		
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_notify() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_notify_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.NOTIFICATION_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_page_saved() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_page_saved_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.PAGE_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_page_templates() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_page_template_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.TEMPLATE_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_pages() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_pages_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.PAGE_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_widget() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
	select nextval('ax_widg_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.widget_id = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_widget_published() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_widget_publish_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.WIDGET_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_ax_widget_saved() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
		select nextval('ax_widget_saved_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.WIDGET_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_axactivetasks() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_grpname varchar[] DEFAULT  ARRAY[]::varchar[];
usercount int;
v_assignmodecnd int;
v_defusers varchar;
v_datagrpusers varchar;
v_usergrpuser varchar;
v_initiator_usergrps varchar;
v_processonwer_cnt int;
v_sqlstmt refcursor;
rec record;
begin
/* assigntoflg=
 * 1 - Reporting manager
 * 2 - Assign to Actor
 * 3 - Assign to Role
 * 4 - From form field
 * 6 - Skip level
 */
/*processownerflg
 * 1 - Actor
 * 2 - Role
 */	
/*allowsendflg
 * 1 - None
 * 2 - Any user
 * 3 - Users in this process
 * 4 - Actor
 * */	
	

	
----------------------------Assign to Reporting Manager & Form fields when touser is null | Redirect to Process owners	
if new.assigntoflg in('1','4','6') and new.touser is null and new.grouped is null then            
		
	select count(*) into v_processonwer_cnt
	from axuserlevelgroups c
	where c.usergroup = new.processowner		
	and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
	and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));

	if v_processonwer_cnt > 0 then	
	insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,isoptional,
	Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
	select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
	new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
	new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
	new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
	new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
	new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
	new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
	new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
	new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,'T',
	new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
	from axuserlevelgroups c
	where c.usergroup = new.processowner		
	and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
	and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	else
	---Redirect to default role when no users exists in process owner
	insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,isoptional,
	Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
	select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
	new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
	new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
	new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
	new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
	new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
	new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
	new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
	new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,'T',
	new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
	from axuserlevelgroups c
	where c.usergroup = 'default'		
	and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
	and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	end if;
								
end if;	
	
	
-----------------------Assign to Reporting Manager & Form fields & User exists  - Redirect to delegated users
if new.assigntoflg in('1','4','6') and new.touser is not null and new.grouped ='T' then	

	insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
	transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
	displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
	useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,
	pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,reminder,
	displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
	usebusinessdatelogic,initonbehalf,autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 								
	select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,new.execonapprove,
	new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,new.orgdimension,new.department,
	new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,new.groupfield,new.groupvalue,
	new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',
	new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
	new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,new.approvalcomments,new.rejectcomments,
	new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',new.returnable,new.allowsend,new.allowsendflg,
	new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,new.autoapprove,
	new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata			
	from axprocessdef_delegation c 
	where c.fromusername = new.touser				
	and current_date  >= c.fromdate
	and current_date  <= c.todate;

end if;
	


------------------------------- Assign to Actor
if new.assigntoflg ='2' then 
	
	select coalesce(assignmodecnd,0) assignmodecnd,defusername,case when array_length(string_to_array(defusername,','),1) is null then 0 else  array_length(string_to_array(defusername,','),1) end usercount
	into v_assignmodecnd,v_defusers ,usercount
	from axpdef_peg_actor a
	where a.actorname=new.assigntoactor; 


	if v_assignmodecnd = 1 then --------Default user
	
		if usercount > 0 then
		insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
		keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,
		displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
		useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,
		actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,
		rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,allowsendflg,sendtoactor,
		initiator_approval,usebusinessdatelogic,initonbehalf,actor_default_users,autoapprove,isoptional,
		Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
		select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
		new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,regexp_split_to_table(v_defusers,','),new.priorindex,new.priortaskname,
		new.corpdimension,new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,
		new.displaycontent,new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,
		new.useridentificationfilter,new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
		new.processowner,new.assigntoflg,new.assigntoactor,	new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,new.approvereasons,
		new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,new.approvalcomments,new.rejectcomments,new.returncomments,
		new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,
		new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,'T' ,new.autoapprove,
		new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
		from dual;
	
	
	
		---------Delegation(Default users)
		insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
		transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
		displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
		useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,
		recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,
		rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,
		sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,autoapprove,isoptional,
		Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
		select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,
		new.keyfield,new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,
		new.corpdimension,new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,
		new.displaycontent,new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,
		new.useridentificationfilter,new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
		new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
		new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,new.approvalcomments,
		new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',new.returnable,
		new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,new.autoapprove,
		new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
		from 
		(select regexp_split_to_table(v_defusers,',') fuser)a,axprocessdef_delegation c 
		where a.fuser = c.fromusername				
		and current_date  >= c.fromdate
		and current_date  <= c.todate;	
		else
		------------Redirect to process owner	
		select count(*) into v_processonwer_cnt
		from axuserlevelgroups c
		where c.usergroup = new.processowner		
		and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
		and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	
		if v_processonwer_cnt > 0 then			
		insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
		keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
		displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
		useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
		assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
		approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
		allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,
		isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
		select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
		new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
		new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
		new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
		new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
		new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
		new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
		new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
		new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,'T',
		new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
		from axuserlevelgroups c
		where c.usergroup = new.processowner		
		and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
		and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
		else----Redirect to default role if users are not exists in process owner
		insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
		keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
		displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
		useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
		assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
		approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
		allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,
		isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
		select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
		new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
		new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
		new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
		new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
		new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
		new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
		new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
		new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,'T',
		new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,
		new.reminderjsondata,new.escalationjsondata
		from axuserlevelgroups c
		where c.usergroup = 'default'		
		and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
		and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
		end if;
			
		--------------Delegation(Process owner)
		insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
		transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
		displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
		mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
		approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
		reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
		usebusinessdatelogic,initonbehalf,autoapprove,isoptional,Reminderstartdate,
		Escalationstartdate,reminderjsondata,escalationjsondata) 								
		select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
		new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,
		new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
		new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
		new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
		new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
		new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',
		new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
		new.initonbehalf,new.autoapprove,new.isoptional,new.Reminderstartdate,
		new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
		from axuserlevelgroups a,axprocessdef_delegation c 
		where a.usergroup = new.processowner
		and a.username = c.fromusername
		and current_date  >= c.fromdate
		and current_date  <= c.todate					 		
		and ((a.startdate is not null and current_date  >= a.startdate) or (a.startdate is null)) 
		and ((a.enddate is not null and current_date  <= a.enddate) or (a.enddate is null));
		
		end if;
	elseif v_assignmodecnd = 2 then -----------User group
			
		select distinct string_agg(usergroupname,',') into  v_initiator_usergrps 
		from axpdef_peg_usergroups where username = case when length(new.initonbehalf)>1 then new.initonbehalf else  new.initiator end
		and active='T'
		and effectivefrom <= current_date;
		
		----------- Check approval users are assigned for the initiator's group
		select string_agg(concat(usergroupname,'~~',unames),'|~') ,count(*) into v_usergrpuser,usercount
		from (select distinct b.usergroupname, b.ugrpusername unames
		from axpdef_peg_actor a
		join axpdef_peg_actorusergrp b on a.axpdef_peg_actorid=b.axpdef_peg_actorid
		where a.actorname = new.assigntoactor 
		and b.usergroupname in (select regexp_split_to_table(v_initiator_usergrps,','))
		order by 1 )a;
		
			
			--------- if approval users are assinged in process users
			if usercount > 0 then 
			
				open v_sqlstmt for 
				select  split_part(unnest(string_to_array(v_usergrpuser,'|~')),'~~',1) ugrpname,
				split_part(unnest(string_to_array(v_usergrpuser,'|~')),'~~',2) ugrpusers;
			
				fetch next from v_sqlstmt into rec;
			
				while found 		
    			loop 	
			
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
				useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,
				processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,
				returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
				allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,actor_user_groups,
				autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,regexp_split_to_table(rec.ugrpusers,','),new.priorindex,new.priortaskname,
				new.corpdimension,new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,
				new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,
				new.rejectreasons,new.defregtext,new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,
				new.groupwithpriorindex,new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,rec.ugrpname,new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from dual;
			
				 fetch next from v_sqlstmt into rec;
		   		    
    			end loop;	
			
				---------Delegation(usergroup users)
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
				useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,
				recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,
				rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,
				sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,autoapprove,isoptional,
				Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,
				new.keyfield,new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,
				new.corpdimension,new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,
				new.displaycontent,new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,
				new.useridentificationfilter,new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
				new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
				new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,new.approvalcomments,
				new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,
				new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from 
				(select regexp_split_to_table(v_usergrpuser,',') fuser)a,axprocessdef_delegation c 
				where a.fuser = c.fromusername				
				and current_date  >= c.fromdate
				and current_date  <= c.todate;
				
			else ------------------------ if approval users are not assinged in process users,Redirect to process owner	
				select count(*) into v_processonwer_cnt
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	
				if v_processonwer_cnt > 0 then				
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
				keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
				displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
				useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
				assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
				approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
				allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,
				isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
				new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
				new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
				else
				---Redirect to default role when no users exists in process owner
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
				keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
				displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
				useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
				assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
				approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
				allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,
				autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
				new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
				new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = 'default'		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
				end if;
				--------------Delegation(Process owner)
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
				mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
				approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
				reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic
				,initonbehalf,autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 								
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
				new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
				new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
				new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',
				new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,new.autoapprove,new.isoptional,new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups a,axprocessdef_delegation c 
				where a.usergroup = new.processowner
				and a.username = c.fromusername
				and current_date  >= c.fromdate
				and current_date  <= c.todate					 		
				and ((a.startdate is not null and current_date  >= a.startdate) or (a.startdate is null)) 
				and ((a.enddate is not null and current_date  <= a.enddate) or (a.enddate is null));	
				
			end if;
			
			
	elseif v_assignmodecnd = 3 then 	---- Data groups

		select fn_peg_assigntoactor(new.assigntoactor,new.actorfilter) into v_datagrpusers ;		

			if v_datagrpusers != '0' then
				open v_sqlstmt for 
				select split_part(unnest(string_to_array(v_datagrpusers,'|~')),'~~',1) dgrpname,
				split_part(unnest(string_to_array(v_datagrpusers,'|~')),'~~',2) dgrpusers;
			
				fetch next from v_sqlstmt into rec;
			
				while found 		
    			loop 					
    				
    			insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
				useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,
				processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,
				returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
				allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,actor_data_grp,
				autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,regexp_split_to_table(rec.dgrpusers,','),new.priorindex,new.priortaskname,
				new.corpdimension,new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,
				new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,
				new.rejectreasons,new.defregtext,new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,
				new.groupwithpriorindex,new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,new.initonbehalf,
				rec.dgrpname,new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from dual;	
			
     			fetch next from v_sqlstmt into rec;		   		    
    			end loop;	
			
    		    						
				---------Delegation(data group users)
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,
				useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,
				recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,
				rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,
				sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,autoapprove,isoptional,
				Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,new.orgdimension,
				new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,new.groupfield,
				new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,new.mapfield_group,
				new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,
				new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,new.approvalcomments,
				new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from 
				(select regexp_split_to_table(v_datagrpusers,',') fuser)a,axprocessdef_delegation c 
				where a.fuser = c.fromusername				
				and current_date  >= c.fromdate
				and current_date  <= c.todate;			
			else		
				----------Redirect to process owner
				select count(*) into v_processonwer_cnt
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	
				if v_processonwer_cnt > 0 then					
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
				mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
				approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
				reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
				usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,isoptional,
				Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
				new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
				new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
				new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,
				new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
				else	
				---Redirect to default role when no users exists in process owner
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
				keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
				displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
				useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
				assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
				approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
				allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,
				autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
				new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
				new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = 'default'		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
				end if;						
						
				--------------Delegation(Process owner | Role)
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
				mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
				approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
				reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
				usebusinessdatelogic,initonbehalf,autoapprove,isoptional,Reminderstartdate,
				Escalationstartdate,reminderjsondata,escalationjsondata) 								
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
				new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
				new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
				new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',
				new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,
				new.usebusinessdatelogic,new.initonbehalf,new.autoapprove,new.isoptional,
				new.Reminderstartdate,new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups a,axprocessdef_delegation c 
				where a.usergroup = new.processowner
				and a.username = c.fromusername
				and current_date  >= c.fromdate
				and current_date  <= c.todate					 		
				and ((a.startdate is not null and current_date  >= a.startdate) or (a.startdate is null)) 
				and ((a.enddate is not null and current_date  <= a.enddate) or (a.enddate is null));	
												
				end if;	
			
			elseif v_assignmodecnd = 0 then ----'When Assign users data is not entered'
				----------Redirect to process owner
				select count(*) into v_processonwer_cnt
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
	
				if v_processonwer_cnt > 0 then					
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
				mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
				approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
				reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
				usebusinessdatelogic,initonbehalf,pownerflg,autoapprove,isoptional,
				Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
				new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
				new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
				new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,
				new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = new.processowner		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
			
				--------------Delegation(Process owner | Role)
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,keyvalue,
				transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,displayicon,displaytitle,
				displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,useridentificationfilter,useridentificationfilter_of,
				mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
				approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,approvalcomments,rejectcomments,returncomments,escalation,
				reminder,displaymcontent,groupwithpriorindex,delegation,returnable,allowsend,allowsendflg,sendtoactor,initiator_approval,
				usebusinessdatelogic,initonbehalf,autoapprove,isoptional,Reminderstartdate,
				Escalationstartdate,reminderjsondata,escalationjsondata) 								
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.tousername,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,new.displaybuttons,
				new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,new.useridentificationfilter,new.useridentificationfilter_of,
				new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,
				new.processownerflg,new.pownerfilter,new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,'T',
				new.returnable,new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups a,axprocessdef_delegation c 
				where a.usergroup = new.processowner
				and a.username = c.fromusername
				and current_date  >= c.fromdate
				and current_date  <= c.todate					 		
				and ((a.startdate is not null and current_date  >= a.startdate) or (a.startdate is null)) 
				and ((a.enddate is not null and current_date  <= a.enddate) or (a.enddate is null));	
												
			
				else	
				---Redirect to default role when no users exists in process owner
				insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
				keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
				displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
				useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
				assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
				approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
				allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,pownerflg,
				autoapprove,isoptional,Reminderstartdate,Escalationstartdate,reminderjsondata,escalationjsondata) 
				select new.eventdatetime,new.taskid,new.processname,new.tasktype,new.taskname,new.taskdescription,new.assigntorole,new.transid,new.keyfield,
				new.execonapprove,new.keyvalue,new.transdata,new.fromrole,new.fromuser,c.username,new.priorindex,new.priortaskname,new.corpdimension,
				new.orgdimension,new.department,new.grade,new.datavalue,new.displayicon,new.displaytitle,new.displaysubtitle,new.displaycontent,
				new.displaybuttons,new.groupfield,new.groupvalue,new.priorusername,new.initiator,new.mapfieldvalue,	new.useridentificationfilter,
				new.useridentificationfilter_of,new.mapfield_group,new.mapfield,'T',new.indexno,new.subindexno,
				new.processowner,new.assigntoflg,new.assigntoactor,new.actorfilter,new.recordid,new.processownerflg,new.pownerfilter,
				new.approvereasons,new.defapptext,new.returnreasons,new.defrettext,new.rejectreasons,new.defregtext,
				new.approvalcomments,new.rejectcomments,new.returncomments,new.escalation,new.reminder,new.displaymcontent,new.groupwithpriorindex,new.returnable,
				new.allowsend,new.allowsendflg,new.sendtoactor,new.initiator_approval,new.usebusinessdatelogic,
				new.initonbehalf,'T',new.autoapprove,new.isoptional,new.Reminderstartdate,
				new.Escalationstartdate,new.reminderjsondata,new.escalationjsondata
				from axuserlevelgroups c
				where c.usergroup = 'default'		
				and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
				and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null));
				end if;		
			end if;
end if;			
  
return new;
end; 
$$;

CREATE FUNCTION {schema}.fn_axi_get_fieldvalues_with_keysuffix_list(p_tstruct text, p_fieldname text) RETURNS TABLE(displaydata text, id text, caption text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
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
    FROM axp_tstructprops 
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
            'SELECT (%I || ''['' || %I || '']'')::text AS displaydata,
                    %I::text AS id,
                    %I::text AS caption
             FROM %I
             WHERE %I IS NOT NULL
             ORDER BY displaydata ASC',
            v_srcfld,
            v_keyfield,
            v_keyfield,
            lower(v_srctf) || 'id',
            lower(v_srctf),
            p_fieldname
        );
    END IF;
    RETURN QUERY EXECUTE v_sql; 
END; 
$$;

CREATE FUNCTION {schema}.fn_axi_getkeyvalueswithfieldnameslist(p_tstruct text, p_fieldname text) RETURNS TABLE(displaydata text, id text, caption text, isfield text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $_$
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
    FROM axp_tstructprops
    WHERE name = p_tstruct
    LIMIT 1;
    IF v_keyfield IS NULL then
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
$_$;

CREATE FUNCTION {schema}.fn_axi_metadata(pstructtype character varying, pusername character varying) RETURNS TABLE(structtype text, caption text, transid character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $_$
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
v_sql = 'select ''ADS'',sqlname::text,sqlname from axdirectsql';
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
select ''ADS'',sqlname::text,sqlname from axdirectsql';
end if;
return query execute v_sql using pusername;
END; 
$_$;

CREATE FUNCTION {schema}.fn_axi_struct_metadata(pstructtype character varying, ptransid character varying, pobjtype character varying) RETURNS TABLE(objtype character varying, objcaption text, objname character varying, dcname character varying, asgrid character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $_$
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
$_$;

CREATE FUNCTION {schema}.fn_axp_appsearch_data_period() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$

	BEGIN
		if new.periodically ='T' or new.srctable is  null or new.srcfield is  null then
		Begin 

        IF (TG_OP = 'INSERT') THEN 
		
		insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values(new.hltype,new.structname, case when new.periodically ='T' then new.searchtext else  new.caption end ,new.params,new.docid);
		
		return new;
		end if;
		
		IF (TG_OP = 'UPDATE') THEN 
		
		insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values(old.hltype,old.structname, case when old.periodically ='T' then old.searchtext else  old.caption end ,old.params,old.docid);
		
		return new;
		
		end if;
		
		IF (TG_OP = 'DELETE') THEN 
		
		delete from axp_appsearch_data_v2 where docid = old.docid;
		
		return new;
		
		end if;
		
		exception
      when unique_violation then
      update axp_appsearch_data_v2 set  hltype= new.hltype , structname = new.structname,searchtext = case when new.periodically ='T' then new.searchtext else  new.caption end  ,params=new.params where docid= new.docid;
   when others then null ;

		end ;
		end if; 
end; 
$$;

CREATE FUNCTION {schema}.fn_axp_mailjobs() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	declare 
	v_sid numeric(15);
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		select nextval('AXP_MAILJOBSID') into v_sid; 
		
		NEW.jobid = v_sid;
		
		return new;
	end if;
		
end; 
$$;

CREATE FUNCTION {schema}.fn_axpanalytics_ap_charts(pentity_transid character varying, pcriteria character varying, pfilter character varying, pusername character varying DEFAULT 'admin'::character varying, papplydac character varying DEFAULT 'T'::character varying, puserrole character varying DEFAULT 'All'::character varying, pconstraints text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
rec record;
rec_filters record;
v_primarydctable varchar;
v_subentitytable varchar;
v_transid varchar;
v_grpfld varchar;
v_aggfld varchar;
v_aggfnc varchar;
v_srckey varchar;
v_srctbl varchar;
v_srcfld varchar;
v_aempty varchar;
v_aggfldtable varchar;
v_sql text;
v_normalizedjoin varchar;
v_keyname varchar;
v_keyname_coalesce varchar;
v_entitycond varchar;
v_keyfld_fname varchar;
v_keyfld_fval varchar;
v_final_sqls text[] DEFAULT  ARRAY[]::text[];
v_fldname_transidcnd numeric;
v_sql1 text;
v_filter_srcfld varchar;
v_filter_srctxt varchar;
v_filter_join varchar;
v_filter_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_cnd varchar;
v_filter_cndary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_joinreq numeric;
v_filter_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_col varchar;
v_filter_normalized varchar;
v_filter_sourcetbl varchar;
v_filter_sourcefld varchar;
v_filter_datatype varchar;
v_filter_listedfld varchar;
v_filter_tablename varchar;
v_emptyary varchar[] DEFAULT  ARRAY[]::varchar[];
v_grpfld_tbl varchar;
v_grpfld_tablejoins varchar;
v_aggfld_tablejoins varchar;
v_tablejoins varchar;
v_aggfldtransid varchar;
v_aggfld_primarydctable varchar;
v_entityrelation varchar;
v_aggfldname_transidcnd numeric;
v_entity_parent_reltable varchar;
v_entity_child_reltable varchar;
--dacrec record;
--v_dacenabled numeric;
--v_dactype numeric;
--v_dac_join varchar;
--v_dac_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_dac_cnd varchar;
--v_dac_cndary varchar[] DEFAULT  ARRAY[]::varchar[];
--v_dac_joinreq numeric;
--v_dac_normalizedjoinreq numeric; 
v_tablenames varchar[] DEFAULT  ARRAY[]::varchar[];
begin

	/*	 
	 * pcriteria_v1 - transid~aggfnc~groupfld~normalized~srctable~srcfld~allowempty~grpfld_tablename~aggfld~aggfld_tablename(Not in use)	 
	 * pcriteria_v2 - aggfnc~grpfld_transid~groupfld~normalized~srctable~srcfld~allowempty~grpfld_tablename~aggfld_transid~aggfld~aggfld_tablename~grpfld_transid_AND_aggfld_transid_relation
	 * Ex1(agg fld in Non grid dc) - sum~gcust~party_name~F~~~~mg_partyhdr~slord~total_discount~salesorder_header~mg_partyhdr.mg_partyhdrid = salesorder_header.customer
	 * Ex2(agg fld in grid dc) - sum~gcust~party_name~F~~~~mg_partyhdr~slord~taxableamount~salesorder_items~mg_partyhdr.mg_partyhdrid = salesorder_header.customer

	*/ 	 
	
	
	select lower(trim(tablename)) into v_primarydctable from axpdc where tstruct = pentity_transid and dname ='dc1';
	
	select count(1) into v_fldname_transidcnd from axpflds where tstruct = pentity_transid and lower(tablename)=lower(v_primarydctable) and lower(fname)='transid';

	v_tablenames := array_append(v_tablenames,v_primarydctable);
	
	
-------------Permission filter
	   if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_primarydctable||'.');											   					   			   										
			   end if;		  
	
	
	
	    FOR rec IN
    	    select unnest(string_to_array(pcriteria,'^')) criteria 
    	    -----aggfnc~grpfld_transid~groupfld~normalized~srctable~srcfld~allowempty~grpfld_tablename~aggfld_transid~aggfld~aggfld_tablename~grpfld_transid_AND_aggfld_transid_relation
		    loop
			    	
			    v_aggfnc := split_part(rec.criteria,'~',1);---- agg function
			    v_transid := split_part(rec.criteria,'~',2);---grpfld_transid  			    
		    	v_grpfld := split_part(rec.criteria,'~',3);---grpfld_name
			    v_srckey := split_part(rec.criteria,'~',4);---normalized_grpfld_flag
	   			v_srctbl := split_part(rec.criteria,'~',5);---normalied_source table	   			
		   		v_srcfld := split_part(rec.criteria,'~',6);---normalied_source field
			   	v_aempty := split_part(rec.criteria,'~',7);---grpfld_allowempty - to franme left join or join
			    v_grpfld_tbl := lower(trim(split_part(rec.criteria,'~',8)));--grpfld_tablename
			    v_aggfldtransid :=split_part(rec.criteria,'~',9);--aggfld_transid;
				v_aggfld := case when split_part(rec.criteria,'~',10)='count' then '1' else split_part(rec.criteria,'~',10) end;				
				v_aggfldtable := lower(trim(split_part(rec.criteria,'~',11)));---aggfld_tablename
				v_entityrelation := split_part(rec.criteria,'~',12);---grpfld_transid_aggfld_transid_relation
				v_entity_parent_reltable := lower(trim(split_part(split_part(v_entityrelation,'=',1),'.',1)));
				v_entity_child_reltable := lower(trim(split_part(split_part(v_entityrelation,'=',2),'.',1)));
				
				
				v_normalizedjoin := case when v_srckey='T' then concat(' left join ',v_srctbl,' b on ',v_grpfld_tbl,'.',v_grpfld,' = b.',v_srctbl,'id ') else ' ' end;
				v_keyname := case when length(v_grpfld) > 0 then case when v_srckey='T' then concat('b.',v_srcfld) else concat(v_grpfld_tbl,'.',v_grpfld) end else 'null' end;			
				v_keyname_coalesce := 'coalesce(trim('||v_keyname||'), '''')';					

				v_tablenames := case when v_srckey='T' then  array_append(v_tablenames,v_srctbl) end;
				v_tablenames := case when v_srckey='T' then  array_append(v_tablenames,v_grpfld_tbl) end;
				v_tablenames := array_append(v_tablenames,v_aggfldtable);
				
			
			if v_transid = v_aggfldtransid then
			
				if lower(v_aggfldtable)=lower(v_primarydctable) and lower(v_grpfld_tbl)=lower(v_primarydctable) then
					v_tablejoins := v_primarydctable;								   			   									
				elsif lower(v_grpfld_tbl) != lower(v_primarydctable) and lower(v_aggfldtable)=lower(v_primarydctable) then
					v_tablejoins := v_primarydctable||' left join '||v_grpfld_tbl||' on '||v_grpfld_tbl||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				elsif lower(v_aggfldtable) != lower(v_primarydctable) and lower(v_grpfld_tbl)=lower(v_primarydctable) then
					v_tablejoins := v_primarydctable||' left join '||v_aggfldtable||' on '||v_aggfldtable||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				elsif lower(v_aggfldtable) != lower(v_primarydctable) and lower(v_grpfld_tbl)=lower(v_aggfldtable) then
					v_tablejoins := v_primarydctable||' left join '||v_aggfldtable||' on '||v_aggfldtable||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				elsif lower(v_aggfldtable) != lower(v_primarydctable) and lower(v_grpfld_tbl)!=lower(v_aggfldtable) then
					v_tablejoins := v_primarydctable||' left join '||v_aggfldtable||' on '||v_aggfldtable||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id left join '||v_grpfld_tbl||' on '||v_grpfld_tbl||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				end if;	----------------- v_tablejoins																						
			
			elsif v_transid != v_aggfldtransid then
				select lower(trim(tablename)) into v_aggfld_primarydctable from axpdc where tstruct = v_aggfldtransid and dname ='dc1';	
			
				select count(1) into v_aggfldname_transidcnd from axpflds where tstruct = v_aggfldtransid and lower(tablename) = lower(v_aggfld_primarydctable) 
				and lower(fname)='transid';

				------------group field joins
				if lower(v_grpfld_tbl)=lower(v_primarydctable)  and lower(v_entity_parent_reltable)=lower(v_primarydctable) then 
					v_grpfld_tablejoins := v_grpfld_tbl;
				elsif lower(v_grpfld_tbl)!=lower(v_primarydctable) and lower(v_entity_parent_reltable)=lower(v_primarydctable) then 
					v_grpfld_tablejoins := v_primarydctable||' join '||v_grpfld_tbl||' on '||v_grpfld_tbl||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				elsif lower(v_grpfld_tbl)=lower(v_primarydctable) and lower(v_entity_parent_reltable)!=lower(v_primarydctable) then 
					v_grpfld_tablejoins := v_primarydctable||' join '||v_entity_parent_reltable||' on '||v_entity_parent_reltable||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';	
				elsif lower(v_grpfld_tbl)!=lower(v_primarydctable) and lower(v_entity_parent_reltable)!=lower(v_primarydctable) then
					v_grpfld_tablejoins := v_primarydctable||' join '||v_grpfld_tbl||' on '||v_grpfld_tbl||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id'
									||' join '||v_entity_parent_reltable||' on '||v_entity_parent_reltable||'.'||v_primarydctable||'id='||v_primarydctable||'.'||v_primarydctable||'id';
				end if;								
					
				--------------agg field joins	
				if lower(v_aggfldtable)=lower(v_aggfld_primarydctable)  and lower(v_entity_child_reltable)=lower(v_aggfld_primarydctable) then 
					v_aggfld_tablejoins := ' join '||v_aggfldtable||' on '||v_entityrelation;
				elsif lower(v_aggfldtable)!=lower(v_aggfld_primarydctable) and lower(v_entity_child_reltable)=lower(v_aggfld_primarydctable) then 
					v_aggfld_tablejoins := ' join '||v_entity_child_reltable||' on '||v_entityrelation||' join '||v_aggfldtable||' on '||v_aggfldtable||'.'||v_aggfld_primarydctable||'id='||v_aggfld_primarydctable||'.'||v_aggfld_primarydctable||'id';
				elsif lower(v_aggfldtable)=lower(v_aggfld_primarydctable) and lower(v_entity_child_reltable)!=lower(v_aggfld_primarydctable) then 
					v_aggfld_tablejoins := ' join '||v_entity_child_reltable||' on '||v_entityrelation||' join '||v_aggfld_primarydctable||' on '||v_aggfld_primarydctable||'.'||v_aggfld_primarydctable||'id='||v_entity_child_reltable||'.'||v_aggfld_primarydctable||'id';	
				elsif lower(v_aggfldtable)!=lower(v_aggfld_primarydctable) and lower(v_entity_child_reltable)!=lower(v_aggfld_primarydctable) then
					v_aggfld_tablejoins := ' join '||v_entity_child_reltable||' on '||v_entityrelation||' join '||v_aggfld_primarydctable||' on '||v_aggfld_primarydctable||'.'||v_aggfld_primarydctable||'id='||v_entity_child_reltable||'.'||v_aggfld_primarydctable||'id'||
											' join '||v_aggfldtable||' on '||v_aggfldtable||'.'||v_aggfld_primarydctable||'id='||v_aggfld_primarydctable||'.'||v_aggfld_primarydctable||'id';									
				end if;											
				
				v_tablejoins := concat(v_grpfld_tablejoins,' ',v_aggfld_tablejoins);
			
			end if; ------- v_transid = v_aggfldtransid
				
			
			
			select concat('select ',v_keyname_coalesce,' keyname,',case when lower(trim(v_aggfnc)) in ('sum','avg') then 'round('||v_aggfnc||'('||v_aggfld||'),2)'else v_aggfnc||'('||v_aggfld||')' end,
			'keyvalue,','''',rec.criteria,'''::varchar',' criteria from ',v_tablejoins,' ',v_normalizedjoin)
			into v_sql;
																								
			
			
				if coalesce(pfilter,'NA') ='NA' then 
				
				
			v_sql1 := concat(v_sql,' where ',v_primarydctable,'.cancel=''F''',
						case when v_fldname_transidcnd > 0 then concat(' and ',v_primarydctable,'.transid=''',pentity_transid,'''') end,
						case when v_transid != v_aggfldtransid then ' and '||v_aggfld_primarydctable||'.cancel=''F''' end,
						case when v_aggfldname_transidcnd > 0 then concat(' and ',v_aggfld_primarydctable,'.transid=''',v_aggfldtransid,'''') end,
						case when papplydac ='T' then concat(' and (',v_dac_cnd,')') end
						,case when length(v_grpfld) > 0 then concat(' group by ',v_keyname_coalesce) else '' end);
	
		else 
			FOR rec_filters IN
    			select unnest(string_to_array(pfilter,'^')) ifilter
			    loop		    	
			    	v_filter_srcfld := split_part(rec_filters.ifilter,'|',1);
			    	v_filter_srctxt := split_part(rec_filters.ifilter,'|',2);
			    	v_filter_col := split_part(v_filter_srcfld,'~',1);
				    v_filter_normalized := split_part(v_filter_srcfld,'~',2);
 				    v_filter_sourcetbl := split_part(v_filter_srcfld,'~',3);
 				    v_filter_sourcefld := split_part(v_filter_srcfld,'~',4);
					v_filter_datatype := split_part(v_filter_srcfld,'~',5);
					v_filter_listedfld :=split_part(v_filter_srcfld,'~',6);
					v_filter_tablename:=split_part(v_filter_srcfld,'~',7);
					
		
			    				    	
			    	if  v_filter_listedfld = 'F' then
			    	
					v_filter_joinreq := case when lower(v_aggfldtable)=lower(v_filter_tablename) then 1 else 0 end; 			    		
					
			    	if v_filter_joinreq = 0  then 
				    	v_filter_dcjoinsary := array_append(v_filter_dcjoinsary,concat(' join ',v_filter_tablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_filter_tablename,'.',v_primarydctable,'id') );
			    	end if;
			    
			    	
			    
		    		select case when v_filter_normalized='T' 
					then concat(' join ',v_filter_sourcetbl,' ',v_filter_col,' on ',v_filter_tablename,'.',v_filter_col,' = ',v_filter_col,'.',v_filter_sourcetbl,'id')
					end into v_filter_join from dual where v_filter_normalized='T';
					
					 
					v_filter_joinsary :=array_append(v_filter_joinsary,v_filter_join);				
					
				
					end if;
			
									
					select case when v_filter_normalized='F' 
					then concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_tablename,'.',v_filter_col,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					else concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_col,'.',v_filter_sourcefld,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					end into v_filter_cnd;
		    	
					v_filter_cndary := array_append(v_filter_cndary,v_filter_cnd);				
			
									
			    end loop;
			   
			   	v_filter_dcjoinsary := ARRAY(SELECT DISTINCT UNNEST(v_filter_dcjoinsary));			
			   
				v_sql1 := concat(v_sql,array_to_string(v_filter_dcjoinsary,' '),array_to_string(v_filter_joinsary,' '),
						' where ',v_primarydctable,'.cancel=''F''',
						case when v_fldname_transidcnd > 0 then concat(' and ',v_primarydctable,'.transid=''',pentity_transid,''' and ') end,
						case when v_transid != v_aggfldtransid then v_aggfld_primarydctable||'.cancel=''F''' end,
						case when v_aggfldname_transidcnd > 0 then concat(' and ',v_aggfld_primarydctable,'.transid=''',v_aggfldtransid,'''') end,						
						array_to_string(v_filter_cndary,' and ')
						,case when papplydac ='T' then concat(' and (',v_dac_cnd,')') end
						,case when length(v_grpfld) > 0 then concat(' group by ',v_keyname_coalesce) else '' end);					    						
		end if;

			v_final_sqls := array_append(v_final_sqls,v_sql1);
			v_filter_cndary:= v_emptyary;
	    	END LOOP;
	      	

   return array_to_string(v_final_sqls,'^^^') ;
END;
$$;

CREATE FUNCTION {schema}.fn_axpanalytics_chartdata(psource character varying, pentity_transid character varying, pcondition character varying, pcriteria character varying, pfilter character varying DEFAULT 'NA'::character varying, pusername character varying DEFAULT 'admin'::character varying, papplydac character varying DEFAULT 'T'::character varying, puserrole character varying DEFAULT 'All'::character varying, pconstraints text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
rec record;
rec_filters record;
dacrec record;
v_primarydctable varchar;
v_subentitytable varchar;
v_transid varchar;
v_grpfld varchar;
v_aggfld varchar;
v_aggfnc varchar;
v_srckey varchar;
v_srctbl varchar;
v_srcfld varchar;
v_aempty varchar;
v_tablename varchar;
v_sql text;
v_normalizedjoin varchar;
v_keyname varchar;
v_keyname_coalesce varchar;
v_entitycond varchar;
v_keyfld_fname varchar;
v_keyfld_fval varchar;
v_keyfld_srckey varchar;
v_keyfld_srctbl varchar;
v_keyfld_srcfld varchar;
v_final_sqls text[] DEFAULT  ARRAY[]::text[];
v_fldname_transidcnd numeric;
v_sql1 text;
v_jointables varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_srcfld varchar;
v_filter_srctxt varchar;
v_filter_join varchar;
v_filter_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_cnd varchar;
v_filter_cndary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_joinreq numeric;
v_filter_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_col varchar;
v_filter_normalized varchar;
v_filter_sourcetbl varchar;
v_filter_sourcefld varchar;
v_filter_datatype varchar;
v_filter_listedfld varchar;
v_filter_tablename varchar;
v_emptyary varchar[] DEFAULT  ARRAY[]::varchar[];
v_dac_cnd varchar;

begin
	
	select tablename into v_primarydctable from axpdc where tstruct = pentity_transid and dname ='dc1';	

	v_jointables := array_append(v_jointables,v_primarydctable);


-------------Permission filter
	   if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_primarydctable||'.');											   					   			   										
			   end if;		   			
		   			
	
	if pcondition ='Custom' then
	
		select count(1) into v_fldname_transidcnd from axpflds where tstruct = pentity_transid and dcname ='dc1' and lower(fname)='transid';


		if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_primarydctable||'.');											   					   			   										
			   end if;		   			
	
	    FOR rec IN
    	    select unnest(string_to_array(pcriteria,'^')) criteria 
		    loop		    			    
			    v_transid := split_part(rec.criteria,'~',1);
		    	v_grpfld := split_part(rec.criteria,'~',2);
				v_aggfld := case when split_part(rec.criteria,'~',3)='count' then '1' else split_part(rec.criteria,'~',3) end;
				v_aggfnc := split_part(rec.criteria,'~',4);
				v_srckey := split_part(rec.criteria,'~',5);
				v_srctbl := split_part(rec.criteria,'~',6);
				v_srcfld := split_part(rec.criteria,'~',7);
				v_aempty := split_part(rec.criteria,'~',8);
				v_tablename := split_part(rec.criteria,'~',9);
				v_keyfld_fname := split_part(rec.criteria,'~',10);
				v_keyfld_fval := split_part(rec.criteria,'~',11);
				
				v_jointables := case when v_srckey='T' then array_append(v_jointables,v_srctbl) end;
				v_normalizedjoin := case when v_srckey='T' then concat(' left join ',v_srctbl,' b on ',v_primarydctable,'.',v_grpfld,' = b.',v_srctbl,'id ') else ' ' end;
				v_keyname := case when length(v_grpfld) > 0 then case when v_srckey='T' then concat('b.',v_srcfld) else concat(v_primarydctable,'.',v_grpfld) end else 'null' end;			
				v_keyname_coalesce := 'coalesce(trim('||v_keyname||'), '''')';							
				
					if lower(v_tablename)=lower(v_primarydctable) then
						select concat('select ',v_keyname_coalesce,' keyname,',case when lower(trim(v_aggfnc)) in ('sum','avg') then 'round('||v_aggfnc||'('||v_aggfld||'),2)'else v_aggfnc||'('||v_aggfld||')' end,
						'keyvalue,''Custom''::varchar cnd,','''',rec.criteria,'''::varchar',' criteria from ',v_tablename,' ',v_normalizedjoin)
						into v_sql;
						v_jointables := array_append(v_jointables,v_tablename);		   			   									
					else
						select concat('select ',
						concat(' ',v_keyname,' keyname,',case when lower(trim(v_aggfnc)) in ('sum','avg') then 'round('||v_aggfnc||'('||v_aggfld||'),2)'else v_aggfnc||'('||v_aggfld||')' end,
						' keyvalue,''Custom''::varchar cnd,','''',rec.criteria,'''::varchar',' criteria from ',
						concat(v_primarydctable,'  join ',v_tablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_tablename,'.',v_primarydctable,'id '),
						v_normalizedjoin))a
						into v_sql;
						v_jointables := array_append(v_jointables,v_tablename);
						
					end if;																											
			
						
			
				if coalesce(pfilter,'NA') ='NA' then 

			v_sql1 := concat(v_sql,' ',' where 1=1 ',
						case when v_fldname_transidcnd > 0 then concat(' and ',v_primarydctable,'.transid=''',pentity_transid,'''') end,
						case when papplydac ='T' and length(v_dac_cnd)>2 then concat(' and (',v_dac_cnd,')') end,'
						--axp_filter
						',
						case when length(v_grpfld) > 0 then concat(' group by ',v_keyname_coalesce) else '' end);
	
		else 
			FOR rec_filters IN
    			select unnest(string_to_array(pfilter,'^')) ifilter
			    loop		    	
			    	v_filter_srcfld := split_part(rec_filters.ifilter,'|',1);
			    	v_filter_srctxt := split_part(rec_filters.ifilter,'|',2);
			    	v_filter_col := split_part(v_filter_srcfld,'~',1);
				    v_filter_normalized := split_part(v_filter_srcfld,'~',2);
 				    v_filter_sourcetbl := split_part(v_filter_srcfld,'~',3);
 				    v_filter_sourcefld := split_part(v_filter_srcfld,'~',4);
					v_filter_datatype := split_part(v_filter_srcfld,'~',5);
					v_filter_listedfld :=split_part(v_filter_srcfld,'~',6);
					v_filter_tablename:=split_part(v_filter_srcfld,'~',7);
					
		
			    				    	
			    	if  v_filter_listedfld = 'F' then
			    	
					v_filter_joinreq := case when lower(v_tablename)=lower(v_filter_tablename) then 1 else 0 end; 			    		
					
			    	if v_filter_joinreq = 0  then 
				    	v_filter_dcjoinsary := array_append(v_filter_dcjoinsary,concat(' join ',v_filter_tablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_filter_tablename,'.',v_primarydctable,'id') );
			    	end if;
			    
			    	
			    
		    		select case when v_filter_normalized='T' 
					then concat(' join ',v_filter_sourcetbl,' ',v_filter_col,' on ',v_filter_tablename,'.',v_filter_col,' = ',v_filter_col,'.',v_filter_sourcetbl,'id')
					end into v_filter_join from dual where v_filter_normalized='T';
					
					 
					v_filter_joinsary :=array_append(v_filter_joinsary,v_filter_join);				
					
				
					end if;
			
									
					select case when v_filter_normalized='F' 
					then concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_tablename,'.',v_filter_col,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					else concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_col,'.',v_filter_sourcefld,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					end into v_filter_cnd;
		    	
					v_filter_cndary := array_append(v_filter_cndary,v_filter_cnd);				
			
									
			    end loop;
			   
			   	v_filter_dcjoinsary := ARRAY(SELECT DISTINCT UNNEST(v_filter_dcjoinsary));		
		
				v_sql1 := concat(v_sql,array_to_string(v_filter_dcjoinsary,' '),array_to_string(v_filter_joinsary,' '),'
						  where 1=1 ',
						case when v_fldname_transidcnd > 0 then concat(' and ',v_primarydctable,'.transid=''',pentity_transid,'''') else ' and ' end,array_to_string(v_filter_cndary,' and '),
						case when papplydac ='T' then concat(' and (',v_dac_cnd,')') end,'
						--axp_filter
						',
						case when length(v_grpfld) > 0 then concat(' group by ',v_keyname_coalesce) else '' end);					    						
		end if;

			v_final_sqls := array_append(v_final_sqls,v_sql1);
			v_filter_cndary:= v_emptyary;
			v_jointables :=v_emptyary;
	    	END LOOP;
	   
   elsif pcondition = 'General' then 
		if psource ='Entity' then    
						
			select count(1) into v_fldname_transidcnd from axpflds where tstruct = pentity_transid and dcname ='dc1' and lower(fname)='transid';


			if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_primarydctable||'.');											   					   			   										
			   end if;		   			

			select concat('select count(*) totrec,
			sum(case when date_part(''year'' ,',v_primarydctable,'.createdon) = date_part(''year'',current_date) then 1 else 0 end) cyear,
			sum(case when date_part(''month'' ,',v_primarydctable,'.createdon) = date_part(''month'',current_date) then 1 else 0 end) cmonth,
			sum(case when date_part(''week'' ,',v_primarydctable,'.createdon) = date_part(''week'',current_date) then 1 else 0 end) cweek,
			sum(case when ',v_primarydctable,'.createdon::Date = current_date - 1 then 1 else 0 end) cyesterday,
			sum(case when ',v_primarydctable,'.createdon::Date = current_date then 1 else 0 end) ctoday,''General''::varchar cnd,null::varchar criteria
			from ',v_primarydctable,' where 1=1 ',
			case when v_fldname_transidcnd > 0 then concat(' and transid=''',pentity_transid,'''') end,
			case when papplydac ='T' and length(v_dac_cnd)>2 then concat(' and (',v_dac_cnd,')') end) into v_sql;		


		
			
		v_final_sqls := array_append(v_final_sqls,v_sql);

		
				
		elsif psource= 'Subentity' then 		
		    FOR rec IN
	    	    select unnest(string_to_array(pcriteria,'^')) criteria
		    loop		    			    
	      		v_transid := split_part(rec.criteria,'~',1);
	      		v_tablename := split_part(rec.criteria,'~',9);
				v_keyfld_fname := split_part(rec.criteria,'~',10);
				v_keyfld_fval := split_part(rec.criteria,'~',11);
				v_keyfld_srckey := split_part(rec.criteria,'~',5);
				v_keyfld_srctbl := split_part(rec.criteria,'~',6);
				v_keyfld_srcfld := split_part(rec.criteria,'~',7);

				select tablename into v_subentitytable from axpdc where tstruct = v_transid and dname ='dc1';				
			
				select count(1) into v_fldname_transidcnd from axpflds where tstruct = v_transid and dcname ='dc1' and lower(fname)='transid';


				if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_tablename||'.');											   					   			   										
			   end if;		   			
			
				if lower(v_tablename)=lower(v_subentitytable) then
			
				 v_sql := concat('select ','''',v_transid,'''transid',',count(*) totrec,''General''::varchar cnd,','''',replace(rec.criteria,'''',''),'''  criteria from '
								,v_tablename
								,case when v_keyfld_srckey='T' then ' join '||v_keyfld_srctbl||' on '||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id = '||v_tablename||'.'||v_keyfld_fname end
								,' where 1=1 ',
				 case when v_fldname_transidcnd > 0 then concat(' and ',v_tablename,'.transid=''',v_transid,''' and ') else ' and ' end
				 ,case when v_keyfld_srckey='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else v_keyfld_fname end,'=',v_keyfld_fval				 
					);				
				
				else 
				
				v_sql := concat('select ','''',v_transid,'''transid',',count(*) totrec,''General''::varchar cnd,','''',replace(rec.criteria,'''',''),'''  criteria from '
								,v_tablename,' a join ',v_subentitytable,' b on a.',v_subentitytable,'id=b.',v_subentitytable,'id '
								,case when v_keyfld_srckey='T' then ' join '||v_keyfld_srctbl||' on '||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id = a.'||v_keyfld_fname end
								,' where 1=1 ',
				case when v_fldname_transidcnd > 0 then concat(' and b.transid=''',v_transid,''' and ') else ' and ' end
				 ,case when v_keyfld_srckey='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else v_keyfld_fname end,'=',v_keyfld_fval				 
				);
				
					
				end if;
			
				v_final_sqls := array_append(v_final_sqls,v_sql);			
			
			END LOOP;	
		
		end if;
	end if;

 
   return array_to_string(v_final_sqls,'^^^') ;

END;
$$;

CREATE FUNCTION {schema}.fn_axpanalytics_edittxn(ptransid character varying, precordid numeric, pusername character varying DEFAULT 'admin'::character varying, papplydac character varying DEFAULT 'T'::character varying) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
rec1 record;
rec2 record;
dacrec record;
v_sql text;
v_sql1 text;
v_primarydctable varchar;
v_fldnamesary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_col varchar;
v_fldname_normalized varchar;
v_fldname_srctbl varchar;
v_fldname_srcfld varchar;
v_fldname_allowempty varchar;
v_fldname_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_dctablename varchar;
v_fldname_dcflds text;
v_fldname_dctables varchar[] DEFAULT  ARRAY[]::varchar[];
v_allflds varchar;
v_dacenabled numeric;
v_dactype numeric;
v_dac_cnd varchar;
v_dac_cndary varchar[] DEFAULT  ARRAY[]::varchar[];
v_editable varchar;
v_dac_join varchar;
v_dac_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_dac_joinreq numeric;
v_dac_normalizedjoinreq numeric; 
v_dac_entry numeric;
v_dac_onlyview numeric;


begin


	select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';


select count(*) into v_dac_entry from axpdef_dac_config where stransid = ptransid and editmode in('Edit','ViewEdit');



----DAC V5
	select sum(cnt),sum(appl),sum(onlyview) into v_dacenabled,v_dactype,v_dac_onlyview from
(select count(*) cnt,2 appl,0 onlyview from axpdef_dac_config a  
where a.uname = pusername and a.stransid = ptransid and a.editmode in ('Edit','ViewEdit')
having count(*) > 0
union all
select count(*),1 appl,0 onlyview from axpdef_dac_config a  join axuserlevelgroups a2 on a.urole = a2.usergroup 
where a2.username = pusername and a.stransid = ptransid and a.editmode in ('Edit','ViewEdit')
and ((a2.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
having count(*) > 0
union all
select 0 cnt,0 appl,2 onlyview from axpdef_dac_config a  
where a.uname = pusername and a.stransid = ptransid and a.editmode='View'
having count(*) > 0
union all
select 0,0 appl,1 onlyview from axpdef_dac_config a  join axuserlevelgroups a2 on a.urole = a2.usergroup 
where a2.username = pusername and a.stransid = ptransid and a.editmode='View'
and ((a2.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
having count(*) > 0
)a
where 'T' = papplydac;


 
			
			select string_agg(str,'^')  into v_allflds 
					from 
					(
					select concat(f.tablename,'=',string_agg(concat(f.fname,'~',f.srckey,'~',f.srctf,'~',f.srcfld,'~',f.allowempty),'|')) str
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpflds f on a.stransid =f.tstruct and b.fldname = f.fname 
					where a.uname = pusername  and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					and a.dataaccesscnd = 30 and v_dactype in(2,3) 
					group by f.tablename									
					union all					
					select  tablename||'='||'createdby~F~~~F'
					from axpdef_dac_config a 
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1' 
					where a.uname = pusername and a.dataaccesscnd in (10,11,12) 
					and a.stransid = ptransid and a.editmode in('Edit','ViewEdit') and v_dactype in(2,3)					
					union all					
					select concat(f.tablename,'=',string_agg(concat(f.fname,'~',f.srckey,'~',f.srctf,'~',f.srcfld,'~',f.allowempty),'|')) str
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpflds f on a.stransid =f.tstruct and b.fldname = f.fname 
					join axuserlevelgroups u on a.urole = u.usergroup and ((u.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
					and u.username = pusername and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					where a.dataaccesscnd =30 and v_dactype = 1					
					group by f.tablename	
					union all
					select tablename||'='||'createdby~F~~~F'
					from axpdef_dac_config a 
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1'
					join axuserlevelgroups u on a.urole = u.usergroup and ((u.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
					and u.username = pusername and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					where a.dataaccesscnd in (10,11,12) and v_dactype = 1
					)a;			
		
						
		FOR rec1 IN
    		select unnest(string_to_array(v_allflds,'^')) dcdtls
    		loop	
    			v_fldname_dctablename := split_part(rec1.dcdtls,'=',1);
				v_fldname_dcflds := split_part(rec1.dcdtls,'=',2);
			
			if v_fldname_dctablename!=v_primarydctable then
						v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_fldname_dctablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_fldname_dctablename,'.',v_primarydctable,'id') );						
					end if;
					v_fldname_dctables := array_append(v_fldname_dctables,v_fldname_dctablename);

				FOR rec2 IN
	    		select unnest(string_to_array(v_fldname_dcflds,'|')) fldname    		    	       			
					loop		    	
						v_fldname_col := split_part(rec2.fldname,'~',1);
						v_fldname_normalized := split_part(rec2.fldname,'~',2);
						v_fldname_srctbl := split_part(rec2.fldname,'~',3);
						v_fldname_srcfld := split_part(rec2.fldname,'~',4);	
						v_fldname_allowempty := split_part(rec2.fldname,'~',5);
				    
											
						if v_fldname_normalized ='F' then 
							v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_dctablename,'.',v_fldname_col)::varchar);
						elsif v_fldname_normalized ='T' then	
							v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_col,'.',v_fldname_srcfld,' ',v_fldname_col)::varchar);	
							v_fldname_joinsary := array_append(v_fldname_joinsary,concat(case when v_fldname_allowempty='F' then ' join ' else ' left join ' end,v_fldname_srctbl,' ',v_fldname_col,' on ',v_fldname_dctablename,'.',v_fldname_col,' = ',v_fldname_col,'.',v_fldname_srctbl,'id')::Varchar);
							v_fldname_dctables := array_append(v_fldname_dctables,v_fldname_srctbl);
						end if;
									
				    end loop;
		   
			end loop;

		   	v_sql := concat(' select count(*) from ',v_primarydctable,' ',array_to_string(v_fldname_dcjoinsary,' '),' ',array_to_string(v_fldname_joinsary,' '));
 

		   			
---------DAC filters
			   if v_dacenabled > 0 then
				   			   				
			   ------------------ DAC V5
			    for dacrec in 			   
					select fname,tablename,srckey,srctf,srcfld,
					case when filtercnd in('like','not like') then case when isglovar='F' then '''%'||attribvalue||'%''' else 
					case when lower(trim(attribvalue))=':username' then  '''%'||pusername||'%''' else '''%''||'||attribvalue||'||''%''' end end
					when filtercnd in('in','not in') then case when isglovar='F' then ''''||replace(attribvalue,',',''',''')||'''' else case when lower(trim(attribvalue))=':username' then  ''''||pusername||'''' else attribvalue end end
					when filtercnd in('=','!=','>','<') then case when isglovar='F' then ''''||attribvalue||'''' else case when lower(trim(attribvalue))=':username' then  ''''||pusername||'''' else attribvalue end end  end cnd,
					ord,filtercnd  from
					(
					select case when b.dynamicval ='No' and a.dataaccesscnd = 30 then b.fldstaticval when b.dynamicval ='Yes' and a.dataaccesscnd = 30 then b.fldmastvalue end  attribvalue,
					f.fname,f.tablename,1 ord, b.filtercnd,b.isglovar,f.srckey,f.srctf,f.srcfld
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpflds f on a.stransid =f.tstruct and b.fldname = f.fname 
					where a.uname = pusername  and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					and a.dataaccesscnd = 30 and v_dactype in(2,3)					
					union all			
					select case when b.dynamicval ='No' and a.dataaccesscnd = 30 then b.fldstaticval when b.dynamicval ='Yes' and a.dataaccesscnd = 30 then b.fldmastvalue end  attribvalue,
					b.fldname ,d.tablename,1 ord, b.filtercnd,b.isglovar,'F',null,null
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1' 
					where a.uname = pusername  and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					and a.dataaccesscnd = 30 and b.fldname in('createdby','username','createdon','modifiedon')  and v_dactype in(2,3)
					union all		
					select  pusername attribvalue, 'createdby' ,d.tablename,1 ord,'='filtercnd,'F','F' srckey,null srctf, null srcfld
					from axpdef_dac_config a 
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1' 
					where a.uname = pusername and a.dataaccesscnd in (10,11,12) 
					and a.stransid = ptransid and a.editmode in('Edit','ViewEdit') 
					and v_dactype in(2,3)					
					union all					
					select case when b.dynamicval ='No' and a.dataaccesscnd = 30 then b.fldstaticval when b.dynamicval ='Yes' and a.dataaccesscnd = 30 then b.fldmastvalue end  attribvalue,
					f.fname,f.tablename,2 ord, b.filtercnd,b.isglovar,f.srckey,f.srctf,f.srcfld
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpflds f on a.stransid =f.tstruct and b.fldname = f.fname 
					join axuserlevelgroups u on a.urole = u.usergroup and ((u.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
					and u.username = pusername and a.stransid = ptransid 
					and a.editmode in('Edit','ViewEdit')
					where a.dataaccesscnd =30 and v_dactype = 1
					union all
					select case when b.dynamicval ='No' and a.dataaccesscnd = 30 then b.fldstaticval when b.dynamicval ='Yes' and a.dataaccesscnd = 30 then b.fldmastvalue end  attribvalue,
					b.fldname,d.tablename,2 ord, b.filtercnd,b.isglovar,'F',null,null
					from axpdef_dac_config a join axpdef_dac_configdtl b on a.axpdef_dac_configid =  b.axpdef_dac_configid
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1'
					join axuserlevelgroups u on a.urole = u.usergroup and ((u.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
					and u.username = pusername and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					where a.dataaccesscnd =30 and v_dactype = 1	and  b.fldname in('createdby','username','createdon','modifiedon') 						
					union all
					select  pusername attribvalue, 'createdby' ,d.tablename,2 ord,'='filtercnd ,'F','F' srckey,null srctf, null srcfld
					from axpdef_dac_config a 
					join axpdc d on a.stransid =d.tstruct and d.dname= 'dc1'
					join axuserlevelgroups u on a.urole = u.usergroup and ((u.startdate is not null and current_date  >= startdate) or (startdate is null)) and ((enddate is not null and current_date  <= enddate) or (enddate is null))
					and u.username = pusername and a.stransid = ptransid and a.editmode in('Edit','ViewEdit')
					where a.dataaccesscnd in (10,11,12) and v_dactype = 1
					)a
					order by ord 
					
					loop												
					
							select count(1) into v_dac_joinreq from (
						select distinct unnest(v_fldname_dctables)tbls 												
						)a 
						where lower(a.tbls)=lower(dacrec.tablename);	


						if dacrec.srckey ='T' then
							select count(1) into v_dac_normalizedjoinreq from (
							select distinct unnest(v_fldname_dctables)tbls 						
							)a 
							where lower(a.tbls)=lower(dacrec.srctf);	
	
								if v_dac_normalizedjoinreq = 0 then
									v_dac_joinsary := array_append(v_dac_joinsary,concat(' join ',dacrec.srctf,' on ',dacrec.srctf,'.',dacrec.srctf,'id=',dacrec.tablename,'.',dacrec.fname));
									v_fldname_dctables := array_append(v_fldname_dctables,dacrec.srctf);						
								end if;

						end if;		

												
						if v_dac_joinreq = 0 then
						v_dac_joinsary := array_append(v_dac_joinsary,concat(' join ',dacrec.tablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',dacrec.tablename,'.',v_primarydctable,'id') );
						v_fldname_dctables := array_append(v_fldname_dctables,dacrec.tablename);		
						end if;							

						v_dac_cnd := case 
									 when dacrec.srckey='F' then  concat(dacrec.tablename,'.',dacrec.fname,' ',dacrec.filtercnd,'(', case when dacrec.filtercnd in('in','not in') then 'select unnest(string_to_array('||replace(dacrec.cnd,':','axglovar.')||','',''))' else replace(dacrec.cnd,':','axglovar.')	end,')')  
									 when 	dacrec.srckey='T' then  
									 case when v_dac_normalizedjoinreq = 0 then concat(dacrec.srctf,'.',dacrec.srcfld,' ',dacrec.filtercnd,'(',case when dacrec.filtercnd in('in','not in') then 'select unnest(string_to_array('||replace(dacrec.cnd,':','axglovar.')||','',''))' else replace(dacrec.cnd,':','axglovar.')	end	,')') 
									else concat(dacrec.fname,'.',dacrec.srcfld,' ',dacrec.filtercnd,'(',case when dacrec.filtercnd in('in','not in') then 'select unnest(string_to_array('||replace(dacrec.cnd,':','axglovar.')||','',''))' else replace(dacrec.cnd,':','axglovar.')	end	,')') end
									end;
					
					
						v_dac_cndary := array_append(v_dac_cndary,v_dac_cnd);									
					

						/*v_dac_cnd := concat(dacrec.tablename,'.',dacrec.fname,' ',dacrec.filtercnd,'(', replace(dacrec.cnd,':','axglovar.')	,')');
					
						v_dac_cndary := array_append(v_dac_cndary,v_dac_cnd);*/
											
					end loop;
								
			   end if;		   			
		   			
						v_sql1 := concat(v_sql,' join axglovar on axglovar.axglo_user = ','''',pusername,'''',' where ',v_primarydctable,'id=',precordid,case when v_dacenabled > 0 then concat(' and ',array_to_string(v_dac_cndary,' and ')) else ' and 1=2 ' end);	
		
				--if v_dacenabled > 0 then 
					execute v_sql1 into v_editable;								   					   			   							
				--end if;

			
return case when v_dac_entry > 0 and v_dac_onlyview = 0 then 
case when v_editable = '0' then 'F' else 'T' end 
when v_dac_entry > 0 and v_dac_onlyview =2 then 'F'
when v_dac_entry > 0 and v_dac_onlyview in (1,3) then case when v_editable = '0' then 'F' else 'T' end
when v_dac_entry = 0 and v_dac_onlyview in (1,2,3) then 'F'
else 'T' end;

END; $$;

CREATE FUNCTION {schema}.fn_axpanalytics_filterdata(ptransid character varying, pflds text) RETURNS TABLE(datavalue character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sql text;
begin
---pflds - fldname~normalized~source table~source fld
	
	
	if split_part(pflds,'~',2)='T' then	
		v_sql := concat('select distinct ',split_part(pflds,'~',4),' from ',split_part(pflds,'~',3));
	elsif 
		split_part(pflds,'~',2)='F' then
		v_sql := concat('select distinct ',split_part(pflds,'~',1),' from ',split_part(pflds,'~',3));
	end if;
		
	
return query execute v_sql;
--return v_sql1;

END; $$;

CREATE FUNCTION {schema}.fn_axpanalytics_ins_axreltn() RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
begin
	
delete from axentityrelations where rtype!='custom';
 
insert into axentityrelations ( 
axentityrelationsid,cancel,username,modifiedon,createdby,createdon,app_level,app_desc,
rtype,mstruct,mfield,mtable,primarytable,dstruct,dfield,dtable,rtypeui,mstructui,mfieldui,dstructui,dfieldui,dprimarytable)
select * from vw_entityrelations;
 
	
end;

$$;

CREATE FUNCTION {schema}.fn_axpanalytics_listdata(ptransid character varying, pflds text DEFAULT 'All'::text, ppagesize numeric DEFAULT 25, ppageno numeric DEFAULT 1, pfilter text DEFAULT 'NA'::text, puser character varying DEFAULT 'admin'::character varying, papplydac character varying DEFAULT 'T'::character varying, puserrole character varying DEFAULT 'All'::character varying, pconstraints text DEFAULT NULL::text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
rec1 record;
rec2 record;
v_sql text;
v_sql1 text;
v_primarydctable varchar;
v_fldnamesary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_col varchar;
v_fldname_normalized varchar;
v_fldname_srctbl varchar;
v_fldname_srcfld varchar;
v_fldname_allowempty varchar;
v_fldname_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_dctablename varchar;
v_fldname_dcflds text;
v_fldname_dctables varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_normalizedtables varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_transidcnd numeric;
v_allflds varchar;
v_filter_srcfld varchar;
v_filter_srctxt varchar;
v_filter_join varchar;
v_filter_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_cnd varchar;
v_filter_cndary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_joinreq numeric;
v_filter_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_filter_col varchar;
v_filter_normalized varchar;
v_filter_sourcetbl varchar;
v_filter_sourcefld varchar;
v_filter_datatype varchar;
v_filter_listedfld varchar;
v_filter_tablename varchar;
v_fldname_tables varchar[] DEFAULT  ARRAY[]::varchar[];
v_dac_cnd varchar;
 

begin

	select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';



	select count(1) into v_fldname_transidcnd from axpflds where tstruct = ptransid and dcname ='dc1' and lower(fname)='transid';

		if pflds = 'All' then 		
			select concat(tablename,'=',string_agg(str,'|'))  into v_allflds From(
			select tablename, concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str,dcname,ordno
			from axpflds where tstruct=ptransid and dcname='dc1' and 
			asgrid ='F' and hidden ='F' and savevalue='T' and tablename = v_primarydctable and datatype not in('i','t')
			union all
			select distinct a.tablename,'app_desc~F~~~T' str,a.dname,1 from axpdc a 
			join AXATTACHWORKFLOW d ON a.tstruct =d.transid 
			where a.tstruct=ptransid and a.dname='dc1'
			order by dcname ,ordno)a group by a.tablename;		 
		end if;
						
		FOR rec1 IN
    		select unnest(string_to_array(case when pflds='All' then v_allflds else pflds end,'^')) dcdtls
    		loop	
    			v_fldname_dctablename := split_part(rec1.dcdtls,'=',1);
				v_fldname_dcflds := split_part(rec1.dcdtls,'=',2);
			
			if v_fldname_dctablename!=v_primarydctable then
						v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_fldname_dctablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_fldname_dctablename,'.',v_primarydctable,'id') );						
					end if;
					v_fldname_dctables := array_append(v_fldname_dctables,v_fldname_dctablename);

			FOR rec2 IN
    		select unnest(string_to_array(v_fldname_dcflds,'|')) fldname    		    	       			
				loop		    	
					v_fldname_col := split_part(rec2.fldname,'~',1);
					v_fldname_normalized := split_part(rec2.fldname,'~',2);
					v_fldname_srctbl := split_part(rec2.fldname,'~',3);
					v_fldname_srcfld := split_part(rec2.fldname,'~',4);	
					v_fldname_allowempty := split_part(rec2.fldname,'~',5);
			    
				
					
					if v_fldname_normalized ='F' and lower(v_fldname_col)!='app_desc' then 						
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_dctablename,'.',v_fldname_col)::varchar);
					elsif v_fldname_normalized ='F' and lower(v_fldname_col)='app_desc' then						
						v_fldnamesary:= array_append(v_fldnamesary,concat('case when length(',v_primarydctable,'.wkid)>2 then case ',v_primarydctable,'.app_desc when 0 then  ''Created''
  when  1 then ''Approved''
  when  2 then ''Review''
  when  3 then ''Return''
  when  4 then ''Approve''
  when  5 then ''Rejected''
  when  9 then ''Orphan'' end else null end app_desc'));
					elsif v_fldname_normalized ='T' then	
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_col,'.',v_fldname_srcfld,' ',v_fldname_col)::varchar);	
						v_fldname_joinsary := array_append(v_fldname_joinsary,concat(case when v_fldname_allowempty='F' then ' join ' else ' left join ' end,v_fldname_srctbl,' ',v_fldname_col,' on ',v_fldname_dctablename,'.',v_fldname_col,' = ',v_fldname_col,'.',v_fldname_srctbl,'id')::Varchar);
						v_fldname_normalizedtables := array_append(v_fldname_normalizedtables,lower(v_fldname_srctbl));
					end if;
								
			    end loop;
		   
			   end loop;
		   	v_sql := concat(' select ','''',ptransid,''' transid,',v_primarydctable,'.',v_primarydctable,'id recordid,',v_primarydctable,'.username modifiedby,',v_primarydctable,'.modifiedon,',v_primarydctable,'.createdon,',v_primarydctable,'.createdby,',
		   			 v_primarydctable,'.cancel,',v_primarydctable,'.cancelremarks,',array_to_string(v_fldnamesary,','),
					',null axpeg_processname,null axpeg_keyvalue,null axpeg_status,null axpeg_statustext from ',
					v_primarydctable,' ',array_to_string(v_fldname_dcjoinsary,' '),' ',array_to_string(v_fldname_joinsary,' ')
					 );
 

		   			
---------DAC filters
			   if papplydac = 'T' then					
					v_dac_cnd := replace(pconstraints,'{primarytable.}',v_primarydctable||'.');											   					   			   										
			   end if;		   			
		   			
			
		if coalesce(pfilter,'NA') ='NA' then 

			if ppagesize > 0 then 
				v_sql1 := concat('select b.* from(select a.*,row_number() over(order by modifiedon desc)::Numeric rno,
				case when mod(row_number() over(order by modifiedon desc),',ppagesize,')=0 then row_number() over(order by modifiedon desc)/',ppagesize,' else row_number() over(order by modifiedon desc)/',ppagesize,'+1 end::numeric pageno from 
				(',concat(v_sql,' where 1=1 ',case when v_fldname_transidcnd>0 then ' and '||v_primarydctable||'.transid='||''''||ptransid||'''' end,
				case when papplydac ='T' and length(v_dac_cnd) > 2 then concat(' and (',v_dac_cnd,')') end),'
				--axp_filter
				',')a order by modifiedon desc limit ',ppagesize*ppageno,' )b ',case when ppageno=0 then '' else concat('where pageno=',ppageno) end);
			else 
				v_sql1 :=concat('select b.* from(select a.*,0 rno,1 pageno from 
				(',concat(v_sql,' where 1=1 ',case when v_fldname_transidcnd>0 then ' and '||v_primarydctable||'.transid='||''''||ptransid||'''' end,
				case when papplydac ='T' and length(v_dac_cnd) > 2 then concat(' and (',v_dac_cnd,')') end),'
				--axp_filter
				',')a order by modifiedon desc)b ');
			end if;
	
		else 
			FOR rec IN
    			select unnest(string_to_array(pfilter,'^')) ifilter
			    loop		    	
			    	v_filter_srcfld := split_part(rec.ifilter,'|',1);
			    	v_filter_srctxt := split_part(rec.ifilter,'|',2);
			    	v_filter_col := split_part(v_filter_srcfld,'~',1);
				    v_filter_normalized := split_part(v_filter_srcfld,'~',2);
 				    v_filter_sourcetbl := split_part(v_filter_srcfld,'~',3);
 				    v_filter_sourcefld := split_part(v_filter_srcfld,'~',4);
					   v_filter_datatype := split_part(v_filter_srcfld,'~',5);
					v_filter_listedfld :=split_part(v_filter_srcfld,'~',6);
				v_filter_tablename:=split_part(v_filter_srcfld,'~',7);
					
		
			    				    	
			    	if  v_filter_listedfld = 'F' then
			    	
					select count(1) into v_filter_joinreq from (select distinct unnest(v_fldname_dctables)tbls )a where lower(a.tbls)=lower(v_filter_tablename);			    		
					
			    	if v_filter_joinreq = 0  then 
				    	v_filter_dcjoinsary := array_append(v_filter_dcjoinsary,concat(' join ',v_filter_tablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_filter_tablename,'.',v_primarydctable,'id') );
				    	v_fldname_tables := array_append(v_fldname_tables,v_filter_tablename);
			    	end if;
			    
			    	
			    
		    		select case when v_filter_normalized='T' 
					then concat(' join ',v_filter_sourcetbl,' ',v_filter_col,' on ',v_filter_tablename,'.',v_filter_col,' = ',v_filter_col,'.',v_filter_sourcetbl,'id')
					end into v_filter_join from dual where v_filter_normalized='T';
					
					 
					v_filter_joinsary :=array_append(v_filter_joinsary,v_filter_join);				
					
				
					end if;
			
									
					select case when v_filter_normalized='F' 
					then concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_tablename,'.',v_filter_col,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					else concat(case when v_filter_datatype='c' then 'lower(' end,v_filter_col,'.',v_filter_sourcefld,case when v_filter_datatype='c' then ')' end,' ',v_filter_srctxt) 
					end into v_filter_cnd;
		    	
					v_filter_cndary := array_append(v_filter_cndary,v_filter_cnd);				
			
									
			    end loop;
			   
			   	v_filter_dcjoinsary := ARRAY(SELECT DISTINCT UNNEST(v_filter_dcjoinsary));				   					   
			   
			   	if ppagesize > 0 then 
						v_sql1 := concat('select b.* from(select a.*,row_number() over(order by modifiedon desc)::Numeric rno,
						case when mod(row_number() over(order by modifiedon desc),',ppagesize,')=0 then row_number() over(order by modifiedon desc)/',ppagesize,' else row_number() over(order by modifiedon desc)/',ppagesize,'+1 end::numeric pageno from 
						(',v_sql,concat(array_to_string(v_filter_dcjoinsary,' '),array_to_string(v_filter_joinsary,' '),' where 1=1 '
						,case when v_fldname_transidcnd>0 then concat(' and ',v_primarydctable,'.transid=','''',ptransid,''' and ') else ' and ' end,
						array_to_string(v_filter_cndary,' and '),case when papplydac ='T' and length(v_dac_cnd) > 2 then concat(' and (',v_dac_cnd,')') end),'
						--axp_filter
						',')a order by modifiedon desc limit ',ppagesize*ppageno,' )b ',case when ppageno=0 then '' else concat('where pageno=',ppageno) end);	
				else 	
						v_sql1 := concat('select b.* from(select a.*,0 rno,1 pageno from 
						(',v_sql,concat(array_to_string(v_filter_dcjoinsary,' '),array_to_string(v_filter_joinsary,' '),' where 1=1 '
						,case when v_fldname_transidcnd>0 then concat(' and ',v_primarydctable,'.transid=','''',ptransid,''' and ') else ' and ' end,
						array_to_string(v_filter_cndary,' and '),case when papplydac ='T' and length(v_dac_cnd) > 2 then concat(' and (',v_dac_cnd,')') end),'
						--axp_filter
						)a order by modifiedon desc)b ');		
			
				end if;			    						
		end if;

return v_sql1;

END; $$;

CREATE FUNCTION {schema}.fn_axpanalytics_metadata(ptransid character varying, psubentity character varying DEFAULT 'F'::character varying, planguage character varying DEFAULT 'English'::character varying) RETURNS SETOF {schema}.axpdef_axpanalytics_mdata
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
r axpdef_axpanalytics_mdata%rowtype;
rec record;
v_subentitytable varchar;
v_sql text;
v_subentitysql text;
v_primarydctable varchar;
begin
 

	select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';

	select concat('select axpflds.tstruct transid,coalesce(lf.compcaption,t.caption) formcap, fname ,coalesce(l.compcaption,axpflds.caption) fcap,customdatatype cdatatype,"datatype" dt,modeofentry,
	hidden fhide,cast(null as varchar) props,srckey ,srctf ,srcfld ,srctrans ,axpflds.allowempty,
	case when modeofentry =''select'' then case when srckey =''T'' then ''Dropdown'' else ''Text'' end else ''Text'' end::varchar filtercnd,
	case when (modeofentry =''select'' or datatype=''c'') then ''T'' else ''F'' end::varchar grpfld,
	case when "datatype" =''n'' then ''T'' else ''F'' end::varchar aggfld,''F'' subentity,1 datacnd,null entityrelfld,allowduplicate,axpflds.tablename,
	dcname,ordno,d.caption dccaption,d.asgrid,case when d.asgrid=''F'' then ''T'' else ''F'' end listingfld,encrypted,masking,lastcharmask,firstcharmask,maskchar,maskroles,customdecimal
	from axpflds join tstructs t on axpflds.tstruct = t.name and t.blobno=1
	join axpdc d on axpflds.tstruct = d.tstruct and axpflds.dcname = d.dname
	left join axlanguage l on substring(l.sname FROM 2)= t.name and lower(l.dispname)=''',lower(planguage),''' and axpflds.fname = l.compname
	left join axlanguage lf on substring(lf.sname FROM 2)= t.name and lower(lf.dispname)=''',lower(planguage),''' and lf.compname=''x__headtext'' 		
	where axpflds.tstruct=','''',ptransid,''' and savevalue =''T'' 
	union all
	select a.name,coalesce(lf.compcaption,t.caption),key,coalesce(l.compcaption,title),	''button'',null,null,''F'',	concat(script, ''~'', icon),''F'',null,null,null,null,null,null,null,''F'' subentity,1,null,
	null,null,null,ordno,null,''F'',''F'',null encrypted,null masking,null lastcharmask,null firstcharmask,null maskchar,null maskroles,null customdecimal
	from axtoolbar a join tstructs t on a.name = t.name and t.blobno=1
	left join axlanguage l on substring(l.sname FROM 2)= t.name and lower(l.dispname)=''',lower(planguage),''' and a.key = l.compname
	left join axlanguage lf on substring(lf.sname FROM 2)= t.name and lower(lf.dispname)=''',lower(planguage),''' and lf.compname=''x__headtext''
	where visible = ''true'' and script is not null and a.name= ','''',ptransid,'''','
	union all 
	select distinct t.name transid,coalesce(lf.compcaption,t.caption) formcap, ''app_desc'' ,''Workflow status'' fcap,
	null cdatatype,''c'' dt,null modeofentry,
	''F'' fhide,null props,''F'' srckey ,null srctf ,null srcfld ,null srctrans ,''T'' allowempty,
	''Text'' filtercnd,
	''F'' grpfld,
	''F'' aggfld,''F'' subentity,1 datacnd,null entityrelfld,''T'' allowduplicate,d.tablename,
	dname,1000,d.caption dccaption,d.asgrid,case when d.asgrid=''F'' then ''T'' else ''F'' end listingfld,
	''F'' encrypted,null masking,null lastcharmask,null firstcharmask,null maskchar,null maskroles,null customdecimal
	from axattachworkflow a join tstructs t on a.transid = t.name and t.blobno=1 		
	join axpdc d on a.transid = d.tstruct and d.dname =''dc1''
	left join axlanguage lf on substring(lf.sname FROM 2)= t.name and lower(lf.dispname)=''',lower(planguage),''' and lf.compname=''x__headtext'' 		
	where t.name=','''',ptransid,'''') into v_sql;

	for r in execute v_sql
		loop	    	
			RETURN NEXT r;
		END LOOP;	
	

if psubentity ='T' then		

    FOR rec IN
        select distinct a.dstruct,a.rtype,dprimarytable  from axentityrelations a 		
		where rtype in('md','custom','gm') and mstruct = ptransid 
   	loop		
	


select concat('select distinct axpflds.tstruct transid,coalesce(lf.compcaption,t.caption) formcap, fname ,coalesce(l.compcaption,axpflds.caption) fcap,customdatatype cdatatype,"datatype" dt,modeofentry ,hidden fhide,
		cast(null as varchar) props,srckey ,srctf ,srcfld ,srctrans ,axpflds.allowempty,
		case when modeofentry =''select'' then case when srckey =''T'' then ''Dropdown'' else ''Text'' end else ''Text'' end::varchar filtercnd,
		case when modeofentry =''select'' then ''T'' else ''F'' end::varchar grpfld,
		case when "datatype" =''n'' then ''T'' else ''F'' end::varchar aggfld,''T'' subentity,2 datacnd,
		r.mfield entityrelfld,
		allowduplicate,axpflds.tablename,dcname,ordno,d.caption,d.asgrid,case when d.asgrid=''F'' then ''T'' else ''F'' end listingfld,
		encrypted,masking,lastcharmask,firstcharmask,maskchar,maskroles,customdecimal	
		from axpflds join tstructs t on axpflds.tstruct = t.name and t.blobno=1 join axpdc d on axpflds.tstruct = d.tstruct and axpflds.dcname = d.dname
		left join axentityrelations r on axpflds.tstruct = r.dstruct and axpflds.fname = r.dfield and r.mstruct=''',ptransid,'''
		left join axlanguage l on substring(l.sname FROM 2)=''',rec.dstruct,''' and lower(l.dispname)=''',lower(planguage),''' and axpflds.fname = l.compname
		left join axlanguage lf on substring(lf.sname FROM 2)= t.name and lower(lf.dispname)=''',lower(planguage),''' and lf.compname=''x__headtext''		
		where axpflds.tstruct=','''',rec.dstruct,''' and savevalue =''T'' 
		union all 
		select ','''',rec.dstruct,''',null,''sourceid'',''sourceid'',''Simple Text'',''c'',''accept'',''T'',
		null,''F'',null,null,null,''F'',null,''F'',''F'',''T'',2,''recordid'',''T'',','''',rec.dprimarytable,'''',',null,1000,null,''F'',''F'',
		null encrypted,null masking,null lastcharmask,null firstcharmask,null maskchar,null maskroles,null customdecimal
		from dual where ''gm''=','''',rec.rtype,''' 
		union all
		','select distinct t.name transid,coalesce(lf.compcaption,t.caption) formcap, ''app_desc'' ,''Workflow status'' fcap,null cdatatype,''c'' dt,null modeofentry ,''F'' fhide,
		null props,''F'' srckey ,null srctf ,null srcfld ,null srctrans ,''T'' allowempty,
		''Text'' filtercnd,''F'' grpfld,''F'' ,''T'' subentity,2 datacnd,
		null entityrelfld,''T'' allowduplicate,d.tablename,d.dname,1000,d.caption,d.asgrid,
		''T'' listingfld,''F'' encrypted,null masking,null lastcharmask,null firstcharmask,null maskchar,null maskroles,null customdecimal	
		from axattachworkflow a join tstructs t on a.transid = t.name  and t.blobno=1		
		join axpdc d on a.transid = d.tstruct and d.dname =''dc1''		
		left join axlanguage lf on substring(lf.sname FROM 2)= t.name and lower(lf.dispname)=''',lower(planguage),''' and lf.compname=''x__headtext''		
		where t.name=','''',rec.dstruct,'''') into v_subentitysql;


	   	

	    for r in execute v_subentitysql
      		loop	    	
        		RETURN NEXT r;	
        	END LOOP;


    END LOOP;


end if;

END; $$;

CREATE FUNCTION {schema}.fn_axpanalytics_pegstatus(ptransid character varying, precordid numeric) RETURNS TABLE(axpeg_processname character varying, axpeg_keyvalue character varying, axpeg_status numeric, axpeg_statustext text, axpeg_recordid numeric)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_pegtable text;
v_pegstatus numeric;

begin
	
	execute 'select status from axpeg_'||ptransid||' where recordid ='||precordid into v_pegstatus;

if v_pegstatus  in(1,2) then 

	return query execute 'select processname axpeg_processname,keyvalue axpeg_keyvalue,status::numeric axpeg_status,statustext::text axpeg_statustext,recordid::numeric axpeg_recordid from axpeg_'||ptransid||' 
where status in (1,2) and recordid ='||precordid;
else
return query execute 'select a.processname,keyvalue,0::numeric status,concat(a.taskname,'' is pending '',string_agg(a.touser,'','')) statustext
,recordid::numeric
from vw_pegv2_activetasks a 
where  a.recordid='||precordid||'
group by a.processname,a.keyvalue,a.taskname,a.recordid';

end if;

exception when others then null;


END; $$;

CREATE FUNCTION {schema}.fn_axpanalytics_se_chartdata(pcriteria character varying) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
rec record;
v_subentitytable varchar;
v_transid varchar;
v_operations varchar;
v_aggfnc varchar;
v_tablename varchar;
v_sql text;
v_keyfld_fname varchar;
v_keyfld_fval varchar;
v_keyfld_srckey varchar;
v_keyfld_srctbl varchar;
v_keyfld_srcfld varchar;
v_final_sqls text[] DEFAULT  ARRAY[]::text[];
v_fldname_transidcnd numeric;

begin

--criteria - transid~opr1,opr2,opr3~normalized~srctable~srcfld~allowempty~tablename~keyfld~keyval

		    FOR rec IN
	    	    select unnest(string_to_array(pcriteria,'^')) criteria
		    loop		    			    
	      		v_transid := split_part(rec.criteria,'~',1);
				v_operations := split_part(rec.criteria,'~',2);
				v_keyfld_srckey := split_part(rec.criteria,'~',3);
				v_keyfld_srctbl := split_part(rec.criteria,'~',4);
				v_keyfld_srcfld := split_part(rec.criteria,'~',5);
	      		v_tablename := split_part(rec.criteria,'~',7);
				v_keyfld_fname := split_part(rec.criteria,'~',8);
				v_keyfld_fval := split_part(rec.criteria,'~',9);
				
				

				select tablename into v_subentitytable from axpdc where tstruct = v_transid and dname ='dc1';				
			
				select count(1) into v_fldname_transidcnd from axpflds where tstruct = v_transid and dcname ='dc1' and lower(fname)='transid';

							
				if lower(v_tablename)=lower(v_subentitytable) then
			
				 v_sql := concat('select ','''',v_transid,'''transid,',v_operations,',''General''::varchar cnd,','''',replace(rec.criteria,'''',''),'''  criteria from '
								,v_tablename
								,case when v_keyfld_srckey='T' then ' join '||v_keyfld_srctbl||' on '||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id = '||v_tablename||'.'||v_keyfld_fname end
								,' where ',v_tablename,'.cancel=''F'' and ',
				case when v_fldname_transidcnd > 0 then concat(v_tablename,'.transid=''',v_transid,''' and ') end
				 ,case when v_keyfld_srckey='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else v_keyfld_fname end,'=',v_keyfld_fval);				
				
				else 
				
				v_sql := concat('select ','''',v_transid,'''transid,',v_operations,',''General''::varchar cnd,','''',replace(rec.criteria,'''',''),'''  criteria from '
								,v_tablename,' a join ',v_subentitytable,' b on a.',v_subentitytable,'id=b.',v_subentitytable,'id '
								,case when v_keyfld_srckey='T' then ' join '||v_keyfld_srctbl||' on '||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id = a.'||v_keyfld_fname end
								,' where b.cancel=''F'' and ',
				case when v_fldname_transidcnd > 0 then concat(' b.transid=''',v_transid,''' and ') end
				 ,case when v_keyfld_srckey='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else v_keyfld_fname end,'=',v_keyfld_fval);
				
					
				end if;
			
				v_final_sqls := array_append(v_final_sqls,v_sql);			
			
			END LOOP;	
		

 
   return array_to_string(v_final_sqls,'^^^') ;

END;
$$;

CREATE FUNCTION {schema}.fn_axpanalytics_se_listdata(pentity_transid character varying, pflds_keyval text, ppagesize numeric DEFAULT 50, ppageno numeric DEFAULT 1) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
rec record;
rec1 record;
rec2 record;
v_sql text;
v_sql1 text;
v_fldname_table varchar;
v_fldname_col varchar;
v_fldname_normalized varchar;
v_fldname_srctbl varchar;
v_fldname_srcfld varchar;
v_fldname_allowempty varchar;
v_fldname_transidcnd numeric;
v_allflds varchar;
v_fldnamesary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_join varchar;
v_fldname_tblflds text;
v_fldname_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_emptyary varchar[] DEFAULT  ARRAY[]::varchar[];
v_pflds_transid varchar;
v_pflds_flds varchar;
v_pflds_keyvalue varchar;
v_pflds_keytable varchar;
v_keyvalue_fname varchar;
v_keyvalue_fvalue varchar;
v_keyvalue_fname_srckey varchar;
v_keyvalue_fname_srctbl varchar;
v_keyvalue_fname_srcfld varchar;
v_final_sqls text[] DEFAULT  ARRAY[]::text[];
v_primarydctable varchar;
v_fldname_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];

begin	

	
	FOR rec in select unnest(string_to_array(pflds_keyval,'++')) fldkeyvals ---- multiple transid split   	 
    loop
	    	
	    	v_pflds_transid := split_part(rec.fldkeyvals,'=',1) ;	    	
	    	v_pflds_flds := split_part(rec.fldkeyvals,'=',2) ;--tablename=~fldname~normalized~source_table~source_fld~mandatory|fldname2~normalized~source_table~source_fld~mandatory^tablename2=~fldname~normalized~srctbl~srcfld~mandatory
	    	v_pflds_keyvalue := split_part(rec.fldkeyvals,'=',3) ;
	    	v_pflds_keytable := split_part(v_pflds_keyvalue,'~',3) ;  	    
			v_keyvalue_fname := split_part(v_pflds_keyvalue,'~',1);
			v_keyvalue_fvalue := split_part(v_pflds_keyvalue,'~',2);		
			v_keyvalue_fname_srckey := split_part(v_pflds_keyvalue,'~',4) ;
			v_keyvalue_fname_srctbl := split_part(v_pflds_keyvalue,'~',5) ;
			v_keyvalue_fname_srcfld := split_part(v_pflds_keyvalue,'~',6) ;		
						
	    	

	    	select tablename into v_primarydctable from axpdc where tstruct =v_pflds_transid and dname ='dc1';
	    
	    	select count(1) into v_fldname_transidcnd from axpflds where tstruct = v_pflds_transid and dcname ='dc1' and lower(fname)='transid';
	    	    	    
	    
	    	if lower(v_pflds_keytable) = lower(v_primarydctable) and v_pflds_flds ='All' then
		    	select concat(tablename ,'!~',string_agg(str,'|'))  into v_allflds From(
				select tablename,concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str
				from axpflds where tstruct=v_pflds_transid and 
				dcname ='dc1' and 
				asgrid ='F' and hidden ='F' and savevalue='T' and datatype not in('i','t') and lower(fname)!='transid'
				order by dcname ,ordno)a group by a.tablename;
			elsif lower(v_pflds_keytable) != lower(v_primarydctable) and v_pflds_flds ='All' then
				select concat(tablename ,'!~',string_agg(str,'|'),'^',v_pflds_keytable,'!~',split_part(split_part(v_pflds_keyvalue,'~',1),'.',2),'~',split_part(v_pflds_keyvalue,'~',4),'~',split_part(v_pflds_keyvalue,'~',5),'~',split_part(v_pflds_keyvalue,'~',6),'~',split_part(v_pflds_keyvalue,'~',7))  into v_allflds From(
				select tablename,concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str
				from axpflds where tstruct=v_pflds_transid and 
				dcname ='dc1' and 
				asgrid ='F' and hidden ='F' and savevalue='T' and datatype not in('i','t')
				order by dcname ,ordno)a group by a.tablename;				
		    end if;
	    
	    for rec1 in select unnest(string_to_array(case when v_pflds_flds='All' then v_allflds else v_pflds_flds end,'^')) tblflds --single transid & single table split --tablename=~fldname~normalized~source_table~source_fld~mandatory|fldname2~normalized~source_table~source_fld~mandatory 
	    	loop		    			    			    			     
		    		v_fldname_table := 	split_part(rec1.tblflds,'!~',1);
		    		v_fldname_tblflds := 	split_part(rec1.tblflds,'!~',2);
		    		
		    	if lower(v_fldname_table)!=lower(v_primarydctable) then
					v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_fldname_table,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_fldname_table,'.',v_primarydctable,'id') );		    							
				end if;
		    
				if lower(v_fldname_table)!=lower(v_pflds_keytable) then
					v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_pflds_keytable,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_pflds_keytable,'.',v_primarydctable,'id') );		    							
				end if;
				
					if v_keyvalue_fname_srckey='T' then 
							v_fldname_joinsary := array_append(v_fldname_joinsary,concat(' join ' ,v_keyvalue_fname_srctbl,' ',' on ',v_keyvalue_fname,' = ',v_keyvalue_fname_srctbl,'.',v_keyvalue_fname_srctbl,'id')::Varchar);
					
							end if;
							
		
		    			    	
			    FOR rec2 in			    	
    				select unnest(string_to_array(v_fldname_tblflds,'|')) fldname--tablename=~fldname~normalized~source_table~source_fld~mandatory
						loop							
							v_fldname_col := split_part(rec2.fldname,'~',1);
							v_fldname_normalized := split_part(rec2.fldname,'~',2);
							v_fldname_srctbl := split_part(rec2.fldname,'~',3);
							v_fldname_srcfld := split_part(rec2.fldname,'~',4);														
							v_fldname_allowempty := split_part(rec2.fldname,'~',5);
								
						
							
							
							
							if v_fldname_normalized ='F' and lower(v_fldname_col)!='app_desc' then 
								v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_table,'.',v_fldname_col)::varchar);
							elsif v_fldname_normalized ='F' and lower(v_fldname_col)='app_desc' then						
								v_fldnamesary:= array_append(v_fldnamesary,concat('case when length(',v_fldname_table,'.wkid)>2 then case ',v_fldname_table,'.app_desc when 0 then  ''Created''
												  when  1 then ''Approved''
												  when  2 then ''Review''
												  when  3 then ''Return''
												  when  4 then ''Approve''
												  when  5 then ''Rejected''
												  when  9 then ''Orphan'' end else null end app_desc'));
							elsif v_fldname_normalized ='T' then	
								v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_col,'.',v_fldname_srcfld,' ',v_fldname_col)::varchar);	
								
								v_fldname_joinsary := array_append(v_fldname_joinsary,concat(case when v_fldname_allowempty='F' then ' join ' else ' left join ' end,v_fldname_srctbl,' ',v_fldname_col,' on ',v_fldname_table,'.',v_fldname_col,' = ',v_fldname_col,'.',v_fldname_srctbl,'id')::Varchar);
							end if;								
												
						

						

			    		end loop;
		   end loop;
		  
		  v_fldname_dcjoinsary := ARRAY(SELECT DISTINCT UNNEST(v_fldname_dcjoinsary));	
		  v_fldname_joinsary := ARRAY(SELECT DISTINCT UNNEST(v_fldname_joinsary));
		
		   
		   	v_sql := concat(' select ','''',v_pflds_transid,''' transid,',v_primarydctable,'.',v_primarydctable,'id recordid,',v_primarydctable,'.username modifiedby,',v_primarydctable,'.modifiedon,',v_primarydctable,'.createdon,',v_primarydctable,'.createdby,',
						v_primarydctable,'.cancel,',v_primarydctable,'.cancelremarks,',array_to_string(v_fldnamesary,','),
						',null axpeg_processname,null axpeg_keyvalue,null axpeg_status,null axpeg_statustext from ',v_primarydctable,' ',array_to_string(v_fldname_dcjoinsary,' '),' ',array_to_string(v_fldname_joinsary,' '),
		   				' where 1=1',case when v_fldname_transidcnd>0 then concat(' and ',v_primarydctable,'.transid=','''',v_pflds_transid,''' and ') else ' and ' end ,
						case when v_keyvalue_fname_srckey='T'  then v_keyvalue_fname_srctbl||'.'||v_keyvalue_fname_srcfld else v_keyvalue_fname end ,'=',v_keyvalue_fvalue,'
						--axp_filter
						');

		   				v_fldnamesary:= v_emptyary;
		   				v_fldname_joinsary:= v_emptyary;	   				
		   				v_fldname_dcjoinsary:= v_emptyary;	   				
	 
	    
	    if ppagesize>0 then 
	   		v_sql1 := concat('select * from(select a.*,row_number() over(order by modifiedon desc)::Numeric rno,
			case when mod(row_number() over(order by modifiedon desc),',ppagesize,')=0 then row_number() over(order by modifiedon desc)/',ppagesize,' else row_number() over(order by modifiedon desc)/',ppagesize,'+1 end::numeric pageno from 
			(',v_sql,')a order by modifiedon desc limit ',ppagesize*ppageno,' )b ',case when ppageno=0 then '' else concat('where pageno=',ppageno) end);
		else
			v_sql1 := concat('select * from(select a.*,0 rno,1 pageno from (',v_sql,')a order by modifiedon desc)b ');
		end if;
		
		
		
v_final_sqls := array_append(v_final_sqls,v_sql1);

    END LOOP;
  
return array_to_string(v_final_sqls,'^^^') ;
   	
END;
$$;

CREATE FUNCTION {schema}.fn_axpmailjobs() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	declare 
	v_sid numeric(15);
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		select nextval('AXP_MAILJOBSID') into v_sid; 
		
		NEW.jobid = v_sid;
		
		return new;
	end if;
		
end; 
$$;

CREATE FUNCTION {schema}.fn_axprocessdefv2_index_update(pprocessname character varying, pindexno numeric, dbevent character varying, recordid numeric, poldindexno numeric) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare
v_axprocessdefv2id numeric;
begin
	
if dbevent = 'Insert' then 
	select axprocessdefv2id into v_axprocessdefv2id from axprocessdefv2 where processname = pprocessname and indexno = pindexno and axprocessdefv2id!=recordid;
	if v_axprocessdefv2id is not null then
			update axprocessdefv2 set indexno = indexno+1 where axprocessdefv2id = v_axprocessdefv2id;	
			update axprocessdefv2 set indexno = indexno+1 where processname=pprocessname and indexno>pindexno and  axprocessdefv2id != v_axprocessdefv2id and axprocessdefv2id != recordid;
	end if;
end if;


if dbevent = 'Update' then
	update axprocessdefv2 set indexno = indexno+1 where processname=pprocessname and indexno>=pindexno and indexno < poldindexno and  axprocessdefv2id != recordid;
end if;

if dbevent = 'Delete' then
	update axprocessdefv2 set indexno = indexno-1 where processname=pprocessname and indexno>pindexno and  axprocessdefv2id != recordid;
end if;

exception when others then 
 null ;

end;

$$;

CREATE FUNCTION {schema}.fn_axpscriptrunner() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	DECLARE
   v_trg varchar(100) := coalesce( new.trg_name, 'NA');
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        select pr_bulkexecute(new.SCRIPT_TEXT,v_trg);
		
end; 
$$;

CREATE FUNCTION {schema}.fn_axrelations() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    
    begin

	delete from axentityrelations where mstruct = new.mstruct and mfield = new.mfield and dstruct = new.dstruct and dfield = new.dfield and 'md' = new.rtype;

	delete from axentityrelations where mstruct = new.mstruct and dstruct = new.dstruct  and 'gm' = new.rtype;
	
	insert into axentityrelations ( 
axentityrelationsid,cancel,username,modifiedon,createdby,createdon,app_level,app_desc,
rtype,mstruct,mfield,mtable,primarytable,dstruct,dfield,dtable,rtypeui,mstructui,mfieldui,dstructui,dfieldui,dprimarytable)    
	SELECT DISTINCT nextval('ax_entity_relseq'::regclass) AS axentityrelationsid,
    'F' AS cancel,
    'admin' AS username,
    CURRENT_TIMESTAMP AS modifiedon,
    'admin' AS createdby,
    CURRENT_TIMESTAMP AS createdon,
    1 AS app_level,
    1 AS app_desc,
    new.rtype,
    new.mstruct,
    new.mfield,
    m.tablename AS mtable,
    dc.tablename AS primarytable,
    new.dstruct,
    new.dfield,
    d.tablename AS dtable,
    'Dropdown' AS rtypeui,
    concat(mt.caption, '-(', mt.name, ')') AS mstructui,
    concat(m.caption, '-(', m.fname, ')') AS mfieldui,
    concat(dt.caption, '-(', dt.name, ')') AS dstructui,
    concat(d.caption, '-(', d.fname, ')') AS dfieldui,
    ddc.tablename AS dprimarytable
   FROM tstructs mt 
     JOIN tstructs dt ON new.dstruct = dt.name
     LEFT JOIN axpflds m ON new.mstruct = m.tstruct AND new.mfield = m.fname
     LEFT JOIN axpflds d ON new.dstruct = d.tstruct AND new.dfield = d.fname
     LEFT JOIN axpdc dc ON new.mstruct = dc.tstruct AND dc.dname = 'dc1'
     LEFT JOIN axpdc ddc ON new.dstruct = ddc.tstruct AND ddc.dname = 'dc1'
  WHERE new.rtype = 'md' and new.mstruct = mt.name
UNION ALL
 SELECT DISTINCT nextval('ax_entity_relseq'::regclass) AS axentityrelationsid,
    'F' AS cancel,
    'admin' AS username,
    CURRENT_TIMESTAMP AS modifiedon,
    'admin' AS createdby,
    CURRENT_TIMESTAMP AS createdon,
    1 AS app_level,
    1 AS app_desc,
    'gm'::character varying AS rtype,
    new.mstruct AS mstruct,   
null mfield,  
	null as mtable,
    pd.tablename AS primarytable,
    new.dstruct,
    'sourceid'::character varying AS dfield,
    td.tablename AS dtable,
    'Genmap' AS rtypeui,
    concat(mt.caption, '-(', mt.name, ')') AS mstructui,
    NULL AS mfieldui,
    concat(dt.caption, '-(', dt.name, ')') AS dstructui,
    NULL AS dfieldui,
    td.tablename AS dprimarytable
   FROM tstructs mt 
     JOIN tstructs dt ON new.dstruct = dt.name 
     LEFT JOIN axpdc td ON new.dstruct = td.tstruct AND td.dname = 'dc1'
     LEFT JOIN axpdc pd ON new.mstruct = pd.tstruct AND pd.dname = 'dc1'
where  new.mstruct = mt.name and 'gm' = new.rtype ;

return new;
  end; 

$$;

CREATE FUNCTION {schema}.fn_axsms() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	declare 
	v_sid numeric(15);
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		select nextval('AXsmsID') into v_sid; 
		
		NEW.RECORDID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_axuserlevelgroups() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN
		
		NEW.USERNAME  = NEW.axUSERNAME ;
		NEW.usergroup = NEW.axusergroup ;
		
		return new;
	end if;
		
	IF (TG_OP = 'UPDATE') THEN
		
		NEW.USERNAME  = NEW.axUSERNAME ;
		NEW.usergroup = NEW.axusergroup ;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_axusers() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    
    BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN
		
		NEW.USERNAME  = NEW.PUSERNAME ;
		NEW.PASSWORD = NEW.PPASSWORD ;
		
		return new;
	end if;
		
		IF (TG_OP = 'UPDATE') THEN
		
		NEW.USERNAME  = NEW.PUSERNAME ;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_axusers_usergrp(pusername character varying, pusergroup character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
begin
	
delete from axpdef_peg_usergroups where username = pusername and fromuser='T';
 
insert into axpdef_peg_usergroups 
select pusername,unnest(string_to_array(pusergroup,',')),unnest(string_to_array(pusergroup,',')),'T',current_date ,'T';
	
end;

$$;

CREATE FUNCTION {schema}.fn_dac_masterdata(pmtransid character varying, pmfldname character varying, pminctransid numeric, pmcnd numeric) RETURNS TABLE(datavalue character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sql text;
v_mastertable varchar(50);
begin
	
	
	if pmcnd = 2 then 
	select tablename into v_mastertable from axpflds where tstruct = pmtransid and fname = pmfldname;
	else 
	v_mastertable = pmtransid;
	end if; 	

	v_sql := concat('select distinct ',pmfldname,' from ',v_mastertable,case when pminctransid = 0 then null else concat('where transid = ','''',pmtransid,'''') end );
					
	

return query execute v_sql;

exception when others then null;

END; 
$$;

CREATE FUNCTION {schema}.fn_fastprint_formdata_sql(ptransid character varying) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec1 record;
rec2 record;
v_sql text;
v_primarydctable varchar;
v_fldnamesary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_col varchar;
v_fldname_normalized varchar;
v_fldname_srctbl varchar;
v_fldname_srcfld varchar;
v_fldname_allowempty varchar;
v_fldname_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_dctablename varchar;
v_fldname_dcflds text;
v_allflds varchar;


begin

select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';

 select string_agg(b.tbl,'^') into v_allflds from(		
select concat(tablename,'=',string_agg(str,'|')) tbl From(
select tablename, concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str
from axpflds where tstruct=ptransid and asgrid ='F' 
and hidden ='F' and savevalue='T' 
order by dcname ,ordno)a group by a.tablename)b;		

						
		FOR rec1 IN
    		select unnest(string_to_array(v_allflds,'^')) dcdtls
    		loop	
    			v_fldname_dctablename := split_part(rec1.dcdtls,'=',1);
				v_fldname_dcflds := split_part(rec1.dcdtls,'=',2);
			
			if v_fldname_dctablename!=v_primarydctable then
						v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_fldname_dctablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_fldname_dctablename,'.',v_primarydctable,'id') );						
					end if;
					

			FOR rec2 IN
    		select unnest(string_to_array(v_fldname_dcflds,'|')) fldname    		    	       			
				loop		    	
					v_fldname_col := split_part(rec2.fldname,'~',1);
					v_fldname_normalized := split_part(rec2.fldname,'~',2);
					v_fldname_srctbl := split_part(rec2.fldname,'~',3);
					v_fldname_srcfld := split_part(rec2.fldname,'~',4);	
					v_fldname_allowempty := split_part(rec2.fldname,'~',5);
			    
				
					
					if v_fldname_normalized ='F' then 
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_dctablename,'.',v_fldname_col)::varchar);
					elsif v_fldname_normalized ='T' then	
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_col,'.',v_fldname_srcfld,' ',v_fldname_col)::varchar);	
						v_fldname_joinsary := array_append(v_fldname_joinsary,concat(case when v_fldname_allowempty='F' then ' join ' else ' left join ' end,v_fldname_srctbl,' ',v_fldname_col,' on ',v_fldname_dctablename,'.',v_fldname_col,' = ',v_fldname_col,'.',v_fldname_srctbl,'id')::Varchar);						
					end if;
								
			    end loop;
		   
			   end loop;

		   	v_sql := concat(' select ',array_to_string(v_fldnamesary,','),' from ',v_primarydctable,' ',
		   			 array_to_string(v_fldname_dcjoinsary,' '),' ',array_to_string(v_fldname_joinsary,' '),' where ',v_primarydctable,'.',v_primarydctable,'id= :recordid');
 

		   			

return v_sql;


END; $$;

CREATE FUNCTION {schema}.fn_generate_cardjson(pchartprops text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
    cardprops1 text;
BEGIN

 

select concat('{"attributes":{',
'"cck":"',split_part( pchartprops,'|',1),'",',
'"shwLgnd":',lower(split_part(pchartprops,'|',2)),','
'"xAxisL":"',split_part(pchartprops,'|',3),'",'
'"yAxisL":"',split_part(pchartprops,'|',4),'",'
'"gradClrChart":',lower(split_part(pchartprops,'|',5)),','
'"shwChartVal":',lower(split_part(pchartprops,'|',6)),','
'"threeD":"',case when split_part(pchartprops,'|',7)='True' then 'create' else 'remove' end,'",'
'"enableSlick":',lower(split_part(pchartprops,'|',8)),
',"numbSym":',lower(split_part(pchartprops,'|',9)),
'','}}')  into cardprops1 from dual ac;

 

RETURN cardprops1;

END;
$$;

CREATE FUNCTION {schema}.fn_get_query_cols(pquery text) RETURNS TABLE(column_list character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
BEGIN
   EXECUTE 'CREATE TEMP TABLE vtmp1 ON COMMIT DROP AS ' ||pquery|| ' limit 1';
   EXECUTE 'CREATE TEMP TABLE vtmp2 ON COMMIT DROP AS select column_name::varchar from INFORMATION_SCHEMA.COLUMNS where table_name =''vtmp1'' ';

     RETURN QUERY TABLE vtmp2;
END
$$;

CREATE FUNCTION {schema}.fn_homebuild_saved_bir() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sid numeric(15);

	BEGIN
	select nextval('ax_homebuild_saved_seq') into v_sid ; 

        IF (TG_OP = 'INSERT') THEN 
		
		NEW.HOMEBUILD_ID = v_sid;
		
		return new;
	end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_iconfiguration() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare
v_cnt numeric(2);
v_sql varchar(4000);

	begin
		
		
		IF (TG_OP = 'INSERT') THEN 
		
		select COALESCE(count(table_name),0) into v_cnt from information_schema.tables where lower(table_name) = lower( 'axpconfigs'||chr(95)||new.structtransid ) and lower(table_schema)=current_schema();
      if v_cnt = 0
      then
      v_sql := 'create table axpconfigsiv'||chr(95)||new.structtransid||' ( configname varchar(30),cvalue varchar(2000),condition varchar(240))' ;
        execute v_sql;
		
        end if;
		

			if new.cv_groupbuttons is not null then
        v_sql = 'insert into axpconfigsiv'||chr(95)||new.structtransid||' ( configname,cvalue,condition ) values ('''||new.configname2||''','''||new.cv_groupbuttons||''',null)';
        execute  v_sql;
      	end if;
		
		return new;
		end if;
		
		IF (TG_OP = 'UPDATE') THEN 
		
		v_sql = 'delete from axpconfigsiv'||chr(95)||old.structtransid;
        execute  v_sql;        
        
		if new.cv_groupbuttons is not null then
        v_sql = 'insert into axpconfigsiv'||chr(95)||new.structtransid||' ( configname,cvalue,condition ) values ('''||new.configname2||''','''||new.cv_groupbuttons||''',null)';
        execute  v_sql;
      	end if;
		
		return new;
		
		end if;
		
		IF (TG_OP = 'DELETE') THEN 
		
		v_sql = 'delete from axpconfigsiv'||chr(95)||old.structtransid;
        execute  v_sql;   
        v_cnt = 2 ;
		
		return new;
		
		end if;
end; 
$$;

CREATE FUNCTION {schema}.fn_peg_assigntoactor(assigntoactor character varying, actorfilter character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
rec record;
ag record;
agc record;
v_grpname varchar[] DEFAULT  ARRAY[]::varchar[];
qry text;
sqlstmt refcursor;
cndresult int;
grpresult int;
truecnt int;
v_totalcnd int;
allusers int;
v_datagrpusers varchar[] DEFAULT  ARRAY[]::varchar[];

begin
	grpresult = 0;
truecnt = 0;
cndresult = 0;
allusers=0;

	<<Actor_Groups>>
	for ag in 	
	select a.actorname,b.axpdef_peg_grpfilterrow,b.tbl_datagrp,b.datagrpusers,axpdef_peg_grpfilterid,a.priorindextransid stransid
	from axpdef_peg_actor a,axpdef_peg_grpfilter b
	where a.axpdef_peg_actorid =b.axpdef_peg_actorid 	
	and a.actorname = assigntoactor 
	
	loop		
	select array_length(string_to_array( tbl_datagrp, '~'),1)  into v_totalcnd from axpdef_peg_grpfilter 
	where axpdef_peg_grpfilterid = ag.axpdef_peg_grpfilterid;

	<<Groups_Condition>>	
		for agc in 
			select substring(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')), position('-(' in unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')))+ 2, abs((position('-(' in unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')))+ 2) - length(substring(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')), 1, length(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ','))))))) fldname,
			substring(substring(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')), position('-(' in unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')))+ 2, abs((position('-(' in unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')))+ 2) - length(substring(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ',')), 1, length(unnest(string_to_array( split_part(tbl_datagrp,'|',1) , ','))))))),1,1) flddatatype,
			case when split_part(tbl_datagrp,'|',2) = 'Equal to' then '='
			when split_part(tbl_datagrp,'|',2) = 'Not equal to' then '!='
			when split_part(tbl_datagrp,'|',2) = 'In' then 'in'
			when split_part(tbl_datagrp,'|',2) = 'Not in' then 'not in'
			when split_part(tbl_datagrp,'|',2) = 'Greater than' then '>'
			when split_part(tbl_datagrp,'|',2) = 'Greater than or Equal to' then '>='
			when split_part(tbl_datagrp,'|',2) = 'Lesser than' then '<'
			when split_part(tbl_datagrp,'|',2) = 'Lesser than or Equal to' then '<=' end cndoprsym,
			split_part(tbl_datagrp,'|',3) fldvalue,axpdef_peg_grpfilterid,datagrpusers,dgname from 
			(select unnest(string_to_array(tbl_datagrp,'~')) tbl_datagrp,axpdef_peg_grpfilterid,datagrpusers,dgname
			from axpdef_peg_grpfilter g2
			where g2.axpdef_peg_grpfilterid =  ag.axpdef_peg_grpfilterid)a		
			
			
			loop 
				
				if agc.cndoprsym  = 'in' or agc.cndoprsym  = 'not in' then										
					open sqlstmt for with ud as (select split_part(regexp_split_to_table(actorfilter,'~'),'=',1) cndfld,
					split_part(regexp_split_to_table(actorfilter,'~'),'=',2) cndfldval) 
					select *  from ud;
					fetch next from sqlstmt into rec;						
					<<user_data>>
					while found loop 	   						
			   		qry :='select count(*) from dual where '''||agc.fldname||'''='''||rec.cndfld ||''' and '''|| rec.cndfldval||''''||agc.cndoprsym||'('''||replace(agc.fldvalue,',',''',''')||''')';			   					   						   		
				   	execute qry into cndresult;					   					  	
 				    if cndresult > 0 then  grpresult := grpresult +1; end if;					  						  				 					   
				  	if cndresult > 0 then truecnt := truecnt + 1; end if;
				  	exit user_data when cndresult > 0;
				  	fetch next from sqlstmt into rec; 			      	
    				end loop;    		
    			 	if v_totalcnd = truecnt then      			 	
					  	v_grpname := array_append(v_grpname,agc.dgname);  
					  	v_datagrpusers := array_append(v_datagrpusers,cast(concat(agc.dgname,'~~',agc.datagrpusers)as varchar(4000)));
    				end if;  
					CLOSE sqlstmt;
				else
					open sqlstmt for with ud as (select * from(select split_part(regexp_split_to_table(actorfilter,'~'),'=',1) cndfld,
					split_part(regexp_split_to_table(actorfilter,'~'),'=',2) cndfldval)a
					where cndfld = agc.fldname
					) 
					select * from ud;
					fetch next from sqlstmt into rec;						
					<<user_data>>
					while found loop 	   						
			   		qry :='select count(*) from dual where '''||agc.fldname||'''='''||rec.cndfld||'''' ||case when agc.flddatatype='n' then ' and '||rec.cndfldval||' '||agc.cndoprsym||' '||agc.fldvalue else  ' and '''||rec.cndfldval||''''||agc.cndoprsym||''''||agc.fldvalue||''''end;			   					   											   	
			   		execute qry into cndresult;					   						
 					if cndresult > 0 then  grpresult := grpresult +1; end if;								  				 					   	
					if cndresult > 0 then truecnt := truecnt + 1; end if;					  
					exit user_data when cndresult > 0;
				    fetch next from sqlstmt into rec;				      	
    				end loop;    		
    				if v_totalcnd = truecnt then  
					  	v_grpname := array_append(v_grpname,agc.dgname); 	
	  				    v_datagrpusers := array_append(v_datagrpusers,cast(concat(agc.dgname,'~~',agc.datagrpusers)as varchar(4000)));
    				end if; 
					CLOSE sqlstmt;
				end if;    		
			end loop;		
			grpresult = 0;truecnt = 0;			
	end loop;		
if array_length(v_datagrpusers,1)>0 then 
return array_to_string(v_datagrpusers,'|~');
else 
return '0'; end if;
end;
$$;

CREATE FUNCTION {schema}.fn_peg_assigntorole(useridentificationfilter character varying, useridentificationfilter_of character varying, initiator character varying, priorusername character varying, assigntorole character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
rec record;
qry text;
sqlstmt refcursor;
rowcount int;
userlist varchar;
begin
rowcount = 1;

if useridentificationfilter is not null then
		open sqlstmt for 
		with a as (select regexp_split_to_table(useridentificationfilter, E',')grp)
		select ''''||b.groupname||'''' groupname,string_agg(''''||groupvalue||'''',',') groupvalue from usergroupings b,a --,axuserlevelgroups c
		where b.username=case when useridentificationfilter_of='Initiator' then initiator when useridentificationfilter_of='Prior User' then priorusername end
		and b.groupname = a.grp  
		--and b.username = c.username and c.usergroup = assigntorole
		--and ((c.startdate is not null and current_date  >= c.startdate) or (c.startdate is null)) 
		--and ((c.enddate is not null and current_date  <= c.enddate) or (c.enddate is null))
		group by b.groupname  ;

		fetch next from sqlstmt into rec;

		while found 		
    		loop 	
    		
			    if rowcount = 1 then 
				qry :='select string_agg(distinct u.username,'','')   from usergroupings u,axuserlevelgroups l where u.username = l.username and l.usergroup='''||assigntorole ||''' and groupname ='||rec.groupname||' and groupvalue in('||  rec.groupvalue||') and u.username!='||''''||
					   case when useridentificationfilter_of='Initiator' then initiator when useridentificationfilter_of='Prior User' then priorusername end||'''';
				else 
				
				qry :='select string_agg(distinct u.username,'','')   from usergroupings u,axuserlevelgroups l  where u.username = l.username and l.usergroup='''||assigntorole ||''' and groupname ='||rec.groupname||' and groupvalue in('||  rec.groupvalue||')
					   and u.username in('||''''||replace(coalesce(userlist,''),',',''',''')||''''||') 
					   and u.username!='||''''||case when useridentificationfilter_of='Initiator' then initiator when useridentificationfilter_of='Prior User' then priorusername end||''''
					   ;
				end if;
													
			execute qry into userlist;			
   			rowcount := rowcount + 1;
   				
		    fetch next from sqlstmt into rec;
		   		    
    		end loop;			
	end if;

return userlist;
	
		
end;

$$;

CREATE FUNCTION {schema}.fn_peg_utl_actorusers(assigntoactor character varying, actorfilter character varying, pinitiator character varying) RETURNS TABLE(pusername character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_assignmodecnd int;
v_defusers varchar;
v_datagrpusers varchar;
usercount int;
v_users varchar;
v_initiator_usergrps varchar;
v_usergrpuser varchar;

begin

select coalesce(assignmodecnd,0) assignmodecnd,defusername,
case when array_length(string_to_array(defusername,','),1) is null then 0 
else  array_length(string_to_array(defusername,','),1) end usercount
into v_assignmodecnd,v_defusers ,usercount
from axpdef_peg_actor a
where a.actorname=assigntoactor; 

	if v_assignmodecnd = 1 then --------Default user
	
		if usercount > 0 then
		v_users := v_defusers;
		end if;
	
	elseif v_assignmodecnd = 2 then -----------User group
		select distinct string_agg(usergroupname,',') into  v_initiator_usergrps 
		from axpdef_peg_usergroups 
		where username = pinitiator and active='T' and effectivefrom <= current_date;
		
		----------- Check approval users are assigned for the initiator's group
		select string_agg(concat(usergroupname,'~~',unames),'|~') ,count(*) into v_usergrpuser,usercount
		from (select distinct b.usergroupname, b.ugrpusername unames
		from axpdef_peg_actor a
		join axpdef_peg_actorusergrp b on a.axpdef_peg_actorid=b.axpdef_peg_actorid
		where a.actorname = assigntoactor 
		and b.usergroupname in (select regexp_split_to_table(v_initiator_usergrps,','))
		order by 1 )a;
		
			--------- if approval users are assinged in process users
		if usercount > 0 then 
		select	split_part(v_usergrpuser,'~~',2) into v_users;
		end if;	
			
	elseif v_assignmodecnd = 3 then 	---- Data groups
		select fn_peg_assigntoactor(assigntoactor,actorfilter) into v_datagrpusers ;		
			if v_datagrpusers != '0' then
				select split_part(v_datagrpusers,'~~',2) dgrpusers into v_users;
			end if;
	end if;		

return query 

select cast(regexp_split_to_table(v_users,',') as varchar);

end;
$$;

CREATE FUNCTION {schema}.fn_pegv2_editabletask(p_processname character varying, p_taskname character varying, p_keyvalue character varying, p_currentuser character varying, p_indexno numeric) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_flag varchar(1);
v_finalapproved varchar(1);
v_finalappqry text;
v_currentuser varchar(50);
v_editable varchar(1);
v_nextleveluser numeric;
v_activeuser numeric;
--p_indexno numeric;
begin
 
	--select indexno into p_indexno from axprocessdefv2 where processname = p_processname and taskname =p_taskname;

-----Transaction final approval check
/*select concat('select case when status=0 then ''F'' else ''T'' end from axpeg_',transid,' where keyvalue=''',p_keyvalue,'''') into v_finalappqry 
from axprocessdefv2 where processname=p_processname and taskname=p_taskname;*/
    
select concat('select case when status=0 then ''F'' else ''T'' end from axpeg_',transid,' where keyvalue=''',p_keyvalue,'''') into v_finalappqry 
from axprocessdefv2 where processname=p_processname
and indexno =(select max(indexno) from axprocessdefv2 a where processname=p_processname and stransid!='pgv2c'); 

execute v_finalappqry into v_finalapproved;

--- Current task createdby user and the next task touser is same
select sum(case when taskname =p_taskname and touser=p_currentuser then 1 else 0 end) activeuser,
sum(case when indexno =p_indexno+1 and touser = p_currentuser then 1 else 0 end) nexttaskuser
into v_activeuser,v_nextleveluser from vw_pegv2_activetasks vpa 
where processname =p_processname and keyvalue =p_keyvalue;



-----Task is created by current user
select case when username = p_currentuser then 'T' else 'F' end into  v_currentuser
from axactivetaskstatus where processname=p_processname and taskname=p_taskname and keyvalue=p_keyvalue;

------Editable task validation in process definition
with a as (
select cast(regexp_split_to_table(allowedittasksid,',') as numeric)  defid,axprocessdefv2id from axprocessdefv2 a1 where processname=p_processname and allowedit='T') 
select case when count(*) = 0 then 'F' else 'T' end flg  into v_flag from axprocessdefv2 b join a on a.axprocessdefv2id = b.axprocessdefv2id
join axprocessdefv2 c on a.defid = c.axprocessdefv2id and c.taskname=p_taskname
join axactivetasks t on b.processname = p_processname and keyvalue = p_keyvalue and b.taskname = t.taskname and t.touser = p_currentuser;

/*select case when v_finalapproved='T' then 'F' 
when  v_finalapproved='F' and v_currentuser='T' then 'T'
when v_finalapproved='F' and v_currentuser='F' then v_flag else 'F' end into v_editable;*/

select case when v_finalapproved='T' then 'F' else 
case when v_activeuser > 0 then 'T'
when v_currentuser='T' and v_nextleveluser > 0 then 'T'  
when v_currentuser='F' and v_activeuser = 0  then v_flag else v_flag end end into v_editable;


return v_editable;
end;

$$;

CREATE FUNCTION {schema}.fn_pegv2_tasklists(pprocessname character varying, pindexno numeric, ptaskname character varying DEFAULT NULL::character varying, ptransid character varying DEFAULT NULL::character varying, precordid numeric DEFAULT 0, pusername character varying DEFAULT NULL::character varying, ptaskid numeric DEFAULT 0, pkeyvalue character varying DEFAULT NULL::character varying) RETURNS TABLE(taskname character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_sql text;

begin
	
	v_sql := 'SELECT TASKNAME FROM AXPROCESSDEFV2 a WHERE PROCESSNAME  = '''||pprocessname||''' AND INDEXNO >'|| pindexno ||'order by indexno';
		
	
    RETURN QUERY    execute v_sql;
END; $$;

CREATE FUNCTION {schema}.fn_pegv2_updapp_datagroups() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_newusers varchar(4000);
v_delusers varchar(4000);
v_retainedusers varchar(4000);
begin

with a as(select regexp_split_to_table(new.olddatagrpusers,',') usr),b as (select regexp_split_to_table(new.datagrpusers,',') usr)
select string_agg(a.usr,',') into v_delusers from a left join b on a.usr = b.usr
where b.usr is null;

with a as(select regexp_split_to_table(new.olddatagrpusers,',') usr),b as (select regexp_split_to_table(new.datagrpusers,',') usr)
select string_agg(b.usr,',') into v_newusers from a right join b on a.usr = b.usr
where a.usr is null;


with a as(select regexp_split_to_table(new.olddatagrpusers,',') usr),b as (select regexp_split_to_table(new.datagrpusers,',') usr)
select string_agg(b.usr,',') into v_retainedusers from a join b on a.usr = b.usr;


update axactivetasks a set removeflg='T' where assigntoflg='2' and delegation='F' and pownerflg='F' and removeflg='F' and grouped='T'
and assigntoactor= new.dg_actorname 
and actor_data_grp  = new.dgname
and touser in(select regexp_split_to_table(v_delusers,','))
and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid);


insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,changedusr,actor_data_grp) 	
	select distinct eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,
	execonapprove,keyvalue,transdata,fromrole,fromuser,regexp_split_to_table(v_newusers,','),priorindex,priortaskname,corpdimension,
	orgdimension,department,grade,datavalue,displayicon,displaytitle,displaysubtitle,displaycontent,
	displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,	useridentificationfilter,
	useridentificationfilter_of,mapfield_group,mapfield,'T',indexno,subindexno,
	processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
	approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
	allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,'T',new.dgname
	from axactivetasks a 	
	where assigntoflg='2' and delegation='F' and pownerflg ='F' and removeflg ='F' and grouped='T'
	and assigntoactor = new.dg_actorname
	and actor_data_grp  = new.dgname 
	and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid); 

	
return new;
end; 
$$;

CREATE FUNCTION {schema}.fn_pegv2_updapp_default() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_newusers varchar(4000);
v_delusers varchar(4000);
v_retainedusers varchar(4000);
begin

with a as(select regexp_split_to_table(new.olddefusername,',') usr),b as (select regexp_split_to_table(new.defusername,',') usr)
select string_agg(a.usr,',') into v_delusers from a left join b on a.usr = b.usr
where b.usr is null;

with a as(select regexp_split_to_table(new.olddefusername,',') usr),b as (select regexp_split_to_table(new.defusername,',') usr)
select string_agg(b.usr,',') into v_newusers from a right join b on a.usr = b.usr
where a.usr is null;


with a as(select regexp_split_to_table(new.olddefusername,',') usr),b as (select regexp_split_to_table(new.defusername,',') usr)
select string_agg(b.usr,',') into v_retainedusers from a join b on a.usr = b.usr;


update axactivetasks a set removeflg='T' where assigntoflg='2' and delegation='F' and pownerflg='F' and removeflg='F' and actor_default_users='T' and grouped='T'
and assigntoactor= new.actorname and touser in(select regexp_split_to_table(v_delusers,','))
and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid);


insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,changedusr,actor_default_users) 	
	select distinct eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,
	execonapprove,keyvalue,transdata,fromrole,fromuser,regexp_split_to_table(v_newusers,','),priorindex,priortaskname,corpdimension,
	orgdimension,department,grade,datavalue,displayicon,displaytitle,displaysubtitle,displaycontent,
	displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,	useridentificationfilter,
	useridentificationfilter_of,mapfield_group,mapfield,'T',indexno,subindexno,
	processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
	approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
	allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,'T','T'
	from axactivetasks a 	
	 where assigntoflg='2' and delegation='F' and pownerflg ='F' and removeflg ='F' and grouped='T' and actor_default_users='T'
	 and assigntoactor = new.actorname	 
	 and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid); 

	
return new;
end; 
$$;

CREATE FUNCTION {schema}.fn_pegv2_updapp_reporting(p_fromuser character varying, p_existingapp character varying, p_newapp character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
begin 

insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,changedusr) 	
	select eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,
	execonapprove,keyvalue,transdata,fromrole,fromuser,p_newapp,priorindex,priortaskname,corpdimension,
	orgdimension,department,grade,datavalue,displayicon,displaytitle,displaysubtitle,displaycontent,
	displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,	useridentificationfilter,
	useridentificationfilter_of,mapfield_group,mapfield,'T',indexno,subindexno,
	processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
	approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
	allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,'T'
	from axactivetasks a 	
	 where assigntoflg='1' and delegation='F' and pownerflg ='F' and grouped='T'
	 and fromuser= p_fromuser and touser= p_existingapp and removeflg ='F'
	and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid); 
	
	
	
	
update axactivetasks a set removeflg ='T' where assigntoflg='1' and delegation='F' and pownerflg ='F' 
and fromuser= p_fromuser and touser= p_existingapp and not exists 
(SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid);

end; $$;

CREATE FUNCTION {schema}.fn_pegv2_updapp_usegroups() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_newusers varchar(4000);
v_delusers varchar(4000);
v_retainedusers varchar(4000);
begin

with a as(select regexp_split_to_table(new.oldugrpusername,',') usr),b as (select regexp_split_to_table(new.ugrpusername,',') usr)
select string_agg(a.usr,',') into v_delusers from a left join b on a.usr = b.usr
where b.usr is null;

with a as(select regexp_split_to_table(new.oldugrpusername,',') usr),b as (select regexp_split_to_table(new.ugrpusername,',') usr)
select string_agg(b.usr,',') into v_newusers from a right join b on a.usr = b.usr
where a.usr is null;


with a as(select regexp_split_to_table(new.oldugrpusername,',') usr),b as (select regexp_split_to_table(new.ugrpusername,',') usr)
select string_agg(b.usr,',') into v_retainedusers from a join b on a.usr = b.usr;


update axactivetasks a set removeflg='T' where assigntoflg='2' and delegation='F' and pownerflg='F' and removeflg='F' and grouped='T'
and assigntoactor= new.ug_actorname 
and actor_user_groups  = new.usergroupname
and touser in(select regexp_split_to_table(v_delusers,','))
and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid);


insert into axactivetasks(eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,execonapprove,
	keyvalue,transdata,fromrole,fromuser,touser,priorindex,priortaskname,corpdimension,orgdimension,department,grade,datavalue,
	displayicon,displaytitle,displaysubtitle,displaycontent,displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,
	useridentificationfilter,useridentificationfilter_of,mapfield_group,mapfield,grouped,indexno,subindexno,processowner,assigntoflg,
	assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,allowsend,
	allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,changedusr,actor_user_groups) 	
	select distinct eventdatetime,taskid,processname,tasktype,taskname,taskdescription,assigntorole,transid,keyfield,
	execonapprove,keyvalue,transdata,fromrole,fromuser,regexp_split_to_table(v_newusers,','),priorindex,priortaskname,corpdimension,
	orgdimension,department,grade,datavalue,displayicon,displaytitle,displaysubtitle,displaycontent,
	displaybuttons,groupfield,groupvalue,priorusername,initiator,mapfieldvalue,	useridentificationfilter,
	useridentificationfilter_of,mapfield_group,mapfield,'T',indexno,subindexno,
	processowner,assigntoflg,assigntoactor,actorfilter,recordid,processownerflg,pownerfilter,
	approvereasons,defapptext,returnreasons,defrettext,rejectreasons,defregtext,
	approvalcomments,rejectcomments,returncomments,escalation,reminder,displaymcontent,groupwithpriorindex,returnable,
	allowsend,allowsendflg,sendtoactor,initiator_approval,usebusinessdatelogic,initonbehalf,'T',new.usergroupname
	from axactivetasks a 	
	 where assigntoflg='2' and delegation='F' and pownerflg ='F' and removeflg ='F' and grouped='T'
	 and assigntoactor = new.ug_actorname
	 and actor_user_groups  = new.usergroupname 
	 and not exists (SELECT b.taskid FROM axactivetaskstatus b WHERE a.taskid = b.taskid); 

	
return new;
end; 
$$;

CREATE FUNCTION {schema}.fn_permissions_apptstructs(pusername character varying, puserrole character varying, ptype character varying DEFAULT 'Tstruct'::character varying) RETURNS TABLE(transid character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
BEGIN
    RETURN QUERY
select formtransid from axpermissions a
where axusername = pusername and comptype='Form'
union
SELECT formtransid FROM axpermissions
WHERE axuserrole = ANY(string_to_array(puserrole, ','))
and comptype='Form';
 
 
END;
$$;

CREATE FUNCTION {schema}.fn_permissions_axupscript() RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
v_sqlary text[] DEFAULT  ARRAY[]::text[];
v_sql text;
begin

for rec in
select fname from axpflds where tstruct = 'a__ua' and dcname='dc4' and fname not in('sqltext1','cnd1')
loop




v_sql := 'select ''exists(select 1 from unnest(string_to_array('||replace(rec.fname,'axug_','{primarytable.}axg_')||','''','''')) val where val in(''''''||replace( concat(:'||rec.fname||','',All''),'','','''''','''''')||''''''))'' cnd from(select '''||rec.fname||''' gname,unnest(string_to_array(:'||rec.fname||','','')) gval from dual)a group by gname having sum(case when gval=''All'' then 1 else 0 end) = 0';


v_sqlary := array_append(v_sqlary,v_sql);

end loop;

return case when array_length(v_sqlary,1)>0 then  'select string_agg(cnd,'' and '') from ( '||array_to_string(v_sqlary,' union all ')||')b' else 'select null from dual' end;
 
END; $$;

CREATE FUNCTION {schema}.fn_permissions_create_grpcol(ptransid character varying, ptable character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_altersql text; 
r record;
begin
	
for r in select grpname from axgroupingmst 
LOOP 
        BEGIN
            v_altersql := 'ALTER TABLE ' || ptable || ' ADD axg_' || r.grpname || ' varchar(4000) default ''All''';
            EXECUTE v_altersql;
        EXCEPTION WHEN OTHERS THEN
            null;
        END;
    END LOOP;

return 'T';
 
end;

$$;

CREATE FUNCTION {schema}.fn_permissions_getadscnd(ptransid character varying, padsname character varying, pusername character varying, proles character varying DEFAULT 'All'::character varying, pkeyfield character varying DEFAULT NULL::character varying, pkeyvalue character varying DEFAULT NULL::character varying) RETURNS TABLE(fullcontrol character varying, userrole character varying, view_access character varying, view_includeflds character varying, view_excludeflds character varying, maskedflds character varying, filtercnd text, permissiontype character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
rolesql text;
v_permissionsql text;
v_permissionexists numeric;
begin


if proles='All' then 
	rolesql := 'select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
	case when viewctrl=''2'' then viewlist else null end view_excludedflds,a.fieldmaskstr,b.cnd1 cnd,viewctrl,''Role'' permissiontype  
	from AxPermissions a 
	join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
	join axusers u on a2.axusersid = u.axusersid    
	--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join axusergrouping b on u.axusersid = b.axusersid
	where u.username = '''||pusername||''' and a.formtransid='''||padsname||'''
union all
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
	case when viewctrl=''2'' then viewlist else null end view_excludedflds,a.fieldmaskstr,b.cnd,viewctrl,''User'' permissiontype  
	from AxPermissions a 
	left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
	where a.axusername = '''||pusername||''' and a.formtransid='''||padsname||'''';
	
	
	v_permissionsql := 'select count(cnt) from(select 1 cnt
	from AxPermissions a 
	join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
	join axusers u on a2.axusersid = u.axusersid    
	--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join axusergrouping b on u.axusersid = b.axusersid
	where u.username = '''||pusername||''' and a.formtransid='''||padsname||'''
union all
select 1 cnt 
	from AxPermissions a 
	left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
	where a.axusername = '''||pusername||''' and a.formtransid='''||padsname||''')a';

else

	rolesql := 'select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
	case when viewctrl=''2'' then viewlist else null end view_excludedflds,
	a.fieldmaskstr,b.cnd,viewctrl,''Role'' permissiontype  
	from AxPermissions a 
	join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
	join axusers u on a2.axusersid = u.axusersid
	--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join (
select a2.usergroup ,b.cnd1 cnd from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
	where u.username = '''||pusername||''' and a.formtransid='''||padsname||'''
	and exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
union all
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
	case when viewctrl=''2'' then viewlist else null end view_excludedflds,
	a.fieldmaskstr,b.cnd,viewctrl,''User'' permissiontype  from AxPermissions a 
	left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
	where a.axusername = '''||pusername||''' and a.formtransid='''||padsname||'''';
	
	v_permissionsql:= 'select count(cnt) from(select 1 cnt
	from AxPermissions a 
	join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
	join axusers u on a2.axusersid = u.axusersid
	--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join (
select a2.usergroup ,b.cnd1 cnd from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
	where u.username = '''||pusername||''' and a.formtransid='''||padsname||'''
	and exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
union all
select 1  from AxPermissions a 
	left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
	where a.axusername = '''||pusername||''' and a.formtransid='''||padsname||''')a';

end if;

execute v_permissionsql into  v_permissionexists;

if v_permissionexists = 0 then 

	fullcontrol:= 'T';
	return next;

else

	for rec in execute rolesql
	loop
	
			userrole := rec.axuserrole;
			view_includeflds := rec.view_includedflds;
			view_excludeflds := rec.view_excludedflds;
			maskedflds := rec.fieldmaskstr;
			filtercnd := rec.cnd;		
			view_access := case when rec.viewctrl='4' then 'None' else null end;		
			permissiontype := rec.permissiontype;
			return next;
	
	
	end loop;

end if;
 
return;
	
END; 
$$;

CREATE FUNCTION {schema}.fn_permissions_getadssql(ptransid character varying, padsname character varying, pcond text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
v_adssql text;
v_filtersql text;
v_primarydctable varchar;
v_filtercnd text;
v_addfilter varchar;
v_addcolselection varchar;
v_addpagination varchar;
v_addsoring varchar;
v_grouping varchar;
begin




select sqltext,case when smartlistcnd like '%Dynamic select columns%' then 'T' else 'F' end dynamiccolumns,
case when smartlistcnd like '%Filter%' then 'T' else 'F' end filters,
case when smartlistcnd like '%Pagination%' then 'T' else 'F' end pagination,
case when smartlistcnd like '%Sorting%' then 'T' else 'F' end sorting,
case when smartlistcnd like '%Grouping%' then 'T' else 'F' end aggregations
into v_adssql,v_addcolselection,v_addfilter,v_addpagination,v_addsoring,v_grouping from axdirectsql 
where sqlname = padsname;

if pcond !='NA' then 

select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';


v_filtercnd := concat(' and (',replace(pcond,'{primarytable.}',v_primarydctable||'.'),')');
	
v_filtersql := replace(v_adssql,'--ax_permission_filter',v_filtercnd);


end if;


v_adssql := concat(case when v_addcolselection='T' 
then 'select --ax_select_columns 
from('else 'select * from(' end
,v_adssql,')wpc
',case when v_addfilter='T' then '--ax_ui_filter_withwhere
'end,
case when v_grouping='T' then '--ax_groupby
'end,
case when v_addsoring='T' then '--ax_orderby
'end,
case when v_addpagination='T' then '--ax_pagination
'end);


return case when pcond ='NA' then  v_adssql else v_filtersql end;
	
	
END; 
$$;

CREATE FUNCTION {schema}.fn_permissions_getcnd(pmode character varying, ptransid character varying, pkeyfld character varying, pkeyvalue character varying, pusername character varying, proles character varying DEFAULT 'All'::character varying, pglobalvars character varying DEFAULT 'NA'::character varying) RETURNS TABLE(fullcontrol character varying, userrole character varying, allowcreate character varying, view_access character varying, view_includedc character varying, view_excludedc character varying, view_includeflds character varying, view_excludeflds character varying, edit_access character varying, edit_includedc character varying, edit_excludedc character varying, edit_includeflds character varying, edit_excludeflds character varying, maskedflds character varying, filtercnd text, recordid numeric, encryptedflds character varying, permissiontype character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
rolesql text;
v_transid_primetable varchar(100);
v_transid_primetableid varchar(100);
v_keyfld_normalized varchar(1);
v_keyfld_srctbl varchar(100);
v_keyfld_srcfld varchar(100);
v_keyfld_mandatory varchar(1);
v_keyfld_joins varchar(500);
v_keyfld_cnd varchar(500);
sql_permission_cnd text;
sql_permission_cnd_result numeric;
v_dcfldslist text;
v_recordid numeric;
v_permissionsql text;
v_permissionexists numeric;
v_menuaccess numeric;
v_fullcontrolsql text;
v_fullcontrolrecid numeric;
v_final_conditions varchar[] DEFAULT  ARRAY[]::varchar[];
rec_glovars record;
rec_glovars_varname varchar;
rec_glovars_varvalue varchar;
rec_dbconditions record;
v_dimensionsexists numeric;
v_applypermissions numeric;
v_condition varchar;
v_usercondition text;
begin


select count(*) into v_applypermissions from axgrouptstructs where ftransid = ptransid;

select srckey,srctf,srcfld,allowempty into v_keyfld_normalized,v_keyfld_srctbl,v_keyfld_srcfld,v_keyfld_mandatory
from axpflds where tstruct = ptransid and fname = pkeyfld;

select tablename into v_transid_primetable from axpdc where tstruct=ptransid and dname='dc1';

v_transid_primetableid := case when lower(pkeyfld)='recordid' then v_transid_primetable||'id' else pkeyfld end;

v_keyfld_cnd := case when v_keyfld_normalized='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else  v_transid_primetable||'.'||v_transid_primetableid end ||'='||pkeyvalue;

if v_keyfld_normalized='T' then 
	v_keyfld_joins := case when v_keyfld_mandatory='T' then ' join ' else ' left join ' end
					  ||v_keyfld_srctbl||' '||pkeyfld||' on '||v_transid_primetable||'.'||pkeyfld||'='||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id';		
	
end if;

select sum(cnt) into v_menuaccess from 
(select 1 cnt from axusergroups a join axusergroupsdetail b on a.axusergroupsid = b.axusergroupsid
join axuseraccess a2 on b.roles_id = a2.rname and stype ='t' 
where a2.sname = ptransid
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
--left join (select b.axuserrole,b.cnd from axusers a join axuserpermissions b on a.axusersid =b.axusersid where a.username = '''||pusername||''')b on a.axuserrole=b.axuserrole 
left join axusergrouping b on u.axusersid = b.axusersid
where a.formtransid='''||ptransid||''' and u.username = '''||pusername||'''
union all
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl ,''User'' permissiontype
from AxPermissions a
left join axuserDpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||ptransid||'''';


v_permissionsql := 'select count(cnt) from(select 1 cnt
from AxPermissions a 
join axuserlevelgroups a2 on a2.axusergroup = a.axuserrole 
join axusers u on a2.axusersid = u.axusersid    
--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join axusergrouping b on u.axusersid = b.axusersid
where a.formtransid='''||ptransid||''' and u.username = '''||pusername||'''
union all
select 1 cnt
from AxPermissions a
left join axuserDpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||ptransid||''')a';

else

rolesql := 'select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl,''Role'' permissiontype 
from AxPermissions a 
--left join (select b.axuserrole,b.cnd from axusers a join axuserpermissions b on a.axusersid =b.axusersid where a.username = '''||pusername||''')b on a.axuserrole=b.axuserrole
left join (
select a2.usergroup ,b.cnd1 cnd from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
where exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
and a.formtransid='''||ptransid||''' 
union all
select a.axuserrole,case when viewctrl=''1'' then viewlist else null end view_includedflds,
case when viewctrl=''2'' then viewlist else null end view_excludedflds,case when editctrl=''1'' then editlist else null end edit_includedflds,
case when editctrl=''2'' then editlist else null end edit_excludedflds,
a.fieldmaskstr,b.cnd,viewctrl,allowcreate,editctrl,''User'' permissiontype 
from AxPermissions a 
left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||ptransid||'''';

v_permissionsql:=  'select count(cnt) from (select 1 cnt
from AxPermissions a 
--left join axuserpermissions b on a.axuserrole = b.axuserrole 
left join (
select a2.usergroup ,b.cnd1 cnd,a.axusersid from axusers a join axuserlevelgroups a2 on a2.axusersid = a.axusersid left join axusergrouping b on a.axusersid =b.axusersid  where a.username = '''||pusername||''')b on a.axuserrole=b.usergroup
left join axusers u on b.axusersid = u.axusersid  and u.username = '''||pusername||'''
where exists (select 1 from unnest(string_to_array('''||proles||''','','')) val where val in (a.axuserrole))
and a.formtransid='''||ptransid||''' 
union all
select 1 cnt
from AxPermissions a 
left join axuserdpermissions b on a.AxPermissionsid = b.AxPermissionsid 
where a.axusername = '''||pusername||''' and a.formtransid='''||ptransid||''')a';

end if;

execute v_permissionsql into  v_permissionexists;


if v_applypermissions > 0 then

select  case when length(cnd1)>2 then 1 else 0 end,cnd1 into v_dimensionsexists,v_usercondition from axusergrouping a 
	join axusers b on a.axusersid = b.axusersid 
	join axgrouptstructs a2 on a2.ftransid=ptransid
	where b.username  = fn_permissions_getcnd.pusername;


if pglobalvars !='NA' then

FOR rec_glovars IN
    SELECT unnest(string_to_array(pglobalvars,'~~')) glovars
LOOP

    rec_glovars_varname  := split_part(rec_glovars.glovars,'=',1);
    rec_glovars_varvalue := split_part(rec_glovars.glovars,'=',2);

   v_condition := concat('{primarytable.}',rec_glovars_varname,' in (',rec_glovars_varvalue,',''All'')');

        v_final_conditions := array_append(v_final_conditions,concat(' and ', v_condition));

END LOOP;

else 


v_condition :=  concat(' and ',v_usercondition);
v_final_conditions := case when  v_dimensionsexists = 1 then array_append(v_final_conditions, v_condition) end;

end if;

end if;



if v_menuaccess > 0 and v_permissionexists = 0 then  

v_fullcontrolsql  := concat('select ',v_transid_primetable,'id',' from ',v_transid_primetable,' ',v_keyfld_joins,' where ',replace(v_keyfld_cnd,' and ',''),replace(array_to_string(v_final_conditions,' '),'{primarytable.}',v_transid_primetable||'.'));
execute v_fullcontrolsql into v_fullcontrolrecid;
fullcontrol:= case when v_fullcontrolrecid > 0 then 'T' else 'F' end;
edit_access:= case when v_fullcontrolrecid > 0 then 'T' else 'None' end;
view_access:= case when v_fullcontrolrecid > 0 then 'T' else 'None' end;
recordid := v_fullcontrolrecid;
select string_agg(fname,',') into encryptedflds  from axpflds where tstruct=ptransid and encrypted='T';
filtercnd := case when pglobalvars !='NA' then array_to_string(v_final_conditions,' ') else v_usercondition end;
return next;

else

for rec in execute rolesql
loop

	sql_permission_cnd := concat('select count(*),',v_transid_primetable,'id',' from ',v_transid_primetable,' ',v_keyfld_joins,' where ',v_keyfld_cnd,case when length(array_to_string(v_final_conditions,' and ')) > 3 then concat(replace(array_to_string(v_final_conditions,' '),'{primarytable.}',v_transid_primetable||'.')) end,' group by ',v_transid_primetable,'id');

	execute sql_permission_cnd into sql_permission_cnd_result,v_recordid;

	
	
	if sql_permission_cnd_result > 0 then	
		userrole := rec.axuserrole;
		select string_agg(dname,',') into view_includedc  from axpdc where tstruct=ptransid and exists (select 1 from unnest(string_to_array(rec.view_includedflds,',')) val where val = dname);
		select string_agg(dname,',') into view_excludedc  from axpdc where tstruct=ptransid and exists (select 1 from unnest(string_to_array(rec.view_excludedflds,',')) val where val = dname);		 
		select string_agg(fname,',') into view_includeflds  from axpflds where tstruct=ptransid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.view_includedflds,',')) val where val = fname);
		select string_agg(fname,',') into view_excludeflds  from axpflds where tstruct=ptransid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.view_excludedflds,',')) val where val = fname);
		select string_agg(dname,',') into edit_includedc  from axpdc where tstruct=ptransid and exists (select 1 from unnest(string_to_array(rec.edit_includedflds,',')) val where val = dname);
		select string_agg(dname,',') into edit_excludedc  from axpdc where tstruct=ptransid and exists (select 1 from unnest(string_to_array(rec.edit_excludedflds,',')) val where val = dname);		 
		select string_agg(fname,',') into edit_includeflds  from axpflds where tstruct=ptransid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.edit_includedflds,',')) val where val = fname);
		select string_agg(fname,',') into edit_excludeflds  from axpflds where tstruct=ptransid and savevalue='T' and exists (select 1 from unnest(string_to_array( rec.edit_excludedflds,',')) val where val = fname);
		maskedflds := rec.fieldmaskstr;
		filtercnd := v_final_conditions;
		recordid :=v_recordid;
		view_access := case when rec.viewctrl='4' then 'None' else null end;
		edit_access := case when rec.editctrl='4' then 'None' else null end;	
		allowcreate := rec.allowcreate;
		view_includeflds := case when rec.viewctrl='0' then view_includeflds else concat(view_includeflds,',',edit_includeflds) end;		
		view_includedc :=case when rec.viewctrl='0' then view_includedc else  concat(view_includedc,',',edit_includedc) end;
		select string_agg(fname,',') into encryptedflds  from axpflds  where tstruct=ptransid and encrypted='T' and exists (select 1 from unnest(string_to_array(view_includeflds,',')) val where val = fname);		
		permissiontype := rec.permissiontype;
		return next;

	end if;



end loop;


end if;

return ;
	
END; 
$$;

CREATE FUNCTION {schema}.fn_permissions_getdcrecid(ptransid character varying, precordid numeric, pdcstring character varying) RETURNS TABLE(dcname character varying, rowno numeric, recordid numeric)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_rec record;
v_rec1 record;
v_sql text;
v_dcname varchar;
v_rowstring varchar;
v_dctable varchar;
v_primarydctable varchar;
begin


select tablename into v_primarydctable from axpdc where tstruct=ptransid and dname='dc1';

for v_rec in select unnest(string_to_array(pdcstring,'|')) str from dual
Loop
	v_dcname := split_part(v_rec.str,'~',1);
	v_rowstring := split_part(v_rec.str,'~',2);

	select tablename into v_dctable from axpdc where tstruct=ptransid and dname=v_dcname;

	if v_rowstring = '0' then 
		v_sql := 'select '''||v_dcname||''' dcname,'||v_rowstring||' rowno,'||v_dctable||'id recordid from '||v_dctable||' where '||v_primarydctable||'id::numeric='||precordid;
	else 
		v_sql := 'select '''||v_dcname||''' dcname,'||v_dctable||'row rowno,'||v_dctable||'id recordid from '||v_dctable||' where '||v_primarydctable||'id::numeric='||precordid||' and '||v_dctable||'row in(select unnest(string_to_array('''||v_rowstring||''','',''))::numeric)';
	end if;

		for v_rec1 in execute v_sql 
		Loop 		
			dcname :=v_rec1.dcname;
			rowno :=v_rec1.rowno;
			recordid :=v_rec1.recordid;		
			return next;
		end loop; 
	

		 		
end loop;

return;


	
END; 
$$;

CREATE FUNCTION {schema}.fn_permissions_getpermission(pmode character varying, ptransid character varying, pusername character varying, proles character varying DEFAULT 'All'::character varying, pglobalvars character varying DEFAULT 'NA'::character varying) RETURNS TABLE(transid character varying, fullcontrol character varying, userrole character varying, allowcreate character varying, view_access character varying, view_includedc character varying, view_excludedc character varying, view_includeflds character varying, view_excludeflds character varying, edit_access character varying, edit_includedc character varying, edit_excludedc character varying, edit_includeflds character varying, edit_excludeflds character varying, maskedflds character varying, filtercnd text, encryptedflds character varying, permissiontype character varying, viewctrl character varying, editctrl character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
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
	where b.username  = fn_permissions_getpermission.pusername;


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
		select string_agg(dname,',') into view_includedc  from axpdc where tstruct=rec_transid.transid and exists (select 1 from unnest(string_to_array( rec.view_includedflds,',')) val where val = dname);
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
$$;

CREATE FUNCTION {schema}.fn_permissions_getsqls(pmode character varying, ptransid character varying, pkeyfld character varying, pkeyvalue character varying, pcond text, pincdc character varying, pexcdc character varying, pincflds text, pexcflds text) RETURNS TABLE(dcno character varying, dcsql text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
rec record;
rec1 record;
rec2 record;
--rolesql text;
v_transid_primetable varchar(100);
v_transid_primetableid varchar(100);
v_keyfld_normalized varchar(1);
v_keyfld_srctbl varchar(100);
v_keyfld_srcfld varchar(100);
v_keyfld_mandatory varchar(1);
v_keyfld_joins varchar(500);
v_keyfld_cnd varchar(500);
v_primarydctable varchar;
v_allflds text;
v_fldname_dctablename varchar;
v_fldname_dcflds text;
v_fldname_dcjoinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_dctables varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_col varchar;
v_fldname_normalized varchar;
v_fldname_srctbl varchar;
v_fldname_srcfld varchar;
v_fldname_allowempty varchar;
v_fldnamesary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_joinsary varchar[] DEFAULT  ARRAY[]::varchar[];
v_fldname_normalizedtables varchar[] DEFAULT  ARRAY[]::varchar[];
v_sql text;
v_onlydcselect numeric;
v_emptyary varchar[] DEFAULT  ARRAY[]::varchar[];
v_alldcs varchar;
begin

select tablename into v_primarydctable from axpdc where tstruct = ptransid and dname ='dc1';

select srckey,srctf,srcfld,allowempty into v_keyfld_normalized,v_keyfld_srctbl,v_keyfld_srcfld,v_keyfld_mandatory
from axpflds where tstruct = ptransid and fname = pkeyfld;

select tablename into v_transid_primetable from axpdc where tstruct=ptransid and dname='dc1';

v_transid_primetableid := case when lower(pkeyfld)='recordid' then v_transid_primetable||'id' else pkeyfld end;

v_keyfld_cnd := case when v_keyfld_normalized='T' then v_keyfld_srctbl||'.'||v_keyfld_srcfld else  v_transid_primetable||'.'||v_transid_primetableid end ||'='||pkeyvalue;

if v_keyfld_normalized='T' then 
	v_keyfld_joins := case when v_keyfld_mandatory='T' then ' join ' else ' left join ' end
					  ||v_keyfld_srctbl||' '||pkeyfld||' on '||v_transid_primetable||'.'||pkeyfld||'='||v_keyfld_srctbl||'.'||v_keyfld_srctbl||'id';		
	
end if;



	if pincdc is null then 	
		select string_agg(dname,',') into v_alldcs from axpdc where tstruct = ptransid
		and not exists(select 1 from unnest(string_to_array( pexcdc,',')) val where val = dname);	
	else		
		with a as(select unnest(string_to_array('dc1,dc2,dc3',','))  fname from dual)
		select fname into v_alldcs  from a where not exists(select 1 from unnest(string_to_array(pexcdc,',')) val where val = a.fname);
	end if;



for rec in select unnest(string_to_array(v_alldcs,',')) dcname 
loop

	select count(1) into v_onlydcselect
	from axpflds where tstruct= ptransid and dcname=rec.dcname and savevalue='T' 
	and exists (select 1 from unnest(string_to_array( pincflds,',')) val where val = fname);

	if v_onlydcselect > 0 then
		select concat(tablename,'=',string_agg(str,'|'))  into v_allflds From(
		select tablename, concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str
		from axpflds where tstruct=ptransid and dcname=rec.dcname and savevalue='T' 
		and exists (select 1 from unnest(string_to_array( pincflds,',')) val where val = fname)
		and not exists(select 1 from unnest(string_to_array( pexcflds,',')) val where val = fname) 		
		order by dcname ,ordno)a group by a.tablename;
	else
		select concat(tablename,'=',string_agg(str,'|'))  into v_allflds From(
		select tablename, concat(fname,'~',srckey,'~',srctf,'~',srcfld,'~',allowempty) str
		from axpflds where tstruct=ptransid and dcname=rec.dcname and savevalue='T' 
		and not exists(select 1 from unnest(string_to_array( pexcflds,',')) val where val = fname) 		
		order by dcname ,ordno)a group by a.tablename;
	end if; 
	
	FOR rec1 IN
    		select unnest(string_to_array(v_allflds,'^')) dcdtls
    		loop	
    			v_fldname_dctablename := split_part(rec1.dcdtls,'=',1);
				v_fldname_dcflds := split_part(rec1.dcdtls,'=',2);
			
			if v_fldname_dctablename!=v_primarydctable then
						v_fldname_dcjoinsary := array_append(v_fldname_dcjoinsary,concat('left join ',v_fldname_dctablename,' on ',v_primarydctable,'.',v_primarydctable,'id=',v_fldname_dctablename,'.',v_primarydctable,'id') );						
					end if;
					v_fldname_dctables := array_append(v_fldname_dctables,v_fldname_dctablename);

			FOR rec2 IN
    		select unnest(string_to_array(v_fldname_dcflds,'|')) fldname    		    	       			
				loop		    	
					v_fldname_col := split_part(rec2.fldname,'~',1);
					v_fldname_normalized := split_part(rec2.fldname,'~',2);
					v_fldname_srctbl := split_part(rec2.fldname,'~',3);
					v_fldname_srcfld := split_part(rec2.fldname,'~',4);	
					v_fldname_allowempty := split_part(rec2.fldname,'~',5);
			    
				
					
					if v_fldname_normalized ='F' then 
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_dctablename,'.',v_fldname_col)::varchar);
					elsif v_fldname_normalized ='T' then	
						v_fldnamesary := array_append(v_fldnamesary,concat(v_fldname_col,'.',v_fldname_srcfld,' ',v_fldname_col)::varchar);	
						v_fldname_joinsary := array_append(v_fldname_joinsary,concat(case when v_fldname_allowempty='F' then ' join ' else ' left join ' end,v_fldname_srctbl,' ',v_fldname_col,' on ',v_fldname_dctablename,'.',v_fldname_col,' = ',v_fldname_col,'.',v_fldname_srctbl,'id')::Varchar);
						v_fldname_normalizedtables := array_append(v_fldname_normalizedtables,lower(v_fldname_srctbl));
					end if;
								
			    end loop;
		   
			   end loop;
		   	v_sql := concat(' select ',v_primarydctable,'.',v_primarydctable,'id recordid,',array_to_string(v_fldnamesary,','),' from ',v_primarydctable,' ',
		   			 array_to_string(v_fldname_dcjoinsary,' '),' ',array_to_string(v_fldname_joinsary,' '),' where ',v_keyfld_cnd);--,' and ',pcond);


			dcno := rec.dcname;
			dcsql := v_sql;
			return next;
			v_fldnamesary:= v_emptyary;
		   				v_fldname_joinsary:= v_emptyary;	   				
		   				v_fldname_dcjoinsary:= v_emptyary;	

end loop; 

 
return;
	
END; 
$$;

CREATE FUNCTION {schema}.fn_permissions_grpmaster(pgrpname character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
    v_altersql text; 
    r record;
BEGIN
    FOR r IN SELECT a.ftransid, d.tablename 
             FROM axgrouptstructs a 
             JOIN axpdc d ON a.ftransid = d.tstruct AND d.dcno = 1 
    LOOP 
        BEGIN
            v_altersql := 'ALTER TABLE ' || r.tablename || ' ADD axg_' || pgrpname || ' varchar(4000) default ''All''';
            EXECUTE v_altersql;
        EXCEPTION WHEN OTHERS THEN
            null;
        END;
    END LOOP;
 
    RETURN 'T';
END;
$$;

CREATE FUNCTION {schema}.fn_ruledef_formula(formula text, applicability character varying, nexttask character varying, nexttask_true character varying, nexttask_false character varying, pegversion character varying DEFAULT 'v1'::character varying) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
    v_formula text;

begin

if pegversion = 'v1' then
-----Used in Rule definition conditions
with a as(
select
	regexp_split_to_table(formula, E'~') cols),
b as(select 	string_agg(case when split_part( cols, '|', 2) not in('In','Not in') then  substring(substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))),2) else '' end||' '||
	case when split_part( cols, '|', 2)='Equal to' then '='
	when split_part( cols, '|', 2)='Not equal to' then '#'
	when split_part( cols, '|', 2)='Greater than' then '>'
	when split_part( cols, '|', 2)='Lesser than' then '<' 
	when split_part( cols, '|', 2) in('In','Not in') then 'StringPOS('||substring(substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))),2)||','
	end||' '||
	case when substring(substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))),1,1) in('c','t')
	then case when substring(trim(split_part( cols, '|', 3)),1,1)!=':' then concat('{',split_part( cols, '|', 3),'}') else replace(split_part( cols, '|', 3),':',' ') end 
	else case when substring(trim(split_part( cols, '|', 3)),1,1)!=':' then split_part( cols, '|', 3) else replace(split_part( cols, '|', 3),':',' ') end  end ||
	case when split_part( cols, '|', 2)='In' then ') # -1' when split_part( cols, '|', 2)='Not in' then ') = -1' else '' end||' '||
	case when split_part( cols, '|', 4)='And' then '&'
	when split_part( cols, '|', 4)='Or' then '|' 
	when split_part( cols, '|', 4)='And(' then '&('
	when split_part( cols, '|', 4)='Or(' then '|('
	else split_part( cols, '|', 4) end ,' ') cndtxt from a)
	select 
case when applicability ='T' then 'iif('||cndtxt||',{T},{F})' 
when nexttask='T' then 'iif('||cndtxt||',{'||nexttask_true||'},'||'{'||nexttask_false||'})'
else cndtxt end  into v_formula from b;

-----Used for PEG condition based on task params

elseif pegversion = 'v2' then

with a as(
select
	regexp_split_to_table(formula, E'~') cols),
b as(select 	string_agg(case when split_part( cols, '|', 2) not in('In','Not in') then  substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))) else '' end||' '||
	case when split_part( cols, '|', 2)='Equal to' then '='
	when split_part( cols, '|', 2)='Not equal to' then '#'
	when split_part( cols, '|', 2)='Greater than' then '>'
	when split_part( cols, '|', 2)='Lesser than' then '<' 
	when split_part( cols, '|', 2) in('In','Not in') then 'StringPOS('||substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1))))))||','
	end||' '||
	case when substring(substring(substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))),position('.' in substring(split_part(cols, '|', 1), position('-(' in split_part(cols, '|', 1))+ 2, abs((position('-(' in split_part(cols, '|', 1) )+ 2) - length(substring(split_part(cols, '|', 1), 1, length(split_part(cols, '|', 1)))))))+1),1,1) in('c','t')
	then concat('{',split_part( cols, '|', 3),'}') else split_part( cols, '|', 3) end||
	case when split_part( cols, '|', 2)='In' then ') # -1' when split_part( cols, '|', 2)='Not in' then ') = -1' else '' end ||' '||
	case when split_part( cols, '|', 4)='And' then '&'
	when split_part( cols, '|', 4)='Or' then '|'
	when split_part( cols, '|', 4)='And(' then '&('
	when split_part( cols, '|', 4)='Or(' then '|('	
	else split_part( cols, '|', 4) end,' ') cndtxt
	 from a)
	select 'iif('||cndtxt||',{T},{F})' into v_formula from b;

end if;

return v_formula;
end;

$$;

CREATE FUNCTION {schema}.fn_ruledef_table_genaxscript(pcmd character varying, ptbldtls character varying, pcnd numeric) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
    v_formula varchar(2000);

   BEGIN

if pcnd=1 then 	   

	select concat(pcmd,' ',
	string_agg(case when split_part( fname, '|', 2) not in('In','Not in') then  substring(substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),2) else '' end||' '||
	case  when split_part(fname, '|', 2)='Equal to' then ' = ' 
	when split_part(fname, '|', 2)='Not equal to' then ' # ' 
	when split_part(fname, '|', 2)='Greater than' then ' > ' 
	when split_part(fname, '|', 2)='Lesser than' then ' < ' 
	when split_part( fname, '|', 2) in('In','Not in') then 'StringPOS('||substring(substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),2)||','
	end ||' '||
	case when substring(substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),1,1) in('c','t')
	then concat('{',split_part( fname, '|', 3),'}') else split_part( fname, '|', 3) end ||
	case when split_part( fname, '|', 2)='In' then ') # -1' when split_part( fname, '|', 2)='Not in' then ') = -1' else '' end 	
	||' '||
	case split_part(fname, '|', 4) when 'And' then ' & ' when 'Or' then ' | ' when 'And(' then ' & (' when 'Or(' then ' | (' else split_part(fname, '|', 4) end,'')) into v_formula 
	from(select unnest(string_to_array( ptbldtls, '~')) fname)a ;
	/*select concat(pcmd,' ',string_agg(concat(substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),
	case split_part(fname, '|', 2)
	when 'Equal to' then ' = ' 
	when 'Not equal to' then ' # ' 
	when 'Greater than' then ' > ' 
	when 'Lesser than' then ' < ' end,
	split_part(fname, '|', 3),
	case split_part(fname, '|', 4) when 'And' then ' & ' when 'Or' then ' | ' when 'And(' then ' & (' when 'Or(' then ' | (' else split_part(fname, '|', 4) end),'')) into v_formula
	from(select unnest(string_to_array( ptbldtls, '~')) fname)a;*/

elseif pcnd =2 then 
	select case when pcmd ='Show' then concat('Axunhidecontrols({', fnames ,'})') 
	when pcmd ='Hide' then concat('Axhidecontrols({', fnames ,'})')
	when pcmd ='Enable' then concat('Axenablecontrols({', fnames ,'})')
	when pcmd ='Disable' then concat('Axdisablecontrols({', fnames ,'})')
	when pcmd ='Mandatory' then concat('AxAllowEmpty({', fnames ,'},{F})')
	when pcmd ='Non mandatory' then concat('AxAllowEmpty({', fnames ,'},{T})') end  into v_formula from 
	(select string_agg(substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),',') fnames
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a)b;

elseif pcnd in(3,31) then 
	select case when pcmd='Mask few characters' then concat('AxMask({',substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),'}',
	',{',split_part(fname, '|', 2),'},{',
	split_part(fname, '|', 3),'~',
	split_part(fname, '|', 4),'})') 
	when pcmd ='Mask all characters' then concat('AxMask({',substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),
	'},{',split_part(fname, '|', 2),'},{all})') 
	end  into v_formula
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a;

elseif pcnd=4 then

	select string_agg(concat('SetValue({',substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),
	'},1,{',split_part(fname, '|', 2),'})'),chr(10)) into v_formula
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a;
	
	/* 
	 select concat('SetValue({',substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),
	'},1,{',split_part(fname, '|', 2),'})') into v_formula
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a;*/

elseif pcnd=5 then  
	select case when pcmd='Show message' then concat('ShowMessage({',split_part(fname, '|', 1),'},{Simple},{})')
	when pcmd='Show error' then concat('ShowMessage({',split_part(fname, '|', 1),'},{Exception},{})') end  into v_formula
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a;

elseif pcnd=6 then 
	v_formula := pcmd;

------------used in PEG for Set value
elseif pcnd=7 then 
	select string_agg(concat('SetValue({',substring(split_part(fname, '|', 1), position('-(' in split_part(fname, '|', 1))+ 2, abs((position('-(' in split_part(fname, '|', 1) )+ 2) - length(substring(split_part(fname, '|', 1), 1, length(split_part(fname, '|', 1)))))),
	'},1,{',split_part(fname, '|', 2),'})'),chr(10)) into v_formula
	from(select unnest(string_to_array(ptbldtls, '~')) fname )a;

end if;
	
RETURN v_formula;
END;
$$;

CREATE FUNCTION {schema}.fn_ruledef_tablefield(pcnd numeric) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_json varchar;

BEGIN  

/*
1	If,Else if
2	Enable,Show,Hide,Disable,Mandatory,Non mandatory
3	Mask all characters,Mask few characters
4	Set value to field
5	Show message,Show error
6	Else
*/
	
if pcnd = 1 then --If , Else if 	 

select '{"props":{"type":"table","colcount":"4","rowcount":"1","addrow":"t","deleterow":"t","valueseparator":"|","rowseparator":"~"},"columns":{	"1":{"caption":"Condition field","name":"cfld","value":"","source":"cndfldcaption","exp":"","vexp":""},"2":{"caption":"Operator","name":"opr","value":"","source":"formula_opr","exp":"","vexp":""},"3":{"caption":"Value","name":"fldvalue","value":"","source":"","exp":"","vexp":""},"4":{"caption":"Condition","name":"ccnd","value":"","source":"formula_andor","exp":"","vexp":""}}}'  into v_json;
		
		
 
elseif pcnd = 2 then  --Enable,Disable,Show,Hide,Mandatory,Non mandatory

select '{"props":{"type":"table","colcount":"1","rowcount":"1","addrow":"t","deleterow":"t","valueseparator":"|","rowseparator":"~"},"columns":{"1":{"caption":"Apply rule on","name":"cndfld","value":"","source":"fctlfldcaption","exp":"","vexp":""}}}' into v_json;

elseif pcnd = 4 then --Set value to field

select '{"props":{"type":"table","colcount":"2","rowcount":"1","addrow":"t","deleterow":"t","valueseparator":"|","rowseparator":"~"},"columns":{"1":{"caption":"Set value to field","name":"cndfld","value":"","source":"setvalueflds","exp":"","vexp":""},"2":{"caption":"Value","name":"sval","value":"","source":"","exp":"","vexp":""}}}'  into v_json;

elseif pcnd=5 then -- Show message,Show error

select '{"props":{"type":"table","colcount":"1","rowcount":"1","addrow":"f","deleterow":"f","valueseparator":"|","rowseparator":"~"},"columns":{"1":{"caption":"Message",	"name":"cndfld","value":"","source":"","exp":"","vexp":""}}}'  into v_json;

end if;

  RETURN v_json;
 
END;
$$;

CREATE FUNCTION {schema}.fn_ruledefv3_masking(pmaskstring text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
v_maskstring varchar;
v_maskstringary text[] DEFAULT  ARRAY[]::text[];
v_maskfldcap varchar;
v_maskfldname varchar;
v_masktype varchar;
v_maskchar varchar;
v_maskfirstnchar varchar;
v_masklastnchar varchar;
rec record;
begin

for rec in select unnest(string_to_array(pmaskstring, '~')) maskstr
loop
	v_maskfldcap := split_part(rec.maskstr,'|',1);	
	v_maskfldname := substring(unnest(string_to_array( v_maskfldcap , ',')), position('-(' in unnest(string_to_array( v_maskfldcap , ',')))+ 2, abs((position('-(' in unnest(string_to_array( v_maskfldcap , ',')))+ 2) - length(substring(unnest(string_to_array( v_maskfldcap , ',')), 1, length(unnest(string_to_array( v_maskfldcap , ',')))))));	
	v_masktype := split_part(rec.maskstr,'|',2);
	v_maskchar := split_part(rec.maskstr,'|',3);
	v_maskfirstnchar := split_part(rec.maskstr,'|',4);
	v_masklastnchar := split_part(rec.maskstr,'|',5);

	v_maskstring := case when v_masktype ='Mask few characters' 
					then  concat('AxMask({',v_maskfldname,'},{',v_maskchar,'},{',v_maskfirstnchar,'~',v_masklastnchar,'})')
					else concat('AxMask({',v_maskfldname,'},{',v_maskchar,'},{all})') end;

	v_maskstringary := array_append(v_maskstringary,v_maskstring);
	
end loop;
	
return array_to_string(v_maskstringary,chr(10)) ;
	
end;
$$;

CREATE FUNCTION {schema}.fn_ruledefv3_scriptgen(pcmd character varying, pfldstring text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_fldnames text;
BEGIN  

  select string_agg(fname, ',') into v_fldnames from (select	substring(unnest(string_to_array( pfldstring , ',')), position('-(' in unnest(string_to_array( pfldstring , ',')))+ 2, abs((position('-(' in unnest(string_to_array( pfldstring , ',')))+ 2) - length(substring(unnest(string_to_array( pfldstring , ',')), 1, length(unnest(string_to_array( pfldstring , ',')))))))fname where pfldstring is not null) a;

if pcmd='Mandatory' then  
return concat('AxAllowEmpty({', v_fldnames,'},{F})');
elsif pcmd='NonMandatory' then
return concat('AxAllowEmpty({', v_fldnames,'},{T})');
else
return concat(pcmd,'({', v_fldnames,'})');
end if;
 
END;
$$;

CREATE FUNCTION {schema}.fn_tconfiguration() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
	v_cnt numeric(2);

v_sql varchar(4000);

begin 
	

if (TG_OP = 'INSERT') then

select coalesce(count(table_name), 0) into v_cnt
from information_schema.tables
where lower(table_name) = lower( 'axpconfigs' || chr(95)|| new.structtransid )
and lower(table_schema)= current_schema();

if v_cnt = 0 then 
v_sql := 'create table axpconfigs' || chr(95)|| new.structtransid || ' ( configname varchar(30),cvalue varchar(2000),condition varchar(240))' ;

execute v_sql;
end if;

if new.cv_searchflds is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname1 || ''',''' || new.cv_searchflds || ''',null)';
execute v_sql;
end if;

if new.cv_groupbuttons is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname2 || ''',''' || new.cv_groupbuttons || ''',null)';
execute v_sql;
end if;

if new.cv_htmlprints is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname3 || ''',''' || new.cv_htmlprints || ''',null)';
execute v_sql;
end if;

if new.cv_masterflds is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname4 || ''',''' || new.cv_masterflds || ''',null)';
execute v_sql;
end if;

return new;

end if;

if (TG_OP = 'UPDATE') then 

v_sql = 'delete from axpconfigs' || chr(95)|| old.structtransid;
execute v_sql;

if new.cv_searchflds is not null then
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname1 || ''',''' || new.cv_searchflds || ''',null)';
execute v_sql;
end if;

if new.cv_groupbuttons is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname2 || ''',''' || new.cv_groupbuttons || ''',null)';
execute v_sql;
end if;

if new.cv_htmlprints is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname3 || ''',''' || new.cv_htmlprints || ''',null)';
execute v_sql;
end if;

if new.cv_masterflds is not null then 
v_sql = 'insert into axpconfigs' || chr(95)|| new.structtransid || ' ( configname,cvalue,condition ) values (''' || new.configname4 || ''',''' || new.cv_masterflds || ''',null)';
execute v_sql;
end if;


return new;

end if;

if (TG_OP = 'DELETE') then 
v_sql = 'delete from axpconfigs' || chr(95)|| old.structtransid;
execute v_sql;
v_cnt = 2 ;

return new;

end if;



end;

$$;

CREATE FUNCTION {schema}.fn_tstruct_getdcrecid(ptransid character varying, precordid numeric, pdcstring character varying) RETURNS TABLE(dcname character varying, rowno numeric, recordid numeric)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_rec record;
v_rec1 record;
v_sql text;
v_dcname varchar;
v_rowstring varchar;
v_dctable varchar;
v_isgrid varchar;
v_primarydctable varchar;
begin


select tablename into v_primarydctable from axpdc where tstruct=ptransid and dname='dc1';

for v_rec in select unnest(string_to_array(pdcstring,',')) str from dual
Loop
	v_dcname := v_rec.str;
	

	select tablename,asgrid into v_dctable,v_isgrid from axpdc where tstruct=ptransid and dname=v_dcname;

	if v_isgrid = 'F' then 

		v_sql := 'select '''||v_dcname||''' dcname,0 rowno,'||v_dctable||'id recordid from '||v_dctable||' where '||v_primarydctable||'id::numeric='||precordid;
	else 
		v_sql := 'select '''||v_dcname||''' dcname,'||v_dctable||'row rowno,'||v_dctable||'id recordid from '||v_dctable||' where '||v_primarydctable||'id::numeric='||precordid;
	end if;

		for v_rec1 in execute v_sql 
		Loop 		
			dcname :=v_rec1.dcname;
			rowno :=v_rec1.rowno;
			recordid :=v_rec1.recordid;		
			return next;
		end loop; 
	

		 		
end loop;

return;


	
END; 
$$;

CREATE FUNCTION {schema}.fn_updatdsign() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
	BEGIN

        -- Work out the increment/decrement amount(s).
        IF (TG_OP = 'INSERT') THEN 
		
		NEW.USERNAME = NEW.PUSERNAME; 
		new.rolename = new.prolename;
		
		return new;
	end if;
		
	IF (TG_OP = 'UPDATE') THEN 
		
		NEW.USERNAME = NEW.PUSERNAME; 
		new.rolename = new.prolename;
		
		return new;
	end if;
		
end; 
$$;

CREATE FUNCTION {schema}.fn_upsert_config_by_condition(p_tablename text, p_fieldnames text, p_fieldvalues text, p_where_clause text) RETURNS TABLE(status text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
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
$$;

CREATE FUNCTION {schema}.fn_utl_forms_dateconversion(pupdatedon character varying) RETURNS timestamp without time zone
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
        CASE 
        WHEN pupdatedon ~ '^\d{1,2}-\d{1,2}-\d{4}\s\d{2}:\d{2}:\d{2}$' THEN 
            RETURN TO_TIMESTAMP(pupdatedon, 'DD-MM-YYYY HH24:MI:SS');
        WHEN pupdatedon ~ '^\d{1,2}/\d{1,2}/\d{4}\s\d{2}:\d{2}:\d{2}$' THEN 
            RETURN TO_TIMESTAMP(pupdatedon, 'DD/MM/YYYY HH24:MI:SS');
        ELSE 
            RETURN NULL;
    END CASE;
END;
$_$;

CREATE FUNCTION {schema}.get_ads_dropdown_data(p_tablename text, p_fieldname text) RETURNS TABLE(displaydata text, name text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
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

CREATE FUNCTION {schema}.get_columns_name(p_selectquery character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare 
    l_result  varchar(32767);
begin
	drop table temp_testtable ;
	execute 'Create table temp_testtable as '|| p_selectQuery;
	
	SELECT string_agg(COLUMN_NAME,',') into l_result FROM information_schema.COLUMNS WHERE TABLE_NAME = 'temp_testtable';
	   
    return  l_result;
end; $$;

CREATE FUNCTION {schema}.get_columns_names(p_selectquery character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare 
    l_result  varchar(32767);
begin
	drop table temp_testtable ;
	execute 'Create table temp_testtable as '|| p_selectQuery;
	
	SELECT string_agg(COLUMN_NAME,',') into l_result FROM information_schema.COLUMNS 
	WHERE TABLE_NAME = 'temp_testtable';
	   
    return  l_result;
end; $$;

CREATE FUNCTION {schema}.get_dynamic_field(p_tstruct text, p_fieldname text) RETURNS TABLE(displaydata text, id text)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
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
$$;

CREATE FUNCTION {schema}.get_sql_columns(sql_query text) RETURNS text
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
    column_names text;
    formatted_query text;
    param_names text[];
    i integer;
BEGIN
    -- Extract parameter names from the query
    select array_agg(cols) INTO param_names from (SELECT unnest(regexp_matches(sql_query, ':\w+', 'g'))cols)a;

    -- Replace parameter placeholders with NULL values if there are any parameters
    IF array_length(param_names, 1) > 0 THEN
        formatted_query := sql_query;
        FOR i IN 1..array_length(param_names, 1) LOOP
            formatted_query := replace(formatted_query, param_names[i], 'NULL');
        END LOOP;
    ELSE
        formatted_query := sql_query;
    END IF;
	
	

   EXECUTE format('CREATE TEMPORARY TABLE Ax_GetColumn_temp_table AS (%s) LIMIT 0', formatted_query);
   
    column_names := array_to_string(
        ARRAY(
            SELECT attname
            FROM pg_attribute
            WHERE attrelid = 'Ax_GetColumn_temp_table'::regclass
                AND attnum > 0
                AND NOT attisdropped
            ORDER BY attnum
        ),
        ','
    );

    -- Drop the temporary table
    EXECUTE 'DROP TABLE IF EXISTS Ax_GetColumn_temp_table';

    RETURN column_names;

END; 
$$;

CREATE FUNCTION {schema}.getiview(isql character varying, inoofrec numeric, ipageno numeric, icountflag numeric, oresult refcursor, oiviewcount refcursor) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
  v_frompos numeric;
 QRY VARCHAR(31000); 
 cnt numeric; 
    BEGIN     
    QRY := ISql; 
 cnt := 0; 
 IF (ICountFlag = 1 AND IPageNo = 1) THEN QRY := 'select count(*) recno from ('|| QRY ||')a';
  EXECUTE  QRY INTO cnt; 
  End If; 
  open OIviewCount for execute 'select '||to_char(cnt)||' as IviewCount from dual';
   QRY := ISql; 
   IF (INoofRec > 0 AND IPageNo > 0) THEN QRY:= 'select a.* from (select row_number()over() AS Rowno, '''' as axrowtype, a.* from (' || QRY||') a )a where a.Rowno > ' || cast( INoofRec * (IpageNo-1.00) as varchar ) || ' and ' || cast( INoofRec * (IpageNo) as varchar)|| ' >= a.Rowno'; 
   else QRY:='select row_number()over() AS Rowno, '''' as axrowtype, a.* from (' || QRY||') a '; 
   END IF; 
   open OResult for execute QRY; 
  exception when others then null;
    END;
$$;

CREATE FUNCTION {schema}.is_number(p_value character varying) RETURNS numeric
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
Declare 
v_num NUMERIC;
BEGIN
v_num:=cast(p_value as numeric);
RETURN 1;
EXCEPTION
WHEN OTHERS THEN
RETURN 0;
END; $$;

CREATE FUNCTION {schema}.join_comma(p_cursor refcursor, p_del character varying DEFAULT ','::character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
    l_value   varchar(32767);
    l_result  varchar(32767);
begin
    loop
        fetch p_cursor into l_value;
        exit when p_cursor%notfound;
        if l_result is not null then
            l_result := l_result || p_del;
        end if;
        l_result := l_result || l_value;
    end loop;
    return l_result;
end;
$$;

CREATE FUNCTION {schema}.populate_axdirectsql_metadata() RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
    r RECORD;
    cols TEXT;
    col TEXT;
    row_no INT;
BEGIN
    FOR r IN
        SELECT axdirectsqlid, sqltext
        FROM axdirectsql
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
            INSERT INTO axdirectsql_metadata (
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
                    '2' || lpad(nextval('axdirectsql_metadata_seq')::text, 14, '0')
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

CREATE FUNCTION {schema}.pr_axcnfg_tab_create(structtransid character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
v_cnt numeric(2) ;
v_sql varchar(4000);
begin
      select COALESCE(count(table_name),0) into v_cnt from information_schema.tables where lower(table_name) = lower( 'axpconfigs'||chr(95)||structtransid );
      if v_cnt = 0
      then
      v_sql := 'create table axpconfigs'||chr(95)||structtransid||' ( configname varchar(30),cvalue varchar(2000),condition varchar(240))' ;
        execute v_sql;

        end if;
end;
$$;

CREATE FUNCTION {schema}.pr_axcnfgiv_tab_create(structtransid character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
v_cnt numeric(2) ;
v_sql varchar(4000);
begin
      select COALESCE(count(table_name),0) into v_cnt from information_schema.tables where lower(table_name) = lower( 'axpconfigsiv'||chr(95)||structtransid );
      if v_cnt = 0
      then
        v_sql := 'create table axpconfigsiv'||chr(95)||structtransid||' ( configname varchar(30),cvalue varchar(240),condition varchar(240))' ;
        execute  v_sql;

      end if;
end;
$$;

CREATE FUNCTION {schema}.pr_bulk_page_delete() RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ 
declare 
i varchar(3000);
begin
for i in (Select name from axpages where pagetype='web' and blobno=1) 
loop
begin
execute axp_pr_page_creation( i.name,null,null,null,'delete',null);
exception when others then
null;
end ;
end loop;
end; $$;

CREATE FUNCTION {schema}.pr_bulkexecute(pintext character varying, pintrg character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
Declare 
v_rowcount numeric(15) :=0;
v_trgdis varchar(500)  := 'ALTER TRIGGER '||pintrg||'  DISABLE';
v_trgena varchar(500) := 'ALTER TRIGGER '||pintrg||'  ENABLE';
begin

if pintrg = 'NA' then
  EXECUTE  pintext;
else
  EXECUTE v_trgdis;
  EXECUTE pintext;
  EXECUTE v_trgena;
end if;

end; $$;

CREATE FUNCTION {schema}.pr_executescript_new(ptablename character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ declare 	sqlstmt refcursor; rec record; temp1 varchar(1000); begin truncate table axonlineconvlog; open sqlstmt for execute 'SELECT case when substring(lower(psqlquery),1,1) in (''i'',''u'',''d'')  then psqlquery else substring(psqlquery,2,length(psqlquery)) end as psqlquery  FROM ' || ptablename; fetch next from sqlstmt into rec; while found loop begin execute rec.psqlquery; exception when others then insert into axonlineconvlog(script,tablename,errmsg ) values(rec.psqlquery,ptablename,SQLERRM); end; fetch next from sqlstmt into rec; end loop; close sqlstmt; temp1 := 'drop table ' || ptablename; execute temp1; end; $$;

CREATE FUNCTION {schema}.pr_executescript_thread_new(ptablename character varying, pfieldname character varying, pgroupfield character varying, pthread numeric) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$ declare sqlstmt  varchar(4000); createtblstmt  varchar(4000); createindexstmt varchar(4000); BEGIN createtblstmt := 'create temp table '||ptablename||'_t on commit drop  as select  b1.'||pgroupfield||',mod(rank()over(order by b1.'||pgroupfield||'),'||pthread||')  as '||pfieldname||' from (select '||pgroupfield||' from '||ptablename||' group by '||pgroupfield||' ) b1'; createindexstmt := 'create index i_'||ptablename||' on '||ptablename||'_t ('||pgroupfield||')'; sqlstmt := ' update '||ptablename||' a set '||pfieldname||'= ( select b.'||pfieldname||' from '||ptablename||'_t b where b.'||pgroupfield||'=a.'||pgroupfield||') where exists (select  1 from  '||ptablename||'_t b where  b.'||pgroupfield||'=a.'||pgroupfield||') ';  execute createtblstmt; execute createindexstmt; execute sqlstmt  ; end; $$;

CREATE FUNCTION {schema}.pr_homeconfig_pagelist(ppageid character varying) RETURNS TABLE(pcaption character varying, pname character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
begin

return  query
WITH RECURSIVE cte AS (
   SELECT name, caption, 1 AS level,pagetype,caption a,name b
   FROM   axpages
--WHERE   length(parent)=0 
   UNION  ALL
   SELECT t.name, t.caption, c.level + 1,t.pagetype,c.a,c.b
   FROM   cte    c
   JOIN   axpages t ON t.parent = c.name    
   )
   select a,b from (
SELECT a,b,row_number() over (order by level desc) rnum
FROM   cte where name=ppageid
ORDER  BY level)a where rnum=1;	
END; $$;

CREATE FUNCTION {schema}.pr_pegv2_processlist(pprocessname character varying) RETURNS TABLE(taskname character varying, tasktype character varying, tasktime character varying, taskfromuser character varying, taskstatus character varying, displayicon character varying, displaytitle text, taskid character varying, keyfield character varying, keyvalue character varying, recordid numeric, transid character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_createtblscr varchar(4000);
v_processtable varchar(100);

begin
	
	select processtable into v_processtable from axpdef_peg_processmaster where lower(caption) = lower(pprocessname);
	
	v_createtblscr :='select taskname,tasktype,cast(to_char(to_timestamp(eventdatetime, ''YYYYMMDDHH24MISSSSS''),''dd/mm/yyyy hh24:mi:ss'')as varchar) eventdatetime,username,taskstatus,displayicon,displaytitle,taskid,keyfield,keyvalue,recordid,transid from '|| v_processtable;
	
    RETURN QUERY    execute v_createtblscr;
END; $$;

CREATE FUNCTION {schema}.pr_pegv2_processprogress(pprocessname character varying, pkeyvalue character varying) RETURNS TABLE(processname character varying, taskname character varying, indexno numeric, eventdatetime character varying, taskstatus character varying, taskid character varying, transid character varying, keyfield character varying, keyvalue character varying, recordid numeric, rnum numeric)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_createtblscr varchar(4000);
v_processtable varchar(100);
v_keyvalue varchar(2000);

begin
    
    select processtable into v_processtable from axpdef_peg_processmaster where lower(caption) = lower(pprocessname);
   
   
   v_createtblscr :=concat('with c as (select distinct a.processname,a.taskname,a.indexno,
    a.eventdatetime,
    coalesce(b.taskstatus, ''active'')taskstatus,a.taskid,
    a.transid,a.keyfield,a.keyvalue,a.recordid from ', v_processtable ,' a 
    join(select processname,taskname,indexno,transid,keyvalue,taskstatus,
    eventdatetime from axactivetaskstatus
    where lower(processname) ='''||lower(pprocessname)||    ''' and lower(keyvalue) = ''',lower(pkeyvalue),''' )b 
    on a.taskname = b.taskname and a.indexno = b.indexno 
    and a.eventdatetime =  b.eventdatetime    
     where lower(a.processname) ='''||lower(pprocessname)||
    ''' and lower(a.keyvalue) = ''',lower(pkeyvalue),''' ) select 
    coalesce(c.processname,d.processname) processname,coalesce(c.taskname,d.taskname) taskname,
    coalesce(c.indexno,d.indexno)indexno,
cast(to_char(to_timestamp(left(coalesce(c.eventdatetime,d.eventdatetime),14) , ''YYYYMMDDHH24MISSSSS''),''dd/mm/yyyy hh24:mi:ss'') as varchar)eventdatetime,
    coalesce(c.taskstatus,''Active'') taskstatus,coalesce(c.taskid,d.taskid) taskid,coalesce(c.transid,d.transid)transid,
    coalesce(c.keyfield,d.keyfield) keyfield,coalesce(c.keyvalue,d.keyvalue)keyvalue,coalesce(c.recordid,d.recordid) recordid,
    cast(row_number() over(partition by coalesce(c.indexno,d.indexno) order by coalesce(c.indexno,d.indexno),coalesce(c.eventdatetime,d.eventdatetime) desc) as numeric)rnum
    from c   right join (select j.indexno,j.transid,j.keyfield,j.keyvalue,j.eventdatetime,
j.processname,j.taskname,j.taskid,j.recordid    from axactivetasks j 
    where lower(processname) = ''',lower(pprocessname),''' and lower(keyvalue) = ''',lower(pkeyvalue) ,''' and removeflg=''F'') d on
    c.indexno = d.indexno and c.transid = d.transid and c.keyfield = d.keyfield and c.keyvalue = d.keyvalue and c.taskid = d.taskid
    group by   coalesce(c.processname,d.processname) ,coalesce(c.taskname,d.taskname) ,coalesce(c.indexno,d.indexno),coalesce(c.eventdatetime,d.eventdatetime),
    coalesce(c.taskstatus,''Active'') ,coalesce(c.taskid,d.taskid) ,coalesce(c.transid,d.transid),
    coalesce(c.keyfield,d.keyfield) ,coalesce(c.keyvalue,d.keyvalue),coalesce(c.recordid,d.recordid)
    order by coalesce(c.indexno,d.indexno)'); 
  
   
RETURN QUERY   execute v_createtblscr;


END; $$;

CREATE FUNCTION {schema}.pr_pegv2_sendto_userslist(pallowsendflg numeric, pactor character varying, pprocessname character varying, pkeyvalue character varying, ptaskname character varying) RETURNS TABLE(pusername character varying)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare
v_usergroup_in varchar;
v_usergroup_notin varchar;
v_usergroup_in_cnt numeric;
v_usergroup_notin_cnt numeric;
begin
	
/*
 * 2 - Any user
 * 3 - Users in this process
 * 4 - Actor
 */

select senduser_in,senduser_notin,
coalesce(length(senduser_in),0),coalesce(length(senduser_notin),0) 
into v_usergroup_in,v_usergroup_notin,v_usergroup_in_cnt,v_usergroup_notin_cnt
from axprocessdefv2 where processname = pprocessname and taskname = ptaskname;	
	
RETURN QUERY 

----------  Any user & Both In & Not in usergroup is empty
select username from axusers 
where pallowsendflg = 2 and v_usergroup_in_cnt=0 and v_usergroup_notin_cnt=0
union all
---------- Any user & not in is empty
select a.username from axusers a,axpdef_peg_usergroups b 
where pallowsendflg = 2 and v_usergroup_in_cnt>0 and v_usergroup_notin_cnt=0
and a.username = b.username
and b.usergroupname in(select unnest(string_to_array(v_usergroup_in,','))) 
union all ---------- Any user & in is empty
select a.username from axusers a,axpdef_peg_usergroups b
where pallowsendflg = 2 and v_usergroup_in_cnt=0 and v_usergroup_notin_cnt>0
and a.username= b.username
and b.usergroupname not in(select unnest(string_to_array(v_usergroup_in,',')))
union all ---------- Any user & both in & not in is selected
select a.username from axusers a,axpdef_peg_usergroups b
where pallowsendflg = 2 and v_usergroup_in_cnt=0 and v_usergroup_notin_cnt>0
and a.username= b.username
and b.usergroupname not in(select unnest(string_to_array(v_usergroup_notin,',')))
and b.usergroupname in(select unnest(string_to_array(v_usergroup_in,',')))
union all
select touser from axactivetasks where grouped='T' 
and 3 = pallowsendflg  and processname = pprocessname and keyvalue = pkeyvalue and removeflg='F'
group by touser;
	
   
END; $$;

CREATE FUNCTION {schema}.pr_pegv2_transactionstatus(ptransid character varying, pkeyvalue character varying) RETURNS TABLE(processname character varying, taskname character varying, status character varying, statustext character varying, recordid numeric, keyvalue character varying, username character varying, eventdatetime character varying, indexno numeric, cnd numeric)
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_qry text;
v_processes varchar(8000);
v_logrec record;
v_logqry text[] DEFAULT  ARRAY[]::varchar[];
v_logqrytxt text;

begin
	
execute 'select distinct string_agg(b.processtable,'','') from axpeg_'||ptransid||' a join  axpdef_peg_processmaster b on a.processname = b.caption 
where a.keyvalue ='''||pkeyvalue||'''' into v_processes;  	

for v_logrec in select regexp_split_to_table(v_processes,',') tblname,
'select processname,taskname,taskstatus,tasktype,recordid,keyvalue,username,eventdatetime,cast(indexno as numeric) ,cast(1 as numeric) cnd from '||regexp_split_to_table(v_processes,',')
||' where keyvalue='''||pkeyvalue||'''' logqry from dual
loop
v_logqry := array_append(v_logqry,v_logrec.logqry);
end loop;
v_logqrytxt := array_to_string(v_logqry,' union all ');

if array_length(v_logqry,1) > 0 then

v_qry := concat('select processname,null taskname,cast(status as varchar(2)) status,statustext,recordid,keyvalue,cast(''NA'' as varchar(2)) username,
cast(eventdatetime as varchar(100)),0 indexno,cast(0 as numeric) cnd from axpeg_'||ptransid||' 
where status in (1,2) and keyvalue ='''||pkeyvalue||'''
union all
select a.processname,taskname,cast(b.status as varchar(20)) status,concat(a.taskname,'' is pending '',string_agg(a.touser,'','')) statustext,
b.recordid,b.keyvalue,cast(''NA'' as varchar(2)) username,null eventdatetime,0 indexno,cast(0 as numeric) cnd
from vw_pegv2_activetasks a join axpeg_'||ptransid||' b on a.processname=b.processname 
and a.keyvalue=b.keyvalue
where b.status=0
and a.keyvalue ='''||pkeyvalue||'''
group by a.processname,a.transid,a.keyvalue,a.taskname,b.recordid,b.keyvalue,b.status',chr(10),' union all ',chr(10),v_logqrytxt);

else 

v_qry := 'select processname,null taskname,cast(status as varchar(2)) status,statustext,recordid,keyvalue,cast(''NA'' as varchar(2)) username,
cast(eventdatetime as varchar(100)),cast(0 as numeric) indexno,cast(0 as numeric) cnd from axpeg_'||ptransid||' 
where status in (1,2) and keyvalue ='''||pkeyvalue||'''
union all
select a.processname,taskname,cast(b.status as varchar(20)) status,concat(a.taskname,'' is pending '',string_agg(a.touser,'','')) statustext,
b.recordid,b.keyvalue,cast(''NA'' as varchar(2)) username,null eventdatetime,cast(indexno as numeric),cast(0 as numeric) cnd
from vw_pegv2_activetasks a join axpeg_'||ptransid||' b on a.processname=b.processname 
and a.keyvalue=b.keyvalue
where b.status=0
and a.keyvalue ='''||pkeyvalue||'''
group by a.processname,a.transid,a.keyvalue,a.taskname,b.recordid,b.keyvalue,b.status,a.indexno';


end if;


RETURN QUERY   execute v_qry;

END; $$;

CREATE FUNCTION {schema}.pr_pegv2_transcurstatus(ptransid character varying, pkeyvalue character varying, pprocess character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_qry text;
v_output numeric;
begin
	

v_qry := concat('select cast(status as varchar(2)) status from axpeg_',ptransid,' 
where keyvalue =''',pkeyvalue,'''and processname=''',pprocess,'''');


execute v_qry into  v_output;


return case v_output when 1 then 'Approved' when 2 then 'Rejected' when 3 then 'Withdrawn' else 'In Progress' end;

END; $$;

CREATE FUNCTION {schema}.pr_source_trigger(phltype character varying, pstructname character varying, psearchtext character varying, psrctable character varying, psrcfield character varying, pparams character varying, pdocid character varying, psrcmultipletransid character varying, pparamchange character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $_$
declare
   pscripts   VARCHAR (3000);
   pcnt       NUMERIC (15);
    BEGIN     
    --To insert  or update dynamic param value from the source table

   IF psrctable IS NOT NULL AND psrcfield IS NOT NULL
   THEN
      --To drop existing trigger if any source field or source table has been changed

      IF pparamchange = 'T'
      THEN
         SELECT COUNT (1)
           INTO pcnt
         FROM information_schema.triggers where trigger_schema=current_user
                AND TRIM (UPPER (TRIGGER_name)) =
                       TRIM (UPPER ('axp_sch_' || pdocid));

         IF pcnt > 0
         THEN
            EXECUTE  'drop trigger if exists axp_sch_' || TRIM (pdocid)||' on '||psrctable||';';
             EXECUTE  'drop trigger if exists axp_sch_' || TRIM (pdocid)||'_delete on '||psrctable||';';
         END IF;

         DELETE FROM axp_appsearch_data_v2
          WHERE docid = pdocid;

      END IF;

      --To create the source table trigger

      pscripts :=
            ' create or replace function axp_sch_'|| pdocid|| '() 
RETURNS trigger
    LANGUAGE ''plpgsql''
    COST 100
    VOLATILE AS 
	$$
begin 
if tg_op=''INSERT''  then 

insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values('''
         || phltype
         || ''','''
         || pstructname
         || ''','
         || 'new.'
         || psrcfield
         || '||  '''
         || psearchtext
         || ''','''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'new.'),
                     '&',
                     '&''||''')
         || ','''
         || pdocid
         || ''');

else if  tg_op=''UPDATE''   then

insert  into axp_appsearch_data_v2 (hltype,structname,searchtext,params,docid) values('''
         || phltype
         || ''','''
         || pstructname
         || ''','
         || 'new.'
         || psrcfield
         || '||  '''
         || psearchtext
         || ''','''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'old.'),
                     '&',
                     '&''||''')
         || ','''
         || pdocid
         || ''');

else  delete  FROM axp_appsearch_data_v2 where hltype='''
         || phltype
         || ''' and params='''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'old.'),
                     '&',
                     '&''||''')
         || ';

 end if;

 end if;
return new;
exception

      when unique_violation then

if tg_op=''INSERT''  then 
      update axp_appsearch_data_v2 set searchtext='
         || 'new.'
         || psrcfield
         || '||  '''
         || psearchtext
         || ''',params='''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'new.'),
                     '&',
                     '&''||''')
         || ' where hltype='''
         || phltype
         || ''' and params='''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'new.'),
                     '&',
                     '&''||''')
         || ' and docid='''
         || pdocid
         || ''';
else 
  update axp_appsearch_data_v2 set searchtext='
         || 'new.'
         || psrcfield
         || '||  '''
         || psearchtext
         || ''',params='''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'new.'),
                     '&',
                     '&''||''')
         || ' where hltype='''
         || phltype
         || ''' and params='''
         || REPLACE (REPLACE (pparams, '@', '''||' || 'old.'),
                     '&',
                     '&''||''')
         || ' and docid='''
         || pdocid
         || ''';
end if;

return new;
   when others then 

return new;

 end ;  
 $$
 ';

      EXECUTE    pscripts;
	  
	  execute  ' drop trigger IF EXISTS axp_sch_'|| pdocid||' on '||psrctable ||';';
	  execute  ' drop trigger IF EXISTS axp_sch_'|| pdocid||'_delete on '||psrctable ||';';
	  
	 --inster and update event
	EXECUTE   'CREATE TRIGGER axp_sch_'|| pdocid||'
    AFTER INSERT OR UPDATE 
    ON '||psrctable ||
	 ' FOR EACH ROW '||
		case when psrcmultipletransid is not null and psrcmultipletransid<>'' 
	then ' when (new.transid='''||psrcmultipletransid||''')' else '' end||'
    EXECUTE PROCEDURE axp_sch_'||pdocid||'();' ;
   
   --delete event
   if psrcmultipletransid is not null and psrcmultipletransid<>'' then
   	EXECUTE   'CREATE TRIGGER axp_sch_'|| pdocid||'_delete
    AFTER delete
    ON '||psrctable ||
	 ' FOR EACH ROW '||
		case when psrcmultipletransid is not null and psrcmultipletransid<>'' 
	then ' when (old.transid='''||psrcmultipletransid||''')' else '' end||'
    EXECUTE PROCEDURE axp_sch_'||pdocid||'();' ;   
   end if;
	
	

      --Rebuild the exsting recordid from source table to appsearch data table

      EXECUTE  'update  ' || psrctable || ' set cancel=cancel';

   END IF;   
  
    
   
    END;
$_$;

CREATE FUNCTION {schema}.pr_utl_forms_menutree(ppagetype character varying) RETURNS character varying
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare v_mtree varchar(1000);
begin

WITH RECURSIVE cte AS (
   SELECT name, caption, 1 AS level,pagetype,caption a,name b,visible
   FROM   axpages 
   UNION  ALL
   SELECT t.name, t.caption, c.level + 1,t.pagetype,c.a,c.b,t.visible
   FROM   cte    c
   JOIN   axpages t ON t.parent = c.name    
   )
   select a.mtree into v_mtree from
(SELECT string_agg(a,'/') over(order by level desc) mtree,row_number() over(order by level) rnum
FROM   cte where substring(pagetype,1,1)='t'  and visible ='T'
and pagetype =ppagetype)a where rnum=1;
return 'Menu - '|| v_mtree||'</br>';
END; $$;

CREATE FUNCTION {schema}.pro_axplogstatextract(fdate date) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
BEGIN
   ------ usage details
   delete from usagedtl  where executeddate=fdate;
   INSERT INTO usagedtl (executeddate,
                         code,
                         title,
                         cnt)
        SELECT cast(calledon as date) cdate,
               'NOT' CODE,
               'Total No. of Transactions' title,
               COUNT (*) cnt
          FROM axpertlog
         WHERE cast(calledon as date) = fdate 
      GROUP BY cast(calledon as date)
      UNION ALL
        SELECT cast(calledon as date) cdate,
               'NOL' CODE,
               'Total No. of Logins' title,
               COUNT (*) cnt
          FROM axpertlog
         WHERE cast(calledon as date) = fdate AND servicename = 'Login'
      GROUP BY cast(calledon as date)
      UNION ALL
        SELECT cast(calledon as date) cdate,
               'NOU' CODE,
               'Total No. of Users' title,
               COUNT (DISTINCT username) cnt
          FROM axpertlog
         WHERE cast(calledon as date) = fdate AND servicename = 'Login'
      GROUP BY cast(calledon as date)
      UNION ALL
        SELECT cast(calledon as date) cdate,
               'NOD' CODE,
               'Total No. of Deadlock Execptions' title,
               COUNT (*) cnt
          FROM axpertlog
         WHERE cast(calledon as date) = fdate
               AND serviceresult LIKE 'trans%dead%'
      GROUP BY cast(calledon as date)
      UNION ALL
        SELECT cast(calledon as date) cdate,
               'MTJ' CODE,
               'More time taken Saves (> 8 Sec)' title,
               COUNT (*) cnt
          FROM axpertlog
         WHERE     cast(calledon as date) = fdate
               AND servicename = 'saving data'
               AND serviceresult = 'success'
               AND recordid = 0
               AND (timetaken / 1000) > 8
      GROUP BY cast(calledon as date)
      UNION ALL
        SELECT cast(calledon as date) cdate,
               'MTL' CODE,
               'More time taken Loads (> 8 Sec)' title,
               COUNT (*) cnt
          FROM axpertlog
         WHERE     cast(calledon as date) = fdate 
               AND servicename = 'load data'
               AND serviceresult = 'success'
               AND (timetaken / 1000) > 8
      GROUP BY cast(calledon as date)
      UNION ALL
      SELECT cast(calledon as date) cdate,
             'MTL' CODE,
             'More time taken reports (> 8 Sec)' title,
             COUNT (*) cnt
        FROM axpertlog
       WHERE     cast(calledon as date) = fdate 
             AND servicename = 'Get IView'
             AND serviceresult = 'success'
             AND (timetaken / 1000) > 8
GROUP BY cast(calledon as date);

   ----- exceptions
    delete from axpexception   where exp_date = fdate;
   INSERT INTO axpexception (EXP_DATE,
                             STRUCTNAME,
                             SERVICENAME,
                             SERVICERESULT,
                             COUNT)
        SELECT TRUNC (calledon),
               structname,
               servicename,
               serviceresult,
               COUNT (*)
          FROM axpertlog
         WHERE SERVICERESULT <> 'success' AND calledon = fdate
      GROUP BY calledon,
               structname,
               servicename,
               serviceresult;

   ----- time taken
    delete from ut_timetaken  where executed_date=fdate;
   INSERT INTO ut_timetaken (executed_date,
                             object_type,
                             service_name,
                             object_name,
                             tot_count,
                             count_8s,
                             count_30s,
                             count_90s,
                             min_time,
                             max_time,
                             avg_time)
        SELECT cast(SYSDATE as date) exec_date,
               'tstruct' obj_type,
               'Saving Data' service_name,
               b.caption,
               COUNT (*) cnt,
               SUM (CASE WHEN timetaken > 8000 THEN 1 ELSE 0 END) cnt8,
               SUM (CASE WHEN timetaken > 30000 THEN 1 ELSE 0 END) cnt30,
               SUM (CASE WHEN timetaken > 90000 THEN 1 ELSE 0 END) cnt90,
               MIN (timetaken) / 1000 mintime,
               MAX (timetaken) / 1000 maxtime,
               AVG (timetaken) / 1000 avgtime
          FROM    axpertlog a
               JOIN
                  (  SELECT name, caption
                       FROM tstructs
                   GROUP BY name, caption) b
               ON a.structname = b.name
         WHERE     LOWER (servicename) = 'saving data'
               AND serviceresult = 'success'
               AND a.recordid = 0
               AND cast(calledon as date) = cast(fdate as date)
      GROUP BY b.caption;

   INSERT INTO ut_timetaken (executed_date,
                             object_type,
                             service_name,
                             object_name,
                             tot_count,
                             count_8s,
                             count_30s,
                             count_90s,
                             min_time,
                             max_time,
                             avg_time)
        SELECT cast(SYSDATE as date) exec_date,
               'tstruct' obj_type,
               'Load Data' service_name,
               b.caption,
               COUNT (*) cnt,
               SUM (CASE WHEN timetaken > 8000 THEN 1 ELSE 0 END) cnt8,
               SUM (CASE WHEN timetaken > 30000 THEN 1 ELSE 0 END) cnt30,
               SUM (CASE WHEN timetaken > 90000 THEN 1 ELSE 0 END) cnt90,
               MIN (timetaken) / 1000 mintime,
               MAX (timetaken) / 1000 maxtime,
               AVG (timetaken) / 1000 avgtime
          FROM    axpertlog a
               JOIN
                  (  SELECT name, caption
                       FROM tstructs
                   GROUP BY name, caption) b
               ON a.structname = b.name
         WHERE     LOWER (servicename) = 'load data'
               AND serviceresult = 'success'
               AND cast(calledon as date) = cast(fdate as date)
      GROUP BY b.caption;

   INSERT INTO ut_timetaken (executed_date,
                             object_type,
                             service_name,
                             object_name,
                             tot_count,
                             count_8s,
                             count_30s,
                             count_90s,
                             min_time,
                             max_time,
                             avg_time)
        SELECT cast(SYSDATE as date) exec_date,
               'tstruct' obj_type,
               'Load Report' service_name,
               b.caption,
               COUNT (*) cnt,
               SUM (CASE WHEN timetaken > 8000 THEN 1 ELSE 0 END) cnt8,
               SUM (CASE WHEN timetaken > 30000 THEN 1 ELSE 0 END) cnt30,
               SUM (CASE WHEN timetaken > 90000 THEN 1 ELSE 0 END) cnt90,
               MIN (timetaken) / 1000 mintime,
               MAX (timetaken) / 1000 maxtime,
               AVG (timetaken) / 1000 avgtime
          FROM    axpertlog a
               JOIN
                  (  SELECT name, caption
                       FROM iviews
                   GROUP BY name, caption) b
               ON a.structname = b.name
         WHERE     LOWER (servicename) = 'get iview'
               AND serviceresult = 'success'
               AND cast(calledon as date) = cast(fdate as date)
      GROUP BY b.caption;

END;$$;

CREATE FUNCTION {schema}.pro_emailformat(ptemplate character varying, pkeyword character varying, ptype character varying, psendto character varying, psendcc character varying) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
v_subject varchar(3500);
v_body varchar(3500);
v_sms  varchar(3500);
v_count numeric(5);
v_keyword varchar(350);
v_keyvalue varchar(1000);
i varchar(3500);
begin

select count(*) into v_count from  sendmsg
 where lower(template) = lower( ptemplate);
 
if v_count=1 then
 
 select MSGSUBJECT,MSGCONTENT,SMSMSG into v_subject,v_body,v_sms from sendmsg
 where lower(template) = lower( ptemplate);
 
for i in (select regexp_split_to_table(pkeyword,',') as vkeyword from dual)
loop

v_keyword := SUBSTR(i.vkeyword, 1 ,INSTR(i.vkeyword, '=', 1, 1)-1);

v_keyvalue :=  SUBSTR( i.vkeyword, INSTR( i.vkeyword,'=', 1, 1)+1);

v_subject := replace(v_subject,v_keyword,v_keyvalue);

v_body := replace(v_body,v_keyword,v_keyvalue);

v_sms := replace(v_sms,v_keyword,v_keyvalue);
end loop;

if ptype='S' then

insert into axsms(createdon,mobileno,msg,status) values ( now() :: timestamp without time zone,psendto,v_sms,0);

elsif ptype='E' then

INSERT INTO AXP_MAILJOBS (MAILTO,
                          MAILCC,
                          SUBJECT,
                          BODY,
                          ATTACHMENTS,
                          IVIEWNAME,
                          IVIEWPARAMS,
                          STATUS,
                          ERRORMESSAGE,
                          SENTON,JOBDATE)
     VALUES (psendto,psendcc,v_subject ,v_body,null,null,null,0,null,null,now() :: timestamp without time zone );



end if;
end if;
end ; 
$$;

CREATE FUNCTION {schema}.random_number() RETURNS numeric
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
   v_num   numeric (20);
BEGIN
   SELECT ROUND (random() * (9999999-1111111) + 1111111)
          || TO_CHAR (now(), 'DDDSSSS')
             AS rno
     INTO v_num
     FROM DUAL;
   RETURN v_num;
END;
$$;

CREATE FUNCTION {schema}.setup_new_user(p_username text, p_email text, p_nickname text) RETURNS void
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
BEGIN
    -- 1. Insert into axusers
    INSERT INTO {schema}.axusers 
    (
        username, "password", usergroup, groupno, build, manage, tools, 
        email, active, isfirsttime, workflow, actflag, importstruct, 
        exportstruct, appmanager, debug, import_data, export_data, 
        pusername, nickname, ppassword, usertype, pwdauth, otpauth, 
        allusergroup, appmgraccess, adminaccess, homepage, singleloginkey, staysignedin, signinexpiry,
        axusersid
    ) 
    VALUES (
        p_username, 
        '22723bbd4217a0abf6d3e68073c7603d', -- Default Pwd Hash
        'default', 2, 'T', 'T', 'T', 
        p_email, 'T', 'F', 'T', 'T', 'T', 
        'T', 'T', 'T', 'T', 'T', 
        p_username, p_nickname, '22723bbd4217a0abf6d3e68073c7603d', 
        NULL, 'T', 'F', 'default', 'T', 
        'Config studio,Developer studio,Export data,Import data', 0,
        NULL, 'F', 15, 99999999999991
    );

    -- 2. Insert into axuserlevelgroups
    INSERT INTO {schema}.axuserlevelgroups
    (
        username, 
        usergroup, 
        startdate, 
        enddate, 
        axuserlevelgroupsrow, 
        axusername, 
        axusergroup, 
        axusersid, 
        axuserlevelgroupsid
    )
    VALUES(
        p_username,           -- Mapping parameter p_username
        'default', 
        CURRENT_DATE,    -- Updated startdate
        NULL, 
        1, 
        p_username,           -- Mapping parameter p_username (axusername)
        'default', 
        99999999999991,       -- Matching axuserid from above
        99999999999992        -- Static ID as per query
    );
END;
$$;

CREATE FUNCTION {schema}.sp_rapiddefinition(itid character varying) RETURNS refcursor
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
declare 
	ORes1 refcursor;
	ORes2 refcursor;
    Qry1 VARCHAR(2000);
    Qry2 VARCHAR(2000);
BEGIN
	-- Qry1 will fetch the 'Form Load' fields and their params.
    Qry1 := 'SELECT a.context, a.fieldname, c.expression, a.fldsql as fldsql, coalesce(b.paramname,'''') as paramname 
              FROM axp_formload a 
              LEFT JOIN axp_params b on b.tstruct = '''||ITid||''' and a.fieldname = b.childfield and b.context = ''new'' and b.active = ''T'' 
              INNER JOIN  axpflds c on c.tstruct = '''||ITid||''' and a.fieldname=c.fname 
              WHERE a.tstruct = '''||ITid||''' and a.active=''T'' and a.context = ''new'' ';
			  
	-- Qry2 will fetch all dependents and all parents of fields and fillgrids. (Includes the parents of all dependents and parents of all parents)
    Qry2 := 'SELECT a.parentfield, a.childfield, a.dependenttype, coalesce(b.paramname,'''') as paramname,    
              coalesce(b.allrows,''F'') as allrows, coalesce(b.dirparam,''F'') as dirparam, c.frmno, c.ordno FROM axp_dependent a 
              LEFT JOIN axp_params b on b.tstruct = '''||ITid||''' and a.parentfield = b.childfield and b.context = ''dep'' and b.active = ''T''
              JOIN axpflds c on c.tstruct = '''||ITid||''' and a.childfield=c.fname 
              WHERE a.tstruct = '''||ITid||'''
              UNION
              SELECT distinct par.paramname parentfield, dep1.childfield, ''g'' as dependenttype, coalesce(b.paramname,'''') as paramname, ''F'' as allrows, ''F'' as dirparam, flds.frmno,flds.ordno  
              FROM axp_dependent dep1
              JOIN (select paramname, childfield from axp_params par where par.tstruct = '''||ITid||''' and par.context = ''fg'') par on par.childfield = dep1.parentfield
              JOIN axp_dependent dep2 on dep2.tstruct = '''||ITid||'''  and dep2.parentfield = par.paramname and dep2.dependenttype = ''g''
              JOIN axp_params b on b.tstruct = '''||ITid||''' and par.childfield = b.childfield and b.context = ''fg'' and b.active = ''T''
              JOIN axpflds flds on flds.tstruct = '''||ITid||''' and dep1.childfield = flds.fname
              WHERE dep1.tstruct = '''||ITid||'''
              ORDER BY frmno asc, ordno asc ';   
			  
    Return ORes1;
	Return ORes2;
END;
$$;

CREATE FUNCTION {schema}.sysdate() RETURNS timestamp without time zone
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
BEGIN
RETURN to_CHAR(CURRENT_TIMESTAMP,'DD/MM/YYYY hh24:mi:ss');
END; $$;

CREATE FUNCTION {schema}.t1_axlanguage11x() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    BEGIN
	
	    begin
	 insert into axlanguage(lngname,sname,fontname,fontsize,compname,compcaption,comphint,dispname) 
	 values(new.lngname,new.sname,new.fontname,new.fontsize,new.compname,new.compcaption,new.comphint,new.dispname );
	

EXCEPTION
   WHEN unique_violation
  then update 	axlanguage set fontname=new.fontname,fontsize=new.fontsize,compcaption=new.compcaption,comphint=new.comphint,dispname=new.dispname
 where  concat(lngname,sname,compname)=concat(new.lngname,new.sname,new.compname);
end;


 RETURN NEW;

end;    
$$;

CREATE FUNCTION {schema}.tr_axpconfigs_iviews() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
 v_cnt NUMERIC(2);
v_sql varchar(4000);
    BEGIN 	 
	  if TG_OP='INSERT'
    then
	 select  count(1)  into v_cnt from information_schema.tables where table_schema=current_schema and lower(table_name) = lower( 'axpconfigsiv'||chr(95)||new.structtransid  );
     
	 if v_cnt = 0
      then
        v_sql := 'create table axpconfigsiv'||chr(95)||new.structtransid ||' ( configname varchar(30),cvalue varchar(240),condition varchar(240))' ;
        execute  v_sql;
		end if;
		
if new.cv_groupbuttons is not null
      then
        v_sql = 'insert into axpconfigsiv'||chr(95)||new.structtransid||' ( configname,cvalue,condition ) values ('''||new.configname2||''','''||new.cv_groupbuttons||''',null)';
        execute  v_sql;
      end if;
	  
end if;	  
	  
    if TG_OP='UPDATE'
    then
        v_sql = 'delete from axpconfigsiv'||chr(95)||old.structtransid;
        execute  v_sql;  
		
      if new.cv_groupbuttons is not null
      then
        v_sql = 'insert into axpconfigsiv'||chr(95)||new.structtransid||' ( configname,cvalue,condition ) values ('''||new.configname2||''','''||new.cv_groupbuttons||''',null)';
        execute  v_sql;
      end if;
	  
	end if;  
     if TG_OP='DELETE' 
    then
        v_sql = 'delete from axpconfigsiv'||chr(95)||old.structtransid;
        execute  v_sql;   
    end if;
  
	
       RETURN NEW;
    END;$$;

CREATE FUNCTION {schema}.tr_axpconfigs_tstructs() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
DECLARE
 V_CNT NUMERIC(2);
V_SQL VARCHAR(4000);
    BEGIN      
     IF TG_OP='INSERT' OR TG_OP='UPDATE'
    THEN 
    

     IF TG_OP='INSERT' THEN
     SELECT COALESCE(COUNT(TABLE_NAME),0) INTO V_CNT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=CURRENT_SCHEMA AND  LOWER(TABLE_NAME) = LOWER( 'axpconfigs'||CHR(95)||NEW.STRUCTTRANSID );
      IF V_CNT = 0
      THEN
      V_SQL := 'create table axpconfigs'||CHR(95)||NEW.STRUCTTRANSID||' ( configname varchar(30),cvalue varchar(2000),condition varchar(2000))' ;
        EXECUTE  V_SQL;
        END IF;
    ELSIF TG_OP='UPDATE'
    THEN
	
        V_SQL = 'delete from axpconfigs'||CHR(95)||OLD.STRUCTTRANSID;
		begin
        EXECUTE  V_SQL; 
		exception when others then null;
		end ;
        END IF;
        
     IF NEW.CV_SEARCHFLDS IS NOT NULL and NEW.CV_SEARCHFLDS  <> ''
      THEN
        V_SQL = 'insert into axpconfigs'||CHR(95)||NEW.STRUCTTRANSID||' ( configname,cvalue,condition ) values ('''||NEW.CONFIGNAME1||''','''||NEW.CV_SEARCHFLDS||''',null)';
        EXECUTE  V_SQL;
      END IF;
      
      IF NEW.CV_GROUPBUTTONS IS NOT NULL and NEW.CV_GROUPBUTTONS <>''
      THEN
        V_SQL = 'insert into axpconfigs'||CHR(95)||NEW.STRUCTTRANSID||' ( configname,cvalue,condition ) values ('''||NEW.CONFIGNAME2||''','''||NEW.CV_GROUPBUTTONS||''',null)';
        EXECUTE  V_SQL;
      END IF;
      
      IF NEW.CV_HTMLPRINTS IS NOT NULL and NEW.CV_HTMLPRINTS <> ''
      THEN
        V_SQL = 'insert into axpconfigs'||CHR(95)||NEW.STRUCTTRANSID||' ( configname,cvalue,condition ) values ('''||NEW.CONFIGNAME3||''','''||NEW.CV_HTMLPRINTS||''',null)';
        EXECUTE  V_SQL;
      END IF;     
              
      IF NEW.CV_MASTERFLDS IS NOT NULL and NEW.CV_MASTERFLDS <>''
      THEN
        V_SQL = 'insert into axpconfigs'||CHR(95)||NEW.STRUCTTRANSID||' ( configname,cvalue,condition ) values ('''||NEW.CONFIGNAME4||''','''||NEW.CV_MASTERFLDS||''',null)';
        EXECUTE  V_SQL;
      END IF;
      
    END IF;
    
    
    IF TG_OP='DELETE'
    THEN
        V_SQL = 'delete from axpconfigs'||CHR(95)||OLD.STRUCTTRANSID;
        EXECUTE  V_SQL;   
        END IF;
       RETURN NEW;
    END;
$$;

CREATE FUNCTION {schema}.trg_axpeg_sendmsg() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
   	
    begin

insert into axactivemessages(eventdatetime,msgtype,fromuser,touser,displaytitle,displaycontent,effectivefrom,effectiveto,hlink_transid,hlink_params)
	select
	to_char(current_timestamp,'YYYYMMDDHH24MISSSS'),new.msgtype,new.fromuser,new.touser,new.msgtitle,new.message,current_date,
	new.effectiveto,new.hlink_transid,new.hlink_params;
	 
		return new;

end; 
$$;

CREATE FUNCTION {schema}.trg_axprocessdefv2() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path = {schema}, pg_catalog
    AS $$
    declare 
   	v_rem_esc_sfrom varchar;
   	v_rem_esc_taskparam varchar;
   	
    begin
	    
	   select string_agg(sfrom,',') into v_rem_esc_sfrom  from (
    select distinct regexp_split_to_table(new.rem_esc_startfrom,',') sfrom)a;
   
   select string_agg(fname, ',') from (select	substring(unnest(string_to_array( v_rem_esc_sfrom , ',')), position('-(' in unnest(string_to_array( v_rem_esc_sfrom , ',')))+ 2, abs((position('-(' in unnest(string_to_array( v_rem_esc_sfrom , ',')))+ 2) - length(substring(unnest(string_to_array( v_rem_esc_sfrom , ',')), 1, length(unnest(string_to_array( v_rem_esc_sfrom , ',')))))))fname where v_rem_esc_sfrom is not null) a
    into v_rem_esc_taskparam;

        IF (TG_OP = 'INSERT') THEN
		
		new.taskparamsui = concat(new.taskparamsui,',',v_rem_esc_sfrom);
		new.taskparams=concat(new.taskparams,',',v_rem_esc_taskparam);
		
		return new;
	end if;
		
		IF (TG_OP = 'UPDATE') THEN
		
		new.taskparamsui = concat(new.taskparamsui,',',v_rem_esc_sfrom);
		new.taskparams=concat(new.taskparams,',',v_rem_esc_taskparam);
		
		return new;
	end if;
end; 
$$;
