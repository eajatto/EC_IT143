/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s6_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: Compares the ad hoc first-name query with the UDF, side by side.
-- Sources:     Same as s5
*****************************************************************************************/

USE EC_IT143_DA;
GO

SELECT CustomerID,
       ContactName,
       CASE
           WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
           ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
       END                                   AS adhoc_first_name,
       dbo.udf_parse_first_name(ContactName) AS udf_first_name
FROM   dbo.t_w3_schools_customers;