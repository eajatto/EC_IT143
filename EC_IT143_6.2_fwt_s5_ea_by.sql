/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s5_ea_by.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Test that the trigger fills both audit columns on update.
*****************************************************************************************/

USE EC_IT143_DA;
GO

UPDATE dbo.t_w3_schools_customers
SET    ContactName = ContactName
WHERE  CustomerID = 2;

SELECT CustomerID, ContactName, last_modified_date, last_modified_by
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID IN (1, 2, 3);
-- Expected: row 2 has date and your login; row 1 has the older date and NULL for "by";
--           row 3 is NULL in both columns