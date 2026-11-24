/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s3_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Research and test. Adds the last_modified_date column and checks it.
-- Sources:     Add Columns to a Table (Database Engine), Microsoft Docs
--              CREATE TRIGGER (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

ALTER TABLE dbo.t_w3_schools_customers
    ADD last_modified_date DATETIME NULL;
GO

SELECT TOP 5 CustomerID, ContactName, last_modified_date
FROM   dbo.t_w3_schools_customers;
-- Expected: last_modified_date is NULL for every row