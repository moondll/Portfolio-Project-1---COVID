-- SELECT location, date, total_cases, new_cases, total_deaths, population
-- FROM PortfolioProject.coviddeaths

-- Looking at Total cases vs Total deaths (percentage of those who died)

-- Shows likelihood of dying if you contract COVID in your country
-- SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
-- FROM PortfolioProject.coviddeaths
-- WHERE location = 'United States'

-- Looking at Total cases vs Population

-- Shows what percentage of the population has contracted COVID
-- SELECT Location, date, total_cases, population, (total_cases/population)*100 AS population_infected_percentage
-- FROM PortfolioProject.coviddeaths
-- WHERE location = 'United States'

-- Looking at countries with highest infection rate compared to population

-- SELECT Location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population))*100 AS population_infected_percentage
-- FROM PortfolioProject.coviddeaths
-- GROUP BY Location, population
-- ORDER BY population_infected_percentage DESC

-- Showing Countries with highest death count per population

-- SELECT location, MAX(CAST(total_deaths AS UNSIGNED)) AS total_death_count
-- FROM PortfolioProject.coviddeaths
-- WHERE continent IS NOT NULL
-- GROUP BY location
-- ORDER BY total_death_count DESC

-- Break things down by continent

-- SELECT location, MAX(CAST(total_deaths AS UNSIGNED)) AS total_death_count
-- FROM PortfolioProject.coviddeaths
-- WHERE continent IS NULL
-- GROUP BY location
-- ORDER BY total_death_count DESC

-- Break things down by continent 'drilldown'

-- SELECT continent, MAX(CAST(total_deaths AS UNSIGNED)) AS total_death_count
-- FROM PortfolioProject.coviddeaths
-- WHERE continent IS NOT NULL
-- GROUP BY continent
-- ORDER BY total_death_count DESCcoviddeaths

-- Global numbers

-- SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS SIGNED)) as total_deaths, SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 as death_percentage
-- FROM PortfolioProject.coviddeaths
-- WHERE continent IS NOT NULL
-- GROUP BY date
-- ORDER BY 1,2

-- Global numbers without date

-- SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS SIGNED)) as total_deaths, SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 as death_percentage
-- FROM PortfolioProject.coviddeaths
-- WHERE continent IS NOT NULL
-- ORDER BY 1,2

-- Total population vs. Vaccinations

-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
-- FROM PortfolioProject.coviddeaths dea
-- JOIN PortfolioProject.covidvaccinations vac
	-- ON dea.location = vac.location
    -- and dea.date = vac.date
-- WHERE dea.continent IS NOT NULL
-- ORDER BY 2,3

--  Adding total vaccinations column using new_vaccinations

-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rolling_vaccinated, -- (rolling_vaccinated/population)*100 
-- FROM PortfolioProject.coviddeaths dea
-- JOIN PortfolioProject.covidvaccinations vac
	-- ON dea.location = vac.location
    -- and dea.date = vac.date
-- WHERE dea.continent IS NOT NULL
-- ORDER BY 2,3

-- Using CTE

-- WITH popvsvac (continent, location, date, population, new_vaccinations, rolling_vaccinated)
-- AS
-- (
-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rolling_vaccinated
-- FROM PortfolioProject.coviddeaths dea
-- JOIN PortfolioProject.covidvaccinations vac
	-- ON dea.location = vac.location
    -- and dea.date = vac.date
-- WHERE dea.continent IS NOT NULL
-- ORDER BY 2,3
-- )
-- SELECT *, (rolling_vaccinated/population)*100
-- FROM popvsvac

-- Using a Temp Table

-- DROP TABLE IF exists percent_population_vaccinated
-- CREATE TABLE percent_population_vaccinated
-- (
-- continent text,
-- location text,
-- date datetime,
-- population text,
-- new_vaccinations text,
-- rolling_vaccinated text
-- )
-- INSERT INTO percent_population_vaccinated
-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rolling_vaccinated
-- FROM PortfolioProject.coviddeaths dea
-- JOIN PortfolioProject.covidvaccinations vac
	-- ON dea.location = vac.location
    -- and dea.date = vac.date
-- SELECT *, (rolling_vaccinated/population)*100
-- FROM percent_population_vaccinated

-- Createing View to store data for later visualizations

-- CREATE VIEW percent_population_vaccinated AS
-- SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as rolling_vaccinated
-- FROM PortfolioProject.coviddeaths dea
-- JOIN PortfolioProject.covidvaccinations vac
	-- ON dea.location = vac.location
    -- and dea.date = vac.date
-- WHERE dea.continent IS NOT NULL



















