/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s5_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Test that the trigger fills last_modified_date on update.
*****************************************************************************************/

USE EC_IT143_DA;
GO

UPDATE dbo.t_w3_schools_customers
SET    ContactName = ContactName      -- no visible change, but it still fires the trigger
WHERE  CustomerID = 1;

SELECT CustomerID, ContactName, last_modified_date
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID IN (1, 2);
-- Expected: row 1 has today's date and time, row 2 is still NULL