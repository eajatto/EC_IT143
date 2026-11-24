/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s7_ea.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: "0 results expected" test. Returns any row where the UDF result
--              differs from the ad hoc query. If the function works, 0 rows return.
-- Sources:     WITH common_table_expression (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

WITH adhoc AS (
    SELECT CustomerID,
           CASE
               WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
               ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
           END AS first_name
    FROM   dbo.t_w3_schools_customers
),
udf AS (
    SELECT CustomerID,
           dbo.udf_parse_first_name(ContactName) AS first_name
    FROM   dbo.t_w3_schools_customers
)
SELECT a.CustomerID,
       a.first_name AS adhoc_value,
       u.first_name AS udf_value
FROM   adhoc a
JOIN   udf   u ON u.CustomerID = a.CustomerID
WHERE  a.first_name <> u.first_name;   -- expect 0 rows