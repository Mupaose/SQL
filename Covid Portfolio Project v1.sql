Select *
from PortifolioProject..CovidDeaths
order by 3,4

--Select *
--from PortifolioProject..CovidVaccinations
--order by 3,4

-- Selecting the data I am going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortifolioProject..CovidDeaths
Order by 1,2

--Looking at Total Cases vs Total Deaths
-- shows the likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From PortifolioProject..CovidDeaths
Where location like '%states%'
Order by 1,2

--Loooking at the Total Cases Vs the Total Population
--Shows what percentage of the population got Covid

--looking ata countries with highest infection rates against the poppulation

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
From PortifolioProject..CovidDeaths
--Where location like '%states%'
Group by location, population
Order by PercentagePopulationInfected desc

--showing the countries with the highest death count per population

Select location, Max(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not NULL
Group by location
Order by TotalDeathCount desc


--Let's Break things up by Continent

--showing the continents with the highest death counts per population

Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortifolioProject..CovidDeaths
--Where location like '%states%'
Where continent is NOT NULL
Group by continent
Order by TotalDeathCount desc



--GLOBAL NUMBERS
--By Date

Select date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int))as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
From PortifolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null
group by date
Order by 1,2

--By Total Global Numbers

Select SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int))as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
From PortifolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null
--group by date
Order by 1,2


--Joining Covid Deaths and Covid Vaccinations Tables


Select *
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   and dea.date = vac.date


   --Looking at Total Population vs Vaccination
   --You can replace 'Cast' with 'Convert' by "..Convert(int, vac.new_vaccinations)....". Works the same way.

 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated,
 --(RollingPeopleVaccinated/population)*100
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
order by 2,3


--As seen above, in the commented out formula, trying to use the table created in a formula does not work
--so we need to make use of CTEs or Temp Tables to allows us the table 'RollingPeoleVaccinated'

-- USING CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100 as RollingPoeplePercentage
from PopvsVac


--USING TEMP TABLES
-- Always add 'Drop Table if exists" to be allow you to make changes in the query without running error messages

Drop table if exists #PercentagePopulationVaccinated
Create Table #PercentagePopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentagePopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   and dea.date = vac.date
----Where dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
from #PercentagePopulationVaccinated



--Creating a VIEW to store data for later visualization
--A view is virtual table based on the result-set of an SQL Statement
--found in the side bar under views, refresh to show


Create VIEW PercentagePopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
 --(RollingPeopleVaccinated/population)*100
From PortifolioProject..CovidDeaths dea
Join PortifolioProject..CovidVaccinations vac
   ON dea.location = vac.location
   and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select * 
from PercentagePopulationVaccinated