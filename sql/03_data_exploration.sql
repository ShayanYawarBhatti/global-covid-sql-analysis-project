USE PortfolioProject;
GO


------------------------------------------------------------
-- 1. Initial table check
-- Preview both imported tables
------------------------------------------------------------

SELECT * 
FROM dbo.CovidDeaths
ORDER BY location, date;

SELECT * 
FROM dbo.CovidVaccinations
ORDER BY location, date;


------------------------------------------------------------
-- 2. Understanding key columns for analysis
-- Selecting the main columns used throughout the project
------------------------------------------------------------

SELECT 
    location, 
    date, 
    total_cases, 
    new_cases, 
    total_deaths, 
    population
FROM dbo.CovidDeaths
ORDER BY location, date;


------------------------------------------------------------
-- 3. Total cases vs total deaths
-- Shows the reported case fatality rate for the United States
------------------------------------------------------------

SELECT 
    location, 
    date, 
    total_cases, 
    total_deaths,
    ROUND((total_deaths / NULLIF(total_cases, 0)) * 100, 2) AS case_fatality_rate_pct
FROM dbo.CovidDeaths
WHERE location = 'United States'
  AND continent IS NOT NULL
ORDER BY location, date;


------------------------------------------------------------
-- 4. Total cases vs population
-- Shows reported COVID cases as a percentage of the population
------------------------------------------------------------

SELECT 
    location, 
    date, 
    population,
    total_cases, 
    ROUND((total_cases / NULLIF(population, 0)) * 100, 2) AS percent_population_infected
FROM dbo.CovidDeaths
WHERE location = 'United States'
  AND continent IS NOT NULL
ORDER BY location, date;


------------------------------------------------------------
-- 5. Countries with the highest infection rate
-- Compares each country's highest reported case count to its population
------------------------------------------------------------

SELECT 
    location, 
    population,
    MAX(total_cases) AS highest_reported_case_count, 
    ROUND((MAX(total_cases) / NULLIF(population, 0)) * 100, 2) AS percent_population_infected
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_population_infected DESC;


------------------------------------------------------------
-- 6. Countries with the highest total death count
------------------------------------------------------------

SELECT 
    location, 
    MAX(total_deaths) AS total_death_count
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC;


------------------------------------------------------------
-- 7. Highest country-level death count within each continent
-- Note: This shows the maximum country death count per continent,
-- not total deaths across the entire continent.
------------------------------------------------------------

SELECT 
    continent, 
    MAX(total_deaths) AS highest_country_death_count
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_country_death_count DESC;


------------------------------------------------------------
-- 8. Total reported deaths by continent
-- This sums daily new deaths across countries in each continent.
------------------------------------------------------------

SELECT 
    continent,
    SUM(new_deaths) AS total_death_count
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;


------------------------------------------------------------
-- 9. Global death percentage
-- Shows total global reported cases, deaths, and death percentage
------------------------------------------------------------

SELECT  
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100, 2) AS global_death_percentage
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL;


------------------------------------------------------------
-- 10. Global numbers by date
-- Shows daily global reported cases, deaths, and death percentage
------------------------------------------------------------

SELECT  
    date,
    SUM(new_cases) AS total_cases, 
    SUM(new_deaths) AS total_deaths,
    ROUND((SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100, 2) AS global_death_percentage
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;


------------------------------------------------------------
-- 11. Total population vs vaccinations
-- Calculates a rolling vaccination count by location
-- and compares it to population
------------------------------------------------------------

WITH PopVsVac AS (
    SELECT 
        d.continent, 
        d.location, 
        d.date, 
        d.population, 
        v.new_vaccinations,
        SUM(COALESCE(v.new_vaccinations, 0)) OVER (
            PARTITION BY d.location 
            ORDER BY d.date
        ) AS rolling_vaccination_count
    FROM dbo.CovidDeaths AS d
    JOIN dbo.CovidVaccinations AS v
        ON d.location = v.location 
        AND d.date = v.date
    WHERE d.continent IS NOT NULL
)
SELECT 
    continent, 
    location, 
    date, 
    population, 
    new_vaccinations, 
    rolling_vaccination_count,
    ROUND((rolling_vaccination_count / NULLIF(population, 0)) * 100, 2) AS percent_population_vaccinated
FROM PopVsVac
ORDER BY location, date;


------------------------------------------------------------
-- 12. Create view for vaccination analysis
-- Saves the population vs vaccination query for later visualizations
--
-- A view is a saved SELECT query. It can be queried like a table,
-- but it does not usually store a separate copy of the data.
------------------------------------------------------------

GO

CREATE OR ALTER VIEW dbo.PercentPopulationVaccinated AS
WITH PopVsVac AS (
    SELECT 
        d.continent, 
        d.location, 
        d.date, 
        d.population, 
        v.new_vaccinations,
        SUM(COALESCE(v.new_vaccinations, 0)) OVER (
            PARTITION BY d.location 
            ORDER BY d.date
        ) AS rolling_vaccination_count
    FROM dbo.CovidDeaths AS d
    JOIN dbo.CovidVaccinations AS v
        ON d.location = v.location 
        AND d.date = v.date
    WHERE d.continent IS NOT NULL
)
SELECT 
    continent, 
    location, 
    date, 
    population, 
    new_vaccinations, 
    rolling_vaccination_count,
    ROUND((rolling_vaccination_count / NULLIF(population, 0)) * 100, 2) AS percent_population_vaccinated
FROM PopVsVac;
GO


------------------------------------------------------------
-- 13. Test the view
-- Query the saved view for later visualization/dashboard use
------------------------------------------------------------

SELECT *
FROM dbo.PercentPopulationVaccinated
ORDER BY location, date;