/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s3_ea_by.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Research and test. Adds last_modified_by and checks what SUSER_NAME() returns.
-- Sources:     SUSER_NAME (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

ALTER TABLE dbo.t_w3_schools_customers
    ADD last_modified_by VARCHAR(100) NULL;
GO

SELECT SUSER_NAME() AS current_server_user;