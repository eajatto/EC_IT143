/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s3_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Ad hoc query that extracts the first name from ContactName.
-- Sources:     CHARINDEX, LEFT, CASE (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

SELECT CustomerID,
       ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
           ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
       END AS first_name
FROM   dbo.t_w3_schools_customers;