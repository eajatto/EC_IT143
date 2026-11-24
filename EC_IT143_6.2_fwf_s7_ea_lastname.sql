/*****************************************************************************************
-- Script name: EC_IT143_6.2_fwf_s7_ea_lastname.sql
-- Author:      Emmanuel Adebisi Jatto
-- Date:        2026-11-23
-- Description: "0 results expected" test for the last-name function.
-- Sources:     WITH common_table_expression (Transact-SQL), Microsoft Docs
*****************************************************************************************/

USE EC_IT143_DA;
GO

WITH adhoc AS (
    SELECT CustomerID,
           CASE
               WHEN CHARINDEX(' ', ContactName) = 0 THEN NULL
               ELSE SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
           END AS last_name
    FROM   dbo.t_w3_schools_customers
),
udf AS (
    SELECT CustomerID,
           dbo.udf_parse_last_name(ContactName) AS last_name
    FROM   dbo.t_w3_schools_customers
)
SELECT a.CustomerID,
       a.last_name AS adhoc_value,
       u.last_name AS udf_value
FROM   adhoc a
JOIN   udf   u ON u.CustomerID = a.CustomerID
WHERE  ISNULL(a.last_name, '') <> ISNULL(u.last_name, '');   -- expect 0 rows