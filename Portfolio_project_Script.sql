/* This project is about exploring the 'Covid dataset, from ourworldindata.org */
/* The data set was in Excel format and we convert into a csv file to import into MySQL Workbench*/

/* Selecting the columns that we will be using in our data exploration*/

select location, date, total_cases, new_cases, total_deaths,population
from portfolio_project.coviddeaths_t1
order by 1,2;

/* Looking at Total Cases vs total Deaths
 i.e percentage of persons who are dying being infected (DeathPercentage) */

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolio_project.coviddeaths_t1
order by 1,2;

/* Looking at the DeathPercentage in USA */
/* This shows the likelihood of dying if you contract covid in USA */

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolio_project.coviddeaths_t1
where location like '%States%'
order by 1,2;

/* Looking at the Total Cases vs Population in Africa */
/* show what percentage of population got Covid in Africa */

select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from portfolio_project.coviddeaths_t1
where location = 'Africa';

/* Looking at Countries with Highest Infection Rate compared to Population */

select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from portfolio_project.coviddeaths_t1
group by location, population
order by PercentPopulationInfected desc;

/* Showing the top 10 Countries with Highest Death Count per Population */

select location,  Max(total_deaths) as TotalDeathCount 
from portfolio_project.coviddeaths_t1
group by location
order by TotalDeathCount desc
limit 10;

/* LET'S BREAK THINGS DOWN BY CONTINENT */

/* Showing the continents with the highest death count per population */

select continent,  Max(total_deaths) as TotalDeathCount 
from portfolio_project.coviddeaths_t1
where continent is not null
group by continent
order by TotalDeathCount desc;

/* GLOBAL NUMBERS */

select  date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths) / SUM(new_cases)*100 as DeathPercentage
from portfolio_project.coviddeaths_t1
where continent is not null
group by date
order by 1,2;

/* Overall over the World */

select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths) / SUM(new_cases)*100 as DeathPercentage
from portfolio_project.coviddeaths_t1
/*where continent is not null */
order by 1,2;

/* LET JOINT COVIDDEATHS_t1 AND COVIDVACCINATION_t1 TABLES, based on the location */

SELECT *
FROM portfolio_project.coviddeaths_t1 d
JOIN portfolio_project.covidvaccinations_t1 v 
ON d.location = v.location;

/* Looking at Total Population vs Vaccinations */

select d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as RollingPeopleVaccinated
from portfolio_project.coviddeaths_t1 d
join portfolio_project.covidvaccinations_t1 v
on d.location = v.location
order by 2,3;

 /* MM: SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as RollingPeopleVaccinated calculates the cumulative total of new_vaccinations overtime for each location */
 /* the  OVER (Partition by d.location order by d.location, d.date) ensures that the sum is calculated per location, ordered by date. */
 
 /* USE CTE: A Common Table Expression (CTE) is a temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. */
 /* CTEs are defined using the WITH clause, and they only exist for the duration of the query.*/
 
With PopvsVac (continent, location, date, population, RollingPeopleVaccinated, new_vaccinations)
as 
(
select d.continent, d.location, d.date, d.population, v.new_vaccinations, SUM(v.new_vaccinations) OVER (Partition by d.location order by d.location, d.date) as RollingPeopleVaccinated
from portfolio_project.coviddeaths_t1 d
join portfolio_project.covidvaccinations_t1 v
on d.location = v.location
order by 2,3
)
select *
from PopvsVac;


/* CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS */
/* A View in MySQL is a virtual table based on the result of a SELECT query. It does not store data itself but acts as a saved query that you can use like a regular table. */

create view  DeathPercentage as
select  date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths) / SUM(new_cases)*100 as DeathPercentage
from portfolio_project.coviddeaths_t1
where continent is not null
group by date
order by 1,2;

CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;
