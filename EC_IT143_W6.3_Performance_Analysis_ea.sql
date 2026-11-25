/*
Course: IT143
Assignment: W6.3 Performance Analysis
Author: Emmanuel Adebisi Jatto
Database: AdventureWorks2022
Purpose: Generate missing index recommendations using execution plans,
         create the recommended indexes, and compare costs.
*/

USE AdventureWorks2022;
GO

/* ---------- Query 1: Person.Address (City) ---------- */
SELECT *
FROM Person.Address
WHERE City = 'Bothell';
-- Before: Estimated Subtree Cost = 0.217106
--         Index Scan, Missing Index Impact = 91.0545

CREATE NONCLUSTERED INDEX IX_Address_City
ON Person.Address (City);
GO

-- After:  Estimated Subtree Cost = 0.0305711 (about 86% lower)
--         Index Seek replaced the scan

/* ---------- Query 2: Sales.SalesOrderHeader (PurchaseOrderNumber) ---------- */
SELECT *
FROM Sales.SalesOrderHeader
WHERE PurchaseOrderNumber = 'PO18444174044';
-- Before: Estimated Subtree Cost = 0.548631
--         Clustered Index Scan, Missing Index Impact = 99.3143

CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_PurchaseOrderNumber
ON Sales.SalesOrderHeader (PurchaseOrderNumber);
GO

-- After:  Estimated Subtree Cost = 0.0065707 (about 98.8% lower)
--         Index Seek replaced the scan