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

```text
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
