-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
ALTER TABLE ONLY {schema}.axautoprints
    ADD CONSTRAINT aglaxautoprintsid PRIMARY KEY (axautoprintsid);

ALTER TABLE ONLY {schema}.axcalendar
    ADD CONSTRAINT aglaxcalendarid PRIMARY KEY (axcalendarid);

ALTER TABLE ONLY {schema}.axcardtypemaster
    ADD CONSTRAINT aglaxcardtypemasterid PRIMARY KEY (axcardtypemasterid);

ALTER TABLE ONLY {schema}.axdef_newfield
    ADD CONSTRAINT aglaxdef_newfieldid PRIMARY KEY (axdef_newfieldid);

ALTER TABLE ONLY {schema}.axdirectsql_metadata
    ADD CONSTRAINT aglaxdirectsql_metadataid PRIMARY KEY (axdirectsql_metadataid);

ALTER TABLE ONLY {schema}.axdirectsql
    ADD CONSTRAINT aglaxdirectsqlid PRIMARY KEY (axdirectsqlid);

ALTER TABLE ONLY {schema}.axdsignconfig
    ADD CONSTRAINT aglaxdsignconfigid PRIMARY KEY (axdsignconfigid);

ALTER TABLE ONLY {schema}.axdsignmail
    ADD CONSTRAINT aglaxdsignmailid PRIMARY KEY (axdsignmailid);

ALTER TABLE ONLY {schema}.axentityrelations
    ADD CONSTRAINT aglaxentityrelationsid PRIMARY KEY (axentityrelationsid);

ALTER TABLE ONLY {schema}.axformnotify
    ADD CONSTRAINT aglaxformnotifyid PRIMARY KEY (axformnotifyid);

ALTER TABLE ONLY {schema}.axglovar
    ADD CONSTRAINT aglaxglovarid PRIMARY KEY (axglovarid);

ALTER TABLE ONLY {schema}.axgrouping
    ADD CONSTRAINT aglaxgroupingid PRIMARY KEY (axgroupingid);

ALTER TABLE ONLY {schema}.axgroupingmst
    ADD CONSTRAINT aglaxgroupingmstid PRIMARY KEY (axgroupingmstid);

ALTER TABLE ONLY {schema}.aximpdef
    ADD CONSTRAINT aglaximpdefid PRIMARY KEY (aximpdefid);

ALTER TABLE ONLY {schema}.axinqueues
    ADD CONSTRAINT aglaxinqueuesid PRIMARY KEY (axinqueuesid);

ALTER TABLE ONLY {schema}.axlanguage11x
    ADD CONSTRAINT aglaxlanguage11xid PRIMARY KEY (axlanguage11xid);

ALTER TABLE ONLY {schema}.axlov
    ADD CONSTRAINT aglaxlovid PRIMARY KEY (axlovid);

ALTER TABLE ONLY {schema}.axnotificationdef
    ADD CONSTRAINT aglaxnotificationdefid PRIMARY KEY (axnotificationdefid);

ALTER TABLE ONLY {schema}.axoutqueues
    ADD CONSTRAINT aglaxoutqueuesid PRIMARY KEY (axoutqueuesid);

ALTER TABLE ONLY {schema}.axoutqueuesmst
    ADD CONSTRAINT aglaxoutqueuesmstid PRIMARY KEY (axoutqueuesmstid);

ALTER TABLE ONLY {schema}.axp_appsearch_data_period
    ADD CONSTRAINT aglaxp_appsearch_data_periodid PRIMARY KEY (axp_appsearch_data_periodid);

ALTER TABLE ONLY {schema}.axp_appsearchdtl
    ADD CONSTRAINT aglaxp_appsearchdtlid PRIMARY KEY (axp_appsearchdtlid);

ALTER TABLE ONLY {schema}.axp_cards
    ADD CONSTRAINT aglaxp_cardsid PRIMARY KEY (axp_cardsid);

ALTER TABLE ONLY {schema}.axp_customdatatype
    ADD CONSTRAINT aglaxp_customdatatypeid PRIMARY KEY (axp_customdatatypeid);

ALTER TABLE ONLY {schema}.axp_dbwdetails
    ADD CONSTRAINT aglaxp_dbwdetailsid PRIMARY KEY (axp_dbwdetailsid);

ALTER TABLE ONLY {schema}.axp_tabledescriptor
    ADD CONSTRAINT aglaxp_tabledescriptorid PRIMARY KEY (axp_tabledescriptorid);

