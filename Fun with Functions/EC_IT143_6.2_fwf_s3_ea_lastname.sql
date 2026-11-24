/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s3_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Ad hoc query that extracts the last name from ContactName.
-- Sources:     CHARINDEX, SUBSTRING, CASE (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

SELECT CustomerID,
       ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN NULL
           ELSE SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
       END AS last_name
FROM   dbo.t_w3_schools_customers;