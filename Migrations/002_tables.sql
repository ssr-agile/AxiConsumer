-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE TABLE {schema}.axpdef_axpanalytics_mdata (
    ftransid character varying(10),
    fcaption character varying(500),
    fldname character varying(50),
    fldcap character varying(500),
    cdatatype character varying(50),
    fdatatype character varying(50),
    fmodeofentry character varying(50),
    hide character varying(10),
    props character varying(4000),
    normalized character varying(10),
    srctable character varying(50),
    srcfield character varying(50),
    srctransid character varying(10),
    allowempty character varying(10),
    filtertype character varying(50),
    grpfield character varying(10),
    aggfield character varying(10),
    subentity character varying(1),
    datacnd numeric(1,0),
    entityrelfld character varying(100),
    allowduplicate character varying(1),
    tablename character varying(100),
    dcname character varying(10),
    fordno numeric,
    dccaption character varying(100),
    griddc character varying(2),
    listingfld character varying(1),
    encrypted character varying(1),
    masking character varying(100),
    lastcharmask character varying(100),
    firstcharmask character varying(100),
    maskchar character varying(1),
    maskroles character varying(1000),
    customdecimal character varying(1)
);

CREATE TABLE {schema}.a__naeventimg (
    recordid numeric(16,0),
    img bytea,
    blobno numeric(3,0),
    ftype character varying(4)
);

CREATE TABLE {schema}.ad_prhistory (
    recordid numeric(16,0),
    modifieddate timestamp without time zone,
    username character varying(30),
    fieldname character varying(30),
    oldvalue character varying(4000),
    newvalue character varying(4000),
    rowno numeric(38,0),
    delflag character varying(1),
    modno numeric(10,0),
    frameno numeric(10,0),
    parentrow numeric(10,0),
    tablerecid numeric(16,0),
    idvalue numeric(16,0),
    oldidvalue numeric(16,0),
    transdeleted character varying(5),
    newtrans character varying(5),
    canceltrans character varying(1),
    cancelremarks character varying(250)
);

CREATE TABLE {schema}.astcpattach (
    recordid numeric(16,0),
    filename character varying(200),
    template bytea,
    blobno numeric(3,0),
    recid character varying(217)
);