ALTER TABLE ONLY {schema}.axp_vp
    ADD CONSTRAINT aglaxp_vpid PRIMARY KEY (axp_vpid);

ALTER TABLE ONLY {schema}.axpdef_axcalendar_event
    ADD CONSTRAINT aglaxpdef_axcalendar_eventid PRIMARY KEY (axpdef_axcalendar_eventid);

ALTER TABLE ONLY {schema}.axpdef_axcalendar_eventstatus
    ADD CONSTRAINT aglaxpdef_axcalendar_eventstatusid PRIMARY KEY (axpdef_axcalendar_eventstatusid);

ALTER TABLE ONLY {schema}.axpdef_axpertapi
    ADD CONSTRAINT aglaxpdef_axpertapiid PRIMARY KEY (axpdef_axpertapiid);

ALTER TABLE ONLY {schema}.axpdef_axpertprops
    ADD CONSTRAINT aglaxpdef_axpertpropsid PRIMARY KEY (axpdef_axpertpropsid);

ALTER TABLE ONLY {schema}.axpdef_axvars_dbvar
    ADD CONSTRAINT aglaxpdef_axvars_dbvarid PRIMARY KEY (axpdef_axvars_dbvarid);

ALTER TABLE ONLY {schema}.axpdef_axvars
    ADD CONSTRAINT aglaxpdef_axvarsid PRIMARY KEY (axpdef_axvarsid);

ALTER TABLE ONLY {schema}.axpdef_impdata_templates
    ADD CONSTRAINT aglaxpdef_impdata_templatesid PRIMARY KEY (axpdef_impdata_templatesid);

ALTER TABLE ONLY {schema}.axpdef_jobs
    ADD CONSTRAINT aglaxpdef_jobsid PRIMARY KEY (axpdef_jobsid);

ALTER TABLE ONLY {schema}.axpdef_language
    ADD CONSTRAINT aglaxpdef_languageid PRIMARY KEY (axpdef_languageid);

ALTER TABLE ONLY {schema}.axpdef_news_events
    ADD CONSTRAINT aglaxpdef_news_eventsid PRIMARY KEY (axpdef_news_eventsid);

ALTER TABLE ONLY {schema}.axpdef_peg_actor
    ADD CONSTRAINT aglaxpdef_peg_actorid PRIMARY KEY (axpdef_peg_actorid);

ALTER TABLE ONLY {schema}.axpdef_peg_actorusergrp
    ADD CONSTRAINT aglaxpdef_peg_actorusergrpid PRIMARY KEY (axpdef_peg_actorusergrpid);

ALTER TABLE ONLY {schema}.axpdef_peg_grpfilter
    ADD CONSTRAINT aglaxpdef_peg_grpfilterid PRIMARY KEY (axpdef_peg_grpfilterid);

ALTER TABLE ONLY {schema}.axpdef_peg_processmaster
    ADD CONSTRAINT aglaxpdef_peg_processmasterid PRIMARY KEY (axpdef_peg_processmasterid);

ALTER TABLE ONLY {schema}.axpdef_prcards
    ADD CONSTRAINT aglaxpdef_prcardsid PRIMARY KEY (axpdef_prcardsid);

