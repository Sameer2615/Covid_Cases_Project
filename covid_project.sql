CREATE TABLE COVID_DEATH(
                iso_code VARCHAR(100),
				continent VARCHAR(200),	
				location VARCHAR(100),	
				date DATE,
				population INT,
				total_cases INT,
				new_cases INT,
				new_cases_smoothed FLOAT,
				total_deaths INT,
				new_deaths INT,
				new_deaths_smoothed FLOAT,
				total_cases_per_million	FLOAT,
				new_cases_per_million FLOAT,
				new_cases_smoothed_per_million FLOAT,
				total_deaths_per_million FLOAT,	
				new_deaths_per_million FLOAT,
				new_deaths_smoothed_per_million FLOAT,
				reproduction_rate FLOAT,
				icu_patients INT,
				icu_patients_per_million FLOAT,
				hosp_patients INT,
				hosp_patients_per_million FLOAT,
				weekly_icu_admissions FLOAT,
				weekly_icu_admissions_per_million FLOAT,
				weekly_hosp_admissions FLOAT,	
				weekly_hosp_admissions_per_million FLOAT
				);
CREATE TABLE covid_vaccine
          (                  
				iso_code VARCHAR(100),
				continent VARCHAR(200),	
				location VARCHAR(100),	
				date DATE,
                new_tests INT,
				total_tests INT,
				total_tests_per_thousand float,
				new_tests_per_thousand FLOAT,
				new_tests_smoothed INT,
				new_tests_smoothed_per_thousand FLOAT,
				positive_rate FLOAT,
				tests_per_case FLOAT,
				tests_units VARCHAR(100),
				total_vaccinations INT,
				people_vaccinated INT,
				people_fully_vaccinated	INT,
				new_vaccinations INT,
				new_vaccinations_smoothed INT,
				total_vaccinations_per_hundred FLOAT,
				people_vaccinated_per_hundred FLOAT,
				people_fully_vaccinated_per_hundred FLOAT,	
				new_vaccinations_smoothed_per_million FLOAT,	
				stringency_index FLOAT,	
				population_density FLOAT,
				median_age FLOAT,	
				aged_65_older FLOAT,
				aged_70_older FLOAT,	
				gdp_per_capita FLOAT,
				extreme_poverty	FLOAT,
				cardiovasc_death_rate FLOAT,
				diabetes_prevalence	FLOAT,
				female_smokers FLOAT,	
				male_smokers FLOAT,
				handwashing_facilities FLOAT,
				hospital_beds_per_thousand FLOAT,	
				life_expectancy FLOAT,
				human_development_index FLOAT
				);
SELECT * from covid_vaccine;
SELECT *
FROM covid_death
WHERE continent IS NOT NULL 
ORDER BY 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_death
WHERE continent is NOT NULL
ORDER BY 1,2;

-- Looking at Total Cases vs Total Deaths

SELECT location, 
	   date, 
	   total_cases, 
	   total_deaths, 
	   ROUND((total_deaths::numeric / total_cases::numeric) *100 ,2) AS DeathPercentage
FROM covid_death
WHERE location='Nepal'
ORDER BY 1,2;

-- Total Cases vs Population
-- Shows what percentage of the population got Covid

SELECT location, 
       date, 
	   total_cases, 
	   population, 
	   ROUND((total_cases::numeric / population::numeric) *100, 5) AS CasesByPopulation
FROM covid_death
WHERE location='Nepal'
ORDER BY 1,2;

-- Countries with Highest Infection Rate compared to Population

SELECT location, 
       population,
	   MAX(total_cases) AS HighestInfectionCount, 
	   ROUND(MAX((total_cases::numeric / population::numeric))*100,2) AS PercentPopulationInfected
FROM covid_death
--WHERE location='Nepal'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

SELECT location, 
       population,
	   date,
	   MAX(total_cases) AS HighestInfectionCount, 
	   ROUND(MAX((total_cases::numeric / population::numeric))*100,2) AS PercentPopulationInfected
FROM covid_death
--WHERE location='Nepal'
GROUP BY location, population,date
ORDER BY PercentPopulationInfected DESC;


