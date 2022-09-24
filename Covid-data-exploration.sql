--In this project, we use covid data worldwide to get insights about the situation in Morocco and campare it to the situation of its neigboor Algeria

--The first thing we are going to do is to select the data of the two countries.
--The following query would do so in addition to selecting the data from the first day of when cases were being received.

select *
from CovidDataAnalysis.dbo.covid_data
--where continent like 'Africa'
where iso_code like 'MAR' 
or iso_code like 'DZA'
and total_cases is not null

--We notice that some columns are useless for our analysis. for that reason we are going to only select usefull columns.

select iso_code, location, date, population, total_cases, new_cases, total_deaths, new_deaths, total_tests, new_tests, total_vaccinations, new_vaccinations
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA'
and total_cases is not null


--Lets Start our analysis
--We are going to get the total cases registered for each country during the whole period

--For Morocco:

select location, sum(new_cases) as TotalCasesRegistered
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
--Result: 1264068 case

--For Algeria:

select location, sum(new_cases) as TotalCasesRegistered
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'DZA' 
--Result: 269971 case

--For both 

select location, sum(new_cases) as TotalCasesRegistered
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'DZA' or iso_code like 'MAR'
group by location

--Algeria	269971
--Morocco	1264068

--Lets calculate the average daily new cases for both countries

select location, avg(new_cases) as TotalCasesRegistered
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'DZA' or iso_code like 'MAR'
group by location

--Algeria:	296.345773874863 cases daily
--Morocco:	1396.76022099448 cases daily

--Let's get the total vaccinations

select location, max(total_vaccinations) as Total_vaccinations
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA'
group by location 
order by Total_vaccinations desc

--Algeria	9989662
--Morocco	9864561
--Algeria has the greater amount of vaccinations campared to Morocco.

--Total deaths
select location, sum(cast(new_deaths as int)) as total_deaths
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA'
group by location
order by total_deaths

--Deaths ratio

select location, date, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_ratio
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA'

--Average deaths to total cases

select location, avg(cast(total_deaths as int)) as avg_deaths
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA'
group by location
order by avg_deaths desc;

--Deaths to cases ratio
select location,date,total_cases, total_deaths, (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathsToCases_rate
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA' 
order by location desc;

--Vaccination to population rate
select location,date,population, people_vaccinated, (cast(people_vaccinated as float))/(cast(population as float))*100 as VaccToPop_rate
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA' 
or total_vaccinations <> null
order by location desc;

--Highest deaths count
select location, avg(population)as population, sum(cast(new_deaths as float)) as highestDeathsCount
from CovidDataAnalysis.dbo.covid_data
where iso_code like 'MAR' 
or iso_code like 'DZA' 
or total_vaccinations <> null
group by location
order by highestDeathsCount desc;

--That was it. Thank you. 
--This was a simple showcase of data querying in SQL