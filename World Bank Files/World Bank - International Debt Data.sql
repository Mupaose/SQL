-- to allow the useof the database portfolio projects in our our queries
USE portfolioproject;

-- to show the tables of the data that we want to work with
SELECT *
FROM international_debt;

-- the data is for international debt of all countries of the world, collected form the World Bank
-- The questions to answer here are as follows:
-- 1. What is the total amount of debt owed by all the countries?
-- 2. Which country owes the maximum amount of debt and how much is it?
-- 3. Whats the average amount of debt is owed by countries across different debt indicators?

-- Finding the distinct number of countries on the data
SELECT 
	COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt;

-- Finding out the count of distinct number of debt indicators
SELECT
	COUNT(DISTINCT indicator_code) AS total_debt_indicators
FROM international_debt;

-- Finding out the distince indicators by name
SELECT DISTINCT indicator_code AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;


-- Finding the total amount of debt owed by the countries
SELECT ROUND(SUM(debt), 2) AS total_debt
FROM international_debt;

-- Finding the country with the highest debt
SELECT
	country_name,
    SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;

-- Finding the average amount of debt across indicators
SELECT
	indicator_code AS debt_indicator,
    indicator_name,
    AVG(debt) AS average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC;

-- finding the highest amount of principal repayments
SELECT
	country_name,
    indicator_name,
    MAX(debt) as total_debt
FROM international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name
ORDER BY total_debt DESC
LIMIT 1;

-- Finding the most common debt indicator
SELECT 
	indicator_code,
    COUNT(indicator_code) AS indicator_count
FROM international_debt
GROUP BY indicator_code
ORDER BY indicator_count DESC
LIMIT 1;


-- finding highest total debts for top 10 countries
SELECT 
	country_name,
    MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10










