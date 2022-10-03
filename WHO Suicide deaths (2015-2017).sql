SELECT * FROM who_health_data;

-- Total deaths from 2017-2019--
SELECT SUM(Deaths_All_Types)
FROM who_health_data;
 -- 36450775--
 
 
 -- Total sucide deaths from 2017-2019--
 SELECT SUM(deaths_suicides)
 FROM who_health_data;
 -- 30365--

-- Top 5 Countries with the highest death count--

SELECT Country_name as Country, SUM(deaths_all_types) as Death_count
FROM who_health_data
GROUP BY Country
ORDER BY Death_count DESC
LIMIT 5;

-- Answer: Japan,Germany,Egypt,Thailand,Brazil


-- Top 5 Countries with highest suicide rate --
SELECT Country_Name, SUM(deaths_suicides)
FROM who_health_data
GROUP BY Country_Name
ORDER BY deaths_suicides DESC
LIMIT 5;

-- Uzbekistan,Finland,Slovenia,Tajikistan,Egypt --

-- What year was the highest sucide recorded?--

SELECT Year, SUM(Deaths_suicides) AS suicide_deaths 
FROM who_health_data
GROUP BY Year
ORDER BY suicide_deaths DESC;

-- 2018 (23589 suicides)

-- How many suicide deaths were recorded in Uzbekistan in 2018?--
SELECT 
    SUM(deaths_suicides), country_name, Year
FROM
    who_health_data
WHERE
    Year = 2018 AND Country_Name = 'Uzbekistan';
    
-- 2278--

-- What is the percentsge of deaths were sucides?
SELECT (SUM(deaths_suicides)/SUM(deaths_all_types) *100) as suicide_percentage
FROM who_health_data;
-- 0.083% --

-- What percentage of deaths in Uzbekistan committed suicide?
SELECT (SUM(deaths_suicides)/SUM(deaths_all_types) *100) as suicide_percentage
FROM who_health_data
WHERE Country_Name = 'Uzbekistan';
-- 0.74% --

-- What percentage of Uzbekistan committed suicide?
SELECT (SUM(deaths_suicides)/SUM(population) *100) as suicide_percentage
FROM who_health_data
WHERE Country_Name = 'Uzbekistan';
-- 0.007%--

