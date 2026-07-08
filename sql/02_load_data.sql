USE PortfolioProject;
GO

------------------------------------------------------------
-- Load COVID datasets into SQL Server
--
-- This script creates the CovidDeaths and CovidVaccinations
-- tables and loads data from CSV files using BULK INSERT.
--
-- Note: The CSV files must already be copied into the SQL Server
-- Docker container at:
-- /tmp/CovidDeaths.csv
-- /tmp/CovidVaccinations.csv
------------------------------------------------------------

DROP TABLE IF EXISTS dbo.CovidDeaths;
GO

CREATE TABLE dbo.CovidDeaths (
    [iso_code] NVARCHAR(255) NULL,
    [continent] NVARCHAR(255) NULL,
    [location] NVARCHAR(255) NULL,
    [date] DATE NULL,
    [population] FLOAT NULL,
    [total_cases] FLOAT NULL,
    [new_cases] FLOAT NULL,
    [new_cases_smoothed] FLOAT NULL,
    [total_deaths] FLOAT NULL,
    [new_deaths] FLOAT NULL,
    [new_deaths_smoothed] FLOAT NULL,
    [total_cases_per_million] FLOAT NULL,
    [new_cases_per_million] FLOAT NULL,
    [new_cases_smoothed_per_million] FLOAT NULL,
    [total_deaths_per_million] FLOAT NULL,
    [new_deaths_per_million] FLOAT NULL,
    [new_deaths_smoothed_per_million] FLOAT NULL,
    [reproduction_rate] FLOAT NULL,
    [icu_patients] FLOAT NULL,
    [icu_patients_per_million] FLOAT NULL,
    [hosp_patients] FLOAT NULL,
    [hosp_patients_per_million] FLOAT NULL,
    [weekly_icu_admissions] FLOAT NULL,
    [weekly_icu_admissions_per_million] FLOAT NULL,
    [weekly_hosp_admissions] FLOAT NULL,
    [weekly_hosp_admissions_per_million] FLOAT NULL
);
GO

BULK INSERT dbo.CovidDeaths
FROM '/tmp/CovidDeaths.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    KEEPNULLS
);
GO

DROP TABLE IF EXISTS dbo.CovidVaccinations;
GO

CREATE TABLE dbo.CovidVaccinations (
    [iso_code] NVARCHAR(255) NULL,
    [continent] NVARCHAR(255) NULL,
    [location] NVARCHAR(255) NULL,
    [date] DATE NULL,
    [new_tests] FLOAT NULL,
    [total_tests] FLOAT NULL,
    [total_tests_per_thousand] FLOAT NULL,
    [new_tests_per_thousand] FLOAT NULL,
    [new_tests_smoothed] FLOAT NULL,
    [new_tests_smoothed_per_thousand] FLOAT NULL,
    [positive_rate] FLOAT NULL,
    [tests_per_case] FLOAT NULL,
    [tests_units] NVARCHAR(255) NULL,
    [total_vaccinations] FLOAT NULL,
    [people_vaccinated] FLOAT NULL,
    [people_fully_vaccinated] FLOAT NULL,
    [new_vaccinations] FLOAT NULL,
    [new_vaccinations_smoothed] FLOAT NULL,
    [total_vaccinations_per_hundred] FLOAT NULL,
    [people_vaccinated_per_hundred] FLOAT NULL,
    [people_fully_vaccinated_per_hundred] FLOAT NULL,
    [new_vaccinations_smoothed_per_million] FLOAT NULL,
    [stringency_index] FLOAT NULL,
    [population_density] FLOAT NULL,
    [median_age] FLOAT NULL,
    [aged_65_older] FLOAT NULL,
    [aged_70_older] FLOAT NULL,
    [gdp_per_capita] FLOAT NULL,
    [extreme_poverty] FLOAT NULL,
    [cardiovasc_death_rate] FLOAT NULL,
    [diabetes_prevalence] FLOAT NULL,
    [female_smokers] FLOAT NULL,
    [male_smokers] FLOAT NULL,
    [handwashing_facilities] FLOAT NULL,
    [hospital_beds_per_thousand] FLOAT NULL,
    [life_expectancy] FLOAT NULL,
    [human_development_index] FLOAT NULL
);
GO

BULK INSERT dbo.CovidVaccinations
FROM '/tmp/CovidVaccinations.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    KEEPNULLS
);
GO
