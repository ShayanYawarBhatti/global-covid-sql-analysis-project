
------------------------------------------------------------
-- 1. Create view for vaccination analysis
-- Saves the population vs vaccination query for later visualizations
--
-- A view is a saved SELECT query. It can be queried like a table,
-- but it does not usually store a separate copy of the data.
------------------------------------------------------------

USE PortfolioProject;
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
-- 2. Test the view
-- Query the saved view for later visualization/dashboard use
------------------------------------------------------------

SELECT *
FROM dbo.PercentPopulationVaccinated
ORDER BY location, date;
