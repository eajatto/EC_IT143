/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s4_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Research and test the last-name logic, including the no-space edge case.
-- Sources:     SUBSTRING (Transact-SQL), Microsoft Docs
--              CHARINDEX (Transact-SQL), Microsoft Docs
--              CASE (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

SELECT ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN NULL
           ELSE SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
       END AS last_name
FROM   dbo.t_w3_schools_customers
WHERE  CustomerID IN (1, 91);
-- Expected: Maria Anders -> "Anders"; Zbyszek -> NULL