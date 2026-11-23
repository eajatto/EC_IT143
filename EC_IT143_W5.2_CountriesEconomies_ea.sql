/*****************************************************************************************
IT143 - Final Project: My Communities Analysis - Create Answers (Deliverable 5.2)
Community:   Countries and Economies (World Bank data)
Database:    CountriesEconomies
Tables:      dbo.Countries (Country_Code, Region, IncomeGroup, ...)
             dbo.GDP       (Country_Name, Country_Code, Y1960 ... Y2025; current US$)
Script by:   Emmanuel Adebisi Jatto
Date:        2026-11-23
Notes:       Groupings such as "Arab World" have no Region or IncomeGroup in
             dbo.Countries, so they are excluded by the filters below.
*****************************************************************************************/

USE CountriesEconomies;
GO

/*****************************************************************************************
Q1: Which three countries had the highest GDP in 2024 within each World Bank region?
    Show the region, country name, and 2024 GDP.
Question author: Emmanuel Jatto
*****************************************************************************************/

-- A1: rank countries inside each region with ROW_NUMBER(), then keep the top 3
WITH ranked_gdp AS
(
    SELECT  c.Region,
            g.Country_Name,
            g.Y2024 AS GDP_2024,
            ROW_NUMBER() OVER (PARTITION BY c.Region
                               ORDER BY g.Y2024 DESC) AS rank_in_region
    FROM    dbo.GDP AS g
            INNER JOIN dbo.Countries AS c
                    ON c.Country_Code = g.Country_Code
    WHERE   c.Region IS NOT NULL
      AND   g.Y2024  IS NOT NULL
)
SELECT  Region,
        rank_in_region,
        Country_Name,
        GDP_2024
FROM    ranked_gdp
WHERE   rank_in_region <= 3
ORDER BY Region, rank_in_region;
GO

/*****************************************************************************************
Q2: How many countries are in each income group, and what was their combined GDP in 2024?
    Show the income group, number of countries, and total 2024 GDP.
Question author: Emmanuel Jatto
*****************************************************************************************/

-- A2: group by income group, count the countries, and sum 2024 GDP
SELECT  c.IncomeGroup,
        COUNT(*)      AS number_of_countries,
        SUM(g.Y2024)  AS total_gdp_2024
FROM    dbo.Countries AS c
        INNER JOIN dbo.GDP AS g
                ON g.Country_Code = c.Country_Code
WHERE   c.IncomeGroup IS NOT NULL
GROUP BY c.IncomeGroup
ORDER BY total_gdp_2024 DESC;
GO

/*****************************************************************************************
Q3: Which countries more than doubled their GDP between 2014 and 2024?
    Show the country name, region, 2014 GDP, 2024 GDP, and the growth ratio.
Question author: Emmanuel Jatto
Data gap: GDP is in current US dollars, so growth is not adjusted for inflation.
*****************************************************************************************/

-- A3: compare the two year columns and keep countries where 2024 is more than 2x 2014
SELECT  g.Country_Name,
        c.Region,
        g.Y2014                      AS GDP_2014,
        g.Y2024                      AS GDP_2024,
        ROUND(g.Y2024 / g.Y2014, 2)  AS growth_ratio
FROM    dbo.GDP AS g
        INNER JOIN dbo.Countries AS c
                ON c.Country_Code = g.Country_Code
WHERE   c.Region IS NOT NULL
  AND   g.Y2014 > 0
  AND   g.Y2024 > 2 * g.Y2014
ORDER BY growth_ratio DESC;
GO

/*****************************************************************************************
Q4: Which are the top 10 countries in Sub-Saharan Africa with the highest GDP in 2025,
    and what is the income group classification of each country?
Question author: Souleymane Biaou (classmate)
Note: If this returns no rows, Y2025 holds no values yet; use Y2024 instead.
*****************************************************************************************/

-- A4: filter to the Sub-Saharan Africa region, order by 2025 GDP, keep the top 10
SELECT TOP 10
        g.Country_Name,
        c.IncomeGroup,
        g.Y2025 AS GDP_2025
FROM    dbo.GDP AS g
        INNER JOIN dbo.Countries AS c
                ON c.Country_Code = g.Country_Code
WHERE   c.Region = 'Sub-Saharan Africa'
  AND   g.Y2025 IS NOT NULL
ORDER BY g.Y2025 DESC;
GO
