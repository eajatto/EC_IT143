/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s2_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Step 2 - Begin creating an answer (last name).
*****************************************************************************************/

-- Where I am: I can already find the first space with CHARINDEX (from the first-name work).
-- Next step: take everything to the right of that space with SUBSTRING.
-- Known edge case: CustomerID 91 ("Zbyszek") has no space, so it has no last name -> NULL.