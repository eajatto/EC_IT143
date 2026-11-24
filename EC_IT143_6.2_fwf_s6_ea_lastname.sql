/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s6_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Compares the ad hoc last-name query with the UDF, side by side.
-- Sources:     Same as s5
*****************************************************************************************/

USE EC_IT143_DA;
GO

SELECT CustomerID,
       ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN NULL
           ELSE SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
       END                                  AS adhoc_last_name,
       dbo.udf_parse_last_name(ContactName) AS udf_last_name
FROM   dbo.t_w3_schools_customers;