-- Auto-generated tenant migration from golden dump.
-- Runtime placeholder: {schema}
-- Execute inside a single transaction after validating schemaName as an identifier.
SET LOCAL search_path = {schema}, pg_catalog;
SET LOCAL check_function_bodies = false;
CREATE TRIGGER ax_homebuild_master_bir BEFORE INSERT ON {schema}.ax_homebuild_master FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_homebuild_master();

CREATE TRIGGER ax_homebuild_saved_bir BEFORE INSERT ON {schema}.ax_homebuild_saved FOR EACH ROW EXECUTE FUNCTION {schema}.fn_homebuild_saved_bir();

CREATE TRIGGER ax_layoutdesign_bir BEFORE INSERT ON {schema}.ax_layoutdesign FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_layoutdesign();

CREATE TRIGGER ax_layoutdesign_saved_bir BEFORE INSERT ON {schema}.ax_layoutdesign_saved FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_layoutdesign_saved();

CREATE TRIGGER ax_notify_bir BEFORE INSERT ON {schema}.ax_notify FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_notify();

CREATE TRIGGER ax_page_saved_bir BEFORE INSERT ON {schema}.ax_page_saved FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_page_saved();

CREATE TRIGGER ax_page_template_bir BEFORE INSERT ON {schema}.ax_page_templates FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_page_templates();

CREATE TRIGGER ax_pages_bir BEFORE INSERT ON {schema}.ax_pages FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_pages();

CREATE TRIGGER ax_widget_bir BEFORE INSERT ON {schema}.ax_widget FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_widget();

CREATE TRIGGER ax_widget_publish_bir BEFORE INSERT ON {schema}.ax_widget_published FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_widget_published();

CREATE TRIGGER ax_widget_saved_bir BEFORE INSERT ON {schema}.ax_widget_saved FOR EACH ROW EXECUTE FUNCTION {schema}.fn_ax_widget_saved();

CREATE TRIGGER axp_tr_search_appsearch AFTER INSERT OR DELETE OR UPDATE ON {schema}.axp_appsearch_data_period FOR EACH ROW EXECUTE FUNCTION {schema}.axp_tr_search_appsearch();

CREATE TRIGGER axp_tr_search_appsearch1 BEFORE INSERT OR DELETE OR UPDATE ON {schema}.axp_appsearch_data_period FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axp_appsearch_data_period();

CREATE TRIGGER t1_axlanguage11x AFTER INSERT ON {schema}.axlanguage11x FOR EACH ROW EXECUTE FUNCTION {schema}.t1_axlanguage11x();

CREATE TRIGGER tr_axpconfigs_iviews BEFORE INSERT OR DELETE OR UPDATE ON {schema}.iconfiguration FOR EACH ROW EXECUTE FUNCTION {schema}.fn_iconfiguration();

CREATE TRIGGER tr_axpconfigs_iviews1 AFTER INSERT OR DELETE OR UPDATE ON {schema}.iconfiguration FOR EACH ROW EXECUTE FUNCTION {schema}.tr_axpconfigs_iviews();

CREATE TRIGGER tr_axpconfigs_tstructs BEFORE INSERT OR DELETE OR UPDATE ON {schema}.tconfiguration FOR EACH ROW EXECUTE FUNCTION {schema}.fn_tconfiguration();

CREATE TRIGGER tr_axpconfigs_tstructs1 AFTER INSERT OR DELETE OR UPDATE ON {schema}.tconfiguration FOR EACH ROW EXECUTE FUNCTION {schema}.tr_axpconfigs_tstructs();

CREATE TRIGGER trg_axactivetasks AFTER INSERT ON {schema}.axactivetasks FOR EACH ROW WHEN ((((new.grouped IS NULL) AND ((new.assigntoflg)::text = ANY (ARRAY[('2'::character varying)::text, ('3'::character varying)::text]))) OR ((new.assigntoflg)::text = ANY (ARRAY[('1'::character varying)::text, ('4'::character varying)::text])))) EXECUTE FUNCTION {schema}.fn_axactivetasks();

CREATE TRIGGER trg_axpdef_peg_actor AFTER UPDATE ON {schema}.axpdef_peg_actor FOR EACH ROW WHEN (((new.olddefusername)::text <> (new.defusername)::text)) EXECUTE FUNCTION {schema}.fn_pegv2_updapp_default();

CREATE TRIGGER trg_axpdef_peg_actorusergrp AFTER UPDATE ON {schema}.axpdef_peg_actorusergrp FOR EACH ROW WHEN (((new.oldugrpusername)::text <> (new.ugrpusername)::text)) EXECUTE FUNCTION {schema}.fn_pegv2_updapp_usegroups();

CREATE TRIGGER trg_axpdef_peg_grpfilter AFTER UPDATE ON {schema}.axpdef_peg_grpfilter FOR EACH ROW WHEN (((new.olddatagrpusers)::text <> (new.datagrpusers)::text)) EXECUTE FUNCTION {schema}.fn_pegv2_updapp_datagroups();

CREATE TRIGGER trg_axpeg_sendmsg AFTER INSERT ON {schema}.axpeg_sendmsg FOR EACH ROW EXECUTE FUNCTION {schema}.trg_axpeg_sendmsg();

CREATE TRIGGER trg_axpmailjobs BEFORE INSERT ON {schema}.axp_mailjobs FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axpmailjobs();

CREATE TRIGGER trg_axprocessdefv2 BEFORE INSERT OR UPDATE ON {schema}.axprocessdefv2 FOR EACH ROW EXECUTE FUNCTION {schema}.trg_axprocessdefv2();

CREATE TRIGGER trg_axrelations BEFORE INSERT ON {schema}.axrelations FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axrelations();

CREATE TRIGGER trg_axsms BEFORE INSERT ON {schema}.axsms FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axsms();

CREATE TRIGGER trg_axuserlevelgroups BEFORE INSERT OR UPDATE ON {schema}.axuserlevelgroups FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axuserlevelgroups();

CREATE TRIGGER trg_axusers BEFORE INSERT OR UPDATE ON {schema}.axusers FOR EACH ROW EXECUTE FUNCTION {schema}.fn_axusers();

CREATE TRIGGER trg_updatdsign BEFORE INSERT OR UPDATE ON {schema}.axdsignconfig FOR EACH ROW EXECUTE FUNCTION {schema}.fn_updatdsign();
