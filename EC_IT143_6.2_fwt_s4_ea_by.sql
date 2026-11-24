/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s4_ea_by.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Alters the after-update trigger so it records both when and who
--              last modified each row.
-- Sources:     CREATE TRIGGER, SUSER_NAME (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

CREATE OR ALTER TRIGGER dbo.trg_w3_customers_last_modified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET    c.last_modified_date = GETDATE(),
           c.last_modified_by   = SUSER_NAME()
    FROM   dbo.t_w3_schools_customers c
    JOIN   inserted i ON i.CustomerID = c.CustomerID;
END;
GO