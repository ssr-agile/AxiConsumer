-- Split seed data files generated from original 100_seed_data.sql.
-- Execute files in filename order. Each file preserves original table-block order.
SET LOCAL search_path = {schema}, pg_catalog;

-- Seed: msgs1 (0 rows)
-- No rows in source dump for msgs1.

-- Seed: msgs2 (0 rows)
-- No rows in source dump for msgs2.

-- Seed: outbound (0 rows)
-- No rows in source dump for outbound.

-- Seed: pdfimage (0 rows)
-- No rows in source dump for pdfimage.

-- Seed: pdfprops (0 rows)
-- No rows in source dump for pdfprops.

-- Seed: popupsizes (0 rows)
-- No rows in source dump for popupsizes.

-- Seed: printprms (0 rows)
-- No rows in source dump for printprms.

-- Seed: printprops (0 rows)
-- No rows in source dump for printprops.

-- Seed: prints (0 rows)
-- No rows in source dump for prints.

-- Seed: publishprops (0 rows)
-- No rows in source dump for publishprops.

-- Seed: recvpkts (0 rows)
-- No rows in source dump for recvpkts.

-- Seed: reference (0 rows)
-- No rows in source dump for reference.

-- Seed: samplefm (0 rows)
-- No rows in source dump for samplefm.

-- Seed: sampll (0 rows)
-- No rows in source dump for sampll.

-- Seed: searchcols (0 rows)
-- No rows in source dump for searchcols.

-- Seed: searchdef (0 rows)
-- No rows in source dump for searchdef.

-- Seed: sect2 (0 rows)
-- No rows in source dump for sect2.

-- Seed: sect4 (0 rows)
-- No rows in source dump for sect4.

-- Seed: sendmsg (0 rows)
-- No rows in source dump for sendmsg.

-- Seed: sendpkts (0 rows)
-- No rows in source dump for sendpkts.

-- Seed: sequence (8 rows)
INSERT INTO {schema}.sequence (sequenceid, prefix, transtype, fieldname, activesequence, description, lastno, corderby, optionname, prefixfield, noofdigits)
VALUES
('100199', 'AP', 'a__ap', 'AutoPrintId', 'T', '', '1', NULL, NULL, '', '6'),
('101368', 'AXPEG', 'ad_pm', 'processtable', 'T', '', '1', NULL, NULL, '', '5'),
('102167', 'job-', 'job_s', 'jobid', 'F', '', '1', NULL, NULL, '', '6'),
('102168', 'axs0', 'job_s', 'jobid', 'F', '', '1', NULL, NULL, '', '6'),
('102169', 'did', 'job_s', 'jobid', 'T', '', '1', NULL, NULL, 'prefix', '6'),
('103883', 'AXGS', 'agspr', 'docid', 'T', '', '1', NULL, NULL, '', '6'),
('105013', 'MSG', 'sendm', 'docid', 'T', 'EMAIL/SMS', '1', NULL, NULL, '', '6'),
('105750', 'DOC-', 'dgmal', 'docid', 'T', '', '1', NULL, NULL, '', '6')
ON CONFLICT DO NOTHING;

-- Seed: structchanges (0 rows)
-- No rows in source dump for structchanges.

-- Seed: structlock (0 rows)
-- No rows in source dump for structlock.

-- Seed: tconfiguration (0 rows)
-- No rows in source dump for tconfiguration.

-- Seed: templates (0 rows)
-- No rows in source dump for templates.

-- Seed: testf1 (1 rows)
INSERT INTO {schema}.testf1 (testf1id, cancel, sourceid, mapname, username, modifiedon, createdby, createdon, wkid, app_level, app_desc, app_slevel, cancelremarks, wfroles, field1)
VALUES
('1011220000000', 'F', '0', NULL, 'admin', '2026-03-03 15:53:46', 'admin', '2026-03-03 15:53:46', NULL, '1', '1', '0', NULL, NULL, 'sdfdsf')
ON CONFLICT DO NOTHING;

-- Seed: tstruct_mst_details (0 rows)
-- No rows in source dump for tstruct_mst_details.
