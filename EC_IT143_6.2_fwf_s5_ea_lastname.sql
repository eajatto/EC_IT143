/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s5_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Scalar user-defined function that returns the last name from a
--              contact name (text after the first space). Returns NULL when
--              there is no space.
-- Sources:     CREATE FUNCTION, SUBSTRING, CHARINDEX (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

CREATE OR ALTER FUNCTION dbo.udf_parse_last_name (@v_contact_name VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    -- No space means a one-word name, so there is no last name to return
    RETURN CASE
               WHEN CHARINDEX(' ', @v_contact_name) = 0 THEN NULL
               ELSE SUBSTRING(@v_contact_name, CHARINDEX(' ', @v_contact_name) + 1, LEN(@v_contact_name))
           END;
END;
GO