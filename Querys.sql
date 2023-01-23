
use covid;

SELECT 
	Location,
	max(cast(total_cases as float)) as Cases,
	max(cast(total_deaths as float)) as Deaths,
	max(cast(population as float)) as Population,
	(max(cast(total_deaths as float)) / max(cast(total_cases as float))) * 100 as Mortality_Rate,
	(max(cast(total_cases as float)) / max(cast(population as float))) * 100 as Infected_rate
FROM
	CovidDeaths
WHERE 
	continent is null
--	location = 'BRAZIL'
GROUP BY
	Location
having 
	max(cast(total_cases as float)) >= 1000000
order by
	 Deaths desc


SELECT 
	dea.location as Location,
	MAX(cast(dea.population as float)) as Population,
	sum(cast(vac.new_vaccinations as float)) as Vaccinated_people,
	(sum(cast(vac.new_vaccinations as float)) / Max(cast(dea.population as float))) * 100 as Vaccination_Rate
FROM
	CovidDeaths as dea
	join CovidVaccinations as vac 
	on Dea.location = vac.location and dea.date = vac.date
where dea.location = 'Brazil'
group by dea.location


-----------------
SELECT 
	dea.location as Location,
	dea.date as Date,
	dea.population as Population,
	sum(cast(vac.new_vaccinations as float)) OVER(PARTITION BY dea.location order by dea.location, dea.date) as Vaccinated_people
--	(sum(cast(vac.new_vaccinations as float)) / Max(cast(dea.population as float))) * 100 as Vaccination_Rate
FROM
	CovidDeaths as dea
	join CovidVaccinations as vac 
	on Dea.location = vac.location and dea.date = vac.date
where dea.location = 'Brazil'



SELECT Location, MAX(cast(total_vaccinations as float)) as total, SUM(cast(new_vaccinations as float)) as total2
FROM
	CovidVaccinations 
where Location = 'Brazil'
Group by Location

