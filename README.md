# Global COVID-19 SQL Analysis

## Project Overview

This project explores global COVID-19 cases, deaths, infection rates, and vaccination progress using SQL Server.

The goal of this project was to practice SQL data exploration using real-world public health data and prepare analysis-ready outputs for future dashboarding in Tableau.

## Tools Used

- SQL Server
- Docker
- Visual Studio Code
- SQL Server VS Code Extension
- GitHub
- CSV datasets

## Dataset

The project uses two CSV files:

- `CovidDeaths.csv`
- `CovidVaccinations.csv`

The data includes country-level COVID-19 information such as total cases, new cases, total deaths, population, and vaccination progress.

## Project Structure

global-covid-sql-analysis/
    data/
        CovidDeaths.csv
        CovidVaccinations.csv

    sql/
        01_create_database.sql
        02_load_data.sql
        03_import_check.sql
        04_data_exploration.sql
        05_create_views.sql

    README.md
    .gitignore

## SQL Workflow

### 1. Database Creation

The database is created using `01_create_database.sql`.

### 2. Data Loading

The two CSV files are loaded into SQL Server tables:

- `dbo.CovidDeaths`
- `dbo.CovidVaccinations`

The data was loaded using manually defined schemas and `BULK INSERT` to avoid import wizard data type errors.

### 3. Data Validation

Row counts and sample records are checked after loading the data.

### 4. Data Exploration

The analysis explores:

- Total cases vs total deaths
- Case fatality rate
- Total cases vs population
- Countries with the highest infection rates
- Countries with the highest death counts
- Death counts by continent
- Global case and death totals
- Rolling vaccination counts
- Percentage of population vaccinated

### 5. View Creation

A SQL view was created for vaccination analysis:

- `dbo.PercentPopulationVaccinated`

This view can be used later for Tableau or Power BI visualizations.

## Key SQL Concepts Used

- SELECT statements
- WHERE filters
- ORDER BY
- GROUP BY
- Aggregate functions
- Joins
- Common Table Expressions
- Window functions
- Views
- NULL handling with `NULLIF`
- Missing value handling with `COALESCE`

## Notes

This project was completed using SQL Server running locally in Docker on macOS. The SQL Server import wizard initially inferred incorrect data types, so the data loading process was handled manually using table creation scripts and `BULK INSERT`.

## Next Steps

- Build Tableau dashboard
- Add Tableau Public dashboard link
- Add dashboard screenshots
- Summarize final insights
