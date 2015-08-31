use NCARBDW
go

/*
Update PopulationEstimates set f1 = replace(f1, ' (Stearns County), ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' urban county, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' (balance), ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' city (balance), ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' unified government, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' borough, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' village, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' city, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' city and borough, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' town, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' town, ', ', ');
Update PopulationEstimates set f1 = replace(f1, ' municipality, ', ', ');
delete from PopulationEstimates where f1='' or f1 is null;
select * from PopulationEstimates;
*/

--truncate table PopulationEstimates;
--truncate table ufo;

-- order by count
select avg(percapita) avgSightingsPerCapita, avg([2013]) avgPopulation, count(distinct fulllocation) cntLocation, statetext, fullLocation, cnt from (
select count(8) cnt, fulllocation, cast([2013] as int) [2013], StateText, cast(count(8) as decimal)/cast([2013] as decimal) PerCapita from (
select distinct SightingDate, fullLocation, s.StateText, [2013]
from	PopulationEstimates p 
join	(select ufo.City, s.StateText, replace(ufo.SightingDate, '"', '') SightingDate, 
			case when (replace(ufo.City, '"', '') like '%(Brooklyn)%' 
					or replace(ufo.City, '"', '') like '%(Queens)%' 
					or replace(ufo.City, '"', '') like '%(Bronx%' 
					or replace(ufo.City, '"', '') like '%(Manhattan)%' 
					or replace(ufo.City, '"', '') = 'Staten Island') and replace(ufo.State, '"', '') = 'NY' then 'New York'
				 else replace(ufo.City, '"', '') end
			 + ', ' + s.StateText fullLocation from ufo
			join	state s on s.Code = replace(ufo.State, '"', '')) s
on s.fullLocation = p.F1) a
where	[2013] > 10000
group by fullLocation, [2013], StateText
--order by 5 desc
) a
--where StateText = 'Texas'
group by statetext,fullLocation, cnt
--having count(distinct fulllocation) > 4
order by 1 desc;


--order by population
select count(8) cnt, fulllocation, cast([2013] as int) [2013], StateText from (
select distinct SightingDate, fullLocation, s.StateText, [2013]
from	PopulationEstimates p
join	(select ufo.City, s.StateText, replace(ufo.SightingDate, '"', '') SightingDate, 
			case when (replace(ufo.City, '"', '') like '%(Brooklyn)%' 
					or replace(ufo.City, '"', '') like '%(Queens)%' 
					or replace(ufo.City, '"', '') like '%(Bronx%' 
					or replace(ufo.City, '"', '') like '%(Manhattan)%' 
					or replace(ufo.City, '"', '') = 'Staten Island') and replace(ufo.State, '"', '') = 'NY' then 'New York'
				 else replace(ufo.City, '"', '') end
			 + ', ' + s.StateText fullLocation from ufo
			join	state s on s.Code = replace(ufo.State, '"', '')) s
on s.fullLocation = p.F1) a
group by fullLocation, [2013], StateText
order by 3 desc;


select distinct SightingDate, fullLocation, s.StateText, [2013], replace(City, '"', '') City, lat, lon, [2013]/10000 bins, Shape
from	PopulationEstimates p 
join	(select ufo.City, s.StateText, replace(ufo.SightingDate, '"', '') SightingDate, 
			case when (replace(ufo.City, '"', '') like '%(Brooklyn)%' 
					or replace(ufo.City, '"', '') like '%(Queens)%' 
					or replace(ufo.City, '"', '') like '%(Bronx%' 
					or replace(ufo.City, '"', '') like '%(Manhattan)%' 
					or replace(ufo.City, '"', '') = 'Staten Island') and replace(ufo.State, '"', '') = 'NY' then 'New York'
				 else replace(ufo.City, '"', '') end
			 + ', ' + s.StateText fullLocation, lat, lon, replace(ufo.Shape, '"', '') Shape from ufo
			join	state s on s.Code = replace(ufo.State, '"', '')) s
on s.fullLocation = p.F1
--where SightingDate like '9/11/13%'
order by 1

