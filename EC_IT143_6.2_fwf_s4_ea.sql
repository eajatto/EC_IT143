/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s4_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Research and test. Found why the first-name query failed (Msg 537)
--              and tested a CASE guard that handles names with no space.
-- Sources:     CHARINDEX (Transact-SQL), Microsoft Docs
--              LEFT (Transact-SQL), Microsoft Docs
--              CASE (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

-- 1. Find rows where CHARINDEX returns 0 (no space in the name)
SELECT CustomerID, ContactName
FROM   dbo.t_w3_schools_customers
WHERE  CHARINDEX(' ', ContactName) = 0;
-- Result: CustomerID 91, "Zbyszek". CHARINDEX = 0, so LEFT(..., 0 - 1) = LEFT(..., -1) -> Msg 537.

-- 2. Test the CASE guard on that one row
SELECT ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
           ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
       END AS first_name
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID IN (1, 91);
-- Expected: Maria Anders -> "Maria"; Zbyszek -> "Zbyszek"