/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s2_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Step 2 - Begin creating an answer.
*****************************************************************************************/

-- Where I am: dbo.t_w3_schools_customers has no column that records changes.
-- A default constraint only fills a value when a row is INSERTED, not UPDATED,
-- so it cannot track modifications.
-- Next step: add a last_modified_date column, then use an AFTER UPDATE trigger to fill it.