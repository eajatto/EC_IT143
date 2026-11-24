/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwt_s4_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: After-update trigger that stamps last_modified_date on every row updated.
-- Sources:     CREATE TRIGGER (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

CREATE OR ALTER TRIGGER dbo.trg_w3_customers_last_modified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- "inserted" holds the new version of the updated rows
    UPDATE c
    SET    c.last_modified_date = GETDATE()
    FROM   dbo.t_w3_schools_customers c
    JOIN   inserted i ON i.CustomerID = c.CustomerID;
END;
GO