CREATE TABLE {schema}.ax_homebuild_master (
    homebuild_id integer NOT NULL,
    title character varying(255),
    widget_type character varying(255),
    content text,
    target character varying(255),
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_by character varying(255),
    updated_by character varying(255),
    responsibility character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_lock character varying(1) DEFAULT 'N'::character varying,
    order_by numeric(10,0),
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.ax_homebuild_responsibility (
    homebuild_id integer,
    responsibility character varying(255),
    responsibility_id numeric(10,0)
);

CREATE TABLE {schema}.ax_homebuild_saved (
    homebuild_id integer NOT NULL,
    title character varying(255),
    widget_type character varying(255),
    content text,
    target character varying(255),
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_by character varying(255),
    updated_by character varying(255),
    responsibility character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_lock character varying(1) DEFAULT 'N'::character varying,
    order_by numeric(10,0),
    is_publish character varying(1) DEFAULT 'N'::character varying,
    parent_homebuild_id numeric(10,0),
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.ax_homebuild_sd_responsibility (
    homebuild_id integer,
    responsibility character varying(255),
    responsibility_id numeric(10,0)
);

CREATE TABLE {schema}.ax_hp_user_level_widget (
    page_id numeric,
    widgets text,
    username character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE {schema}.ax_htmlplugins (
    name character varying(200) NOT NULL,
    htmltext text,
    context character varying(20)
);

CREATE TABLE {schema}.inbound (
    inboundid integer NOT NULL,
    filename character varying(100),
    recdon character varying(30),
    transid character varying(5),
    instatus character varying(250)
);

CREATE TABLE {schema}.tstructs (
    name character varying(15) NOT NULL,
    caption character varying(2000),
    props bytea,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(50),
    updatedby character varying(50),
    importedby character varying(50),
    readonly character varying(1),
    updusername character varying(25),
    workflow character varying(1),
    runtimetstruct character varying(1),
    runtimemod character varying(1)
);

CREATE TABLE {schema}.ax_layoutdesign (
    design_id numeric(16,0) NOT NULL,
    transid character varying(255),
    module character varying(255),
    content text,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying,
    is_publish character varying(1),
    parent_design_id numeric(10,0),
    responsibility text,
    order_by numeric(53,0)
);

CREATE TABLE {schema}.ax_layoutdesign_saved (
    design_id numeric(16,0) NOT NULL,
    transid character varying(255),
    module character varying(255),
    content text,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying,
    is_publish character varying(1) DEFAULT 'N'::character varying,
    is_private character varying(1) DEFAULT 'N'::character varying,
    parent_design_id numeric(16,0),
    responsibility text,
    order_by numeric
);

CREATE TABLE {schema}.ax_mobile_response (
    notification_id numeric(10,0),
    user_id character varying(255),
    response text,
    project_id character varying(255)
);

CREATE TABLE {schema}.ax_mobile_user (
    imei character varying(255),
    user_id character varying(255),
    project_id character varying(255),
    firebase_id character varying(255),
    groupname character varying(255),
    active character varying(1)
);

CREATE TABLE {schema}.ax_notify (
    notification_id numeric(10,0) NOT NULL,
    title character varying(255),
    message text,
    actions text,
    fromuser character varying(255),
    broadcast character varying(1) DEFAULT 'N'::character varying,
    status character varying(255),
    created_by character varying(255),
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    workflow_id character varying(255),
    project_id character varying(255),
    purge_on_first_action character varying(1) DEFAULT 'N'::character varying,
    notification_sent_datetime timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    recordid character varying(255),
    lno character varying(255),
    elno character varying(255)
);

CREATE TABLE {schema}.ax_notify_users (
    notification_id numeric(10,0),
    user_id character varying(255),
    status character varying(255),
    project_id character varying(255)
);

CREATE TABLE {schema}.ax_notify_workflow (
    notification_id numeric(10,0),
    recordid character varying(255),
    app_level character varying(2),
    app_desc character varying(2),
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    workflow_id character varying(255),
    project_id character varying(255),
    lno character varying(255),
    elno character varying(255)
);

CREATE TABLE {schema}.outbound (
    outboundid integer NOT NULL,
    transid character varying(5) NOT NULL,
    recordid numeric(17,0) NOT NULL,
    oaction character varying(1),
    username character varying(50) NOT NULL,
    modifiedon character varying(30),
    senton character varying(30),
    sap_integration_status character varying(30)
);

CREATE TABLE {schema}.ax_page_responsibility (
    page_id numeric,
    responsibility character varying(255),
    responsibility_id numeric
);

CREATE TABLE {schema}.ax_page_saved (
    page_id numeric(10,0) NOT NULL,
    title character varying(255),
    type character varying(255),
    module character varying(255),
    template character varying(255),
    page_menu character varying(255),
    content text,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying,
    is_lock character varying(1) DEFAULT 'N'::character varying,
    is_publish character varying(1) DEFAULT 'N'::character varying,
    is_private character varying(1) DEFAULT 'N'::character varying,
    is_default character varying(1) DEFAULT 'N'::character varying,
    parent_page_id numeric(10,0),
    responsibility text,
    order_by numeric,
    widget_groups character varying(1)
);

CREATE TABLE {schema}.ax_page_sd_responsibility (
    page_id numeric,
    responsibility character varying(255),
    responsibility_id numeric
);

CREATE TABLE {schema}.ax_page_templates (
    template_id numeric(16,0) NOT NULL,
    title character varying(255),
    module character varying(255),
    content text,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE {schema}.ax_pages (
    page_id numeric(10,0) NOT NULL,
    title character varying(255),
    type character varying(255),
    module character varying(255),
    template character varying(255),
    page_menu character varying(255),
    content text,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying,
    is_default character varying(1) DEFAULT 'N'::character varying,
    order_by numeric,
    widget_groups character varying(1)
);

CREATE TABLE {schema}.ax_user_settings (
    username character varying(50),
    ir_config character varying(4000),
    appsettings character varying(4000)
);

CREATE TABLE {schema}.ax_userconfigdata (
    page character varying(100),
    struct character varying(100),
    keyname character varying(100),
    username character varying(100),
    value text
);

CREATE TABLE {schema}.ax_widget (
    widget_id integer NOT NULL,
    widget_type character varying(50),
    sub_type character varying(50),
    title character varying(255),
    sqltext text,
    tabletext text,
    attributes text,
    created_by character varying(255),
    created_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    charttype character varying(45),
    is_migrated character varying(1) DEFAULT 'N'::character varying,
    is_public character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.ax_widget_published (
    widget_id numeric(16,0) NOT NULL,
    title character varying(255),
    widget_type character varying(255),
    content text,
    target character varying(255),
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_lock character varying(1) DEFAULT 'N'::character varying,
    order_by numeric,
    is_publish character varying(1) DEFAULT 'N'::character varying,
    parent_widget_id numeric,
    page_id numeric,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.ax_widget_responsibility (
    widget_id integer,
    responsibility character varying(255),
    responsibility_id integer
);

CREATE TABLE {schema}.ax_widget_saved (
    widget_id numeric(10,0) NOT NULL,
    title character varying(255),
    widget_type character varying(255),
    content text,
    target character varying(255),
    is_private character varying(1) DEFAULT 'N'::character varying,
    created_by character varying(255),
    updated_by character varying(255),
    is_deleted character varying(1) DEFAULT 'N'::character varying,
    is_lock character varying(1) DEFAULT 'N'::character varying,
    order_by numeric,
    is_publish character varying(1) DEFAULT 'N'::character varying,
    parent_widget_id numeric,
    page_id numeric,
    created_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP,
    is_migrated character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.axaction (
    actionname character varying(50),
    structname character varying(8),
    structtype character varying(10),
    actnode text
);

CREATE TABLE {schema}.axactivemessages (
    eventdatetime character varying(30),
    msgtype character varying(30),
    fromuser character varying(30),
    touser character varying(500),
    taskid character varying(15),
    tasktype character varying(30),
    processname character varying(500),
    taskname character varying(500),
    indexno numeric(10,0),
    keyfield character varying(30),
    keyvalue character varying(30),
    transid character varying(8),
    displaytitle character varying(500),
    displaycontent text,
    effectivefrom timestamp without time zone,
    effectiveto timestamp without time zone,
    html text,
    scripts text,
    hide character varying(1),
    displayicon character varying(200),
    hlink character varying(500),
    hlink_transid character varying(50),
    hlink_params character varying(2000),
    requestpayload text
);

CREATE TABLE {schema}.axactivetaskdata (
    eventdatetime character varying(30),
    taskid character varying(15),
    transid character varying(8),
    keyfield character varying(30),
    keyvalue character varying(500),
    datavalues character varying(4000)
);

CREATE TABLE {schema}.axactivetaskparams (
    eventdatetime character varying(30),
    taskid character varying(30),
    transid character varying(8),
    keyfield character varying(30),
    keyvalue character varying(500),
    taskstatus character varying(15),
    username character varying(30),
    tasktype character varying(500),
    taskname character varying(500),
    processname character varying(500),
    priorindex numeric(10,0),
    indexno numeric(10,0),
    subindexno numeric(10,0),
    recordid numeric(20,0),
    taskparams character varying(4000)
);

CREATE TABLE {schema}.axactivetasks (
    eventdatetime character varying(30),
    taskid character varying(15),
    processname character varying(500),
    tasktype character varying(30),
    taskname character varying(500),
    taskdescription character varying(4000),
    assigntorole character varying(50),
    transid character varying(8),
    keyfield character varying(30),
    execonapprove character varying(5),
    keyvalue character varying(500),
    transdata character varying(4000),
    fromrole character varying(30),
    fromuser character varying(30),
    touser character varying(500),
    priorindex numeric(10,0),
    priortaskname character varying(200),
    corpdimension character varying(10),
    orgdimension character varying(10),
    department character varying(30),
    grade character varying(10),
    datavalue character varying(4000),
    displayicon character varying(200),
    displaytitle character varying(500),
    displaysubtitle character varying(250),
    displaycontent text,
    displaybuttons character varying(250),
    groupfield character varying(4000),
    groupvalue character varying(4000),
    priorusername character varying(100),
    initiator character varying(100),
    mapfieldvalue character varying(4000),
    useridentificationfilter character varying(1000),
    useridentificationfilter_of character varying(1000),
    mapfield_group character varying(1000),
    mapfield character varying(1000),
    grouped character varying(1),
    indexno numeric(10,0),
    subindexno numeric(10,0),
    processowner character varying(100),
    assigntoflg character varying(1),
    assigntoactor character varying(1000),
    actorfilter text,
    recordid numeric(20,0),
    processownerflg numeric(1,0),
    pownerfilter character varying(4000),
    approvereasons character varying(4000),
    defapptext character varying(4000),
    returnreasons character varying(4000),
    defrettext character varying(4000),
    rejectreasons character varying(4000),
    defregtext character varying(4000),
    approvalcomments character varying(1),
    rejectcomments character varying(1),
    returncomments character varying(1),
    escalation character varying(1),
    reminder character varying(1),
    displaymcontent text,
    groupwithpriorindex numeric(2,0),
    delegation character varying(1) DEFAULT 'F'::character varying,
    returnable character varying(1),
    sendtoactor character varying(4000),
    allowsend character varying(30),
    allowsendflg character varying(1),
    sendtocomments character varying(4000),
    usebusinessdatelogic character varying(1),
    initiator_approval character varying(1),
    initonbehalf character varying(100),
    removeflg character varying(1) DEFAULT 'F'::character varying,
    pownerflg character varying(1) DEFAULT 'F'::character varying,
    changedusr character varying(1) DEFAULT 'F'::character varying,
    actor_user_groups text,
    actor_default_users character varying(1),
    actor_data_grp character varying(200),
    cancel character varying(1) DEFAULT 'F'::character varying,
    cancelledby character varying(100),
    cancelledon timestamp without time zone,
    cancelremarks text,
    action_buttons character varying(100),
    autoapprove character varying(1),
    isoptional character varying(1),
    reminderstartdate date,
    escalationstartdate date,
    reminderjsondata text,
    escalationjsondata text
);

CREATE TABLE {schema}.axactivetaskstatus (
    eventdatetime character varying(30),
    taskid character varying(15),
    transid character varying(8),
    keyfield character varying(30),
    keyvalue character varying(500),
    taskstatus character varying(15),
    username character varying(30),
    tasktype character varying(500),
    taskname character varying(500),
    processname character varying(500),
    priorindex numeric(10,0),
    indexno numeric(10,0),
    subindexno numeric(10,0),
    recordid numeric(20,0),
    statusreason character varying(4000),
    statustext character varying(4000),
    cancelremarks text,
    cancelledby character varying(100),
    cancelledon timestamp without time zone,
    cancel character varying(1),
    sendtocomments character varying(4000)
);

CREATE TABLE {schema}.axamend (
    transid character varying(5),
    usersession character varying(50),
    primaryrecordid numeric(20,0),
    amendno character varying(25),
    amendedby character varying(100),
    amendedon timestamp without time zone,
    fieldlist text,
    parselist text,
    recidlist text
);

CREATE TABLE {schema}.axapijobdetails (
    jobid character varying(100),
    requestid character varying(50),
    url character varying(500),
    servicename character varying(50),
    method character varying(10),
    requeststr text,
    params character varying(2000),
    bparams character varying(2000),
    header character varying(2000),
    responsestr text,
    status character varying(20),
    starttime timestamp without time zone,
    endtime timestamp without time zone,
    schjobid character varying(100),
    sessionid character varying(30),
    username character varying(50),
    context character varying(10),
    act_script_name character varying(100),
    bodyparamstr character varying(2000),
    formdatastr character varying(2000),
    formdatafiles character varying(2000),
    formurlencode character varying(2000),
    authstr character varying(2000)
);

CREATE TABLE {schema}.axappconfig (
    ordno numeric(5,0),
    rolename character varying(50),
    username character varying(50),
    userlevel numeric(2,0),
    propname character varying(10),
    propvalue character varying(4000)
);

CREATE TABLE {schema}.axattachworkflow (
    wkid character varying(15) NOT NULL,
    transid character varying(5) NOT NULL,
    wf_condition text,
    condtext text,
    blobno numeric(3,0),
    updatedon character varying(25),
    readonly character varying(1),
    updusername character varying(25),
    wf_edit character varying(1),
    wf_cancel character varying(1),
    subtype character varying(50),
    wf_reapproval character varying(1)
);

CREATE TABLE {schema}.axaudit (
    sessionid character varying(30) NOT NULL,
    username character varying(50),
    logintime timestamp without time zone,
    status character varying(20),
    reason character varying(150),
    ip character varying(20),
    mac character varying(20),
    other character varying(200),
    logouttime timestamp without time zone,
    nologout character varying(1),
    servertime timestamp without time zone,
    exeverdet character varying(125)
);

CREATE TABLE {schema}.axautoprints (
    axautoprintsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    autoprintid character varying(20),
    form character varying(250),
    stransid character varying(10),
    fast_prt character varying(1),
    fp_name character varying(50),
    printdoc character varying(250),
    dupchk character varying(500),
    directprint character varying(1),
    formula character varying(4000),
    formula_expr character varying(4000)
);

CREATE TABLE {schema}.axcalendar (
    axcalendarid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    calendarevent numeric(10,0),
    aftsaveflg character varying(1),
    transid character varying(5),
    eventname character varying(100),
    notifiedon date,
    sendername character varying(100),
    uname character varying(4000),
    unameemail text,
    messagetext text,
    eventtype character varying(250),
    axpdef_axcalendar_eventid numeric(15,0),
    startdate date,
    axptm_starttime character varying(10),
    enddate date,
    axptm_endtime character varying(10),
    location character varying(500),
    recurring character varying(20),
    isrecevent character varying(1),
    statusui character varying(30),
    status character varying(10),
    sqltext text,
    parenteventid numeric(15,0),
    emailalert character varying(1),
    eventstatus character varying(100),
    axpdef_axcalendar_eventstatusid numeric(15,0)
);

CREATE TABLE {schema}.axcardtypemaster (
    axcardtypemasterid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    cardtype character varying(15),
    cardcaption character varying(100),
    cardicon character varying(500),
    axpfile_cardimg character varying(4000),
    axpfilepath_cardimg character varying(1000)
);

CREATE TABLE {schema}.axconstraints (
    axconstraintsid numeric,
    cancel character varying(1),
    sourceid numeric,
    mapname character varying(20),
    username character varying(50),
    modifiedon date,
    createdby character varying(50),
    createdon date,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    constraint_name character varying(50),
    msg character varying(1000)
);

CREATE TABLE {schema}.axctx1 (
    atype character varying(10),
    axcontext character varying(75)
);

CREATE TABLE {schema}.axcustomviews (
    name character varying(25) NOT NULL,
    caption character varying(25),
    props text,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25),
    username character varying(30) NOT NULL,
    transid character varying(30) NOT NULL
);

CREATE TABLE {schema}.axdef_newfield (
    axdef_newfieldid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    formcaption character varying(500),
    stransid character varying(10),
    formtype numeric(10,0),
    dcname character varying(100),
    name character varying(50),
    caption character varying(200),
    flddupchk character varying(200),
    ftype character varying(100),
    fieldtype character varying(100),
    datatype character varying(20),
    width numeric(10,0),
    flddecimal numeric(4,0),
    dsformcaptionui character varying(250),
    dsformcaption character varying(250),
    dsform character varying(10),
    dsfieldui character varying(200),
    dsfield character varying(100),
    dsfieldcaption character varying(200),
    deflist text,
    apinamemo numeric(16,0),
    defsrcfieldui character varying(100),
    defsrcfield character varying(50),
    defsrcfieldcaption character varying(200),
    deftable text,
    rangeperiod character varying(1500),
    autogenprefix character varying(50),
    autogenprefixfld character varying(50),
    autogensno numeric(5,0),
    autogenno numeric(8,0),
    autogenstr character varying(50),
    exp_editor_formula text,
    exp_editor_valexpr text,
    allowduplicate character varying(1),
    allowempty character varying(1),
    fldposition character varying(30),
    "position" character varying(100),
    moe character varying(50),
    source character varying(50),
    sql_editor_psql text,
    savenormalised character varying(1),
    srcfield character varying(100),
    srctable character varying(100),
    savevalue character varying(1),
    hidden character varying(1),
    masterdl character varying(500),
    sourcedl character varying(500)
);

CREATE TABLE {schema}.axdelegatedtasks (
    fromuser character varying(30),
    sname character varying(5),
    recordid numeric(16,0),
    delegated character varying(1),
    del_user character varying(30),
    finalapprove character varying(1),
    uroles character varying(100)
);

CREATE TABLE {schema}.axdelegateusers (
    fromuser character varying(30),
    touser character varying(30),
    fromdate timestamp without time zone,
    todate timestamp without time zone
);

CREATE TABLE {schema}.axdirectsql (
    axdirectsqlid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    sqlname character varying(50),
    ddldatatype character varying(20),
    sqlsrc character varying(30),
    sqlsrccnd numeric(10,0),
    sqltext text,
    paramcal character varying(200),
    sqlparams character varying(2000),
    accessstring character varying(500),
    groupname character varying(50),
    sqlquerycols character varying(4000),
    cachedata character varying(1),
    cacheinterval character varying(10),
    encryptedflds character varying(4000),
    adsdesc text,
    smartlistcnd character varying(500)
);

CREATE TABLE {schema}.axdirectsql_metadata (
    axdirectsql_metadataid numeric(16,0) NOT NULL,
    axdirectsqlid numeric(16,0),
    axdirectsql_metadatarow integer,
    fldname character varying(100),
    fldcaption character varying(100),
    normalized character varying(10),
    sourcetable character varying(50),
    sourcefld character varying(50),
    datatypeui character varying(20),
    fdatatype character varying(2),
    filter character varying(20),
    hyp_structtype character varying(20),
    hyp_struct character varying(500),
    hyp_transid character varying(100),
    tbl_hyperlink character varying(8000),
    tbl_normalizedsource character varying(2000)
);

CREATE TABLE {schema}.axdsignconfig (
    axdsignconfigid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    stransid character varying(10),
    printdocname character varying(50),
    docnamefield character varying(50),
    pusername character varying(100),
    ordno character varying(10),
    doctype character varying(50),
    axpmailid numeric(15,0),
    mailid character varying(100),
    mobileno character varying(10),
    sendemail character varying(1),
    sendsms character varying(1),
    prolename character varying(50),
    rolename character varying(60)
);

CREATE TABLE {schema}.axdsignmail (
    axdsignmailid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    docid character varying(10),
    axpmailid numeric(15,0),
    docdate date,
    mailtype character varying(70),
    filename character varying(30),
    subject character varying(100),
    mailcontent character varying(2000),
    smscontent character varying(500)
);

CREATE TABLE {schema}.axdsigntrans (
    stransid character varying(5),
    doctype character varying(30),
    docdate timestamp without time zone,
    documentname character varying(50),
    username character varying(30),
    ordno numeric(5,0),
    status numeric(1,0),
    signedon timestamp without time zone,
    axpmailid integer,
    mailid character varying(30),
    mobileno character varying(10),
    sendmail character varying(1),
    sendsms character varying(1),
    mailstatus numeric(1,0) DEFAULT 0,
    smsstatus numeric(1,0) DEFAULT 0
);

CREATE TABLE {schema}.axentityrelations (
    axentityrelationsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    rtypeui character varying(10),
    rtype character varying(10),
    mstructui character varying(200),
    mstruct character varying(10),
    primarytable character varying(50),
    mfieldui character varying(200),
    mfield character varying(100),
    mtable character varying(50),
    dstructui character varying(200),
    dstruct character varying(10),
    dprimarytable character varying(50),
    dfieldui character varying(200),
    dfield character varying(100),
    dtable character varying(50),
    dupchk character varying(200)
);

CREATE TABLE {schema}.axerrorlog (
    username character varying(15) NOT NULL,
    eventdate timestamp without time zone NOT NULL,
    sname character varying(15),
    actname character varying(15),
    errormsg character varying(250)
);

CREATE TABLE {schema}.axexportjobs (
    jobid character varying(50),
    jobdate timestamp(0) without time zone,
    taskname character varying(25),
    datasource character varying(25),
    owner character varying(50),
    iviewname character varying(10),
    tstructname character varying(5),
    recordid numeric(16,0),
    starttime timestamp(0) without time zone,
    endtime timestamp(0) without time zone,
    status character varying(1000)
);

CREATE TABLE {schema}.axexportjobsexception (
    jobid character varying(50),
    recordid numeric(16,0),
    errormsg character varying(1000)
);

CREATE TABLE {schema}.axfastlink (
    transid character varying(15),
    caption character varying(50),
    output character varying(50),
    efont character varying(1),
    istemplate character varying(1)
);

CREATE TABLE {schema}.axfinworkflow (
    recordid numeric(16,0),
    comments character varying(250),
    updusername character varying(50),
    app_datetime character varying(25),
    app_level numeric(3,0),
    app_desc numeric(1,0)
);

CREATE TABLE {schema}.axformnotify (
    axformnotifyid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    form character varying(250),
    stransid character varying(10),
    active character varying(1),
    formula character varying(4000),
    formula_expr character varying(4000),
    notifyto character varying(500),
    notifytocnd character varying(20),
    usergroups character varying(4000),
    usernames character varying(4000),
    formfield character varying(250),
    formfieldname character varying(100),
    whatsapp_usernames character varying(4000),
    whatsapp_formfield character varying(250),
    sms_usernames character varying(4000),
    sms_formfield character varying(250),
    sms_formfieldname character varying(100),
    whatsapp_formfieldname character varying(100),
    isemailreq character varying(1),
    notify_msg_prints character varying(100),
    notify_sub_new character varying(4000),
    notify_msg_new text,
    notify_sub_edit character varying(4000),
    notify_msg_edit text,
    notify_sub_cancel character varying(4000),
    notify_msg_cancel text,
    notify_sub_delete character varying(4000),
    notify_msg_delete text,
    emailto character varying(250),
    emailto_usergroups character varying(4000),
    emailto_usernames character varying(4000),
    emailto_formfield character varying(500),
    emailto_formfieldname character varying(100),
    emailcc character varying(250),
    emailcc_usergroups character varying(4000),
    emailcc_usernames character varying(4000),
    emailcc_formfield character varying(250),
    emailcc_formfieldname character varying(100),
    emailbcc character varying(250),
    emailbcc_usergroups character varying(4000),
    emailbcc_usernames character varying(4000),
    emailbcc_formfield character varying(250),
    emailbcc_formfieldname character varying(100),
    email_msg_prints character varying(1000),
    email_msg_attachmentsui character varying(300),
    email_msg_attachments character varying(100),
    email_sub_new character varying(4000),
    email_msg_new text,
    email_sub_edit character varying(4000),
    email_msg_edit text,
    email_sub_cancel character varying(4000),
    email_msg_cancel text,
    email_sub_delete character varying(4000),
    email_msg_delete text,
    navigateto character varying(500),
    pagetype character varying(50),
    loadopen character varying(5),
    tbl_params character varying(250),
    tbl_paramval character varying(250),
    tbl_navigationparam character varying(8000)
);

CREATE TABLE {schema}.axglovar (
    axglovarid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    fromuserlogin character varying(1),
    axglo_user character varying(50),
    axp_displaytext character varying(1500),
    axglo_hide character varying(50),
    axpimageserver character varying(400),
    axpimagepath character varying(400)
);

CREATE TABLE {schema}.axgraphcols (
    name character varying(15),
    xaxiscolumn character varying(25),
    yaxiscolumn character varying(25),
    groupbycolumn character varying(25),
    filtercolumn character varying(25)
);

CREATE TABLE {schema}.axgraphsetting (
    name character varying(15),
    graphstyle numeric(1,0),
    barstyle character varying(255),
    barposition numeric(1,0),
    bottomaxis numeric(4,0),
    leftaxis numeric(4,0),
    rotation numeric(4,0),
    dvalue numeric(4,0),
    xlabelangle numeric(4,0),
    horizontallines numeric(1,0),
    verticallines numeric(1,0),
    showlegend numeric(1,0),
    view3d numeric(1,0),
    marks numeric(1,0),
    legendposition numeric(1,0),
    legendvalues numeric(1,0),
    markstyle numeric(1,0),
    piecircled numeric(1,0),
    piepattern numeric(1,0),
    formheight numeric(6,0),
    formwidth numeric(6,0),
    formtop numeric(6,0),
    formleft numeric(6,0),
    xaxisfsize numeric(4,0),
    xaxisfname character varying(100),
    xaxisfbold numeric(1,0),
    xaxisfitallic numeric(1,0),
    xaxisfunderline numeric(1,0),
    xaxisfst numeric(1,0),
    xaxisfcolor character varying(100),
    xcaptionfsize numeric(4,0),
    xcaptionfname character varying(100),
    xcaptionfbold numeric(1,0),
    xcaptionfitallic numeric(1,0),
    xcaptionfunderline numeric(1,0),
    xcaptionfst numeric(1,0),
    xcaptionfcolor character varying(100),
    yaxisfunderline numeric(1,0),
    yaxisfst numeric(1,0),
    yaxisfcolor character varying(100),
    ycaptionfsize numeric(4,0),
    ycaptionfname character varying(100),
    ycaptionfbold numeric(1,0),
    ycaptionfitallic numeric(1,0),
    ycaptionfunderline numeric(1,0),
    ycaptionfst numeric(1,0),
    ycaptionfcolor character varying(100),
    titlefsize numeric(4,0),
    titlefname character varying(100),
    titlefbold numeric(1,0),
    titlefitallic numeric(1,0),
    titlefunderline numeric(1,0),
    titlefst numeric(1,0),
    titlefcolor character varying(100),
    legendfsize numeric(4,0),
    legendfname character varying(100),
    legendfbold numeric(1,0),
    legendfitallic numeric(1,0),
    legendfunderline numeric(1,0),
    legendfst numeric(1,0),
    legendfcolor character varying(100),
    barcolor character varying(100),
    linecolor character varying(100),
    areacolor character varying(100),
    xcaption character varying(100),
    ycaption character varying(100),
    title character varying(100),
    legenddrawing numeric(1,0),
    legendtextstyle numeric(1,0),
    horizlinewidth numeric(3,0),
    horizlinecolor character varying(25),
    hlinestyle numeric(1,0),
    vertlinewidth numeric(3,0),
    vertlinecolor character varying(25),
    vlinestyle numeric(1,0),
    pierotationspeed numeric(5,0),
    invertyaxis numeric(1,0),
    invertxaxis numeric(1,0),
    showtoolbar numeric(1,0),
    showsettingbar numeric(1,0),
    formborderstyle numeric(1,0)
);

CREATE TABLE {schema}.axgrouping (
    axgroupingid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    grpname character varying(250),
    grpvalue character varying(4000),
    dupchk character varying(4000),
    grpparent character varying(200),
    grpnamedb character varying(100),
    parentgrp character varying(100)
);

CREATE TABLE {schema}.axgroupingmst (
    axgroupingmstid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    grpname character varying(25),
    grpcaption character varying(250),
    dc2fldprops character varying(4000),
    dc3fldprops character varying(4000),
    parentgrp character varying(100)
);

CREATE TABLE {schema}.axgrouptstructs (
    formcap character varying(500),
    ftransid character varying(10)
);

CREATE TABLE {schema}.axi_command_prompts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cmdtoken integer,
    wordpos integer,
    prompt character varying(200),
    promptsource character varying(500),
    promptparams character varying(100),
    promptvalues character varying(500),
    props character varying(100),
    extraparams character varying(1000),
    requesturl character varying(2000)
);

CREATE TABLE {schema}.axi_commands (
    cmdtoken integer NOT NULL,
    command_group character varying(50) NOT NULL,
    command character varying(50) NOT NULL
);

CREATE TABLE {schema}.axiconmenu (
    parentpagename character varying(50) NOT NULL,
    iconname character varying(50)
);

CREATE TABLE {schema}.aximpappping (
    ttransid character varying(5),
    jobid character varying(100),
    application character varying(10),
    threadno character varying(3),
    username character varying(30),
    pingedon character varying(25),
    status character varying(30),
    remarks character varying(4000)
);

CREATE TABLE {schema}.aximpdatauploadjobs (
    jobid character varying(100),
    ttransid character varying(5),
    dnstructure character varying(5),
    actname character varying(15),
    temptablename character varying(30),
    primaryfield character varying(30),
    groupfield character varying(30),
    selectscript character varying(4000),
    username character varying(20),
    createdon timestamp without time zone,
    updatedon timestamp without time zone,
    starttime timestamp without time zone,
    endtime timestamp without time zone,
    status character varying(50),
    remarks character varying(1000)
);

CREATE TABLE {schema}.aximpdef (
    aximpdefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    aximpdefname character varying(100),
    aximpform character varying(100),
    aximptransid character varying(10),
    aximptextqualifier character varying(1),
    aximpmapinfile character varying(1),
    aximpheaderrows numeric(3,0),
    aximpprimayfield character varying(50),
    aximpgroupfield character varying(50),
    aximpfieldseperatorui character varying(100),
    aximpfieldseperator character varying(15),
    aximpmapfields character varying(2000),
    aximpthreadcount numeric(2,0),
    aximpprocname character varying(100),
    aximpbindtotstruct character varying(1),
    aximpstdcolumnwidth numeric(5,0),
    aximpignorefldexception character varying(1),
    aximponlyappend character varying(1),
    aximpprocessmode character varying(30),
    aximpfilefromtable character varying(1),
    aximpprimaryfield_details character varying(200)
);

CREATE TABLE {schema}.aximpfailedrecords (
    jobid character varying(100),
    ttransid character varying(5),
    recordid numeric(15,0),
    primaryfield character varying(500),
    status character varying(4000),
    createdon timestamp without time zone,
    mapname character varying(10),
    parenttransid character varying(5),
    parentrecordid numeric(15,0),
    tmptblrowno numeric(10,0)
);

CREATE TABLE {schema}.aximpjobs (
    jobid character varying(100),
    sessionid character varying(30),
    jobdate timestamp without time zone,
    aximpdefname character varying(100),
    act_script_name character varying(100),
    aximptransid character varying(10),
    aximptextqualifier character varying(1),
    aximpmapinfile character varying(1),
    aximpheaderrows numeric(10,0),
    aximpprimayfield character varying(50),
    aximpprimaryfield_details character varying(4000),
    aximpgroupfield character varying(50),
    aximpfieldseperator character varying(1),
    aximpmapfields character varying(2000),
    aximpthreadcount numeric(2,0),
    aximpprocname character varying(100),
    aximpbindtotstruct character varying(1),
    aximpstdcolumnwidth numeric(5,0),
    aximpignorefldexception character varying(1),
    aximponlyappend character varying(1),
    aximpprocessmode character varying(30),
    dbdirpath character varying(250),
    filename character varying(500),
    threadcount numeric(2,0),
    username character varying(20),
    status character varying(500)
);

CREATE TABLE {schema}.aximportdef (
    actname character varying(30),
    ttransid character varying(5),
    transcaption character varying(100),
    textqualifier character varying(1),
    mapinfile character varying(1),
    bgact character varying(1),
    headerrows numeric(2,0),
    primaryfield character varying(50),
    groupfield character varying(50),
    fieldseperator character varying(1),
    mapfields character varying(4000),
    dbdirpath character varying(200),
    filepath character varying(200),
    threadcount character varying(3),
    procname character varying(100),
    bindtotstruct character varying(1),
    stdcolumnwidth numeric(4,0),
    ignorefldexception character varying(1),
    onlyappend character varying(1),
    transid character varying(5),
    impprocessmode numeric(1,0),
    filefromtable character varying(1)
);

CREATE TABLE {schema}.aximportjobs (
    jobid character varying(30),
    jobdate timestamp(0) without time zone,
    actname character varying(30),
    ttransid character varying(5),
    dbdirpath character varying(250),
    filepath character varying(250),
    filename character varying(100),
    threadcount numeric(2,0),
    ip character varying(15),
    username character varying(20),
    status character varying(500),
    uname character varying(20),
    ordseq numeric(3,0),
    transid character varying(5)
);

CREATE TABLE {schema}.axinqueues (
    axinqueuesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    axqueuename character varying(100),
    axqueuedesc text,
    unameui character varying(200),
    uname character varying(100),
    secretkey character varying(16),
    active character varying(1),
    defqueu character varying(1)
);

CREATE TABLE {schema}.axinqueuesdata (
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    axqueuename character varying(100),
    transid character varying(10),
    recordid numeric,
    queuedata text
);

CREATE TABLE {schema}.axivuserconfig (
    rolename character varying(50),
    username character varying(50),
    userlevel numeric(2,0),
    reportname character varying(10),
    paramname character varying(50),
    propname character varying(10),
    propvalue character varying(4000)
);

CREATE TABLE {schema}.axlangsource (
    langname character varying(15),
    fontcharset character varying(25),
    fontname character varying(25),
    fontsize numeric(3,0)
);

CREATE TABLE {schema}.axlanguage (
    lngname character varying(25) NOT NULL,
    sname character varying(16) NOT NULL,
    fontname character varying(30),
    fontsize numeric(3,0),
    compname character varying(50) NOT NULL,
    compcaption character varying(300),
    comphint character varying(300),
    dispname character varying(75)
);

CREATE TABLE {schema}.axlanguage11x (
    axlanguage11xid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    dispname character varying(100),
    sname character varying(100),
    compname character varying(100),
    compengcap character varying(4000),
    compcaption character varying(4000),
    comphint character varying(4000),
    lngname character varying(20),
    fontname character varying(100),
    fontsize numeric(3,0)
);

CREATE TABLE {schema}.axliccontrol (
    licid character varying(10),
    regkey bytea,
    mlicid bytea,
    alicid bytea,
    dlicid bytea,
    llicid bytea,
    lictrans bytea,
    mdt character varying(25),
    adt character varying(25),
    blobno numeric(1,0)
);

CREATE TABLE {schema}.axlictrans (
    licid character varying(19) NOT NULL,
    lictrans character varying(15)
);

CREATE TABLE {schema}.axlov (
    axlovid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    group_name character varying(30),
    value_name character varying(30),
    dupcheck character varying(60),
    identifier character varying(10),
    disp_order numeric(10,0),
    activeyes character varying(10)
);

CREATE TABLE {schema}.axmaudit (
    sessionid character varying(30),
    username character varying(50),
    logintime timestamp without time zone,
    status character varying(20),
    reason character varying(150),
    other character varying(200),
    logouttime timestamp without time zone,
    nologout character varying(1)
);

CREATE TABLE {schema}.axmconnections (
    sessionid character varying(50),
    logintime timestamp without time zone,
    username character varying(50),
    usergroup character varying(250),
    groupno numeric(7,0),
    project character varying(50),
    pageaccess character varying(250),
    appvars text,
    userroles character varying(250),
    transidlist text
);

CREATE TABLE {schema}.axmessage (
    msgid numeric(15,0),
    groupid numeric(15,0),
    fromwhom character varying(30),
    towhom character varying(30),
    fromstatus numeric(2,0),
    status numeric(2,0),
    upddatetime character varying(30),
    readstatus numeric(2,0),
    message character varying(4000),
    towhoms character varying(3000)
);

CREATE TABLE {schema}.axmessage_archive (
    msgid numeric(15,0),
    groupid numeric(15,0),
    fromwhom character varying(30),
    towhom character varying(30),
    fromstatus numeric(2,0),
    tostatus numeric(2,0),
    upddatetime character varying(30),
    readstatus numeric(2,0),
    message character varying(4000),
    towhoms character varying(3000)
);

CREATE TABLE {schema}.axmmetadatamaster (
    structtype character varying(10),
    structname character varying(15),
    structcaption character varying(50),
    structstatus character varying(50),
    ordno integer,
    createdon timestamp without time zone DEFAULT now(),
    updatedon timestamp without time zone DEFAULT now(),
    createdby character varying(50),
    updatedby character varying(50)
);

CREATE TABLE {schema}.axmtranscontrol (
    username character varying(50),
    transid character varying(5),
    sessionid character varying(30),
    recordid numeric(16,0),
    loadedon timestamp without time zone
);

CREATE TABLE {schema}.axmwslog (
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    structname character varying(16),
    recordid numeric(15,0),
    timetaken numeric(10,0),
    dbtimetaken numeric(10,0),
    servicename character varying(50),
    serviceresult character varying(200),
    callfinished timestamp without time zone
);

CREATE TABLE {schema}.axmyviews (
    viewname character varying(50) NOT NULL,
    iname character varying(10) NOT NULL,
    username character varying(50) NOT NULL,
    params text,
    filtercond text,
    sortcond character varying(50),
    hiddencols text
);

CREATE TABLE {schema}.axnotificationdef (
    axnotificationdefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    name character varying(200),
    processname character varying(250),
    taskname character varying(250),
    indexno numeric(2,0),
    ttransid character varying(10),
    notifyto character varying(50),
    fromfieldcaption character varying(500),
    fromfieldname character varying(200),
    roles character varying(4000),
    actors character varying(250),
    taskparams character varying(500),
    tasklist character varying(500),
    emailaddr character varying(4000),
    enableemail character varying(3),
    enablesms character varying(3),
    enablewhatsapp character varying(3),
    enablemobilenotify character varying(3),
    emailsubject character varying(1000),
    emailattachment character varying(4000),
    emailtext text,
    notifyto_cc character varying(4000),
    fromfieldcaption_cc character varying(500),
    roles_cc character varying(4000),
    fromfieldname_cc character varying(200),
    actors_cc character varying(200),
    taskparams_cc character varying(500),
    tasklist_cc character varying(500),
    emailaddr_cc character varying(4000),
    notifyto_bcc character varying(4000),
    fromfieldcaption_bcc character varying(200),
    fromfieldname_bcc character varying(200),
    roles_bcc character varying(4000),
    actors_bcc character varying(500),
    taskparams_bcc character varying(500),
    tasklist_bcc character varying(500),
    emailaddr_bcc character varying(4000),
    smstext text,
    whatsapptext text,
    mobile_title character varying(500),
    mobile_content text
);

CREATE TABLE {schema}.axonlineconvlog (
    script text,
    errmsg character varying(8000),
    tablename character varying(100)
);

CREATE TABLE {schema}.axoutqueues (
    axoutqueuesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    axqueuename character varying(100),
    axqueuedesc text,
    active character varying(1),
    axqueuesource character varying(20),
    formcaption character varying(250),
    stransid character varying(10),
    allfields character varying(1),
    formfields character varying(8000),
    fieldnames character varying(4000),
    primaryfieldui character varying(200),
    primaryfield character varying(100),
    printforms character varying(1),
    fastprints character varying(4000),
    fileattachments character varying(1),
    datasource character varying(200),
    onformdata character varying(1),
    ds_forms character varying(8000),
    ds_stransid character varying(4000),
    ds_interval character varying(20)
);

CREATE TABLE {schema}.axoutqueuesdata (
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    axqueuename character varying(100),
    transid character varying(10),
    recordid numeric,
    queuedata text
);

CREATE TABLE {schema}.axoutqueuesmst (
    axoutqueuesmstid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    axqueuename character varying(100),
    axqueuedesc text,
    defqueue character varying(1)
);

CREATE TABLE {schema}.axp__appmgrms1 (
    axp__appmgrms1id numeric,
    cancel character(1),
    sourceid numeric,
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250)
);

CREATE TABLE {schema}.axp__appmgrss1 (
    axp__appmgrss1id numeric,
    cancel character(1),
    sourceid numeric,
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250)
);

CREATE TABLE {schema}.axp_appmgr (
    tstruct character varying(5),
    fname character varying(25)
);

CREATE TABLE {schema}.axp_appsearch_data (
    cancel character(1),
    sourceid integer,
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    hltype character varying(10),
    structname character varying(50),
    searchtext character varying(500),
    params character varying(500),
    axp_appsearch_dataid numeric(16,0)
);

CREATE TABLE {schema}.axp_appsearch_data_v2 (
    hltype character varying(10),
    structname character varying(25),
    searchtext character varying(200),
    params character varying(150),
    createdon date DEFAULT CURRENT_DATE,
    docid character varying(50)
);

CREATE TABLE {schema}.axpages (
    name character varying(15) NOT NULL,
    caption character varying(50),
    props text,
    blobno numeric(3,0) NOT NULL,
    img character varying(50),
    visible character(1),
    type character(1),
    parent character varying(15),
    ordno numeric(5,0),
    levelno numeric(5,0),
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25),
    category character varying(30),
    pagetype character varying(15),
    intview character varying(1),
    webenable character varying(1),
    shortcut character varying(30),
    icon character varying(100),
    websubtype character varying(15),
    workflow character varying(5),
    oldappurl character varying(500)
);

CREATE TABLE {schema}.iviews (
    name character varying(15) NOT NULL,
    caption character varying(2000),
    props text,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(50),
    updatedby character varying(50),
    importedby character varying(50),
    readonly character varying(1),
    updusername character varying(25)
);

CREATE TABLE {schema}.axuseraccess (
    rname character varying(50) NOT NULL,
    sname character varying(15) NOT NULL,
    stype character varying(1) NOT NULL,
    props text,
    blobno numeric(3,0),
    updatedon character varying(25),
    actflag character varying(1)
);

CREATE TABLE {schema}.axusergroups (
    groupno numeric(7,0),
    groupname character varying(30) NOT NULL,
    userroles character varying(250),
    actflag character varying(1),
    roletype character varying(20),
    active character varying(1),
    dhomepage character varying(100),
    axusergroupsid numeric(15,0),
    cancel character varying(10),
    sourceid numeric(15,0),
    cancelremarks character varying(150),
    homepage character varying(255) DEFAULT NULL::character varying,
    selfregistration character varying(10),
    approvedby character varying(2000),
    apprequired character varying(1),
    mapname character varying(20)
);

CREATE TABLE {schema}.axusergroupsdetail (
    axusergroupsdetailid numeric(16,0) NOT NULL,
    axusergroupsid numeric(16,0),
    axusergroupsdetailrow integer,
    roles_id character varying(100)
);

CREATE TABLE {schema}.axuserlevelgroups (
    username character varying(30),
    usergroup character varying(30),
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    axuserlevelgroupsrow numeric(4,0),
    axusername character varying(50),
    axusergroup character varying(30),
    axusersid numeric(15,0),
    axuserlevelgroupsid numeric(15,0)
);

CREATE TABLE {schema}.axp_appsearch_data_period (
    axp_appsearch_data_periodid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    docid character varying(30),
    hltype character varying(10),
    caption character varying(100),
    structname character varying(30),
    action character varying(10),
    periodically character varying(1),
    searchfor character varying(50),
    period character varying(20),
    searchtext character varying(200),
    periodfromdt character varying(100),
    periodtodt character varying(100),
    fromdt character varying(30),
    todt character varying(30),
    duplicate character varying(150),
    dynamicparam character varying(1),
    srctrans character varying(100),
    srctransid character varying(10),
    tsrcfield character varying(100),
    srcfield character varying(50),
    dcname character varying(10),
    srctable character varying(100),
    paramvalue character varying(100),
    sourcefieldchanged character varying(1),
    srcmultipletransid character varying(10),
    params character varying(200),
    triggerscripts character varying(1000)
);

CREATE TABLE {schema}.axp_appsearchdtl (
    axp_appsearchdtlid numeric(16,0) NOT NULL,
    axp_appsearch_dataid numeric(16,0),
    axp_appsearchdtlrow integer,
    paramcaption character varying(500),
    paramname character varying(500),
    paramvalue character varying(500),
    tiviewparams character varying(500),
    refsearchtext character varying(500)
);

CREATE TABLE {schema}.axp_cards (
    axp_cardsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon date,
    createdby character varying(50),
    createdon date,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    cardtypeui character varying(500),
    cardtype character varying(30),
    cardicon character varying(100),
    charttype character varying(50),
    sql_editor_cardsql text,
    cardname character varying(100),
    heightui numeric(10,0),
    height character varying(10),
    widthui character varying(20),
    width character varying(10),
    cachedata character varying(20),
    autorefresh numeric(10,0),
    orderno numeric(10,0),
    clrpalet character varying(20),
    trufalse character varying(20),
    chartprops character varying(4000),
    accessstringui character varying(1000),
    chartjson character varying(4000),
    accessstring character varying(1000),
    axpfile_imgcard character varying(100),
    con_name character varying(100),
    pagecaption character varying(100),
    axpfilepath_imgcard character varying(100),
    pagename character varying(20),
    cardbgclr character varying(20),
    hcaption character varying(1000),
    isparentpage character varying(10),
    htype character varying(20),
    pagedesc text,
    htranstypeui character varying(200),
    htransid character varying(10),
    is_migrated character varying(1),
    html_editor_card text,
    calendarsource character varying(250),
    calendarstransid character varying(10),
    dashboardcard character varying(1),
    processcard character varying(1),
    exp_editor_buttons text,
    inchart character varying(1),
    inhomepage character varying(1),
    card_datasource character varying(100),
    pluginname character varying(200),
    indashboard character varying(1)
);

CREATE TABLE {schema}.axp_customdatatype (
    axp_customdatatypeid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    typename character varying(20),
    datatype character varying(20),
    width numeric(4,0),
    dwidth numeric(1,0),
    isactive character varying(1),
    isspldatatpye character varying(1),
    spldatatype character varying(10)
);

CREATE TABLE {schema}.axp_customtypes (
    typename character varying(15),
    datatype character varying(10),
    width numeric(4,0),
    deci numeric(2,0)
);

CREATE TABLE {schema}.axp_dbwdetails (
    axp_dbwdetailsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    title character varying(200),
    subtitle character varying(200),
    graphtype character varying(50),
    piecolor character varying(100),
    linkname character varying(40),
    sqltext text,
    hyptext character varying(500),
    flinkname character varying(10),
    uname character varying(60),
    chartgroup character varying(100)
);

CREATE TABLE {schema}.axp_dependent (
    tstruct character varying(5),
    parentfield character varying(30),
    childfield character varying(30),
    dependenttype character varying(5),
    frmno numeric(3,0),
    fldsql character varying(4000),
    active character varying(5),
    userdefined character varying(5)
);

CREATE TABLE {schema}.axp_files (
    filename character varying(200),
    storedon timestamp without time zone,
    filecontent text,
    blobno numeric(3,0),
    status character varying(1000)
);

CREATE TABLE {schema}.axp_formload (
    tstruct character varying(5),
    context character varying(20),
    fieldname character varying(30),
    fldsql character varying(4000),
    frmno numeric(3,0),
    active character varying(5),
    userdefined character varying(5)
);

CREATE TABLE {schema}.axp_mailjobs (
    mailto character varying(1000),
    mailcc character varying(1000),
    subject character varying(1000),
    body text,
    recipientcategory character varying(500),
    enquiryno character varying(30),
    attachments character varying(1000),
    iviewname character varying(10),
    iviewparams character varying(500),
    transid character varying(10),
    recordid numeric(16,0),
    status numeric(2,0),
    errormessage character varying(500),
    senton date,
    jobid numeric(15,0),
    jobdate date
);

CREATE TABLE {schema}.axp_params (
    tstruct character varying(5),
    context character varying(20),
    childfield character varying(30),
    paramname character varying(30),
    paramtype character varying(30),
    allrows character varying(5),
    frmno numeric(3,0),
    fldsql character varying(4000),
    active character varying(5),
    userdefined character varying(5),
    dirparam character varying(1)
);

CREATE TABLE {schema}.axp_reportjobs (
    jobid numeric(10,0) NOT NULL,
    jobdate timestamp without time zone,
    iviewname character varying(8),
    iviewparams character varying(500),
    transid character varying(5),
    recordid numeric(16,0),
    status numeric(1,0),
    errormessage character varying(1000),
    senton timestamp without time zone,
    filepath character varying(100),
    tablename character varying(30),
    sjobid character varying(50)
);

CREATE TABLE {schema}.axp_sales_data (
    first_name character varying(50),
    country character varying(50),
    sales_year integer,
    sales_qty integer,
    sales_amount integer
);

CREATE TABLE {schema}.axp_smartviews_config (
    username character varying(100) NOT NULL,
    ivname character varying(15) NOT NULL,
    config_data text,
    createdon character varying(50),
    createdby character varying(100),
    updatedon character varying(50),
    updatedby character varying(100)
);

CREATE TABLE {schema}.axp_struct_release_log (
    createdon timestamp without time zone DEFAULT now(),
    axpversion character varying(100)
);

CREATE TABLE {schema}.axp_tabledescriptor (
    axp_tabledescriptorid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    dname character varying(50),
    tjson text,
    isactive character varying(1)
);

CREATE TABLE {schema}.axp_transcheck (
    sessionid character varying(50)
);

CREATE TABLE {schema}.axp_tstructprops (
    name character varying(5),
    caption character varying(500),
    keyfield character varying(200),
    userconfigured character(1),
    createdon character varying(30),
    updatedon character varying(30),
    createdby character varying(100),
    updatedby character varying(100)
);

CREATE TABLE {schema}.axp_versionchangedetails (
    verno character varying(50),
    transid character varying(50),
    name character varying(200),
    stype character varying(100),
    status character varying(20),
    property character varying(100),
    oldvalue character varying(250),
    newvalue character varying(250),
    blobno numeric(3,0),
    oldvalueclob text,
    newvalueclob text
);

CREATE TABLE {schema}.axp_versionchanges (
    verno character varying(50),
    stype character varying(20),
    name character varying(20),
    caption character varying(50),
    createdby character varying(25),
    createdon character varying(25),
    updatedby character varying(25),
    updatedon character varying(25)
);

CREATE TABLE {schema}.axp_versions (
    verno character varying(50),
    domainname character varying(50),
    servername character varying(50),
    publishedon character varying(50),
    publishedby character varying(30),
    publishedfrom character varying(20),
    comments text,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.axp_vp (
    axp_vpid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    isconstant character varying(1),
    isvariable character varying(1),
    isappparam character varying(1),
    vpname character varying(50),
    isparam character varying(1),
    vscript text,
    pcaption character varying(100),
    pdatatype character varying(20),
    modeofentry character varying(10),
    masterdlui character varying(200),
    masterdl character varying(200),
    source character varying(200),
    sql_editor_psql text,
    vpvalue character varying(300),
    display character varying(1),
    readonly character varying(1),
    postaccept character varying(10),
    postselect character varying(10),
    customdatatype character varying(100),
    datawidth numeric(10,0),
    ttransid character varying(10),
    dcselect character varying(200),
    remarks text,
    masterdlselect character varying(200)
);

CREATE TABLE {schema}.axp_webtrace (
    username character varying(50),
    sessionid character varying(50),
    datetime timestamp without time zone,
    logtext text
);

CREATE TABLE {schema}.axpagedetail (
    name character varying(15),
    sname character varying(15),
    stype character varying(1)
);

CREATE TABLE {schema}.axpcal (
    axpcalid numeric(18,0) NOT NULL,
    profitdoc character(1),
    approval numeric(38,0),
    approvalstatus character(1),
    maxapproved numeric(2,0),
    cancel character(1),
    sourceid numeric(38,0),
    mapname character varying(20),
    stdate timestamp without time zone,
    sttime character varying(10),
    enddate timestamp without time zone,
    endtime character varying(10),
    task character varying(80),
    recordid numeric(15,0),
    active character varying(10),
    status character varying(20),
    transid character varying(5),
    unameid numeric(15,0),
    inv character varying(5),
    pagename character varying(20)
);

CREATE TABLE {schema}.axpclouddevsettings (
    userid character varying(50),
    tranid character varying(200),
    type character varying(50),
    value text
);

CREATE TABLE {schema}.axpdc (
    tstruct character varying(5),
    dname character varying(10),
    caption character varying(2000),
    tablename character varying(50),
    asgrid character varying(1),
    allowchange character varying(1),
    allowempty character varying(1),
    popup character varying(1),
    dcno numeric(2,0),
    addrow character varying(1),
    deleterow character varying(1),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    purpose text
);

CREATE TABLE {schema}.axpdef_axcalendar_event (
    axpdef_axcalendar_eventid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    eventname character varying(250),
    eventcolor character varying(50)
);

CREATE TABLE {schema}.axpdef_axcalendar_eventstatus (
    axpdef_axcalendar_eventstatusid numeric(16,0) NOT NULL,
    axpdef_axcalendar_eventid numeric(16,0),
    axpdef_axcalendar_eventstatusrow integer,
    eventstatus character varying(200),
    eventstatcolor character varying(50)
);

CREATE TABLE {schema}.axpdef_axpertapi (
    axpdef_axpertapiid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    apicategory character varying(30),
    page character varying(10),
    pagecaption character varying(200),
    pagename character varying(10),
    pagescript character varying(100),
    pagescriptname character varying(10),
    fldcnd numeric(10,0),
    formcaption character varying(200),
    tname character varying(5),
    dd_caption character varying(100),
    fldname character varying(100),
    iviewcaption character varying(200),
    iname character varying(8),
    sql_reffield numeric(16,0),
    sql_editor_apiquery text,
    sql_output character varying(1),
    apiurl character varying(2000),
    reqformat text,
    res_success text,
    res_fail text
);

CREATE TABLE {schema}.axpdef_axpertprops (
    axpdef_axpertpropsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    smtphost character varying(200),
    smtpport numeric(4,0),
    smtpuser character varying(200),
    smtppwd character varying(50),
    axpsiteno numeric(10,0),
    amtinmillions character varying(1),
    currseperator character varying(1),
    lastlogin character varying(1),
    autogen character varying(1),
    customfrom character varying(20),
    customto character varying(20),
    loginattempt numeric(2,0),
    pwdexp numeric(4,0),
    pwdchange numeric(4,0),
    pwdminchar numeric(2,0),
    pwdmaxchar numeric(4,0),
    pwdreuse numeric(2,0),
    pwdencrypt character varying(1),
    pwdalphanum character varying(1),
    pwdcapchar numeric(2,0),
    pwdsmallchar numeric(2,0),
    pwdnumchar numeric(2,0),
    pwdsplchar numeric(2,0),
    emailsubject character varying(250),
    emailbody text,
    smscontent text,
    onlysso character varying(1),
    sso_windows character varying(1),
    sso_saml character varying(1),
    sso_office365 character varying(1),
    sso_okta character varying(1),
    sso_google character varying(1),
    sso_facebook character varying(1),
    sso_openid character varying(1),
    tbl_windows character varying(2000),
    tbl_saml character varying(4000),
    tbl_okta character varying(4000),
    tbl_office365 character varying(4000),
    tbl_google character varying(4000),
    tbl_facebook character varying(4000),
    tbl_openid character varying(4000),
    otpauth character varying(1),
    otpchars character varying(1),
    otpexpiry character varying(10),
    mob_citizenuser character varying(1),
    mob_geofencing character varying(1),
    mob_geotag character varying(1),
    mob_fingerauth character varying(1),
    mob_faceauth character varying(1),
    mob_forcelogin character varying(1),
    mob_forceloginusers character varying(4000)
);

CREATE TABLE {schema}.axpdef_axvars (
    axpdef_axvarsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    transid character varying(5),
    db_function character varying(500),
    db_function_params character varying(4000),
    event_onlogin character varying(1),
    event_onformload character varying(1),
    forms character varying(4000),
    forms_transid character varying(4000),
    event_onreportload character varying(1),
    reports character varying(4000),
    reports_transid character varying(4000),
    isdbobj character varying(1),
    remarks text
);

CREATE TABLE {schema}.axpdef_axvars_dbvar (
    axpdef_axvars_dbvarid numeric(16,0) NOT NULL,
    axpdef_axvarsid numeric(16,0),
    axpdef_axvars_dbvarrow integer,
    db_varname character varying(200),
    db_varcaption character varying(500),
    db_varval character varying(500),
    db_vartype character varying(100)
);

CREATE TABLE {schema}.axpdef_impdata_templates (
    axpdef_impdata_templatesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    templatename character varying(25),
    stransid character varying(10),
    dupchk character varying(50),
    templatecap character varying(100),
    impfields character varying(4000),
    dataupd character varying(1),
    fldpkey character varying(200)
);

CREATE TABLE {schema}.axpdef_jobs (
    axpdef_jobsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    jname character varying(100),
    priority character varying(1),
    prefix character varying(10),
    jobid character varying(15),
    exp_editor_jobscript text,
    formload character varying(200),
    formtransid character varying(10),
    formevent character varying(20),
    jobschedule character varying(50),
    weekday character varying(15),
    jday character varying(2),
    axptm_starttime character varying(10),
    jhrs character varying(2),
    jminutes character varying(2),
    ampm character varying(2),
    noofhrs character varying(10),
    noofmins character varying(2),
    jobstartfrom date,
    jobdesc character varying(500),
    status numeric(1,0),
    lastrun date,
    remarks character varying(500),
    isactive character varying(1),
    isdefault character varying(1),
    jobdatechar character varying(10),
    jobstarttime character varying(20),
    appname character varying(50),
    rediskeyname character varying(100),
    rediskeyval character varying(200),
    deletekey character varying(100),
    redisserver character varying(50),
    deletepending character varying(1),
    rmq_version numeric(10,0),
    rmq_json text
);

CREATE TABLE {schema}.axpdef_language (
    axpdef_languageid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    language character varying(100),
    fontcharset character varying(25),
    exportto character varying(1000),
    fontname character varying(200),
    fontsize character varying(10),
    exportfiles character varying(1000),
    expalltstruct character varying(10),
    expalliview character varying(10),
    tstructcap character varying(4000),
    tstructnames character varying(4000),
    iviewcap character varying(4000),
    iviewnames character varying(4000),
    uploadfiletype character varying(20)
);

CREATE TABLE {schema}.axpdef_news_events (
    axpdef_news_eventsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    title character varying(500),
    subdetails text,
    redirecturl character varying(500),
    effectfrom date,
    effecto date,
    active character varying(1)
);

CREATE TABLE {schema}.axpdef_peg_actor (
    axpdef_peg_actorid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    process character varying(100),
    taskname character varying(200),
    actorname character varying(2000),
    axpdef_peg_processmasterid numeric(15,0),
    dupchk character varying(2000),
    acttype numeric(10,0),
    assignmode character varying(20),
    assignmodecnd numeric(1,0),
    olddefusername character varying(4000),
    defusername character varying(4000),
    axprocessdefv2id numeric(15,0),
    stransid character varying(10),
    priorindextransid character varying(10),
    datagrpgrid character varying(100),
    applicableto character varying(30),
    applicablecnd numeric(10,0),
    sprocessname character varying(4000)
);

CREATE TABLE {schema}.axpdef_peg_actorusergrp (
    axpdef_peg_actorusergrpid numeric(16,0) NOT NULL,
    axpdef_peg_actorid numeric(16,0),
    axpdef_peg_actorusergrprow integer,
    usergroupname character varying(100),
    usergrpcode character varying(50),
    oldugrpusername character varying(4000),
    ugrpusername character varying(4000),
    ug_actorname character varying(250)
);

CREATE TABLE {schema}.axpdef_peg_grpfilter (
    axpdef_peg_grpfilterid numeric(16,0) NOT NULL,
    axpdef_peg_actorid numeric(16,0),
    axpdef_peg_grpfilterrow integer,
    cndopr character varying(50),
    fldcnd character varying(1000),
    dg_actorname character varying(250),
    dgname character varying(100),
    tbl_datagrp character varying(4000),
    olddatagrpusers character varying(4000),
    datagrpusers character varying(4000)
);

CREATE TABLE {schema}.axpdef_peg_processmaster (
    axpdef_peg_processmasterid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    caption character varying(200),
    processowner character varying(300),
    axpicon_process character varying(100),
    processdesc text,
    powner character varying(250),
    pownerflg numeric(2,0),
    processtable character varying(50),
    createscr character varying(4000),
    amendment character varying(1),
    cards character varying(4000),
    amendconfirm character varying(1),
    amendconfirmmsg text
);

CREATE TABLE {schema}.axpdef_peg_usergroups (
    username character varying(100),
    usergroupname character varying(500),
    usergroupcode character varying(200),
    active character varying(1),
    effectivefrom timestamp without time zone,
    fromuser character varying(1) DEFAULT 'F'::character varying
);

CREATE TABLE {schema}.axpdef_prcards (
    axpdef_prcardsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    cardtype character varying(20),
    charttype character varying(50),
    cardname character varying(100),
    sql_editor_cardsql text,
    chartprops character varying(2000),
    chartjson character varying(4000)
);

CREATE TABLE {schema}.axpdef_publishapi (
    axpdef_publishapiid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    publickey character varying(30),
    secretkey character varying(20),
    secretkeyflg character varying(10),
    apitype character varying(50),
    structcapui character varying(250),
    structcapuiname character varying(50),
    objdatasrc character varying(4000),
    structcap character varying(4000),
    objname character varying(4000),
    scriptcapui character varying(100),
    scriptcap character varying(10),
    printform character varying(50),
    unameui character varying(150),
    uname character varying(100),
    apirequeststring text,
    apisuccess text,
    apierror text
);

CREATE TABLE {schema}.axpdef_ruleeng (
    axpdef_ruleengid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    rulename character varying(200),
    formcaption character varying(200),
    stransid character varying(10),
    uroles character varying(4000),
    formula character varying(8000),
    formula_expr character varying(4000),
    active character varying(1),
    isapplicableui character varying(4000),
    showfieldsui character varying(4000),
    hidefieldsui character varying(4000),
    enablefieldsui character varying(4000),
    disablefieldsui character varying(4000),
    mandatoryfieldsui character varying(4000),
    nonmandatoryfieldsui character varying(4000),
    fldsmasking character varying(8000),
    readonly character varying(1),
    cachedsave character varying(1),
    exp_editor_scriptload text,
    exp_editor_onsubmit text
);

CREATE TABLE {schema}.axpdef_ruleeng_expr (
    axpdef_ruleeng_exprid numeric(16,0) NOT NULL,
    axpdef_ruleengid numeric(16,0),
    axpdef_ruleeng_exprrow integer,
    flds_expr character varying(500),
    fldname_expr character varying(50),
    exp_editor_expr text
);

CREATE TABLE {schema}.axpdef_ruleeng_fctl (
    axpdef_ruleeng_fctlid numeric(16,0) NOT NULL,
    axpdef_ruleengid numeric(16,0),
    axpdef_ruleeng_fctlrow integer,
    cmd character varying(50),
    fldcomps character varying(4000),
    tbl_comps character varying(4000)
);

CREATE TABLE {schema}.axpdef_ruleeng_masks (
    axpdef_ruleeng_masksid numeric(16,0) NOT NULL,
    axpdef_ruleengid numeric(16,0),
    axpdef_ruleeng_masksrow integer,
    mask_fldcap character varying(250),
    mask_fldname character varying(50),
    maskcmd character varying(30),
    mask_pcnd numeric(10,0),
    maskchar character varying(5),
    firstnchar numeric(10,0),
    lastnchar numeric(10,0)
);

CREATE TABLE {schema}.axpdef_ruleeng_msg (
    axpdef_ruleeng_msgid numeric(16,0) NOT NULL,
    axpdef_ruleengid numeric(16,0),
    axpdef_ruleeng_msgrow integer,
    btncaption character varying(100),
    btnname character varying(50),
    btnformula character varying(8000),
    btnapplicable character varying(4000),
    btn_message text
);

CREATE TABLE {schema}.axpdef_ruleeng_valexpr (
    axpdef_ruleeng_valexprid numeric(16,0) NOT NULL,
    axpdef_ruleengid numeric(16,0),
    axpdef_ruleeng_valexprrow integer,
    flds_vexpr character varying(250),
    fldname_vexpr character varying(50),
    exp_editor_valexpr text
);

CREATE TABLE {schema}.axpdef_script (
    axpdef_scriptid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    structname character varying(10),
    recid numeric(15,0),
    stransid character varying(5),
    axpdef_tstructid numeric(15,0),
    control_type character varying(1),
    event character varying(50),
    type character varying(20),
    fldflg numeric(1,0),
    object character varying(30),
    ctflg character varying(3),
    ctdc numeric(3,0),
    name character varying(10),
    caption character varying(20),
    exp_editor_script text,
    js_editor_script text,
    scriptparams character varying(200),
    purpose character varying(1000),
    active character varying(10),
    sorderno numeric(10,0),
    fdetails character varying(100),
    isapi character varying(1),
    exp_editor_fcscript text
);

CREATE TABLE {schema}.axpdef_usergroups (
    axpdef_usergroupsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    usernames character varying(4000),
    users_group_name character varying(254),
    users_group_description character varying(254),
    isactive character varying(1)
);

CREATE TABLE {schema}.axpdef_userroles (
    axpdef_userrolesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    axusergroup character varying(100),
    dhomepage character varying(200),
    homepage character varying(100),
    useprodform character varying(1),
    active character varying(1),
    rolev2 character varying(1)
);

CREATE TABLE {schema}.axpdflanguage (
    lngname character varying(25) NOT NULL,
    sname character varying(16) NOT NULL,
    fontname character varying(30),
    fontsize numeric(3,0),
    compname character varying(25) NOT NULL,
    compcaption character varying(100),
    comphint character varying(1)
);

CREATE TABLE {schema}.axpdraft (
    transid character varying(5),
    username character varying(50),
    usersession character varying(50),
    ip character varying(20),
    holdid character varying(250),
    createdon character varying(20),
    modifiedon character varying(20),
    fieldlist bytea,
    parselist bytea,
    assignedlist bytea,
    rec_varlist bytea,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.axpeg_sendmsg (
    axpeg_sendmsgid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    touser_ui character varying(200),
    touser character varying(100),
    msgtitle character varying(100),
    message text,
    pagetype character varying(50),
    formmode character varying(50),
    formcaption character varying(250),
    stransid character varying(50),
    msgtype character varying(10),
    loadparams character varying(1000),
    effectiveto date,
    fromuser character varying(100),
    hlink_transid character varying(100),
    hlink_params character varying(4000)
);

CREATE TABLE {schema}.axperiodnotify (
    axperiodnotifyid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    name character varying(200),
    startdate date,
    starttime character varying(10),
    frequency character varying(20),
    sendday character varying(20),
    sendon character varying(30),
    sendtime character varying(10),
    active character varying(1),
    datasource character varying(200),
    messagetitle character varying(500),
    messagetext text,
    messageattsingle character varying(100),
    messageattsinglename character varying(50),
    messageattachmentsui character varying(4000),
    messageattachments character varying(4000),
    notifyto character varying(1000),
    usergroups character varying(4000),
    usernames character varying(4000),
    externalemails character varying(4000),
    fromuserui character varying(100),
    fromuser character varying(50),
    mobilenotify character varying(1),
    projname character varying(100),
    queuestat character varying(25),
    exp_editor_condition text,
    navigateto character varying(500),
    pagetype character varying(10),
    loadopen character varying(5),
    tbl_navigationparam character varying(8000),
    formula character varying(8000),
    formula_expr character varying(4000)
);

CREATE TABLE {schema}.axpermissions (
    axpermissionsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    axuserrole character varying(100),
    comptype character varying(20),
    formcap character varying(250),
    formtransid character varying(50),
    allowcreate character varying(3),
    viewcnd character varying(100),
    viewctrl character varying(1),
    view_flds character varying(4000),
    viewlist character varying(4000),
    editcnd character varying(100),
    editctrl character varying(1),
    edit_flds character varying(4000),
    editlist character varying(4000),
    fieldmasks character varying(4000),
    fieldmaskstr character varying(4000),
    dupchk character varying(500),
    fromsource character varying(1),
    axusername character varying(100)
);

CREATE TABLE {schema}.axpertlog (
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    structname character varying(16),
    recordid numeric(15,0),
    timetaken numeric(10,0),
    db_conntime numeric(10,0),
    dbtimetaken numeric(10,0),
    servicename character varying(50),
    serviceresult character varying(200),
    callfinished timestamp without time zone,
    calldetails character varying(2000)
);

CREATE TABLE {schema}.axpertreports (
    caption character varying(50),
    design bytea,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.axpexception (
    exp_date date,
    structname character varying(16),
    servicename character varying(50),
    serviceresult character varying(500),
    count numeric
);

CREATE TABLE {schema}.axpexchange (
    axpexchangeid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    transid character varying(5),
    idfield character varying(30),
    adxinout character varying(1),
    ftphost character varying(180),
    ftpname character varying(10),
    ftppwd character varying(10),
    ftp character varying(200),
    formatfile text,
    extension character varying(5),
    ordno numeric(3,0),
    cond character varying(200),
    outfolder character varying(200),
    infolder character varying(200),
    succfolder character varying(200),
    failfolder character varying(200),
    archsuccfolder character varying(200),
    archfailfolder character varying(200)
);

CREATE TABLE {schema}.axpfgdtl (
    tstruct character varying(5),
    fgname character varying(50),
    srcfld character varying(50),
    tarfld character varying(50),
    caption character varying(500)
);

CREATE TABLE {schema}.axpfillgrid (
    tstruct character varying(5),
    fgname character varying(50),
    caption character varying(2000),
    fgsql text,
    fromiview character varying(1),
    tardc character varying(5),
    multiselect character varying(1),
    autoshow character varying(1),
    srcdc character varying(5),
    validat character varying(1),
    exeonsave character varying(1),
    firmbind character varying(1),
    selecton character varying(15),
    footer character varying(200),
    valexpr character varying(200),
    addrows character varying(30),
    purpose text,
    gfld character varying(50),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    plist character varying(200)
);

CREATE TABLE {schema}.axpflds (
    tstruct character varying(5),
    itype character varying(50),
    fname character varying(50),
    caption character varying(2000),
    datatype character varying(50),
    datawidth numeric(5,0),
    flddecimal numeric(2,0),
    modeofentry character varying(50),
    expression character varying(4000),
    valexpr character varying(4000),
    srctf character varying(100),
    purpose text,
    fldsql text,
    srcfld character varying(50),
    hidden character varying(1),
    readonly character varying(1),
    savevalue character varying(1),
    dcname character varying(5),
    ordno numeric(4,0),
    customdatatype character varying(15),
    stype character varying(1),
    allowempty character varying(1),
    allowduplicate character varying(1),
    tabstop character varying(1),
    setcarry character varying(1),
    applycomma character varying(1),
    onlypositive character varying(1),
    clientvalidate character varying(1),
    mask character varying(25),
    pattern character varying(25),
    hint character varying(50),
    pwordchar character varying(1),
    srckey character varying(1),
    sgwidth character varying(50),
    sgheight numeric(5,0),
    cfield character varying(50),
    srctrans character varying(5),
    scol numeric(2,0),
    autoselect character varying(1),
    linkfield character varying(50),
    suggestive character varying(1),
    ctype character varying(11),
    disptype character varying(1),
    sep character varying(1),
    font character varying(35),
    color character varying(20),
    refreshonsave character varying(1),
    searchsql character varying(4000),
    dispdet character varying(500),
    depflds character varying(3000),
    parentflds character varying(3000),
    listvalues character varying(300),
    autogendet character varying(250),
    tablename character varying(50),
    asgrid character varying(1),
    frmno numeric(2,0),
    tlhw character varying(20),
    lbltlhw character varying(20),
    runtimefld character varying(1),
    applyrule character varying(1),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    encrypted character varying(1),
    masking character varying(100),
    lastcharmask character varying(100),
    firstcharmask character varying(100),
    maskchar character varying(1),
    maskroles character varying(1000),
    customdecimal character varying(1),
    displaytotal character varying(1)
);

CREATE TABLE {schema}.axpformlbls (
    transid character varying(5),
    lblname character varying(50),
    lblcaption character varying(4000)
);

CREATE TABLE {schema}.axpgenmapdtl (
    tstruct character varying(20),
    gname character varying(20),
    tarfld character varying(50),
    srcfld character varying(50),
    trow numeric(2,0),
    srow numeric(2,0),
    control character varying(50),
    dgroup character varying(50),
    dtype character varying(6),
    ord numeric(2,0),
    id character varying(1)
);

CREATE TABLE {schema}.axpgenmaps (
    tstruct character varying(5),
    gname character varying(20),
    caption character varying(2000),
    targettstr character varying(30),
    basedondc character varying(5),
    ctrlfldname character varying(50),
    active character varying(1),
    axpschema character varying(50),
    onpost text,
    purpose text,
    onapprove character varying(1),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    onreject character varying(1)
);

CREATE TABLE {schema}.axpinstance (
    axpid character varying(250)
);

CREATE TABLE {schema}.axpkeywords (
    keyword character varying(100),
    f2 numeric
);

CREATE TABLE {schema}.axpkt (
    siteno numeric(10,0),
    name character varying(30),
    pkt bytea,
    pktdate character varying(30),
    blobno numeric(3,0),
    pktname character varying(50)
);

CREATE TABLE {schema}.axpmdmaps (
    tstruct character varying(5),
    mname character varying(10),
    caption character varying(2000),
    extended character varying(1),
    mastrans character varying(50),
    masfld character varying(50),
    detfld character varying(50),
    msrcfld character varying(50),
    dtlsrcfld character varying(50),
    mastable character varying(50),
    updatetype character varying(10),
    ctrlfield character varying(50),
    mdappend character varying(1),
    initondel character varying(1),
    maptext text,
    purpose text,
    onapprove character varying(1),
    reject character varying(1),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    masdec numeric(2,0),
    onreject character varying(1)
);

CREATE TABLE {schema}.axppopdc (
    tstruct character varying(5),
    dcname character varying(10),
    frameno numeric(2,0),
    parent character varying(5),
    parentfield character varying(50),
    heading character varying(50),
    popcond character varying(75),
    autoshow character varying(1),
    autofill text,
    firmbind character varying(1),
    keycols character varying(50),
    dispfield character varying(25),
    sumformat character varying(75),
    delimiter character varying(1),
    addrow character varying(1),
    showbuttons character varying(30)
);

CREATE TABLE {schema}.axprintdetails (
    id character varying(100),
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    context character varying(50),
    act_script_name character varying(100),
    source character varying(20),
    structname character varying(20),
    paramstring character varying(2000),
    fileservername character varying(100),
    uploadtype character varying(10),
    url character varying(1000),
    fileserverauth character varying(200),
    urldir character varying(500),
    printforms character varying(500),
    outputfilepathandname character varying(1000),
    printfiletype character varying(20),
    directprint character varying(1),
    totallines numeric(5,0),
    succlines numeric(5,0),
    status character varying(500)
);

CREATE TABLE {schema}.axprintexceptiondetails (
    id character varying(100),
    transid character varying(5),
    recordid numeric(15,0),
    iviewname character varying(10),
    formnames character varying(200),
    filename character varying(500),
    lineno numeric(5,0),
    errormsg character varying(1000)
);

CREATE TABLE {schema}.axprinting (
    jobid character varying(10),
    jobname character varying(30),
    paramsnamevalue character varying(500),
    transid character varying(10),
    recordid numeric(15,0),
    printfilename character varying(250),
    filepath character varying(100),
    filename character varying(100),
    status character varying(100),
    source character varying(1),
    enddatetime timestamp(0) without time zone,
    jobdate timestamp(0) without time zone
);

CREATE TABLE {schema}.axprintjobs (
    jobname character varying(30),
    iviewname character varying(50),
    printfilename character varying(50)
);

CREATE TABLE {schema}.axprocess (
    eventdatetime character varying(30),
    taskid character varying(15),
    transid character varying(8),
    processname character varying(500),
    taskname character varying(500),
    keyvalue character varying(500),
    taskstatus character varying(15)
);

CREATE TABLE {schema}.axprocessdef (
    axprocessdefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    processname character varying(500),
    indexno numeric(10,0),
    subindexno numeric(2,0),
    tasktype character varying(10),
    active character varying(1),
    taskgroupname character varying(250),
    taskname character varying(500),
    taskdescription text,
    formcaption character varying(500),
    keyfieldcaption character varying(500),
    transid character varying(10),
    keyfield character varying(250),
    axpdef_peg_processmasterid numeric(15,0),
    prenotify character varying(250),
    postnotify character varying(250),
    assignto character varying(50),
    assigntoflg character varying(10),
    formfieldscaption character varying(250),
    formfieldname character varying(100),
    assigntoactor character varying(100),
    assigntorole character varying(4000),
    useridentificationfilter character varying(4000),
    useridentificationfilter_of character varying(20),
    assigntouserflag character varying(5),
    assigntouser character varying(100),
    mapfield character varying(100),
    mapfieldcaption character varying(250),
    mapfield_group character varying(250),
    formula_opr character varying(50),
    formula_andor character varying(20),
    applicability_tbl character varying(4000),
    applicability character varying(4000),
    exp_editor_applicability text,
    nexttask_tbl character varying(4000),
    nexttask_truecnd character varying(250),
    nexttask_falsecnd character varying(250),
    nexttask character varying(4000),
    exp_editor_nexttask text,
    displaybuttons character varying(250),
    displayicon character varying(200),
    displaytitle character varying(500),
    displaysubtitle character varying(250),
    displaycontent text,
    displaytemplate text,
    processownerui character varying(300),
    processowner character varying(300),
    processownerflg numeric(1,0),
    approvereasons character varying(4000),
    defapptext character varying(4000),
    returnreasons character varying(4000),
    defrettext character varying(4000),
    rejectreasons character varying(4000),
    defregtext character varying(4000),
    execmaps character varying(2000),
    editablefieldscaption character varying(4000),
    execonapprove character varying(250),
    approvecmt character varying(1),
    rejectcmt character varying(1),
    returncmt character varying(1),
    reminder numeric(2,0),
    escalation numeric(2,0),
    indexdupchk character varying(1000),
    mobilenotify character varying(1)
);

CREATE TABLE {schema}.axprocessdef_delegation (
    axprocessdef_delegationid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    fromuser character varying(250),
    fromusername character varying(100),
    touser character varying(250),
    tousername character varying(100),
    fromdate date,
    todate date
);

CREATE TABLE {schema}.axprocessdefv2 (
    axprocessdefv2id numeric(16,0),
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    processname character varying(500),
    indexno numeric(10,0),
    subindexno numeric(2,0),
    tasktype character varying(10),
    active character varying(1),
    taskgroupname character varying(250),
    taskname character varying(500),
    taskdescription text,
    formcaption character varying(500),
    keyfieldcaption character varying(500),
    transid character varying(10),
    keyfield character varying(250),
    axpdef_peg_processmasterid numeric(15,0),
    postnotify character varying(4000),
    assignto character varying(50),
    assigntoflg character varying(10),
    formfieldscaption character varying(250),
    formfieldname character varying(100),
    assigntoactor character varying(100),
    assigntorole character varying(4000),
    useridentificationfilter character varying(4000),
    useridentificationfilter_of character varying(20),
    assigntouserflag character varying(5),
    assigntouser character varying(100),
    mapfield character varying(100),
    mapfieldcaption character varying(250),
    mapfield_group character varying(250),
    formula_opr character varying(30),
    formula_andor character varying(20),
    applicability_tbl character varying(8000),
    applicability character varying(8000),
    nexttask_tbl character varying(4000),
    nexttask_truecnd character varying(250),
    nexttask_falsecnd character varying(250),
    nexttask character varying(4000),
    exp_editor_nexttask text,
    displayicon character varying(200),
    displaytitle character varying(500),
    displaycontent text,
    displaytemplate text,
    processownerui character varying(300),
    processowner character varying(300),
    processownerflg numeric(1,0),
    approvereasons character varying(4000),
    defapptext character varying(4000),
    returnreasons character varying(4000),
    defrettext character varying(4000),
    rejectreasons character varying(4000),
    defregtext character varying(4000),
    execmaps character varying(2000),
    approvecmt character varying(1),
    rejectcmt character varying(1),
    returncmt character varying(1),
    reminder numeric(2,0),
    escalation numeric(2,0),
    groupwithprior character varying(1),
    displaymcontent text,
    taskparams character varying(4000),
    execonapprove character varying(250),
    taskparamsui character varying(4000),
    displaysubtitle character varying(100),
    displaybuttons character varying(100),
    timelinetitle text,
    hidecards character varying(4000),
    parenttaskname character varying(500),
    stransid character varying(10),
    isoptional character varying(1),
    formcontrl text,
    postnotify_return character varying(4000),
    postnotify_reject character varying(4000),
    orphan_autoapproval character varying(1),
    returnable character varying(1),
    usebusinessdatelogic character varying(1),
    allowsend character varying(50),
    allowsendflg character varying(1),
    sendtoactor character varying(4000),
    indexdupchk character varying(200),
    initiator_approval character varying(1),
    postactorname character varying(1000),
    posttoprocessuser character varying(1),
    postruledef character varying(1),
    senduser_in character varying(4000),
    senduser_notin character varying(4000),
    skipleveluser character varying(40),
    skiplevelcnd numeric(2,0),
    formula_flds character varying(250),
    action_buttons character varying(50),
    editablefieldscaption character varying(4000),
    exp_editor_applicability text,
    mobilenotify character varying(1),
    parenttask character varying(200),
    prenotify character varying(250),
    allowedit character varying(1),
    allowedittasks character varying(4000),
    allowedittasksid character varying(4000),
    autoapprove character varying(1),
    reminderstartfrom character varying(250),
    reminderstartwhen character varying(10),
    escalationstartfrom character varying(250),
    escalationstartwhen character varying(10),
    reminderstartcnd character varying(10),
    reminderstartfname character varying(100),
    escalationstartcnd character varying(10),
    escalationstartfname character varying(100),
    cmsg_appcheckflg character varying(1),
    cmsg_appcheck text,
    cmsg_returnflg character varying(1),
    cmsg_return text,
    cmsg_rejectflg character varying(1),
    cmsg_reject text,
    taskbuttons character varying(100),
    showbuttons character varying(1),
    rem_esc_startfrom character varying(4000),
    tasknotification character varying(4000),
    approve_forwardto character varying(1),
    return_to_priorindex character varying(1)
);

CREATE TABLE {schema}.axprocessdefv2_escalation (
    axprocessdefv2_escalationid numeric(16,0) NOT NULL,
    axprocessdefv2id numeric(16,0),
    axprocessdefv2_escalationrow integer,
    escalateafter character varying(20),
    escalateday numeric(2,0),
    escalatehr numeric(2,0),
    escalatemin numeric(2,0),
    esc_startfrom character varying(250),
    esc_when character varying(20),
    esc_maildays numeric(10,0),
    esc_mailndays numeric(10,0),
    esc_daytypeui character varying(50),
    esc_daytype character varying(20),
    esc_startfromcnd character varying(10),
    esc_startfromfname character varying(100),
    esc_frequency character varying(30),
    esc_frq_daytype character varying(20),
    escalate character varying(50),
    escalatetoactor character varying(100),
    escalatetemplate character varying(4000),
    escalateflg numeric(1,0),
    escalate_notifyto character varying(50),
    notifytoactor character varying(250)
);

CREATE TABLE {schema}.axprocessdefv2_formctls (
    axprocessdefv2_formctlsid numeric(16,0) NOT NULL,
    axprocessdefv2id numeric(16,0),
    axprocessdefv2_formctlsrow integer,
    cmd character varying(50),
    tbldtls character varying(4000),
    axpscript character varying(4000),
    pcnd numeric(10,0)
);

CREATE TABLE {schema}.axprocessdefv2_reminder (
    axprocessdefv2_reminderid numeric(16,0) NOT NULL,
    axprocessdefv2id numeric(16,0),
    axprocessdefv2_reminderrow integer,
    remindafter character varying(2000),
    remindday numeric(10,0),
    reminderhr numeric(2,0),
    remindmin numeric(2,0),
    rem_startfrom character varying(250),
    rem_startafter character varying(20),
    rem_when character varying(20),
    rem_maildays numeric(10,0),
    rem_mailndays numeric(10,0),
    rem_daytypeui character varying(50),
    rem_daytype character varying(20),
    rem_startfromcnd character varying(10),
    rem_startfromfname character varying(100),
    rem_frequency character varying(50),
    rem_frq_daytype character varying(20),
    remindnotify character varying(4000),
    rem_stopafter character varying(30)
);

CREATE TABLE {schema}.axprocessdefv2_setval (
    axprocessdefv2_setvalid numeric(16,0) NOT NULL,
    axprocessdefv2id numeric(16,0),
    axprocessdefv2_setvalrow integer,
    setval_formcaption character varying(500),
    setval_formname character varying(10),
    tblsetval character varying(4000)
);

CREATE TABLE {schema}.axprops (
    name character varying(15) NOT NULL,
    caption character varying(50),
    props text,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25)
);

CREATE TABLE {schema}.axpselectionc (
    selection character varying(25)
);

CREATE TABLE {schema}.axpselectiond (
    selection timestamp without time zone
);

CREATE TABLE {schema}.axpselectionn (
    selection numeric(5,0)
);

CREATE TABLE {schema}.axpstructconfig (
    axpstructconfigid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    asprops character varying(150),
    setype character varying(15),
    props character varying(150),
    context character varying(100),
    propvalue1 character varying(500),
    uploadfiletype character varying(4000),
    propvalue2 character varying(4000),
    propsval character varying(4000),
    alluserroles character varying(10),
    structcaption character varying(150),
    structname character varying(25),
    structelements character varying(100),
    structelements1 character varying(4000),
    sfield character varying(100),
    icolumn character varying(100),
    sbutton character varying(100),
    hlink character varying(100),
    stype character varying(15),
    userroles character varying(100),
    dupchk character varying(500),
    purpose text
);

CREATE TABLE {schema}.axpstructconfigprops (
    axpstructconfigpropsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    configprops character varying(150),
    propcode character varying(150),
    description text,
    dupchk character varying(150),
    context character varying(50),
    ptype character varying(15),
    caction character varying(1),
    chyperlink character varying(1),
    cfields character varying(1),
    alltstructs character varying(1),
    alliviews character varying(1),
    alluserroles character varying(1)
);

CREATE TABLE {schema}.axpstructconfigproval (
    axpstructconfigprovalid numeric(16,0) NOT NULL,
    axpstructconfigpropsid numeric(16,0),
    axpstructconfigprovalrow integer,
    configvalues character varying(75)
);

CREATE TABLE {schema}.axptree (
    name character varying(50) NOT NULL,
    caption character varying(50),
    props text,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25)
);

CREATE TABLE {schema}.axptreeviewdetails (
    viewname character varying(50),
    tstruct_node character varying(50),
    treename character varying(50),
    iviewname character varying(50),
    img character varying(75),
    type character varying(1)
);

CREATE TABLE {schema}.axptreeviews (
    vname character varying(50),
    viewname character varying(50),
    treename character varying(50),
    applyon character varying(1),
    img character varying(75),
    type character varying(1)
);

CREATE TABLE {schema}.axptstructs (
    tstruct character varying(5),
    caption character varying(50),
    savectrlfld character varying(50),
    delctrlfld character varying(50),
    trackchanges character varying(1),
    attach character varying(1),
    searchcond character varying(1000),
    listview character varying(1),
    schemaname character varying(25),
    workflow character varying(1),
    purpose text,
    traceability character varying(1),
    allflds character varying(1),
    trackflds character varying(2500),
    allusers character varying(1),
    trackusers character varying(4000),
    createdby character varying(100),
    createdon timestamp without time zone,
    modifiedby character varying(100),
    modifiedon timestamp without time zone,
    updatedon character varying(25)
);

CREATE TABLE {schema}.axpublishreport (
    transid character varying(30),
    publishedon character varying(25),
    publishedby character varying(30),
    status character varying(4000),
    remarks character varying(1000),
    createdon date DEFAULT now(),
    publishedto character varying(100),
    transtype character varying(10)
);

CREATE TABLE {schema}.axpweblogs (
    username character varying(50),
    logtime character varying(50),
    type character varying(50),
    sessionid character varying(50),
    ipaddress character varying(20),
    logdetails text
);

CREATE TABLE {schema}.axpws_config (
    transid character varying(8) NOT NULL,
    iviewname character varying(8) NOT NULL,
    fldname character varying(8),
    printformname character varying(8),
    versionno character varying(8)
);

CREATE TABLE {schema}.axquicklinks (
    axquicklinksid numeric,
    name character varying(100),
    linkname character varying(100),
    linkurl character varying(100),
    iconurl character varying(100),
    linktype character varying(100)
);

CREATE TABLE {schema}.axrelations (
    mstruct character varying(5),
    dstruct character varying(5),
    mfield character varying(50),
    dfield character varying(50),
    rtype character varying(2)
);

CREATE TABLE {schema}.axrepostgenmaps (
    jobid character varying(50),
    jobdate timestamp(0) without time zone,
    transid character varying(5),
    caption character varying(200),
    genmaps character varying(1000),
    fromdt timestamp(0) without time zone,
    todt timestamp(0) without time zone,
    postchildgenmaps character varying(1),
    reccnt numeric(6,0),
    status character varying(1000)
);

CREATE TABLE {schema}.axrepostgenmapsrecdetails (
    jobid character varying(50),
    transid character varying(5),
    genmap character varying(100),
    recordid numeric(15,0),
    action character varying(1),
    status character varying(1),
    errmsg character varying(2000)
);

CREATE TABLE {schema}.axrequest (
    requestid character varying(100) NOT NULL,
    requestreceivedtime timestamp with time zone,
    sourcefrom character varying(255),
    requeststring text,
    headers text,
    params text,
    authz character varying(255),
    contenttype character varying(150),
    contentlength character varying(10),
    host character varying(255),
    url text,
    endpoint character varying(255),
    requestmethod character varying(10),
    apiname character varying(255),
    username character varying(255),
    additionaldetails text,
    sourcemachineip character varying(255)
);

CREATE TABLE {schema}.axresponse (
    responseid character varying(100) NOT NULL,
    responsesenttime timestamp with time zone,
    statuscode integer,
    responsestring text,
    headers text,
    contenttype character varying(150),
    contentlength character varying(10),
    errordetails text,
    endpoint character varying(255),
    requestmethod character varying(10),
    username character varying(255),
    additionaldetails text,
    requestid character varying(100),
    executiontime character varying(20)
);

CREATE TABLE {schema}.axrolhistory (
    recordid numeric(16,0),
    modifieddate timestamp without time zone,
    username character varying(30),
    fieldname character varying(30),
    oldvalue character varying(250),
    newvalue character varying(250),
    rowno numeric(38,0),
    delflag character varying(1),
    modno numeric(10,0),
    frameno numeric(10,0),
    parentrow numeric(10,0),
    tablerecid numeric(16,0),
    idvalue numeric(16,0),
    oldidvalue numeric(16,0),
    transdeleted character varying(5),
    newtrans character varying(5),
    canceltrans character varying(1),
    cancelremarks character varying(250)
);

CREATE TABLE {schema}.axrulesdef (
    axrulesdefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    transid character varying(10),
    formcontrol character varying(500),
    active character varying(10),
    rulegroup character varying(100),
    formcaption character varying(300),
    uroles text,
    isapplicable character varying(2000),
    isruntime character varying(1),
    onchngfldname character varying(4000),
    rulename character varying(200),
    scriptonload text,
    formcontrolparent text,
    onsubmit text,
    pegrule character varying(1),
    levelno numeric(10,0)
);

CREATE TABLE {schema}.axrulesdef_conmsg (
    axrulesdef_conmsgid numeric(16,0) NOT NULL,
    axrulesdefid numeric(16,0),
    axrulesdef_conmsgrow integer,
    btnname character varying(100),
    btnapplicable character varying(99999),
    confirm_msg character varying(8000),
    btnstransid character varying(10),
    btnuroles character varying(4000),
    fname character varying(50)
);

CREATE TABLE {schema}.axrulesdef_expr (
    axrulesdef_exprid numeric(16,0) NOT NULL,
    axrulesdefid numeric(16,0),
    axrulesdef_exprrow integer,
    exp_transid character varying(10),
    exp_fname character varying(50),
    expr character varying(4000)
);

CREATE TABLE {schema}.axrulesdef_valexpr (
    axrulesdef_valexprid numeric(16,0) NOT NULL,
    axrulesdefid numeric(16,0),
    axrulesdef_valexprrow integer,
    vexp_transid character varying(10),
    vexp_fname character varying(50),
    valexpr character varying(4000)
);

CREATE TABLE {schema}.axscheduler (
    name character varying(15) NOT NULL,
    caption character varying(50),
    props text,
    blobno numeric(3,0) NOT NULL,
    updusername character varying(25),
    mwd numeric(1,0),
    dys character varying(100),
    schedule character varying(15),
    "time" character varying(15),
    updatedon character varying(25),
    readonly character varying(1),
    createdon character varying(25),
    createdby character varying(25),
    importedon character varying(25),
    importedby character varying(25),
    updatedby character varying(25)
);

CREATE TABLE {schema}.axschema (
    transid character varying(5),
    tablename character varying(128),
    schemaname character varying(25)
);

CREATE TABLE {schema}.axscriptdef (
    scriptname character varying(50),
    script text,
    breakonerror character varying(1)
);

CREATE TABLE {schema}.axscriptjobs (
    jobid character varying(50),
    scriptname character varying(50),
    username character varying(50),
    starttime timestamp(0) without time zone,
    endtime timestamp(0) without time zone,
    status character varying(4000),
    jobdate timestamp(0) without time zone,
    paramsnamevalue character varying(1000)
);

CREATE TABLE {schema}.axsites (
    sitename character varying(100),
    siteno numeric(3,0)
);

CREATE TABLE {schema}.axsms (
    recordid integer NOT NULL,
    mobileno character varying(10),
    msg character varying(250),
    status numeric(1,0) NOT NULL,
    senton timestamp without time zone,
    remarks character varying(1000),
    createdon timestamp without time zone
);

CREATE TABLE {schema}.axsql_perf (
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    structname character varying(16),
    recordid numeric(15,0),
    timetaken numeric(10,0),
    dbtimetaken numeric(10,0),
    servicename character varying(50),
    serviceresult character varying(200),
    callfinished timestamp without time zone,
    query_details text,
    querytimetaken numeric(10,0)
);

CREATE TABLE {schema}.axsrrattach (
    recordid numeric(16,0),
    filename character varying(200),
    template bytea,
    blobno numeric(3,0),
    recid character varying(217)
);

CREATE TABLE {schema}.axstructprops (
    sname character varying(10),
    stype character varying(1),
    fldname character varying(50),
    datawidth numeric(4,0),
    decimals numeric(2,0),
    status character varying(15),
    errmsg character varying(500)
);

CREATE TABLE {schema}.axtasks (
    fromwhom character varying(30),
    towhom character varying(30),
    sname character varying(10),
    recordid numeric(16,0),
    status numeric(2,0),
    upddatetime character varying(30),
    message text,
    dueby timestamp without time zone,
    reportingto character varying(30),
    dueact numeric(1,0),
    app_level numeric(3,0),
    notify_status character varying(1) DEFAULT 'N'::character varying
);

CREATE TABLE {schema}.axtempuserfields (
    fldname character varying(50),
    fldtype character varying(1),
    fldwidth numeric(5,0),
    fldordno numeric(5,0)
);

CREATE TABLE {schema}.axtoolbar (
    name character varying(50),
    stype character varying(20),
    title character varying(50),
    key character varying(50),
    folder character varying(10),
    action character varying(100),
    task character varying(100),
    script character varying(1000),
    icon character varying(100),
    parent character varying(50),
    haschildren character varying(5),
    ordno numeric(3,0),
    footer character varying(6),
    visible character varying(7),
    parentdc character varying(10),
    "position" character varying(30),
    api character varying(200),
    scripts character varying(100)
);

CREATE TABLE {schema}.axtranscontrol (
    username character varying(50),
    transid character varying(5),
    sessionid character varying(30),
    recordid numeric(16,0),
    loadedon timestamp without time zone
);

CREATE TABLE {schema}.axtsuserconfig (
    rolename character varying(50),
    username character varying(50),
    userlevel numeric(2,0),
    formname character varying(5),
    fieldname character varying(50),
    opname character varying(10),
    propvalue character varying(4000),
    propname character varying(10)
);

CREATE TABLE {schema}.axuseractivations (
    axuseractivationsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    pusername character varying(200),
    usertype character varying(5),
    isactive character varying(1),
    authkey character varying(200),
    utypechng character varying(1),
    authkeyflg character varying(1),
    userkey character varying(500)
);

CREATE TABLE {schema}.axusercharts (
    axuserchartsid numeric(16,0) NOT NULL,
    axusersid numeric(16,0),
    axuserchartsrow integer,
    charts numeric(16,0),
    graphtype character varying(30)
);

CREATE TABLE {schema}.axuserdpermissions (
    axuserdpermissionsid numeric(16,0) NOT NULL,
    axpermissionsid numeric(16,0),
    cnd character varying(4000)
);

CREATE TABLE {schema}.axusergrouping (
    axusergroupingid numeric(16,0) NOT NULL,
    axusersid numeric(16,0),
    cnd1 text
);

CREATE TABLE {schema}.axuserpermissions (
    axuserpermissionsid numeric(16,0) NOT NULL,
    axusersid numeric(16,0),
    axuserpermissionsrow integer,
    axuserrole character varying(200),
    cnd text
);

CREATE TABLE {schema}.axuserprofile (
    username character varying(50),
    userprofile text,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.axuserprofileimage (
    username character varying(50),
    userimage text,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.axusers (
    username character varying(30) NOT NULL,
    password character varying(200),
    usergroup character varying(30),
    groupno numeric(7,0),
    build character varying(1),
    manage character varying(1),
    tools character varying(1),
    email character varying(50),
    pageaccess character varying(250),
    active character varying(1),
    reportingto character varying(30),
    isfirsttime character varying(1),
    workflow character varying(1),
    webskin character varying(25),
    send character varying(1),
    actflag character varying(1),
    logintry numeric(2,0),
    pwdexpdays numeric(3,0),
    importstruct character varying(1),
    language_access character varying(1),
    language character varying(25),
    exportstruct character varying(1),
    axpertmanager character varying(1),
    pwd character varying(20),
    accesscode character varying(25),
    appparams character varying(1),
    appmanager character varying(1),
    repostgenmap character varying(1),
    debug character varying(1),
    carddetails text,
    pusername character varying(50),
    usergroups character varying(4000),
    actors character varying(4000),
    adminaccess character varying(500),
    appmgraccess character varying(10),
    export_data character varying(10),
    import_data character varying(10),
    pwdauth character varying(1),
    otpauth character varying(1),
    portaluser character varying(1),
    authkey character varying(200),
    userkey character varying(200),
    oldportaluser character varying(1),
    nickname character varying(200),
    ppassword character varying(50),
    usertype character varying(20),
    mobile character varying(14),
    allusergroup character varying(200),
    dhomepage character varying(200),
    global_displaytext character varying(300),
    poweruser character varying(1),
    isuniquehybrid character varying(1),
    axlang character varying(100),
    cancelremarks character varying(300),
    axusersid numeric(15,0),
    cancel character varying(10),
    sourceid numeric(15,0),
    homepage character varying(255) DEFAULT NULL::character varying,
    singleloginkey character varying(50),
    staysignedin character varying(1),
    signinexpiry numeric(2,0)
);

CREATE TABLE {schema}.axuserspwdpolicy (
    username character varying(50) NOT NULL,
    pwdchangedate timestamp without time zone,
    pwdchange character varying(1),
    prevpwds text
);

CREATE TABLE {schema}.axusrhistory (
    recordid numeric(16,0),
    modifieddate date,
    username character varying(30),
    fieldname character varying(30),
    oldvalue character varying(250),
    newvalue character varying(250),
    rowno numeric(38,0),
    delflag character varying(1),
    modno numeric(10,0),
    frameno numeric(10,0),
    parentrow numeric(10,0),
    tablerecid numeric(16,0),
    idvalue numeric(16,0),
    oldidvalue numeric(16,0),
    transdeleted character varying(5),
    newtrans character varying(5),
    canceltrans character varying(1),
    cancelremarks character varying(250)
);

CREATE TABLE {schema}.axusrprofilepic (
    recordid numeric(16,0),
    img bytea,
    blobno numeric(3,0),
    ftype character varying(4)
);

CREATE TABLE {schema}.axvarcore (
    axvarcoreid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    vpname character varying(50),
    isparam character varying(1),
    vscript text,
    pcaption character varying(100),
    pdatatype character varying(20),
    modeofentry character varying(10),
    masterdlui character varying(200),
    masterdl character varying(200),
    source character varying(200),
    sql_editor_psql text,
    vpvalue character varying(2000),
    display character varying(1),
    readonly character varying(1),
    customdatatype character varying(100),
    datawidth numeric(10,0),
    isappparam character varying(1),
    constant_name character varying(100),
    constant_value character varying(500),
    isconstant character varying(1),
    var_name character varying(100),
    exp_editor_varscript text,
    isvariable character varying(1),
    db_funtion character varying(500),
    db_funtion_params character varying(4000),
    isdbobj character varying(1),
    event_onlogin character varying(1),
    event_onformload character varying(1),
    forms character varying(4000),
    event_onreportload character varying(1),
    reports character varying(4000),
    remarks text,
    stransid character varying(5),
    axvarname character varying(200),
    dbvarname character varying(100),
    dbvartype character varying(100),
    dbvarval character varying(500),
    dbvarsourceid numeric(15,0),
    forms_transid character varying(4000),
    reports_transid character varying(4000)
);

CREATE TABLE {schema}.axworkflow (
    name character varying(10) NOT NULL,
    caption character varying(25),
    rname character varying(15),
    props text,
    blobno numeric(3,0),
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25),
    wno numeric(4,0),
    appemail character varying(1),
    mailcontent text,
    chkms character varying(1),
    url character varying(200),
    attach character varying(75),
    auth character varying(1)
);

CREATE TABLE {schema}.axworkflowmail (
    sname character varying(5),
    recordid numeric(16,0),
    updusername character varying(50),
    app_datetime timestamp without time zone,
    app_level numeric(3,0),
    status numeric(2,0),
    errmsg character varying(1000)
);

CREATE TABLE {schema}.connectinfo (
    connectno numeric(4,0),
    lastupdated timestamp without time zone,
    lastnumber numeric(9,0),
    active character(1)
);

CREATE TABLE {schema}.connections (
    sessionid character varying(50),
    logintime timestamp without time zone,
    username character varying(50),
    usergroup character varying(250),
    groupno numeric(7,0),
    project character varying(50),
    pageaccess character varying(250),
    appvars text,
    userroles character varying(250),
    ip character varying(20),
    transidlist text
);

CREATE TABLE {schema}.customtypes (
    customtypesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    typename character varying(20),
    datatype character varying(10),
    width numeric(4,0),
    deci numeric(5,3),
    namecheck character varying(30),
    replacechar character varying(30),
    fcharcheck character varying(30),
    validchk character varying(30),
    modeofentry character varying(20),
    cvalues character varying(100),
    defaultvalue character varying(100),
    sql_editor_details character varying(500),
    exp_editor_expression character varying(200),
    exp_editor_validateexpression character varying(200),
    readonly character varying(10),
    chide character varying(1),
    cpattern character varying(20),
    cmask character varying(50),
    cregularexpress character varying(500),
    spldatatype character varying(10)
);

CREATE TABLE {schema}.dsignconfig (
    dsignconfigid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    transname character varying(100),
    stransid character varying(10),
    tunique character varying(50),
    docname character varying(50),
    doctype character varying(10),
    duplicatecheck character varying(70)
);

CREATE TABLE {schema}.dsignconfigdtl (
    dsignconfigdtlid numeric(16,0) NOT NULL,
    dsignconfigid numeric(16,0),
    dsignconfigdtlrow integer,
    prolename numeric(16,0),
    pusername numeric(16,0),
    ordno character varying(10),
    semail character varying(10),
    ssms character varying(10),
    axpmailid numeric(16,0)
);

CREATE TABLE {schema}.dual (
    lval character varying(50)
);

CREATE TABLE {schema}.dwb_iviewscripts (
    dwb_iviewscriptsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    structname character varying(10),
    recid numeric(15,0),
    iname character varying(8),
    dwb_iviewsid numeric(15,0),
    event character varying(50),
    ctflg character varying(3),
    name character varying(10),
    caption character varying(20),
    dupchk character varying(100),
    exp_editor_script text,
    sorderno numeric(10,0),
    fdetails character varying(100),
    captitle character varying(50),
    ppagecreate character varying(10),
    stype character varying(10),
    isapi character varying(1)
);

CREATE TABLE {schema}.dwb_publishprops (
    dwb_publishpropsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    servertype character varying(20),
    servername character varying(100),
    serverpath character varying(1000),
    app_connection character varying(100),
    fs_username character varying(100),
    fs_password character varying(50),
    inactive character varying(1),
    uploadtype character varying(10),
    ftp_url character varying(1000),
    ftp_dir character varying(500),
    ftp_username character varying(100),
    ftp_pwd character varying(10),
    ftp_port numeric(10,0),
    db_type character varying(10),
    db_version character varying(10),
    db_host character varying(50),
    db_username character varying(100),
    db_pwd character varying(50),
    publishtodev character varying(1)
);

CREATE TABLE {schema}.emaildef (
    emaildefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    emaildefname character varying(100),
    emailwhat character varying(30),
    axp_emailsource character varying(30),
    stype character varying(1),
    emailform character varying(100),
    axp_emailtransid character varying(10),
    emailfilterstring character varying(1000),
    emailprintformnames character varying(100),
    emailiview character varying(100),
    axp_emailiview character varying(10),
    emailparams character varying(2000),
    sql_editor_emailsqltext text,
    axp_emailto character varying(1000),
    axp_emailcc character varying(1000),
    axp_emailbcc character varying(1000),
    axp_emailsubject character varying(1000),
    axp_emailattachment character varying(1000),
    axp_emailattachrenamelist character varying(1000),
    axp_emailbody text,
    emailmsoutlook character varying(1)
);

CREATE TABLE {schema}.emaildetails (
    id character varying(100),
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    context character varying(50),
    structtype character varying(1),
    structname character varying(10),
    recordid numeric(15,0),
    act_script_name character varying(100),
    params character varying(1000),
    emaildefname character varying(100),
    totallines numeric(5,0),
    succlines numeric(5,0),
    status character varying(500)
);

CREATE TABLE {schema}.emailexceptiondetails (
    id character varying(100),
    transid character varying(5),
    recordid numeric(15,0),
    iviewname character varying(10),
    emaildet character varying(1000),
    lineno numeric(5,0),
    errormsg character varying(1000)
);

CREATE TABLE {schema}.executeapidef (
    executeapidefid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    apicategory character varying(20),
    apiresponsetype character varying(10),
    apiresponseformat character varying(10),
    execapidefname character varying(100),
    execapimethod character varying(10),
    execapiurl character varying(500),
    execapiparameterstring character varying(1000),
    execapiheaderstring character varying(1000),
    execapirequeststring text,
    execapibodyparamstring text,
    execapiauthstring character varying(100),
    execapibasedon character varying(30),
    stype character varying(2),
    execapiform character varying(100),
    execapitransid character varying(10),
    execapifilterstring character varying(1000),
    execapilprintformnames character varying(100),
    execapiformattachments character varying(500),
    execapiiview character varying(100),
    execapiiviewname character varying(10),
    execapiiparams character varying(1000),
    sql_editor_execapisqltext text,
    apitype character varying(200),
    apitypecnd numeric(1,0),
    isdropdown character varying(1)
);

CREATE TABLE {schema}.fast_print_paper_size (
    psize character varying(250),
    pheight numeric(15,2),
    pwidth numeric(15,2)
);

CREATE TABLE {schema}.fillgriddef (
    transid character varying(5),
    fg_name character varying(50),
    formsize character varying(30),
    colsize character varying(150)
);

CREATE TABLE {schema}.financialyear (
    financialyearid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    ttype character varying(50),
    finyr character varying(4),
    finyridentifier character varying(2),
    startdate date,
    enddate date,
    currentfinyr character varying(1),
    active character varying(10),
    closed character varying(1)
);

CREATE TABLE {schema}.financialyeardtl (
    financialyeardtlid numeric(16,0) NOT NULL,
    financialyearid numeric(16,0),
    financialyeardtlrow integer,
    dfinyr character varying(4),
    periodcode character varying(2),
    perioddesc character varying(10),
    quarter character varying(10),
    pstartdate date,
    penddate date,
    days numeric(15,0)
);

CREATE TABLE {schema}.formsize (
    username character varying(30) NOT NULL,
    formname character varying(16) NOT NULL,
    tlhw character varying(25)
);

CREATE TABLE {schema}.groupbtns (
    groupbtnsid numeric(16,0) NOT NULL,
    tconfigurationid numeric(16,0),
    groupbtnsrow integer,
    groupbtnname character varying(20),
    groupbuttons character varying(240),
    tmpgroup character varying(100),
    bcondition character varying(50)
);

CREATE TABLE {schema}.htmlprint (
    htmlprintid numeric(16,0) NOT NULL,
    tconfigurationid numeric(16,0),
    htmlprintrow integer,
    html_buttonname character varying(20),
    html_filename character varying(40),
    html_fields character varying(100),
    t_fields character varying(10),
    t_file character varying(10),
    ccondition character varying(50)
);

CREATE TABLE {schema}.htmlsections (
    htmlsectionsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    pageno character varying(100),
    caption character varying(100),
    template character varying(250),
    axpfile_hpimages character varying(1000),
    axpfilepath_hpimages character varying(1000),
    addtomenu character varying(10),
    isacoretrans character varying(10),
    params character varying(4000),
    menuposition character varying(50),
    menulist character varying(500)
);

CREATE TABLE {schema}.iconfiguration (
    iconfigurationid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    structname character varying(50),
    structtransid character varying(20),
    configname2 character varying(10),
    cntval character varying(10),
    cv_groupbuttons character varying(300)
);

CREATE TABLE {schema}.iconfigurationdtl (
    iconfigurationdtlid numeric(16,0) NOT NULL,
    iconfigurationid numeric(16,0),
    iconfigurationdtlrow integer,
    groupbtnname character varying(25),
    groupbuttons character varying(240),
    tmpgroup character varying(200),
    bcondition character varying(50)
);

CREATE TABLE {schema}.images (
    name character varying(50) NOT NULL,
    img bytea,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(50),
    imgcount numeric(3,0)
);

CREATE TABLE {schema}.importdatacompletion (
    id numeric(30,0),
    rapidimpid character varying(100),
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    structname character varying(6),
    filename character varying(200),
    recordcount numeric(5,0),
    success numeric(5,0),
    resultmsg character varying(4000),
    errlist text,
    blobno numeric
);

CREATE TABLE {schema}.importdatadetails (
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    structname character varying(6),
    recordid numeric(15,0),
    recordcount numeric(5,0),
    paramdetails character varying(250),
    filename character varying(200),
    success numeric(5,0),
    id numeric(30,0),
    mapfields character varying(250),
    infile numeric(1,0),
    rapidimpid character varying(100)
);

CREATE TABLE {schema}.importdataexceptions (
    sessionid character varying(30),
    username character varying(50),
    calledon timestamp without time zone,
    recordno numeric(5,0),
    errormsg character varying(250),
    id character varying(30),
    rapidimpid character varying(100)
);

CREATE TABLE {schema}.iviewbuttons (
    iname character varying(8),
    button_name character varying(50),
    caption character varying(250),
    hint character varying(250),
    type character varying(10),
    img character varying(20),
    "position" character varying(10),
    flat character varying(10),
    sname character varying(20),
    bcontainer character varying(50),
    action character varying(20),
    btask character varying(20),
    bdef character varying(10),
    cat character varying(10),
    bparent character varying(20),
    tlhw character varying(30),
    font character varying(150),
    down character varying(10),
    ptype character varying(10),
    bcolor character varying(15),
    bfile character varying(50),
    balign character varying(10),
    ordno numeric(3,0)
);

CREATE TABLE {schema}.iviewcols (
    iname character varying(8),
    icaption character varying(2000),
    f_name character varying(50),
    f_caption character varying(2000),
    query_name character varying(20),
    decimals numeric(10,0),
    datatype character varying(1),
    hidden character varying(1),
    expression character varying(1000),
    running_total character varying(1),
    display_total character varying(1),
    no_repeat character varying(1),
    apply_comma character varying(1),
    set_factor character varying(1),
    alignment character varying(10),
    col_seperator character varying(1),
    zero_off character varying(1),
    color character varying(20),
    font character varying(50),
    dos_graphicmode character varying(20),
    linespace character varying(50),
    before_fill character varying(50),
    click character varying(20),
    dblclick character varying(20),
    table_name character varying(20),
    search_name character varying(20),
    group_no numeric(5,0),
    group_heading character varying(20),
    column_width numeric(4,0),
    disp_expr character varying(500),
    compute_post character varying(1),
    set_cellfont character varying(1000),
    colcat character varying(10),
    ordno numeric(3,0)
);

CREATE TABLE {schema}.iviewcomps (
    iname character varying(8),
    localnum numeric(4,0),
    abtn numeric(4,0),
    vupd character varying(1),
    pnl_height numeric(4,0)
);

CREATE TABLE {schema}.iviewhyplink (
    iname character varying(10),
    hypname character varying(10),
    sname character varying(20),
    hypsource character varying(20),
    popup character varying(1),
    hyprefresh character varying(1),
    loadname character varying(1),
    ordno numeric(3,0)
);

CREATE TABLE {schema}.iviewhypparval (
    iname character varying(10),
    hypname character varying(10),
    field character varying(20),
    parvalue character varying(20)
);

CREATE TABLE {schema}.iviewmain (
    iname character varying(8),
    caption character varying(250),
    header1 character varying(250),
    header2 character varying(250),
    header3 character varying(250),
    grand_total character varying(1),
    display_params character varying(1),
    load_tstruct character varying(5),
    footer1 character varying(250),
    footer2 character varying(250),
    trailing_page numeric(5,0),
    printpage_total character varying(1),
    expression_set character varying(250),
    group_field character varying(20),
    lines_per_page numeric(5,0),
    font character varying(50),
    row_seperator character varying(1),
    caption_column character varying(20),
    folder character varying(20),
    printer_settings character varying(50),
    option_type character varying(20),
    total_seperator character varying(20),
    dos_graphic_mode character varying(10),
    line_space character varying(1),
    condensed character varying(1),
    page_footer1 character varying(50),
    page_footer2 character varying(50),
    page_footer3 character varying(50),
    report_footer3 character varying(50),
    recordid_column numeric(17,0),
    filter_expression character varying(50),
    factor numeric(5,0),
    print_logo character varying(1),
    heading_line_space character varying(1),
    details_in_footer character varying(1),
    next_queryname character varying(20),
    transid character varying(10),
    printer_name character varying(250),
    report_style character varying(1),
    print_indexpage character varying(1),
    hidden character varying(1),
    absolute_check character varying(1),
    heading_color character varying(50),
    heading1_font character varying(50),
    heading2_font character varying(50),
    heading3_font character varying(50),
    odd_color character varying(50),
    even_color character varying(50),
    row_height numeric(2,0),
    fixed_rows numeric(2,0),
    paper_size character varying(10),
    source_key character varying(15),
    orientation character varying(10),
    no_of_copies numeric(3,0),
    open_form character varying(10),
    extract_data character varying(20),
    before_fill character varying(20),
    click character varying(15),
    dblclick character varying(15),
    hide_firstcol character varying(1),
    hide_column_lines character varying(1),
    head_rowcolor character varying(50),
    head_rowfont character varying(50),
    sh_graph character varying(10),
    fittopage character varying(10),
    viewtype character varying(15),
    header_align character varying(10),
    footer_align character varying(10),
    parrange numeric(2,0),
    caching_type character varying(15),
    page_size numeric(4,0),
    ptable character varying(30)
);

CREATE TABLE {schema}.iviewparams (
    iname character varying(8),
    pname character varying(50),
    pcaption character varying(250),
    query_name character varying(50),
    dtype character varying(1),
    suggestive character varying(1),
    exp character varying(250),
    val_exp character varying(250),
    hidden character varying(1),
    decimals numeric(10,0),
    value character varying(100),
    moe character varying(20),
    scripttext text,
    blobno numeric(3,0),
    multiselect character varying(1),
    dynamic_param character varying(1),
    save_value character varying(1),
    deps character varying(20),
    pord numeric(2,0),
    param_width numeric(4,0),
    clrcache character varying(1),
    picklist_cols character varying(250),
    ordno numeric(3,0)
);

CREATE TABLE {schema}.iviewscripts (
    username character varying(50) NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    createdby character varying(50),
    modifiedon timestamp without time zone,
    modifiedby character varying(50),
    iname character varying(8),
    event character varying(50),
    type character varying(20),
    name character varying(10),
    caption character varying(20),
    script text
);

CREATE TABLE {schema}.iviewsql (
    iname character varying(8),
    scripttext text,
    type character varying(20),
    task character varying(10),
    blobno numeric(3,0),
    relation_field character varying(20),
    cat character varying(5),
    sname character varying(10),
    ordno numeric(2,0)
);

CREATE TABLE {schema}.iviewsubtotals (
    iname character varying(8),
    key_column character varying(100),
    header character varying(250),
    footer character varying(250),
    caption character varying(250),
    subtotal_order character varying(10),
    line_space character varying(1),
    pageskip character varying(1),
    total_ontop character varying(1),
    header_color character varying(15),
    footer_color character varying(15),
    ordno numeric(3,0)
);

CREATE TABLE {schema}.lviews (
    name character varying(15) NOT NULL,
    caption character varying(50),
    username character varying(30) NOT NULL,
    props text,
    blobno numeric(3,0) NOT NULL,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    transid character varying(5) NOT NULL,
    updusername character varying(25)
);

CREATE TABLE {schema}.msgs1 (
    msgtime character varying(25),
    msg text,
    msgfrom character varying(30),
    msgto character varying(30),
    sname character varying(10),
    readflag character varying(3),
    recordid numeric(15,0),
    msgno numeric(5,0)
);

CREATE TABLE {schema}.msgs2 (
    msgtime character varying(25),
    msg text,
    msgfrom character varying(30),
    msgto character varying(30),
    sname character varying(10),
    readflag character varying(3),
    recordid numeric(15,0),
    msgno numeric(5,0)
);

CREATE TABLE {schema}.pdfimage (
    name character varying(50),
    pdfname character varying(50),
    img bytea,
    blobno numeric(3,0)
);

CREATE TABLE {schema}.pdfprops (
    name character varying(50),
    caption character varying(50),
    blobno numeric(2,0),
    props text,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25),
    transid character varying(5)
);

CREATE TABLE {schema}.popupsizes (
    name character varying(5),
    tlhw character varying(25)
);

CREATE TABLE {schema}.printprms (
    iview character varying(30) NOT NULL,
    prms character varying(250)
);

CREATE TABLE {schema}.printprops (
    name character varying(25) NOT NULL,
    caption character varying(25),
    blobno numeric(3,0) NOT NULL,
    props text,
    updatedon character varying(25),
    createdon character varying(25),
    importedon character varying(25),
    createdby character varying(25),
    updatedby character varying(25),
    importedby character varying(25),
    readonly character varying(1),
    updusername character varying(25)
);

CREATE TABLE {schema}.prints (
    name character varying(25) NOT NULL,
    sname character varying(25),
    template bytea,
    printdoctype character varying(20),
    caption character varying(25),
    blobno numeric(3,0) NOT NULL
);

CREATE TABLE {schema}.publishprops (
    servername character varying(50),
    serverpath character varying(200),
    ftp_path character varying(200),
    ftp_port character varying(10),
    ftp_username character varying(50),
    ftp_pwd character varying(50),
    db_type character varying(10),
    db_host character varying(50),
    db_username character varying(50),
    db_pwd character varying(50),
    ftp_dir character varying(200),
    db_version character varying(20),
    uploadtype character varying(4) DEFAULT 'FTP'::character varying,
    cloudflag character varying(1) DEFAULT 'O'::character varying,
    title character varying(100),
    descr text,
    dtldescr text,
    userid character varying(255),
    appid character varying(20),
    masterdataapiurl character varying(255),
    publishappapiurl character varying(255)
);

CREATE TABLE {schema}.recvpkts (
    pktdate character varying(30),
    fromsite numeric(5,0),
    recdon character varying(30),
    transid character varying(5),
    pktid character varying(50),
    recordid numeric(15,0),
    mstatus character varying(300),
    status character varying(1000),
    smode character varying(1)
);

CREATE TABLE {schema}.reference (
    referenceid numeric(16,0) NOT NULL,
    tconfigurationid numeric(16,0),
    referencerow integer,
    ref_struct character varying(50),
    ref_transid character varying(10),
    master_field character varying(50),
    source_field character varying(50),
    ref_idcol character varying(10),
    dcondition character varying(300)
);

CREATE TABLE {schema}.samplefm (
    ename character varying(50)
);

CREATE TABLE {schema}.sampll (
    ename character varying(20)
);

CREATE TABLE {schema}.searchcols (
    searchcolsid numeric(16,0) NOT NULL,
    tconfigurationid numeric(16,0),
    searchcolsrow integer,
    searchflds character varying(20),
    acondition character varying(50)
);

CREATE TABLE {schema}.searchdef (
    transid character varying(50) NOT NULL,
    username character varying(30) NOT NULL,
    props text,
    rolename character varying(50),
    userlevel numeric(2,0),
    smode character varying(10)
);

CREATE TABLE {schema}.sect2 (
    sect2id numeric(16,0) NOT NULL,
    htmlsectionsid numeric(16,0)
);

CREATE TABLE {schema}.sect4 (
    sect4id numeric(16,0) NOT NULL,
    htmlsectionsid numeric(16,0),
    sect4row integer,
    filename character varying(50),
    filetype character varying(10)
);

CREATE TABLE {schema}.sendmsg (
    sendmsgid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    issubmit character varying(1),
    mtype character varying(50),
    docid character varying(10),
    currdate date,
    template character varying(100),
    keytemplate numeric(16,0),
    msgsubject character varying(500),
    msgcontent character varying(2000),
    smsmsg character varying(500)
);

CREATE TABLE {schema}.sendpkts (
    pktdate character varying(30),
    tosite numeric(5,0),
    transid character varying(5),
    username character varying(50),
    action character varying(1),
    totransid character varying(5),
    pktid character varying(50),
    recordid numeric(15,0),
    senton character varying(30),
    smode character varying(1),
    msenton character varying(30),
    mstatus character varying(7),
    status character varying(7),
    pktpriority numeric(2,0) DEFAULT 99
);

CREATE TABLE {schema}.sequence (
    sequenceid numeric(18,0) NOT NULL,
    prefix character varying(30),
    transtype character varying(5),
    fieldname character varying(20),
    activesequence character(1),
    description character varying(50),
    lastno numeric(15,0),
    corderby numeric,
    optionname character varying(50),
    prefixfield character varying(30),
    noofdigits numeric(2,0)
);

CREATE TABLE {schema}.structchanges (
    transid character varying(5),
    username character varying(30),
    changedon timestamp without time zone,
    sqltext character varying(3000)
);

CREATE TABLE {schema}.structlock (
    sname character varying(20) NOT NULL,
    cno character varying(4),
    lockedon character varying(25)
);

CREATE TABLE {schema}.tconfiguration (
    tconfigurationid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    structname character varying(50),
    structtransid character varying(20),
    configname1 character varying(10),
    configname2 character varying(10),
    configname3 character varying(10),
    configname4 character varying(15),
    cntval character varying(10),
    cv_searchflds character varying(200),
    cv_groupbuttons character varying(200),
    getallhtml character varying(200),
    cv_htmlprints character varying(200),
    getallref character varying(1000),
    getallreff character varying(1000),
    cv_masterflds character varying(1000)
);

CREATE TABLE {schema}.templates (
    templatesid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    type character varying(10),
    names character varying(100),
    iviewid character varying(10),
    elements character varying(100),
    cvalue text,
    dupchk character varying(500)
);

CREATE TABLE {schema}.testf1 (
    testf1id numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    field1 character varying(50)
);

CREATE TABLE {schema}.tstruct_mst_details (
    tstruct_mst_detailsid numeric(16,0) NOT NULL,
    cancel character varying(1),
    sourceid numeric(16,0),
    mapname character varying(20),
    username character varying(50),
    modifiedon timestamp without time zone,
    createdby character varying(50),
    createdon timestamp without time zone,
    wkid character varying(15),
    app_level numeric(3,0),
    app_desc numeric(1,0),
    app_slevel numeric(3,0),
    cancelremarks character varying(150),
    wfroles character varying(250),
    mastertransid character varying(10),
    sourcetransid character varying(10),
    sourcename character varying(100),
    soucecaption character varying(150),
    sourcetype character varying(20),
    sourcedetails character varying(400),
    sourcerules character varying(200),
    sleveno numeric(10,0),
    sordno numeric(10,0),
    dcid numeric(15,0),
    fsordno numeric(10,0),
    moe character varying(30),
    dcname character varying(10),
    fnum numeric(10,2),
    fldordno numeric(10,0),
    trackchanges character varying(100),
    trackchangesmadeby character varying(100),
    selectedusers character varying(1000),
    selectedfields character varying(1000)
);

CREATE TABLE {schema}.tstructscripts (
    username character varying(50) NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    createdby character varying(50),
    modifiedon timestamp without time zone,
    modifiedby character varying(50),
    stransid character varying(5),
    control_type character(1),
    event character varying(50),
    type character varying(20),
    name character varying(10),
    caption character varying(20),
    script text
);

CREATE TABLE {schema}.usagedtl (
    executeddate date,
    code character varying(20),
    title character varying(50),
    cnt numeric(18,0)
);

CREATE TABLE {schema}.usergroupings (
    username character varying(100),
    groupname character varying(100),
    groupvalue character varying(100)
);

CREATE TABLE {schema}.usergroupmaster (
    groupname character varying(100)
);

CREATE TABLE {schema}.usersequence (
    transtype character varying(5),
    fieldname character varying(20),
    uname character varying(30),
    prefix character varying(30)
);

CREATE TABLE {schema}.ut_timetaken (
    executed_date date,
    object_type character varying(10),
    service_name character varying(100),
    object_name character varying(100),
    tot_count numeric(10,0),
    count_8s numeric(10,0),
    count_30s numeric(10,0),
    count_90s numeric(10,0),
    min_time numeric(10,2),
    max_time numeric(10,2),
    avg_time numeric(10,2)
);