-- Countries with Highest Death Count per Population

SELECT 
    location, 
    MAX(total_deaths) AS total_deaths,
    MAX(population) AS population,
    ROUND(
        MAX(total_deaths::numeric) / NULLIF(MAX(population::numeric), 0) * 100.0,4) AS death_percent
FROM covid_death
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY death_percent DESC;


-- Continents with Highest Death Count 

SELECT continent, SUM(total_deaths::numeric) AS total_deaths
FROM covid_death
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC;

-- Global Numbers by date

SELECT 
       SUM(new_cases) AS TotalCases, 
	   SUM(new_deaths ) AS TotalDeaths, 
	   ROUND((SUM(new_deaths::numeric) /SUM(new_cases::numeric))*100, 2) AS DeathPercentage
FROM covid_death
WHERE continent is NOT NULL
--GROUP BY date
ORDER BY 1,2;

--Nepal number by date

SELECT 
    date, 
    SUM(new_cases) AS TotalCases, 
    SUM(new_deaths) AS TotalDeaths, 
    ROUND(
        SUM(new_deaths::numeric) * 100 / NULLIF(SUM(new_cases::numeric),0) ,2) AS DeathPercentage
FROM covid_death
WHERE location = 'Nepal'
GROUP BY date
ORDER BY date;

--Keep all data but show NULLs last
SELECT 
    date, 
    SUM(new_cases) AS TotalCases,
    SUM(new_deaths) AS TotalDeaths,
    ROUND(
        SUM(new_deaths::numeric) * 100 / NULLIF(SUM(new_cases::numeric), 0), 2) AS DeathPercentage
FROM covid_death
WHERE location = 'Nepal'
GROUP BY date
ORDER BY DeathPercentage NULLS LAST;


-- Global Numbers overall

SELECT SUM(new_cases) AS TotalCases, 
       SUM(new_deaths) AS TotalDeaths, 
	   ROUND((SUM(new_deaths::numeric)/SUM(new_cases::numeric))*100, 2) AS DeathPercentage
FROM covid_death
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- Total Population vs Vaccinations
-- Percentage of Population that has received at least one Covid Vaccine

SELECT cd.continent,    
       cd.location, 
	   cd.date, 
	   cd.population, 
	   cv.new_vaccinations, 
	   SUM(cv.new_vaccinations) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
FROM covid_death cd
JOIN covid_vaccine cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
ORDER BY 2,3;


-- Using CTE to perform calculation on partition by previous query

WITH PopulationvsVaccinations (Continent, Location, date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT cd.continent,    
       cd.location, 
	   cd.date, 
	   cd.population, 
	   cv.new_vaccinations, 
	   SUM(cv.new_vaccinations) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
FROM covid_death cd
JOIN covid_vaccine cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
)
SELECT *, 
       ROUND((RollingPeopleVaccinated::numeric /Population::numeric)*100,4) AS RollingPercent
FROM PopulationvsVaccinations


--Using TEMP TABLE to perform calculation on Partition By in previous query 

Create Table PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255), 
date date, 
Population numeric, 
New_Vaccinations numeric, 
RollingPeopleVaccinated numeric
)

INSERT INTO PercentPopulationVaccinated
SELECT cd.continent,    
       cd.location, 
	   cd.date, 
	   cd.population, 
	   cv.new_vaccinations, 
	   SUM(COALESCE(cv.new_vaccinations, 0)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
FROM covid_death cd
JOIN covid_vaccine cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL

SELECT *,    
       ROUND((RollingPeopleVaccinated::numeric/Population::numeric)*100,4) AS RollingPercent
FROM PercentPopulationVaccinated;

DROP TABLE PercentPopulationVaccinated;


-- Creating View to store data for later visualisations

CREATE View PercentPopulationVaccinated as
SELECT cd.continent,    
       cd.location, 
	   cd.date, 
	   cd.population, 
	   cv.new_vaccinations, 
	   SUM(COALESCE(cv.new_vaccinations, 0)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
FROM covid_death cd
JOIN covid_vaccine cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL;





