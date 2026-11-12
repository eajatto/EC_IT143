/*****************************************************************************************
NAME:    EC_IT143_W3.4_ea
PURPOSE: Answer eight AdventureWorks questions with SQL (W3.4 Create Answers)

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------
1.0     11/12/2026   E.A. Jatto     1. Built this script for EC IT143


RUNTIME:
0m 1s

NOTES:
This script answers eight questions from the W3.3 discussion: two of my own
and six from classmates. Each question is numbered, commented out, and credited
to its original author.
*****************************************************************************************/

-- Q1: What is the highest list price among all our products? Author: Festus
-- A1: MAX returns the largest value in the ListPrice column.

SELECT MAX(ListPrice) AS HighestListPrice
FROM Production.Product;


-- Q2: How many products in our catalog have the color Red? Author: Iorlaha
-- A2: Count the products whose Color is Red.

SELECT COUNT(*) AS RedProducts
FROM Production.Product
WHERE Color = 'Red';


-- Q3: Which product category has the largest number of distinct products assigned to it? Author: Iorlaha
-- A3: Join products to subcategories and categories, count per category, keep the top one.

SELECT TOP 1 WITH TIES
       pc.Name AS CategoryName,
       COUNT(p.ProductID) AS ProductCount
FROM Production.Product AS p
JOIN Production.ProductSubcategory AS ps
    ON ps.ProductSubcategoryID = p.ProductSubcategoryID
JOIN Production.ProductCategory AS pc
    ON pc.ProductCategoryID = ps.ProductCategoryID
GROUP BY pc.Name
ORDER BY COUNT(p.ProductID) DESC;


-- Q4: Which sales territory generated the highest total order revenue in 2013, based on the order subtotal? Author: Iorlaha
-- A4: Sum the order subtotals for 2013 by territory and keep the highest.

SELECT TOP 1 WITH TIES
       st.Name AS TerritoryName,
       SUM(soh.SubTotal) AS TotalSubTotal
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesTerritory AS st
    ON st.TerritoryID = soh.TerritoryID
WHERE soh.OrderDate >= '2013-01-01'
  AND soh.OrderDate < '2014-01-01'
GROUP BY st.Name
ORDER BY SUM(soh.SubTotal) DESC;


-- Q5: List each order year with total quantity sold and total line revenue for the Road Bikes subcategory, sorted by year. Author: E. A. Jatto
-- A5: Join orders, order lines, products and subcategories, filter to Road Bikes, group by year.

SELECT YEAR(soh.OrderDate) AS OrderYear,
       SUM(sod.OrderQty) AS UnitsSold,
       SUM(sod.LineTotal) AS Revenue
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS p
    ON p.ProductID = sod.ProductID
JOIN Production.ProductSubcategory AS ps
    ON ps.ProductSubcategoryID = p.ProductSubcategoryID
WHERE ps.Name = 'Road Bikes'
GROUP BY YEAR(soh.OrderDate)
ORDER BY OrderYear;


-- Q6: Which three vendors had the highest total rejected quantity across all purchase orders? Author: Festus
-- A6: Sum RejectedQty per vendor across all purchase order lines and keep the top three.

SELECT TOP 3 WITH TIES
       v.Name AS VendorName,
       SUM(pod.RejectedQty) AS TotalRejected
FROM Purchasing.PurchaseOrderDetail AS pod
JOIN Purchasing.PurchaseOrderHeader AS poh
    ON poh.PurchaseOrderID = pod.PurchaseOrderID
JOIN Purchasing.Vendor AS v
    ON v.BusinessEntityID = poh.VendorID
GROUP BY v.Name
ORDER BY SUM(pod.RejectedQty) DESC;


-- Q7: Which tables or views contain a column named ModifiedDate? Author: Iorlaha
-- A7: Search the INFORMATION_SCHEMA.COLUMNS view for that column name.

SELECT TABLE_SCHEMA,
       TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ModifiedDate'
ORDER BY TABLE_SCHEMA, TABLE_NAME;


-- Q8: How many columns in the Sales.SalesOrderHeader table allow NULL values? Author: E. A. Jatto
-- A8: Count the rows in INFORMATION_SCHEMA.COLUMNS where IS_NULLABLE is YES.

SELECT COUNT(*) AS NullableColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
  AND TABLE_NAME = 'SalesOrderHeader'
  AND IS_NULLABLE = 'YES';