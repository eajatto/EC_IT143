/*****************************************************************************************
IT143 - Final Project: My Communities Analysis - Create Answers (Deliverable 5.2)
Community:   Agriculture (FAOSTAT crop production and producer prices, 2019-2024)
Database:    AgricultureData
Tables:      dbo.CropProduction (Area, Area_Code_ISO3, Element, Item, Year, Unit, Value)
                 Element = 'Production' (t) or 'Yield' (kg/ha)
             dbo.CropPrices     (Area, Area_Code_ISO3, Element, Item, Year, Unit, Value)
                 Element = 'Producer Price (USD/tonne)'
Items:       Maize (corn), Cassava, fresh, Rice, Wheat
Script by:   Emmanuel Adebisi Jatto
Date:        2026-11-23
Notes:       Area 'China' is a FAOSTAT aggregate that double counts 'China, mainland',
             so every query excludes it (Area <> 'China').
             The two tables are joined on Area_Code_ISO3 (plus Item and Year).
             Countries with no reported price are handled with LEFT JOIN or left out,
             as described in each question.
*****************************************************************************************/

USE AgricultureData;
GO

/*****************************************************************************************
Q1: Which ten countries produced the most maize in 2023, and what price per tonne did
    their farmers receive? Show the country, production in tonnes, and producer price.
Question author: Emmanuel Jatto
Data gap: Some countries report no producer price; they show NULL in the price column.
*****************************************************************************************/

-- A1: take the top 10 producers first, then attach their producer price
WITH top_producers AS
(
    SELECT TOP 10
            Area,
            Area_Code_ISO3,
            Value AS production_tonnes
    FROM    dbo.CropProduction
    WHERE   Area <> 'China'
      AND   Item    = 'Maize (corn)'
      AND   Element = 'Production'
      AND   Year    = 2023
    ORDER BY Value DESC
)
SELECT  tp.Area,
        tp.production_tonnes,
        pr.Value AS producer_price_usd_per_tonne
FROM    top_producers AS tp
        LEFT JOIN dbo.CropPrices AS pr
               ON pr.Area_Code_ISO3 = tp.Area_Code_ISO3
              AND pr.Item = 'Maize (corn)'
              AND pr.Year = 2023
ORDER BY tp.production_tonnes DESC;
GO

/*****************************************************************************************
Q2: How did average wheat prices and total wheat production change each year from 2019
    to 2024? Show the year, average producer price per tonne, and total production.
Question author: Emmanuel Jatto
Data gap: Prices exist only for countries that report them.
*****************************************************************************************/

-- A2: summarize production and price separately by year, then join the two summaries
WITH production_by_year AS
(
    SELECT  Year,
            SUM(Value) AS total_production_tonnes
    FROM    dbo.CropProduction
    WHERE   Area <> 'China'
      AND   Item    = 'Wheat'
      AND   Element = 'Production'
      AND   Year BETWEEN 2019 AND 2024
    GROUP BY Year
),
price_by_year AS
(
    SELECT  Year,
            AVG(Value) AS avg_price_usd_per_tonne
    FROM    dbo.CropPrices
    WHERE   Area <> 'China'
      AND   Item = 'Wheat'
      AND   Year BETWEEN 2019 AND 2024
    GROUP BY Year
)
SELECT  p.Year,
        ROUND(pr.avg_price_usd_per_tonne, 2) AS avg_price_usd_per_tonne,
        p.total_production_tonnes
FROM    production_by_year AS p
        LEFT JOIN price_by_year AS pr
               ON pr.Year = p.Year
ORDER BY p.Year;
GO

/*****************************************************************************************
Q3: Which countries had cassava yields above the average in 2023 but producer prices
    below the average? Show the country, yield, and price per tonne.
Question author: Emmanuel Jatto
Data gap: Countries with no reported price are left out.
*****************************************************************************************/

-- A3: build 2023 yield and price per country, then compare each with its overall average
WITH cassava_yield AS
(
    SELECT  Area, Area_Code_ISO3, Value AS yield_kg_per_ha
    FROM    dbo.CropProduction
    WHERE   Area <> 'China'
      AND   Item    = 'Cassava, fresh'
      AND   Element = 'Yield'
      AND   Year    = 2023
),
cassava_price AS
(
    SELECT  Area_Code_ISO3, Value AS price_usd_per_tonne
    FROM    dbo.CropPrices
    WHERE   Area <> 'China'
      AND   Item = 'Cassava, fresh'
      AND   Year = 2023
)
SELECT  y.Area,
        y.yield_kg_per_ha,
        p.price_usd_per_tonne
FROM    cassava_yield AS y
        INNER JOIN cassava_price AS p
                ON p.Area_Code_ISO3 = y.Area_Code_ISO3
WHERE   y.yield_kg_per_ha     > (SELECT AVG(yield_kg_per_ha)     FROM cassava_yield)
  AND   p.price_usd_per_tonne < (SELECT AVG(price_usd_per_tonne) FROM cassava_price)
ORDER BY y.yield_kg_per_ha DESC;
GO

/*****************************************************************************************
Q4: Between 2019 and 2024, which countries had the highest average maize production and
    yield, and how did their average maize producer prices (USD per tonne) compare?
Question author: Milton Madire (classmate)
Note: "Highest" is read as the top 10 countries by average annual production.
*****************************************************************************************/

-- A4: average production and yield per country (pivoted with CASE), then attach average price
WITH maize_output AS
(
    SELECT TOP 10
            Area,
            Area_Code_ISO3,
            AVG(CASE WHEN Element = 'Production' THEN Value END) AS avg_production_tonnes,
            AVG(CASE WHEN Element = 'Yield'      THEN Value END) AS avg_yield_kg_per_ha
    FROM    dbo.CropProduction
    WHERE   Area <> 'China'
      AND   Item = 'Maize (corn)'
      AND   Year BETWEEN 2019 AND 2024
    GROUP BY Area, Area_Code_ISO3
    ORDER BY AVG(CASE WHEN Element = 'Production' THEN Value END) DESC
),
maize_price AS
(
    SELECT  Area_Code_ISO3,
            AVG(Value) AS avg_price_usd_per_tonne
    FROM    dbo.CropPrices
    WHERE   Area <> 'China'
      AND   Item = 'Maize (corn)'
      AND   Year BETWEEN 2019 AND 2024
    GROUP BY Area_Code_ISO3
)
SELECT  o.Area,
        ROUND(o.avg_production_tonnes, 0)       AS avg_production_tonnes,
        ROUND(o.avg_yield_kg_per_ha, 0)         AS avg_yield_kg_per_ha,
        ROUND(p.avg_price_usd_per_tonne, 2)     AS avg_price_usd_per_tonne
FROM    maize_output AS o
        LEFT JOIN maize_price AS p
               ON p.Area_Code_ISO3 = o.Area_Code_ISO3
ORDER BY o.avg_production_tonnes DESC;
GO