ALTER TABLE ONLY {schema}.axpdef_publishapi
    ADD CONSTRAINT aglaxpdef_publishapiid PRIMARY KEY (axpdef_publishapiid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng_expr
    ADD CONSTRAINT aglaxpdef_ruleeng_exprid PRIMARY KEY (axpdef_ruleeng_exprid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng_fctl
    ADD CONSTRAINT aglaxpdef_ruleeng_fctlid PRIMARY KEY (axpdef_ruleeng_fctlid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng_masks
    ADD CONSTRAINT aglaxpdef_ruleeng_masksid PRIMARY KEY (axpdef_ruleeng_masksid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng_msg
    ADD CONSTRAINT aglaxpdef_ruleeng_msgid PRIMARY KEY (axpdef_ruleeng_msgid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng_valexpr
    ADD CONSTRAINT aglaxpdef_ruleeng_valexprid PRIMARY KEY (axpdef_ruleeng_valexprid);

ALTER TABLE ONLY {schema}.axpdef_ruleeng
    ADD CONSTRAINT aglaxpdef_ruleengid PRIMARY KEY (axpdef_ruleengid);

ALTER TABLE ONLY {schema}.axpdef_script
    ADD CONSTRAINT aglaxpdef_scriptid PRIMARY KEY (axpdef_scriptid);

ALTER TABLE ONLY {schema}.axpdef_usergroups
    ADD CONSTRAINT aglaxpdef_usergroupsid PRIMARY KEY (axpdef_usergroupsid);

ALTER TABLE ONLY {schema}.axpdef_userroles
    ADD CONSTRAINT aglaxpdef_userrolesid PRIMARY KEY (axpdef_userrolesid);

ALTER TABLE ONLY {schema}.axpeg_sendmsg
    ADD CONSTRAINT aglaxpeg_sendmsgid PRIMARY KEY (axpeg_sendmsgid);

ALTER TABLE ONLY {schema}.axperiodnotify
    ADD CONSTRAINT aglaxperiodnotifyid PRIMARY KEY (axperiodnotifyid);

ALTER TABLE ONLY {schema}.axpermissions
    ADD CONSTRAINT aglaxpermissionsid PRIMARY KEY (axpermissionsid);

ALTER TABLE ONLY {schema}.axpexchange
    ADD CONSTRAINT aglaxpexchangeid PRIMARY KEY (axpexchangeid);

ALTER TABLE ONLY {schema}.axprocessdef_delegation
    ADD CONSTRAINT aglaxprocessdef_delegationid PRIMARY KEY (axprocessdef_delegationid);

ALTER TABLE ONLY {schema}.axprocessdef
    ADD CONSTRAINT aglaxprocessdefid PRIMARY KEY (axprocessdefid);

ALTER TABLE ONLY {schema}.axprocessdefv2_escalation
    ADD CONSTRAINT aglaxprocessdefv2_escalationid PRIMARY KEY (axprocessdefv2_escalationid);

ALTER TABLE ONLY {schema}.axprocessdefv2_formctls
    ADD CONSTRAINT aglaxprocessdefv2_formctlsid PRIMARY KEY (axprocessdefv2_formctlsid);

ALTER TABLE ONLY {schema}.axprocessdefv2_reminder
    ADD CONSTRAINT aglaxprocessdefv2_reminderid PRIMARY KEY (axprocessdefv2_reminderid);

ALTER TABLE ONLY {schema}.axprocessdefv2_setval
    ADD CONSTRAINT aglaxprocessdefv2_setvalid PRIMARY KEY (axprocessdefv2_setvalid);

ALTER TABLE ONLY {schema}.axpstructconfig
    ADD CONSTRAINT aglaxpstructconfigid PRIMARY KEY (axpstructconfigid);

ALTER TABLE ONLY {schema}.axpstructconfigprops
    ADD CONSTRAINT aglaxpstructconfigpropsid PRIMARY KEY (axpstructconfigpropsid);

ALTER TABLE ONLY {schema}.axpstructconfigproval
    ADD CONSTRAINT aglaxpstructconfigprovalid PRIMARY KEY (axpstructconfigprovalid);

ALTER TABLE ONLY {schema}.axrulesdef_conmsg
    ADD CONSTRAINT aglaxrulesdef_conmsgid PRIMARY KEY (axrulesdef_conmsgid);

ALTER TABLE ONLY {schema}.axrulesdef_expr
    ADD CONSTRAINT aglaxrulesdef_exprid PRIMARY KEY (axrulesdef_exprid);

ALTER TABLE ONLY {schema}.axrulesdef_valexpr
    ADD CONSTRAINT aglaxrulesdef_valexprid PRIMARY KEY (axrulesdef_valexprid);

ALTER TABLE ONLY {schema}.axrulesdef
    ADD CONSTRAINT aglaxrulesdefid PRIMARY KEY (axrulesdefid);

ALTER TABLE ONLY {schema}.axuseractivations
    ADD CONSTRAINT aglaxuseractivationsid PRIMARY KEY (axuseractivationsid);

ALTER TABLE ONLY {schema}.axusercharts
    ADD CONSTRAINT aglaxuserchartsid PRIMARY KEY (axuserchartsid);

ALTER TABLE ONLY {schema}.axuserdpermissions
    ADD CONSTRAINT aglaxuserdpermissionsid PRIMARY KEY (axuserdpermissionsid);

ALTER TABLE ONLY {schema}.axusergrouping
    ADD CONSTRAINT aglaxusergroupingid PRIMARY KEY (axusergroupingid);

ALTER TABLE ONLY {schema}.axusergroupsdetail
    ADD CONSTRAINT aglaxusergroupsdetailid PRIMARY KEY (axusergroupsdetailid);

ALTER TABLE ONLY {schema}.axuserpermissions
    ADD CONSTRAINT aglaxuserpermissionsid PRIMARY KEY (axuserpermissionsid);

ALTER TABLE ONLY {schema}.axvarcore
    ADD CONSTRAINT aglaxvarcoreid PRIMARY KEY (axvarcoreid);

ALTER TABLE ONLY {schema}.customtypes
    ADD CONSTRAINT aglcustomtypesid PRIMARY KEY (customtypesid);

ALTER TABLE ONLY {schema}.dsignconfigdtl
    ADD CONSTRAINT agldsignconfigdtlid PRIMARY KEY (dsignconfigdtlid);

ALTER TABLE ONLY {schema}.dsignconfig
    ADD CONSTRAINT agldsignconfigid PRIMARY KEY (dsignconfigid);

ALTER TABLE ONLY {schema}.dwb_iviewscripts
    ADD CONSTRAINT agldwb_iviewscriptsid PRIMARY KEY (dwb_iviewscriptsid);

ALTER TABLE ONLY {schema}.dwb_publishprops
    ADD CONSTRAINT agldwb_publishpropsid PRIMARY KEY (dwb_publishpropsid);

ALTER TABLE ONLY {schema}.emaildef
    ADD CONSTRAINT aglemaildefid PRIMARY KEY (emaildefid);

ALTER TABLE ONLY {schema}.executeapidef
    ADD CONSTRAINT aglexecuteapidefid PRIMARY KEY (executeapidefid);

ALTER TABLE ONLY {schema}.financialyeardtl
    ADD CONSTRAINT aglfinancialyeardtlid PRIMARY KEY (financialyeardtlid);

ALTER TABLE ONLY {schema}.financialyear
    ADD CONSTRAINT aglfinancialyearid PRIMARY KEY (financialyearid);

ALTER TABLE ONLY {schema}.groupbtns
    ADD CONSTRAINT aglgroupbtnsid PRIMARY KEY (groupbtnsid);

ALTER TABLE ONLY {schema}.htmlprint
    ADD CONSTRAINT aglhtmlprintid PRIMARY KEY (htmlprintid);

ALTER TABLE ONLY {schema}.htmlsections
    ADD CONSTRAINT aglhtmlsectionsid PRIMARY KEY (htmlsectionsid);

ALTER TABLE ONLY {schema}.iconfigurationdtl
    ADD CONSTRAINT agliconfigurationdtlid PRIMARY KEY (iconfigurationdtlid);

ALTER TABLE ONLY {schema}.iconfiguration
    ADD CONSTRAINT agliconfigurationid PRIMARY KEY (iconfigurationid);

ALTER TABLE ONLY {schema}.reference
    ADD CONSTRAINT aglreferenceid PRIMARY KEY (referenceid);

ALTER TABLE ONLY {schema}.searchcols
    ADD CONSTRAINT aglsearchcolsid PRIMARY KEY (searchcolsid);

ALTER TABLE ONLY {schema}.sect2
    ADD CONSTRAINT aglsect2id PRIMARY KEY (sect2id);

ALTER TABLE ONLY {schema}.sect4
    ADD CONSTRAINT aglsect4id PRIMARY KEY (sect4id);

ALTER TABLE ONLY {schema}.sendmsg
    ADD CONSTRAINT aglsendmsgid PRIMARY KEY (sendmsgid);

ALTER TABLE ONLY {schema}.tconfiguration
    ADD CONSTRAINT agltconfigurationid PRIMARY KEY (tconfigurationid);

ALTER TABLE ONLY {schema}.templates
    ADD CONSTRAINT agltemplatesid PRIMARY KEY (templatesid);

ALTER TABLE ONLY {schema}.testf1
    ADD CONSTRAINT agltestf1id PRIMARY KEY (testf1id);

ALTER TABLE ONLY {schema}.tstruct_mst_details
    ADD CONSTRAINT agltstruct_mst_detailsid PRIMARY KEY (tstruct_mst_detailsid);

ALTER TABLE ONLY {schema}.ax_homebuild_master
    ADD CONSTRAINT ax_homebuild_master_pkey PRIMARY KEY (homebuild_id);

ALTER TABLE ONLY {schema}.ax_homebuild_saved
    ADD CONSTRAINT ax_homebuild_saved_pkey PRIMARY KEY (homebuild_id);

ALTER TABLE ONLY {schema}.ax_htmlplugins
    ADD CONSTRAINT ax_htmlplugins_pk PRIMARY KEY (name);

ALTER TABLE ONLY {schema}.ax_layoutdesign
    ADD CONSTRAINT ax_layoutdesign_pkey PRIMARY KEY (design_id);

ALTER TABLE ONLY {schema}.ax_layoutdesign_saved
    ADD CONSTRAINT ax_layoutdesign_saved_pkey PRIMARY KEY (design_id);

ALTER TABLE ONLY {schema}.ax_notify
    ADD CONSTRAINT ax_notify_pkey PRIMARY KEY (notification_id);

ALTER TABLE ONLY {schema}.ax_page_saved
    ADD CONSTRAINT ax_page_saved_pkey PRIMARY KEY (page_id);

ALTER TABLE ONLY {schema}.ax_page_templates
    ADD CONSTRAINT ax_page_templates_pkey PRIMARY KEY (template_id);

ALTER TABLE ONLY {schema}.ax_pages
    ADD CONSTRAINT ax_pages_pkey PRIMARY KEY (page_id);

ALTER TABLE ONLY {schema}.ax_widget
    ADD CONSTRAINT ax_widget_pkey PRIMARY KEY (widget_id);

ALTER TABLE ONLY {schema}.ax_widget_published
    ADD CONSTRAINT ax_widget_published_pkey PRIMARY KEY (widget_id);

ALTER TABLE ONLY {schema}.ax_widget_saved
    ADD CONSTRAINT ax_widget_saved_pkey PRIMARY KEY (widget_id);

ALTER TABLE ONLY {schema}.axaudit
    ADD CONSTRAINT axaudit_pkey PRIMARY KEY (sessionid);

ALTER TABLE ONLY {schema}.axcustomviews
    ADD CONSTRAINT axcustomviews_pkey PRIMARY KEY (name, username, transid, blobno);

ALTER TABLE ONLY {schema}.axerrorlog
    ADD CONSTRAINT axerrorlog_pkey PRIMARY KEY (username, eventdate);

ALTER TABLE ONLY {schema}.axi_command_prompts
    ADD CONSTRAINT axi_command_prompts_pkey PRIMARY KEY (id);

ALTER TABLE ONLY {schema}.axi_commands
    ADD CONSTRAINT axi_commands_pkey PRIMARY KEY (cmdtoken);

ALTER TABLE ONLY {schema}.axiconmenu
    ADD CONSTRAINT axiconmenu_pkey PRIMARY KEY (parentpagename);

ALTER TABLE ONLY {schema}.axlanguage
    ADD CONSTRAINT axlanguage_pkey PRIMARY KEY (sname, lngname, compname);

ALTER TABLE ONLY {schema}.axlictrans
    ADD CONSTRAINT axlictrans_pkey PRIMARY KEY (licid);

ALTER TABLE ONLY {schema}.axp_smartviews_config
    ADD CONSTRAINT axp_smartviews_config_pkey PRIMARY KEY (username, ivname);

ALTER TABLE ONLY {schema}.axpages
    ADD CONSTRAINT axpages_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.axpcal
    ADD CONSTRAINT axpcal_pkey PRIMARY KEY (axpcalid);

ALTER TABLE ONLY {schema}.axpclouddevsettings
    ADD CONSTRAINT axpclouddevsettings_tranid_type_key UNIQUE (tranid, type);

ALTER TABLE ONLY {schema}.axpdflanguage
    ADD CONSTRAINT axpdflanguage_pkey PRIMARY KEY (sname, lngname, compname);

ALTER TABLE ONLY {schema}.axprops
    ADD CONSTRAINT axprops_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.axptree
    ADD CONSTRAINT axptree_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.axpws_config
    ADD CONSTRAINT axpws_config_pkey PRIMARY KEY (transid, iviewname);

ALTER TABLE ONLY {schema}.axrequest
    ADD CONSTRAINT axrequest_pkey PRIMARY KEY (requestid);

ALTER TABLE ONLY {schema}.axresponse
    ADD CONSTRAINT axresponse_pkey PRIMARY KEY (responseid);

ALTER TABLE ONLY {schema}.axscheduler
    ADD CONSTRAINT axscheduler_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.axuseraccess
    ADD CONSTRAINT axuseraccess_pkey PRIMARY KEY (rname, sname, stype);

ALTER TABLE ONLY {schema}.axusergroups
    ADD CONSTRAINT axusergroups_pkey PRIMARY KEY (groupname);

ALTER TABLE ONLY {schema}.axusers
    ADD CONSTRAINT axusers_pkey PRIMARY KEY (username);

ALTER TABLE ONLY {schema}.axuserspwdpolicy
    ADD CONSTRAINT axuserspwdpolicy_pkey PRIMARY KEY (username);

ALTER TABLE ONLY {schema}.axworkflow
    ADD CONSTRAINT axworkflow_pkey PRIMARY KEY (name);

ALTER TABLE ONLY {schema}.formsize
    ADD CONSTRAINT formsize_pkey PRIMARY KEY (username, formname);

ALTER TABLE ONLY {schema}.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.iviews
    ADD CONSTRAINT iviews_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.lviews
    ADD CONSTRAINT lviews_pkey PRIMARY KEY (name, username, transid, blobno);

ALTER TABLE ONLY {schema}.axattachworkflow
    ADD CONSTRAINT pk__axattach_wkidtransid PRIMARY KEY (wkid, transid);

ALTER TABLE ONLY {schema}.printprms
    ADD CONSTRAINT printprms_pkey PRIMARY KEY (iview);

ALTER TABLE ONLY {schema}.printprops
    ADD CONSTRAINT printprops_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.prints
    ADD CONSTRAINT prints_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.searchdef
    ADD CONSTRAINT searchdef_pkey PRIMARY KEY (transid, username);

ALTER TABLE ONLY {schema}.sequence
    ADD CONSTRAINT seq_unique UNIQUE (transtype, fieldname, prefix, prefixfield);

ALTER TABLE ONLY {schema}.sequence
    ADD CONSTRAINT sequence_pkey PRIMARY KEY (sequenceid);

ALTER TABLE ONLY {schema}.structlock
    ADD CONSTRAINT structlock_pkey PRIMARY KEY (sname);

ALTER TABLE ONLY {schema}.tstructs
    ADD CONSTRAINT tstructs_pkey PRIMARY KEY (name, blobno);

ALTER TABLE ONLY {schema}.axmmetadatamaster
    ADD CONSTRAINT unique_structtype_structname UNIQUE (structtype, structname);

ALTER TABLE ONLY {schema}.ax_homebuild_responsibility
    ADD CONSTRAINT ax_homebuild_responsibility_homebuild_id_fkey FOREIGN KEY (homebuild_id) REFERENCES {schema}.ax_homebuild_master(homebuild_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_homebuild_sd_responsibility
    ADD CONSTRAINT ax_homebuild_sd_responsibility_homebuild_id_fkey FOREIGN KEY (homebuild_id) REFERENCES {schema}.ax_homebuild_saved(homebuild_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_hp_user_level_widget
    ADD CONSTRAINT ax_hp_user_level_widget_page_id_fkey FOREIGN KEY (page_id) REFERENCES {schema}.ax_pages(page_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_page_responsibility
    ADD CONSTRAINT ax_page_responsibility_page_id_fkey FOREIGN KEY (page_id) REFERENCES {schema}.ax_pages(page_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_page_sd_responsibility
    ADD CONSTRAINT ax_page_sd_responsibility_page_id_fkey FOREIGN KEY (page_id) REFERENCES {schema}.ax_page_saved(page_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_widget_published
    ADD CONSTRAINT ax_widget_published_page_id_fkey FOREIGN KEY (page_id) REFERENCES {schema}.ax_pages(page_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_widget_published
    ADD CONSTRAINT ax_widget_published_parent_widget_id_fkey FOREIGN KEY (parent_widget_id) REFERENCES {schema}.ax_widget_saved(widget_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_widget_responsibility
    ADD CONSTRAINT ax_widget_responsibility_widget_id_fkey FOREIGN KEY (widget_id) REFERENCES {schema}.ax_widget(widget_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.ax_widget_saved
    ADD CONSTRAINT ax_widget_saved_page_id_fkey FOREIGN KEY (page_id) REFERENCES {schema}.ax_page_saved(page_id) ON DELETE CASCADE;

ALTER TABLE ONLY {schema}.axresponse
    ADD CONSTRAINT axresponse_requestid_fkey FOREIGN KEY (requestid) REFERENCES {schema}.axrequest(requestid);
