-- Split seed data files generated from original 100_seed_data.sql.
-- Execute files in filename order. Each file preserves original table-block order.
SET LOCAL search_path = {schema}, pg_catalog;

-- Seed: tstructscripts (0 rows)
-- No rows in source dump for tstructscripts.

-- Seed: usagedtl (0 rows)
-- No rows in source dump for usagedtl.

-- Seed: usergroupings (0 rows)
-- No rows in source dump for usergroupings.

-- Seed: usergroupmaster (0 rows)
-- No rows in source dump for usergroupmaster.

-- Seed: usersequence (0 rows)
-- No rows in source dump for usersequence.

-- Seed: ut_timetaken (0 rows)
-- No rows in source dump for ut_timetaken.


-- Sequence values from source dump.
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
