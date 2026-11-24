/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s5_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Scalar user-defined function that returns the first name from a
--              contact name (text before the first space). If there is no space,
--              the whole value is returned.
-- Sources:     CREATE FUNCTION (Transact-SQL), Microsoft Docs
--              CHARINDEX / LEFT / CASE (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

CREATE OR ALTER FUNCTION dbo.udf_parse_first_name (@v_contact_name VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    -- Return the whole value when there is no space (e.g., "Zbyszek"),
    -- otherwise return everything to the left of the first space
    RETURN CASE
               WHEN CHARINDEX(' ', @v_contact_name) = 0 THEN @v_contact_name
               ELSE LEFT(@v_contact_name, CHARINDEX(' ', @v_contact_name) - 1)
           END;
END;
GO