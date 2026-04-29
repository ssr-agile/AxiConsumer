-- Split seed data files generated from original 100_seed_data.sql.
-- Execute files in filename order. Each file preserves original table-block order.
SET LOCAL search_path = {schema}, pg_catalog;

-- Seed: iviewscripts (0 rows)
-- No rows in source dump for iviewscripts.

-- Seed: iviewsql (167 rows)
INSERT INTO {schema}.iviewsql (iname, scripttext, type, task, blobno, relation_field, cat, sname, ordno)
VALUES
('ad___red', 'select a.axpdef_ruleengid, 
a.rulename,a.formcaption as form,
case when a.active = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as active, 
case when (a.uroles is not null or length(trim(a.uroles)) > 0) then ''<span style="font-weight:bold;">''||''Roles''||''</span><br/>'' || a.uroles || ''<br/><br/>'' end|| 
case when (a.formula is not null or length(trim(a.formula)) > 0) then ''<span style="font-weight:bold;">''||''Criteria''||''</span><br/>'' || a.formula || ''<br/>'' end criteria, 
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon created,
''<b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated
from axpdef_ruleeng a
where (a.stransid = :ptransid or ''All'' = :ptransid)
ORDER BY a.rulename 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___erc', 'select axentityrelationsid,rtypeui,mstructui,mfieldui,dstructui,a.CAPTION||''-(''||a.FNAME||'')'' DFIELDUI 
from axentityrelations 
join axpflds a on axentityrelations.dfield = a.fname and axentityrelations.dstruct=a.tstruct
join axpflds mf on axentityrelations.mfield = mf.fname and axentityrelations.mstruct=mf.tstruct
where (mstruct = :ptransid or ''All'' = :ptransid)
and rtype =''md''
union all
select axentityrelationsid,rtypeui,mstructui,mfieldui,dstructui,a.DFIELDUI 
from axentityrelations a 
where (mstruct = :ptransid or ''All'' = :ptransid)
and rtype !=''md''
order BY 3,2,4
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___nwa', 'SELECT axpdef_news_eventsid,title,subdetails,EFFECTFROM,EFFECTO,case when active = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as active  FROM axpdef_news_events
ORDER BY EFFECTFROM desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axpcards', 'select axp_cardsid,cardtype,coalesce(charttype,''NA'') charttype,cardname,cachedata ,orderno from axp_cards
order by cardtype,orderno,cardname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___tbd', 'select dname,modifiedon,axp_tabledescriptorid from axp_tabledescriptor order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axlangs', 'select axpdef_languageid,language langname,fontcharset,fontname,fontsize from axpdef_language order by langname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___pth', 'select substr(eventdatetime,1,4)||''-''||substr(eventdatetime,5,2)||''-''||substr(eventdatetime,7,2)
||'' ''||substr(eventdatetime,9,2)||'':''||substr(eventdatetime,11,2)||'':''||substr(eventdatetime,13,2) as eventdatetime,keyvalue,username,processname,taskname,taskstatus,statusreason from axactivetaskstatus a 
where keyvalue  = :pkeyvalue
and processname = :pprocess 
order by eventdatetime
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emaildef', 'select emaildefid,emaildefname,emailwhat,
case when emailwhat =''Tstruct'' then emailform 
when emailwhat in(''IView'',''IView rows'') then emailiview 
end source,
axp_emailto emailto,axp_emailcc emailcc,axp_emailsubject emailsubject,axp_emailattachment emailattachment
from emaildef e 
order by emaildefname 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ivconfdt', 'select distinct configprops,propcode,ptype,
case when caction=''T'' then ''Yes'' else ''No'' end as caction,
case when chyperlink=''T'' then ''Yes'' else ''No'' end  as chyperlink,
case when cfields=''T'' then ''Yes'' else ''No'' end as cfields,
case when alltstructs=''T'' then ''Yes'' else ''No'' end  as alltstructs,
case when alliviews=''T'' then ''Yes'' else ''No'' end  as alliviews,
case when alluserroles=''T'' then ''Yes'' else ''No'' end  as alluserroles
 from axpstructconfigprops
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('dop_list', 'select asprops as Property,propvalue1 as Property_Value, propvalue2 as Property_Info,structcaption as Form_Report,purpose,axpstructconfigid from axpstructconfig
order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_lngst', 'select a.jobdate,a.status,reverse(substring(reverse(a.filename),0,position(''\'' in reverse(a.filename)))) filename,b.remarks from aximpjobs a
left join aximpdatauploadjobs b on a.jobid=b.jobid
where aximpdefname=''Axlanguage'' 
order by jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('publsdtl', 'select a.createdon, case transtype when  ''ts'' then ''Form''
when ''iv'' then ''Iview''
when ''rsiv'' then ''Responsibility''
when ''rl'' then ''User roles''
when ''wf'' then ''Workflow''
when ''cd'' then ''AxCards''
when ''pg'' then ''Pages''
when ''fr'' then ''Fast report''  end transtype,
coalesce(case transtype when  ''ts'' then t.caption
when ''iv'' then i.caption
when ''rsiv'' then ''Responsibility''
when ''rl'' then ''User roles''
when ''wf'' then ''Workflow''
when ''cd'' then ''AxCards''
when ''pg'' then pg.caption 
when ''fr'' then ''Fast report''  end,a.transid) transid,
publishedon,publishedto,status,remarks
from axpublishreport a
left join tstructs t on a.transid = t.name
left join iviews i on a.transid = i.name
left join axpages pg on a.transid = pg.name
where cast(a.createdon as date) = :pdate 
and coalesce(publishedby,''NA'') = :ppby 
and coalesce(publishedto,''NA'') = :ppon
order by a.createdon desc,transid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('publist', 'select cast(createdon as date) createdon,coalesce(publishedby,''NA'') publishedby,coalesce(publishedto,''NA'')publishedto ,substring(string_agg(transid,'',''),1,300)||''..'' details from axpublishreport
group by cast(createdon as date) ,publishedby,publishedto
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('pservers', 'select dwb_publishpropsid,servername,
serverpath,app_connection,
case when inactive=''F'' then ''Active'' else ''In active'' end status
from dwb_publishprops where servertype=''Publish''
order by servername
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('jobtsk', 'select axpdef_jobsid,jobid,jname,jobschedule,status,lastrun,remarks,case when isactive=''T'' then ''Active'' else ''Disabled'' end  as active from axpdef_jobs order by createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_pgv2', 'select concat(''<b>Desc:</b> ''||c.processdesc,
''</br><b>Tasks:</b> ''||string_agg(taskname,'','' order by b.indexno,b.subindexno)) procdesc,c.processowner,c.powner,c.pownerflg,c.axpdef_peg_processmasterid,
''Add/View'' clm,''<a title="''||c.caption||''" href="processflow.aspx?loadcaption=AxProcessBuilder&processname=''||c.caption||''" style="cursor: pointer;">''||c.caption||''  </a>'' as processname,
''All'' pprocess,''Edit'' actn,''<a title ="Test" href="tstruct.aspx?transid=ad_pm&act=load&axpdef_peg_processmasterid=''||c.axpdef_peg_processmasterid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd
from	axprocessdefv2 b right join axpdef_peg_processmaster c on b.processname = c.caption 
where (b.transid = :ptransid or ''All'' = :ptransid)
and (b.processname =:pprocessname or ''All'' =:pprocessname)
group by c.caption,c.processdesc,c.processowner,c.powner,c.pownerflg,c.axpdef_peg_processmasterid
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__prcd', 'select axpdef_prcardsid,cardname,cardtype,charttype from axpdef_prcards order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__pgnt', 'select axnotificationdefid,processname,taskname,name,notifyto,enableemail,enablesms,enablewhatsapp,enablemobilenotify from axnotificationdef
where (processname = :pprocess or ''All''= :pprocess)
order by 2,3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('jobcdtl', 'select jobdate ,act_script_name ,aximpdefname,
''Form: ''||b.caption||'' DB Directory: ''||dbdirpath||'' File name: ''||filename adetails,
status,1 ord,''View details'' actn,''iaximpfrc'' ptransid,a.jobid jobid
from aximpjobs a join tstructs b on a.aximptransid =''t''||b.name
where jobid = :pjobid 
union all
select calledon,act_script_name ,axprintdefname,
''Source: ''||case when axprintwhat in(''Form Data'')  then b.caption 
when axprintwhat in(''IView'',''Form Data from IView'') then i.caption
when axprintwhat in(''Form data from SQL'',''SQL Result'') then ''SQL'' end||''| Print forms: ''||a.axprintformnames||''| Download location:''||axprintsaveto||
''| Total records: ''|| a.totallines ||''| Success :''||a.succlines adetails,
status,2,''View details'' actn,''iprnfail'' ptransid,substring(context,7) jobid
 from axprintdetails a
left join tstructs b on a.axprinttransid =b.name
left join iviews i on a.axprintiviewname = i.name
where substring(context,7) = :pjobid 
union all
select calledon , act_script_name , emaildefname,''Total records: ''|| e.totallines ||''| Success :''||e.succlines ,status,3,''View details'' actn,
''iemlexcp'' ptransid,e.id jobid
from emaildetails e
where substring(context,7) = :pjobid 
union all
select starttime,null act_script_name,null apidefname,
''URL :''||url||'' | Service name:''||servicename ||'' | Method: ''||method adetails 
,status,4,''View details'' actn,''iaxapilog'' ptransid,a.schjobid jobid
 from axapijobdetails a 
where jobid = :pjobid 
order by ord,jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__pgal', 'select *, ''dynamic buttons'' dynamicbuttons from vw_pegv2_activetasks 
where lower(touser) = :username
and (lower(processname) = lower( :pprocess) or ''All'' = :pprocess)
and (lower(fromuser) = lower(:pfromuser) or ''All'' = :pfromuser)
and cast(eventdatetime as date) between cast(:pfrom as date) and cast(:pto as date)
order by edatetime desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('hplist', 'select a1.caption as fromCaption ,case when a1.isacoretrans=''No'' then ''hidden'' when a1.isacoretrans=''Yes'' and a1.menuposition=''Default'' then ''root'' when a1.isacoretrans=''Yes'' and a1.menuposition !=''Default'' and a1.menulist !='''' then a1.menulist else ''Not Defined'' end as Modulename,  ''<b>''|| COALESCE(d.cntimg,'''') ||'' '' || case when COALESCE(a2.filedtl,'''')='''' then '''' else  COALESCE(a2.filedtl,'''') || ''</b> Files'' end as detail,''<b>'' || a1.createdBy || ''</b> on '' || a1.createdon as createdBy, ''<b>'' || a1.username || ''</b> on '' || a1.modifiedon as updatedBy ,a1.htmlsectionsid from htmlsections  a1
left join (select string_agg(cnt||'' ''||filetype ,'', '')  as filedtl , htmlsectionsid from 
(select count(filetype) as cnt,filetype,htmlsectionsid from sect4 group by filetype ,htmlsectionsid order by filetype) b
group by b.htmlsectionsid) a2 on a1.htmlsectionsid=a2.htmlsectionsid
left join ( select count(cc)|| '' Image,'' as cntimg,htmlsectionsid from ( 
SELECT regexp_split_to_table(axpfile_hpimages, '','') as cc,htmlsectionsid FROM htmlsections where coalesce(axpfile_hpimages,'''')<>'''') as c
GROUP by htmlsectionsid ) d on a1.htmlsectionsid =d.htmlsectionsid 
order by a1.createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('exapidef', 'select executeapidefid,execapidefname,execapimethod,execapiurl,execapibasedon from executeapidef
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axvars', 'select sourceid,
axvarname,
case when isconstant=''T'' then ''Constant'' when isvariable=''T'' then ''Variable'' when isdbobj=''T'' then ''Get from DB''  when isappparam=''T'' then ''Application Parameter'' end vartype,
case when event_onlogin = ''T''then  ''OnLogin'' 
when event_onformload =''T'' and event_onreportload =''T'' then concat(''OnFormLoad - '',forms)||''</br>''||concat(''OnReportLoad - '',reports) 
when event_onformload =''T'' and event_onreportload =''F'' then concat(''OnFormLoad - '',forms)
when event_onformload =''F'' and event_onreportload =''T'' then concat(''OnReportLoad - '',reports)
end eventdtl,
case when isconstant=''T'' then concat(''Constant: '',vpvalue) 
when isvariable=''T'' then concat(''Var: '',''</br>'',vscript ) 
when isdbobj=''T'' then concat(''DBVar: '',''</br>'',''DBfun='',db_funtion,case when db_funtion_params is not null then concat(''</br>'',''DBfunparam='',db_funtion_params) end) 
when isappparam =''T'' then concat(''VPname: '',axvarname,''</br>'',''Vartype: '',case when isparam=''T'' then ''Parameter'' else ''Variable'' end) end vardtl,
concat(''t'',stransid) stransid
 from axvarcore a 
order by 3,1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axjobs', 'select *,case 
when lower(status) in(''completed'',''inprogress'') then null else   ''View details'' end actn   from axscriptjobs 
where (case 
when lower(status)=''completed'' then ''Success''
when lower(status)=''inprogress'' then ''In progress''
else ''Failed'' end = :pstatus or ''ALL'' = :pstatus)
and jobdate between :pfdate and :ptdate
order by jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximpdef', 'select aximpdefid,AxImpDefName,AxImpform,AxImpProcessMode,AxImpHeaderRows from aximpdef
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('appvars', 'select axp_vpid,vpname from axp_vp order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adi_td', 'select dname,modifiedon,axp_tabledescriptorid from axp_tabledescriptor order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__qls', 'select a.axqueuename,concat(a.axqueuedesc,''</br><b>'',''Forms mapped to this queue: </b>'',case when length(string_agg(t.caption,'','')) > 1 then concat(substring(string_agg(t.caption,'',''),1,75),''...'') else null end)axqueuedesc,''Outbound'' qtype,
''<a title ="Oque" href="tstruct.aspx?transid=a__qm&act=load&axoutqueuesmstid=''||a.axoutqueuesmstid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>''  cmd,
''<a title ="Oqueadd" href="tstruct.aspx?transid=ad__q&act=open&AxQueueName=''||a.axqueuename||''" style="cursor: pointer;"><span class="material-icons ">add</span> </a>''  addcmd
from axoutqueuesmst a left join axoutqueues b on a.axqueuename = b.axqueuename  
left join tstructs t on b.stransid = t.name
group by a.axqueuename,a.axqueuedesc,case when b.active=''T'' then ''Active'' else ''Inactive'' end ,a.axoutqueuesmstid 
union all
select axqueuename,axqueuedesc,''Inbound'' qtype,
''<a title ="Ique" href="tstruct.aspx?transid=a__iq&act=load&axinqueuesid=''||axinqueuesid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd,null
from axinqueues
order by 3,1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ual', 'select axusersid,username, nickname, email, usergroups,actors,adminaccess,
case when COALESCE(active,''T'')=''T'' then ''Yes'' else ''No'' end status
from axusers 
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__qlog', 'select a.createdon,axqueuename,t.caption,substring(queuedata,1,250) queuedata from axinqueuesdata a join tstructs t on a.transid = t.name
where a.axqueuename = :pqueuename
union all
select a.createdon,axqueuename,t.caption,substring(queuedata,1,250) queuedata from axoutqueuesdata a join tstructs t on a.transid = t.name
where a.axqueuename = :pqueuename
order by 1 desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__papi', 'select axpdef_publishapiid,publickey,apitype,structcap,scriptcap,printform,unameui,
''<b>Created by</b> ''||createdby||'' on ''||createdon||''</br><b> Last modified by </b>''||username||'' on ''||modifiedon updated
from axpdef_publishapi order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ugu', 'SELECT u.username  user_name,u.NICKNAME login_name,u.EMAIL,u.MOBILE,ug.grps USERGROUP,u.ACTORS,u.AXUSERSID
FROM AXPDEF_PEG_USERGROUPS a JOIN axusers u ON a.USERNAME=u.USERNAME
join (select username,string_agg(usergroupname,'','') grps from axpdef_peg_usergroups where active=''T''
group by username) ug on a.username = ug.username
WHERE USERGROUPNAME  = :pusergroup AND u.ACTIVE=''T'' 
ORDER BY 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___oqm', 'select axqueuename,b.axqueuesource,t.caption,case when b.active=''T'' then ''Active'' else ''Inactive'' end stats,b.axoutqueuesid,
''<b>Created by </b>''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.username||'' on ''||b.modifiedon updated
from axoutqueues b join tstructs t on b.stransid = t.name
where (b.axqueuename = :pqueuename or ''All'' = :pqueuename)
and (t.name = :ptransid or ''All'' = :ptransid)
union all
select axqueuename,b.axqueuesource, b.datasource,case when b.active=''T'' then ''Active'' else ''Inactive'' end stats,b.axoutqueuesid,
''<b>Created by </b>''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.username||'' on ''||b.modifiedon updated
from axoutqueues b
where (b.axqueuename = :pqueuename or ''All'' = :pqueuename) and 1=2
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ntn', 'select t.caption,a.notifyto,''Form'' notifytype,axformnotifyid recid,''ta__fn''stransid,
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by</b> ''||a.username||'' on ''||a.modifiedon updated
from AxFormNotify a,tstructs t 
where a.stransid =t."name" and (''Form'' = :ptype or ''All'' = :ptype) and (t.name = :ptransid or ''All'' = :ptransid)
union all
select "name",datasource,''Periodic'',axperiodnotifyid,''ta__pn'',
''<b>Created by </b>''||createdby||'' on ''||createdon||''</br><b> Last modified by</b> ''||username||'' on ''||modifiedon updated
from AxPeriodNotify where (''Periodic'' = :ptype or ''All'' = :ptransid )
union all
select "name",notifyto,''PEG'',axnotificationdefid,''tad_pn'',
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br> <b>Last modified by</b> ''||a.username||'' on ''||a.modifiedon updated
from axnotificationdef a 
where (''PEG'' = :ptype or ''All'' = :ptransid)
order by 3,2 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___apt', 'select autoprintid,t.caption,a.printdoc,
''<b>Created by </b>''||a.createdby || '' on '' || a.createdon||''</br><b> Last Modified by </b>''|| a.username || '' on '' || a.modifiedon as modifiedon
,axautoprintsid
from axautoprints a join tstructs t on a.stransid = t.name 
where (t.name = :ptransid or ''All'' = :ptransid)
order by 2,3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_implg', 'select username,calledon,filename,recordcount, greatest(a.success,0) as success,
a.recordcount-greatest(a.success,0) as failed_record,id,''t'' dmyhl 
from importdatadetails a
where structname = :ptransid 
order by calledon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__ugp', 'select a1.users_group_masterid recordid, a1.users_group_name, a1.users_group_description, 
coalesce( a2.cnt,0 ) as usersongroups,
case when a1.isactive = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as isactive
from users_group_master a1
left outer join (select a.users_group_name, count(1) as cnt
from
(select unnest(string_to_array(b.consolidated_usergroups, '','')) as users_group_name
from users_logindetails b where b.isactive = ''T'' and b.cancel = ''F'') a
group by a.users_group_name
) a2
on ( a1.users_group_name = a2.users_group_name)
where 1 = 1  and
a1.cancel = ''F'' 
order by a1.users_group_name
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_txalg', 'select recordid,modifieddate,username,fieldname,fieldcaption,
case 
when newrecord=''t''  then ''New'' 
when delrec = ''t'' then ''Deleted''
when cancelrec = ''t'' then ''Cancelled''
when newrecord=''f'' and delrec=''f'' and cancelrec=''f'' then ''Modification'' end newrecord,
oldvalue,newvalue,cancelremarks,docid 
from fn_axp_auditlog( :ptransid,cast(:pfromdate as date) ,cast(:ptodate as date))
order by modifieddate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__alog', 'SELECT * from fn_axp_auditlog(''histt'',current_date,current_date)
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___cfd', 'select null dmy,b.fname ,b.caption  fcaption,a.caption ,a.name,a.runtimetstruct,a.runtimemod 
from tstructs a,axpflds b
where a.name = b.tstruct 
and a.runtimemod=''T''
and b.runtimefld=''T''
order by 3,2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___acs', 'select null dmy,name,caption,runtimetstruct,runtimemod from tstructs
where runtimetstruct=''T'' and runtimemod=''T''
order by 1,2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emlexcp', 'select case when e.transid is null and iviewname is null then emaildet 
when e.transid is null then i.caption 
when e.iviewname  is null then b.caption end source,lineno,errormsg from emailexceptiondetails e 
left join tstructs  b on e.transid  = b."name" 
left join iviews i on e.iviewname=i."name" 
where e.id  = :pjobid
order by lineno
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('prnfail', 'select case when a.transid is null then iviewname 
when a.iviewname  is null then a.transid end source, formnames,filename,lineno,errormsg from axprintexceptiondetails a
left join tstructs b on a.transid = b.name
left join iviews i on iviewname = i.name
where id = :pjobid
order by lineno
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('printlog', 'select id,calledon,username,act_script_name,axprintdefname,axprintwhat,
case when axprintwhat in(''Form Data'')  then b.caption 
when axprintwhat in(''IView'',''Form Data from IView'') then i.caption
when axprintwhat in(''Form data from SQL'',''SQL Result'') then ''SQL'' end source,
axprintformnames,axprintsaveto,status,''View details'' actn
from axprintdetails a
left join tstructs  b on a.axprinttransid = b."name" 
left join iviews i on a.axprintiviewname = i.name
where a.calledon between :pfdate and :ptdate
order by calledon desc,id
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('thint', 'select a1.axtstructhintid as recordid,a1.caption_tstruct, a1.rtf_hint from axtstructhint a1   order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('smslog', 'select recordid jobid, trunc(createdon) jobdate, mobileno mobilenumber, substr(msg,1,80)+''...'' msg, 
to_char(senton) as senton, case when status=1 then ''Success'' when status=0 then ''Pending'' else 
remarks end errormessage from 
axsms where to_date(createdon)=:asondate order by jobid 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('response', 'SELECT rname,substring(string_agg(case when stype=''t''  then t.caption
when stype =''i'' then i.caption end,'',''),1,150)||''...'' sname FROM axuseraccess a
left join tstructs t on a.sname  = t.name
left join iviews i on a.sname  = i.name
group by rname
order by rname 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('loview1', 'select axlovid, group_name, value_name, identifier, case when activeyes=''T'' then ''Yes'' else ''No'' end as active 
from axlov
where COALESCE(activeyes,''T'')=''T''
order by group_name, disp_order
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ivhelpto', 'select module,topic,axphelpdocsid
 from axphelpdocs  
 order by module,topic
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('itimtk', 'SELECT  U.OBJECT_NAME, U.TOT_COUNT, U.COUNT_8S, 
   U.COUNT_30S, U.COUNT_90S, U.MIN_TIME, 
   U.MAX_TIME, U.AVG_TIME
FROM UT_TIMETAKEN U
where  executed_date = :fdate
and object_type=''tstruct''
order by object_name
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('inmemdb', '  SELECT  distinct name AS TName, ftype,  CASE
                         WHEN ftype = ''General'' THEN caption
                         WHEN ftype = ''ALL'' THEN caption
                         ELSE caption
                      END
                         AS caption, TotalKeys, keysize, keys
    FROM (SELECT  distinct name, caption, ''Form'' ftype, ''0'' TotalKeys, ''0'' keysize, ''keys'' keys
            FROM tstructs
           WHERE (:fldtype = ''Tstructs'' OR :fldtype = ''ALL'')
                 AND (caption = :cap OR :cap = ''ALL'')
          UNION
          SELECT  distinct i.name, i.caption, ''Report/List'' AS ftype, ''0'' TotalKeys, ''0'' keysize, ''keys'' keys
            FROM iviews i
           WHERE (:fldtype = ''Iviews'' OR :fldtype = ''ALL'')
                 AND (caption = :cap OR :cap = ''ALL'')

) a
ORDER BY ftype
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('imobc', 'SELECT a1.axmpagehdrid ,
               a1.struct_type Page_type,
         a1.menu_caption Page_name
            FROM axmpagehdr a1
 ORDER BY a1.modifiedon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ikywd', ' select axpmsgkeywordsid,a1.templatename from axpmsgkeywords a1 
   order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('idsco', 'SELECT a1.dsignconfigid as recordid,
       a1.transname,
       a1.stransid,
       a1.tunique,
       a1.docname
      FROM dsignconfig a1
      order by a1.transname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('iaxpscon', 'select a1.axpstructconfigid recordid,a1.stype, a1.structname, a1.context, a1.sfield, a1.icolumn, a1.sbutton, a1.hlink, a1.props, a1.propsval, a1.userroles from axpstructconfig a1 
    order by stype,structname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('iaxex', 'select EXP_DATE, STRUCTNAME, SERVICENAME, 
   SERVICERESULT, COUNT from axpexception
   where EXP_DATE = :fdate 
order by count desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('esmsco', 'SELECT a1.sendmsgid as recordid,
             a1.docid,
       a1.currdate,
       a1.template,
       a1.msgsubject,
        a1.smsmsg
  FROM sendmsg a1
 order by a1.modifiedon  DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emaillog', 'select substring(context,7),calledon,emaildefname ,act_script_name,
case when totallines = succlines then ''Success'' 
when succlines = 0 then ''Failed''
else ''Partial success'' end status,id,''View details'' actn
from emaildetails 
where calledon between :pfdate and :ptdate
order by calledon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('dmlscrpt', 'select axpscriptrunnerid, script_id, script_date, script_type, script_purpose, substr(script_text,1,30)||''....''   as sqltext,rows_affected  from axpscriptrunner order by script_id
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('cerrm', 'SELECT 
   A.CONSTRAINT_NAME, 
   A.MSG
FROM  AXCONSTRAINTS A
order by   A.CONSTRAINT_NAME
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axusracc', 'select distinct a1.rname, A2.CAPTION, a1.sname, ''Page'' stype from axuseraccess a1, axpages a2
where a1.sname = A2.NAME 
and stype=''p''
union all
select distinct a1.rname, A3.CAPTION,a1.sname, ''Tstruct'' stype from axuseraccess a1, tstructs a3 
where   a1.sname=A3.NAME
and stype=''t''
union all
select distinct a1.rname, a4.CAPTION,a1.sname, ''Iview'' stype from axuseraccess a1,  iviews a4
where  A1.SNAME=a4.name 
 and stype=''i'' 
order by rname, caption
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axroles', 'select axusergroupsid, groupname, userroles from axusergroups where groupname <> ''admin''
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axpfinhs', ' select a.username, c.caption, a.calledon as dd,a.filename, a.success from importdatadetails a 
join tstructs c on a.structname= c.name
left outer join  importdataexceptions b on  a.sessionid= b.sessionid
  where   a.calledon between :fromdate and :todate
and  (c.caption = :strut or ''ALL'' = :strut)
order by 3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axnxtlst', 'select axintelliviewdetid, repid, ivname, companyname, reportname,reporttype  from axintelliviewdet
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximplog', 'select jobid,jobdate,aximpdefname,act_script_name ,b.caption form,aximpprocessmode,a.username,status,sessionid,to_char( jobdate,''dd/MM/yyyy HH24:mi:ss'') pcjdate, ''View details'' actn from aximpjobs a 
left join tstructs b on a.aximptransid = ''t''||b.name
where cast(to_char(a.jobdate,''dd/mm/yyyy'') as date)between :pfdate and :ptdate
order by jobdate desc,jobid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximpfrc', 'select primaryfield,status errmsg,createdon from aximpfailedrecords a2 
where jobid = :pjobid
order by createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axfinyrs', 'select financialyearid, finyr, A.FINYRIDENTIFIER, A.STARTDATE, A.ENDDATE, case when A.CURRENTFINYR =''T'' then ''Yes'' else ''No'' end as iscurrentfinyr from financialyear a
where active=''T'' order by iscurrentfinyr desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('publsdtl', 'select a.createdon, case transtype when  ''ts'' then ''Form''
when ''iv'' then ''Iview''
when ''rsiv'' then ''Responsibility''
when ''rl'' then ''User roles''
when ''wf'' then ''Workflow''
when ''cd'' then ''AxCards''
when ''pg'' then ''Pages''
when ''fr'' then ''Fast report''  end transtype,
coalesce(case transtype when  ''ts'' then t.caption
when ''iv'' then i.caption
when ''rsiv'' then ''Responsibility''
when ''rl'' then ''User roles''
when ''wf'' then ''Workflow''
when ''cd'' then ''AxCards''
when ''pg'' then pg.caption 
when ''fr'' then ''Fast report''  end,a.transid) transid,
publishedon,publishedto,status,remarks
from axpublishreport a
left join tstructs t on a.transid = t.name
left join iviews i on a.transid = i.name
left join axpages pg on a.transid = pg.name
where cast(a.createdon as date) = :pdate 
and coalesce(publishedby,''NA'') = :ppby 
and coalesce(publishedto,''NA'') = :ppon
order by a.createdon desc,transid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axemllog', '  SELECT jobid,
         jobdate,
         mailto,
         mailcc,
         subject,
         SUBSTR (body, 1, 80) || ''...'' AS body,
         senton,
         CASE
            WHEN status = 1 THEN ''Success''
            WHEN status = 0 THEN ''Pending''
            ELSE errormessage
         END
            errormessage
    FROM axp_mailjobs
   WHERE (mailto IS NOT NULL OR mailto <> '''') AND jobdate = :asondate
         AND (UPPER (subject) LIKE ''%'' || UPPER (:psubject) || ''%''
              OR UPPER (:psubject) = ''ALL'')
         AND ( (CASE
                   WHEN status = 1 THEN ''SUCCESS''
                   WHEN status = 0 THEN ''PENDING''
                   ELSE ''FAILURE''
                END) = UPPER (:pstatus)
              OR UPPER (:pstatus) = ''ALL'')
         AND ( (CASE
                   WHEN iviewname IS NOT NULL THEN ''Report''
                   WHEN transid IS NOT NULL THEN ''Document''
                   ELSE ''Alert''
                END) = :petype)
         AND mailto IS NOT NULL
         AND subject IS NOT NULL
         AND mailto <> ''''
         AND subject <> ''''
ORDER BY jobid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axchtdtl', 'SELECT a1.axp_chartconfigid as recordid,
         a1.title,
         a1.subtitle,
         a1.graphtype,
         a1.piecolor, 
         a1.linkname,
         a1.sqltext,
         a1.hyptext,
         a1.flinkname
    FROM axp_chartconfig a1
ORDER BY a1.modifiedon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axapilog', 'select schjobid,act_script_name,servicename,method,starttime,endtime ,status from axapijobdetails a 
where starttime  between :pfdate and :ptdate
order by starttime  desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('auditlog', 'select * from axaudit
where username = :usernam or  :usernam =''ALL''
and cast(to_char(logintime,''dd/mm/yyyy'') as date)  between cast(to_char( :fromdt,''dd/mm/yyyy'') as date)  and  cast(to_char(  :todt,''dd/mm/yyyy'') as date)
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('applogsm', 'select title, executeddate as pivotcol, cnt from usagedtl 
where executeddate between :fromdt and :todt 
order by title, pivotcol 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxoutlo', 'select filename, senton recdon, transid, tstructname, outstatus from ax_outbound_status  where  outdate= :asondt or  senton is null order    by recdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxinlog', '  SELECT filename,
         recdon,
         transid,
         tstructname,
         instatus
    FROM ax_inbound_status
   WHERE indate = :asondt
         AND ( (instatus NOT LIKE ''%No of Records not imported : 0%''
                AND :pstatus = ''Failed'')
              OR :pstatus = ''ALL'')
         AND (transid LIKE ''%'' || :ptransid || ''%'' OR :ptransid = ''ALL'')
         AND (filename LIKE ''%'' || :pfilename || ''%'' OR :pfilename = ''ALL'')
ORDER BY recdon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxconfv', 'select a.ordno, a.axpexchangeid, a.transid, b.caption as  document, idfield,  
case when adxinout=''o'' then ''Outbound'' else ''Inbound'' end as  inout, ftp, outfolder,    infolder,  
succfolder,  failfolder  from  axpexchange a, tstructs b  where a.transid=b.name  and :a = ''a''    order by A.ORDNO, transid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___red', 'select a.axpdef_ruleengid, 
a.rulename,a.formcaption as form,
case when a.active = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as active, 
case when (a.uroles is not null or length(trim(a.uroles)) > 0) then ''<span style="font-weight:bold;">''||''Roles''||''</span><br/>'' || a.uroles || ''<br/><br/>'' end|| 
case when (a.formula is not null or length(trim(a.formula)) > 0) then ''<span style="font-weight:bold;">''||''Criteria''||''</span><br/>'' || a.formula || ''<br/>'' end criteria, 
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon created,
''<b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated
from axpdef_ruleeng a
where (a.stransid = :ptransid or ''All'' = :ptransid)
ORDER BY a.rulename 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___erc', 'select axentityrelationsid,rtypeui,mstructui,mfieldui,dstructui,a.CAPTION||''-(''||a.FNAME||'')'' DFIELDUI 
from axentityrelations 
join axpflds a on axentityrelations.dfield = a.fname and axentityrelations.dstruct=a.tstruct
join axpflds mf on axentityrelations.mfield = mf.fname and axentityrelations.mstruct=mf.tstruct
where (mstruct = :ptransid or ''All'' = :ptransid)
and rtype =''md''
union all
select axentityrelationsid,rtypeui,mstructui,mfieldui,dstructui,a.DFIELDUI 
from axentityrelations a 
where (mstruct = :ptransid or ''All'' = :ptransid)
and rtype !=''md''
order BY 3,2,4
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___nwa', 'SELECT axpdef_news_eventsid,title,subdetails,EFFECTFROM,EFFECTO,case when active = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as active  FROM axpdef_news_events
ORDER BY EFFECTFROM desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axpcards', 'select axp_cardsid,cardtype,coalesce(charttype,''NA'') charttype,cardname,cachedata ,orderno from axp_cards
order by cardtype,orderno,cardname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___tbd', 'select dname,modifiedon,axp_tabledescriptorid from axp_tabledescriptor order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axlangs', 'select axpdef_languageid,language langname,fontcharset,fontname,fontsize from axpdef_language order by langname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___pth', 'select substr(eventdatetime,1,4)||''-''||substr(eventdatetime,5,2)||''-''||substr(eventdatetime,7,2)
||'' ''||substr(eventdatetime,9,2)||'':''||substr(eventdatetime,11,2)||'':''||substr(eventdatetime,13,2) as eventdatetime,keyvalue,username,processname,taskname,taskstatus,statusreason from axactivetaskstatus a 
where keyvalue  = :pkeyvalue
and processname = :pprocess 
order by eventdatetime
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emaildef', 'select emaildefid,emaildefname,emailwhat,
case when emailwhat =''Tstruct'' then emailform 
when emailwhat in(''IView'',''IView rows'') then emailiview 
end source,
axp_emailto emailto,axp_emailcc emailcc,axp_emailsubject emailsubject,axp_emailattachment emailattachment
from emaildef e 
order by emaildefname 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ivconfdt', 'select distinct configprops,propcode,ptype,
case when caction=''T'' then ''Yes'' else ''No'' end as caction,
case when chyperlink=''T'' then ''Yes'' else ''No'' end  as chyperlink,
case when cfields=''T'' then ''Yes'' else ''No'' end as cfields,
case when alltstructs=''T'' then ''Yes'' else ''No'' end  as alltstructs,
case when alliviews=''T'' then ''Yes'' else ''No'' end  as alliviews,
case when alluserroles=''T'' then ''Yes'' else ''No'' end  as alluserroles
 from axpstructconfigprops
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('dop_list', 'select asprops as Property,propvalue1 as Property_Value, propvalue2 as Property_Info,structcaption as Form_Report,purpose,axpstructconfigid from axpstructconfig
order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_lngst', 'select a.jobdate,a.status,reverse(substring(reverse(a.filename),0,position(''\'' in reverse(a.filename)))) filename,b.remarks from aximpjobs a
left join aximpdatauploadjobs b on a.jobid=b.jobid
where aximpdefname=''Axlanguage'' 
order by jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('publist', 'select cast(createdon as date) createdon,coalesce(publishedby,''NA'') publishedby,coalesce(publishedto,''NA'')publishedto ,substring(string_agg(transid,'',''),1,300)||''..'' details from axpublishreport
group by cast(createdon as date) ,publishedby,publishedto
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('pservers', 'select dwb_publishpropsid,servername,
serverpath,app_connection,
case when inactive=''F'' then ''Active'' else ''In active'' end status
from dwb_publishprops where servertype=''Publish''
order by servername
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('jobtsk', 'select axpdef_jobsid,jobid,jname,jobschedule,status,lastrun,remarks,case when isactive=''T'' then ''Active'' else ''Disabled'' end  as active from axpdef_jobs order by createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('jobcdtl', 'select jobdate ,act_script_name ,aximpdefname,
''Form: ''||b.caption||'' DB Directory: ''||dbdirpath||'' File name: ''||filename adetails,
status,1 ord,''View details'' actn,''iaximpfrc'' ptransid,a.jobid jobid
from aximpjobs a join tstructs b on a.aximptransid =''t''||b.name
where jobid = :pjobid 
union all
select calledon,act_script_name ,axprintdefname,
''Source: ''||case when axprintwhat in(''Form Data'')  then b.caption 
when axprintwhat in(''IView'',''Form Data from IView'') then i.caption
when axprintwhat in(''Form data from SQL'',''SQL Result'') then ''SQL'' end||''| Print forms: ''||a.axprintformnames||''| Download location:''||axprintsaveto||
''| Total records: ''|| a.totallines ||''| Success :''||a.succlines adetails,
status,2,''View details'' actn,''iprnfail'' ptransid,substring(context,7) jobid
 from axprintdetails a
left join tstructs b on a.axprinttransid =b.name
left join iviews i on a.axprintiviewname = i.name
where substring(context,7) = :pjobid 
union all
select calledon , act_script_name , emaildefname,''Total records: ''|| e.totallines ||''| Success :''||e.succlines ,status,3,''View details'' actn,
''iemlexcp'' ptransid,e.id jobid
from emaildetails e
where substring(context,7) = :pjobid 
union all
select starttime,null act_script_name,null apidefname,
''URL :''||url||'' | Service name:''||servicename ||'' | Method: ''||method adetails 
,status,4,''View details'' actn,''iaxapilog'' ptransid,a.schjobid jobid
 from axapijobdetails a 
where jobid = :pjobid 
order by ord,jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__pgal', 'select *, ''dynamic buttons'' dynamicbuttons from vw_pegv2_activetasks 
where lower(touser) = :username
and (lower(processname) = lower( :pprocess) or ''All'' = :pprocess)
and (lower(fromuser) = lower(:pfromuser) or ''All'' = :pfromuser)
and cast(eventdatetime as date) between cast(:pfrom as date) and cast(:pto as date)
order by edatetime desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('hplist', 'select a1.caption as fromCaption ,case when a1.isacoretrans=''No'' then ''hidden'' when a1.isacoretrans=''Yes'' and a1.menuposition=''Default'' then ''root'' when a1.isacoretrans=''Yes'' and a1.menuposition !=''Default'' and a1.menulist !='''' then a1.menulist else ''Not Defined'' end as Modulename,  ''<b>''|| COALESCE(d.cntimg,'''') ||'' '' || case when COALESCE(a2.filedtl,'''')='''' then '''' else  COALESCE(a2.filedtl,'''') || ''</b> Files'' end as detail,''<b>'' || a1.createdBy || ''</b> on '' || a1.createdon as createdBy, ''<b>'' || a1.username || ''</b> on '' || a1.modifiedon as updatedBy ,a1.htmlsectionsid from htmlsections  a1
left join (select string_agg(cnt||'' ''||filetype ,'', '')  as filedtl , htmlsectionsid from 
(select count(filetype) as cnt,filetype,htmlsectionsid from sect4 group by filetype ,htmlsectionsid order by filetype) b
group by b.htmlsectionsid) a2 on a1.htmlsectionsid=a2.htmlsectionsid
left join ( select count(cc)|| '' Image,'' as cntimg,htmlsectionsid from ( 
SELECT regexp_split_to_table(axpfile_hpimages, '','') as cc,htmlsectionsid FROM htmlsections where coalesce(axpfile_hpimages,'''')<>'''') as c
GROUP by htmlsectionsid ) d on a1.htmlsectionsid =d.htmlsectionsid 
order by a1.createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('exapidef', 'select executeapidefid,execapidefname,execapimethod,execapiurl,execapibasedon from executeapidef
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axvars', 'select sourceid,
axvarname,
case when isconstant=''T'' then ''Constant'' when isvariable=''T'' then ''Variable'' when isdbobj=''T'' then ''Get from DB''  when isappparam=''T'' then ''Application Parameter'' end vartype,
case when event_onlogin = ''T''then  ''OnLogin'' 
when event_onformload =''T'' and event_onreportload =''T'' then concat(''OnFormLoad - '',forms)||''</br>''||concat(''OnReportLoad - '',reports) 
when event_onformload =''T'' and event_onreportload =''F'' then concat(''OnFormLoad - '',forms)
when event_onformload =''F'' and event_onreportload =''T'' then concat(''OnReportLoad - '',reports)
end eventdtl,
case when isconstant=''T'' then concat(''Constant: '',vpvalue) 
when isvariable=''T'' then concat(''Var: '',''</br>'',vscript ) 
when isdbobj=''T'' then concat(''DBVar: '',''</br>'',''DBfun='',db_funtion,case when db_funtion_params is not null then concat(''</br>'',''DBfunparam='',db_funtion_params) end) 
when isappparam =''T'' then concat(''VPname: '',axvarname,''</br>'',''Vartype: '',case when isparam=''T'' then ''Parameter'' else ''Variable'' end) end vardtl,
concat(''t'',stransid) stransid
 from axvarcore a 
order by 3,1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axjobs', 'select *,case 
when lower(status) in(''completed'',''inprogress'') then null else   ''View details'' end actn   from axscriptjobs 
where (case 
when lower(status)=''completed'' then ''Success''
when lower(status)=''inprogress'' then ''In progress''
else ''Failed'' end = :pstatus or ''ALL'' = :pstatus)
and jobdate between :pfdate and :ptdate
order by jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximpdef', 'select aximpdefid,AxImpDefName,AxImpform,AxImpProcessMode,AxImpHeaderRows from aximpdef
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('appvars', 'select axp_vpid,vpname from axp_vp order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adi_td', 'select dname,modifiedon,axp_tabledescriptorid from axp_tabledescriptor order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__qls', 'select a.axqueuename,concat(a.axqueuedesc,''</br><b>'',''Forms mapped to this queue: </b>'',case when length(string_agg(t.caption,'','')) > 1 then concat(substring(string_agg(t.caption,'',''),1,75),''...'') else null end)axqueuedesc,''Outbound'' qtype,
''<a title ="Oque" href="tstruct.aspx?transid=a__qm&act=load&axoutqueuesmstid=''||a.axoutqueuesmstid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>''  cmd,
''<a title ="Oqueadd" href="tstruct.aspx?transid=ad__q&act=open&AxQueueName=''||a.axqueuename||''" style="cursor: pointer;"><span class="material-icons ">add</span> </a>''  addcmd
from axoutqueuesmst a left join axoutqueues b on a.axqueuename = b.axqueuename  
left join tstructs t on b.stransid = t.name
group by a.axqueuename,a.axqueuedesc,case when b.active=''T'' then ''Active'' else ''Inactive'' end ,a.axoutqueuesmstid 
union all
select axqueuename,axqueuedesc,''Inbound'' qtype,
''<a title ="Ique" href="tstruct.aspx?transid=a__iq&act=load&axinqueuesid=''||axinqueuesid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd,null
from axinqueues
order by 3,1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ual', 'select axusersid,username, nickname, email, usergroups,actors,adminaccess,
case when COALESCE(active,''T'')=''T'' then ''Yes'' else ''No'' end status
from axusers 
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__qlog', 'select a.createdon,axqueuename,t.caption,substring(queuedata,1,250) queuedata from axinqueuesdata a join tstructs t on a.transid = t.name
where a.axqueuename = :pqueuename
union all
select a.createdon,axqueuename,t.caption,substring(queuedata,1,250) queuedata from axoutqueuesdata a join tstructs t on a.transid = t.name
where a.axqueuename = :pqueuename
order by 1 desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_pgv2', 'select concat(''<b>Desc:</b> ''||c.processdesc,
''</br><b>Tasks:</b> ''||string_agg(taskname,'','' order by b.indexno,b.subindexno)) procdesc,c.processowner,c.powner,c.pownerflg,c.axpdef_peg_processmasterid,
''Add/View'' clm,''<a title="''||c.caption||''" href="processflow.aspx?loadcaption=AxProcessBuilder&processname=''||c.caption||''" style="cursor: pointer;">''||c.caption||''  </a>'' as processname,
''All'' pprocess,''Edit'' actn,''<a title ="Test" href="tstruct.aspx?transid=ad_pm&act=load&axpdef_peg_processmasterid=''||c.axpdef_peg_processmasterid||''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd
from	axprocessdefv2 b right join axpdef_peg_processmaster c on b.processname = c.caption 
where (b.transid = :ptransid or ''All'' = :ptransid)
and (b.processname =:pprocessname or ''All'' =:pprocessname)
group by c.caption,c.processdesc,c.processowner,c.powner,c.pownerflg,c.axpdef_peg_processmasterid
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__prcd', 'select axpdef_prcardsid,cardname,cardtype,charttype from axpdef_prcards order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__pgnt', 'select axnotificationdefid,processname,taskname,name,notifyto,enableemail,enablesms,enablewhatsapp,enablemobilenotify from axnotificationdef
where (processname = :pprocess or ''All''= :pprocess)
order by 2,3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__papi', 'select axpdef_publishapiid,publickey,apitype,structcap,scriptcap,printform,unameui,
''<b>Created by</b> ''||createdby||'' on ''||createdon||''</br><b> Last modified by </b>''||username||'' on ''||modifiedon updated
from axpdef_publishapi order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ugu', 'SELECT u.username  user_name,u.NICKNAME login_name,u.EMAIL,u.MOBILE,ug.grps USERGROUP,u.ACTORS,u.AXUSERSID
FROM AXPDEF_PEG_USERGROUPS a JOIN axusers u ON a.USERNAME=u.USERNAME
join (select username,string_agg(usergroupname,'','') grps from axpdef_peg_usergroups where active=''T''
group by username) ug on a.username = ug.username
WHERE USERGROUPNAME  = :pusergroup AND u.ACTIVE=''T'' 
ORDER BY 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___oqm', 'select axqueuename,b.axqueuesource,t.caption,case when b.active=''T'' then ''Active'' else ''Inactive'' end stats,b.axoutqueuesid,
''<b>Created by </b>''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.username||'' on ''||b.modifiedon updated
from axoutqueues b join tstructs t on b.stransid = t.name
where (b.axqueuename = :pqueuename or ''All'' = :pqueuename)
and (t.name = :ptransid or ''All'' = :ptransid)
union all
select axqueuename,b.axqueuesource, b.datasource,case when b.active=''T'' then ''Active'' else ''Inactive'' end stats,b.axoutqueuesid,
''<b>Created by </b>''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.username||'' on ''||b.modifiedon updated
from axoutqueues b
where (b.axqueuename = :pqueuename or ''All'' = :pqueuename) and 1=2
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ntn', 'select t.caption,a.notifyto,''Form'' notifytype,axformnotifyid recid,''ta__fn''stransid,
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by</b> ''||a.username||'' on ''||a.modifiedon updated
from AxFormNotify a,tstructs t 
where a.stransid =t."name" and (''Form'' = :ptype or ''All'' = :ptype) and (t.name = :ptransid or ''All'' = :ptransid)
union all
select "name",datasource,''Periodic'',axperiodnotifyid,''ta__pn'',
''<b>Created by </b>''||createdby||'' on ''||createdon||''</br><b> Last modified by</b> ''||username||'' on ''||modifiedon updated
from AxPeriodNotify where (''Periodic'' = :ptype or ''All'' = :ptransid )
union all
select "name",notifyto,''PEG'',axnotificationdefid,''tad_pn'',
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br> <b>Last modified by</b> ''||a.username||'' on ''||a.modifiedon updated
from axnotificationdef a 
where (''PEG'' = :ptype or ''All'' = :ptransid)
order by 3,2 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___apt', 'select autoprintid,t.caption,a.printdoc,
''<b>Created by </b>''||a.createdby || '' on '' || a.createdon||''</br><b> Last Modified by </b>''|| a.username || '' on '' || a.modifiedon as modifiedon
,axautoprintsid
from axautoprints a join tstructs t on a.stransid = t.name 
where (t.name = :ptransid or ''All'' = :ptransid)
order by 2,3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_implg', 'select username,calledon,filename,recordcount, greatest(a.success,0) as success,
a.recordcount-greatest(a.success,0) as failed_record,id,''t'' dmyhl 
from importdatadetails a
where structname = :ptransid 
order by calledon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__ugp', 'select a1.users_group_masterid recordid, a1.users_group_name, a1.users_group_description, 
coalesce( a2.cnt,0 ) as usersongroups,
case when a1.isactive = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as isactive
from users_group_master a1
left outer join (select a.users_group_name, count(1) as cnt
from
(select unnest(string_to_array(b.consolidated_usergroups, '','')) as users_group_name
from users_logindetails b where b.isactive = ''T'' and b.cancel = ''F'') a
group by a.users_group_name
) a2
on ( a1.users_group_name = a2.users_group_name)
where 1 = 1  and
a1.cancel = ''F'' 
order by a1.users_group_name
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_txalg', 'select recordid,modifieddate,username,fieldname,fieldcaption,
case 
when newrecord=''t''  then ''New'' 
when delrec = ''t'' then ''Deleted''
when cancelrec = ''t'' then ''Cancelled''
when newrecord=''f'' and delrec=''f'' and cancelrec=''f'' then ''Modification'' end newrecord,
oldvalue,newvalue,cancelremarks,docid 
from fn_axp_auditlog( :ptransid,cast(:pfromdate as date) ,cast(:ptodate as date))
order by modifieddate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__alog', 'SELECT * from fn_axp_auditlog(''histt'',current_date,current_date)
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___cfd', 'select null dmy,b.fname ,b.caption  fcaption,a.caption ,a.name,a.runtimetstruct,a.runtimemod 
from tstructs a,axpflds b
where a.name = b.tstruct 
and a.runtimemod=''T''
and b.runtimefld=''T''
order by 3,2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___acs', 'select null dmy,name,caption,runtimetstruct,runtimemod from tstructs
where runtimetstruct=''T'' and runtimemod=''T''
order by 1,2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emlexcp', 'select case when e.transid is null and iviewname is null then emaildet 
when e.transid is null then i.caption 
when e.iviewname  is null then b.caption end source,lineno,errormsg from emailexceptiondetails e 
left join tstructs  b on e.transid  = b."name" 
left join iviews i on e.iviewname=i."name" 
where e.id  = :pjobid
order by lineno
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('prnfail', 'select case when a.transid is null then iviewname 
when a.iviewname  is null then a.transid end source, formnames,filename,lineno,errormsg from axprintexceptiondetails a
left join tstructs b on a.transid = b.name
left join iviews i on iviewname = i.name
where id = :pjobid
order by lineno
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('printlog', 'select id,calledon,username,act_script_name,axprintdefname,axprintwhat,
case when axprintwhat in(''Form Data'')  then b.caption 
when axprintwhat in(''IView'',''Form Data from IView'') then i.caption
when axprintwhat in(''Form data from SQL'',''SQL Result'') then ''SQL'' end source,
axprintformnames,axprintsaveto,status,''View details'' actn
from axprintdetails a
left join tstructs  b on a.axprinttransid = b."name" 
left join iviews i on a.axprintiviewname = i.name
where a.calledon between :pfdate and :ptdate
order by calledon desc,id
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('thint', 'select a1.axtstructhintid as recordid,a1.caption_tstruct, a1.rtf_hint from axtstructhint a1   order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('smslog', 'select recordid jobid, trunc(createdon) jobdate, mobileno mobilenumber, substr(msg,1,80)+''...'' msg, 
to_char(senton) as senton, case when status=1 then ''Success'' when status=0 then ''Pending'' else 
remarks end errormessage from 
axsms where to_date(createdon)=:asondate order by jobid 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('response', 'SELECT rname,substring(string_agg(case when stype=''t''  then t.caption
when stype =''i'' then i.caption end,'',''),1,150)||''...'' sname FROM axuseraccess a
left join tstructs t on a.sname  = t.name
left join iviews i on a.sname  = i.name
group by rname
order by rname 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('loview1', 'select axlovid, group_name, value_name, identifier, case when activeyes=''T'' then ''Yes'' else ''No'' end as active 
from axlov
where COALESCE(activeyes,''T'')=''T''
order by group_name, disp_order
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ivhelpto', 'select module,topic,axphelpdocsid
 from axphelpdocs  
 order by module,topic
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('itimtk', 'SELECT  U.OBJECT_NAME, U.TOT_COUNT, U.COUNT_8S, 
   U.COUNT_30S, U.COUNT_90S, U.MIN_TIME, 
   U.MAX_TIME, U.AVG_TIME
FROM UT_TIMETAKEN U
where  executed_date = :fdate
and object_type=''tstruct''
order by object_name
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('inmemdb', '  SELECT  distinct name AS TName, ftype,  CASE
                         WHEN ftype = ''General'' THEN caption
                         WHEN ftype = ''ALL'' THEN caption
                         ELSE caption
                      END
                         AS caption, TotalKeys, keysize, keys
    FROM (SELECT  distinct name, caption, ''Form'' ftype, ''0'' TotalKeys, ''0'' keysize, ''keys'' keys
            FROM tstructs
           WHERE (:fldtype = ''Tstructs'' OR :fldtype = ''ALL'')
                 AND (caption = :cap OR :cap = ''ALL'')
          UNION
          SELECT  distinct i.name, i.caption, ''Report/List'' AS ftype, ''0'' TotalKeys, ''0'' keysize, ''keys'' keys
            FROM iviews i
           WHERE (:fldtype = ''Iviews'' OR :fldtype = ''ALL'')
                 AND (caption = :cap OR :cap = ''ALL'')

) a
ORDER BY ftype
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('imobc', 'SELECT a1.axmpagehdrid ,
               a1.struct_type Page_type,
         a1.menu_caption Page_name
            FROM axmpagehdr a1
 ORDER BY a1.modifiedon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ikywd', ' select axpmsgkeywordsid,a1.templatename from axpmsgkeywords a1 
   order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('idsco', 'SELECT a1.dsignconfigid as recordid,
       a1.transname,
       a1.stransid,
       a1.tunique,
       a1.docname
      FROM dsignconfig a1
      order by a1.transname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('iaxpscon', 'select a1.axpstructconfigid recordid,a1.stype, a1.structname, a1.context, a1.sfield, a1.icolumn, a1.sbutton, a1.hlink, a1.props, a1.propsval, a1.userroles from axpstructconfig a1 
    order by stype,structname
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('iaxex', 'select EXP_DATE, STRUCTNAME, SERVICENAME, 
   SERVICERESULT, COUNT from axpexception
   where EXP_DATE = :fdate 
order by count desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('esmsco', 'SELECT a1.sendmsgid as recordid,
             a1.docid,
       a1.currdate,
       a1.template,
       a1.msgsubject,
        a1.smsmsg
  FROM sendmsg a1
 order by a1.modifiedon  DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('emaillog', 'select substring(context,7),calledon,emaildefname ,act_script_name,
case when totallines = succlines then ''Success'' 
when succlines = 0 then ''Failed''
else ''Partial success'' end status,id,''View details'' actn
from emaildetails 
where calledon between :pfdate and :ptdate
order by calledon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('dmlscrpt', 'select axpscriptrunnerid, script_id, script_date, script_type, script_purpose, substr(script_text,1,30)||''....''   as sqltext,rows_affected  from axpscriptrunner order by script_id
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('cerrm', 'SELECT 
   A.CONSTRAINT_NAME, 
   A.MSG
FROM  AXCONSTRAINTS A
order by   A.CONSTRAINT_NAME
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axusracc', 'select distinct a1.rname, A2.CAPTION, a1.sname, ''Page'' stype from axuseraccess a1, axpages a2
where a1.sname = A2.NAME 
and stype=''p''
union all
select distinct a1.rname, A3.CAPTION,a1.sname, ''Tstruct'' stype from axuseraccess a1, tstructs a3 
where   a1.sname=A3.NAME
and stype=''t''
union all
select distinct a1.rname, a4.CAPTION,a1.sname, ''Iview'' stype from axuseraccess a1,  iviews a4
where  A1.SNAME=a4.name 
 and stype=''i'' 
order by rname, caption
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axroles', 'select axusergroupsid, groupname, userroles from axusergroups where groupname <> ''admin''
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axpfinhs', ' select a.username, c.caption, a.calledon as dd,a.filename, a.success from importdatadetails a 
join tstructs c on a.structname= c.name
left outer join  importdataexceptions b on  a.sessionid= b.sessionid
  where   a.calledon between :fromdate and :todate
and  (c.caption = :strut or ''ALL'' = :strut)
order by 3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axnxtlst', 'select axintelliviewdetid, repid, ivname, companyname, reportname,reporttype  from axintelliviewdet
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximplog', 'select jobid,jobdate,aximpdefname,act_script_name ,b.caption form,aximpprocessmode,a.username,status,sessionid,to_char( jobdate,''dd/MM/yyyy HH24:mi:ss'') pcjdate, ''View details'' actn from aximpjobs a 
left join tstructs b on a.aximptransid = ''t''||b.name
where cast(to_char(a.jobdate,''dd/mm/yyyy'') as date)between :pfdate and :ptdate
order by jobdate desc,jobid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('aximpfrc', 'select primaryfield,status errmsg,createdon from aximpfailedrecords a2 
where jobid = :pjobid
order by createdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axfinyrs', 'select financialyearid, finyr, A.FINYRIDENTIFIER, A.STARTDATE, A.ENDDATE, case when A.CURRENTFINYR =''T'' then ''Yes'' else ''No'' end as iscurrentfinyr from financialyear a
where active=''T'' order by iscurrentfinyr desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axemllog', '  SELECT jobid,
         jobdate,
         mailto,
         mailcc,
         subject,
         SUBSTR (body, 1, 80) || ''...'' AS body,
         senton,
         CASE
            WHEN status = 1 THEN ''Success''
            WHEN status = 0 THEN ''Pending''
            ELSE errormessage
         END
            errormessage
    FROM axp_mailjobs
   WHERE (mailto IS NOT NULL OR mailto <> '''') AND jobdate = :asondate
         AND (UPPER (subject) LIKE ''%'' || UPPER (:psubject) || ''%''
              OR UPPER (:psubject) = ''ALL'')
         AND ( (CASE
                   WHEN status = 1 THEN ''SUCCESS''
                   WHEN status = 0 THEN ''PENDING''
                   ELSE ''FAILURE''
                END) = UPPER (:pstatus)
              OR UPPER (:pstatus) = ''ALL'')
         AND ( (CASE
                   WHEN iviewname IS NOT NULL THEN ''Report''
                   WHEN transid IS NOT NULL THEN ''Document''
                   ELSE ''Alert''
                END) = :petype)
         AND mailto IS NOT NULL
         AND subject IS NOT NULL
         AND mailto <> ''''
         AND subject <> ''''
ORDER BY jobid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axchtdtl', 'SELECT a1.axp_chartconfigid as recordid,
         a1.title,
         a1.subtitle,
         a1.graphtype,
         a1.piecolor, 
         a1.linkname,
         a1.sqltext,
         a1.hyptext,
         a1.flinkname
    FROM axp_chartconfig a1
ORDER BY a1.modifiedon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axapilog', 'select schjobid,act_script_name,servicename,method,starttime,endtime ,status from axapijobdetails a 
where starttime  between :pfdate and :ptdate
order by starttime  desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('auditlog', 'select * from axaudit
where username = :usernam or  :usernam =''ALL''
and cast(to_char(logintime,''dd/mm/yyyy'') as date)  between cast(to_char( :fromdt,''dd/mm/yyyy'') as date)  and  cast(to_char(  :todt,''dd/mm/yyyy'') as date)
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('applogsm', 'select title, executeddate as pivotcol, cnt from usagedtl 
where executeddate between :fromdt and :todt 
order by title, pivotcol 
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxoutlo', 'select filename, senton recdon, transid, tstructname, outstatus from ax_outbound_status  where  outdate= :asondt or  senton is null order    by recdon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxinlog', '  SELECT filename,
         recdon,
         transid,
         tstructname,
         instatus
    FROM ax_inbound_status
   WHERE indate = :asondt
         AND ( (instatus NOT LIKE ''%No of Records not imported : 0%''
                AND :pstatus = ''Failed'')
              OR :pstatus = ''ALL'')
         AND (transid LIKE ''%'' || :ptransid || ''%'' OR :ptransid = ''ALL'')
         AND (filename LIKE ''%'' || :pfilename || ''%'' OR :pfilename = ''ALL'')
ORDER BY recdon DESC
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('adxconfv', 'select a.ordno, a.axpexchangeid, a.transid, b.caption as  document, idfield,  
case when adxinout=''o'' then ''Outbound'' else ''Inbound'' end as  inout, ftp, outfolder,    infolder,  
succfolder,  failfolder  from  axpexchange a, tstructs b  where a.transid=b.name  and :a = ''a''    order by A.ORDNO, transid
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___fpr', 'select null editable,''DC'' ctypre,a.name ntransid, a.caption fcaption, b.dname cname,concat(b.caption,''('',b.dname,'')'') ccaption, 
concat(''<span style="font-weight:bold;">'',''Caption - '',''</span>'' , concat(b.caption,''-('',b.dname,'')''), ''<br/>'' ,
case when b.asgrid = ''T'' then ''(Grid DC)'' else '' '' end,
''<span style="font-weight:bold;">'',''Saving to Table '',''</span>'', b.tablename,''<br/>'') as cprops,NULL datarule,NULL validrule,b.dname,
b.dcno ordno,1 lord,null editcmd,a.caption||''-(''||a.name||'')'' fparams,
''<b>Created by</b> ''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.modifiedby||'' on ''||b.modifiedon updated,
null editcmdtransid,0 editcmdrecid
from tstructs a join  axpdc b on b.tstruct = a.name 
where a.name = :ptransid 
union all
select runtimefld editable,''Field'' ctypre,a.name, a.caption, c.fname cname, concat(c.caption,''('',c.fname,'')'')  ccaption, 
concat(''<span style="font-weight:bold;">'',
case when c.runtimefld =''T'' then ''Runtime'' else ''Developer'' end|| ''<br/>'',''Field type - '',''</span>'', c.customdatatype,''<br/>'',
''<span style="font-weight:bold;">''||''Data type and Width - '',''</span>'',concat(case "datatype" when ''c'' then ''Character''  
when ''d'' then ''Date'' when ''i'' then ''Image'' when ''t'' then ''Text'' when ''n'' then ''Numeric'' end,''('',case when datatype=''n'' 
then concat(cast(datawidth as varchar(5)),'','',cast(flddecimal as varchar(5))) else cast(datawidth  as varchar(10)) end,'')'' ),''<br/>'') fdesc,
concat(coalesce(case when c.readonly = ''T'' then  ''<span style="font-weight:bold;">''||''ReadOnly ''||''</span><br/>'' || ''''|| ''<br/>'' end,''''),
coalesce(case when c.hidden= ''T'' then ''<span style="font-weight:bold;">''||''Hidden''||''</span><br/>'' ||''''|| ''<br/>'' end,''''),
coalesce(''<span style="font-weight:bold;">''||case when c.allowempty= ''F'' then ''Mandatory'' else '''' end||''</span><br/>'' ||''''|| ''<br/>'' ,''''),
coalesce(case when c.mask is not null then ''<span style="font-weight:bold;">''||''Mask ''||''</span><br/>''|| c.mask||'' <br/>'' end,''''),
coalesce(''<span style="font-weight:bold;">''||case when c.allowduplicate= ''F'' then ''Unique''||''</span><br/>'' ||''''|| ''<br/>'' end ,'''')
) datarule,
concat(coalesce(case when c.expression is not null then ''<span style="font-weight:bold;">''||''Expression ''||''</span><br/>'' || c.expression || ''<br/>'' end,''''),
coalesce(case when c.valexpr is not null then ''<span style="font-weight:bold;">''||''Validation  ''||''</span><br/>'' || c.valexpr || ''<br/>'' end,'' '')) validrule,
c.dcname,c.ordno,2 lord,null editcmd,a.caption||''-(''||a.name||'')'' fparams,
''<b>Created by</b> ''||c.createdby||'' on ''||c.createdon||''</br><b> Last modified by </b>''||c.modifiedby||'' on ''||c.modifiedon updated,null editcmdtransid,0 editcmdrecid
from tstructs a 
join axpflds c on a.name = c.tstruct  
where a.name = :ptransid 
union all
select null editable,''Fillgrid'' ctypre,t.name,t.caption, a.fgname,concat(a.caption,''('',a.fgname,'')''),
concat(''<span style="font-weight:bold;">'',''Target DC - '',''</span>'' , ''dc''||tardc, ''<br/>'' ,
''<span style="font-weight:bold;">'',''Data source - '',''</span>'', case when a.srcdc = ''0'' then ''SQL'' else ''dc''||a.srcdc end,''<br/>'',
''<span style="font-weight:bold;">'',''Autoshow - '',''</span>'', case when a.autoshow = ''T'' then ''Yes'' else ''No'' end, ''<br/>'',
''<span style="font-weight:bold;">'',''Multiselect - '',''</span>'', case when a.multiselect = ''T'' then ''Yes'' else ''No'' end, ''<br/>''
) as cprops,null,null,''z100'',1,3,null editcmd,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.modifiedby||'' on ''||a.modifiedon updated,null editcmdtransid,0 editcmdrecid
from axpfillgrid a join tstructs t on a.tstruct =t.name  and t.name = :ptransid
union all
select null editable,''MDMAP'' ctypre,t.name,t.caption, a.mname,concat(a.caption,''('',a.mname,'')''),
 concat(''<span style="font-weight:bold;">'',''Master form - '',''</span>'' , mt.caption||''-(''||mt."name"||'')'' , ''<br/>'' ,
''<span style="font-weight:bold;">'',''Master field - '',''</span>'',muf.caption||''-(''||muf.fname||'')'' ,''<br/>'',
''<span style="font-weight:bold;">'',''Detail field - '',''</span>'',duf.caption||''-(''||duf.fname||'')'' ,''<br/>'',
''<span style="font-weight:bold;">'',''Master search field -  '',''</span>'',CASE WHEN msf.fname IS NULL THEN ''Default'' ELSE  coalesce(msf.caption||''-(''||msf.fname||'')'',a.msrcfld) end, ''<br/>'',
''<span style="font-weight:bold;">'',''Detail search field - '',''</span>'',coalesce(dsf.caption||''-(''||dsf.fname||'')'',a.dtlsrcfld)
) as cprops,null,null,''z100'',1,4,null editcmd,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.modifiedby||'' on ''||a.modifiedon updated,null editcmdtransid,0 editcmdrecid
from axpmdmaps a join tstructs t on a.tstruct =t.name and t.name = :ptransid
join tstructs mt on a.mastrans = mt.name
join axpflds muf on a.masfld = muf.fname and a.mastrans = muf.tstruct 
left join axpflds msf on a.msrcfld = msf.fname and a.mastrans = msf.tstruct 
join axpflds duf on a.detfld = duf.fname and a.tstruct = duf.tstruct
left join axpflds dsf on a.dtlsrcfld = dsf.fname and a.tstruct = dsf.tstruct
union all
select null editable,''Genmap'',t.name,t.caption fcaption, a.gname,concat(a.caption,''('',a.gname,'')''),
concat(''<span style="font-weight:bold;">'',''Target form - '',''</span>'' , tt.caption||''-(''||tt.name||'')'', ''<br/>'' ,
''<span style="font-weight:bold;">'',''Based on - '',''</span>'', basedondc,''<br/>'',
''<span style="font-weight:bold;">'',''Control fieldname'',''</span>'', a.ctrlfldname , ''<br/>'') as cprops,null,null,''z100'',1,5,null editcmd,
t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.modifiedby||'' on ''||a.modifiedon updated,
null editcmdtransid,0 editcmdrecid
from axpgenmaps a join tstructs t on a.tstruct =t.name  and t.name = :ptransid
join tstructs tt on a.targettstr = tt.name
union all
SELECT null editable,''Script'',t.name,t.caption,a.name,a.caption||''(''||a.name||'')'',
''<span style="font-weight:bold;">''||''Form control - ''||''</span>'' || ''dc''||control_type || ''<br/>'' ||
''<span style="font-weight:bold;">''||''Script - ''||''</span>'' || ''dc''||a.script|| ''<br/>'' ||
''<span style="font-weight:bold;">''||''Event - ''||''</span>'' || ''dc''||"event" || ''<br/>'',NULL,NULL,
''z100'',1,6,t.caption||''-(''||t.name||'')'' fparams,null editcmd,
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,
null editcmdtransid,0 editcmdrecid
FROM tstructSCRIPTs a join tstructs t on a.name =t.name and t.name = :ptransid
union all
select null editable,''Rule'',t.name,t.caption,rulename,rulename,  
concat(''<span style="font-weight:bold;">'',''<b>Applicable Userroles - </b>'',''</span>'',uroles,''<br/>'',
''<span style="font-weight:bold;">'',''<b>'',case when a.readonly =''T'' then ''ReadOnly'' else ''Editable'' end,''</b></span><br/>'',
''<span style="font-weight:bold;">'',''<b>Cached save - </b>'',''</span>'',case when a.cachedsave=''T'' then ''Yes'' else ''No'' end ,''<br/>'',
''<span style="font-weight:bold;">'',''<b>'',case when active=''T'' then ''Active'' else ''Inactive'' end,''</b></span><br/>'') props,null,null,''z100'',1,7,
''<a title ="editi" href="tstruct.aspx?transid=ad_re&act=load&axpdef_ruleengid='' || a.axpdef_ruleengid || ''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd,
t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,''tad_re'' editcmdtransid,axpdef_ruleengid editcmdrecid
from axpdef_ruleeng a join tstructs t on a.stransid = t.name and t.name = :ptransid
union all
select null editable,''Auto Print'',t.name ntransid,a.cancel, a.autoprintid,a.autoprintid,
concat(''<span style="font-weight:bold;">'',''<b>Form - </b>'',''</span>'',form,''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Direct Print - </b>'',''</span>'',case when directprint = ''T'' then ''Yes'' else ''No'' end,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Fast print - </b>'',''</span>'' ,printdoc,''<br/>''),null,null ,''z100'',1,9,
''<a title ="editi" href="tstruct.aspx?transid=a__ap&act=load&axautoprintsid='' || a.axautoprintsid || ''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd
,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,''ta__ap'' editcmdtransid,axautoprintsid editcmdrecid
from axautoprints a join tstructs t on a.stransid =t.name and t.name = :ptransid
union all
select null editable,''Form Notification'',t.name ntransid,t.caption,a.form,a.form,
concat(''<span style="font-weight:bold;">'',''<b>Notify to - </b>'',''</span>'',notifyto,''<br/>'',''<span style="font-weight:bold;">'',''<b>'',''</span>'',case when active=''T'' then ''Active'' else ''Inactive'' end,''</b><br/>'') props,null,null,''z100'',1,10,
''<a title ="editi" href="tstruct.aspx?transid=a__fn&act=load&AxFormNotifyid='' || a.AxFormNotifyid || ''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd
,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,
''ta__fn'' editcmdtransid,AxFormNotifyid editcmdrecid
 from   AxFormNotify a join tstructs t on a.stransid =t.name and t.name = :ptransid
union all
select null editable,''Process definition'',t.name,t.caption,
''<a title="''||a.TASKNAME||''" href="processflow.aspx?loadcaption=AxProcessBuilder&processname=''||a.processname||''" style="cursor: pointer;">''||a.TASKNAME||''  </a>''TASKNAME,a.processname , 
concat(''<span style="font-weight:bold;">'',''<b>Task type - </b>'',''</span>'',tasktype,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Keyfield - </b>'',''</span>'',KEYFIELDCAPTION,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Assign to- </b>'',''</span>'',ASSIGNTO,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Keyfield - </b>'',''</span>'',KEYFIELDCAPTION,''<br/>'') props,
NULL,NULL,''z100'',1,11,null editcmd,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,
null editcmdtransid,AXPROCESSDEFV2id editcmdrecid
 from   AXPROCESSDEFV2 a join tstructs t on a.transid =t.name and t.name = :ptransid
union all
select null editable,''Outbound queue'',t.name ntransid,t.caption, a.axqueuename ,a.axqueuename,
concat(''<span style="font-weight:bold;">'',''<b>Fields - </b>'',''</span>'',case when a.allfields=''T'' then ''All'' else ''Selected'' end ,''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Primary field - </b>'',''</span>'',pf.caption||''-(''||pf.fname||'')'',''<br/>'',
''<span style="font-weight:bold;">'',''<b>Print forms - </b>'',''</span>'' ,a.printforms ,''<br/>''),null,null ,''z100'',1,12,
''<a title ="editi" href="tstruct.aspx?transid=ad__q&act=load&axoutqueuesid='' || a.axoutqueuesid || ''" style="cursor: pointer;"><span class="material-icons ">edit</span> </a>'' cmd
,t.caption||''-(''||t.name||'')'' fparams,
''<b>Created by</b> ''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.username||'' on ''||a.modifiedon updated,''tad__q'' editcmdtransid,axoutqueuesid editcmdrecid
from axoutqueues a  
left join axpflds pf on a.primaryfield = pf.fname and pf.tstruct = a.stransid  
join tstructs t on a.stransid =t.name
and a.stransid = :ptransid
order by dname,lord, ordno
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad_pbcs', 'select * from 
(select ''PEG'' cnd,caption,axpdef_peg_processmasterid recordid,''pe''||caption pname,null props from axpdef_peg_processmaster
union all
select ''Publish API'',publickey,axpdef_publishapiid recordid,''pa''||publickey publishname,
concat(''<span style="font-weight:bold;">'',''<b>API type - </b>'',''</span><'' ,apitype ,''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Object name - </b>'',''</span>'',coalesce(structcapui,objdatasrc) ,''<br/>'') props
from axpdef_publishapi
union all
select ''Rule'',rulename,axpdef_ruleengid,''ru''||rulename,  
concat(''<span style="font-weight:bold;">'',''<b>Form - </b>'',''</span>'',formcaption,''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Applicable Userroles - </b>'',''</span>'',uroles,''<br/>'') props
from axpdef_ruleeng
union all
select ''Auto Print'',autoprintid,axautoprintsid,''au''||autoprintid ,
concat(''<span style="font-weight:bold;">'',''<b>Form - </b>'',''</span>'',form,''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Direct Print - </b>'',''</span>'',case when directprint = ''T'' then ''Yes'' else ''No'' end,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Fast print - </b>'',''</span>'' ,fp_name,''<br/>'') from axautoprints 
union all 
select ''Periodic Notification'',name,axperiodnotifyid,''pn''||name, 
concat(''<span style="font-weight:bold;">'',''<b>Frequency - </b>'',''</span>'',concat(frequency,'' '',sendday,'' '',sendon,'' at '',sendtime),''<br/>'', 
''<span style="font-weight:bold;">'',''<b>Data source -  </b>'',''</span>'',datasource ,''<br/>'',
''<span style="font-weight:bold;">'',''<b>Notify to -  </b>'',''</span>'',notifyto ,''<br/>'') props
from   AxPeriodNotify
union all
select ''Form Notification'',form,AxFormNotifyid,''fn''||form,
concat(''<span style="font-weight:bold;">'',''<b>Notify to - </b>'',''</span>'',notifyto,''<br/>'') props
 from   AxFormNotify
)a
order by 1,2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axpubls', 'select a.*,b.publishedon from 
(select distinct ''Tstruct'' ftype,b.name,b.caption,cast(b.updatedon as varchar(30)) updatedon,1 ord,concat(''ts'',name) pname,''Axpert'' objtype  from 
tstructs b
union all
select distinct''Iview'' ftype,a.name,a.caption,cast(a.updatedon as varchar(30)) updatedon,2 ord,concat(''iv'',a.name) pname,''Axpert'' objtype from iviews a
union all
select distinct ''Responsibility'',rname,null,cast(updatedon as varchar(30)) updatedon,3 ord,concat(''rs'',rname) pname,''Axpert'' objtype from axuseraccess 
union all
select ''Roles'' ftype,groupname,null,null,4 ord,concat(''rl'',groupname) pname,''Axpert'' objtype from axusergroups
union all
select ''Workflow'' ftype,name,caption,cast(updatedon as varchar(30)) updatedon,6 ord,concat(''wf'',name) pname,''Axpert'' objtype from axworkflow
union all
select ''Cards'',cardname,cardtype,cast(modifiedon as varchar(30)) ,7,concat(''cd'',cardname),''Axpert'' objtype from axp_cards
union all
select ''Pages'',name,caption,cast(updatedon as varchar(30)) updatedon,8,concat(''pg'',name),''Axpert'' objtype from axpages
union all
select ''Fast Report'',caption,transid,null updatedon,9,concat(''fr'',caption),''Axpert'' objtype from axfastlink a2 
union all
select ''Jobs'',jobid,jname,cast(modifiedon as varchar(30)) ,10,concat(''sc'',jobid),''Axpert'' objtype from  axpdef_jobs
union all
select ''View'',table_name,null,null,11,concat(''dv'',table_name ),''DB'' objtype from INFORMATION_SCHEMA.views 
WHERE table_schema = ANY (current_schemas(false)) 
union all
select ''Materialized View'',matviewname,null,null,12,concat(''dv'',matviewname),''DB'' objtype from pg_catalog.pg_matviews pm 
WHERE schemaname = ANY (current_schemas(false)) 
union all
select ''Function'',a.proname,null,null,13,concat(''df'',proname ),''DB'' objtype from pg_catalog.pg_proc a join pg_catalog.pg_namespace b 
on a.pronamespace =b.oid 
where b.nspname = ANY (current_schemas(false))
union all 
select ''Trigger'',trigger_name ,null,null,14,concat(''dt'',trigger_name ),''DB'' objtype from information_schema.triggers t 
WHERE trigger_schema = ANY (current_schemas(false)) 
union all 
select ''Index'',indexname ,null,null,15,concat(''di'',indexname ),''DB'' objtype from pg_catalog.pg_indexes t 
WHERE schemaname = ANY (current_schemas(false)) 
union all
select ''Sequence'',sequence_name,null,null,16,concat(''ds'',sequence_name),''DB'' objtype from information_schema."sequences" s
where sequence_schema= ANY (current_schemas(false))
union all
select ''API Definition'',execapidefname,null,null,17,concat(''ap'',execapidefname),''Axpert'' objtype from executeapidef
union all
select ''Import Definition'',aximpdefname,null,null,18,concat(''im'',aximpdefname),''Axpert'' objtype from aximpdef
union all
select ''Email Definition'',emaildefname,null,null,19,concat(''em'',emaildefname),''Axpert'' objtype from emaildef
)a 
left join (select transtype||transid transid,max(publishedon) publishedon from axpublishreport where status=''Published'' group by transtype||transid ) b on a.pname = b.transid
where (a.objtype = :pobjtype or ''All'' = :pobjtype)
order by ord,name
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('csqlist', 'select sqlname, modifiedon,Axdirectsqlid ,
concat(''<b>Created by </b>''||createdby||'' on ''||createdon,
''</br><b>Last modified by </b>''||username||'' on ''||modifiedon,''</br>'',
case when cachedata=''T'' then ''<b>Data cached</b>'' else ''<b>Data not cached</b>''end,
case when cachedata=''T'' then ''</br><b>Refresh interval-</b>''||cacheinterval end
) dtls
from Axdirectsql
where cancel =''F''  
order by modifiedon desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('cdlist', 'select typename dname,datatype,width,dwidth, case when isactive=''T'' then ''Active'' else ''Disabled'' end status,axp_customdatatypeid,spldatatype from axp_customdatatype order by typename
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___rla', 'select name, CAPTION, ''Page'' stype from axpages a2 join axuserlevelgroups a on a.usergroup =''default'' and a.username =:pusername
union
select name, CAPTION, ''Tstruct'' stype from tstructs a2 join axuserlevelgroups a on a.usergroup =''default'' and a.username = :pusername
union
select name, CAPTION, ''Iview'' stype from iviews a2 join axuserlevelgroups a on a.usergroup =''default'' and a.username = :pusername
union
select p.name,p.caption,''Page'' from axusers u join axuserlevelgroups a on u.axusersid=a.axusersid 
join axusergroups a2 on a2.groupname = a.axusergroup 
join axusergroupsdetail a3 on a2.axusergroupsid =a3.axusergroupsid 
join axuseraccess a4 on a4.rname = a3.roles_id and a4.stype=''p'' 
join axpages p on a4.sname = p.name 
and u.username = :pusername 
union
select t.name,t.caption,''Tstruct'' from axusers u join axuserlevelgroups a on u.axusersid=a.axusersid 
join axusergroups a2 on a2.groupname = a.axusergroup 
join axusergroupsdetail a3 on a2.axusergroupsid =a3.axusergroupsid 
join axuseraccess a4 on a4.rname = a3.roles_id and a4.stype=''t'' 
join tstructs t on a4.sname = t.name 
and u.username = :pusername
union
select i.name,i.caption,''Iview'' from axusers u join axuserlevelgroups a on u.axusersid=a.axusersid 
join axusergroups a2 on a2.groupname = a.axusergroup 
join axusergroupsdetail a3 on a2.axusergroupsid =a3.axusergroupsid 
join axuseraccess a4 on a4.rname = a3.roles_id  and a4.stype=''i''
join iviews i on a4.sname = i.name 
and u.username = :pusername
order by caption,stype
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ubr', 'select u.axusersid, u.username,u.nickname,u.email,u.mobile,case when u.active=''T'' then ''Yes'' else ''No'' end active
from axuserlevelgroups a join axusers u on a.axusersid =u.axusersid 
where a.usergroup  = :pusergroup
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ugp', 'select axpdef_usergroupsid,users_group_name,coalesce(b.users,0),
case when au.isactive = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as isactive from axpdef_usergroups au left join (select ugrp,count(user_name) users from (
select usergroupname ugrp,username user_name  from axpdef_peg_usergroups where active =''T'')a 
group by ugrp)b on au.users_group_name = b.ugrp
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___upg', 'select b.axgroupingid,a.grpname,b.grpvalue,concat(b.grpparent,''-'',pd.grpcaption,''('',pd.grpname,'')'') parentgrp, a.axgroupingmstid 
from axgroupingmst a 
left join axgrouping b on a.grpname = b.grpnamedb 
left join axgroupingmst pd on a.parentgrp = pd.grpname
order by 2,3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___ups', 'select  a.axpermissionsid,b.groupname, coalesce(b.caption,b.sname) formcap,coalesce(a.allowcreate,''Yes'') allowcreate,
coalesce(a.viewdlts,''All'')viewdlts,coalesce(editdlts,''All'') editdlts,
b.sname,concat(b.caption,''-('',b.sname,'')'') capui,''Form'' comptype,b.stype,
case b.stype when ''t'' then ''Form'' when ''i'' then ''Report'' when ''p'' then ''Page'' else null end stypeui,
case when b.stype=''t'' then ''aperm,Add permission,script,build_circle'' end AxRowOptions,
case when b.stype=''t'' then ''Configure'' end perm
from (
select  b.axpermissionsid recordid,b.axpermissionsid,b.axusername ,b.axuserrole ,b.formcap,coalesce(b.allowcreate,''Yes'') allowcreate,
	case b.viewctrl when ''0'' then ''All'' 
	when ''1'' then ''View these fields - ''||view_flds 
	when ''2'' then ''View exclude these fields - ''||view_flds 
	when ''4'' then ''No access'' else ''All'' end viewdlts,	
	case b.editctrl when ''0'' then ''All'' 
	when ''1'' then ''Edit these fields - ''||edit_flds 
	when ''2'' then ''Edit exclude these fields ''||edit_flds
	when ''4'' then ''No access'' else ''All'' end editdlts ,b.formtransid 	
from  axpermissions b where  b.axuserrole =:prole and ''Form'' =b.comptype)a
right join (select distinct sname,caption,groupname,stype from vw_username_role_menu_access where groupname=:prole
and (stype =case :pstype when ''Form'' then ''t'' when ''Report'' then ''i'' when ''Page'' then ''p'' end or ''All'' = :pstype)) b on 
b.sname = a.formtransid 
union all
select a.axpermissionsid,:prole, b.sqlname formcap,''NA'' allowcreate,
coalesce(a.viewdlts,''All'')viewdlts,''NA'' editdlts,
sqlname sname,sqlname capui,''ADS'' comptype,null stype,''ADS'' stypeui,
''aperm,Setup permission,script,build_circle'' AxRowOptions,''Configure'' perm from
(
select  p.axpermissionsid recordid, p.axpermissionsid,p.axusername,axuserrole groupname, p.formcap,
case p.viewctrl when ''0'' then ''All'' 
	when ''1'' then ''View these fields - ''||view_flds 
	when ''2'' then ''View exclude these fields - ''||view_flds 
	when ''4'' then ''No access'' else ''All'' end viewdlts
from axpermissions p 
where  p.comptype =''ADS'' and p.axuserrole = :prole)a
right join(select sqlname from axdirectsql)b on a.formcap=b.sqlname
where (:pstype =''ADS'' or ''All'' = :pstype)
order by 4
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___url', 'select a.groupname,coalesce(case when a.groupname=''default'' then ''default'' else substring(string_agg(case when stype=''t''  then t.caption
when stype =''i'' then i.caption end,'',''),1,150)||''...'' end,''NA'') sname,
case when aur.rolev2=''T'' then ''tad_ur'' else ''taxrol'' end ldtrans,
case when aur.rolev2=''T'' then aur.AXPDEF_USERROLESid else a.axusergroupsid end ldrecid,
ur.ucnt,a.axusergroupsid,case when prm.cnt > 0 then ''View'' else ''Add'' end pst
from axusergroups a 
left join axusergroupsdetail a2 on a.axusergroupsid = a2.axusergroupsid 
left join AXPDEF_USERROLES aur on a.groupname = aur.AXUSERGROUP
left join axuseraccess u on a2.roles_id = u.rname 
left join tstructs t on u.sname  = t.name
left join iviews i on u.sname  = i.name
left join (select a3.usergroup,count(*) ucnt from axuserlevelgroups a3 group by a3.usergroup) ur on ur.usergroup = a.groupname
left join (select a.axuserrole,count(1) cnt from axpermissions a group by axuserrole)prm on prm.axuserrole= a.groupname
group by a.groupname,ur.ucnt,case when aur.rolev2=''T'' then ''tad_ur'' else ''taxrol'' end ,
case when aur.rolev2=''T'' then aur.AXPDEF_USERROLESid else a.axusergroupsid end,prm.cnt,
a.groupname
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad__act', 'select case when b.acttype=1 then b.actorname 
when acttype=2 then concat(b.process,'','',b.taskname) else null end processdtl ,b.axpdef_peg_actorid,
case when assignmodecnd!=0 then 
case when b.assignmodecnd = 1 then b.defusername  
when b.assignmodecnd = 2 then c.ugrps
when b.assignmodecnd = 3 then d.dgrps
end else ''Assign users'' end users,acttype,
''<b>Created by</b> ''||b.createdby||'' on ''||b.createdon||''</br><b> Last modified by </b>''||b.username||'' on ''||b.modifiedon updated
from axpdef_peg_actor b
left join (select axpdef_peg_actorid,string_agg(ugrpusername,'','') ugrps from axpdef_peg_actorusergrp group by axpdef_peg_actorid) c
on b.axpdef_peg_actorid=c.axpdef_peg_actorid
left join (select axpdef_peg_actorid,string_agg(datagrpusers,'','') dgrps from axpdef_peg_grpfilter group by axpdef_peg_actorid)d
on b.axpdef_peg_actorid=d.axpdef_peg_actorid
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axusers', 'select axusersid,username, allusergroup,case when length(usergroups) > 1 then usergroups end usergroups,
case when length(actors) > 1 then actors end actors,
case when length(adminaccess) > 1 then adminaccess end adminaccess,case when portaluser = ''T'' then 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end portaluser,
case when active = ''F'' then ''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box</span>'' 
else 
''<span class="material-icons material-icons-style" style="color:#2b4da1">check_box_outline_blank</span>'' 
end as active,concat(''<b>Name :</b> '',nickname,''</br><b>Email :</b> '',email,''</br><b>Mobile :</b> '',mobile,''</br><b>Authentication :</b> '',
case when pwdauth=''T'' and otpauth=''F'' then ''Password'' 
when pwdauth=''F'' and otpauth=''T'' then ''OTP'' when pwdauth=''T'' and otpauth=''T'' then ''Password and OTP'' end 
,''</br>'',case when portaluser =''T'' then ''Portal user'' end
,''</br>'',case when active=''F'' then ''Inactive user'' end
,''</br>'',case when prm.cnt>0 then ''Permissions configured'' end) pdtls,case when prm.cnt>0 then ''View'' else ''Add'' end perm ,
concat(case when prm.cnt>0 then ''vperm,View permissions,script,filter_alt~'' end,       
''aperm,Add permissions,script,rule'') AxRowOptions
from axusers 
left join (select a.axusername,count(1) cnt from axpermissions a group by a.axusername)prm on prm.axusername = axusers.username  
where (case when active=''T'' then ''Active'' else ''Inactive'' end = :pactive or ''All'' = :pactive)
and (case when portaluser =''T'' then ''Yes'' else ''No'' end = :pportal or ''All''= :pportal)
and (exists(select 1 from unnest(string_to_array(allusergroup,'','')) val where val =(:proles)) or ''All'' = :proles)
and (exists(select 1 from unnest(string_to_array(usergroups,'','')) val where val =(:pusergroup))or ''All'' = :pusergroup)
and (exists(select 1 from unnest(string_to_array(actors,'','')) val where val =(:pactors))or ''All'' = :pactors)
order by 2
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('axscrlog', 'select *,case 
when lower(status) in(''completed'',''inprogress'') then null else   ''View details'' end actn   from axscriptjobs 
where (case 
when lower(status)=''completed'' then ''Success''
when lower(status)=''inprogress'' then ''In progress''
else ''Failed'' end = :pstatus or ''ALL'' = :pstatus)
and jobdate between :pfdate and :ptdate
order by jobdate desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('a__dftst', 'select concat(t.caption,''-('',t.name,'')'') caption,t.name,a.axgrouptstructsid from axgrouptstructs a join tstructs t on a.ftransid = t.name
order by 1
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___rel', 'select a.runtimetstruct editable,a.name axpdef_tstructid, concat(a.caption,''-('',a.name,'')'') caption,name ntransid, 
concat(case when a.runtimetstruct=''T'' then ''Runtime form'' else ''Developer form'' end||''</br>'',
case when length(t.purpose) > 3 then purpose||''</br>'' else '''' end,
(select pr_utl_forms_menutree(concat(''t'',a.name))),
coalesce ( case when length(t.savectrlfld) > 1 then ''Save control field- ''||t.savectrlfld ||''</br>'' end,''''),
coalesce (case when t.delctrlfld is not null then ''Delete control field- ''|| t.delctrlfld ||''</br>'' end,''''),
case when coalesce(oq.oqns,0 ) != 0 then  oq.oqns|| '' Outbound queues''||'','' else '''' end,
case when coalesce(b.cnt,0 ) != 0 then  b.cnt ||'' Rules defined''|| '','' else '''' end,
case when coalesce(p.pros,0 ) != 0 then  p.pros||'' Process defined''|| '','' else '''' end,
case when coalesce(ap.aps,0 ) != 0 then  ap.aps||'' Auto prints''||'','' else '''' end,
case when coalesce(fn.fns,0 ) != 0 then  fn.fns||'' Form notifications''||'','' else '''' end)
as form_properties,concat(case when a.runtimetstruct=''T'' then concat(''script3,Edit form,script,edit~'')  else null end,
case when a.runtimemod =''T'' then concat(''ruleeng,'',case when b.cnt>0 then ''View rules'' else ''Add rule'' end,'',script,rule~'') end,
case when p.pros > 0 then concat(''peg,'',''Process listing'','',script,schema~'') else concat(''newpeg,'',''Add process definition'','',script,schema~'') end,
concat(''autoprint,'',case when ap.aps>0 then ''View AutoPrints'' else ''Add AutoPrints'' end,'',script,print~''),
concat(''formnot,'',case when fn.fns>0 then ''View Notifications'' else ''Add Notifications'' end,'',script,notifications_active~''),
concat(''queue,'',case when oq.oqns>0 then ''Queue listing'' else ''Add to Outbound queue'' end,'',script,playlist_add~''),
''condata,Connected forms,script,call_merge'') AxRowOptions,
b.cnt rules,p.pros processes,ap.aps autopr,fn.fns fnotify,oq.oqns queue,''Form'' fptype,
''<b>Created by </b>''||a.createdby||'' on ''||a.createdon||''</br><b> Last modified by </b>''||a.updatedby||'' on ''||a.updatedon updated
from tstructs a
left outer join axptstructs t on a.name = t.tstruct
left outer join (select  b.stransid, count(1) as cnt from axpdef_ruleeng b group by stransid) b on ( a.name = b.stransid )
left outer join (select transid,count(distinct processname) pros from axprocessdefv2 a  group by transid) p on ( a.name = p.transid )
left outer join (select stransid,count(1) aps from AxAutoPrints  group by stransid) ap on ( a.name = ap.stransid)
left outer join (select stransid,count(1) fns from AxFormNotify  group by stransid) fn on ( a.name = fn.stransid)
left outer join (select stransid,count(1) oqns from AxOutQueues group by stransid) oq on ( a.name = oq.stransid)
 order by fn_utl_forms_dateconversion(a.updatedon) desc
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1'),
('ad___upm', 'select distinct a.axpermissionsid,b.username,concat(b.caption,''-('',b.sname,'')'') formcap,coalesce(a.allowcreate,''Yes'') allowcreate,coalesce(a.viewdlts,''All'')viewdlts,coalesce(editdlts,''All'') editdlts,
b.sname,concat(b.caption,''-('',b.sname,'')'') capui,''Form'' comptype,b.stype,
case b.stype when ''t'' then ''Form'' when ''i'' then ''Report'' when ''p'' then ''Page'' else null end stypeui,
case when b.stype=''t'' and (a.fromsource is null or a.fromsource=''U'' )then ''aperm,Add permission,script,build_circle'' end AxRowOptions,
case when b.stype=''t'' then ''Configure'' end perm,case when axuserrole=''All'' then ''User'' else ''Role - ''||axuserrole end axuserrole
from (
select b.axpermissionsid,b.axusername ,axuserrole ,b.formcap,coalesce(b.allowcreate,''Yes'') allowcreate,
 case b.viewctrl when ''0'' then ''All'' 
 when ''1'' then ''View these fields - ''||view_flds 
 when ''2'' then ''View exclude these fields - ''||view_flds 	
 when ''4'' then ''No access'' else ''All'' end viewdlts, 
 case b.editctrl when ''0'' then ''All'' 
 when ''1'' then ''Edit these fields - ''||edit_flds 
 when ''2'' then ''Edit exclude these fields ''||edit_flds
 when ''4'' then ''No access'' else ''All'' end editdlts ,b.formtransid ,b.fromsource 
from  axpermissions b join  axuserlevelgroups a on b.axuserrole = a.usergroup and a.username = :pusername
where  b.axuserrole !=''All''  
union all
select b.axpermissionsid,b.axusername ,b.axuserrole ,b.formcap,coalesce(b.allowcreate,''Yes'') allowcreate,
 case b.viewctrl when ''0'' then ''All'' 
 when ''1'' then ''View these fields - ''||view_flds 
 when ''2'' then ''View exclude these fields - ''||view_flds 
 when ''4'' then ''No access'' else ''All'' end viewdlts, 
 case b.editctrl when ''0'' then ''All'' 
 when ''1'' then ''Edit these fields - ''||edit_flds 
 when ''2'' then ''Edit exclude these fields ''||edit_flds
 when ''4'' then ''No access'' else ''All'' end editdlts ,b.formtransid,b.fromsource  
from  axpermissions b where  b.axuserrole =''All''  and b.axusername = :pusername 
)a
right join (select distinct sname,caption,username,stype,groupname from vw_username_role_menu_access 
where username=:pusername 
and (stype =case :pstype when ''Form'' then ''t'' when ''Report'' then ''i'' when ''Page'' then ''p'' end or ''All'' = :pstype)
union all
select distinct sname,caption,username,stype,''All'' from vw_username_role_menu_access 
where username=:pusername 
and (stype =case :pstype when ''Form'' then ''t'' when ''Report'' then ''i'' when ''Page'' then ''p'' end or ''All'' = :pstype)
) b on b.sname = a.formtransid  and b.groupname = a.axuserrole 
union all
select distinct a.axpermissionsid,a.username, b.sqlname formcap,''NA'' allowcreate,
coalesce(a.viewdlts,''All'')viewdlts,''NA'' editdlts,
sqlname sname,sqlname capui,''ADS'' comptype,null stype,''ADS'' stypeui,
case when (a.fromsource is null or a.fromsource=''U'' ) then ''aperm,Setup permission,script,build_circle'' end AxRowOptions,''Configure'' perm,groupname from
(select p.axpermissionsid,u.username username,p.axuserrole groupname, p.formcap,
case p.viewctrl when ''0'' then ''All'' 
 when ''1'' then ''View these fields - ''||view_flds 
 when ''2'' then ''View exclude these fields - ''||view_flds 
 when ''4'' then ''No access'' else ''All'' end viewdlts,p.fromsource
from axpermissions p join  axuserlevelgroups u on p.axuserrole = u.usergroup and u.username = :pusername
where  p.axuserrole !=''All'' and p.comptype =''ADS''
union all
select p.axpermissionsid,p.axusername,null, p.formcap,
case p.viewctrl when ''0'' then ''All'' 
 when ''1'' then ''View these fields - ''||view_flds 
 when ''2'' then ''View exclude these fields - ''||view_flds 
 when ''4'' then ''No access'' else ''All'' end viewdlts,p.fromsource
from axpermissions p 
where  p.axuserrole =''All'' and p.comptype =''ADS'' and p.axusername = :pusername)a
right join(select a.sqlname,b.axpermissionsid from axdirectsql a left join axpermissions b on a.sqlname = b.formcap and b.comptype=''ADS''
    union all
    select a.sqlname,0 from axdirectsql a)b on a.formcap=b.sqlname and b.axpermissionsid=a.axpermissionsid
where (:pstype =''ADS'' or ''All'' = :pstype)
order by 3
', 'reportsql', 'Task1', '1', NULL, 'sql', 'row1', '1')
ON CONFLICT DO NOTHING;

-- Seed: iviewsubtotals (0 rows)
-- No rows in source dump for iviewsubtotals.
