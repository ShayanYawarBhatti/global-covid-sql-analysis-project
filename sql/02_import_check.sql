USE PortfolioProject;
GO

SELECT COUNT(*) AS CovidDeaths_RowCount
FROM dbo.CovidDeaths;

SELECT COUNT(*) AS CovidVaccinations_RowCount
FROM dbo.CovidVaccinations;

SELECT TOP 10 *
FROM dbo.CovidDeaths;

SELECT TOP 10 *
FROM dbo.CovidVaccinations;