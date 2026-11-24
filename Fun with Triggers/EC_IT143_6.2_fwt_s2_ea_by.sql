/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s2_ea_by.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Step 2 - Begin creating an answer (last modified by).
*****************************************************************************************/

-- Where I am: the trigger already stamps the date on every update.
-- Next step: add a last_modified_by column and have the same trigger fill it with SUSER_NAME(),
-- which returns the login of the person running the update.
-- I will alter the existing trigger instead of adding a second one, because two triggers
-- updating the same table can fire each other in a loop.