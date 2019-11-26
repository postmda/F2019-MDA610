/* Sample Database: World*/

/* 1. List all databases. */
SHOW DATABASES;

/* 2. Use the World database. */
USE world;

/* 3. List tables in the database. */
SHOW TABLES;

/* 4. Show the structure of table country. */
DESCRIBE country;

/* 5. Show the structure of table city. */
SHOW COLUMNS FROM city;

/* 6. Show all records in table country. */
SELECT * FROM country;

/* 7. Show each country with region. */
SELECT name, region FROM country;

/* 8. Show the region Germany belongs to. */
SELECT name, region 
FROM country 
WHERE name = 'Germany';

/* 9. Show the surface area and 
      population of Germany; use
      'area' and 'pop' as 
      the column names in the 
      output. */
SELECT surfacearea AS area, population AS pop
FROM country 
WHERE name = 'Germany';

/* 10. Show the country name and GNP of each country 
       in Southeast Asia; sort the results in 
       descending order of GNP. */ 
SELECT name, gnp
FROM country
WHERE region = 'Southeast Asia'
ORDER BY gnp DESC; 

/* 11. Show the country name and GNP of the
       ten countries with the highest GNP. */
SELECT name, gnp
FROM country
ORDER BY gnp DESC
LIMIT 10; 

/* 12. Show the country name and surface area of the
       five smallest countries. */
SELECT name, surfacearea
FROM country
ORDER BY surfacearea ASC
LIMIT 5; 


/* 13. Show the region, population and GNP of each European 
country; sort the results in ascending order of region 
and descending order of population. */
SELECT region, population, GNP
FROM country
WHERE continent = 'Europe'
ORDER BY region ASC, population DESC;

/* 14. Show the distinct continents. */
SELECT DISTINCT(continent)
FROM country
ORDER by continent;

/* 15. Show the number of distinct
       regions. */
SELECT COUNT(DISTINCT(region)) AS NumofRegions
FROM country;

/* 16. Show the total number of countries in the 
	   table country. */
SELECT COUNT(code) AS NumofCountries
FROM country;

/* 17. Show the ten countries with the highest GNP per capita. */
SELECT name, GNP/population AS GNP_PER_CAPITA
FROM country
ORDER BY 2 DESC
LIMIT 10;

/* 18. Show all country names that begin with letter 'Z'. */
SELECT name
FROM country
WHERE name LIKE 'Z%';

/* 19. Show all country names in which the third letter is 'h' */
SELECT name
FROM country
WHERE name LIKE '__h%';

/* 20. Show all country names in which the third letter is 'h' */
SELECT name
FROM country
WHERE name LIKE '__h%';

/* 21. Suppose a country would be classfied as 'developed' if its GNP 
per capita is higher than 0.01, and as 'developing' otherwise. Show 
the names and development classification of all countries in 
Southeast Asia. */
SELECT name, 
   IF(gnp / population > 0.01, 'developed', 'developing') AS classification
FROM country
WHERE region = 'Southeast Asia';

/* 22. Suppose a country would be classfied as 'Level 1', 'Level 2', 
or 'Level 3' if its population exceeds 1 billion, 100 million, 10 million, 
respectively. Other countries would be classfied as 'Level 4'.  
Show the names and population classification of all countries in 
Asia. */
SELECT name, population, 
       CASE FLOOR(LOG10(population))
       	WHEN 9 THEN 'Level 1'
       	WHEN 8 THEN 'Level 2'
       	WHEN 7 THEN 'Level 3'
       	ELSE 'Level 4'
       END
       AS classification
FROM country
WHERE continent = 'Asia';

/* 23. Show the names of all countries with a population smaller than 
1 million but higher than five hundred thousand. */
SELECT name, population
FROM country
WHERE population BETWEEN 5e5 AND 1e6;

/* 24. Show the names of all countries in Southern Africa and 
Eastern Africa. */
SELECT name, region
FROM country
WHERE region IN ('Southern Africa', 'Eastern Africa');

/* 25. Show the name and gnp of all countries with a gnp 
higher than 500,000. */
SELECT name, gnp
FROM country
WHERE gnp > 500000;

/* 26. Show the name of all countries where the field IndepYear 
is missing. */
SELECT name 
FROM country
WHERE IndepYear IS NULL;

/* 27. Show the country code and name of each country in Southeast
Asia. */
SELECT CONCAT(code, " : ", name) AS country
FROM country
WHERE region = 'Southeast Asia';

/* 28. Show the total GNP in Southeast Asia.*/
SELECT SUM(gnp) AS TotalGNP
FROM country
WHERE region = 'Southeast Asia';

/* 29. Show the name, population and surface area of the country with the highest 
gnp per capita. */
SELECT name, population, surfacearea
FROM country
ORDER BY gnp/population DESC
LIMIT 1;

/* 30. Sort the regions in descending order of total GNP. */
SELECT region, SUM(gnp) AS totalgnp 
FROM country
GROUP BY region
ORDER BY totalgnp DESC; 

/* 31. Show the regions with a total GNP higher of six hundered 
thousand or above. */
SELECT region, SUM(gnp) AS totalgnp 
FROM country
GROUP BY region
HAVING totalgnp > 6e5
ORDER BY totalgnp DESC; 

/* 32. Show the names of the countries with a GNP per capita 
at least five times as much as the world average. */
SELECT name, gnp/population as gnp_per_capita 
FROM country
WHERE gnp/population > 5 * (SELECT AVG(gnp/population) FROM country);

/* 33. Show the number of countries where English is an
official language. */
SELECT COUNT(code)
FROM country tbla, countrylanguage AS tblb
WHERE tbla.code = tblb.countrycode AND language = 'English' 
      AND isofficial = 'T';

/* 34. Show the number of countries where French is an
official language. */
SELECT COUNT(code)
FROM country tbla INNER JOIN countrylanguage AS tblb
ON tbla.code = tblb.countrycode 
WHERE language = 'French' AND isofficial = 'T';

/* 35. Show the number of official languages in all 
countries where French is an official language. */
SELECT name, COUNT(language) AS num_official
FROM country tbla INNER JOIN countrylanguage AS tblb
ON tbla.code = tblb.countrycode
WHERE countrycode IN
			(SELECT DISTINCT(countrycode)
     	 	 FROM countrylanguage
     	 	 WHERE isofficial = 'T' AND language = 'French'
     		 )
	  AND isofficial = 'T'
GROUP BY countrycode; 

/* 36.  Show the names of all countries where French 
is the only official language. */
SELECT name
FROM country tbla INNER JOIN countrylanguage AS tblb
ON tbla.code = tblb.countrycode
WHERE countrycode IN
			(SELECT DISTINCT(countrycode)
     	 	 FROM countrylanguage
     	 	 WHERE isofficial = 'T' AND language = 'French'
     		 )
	  AND isofficial = 'T'
GROUP BY countrycode
HAVING COUNT(language) = 1; 

/* 37. Show two largest cities in each country. */
SELECT code, country.name, city.name 
FROM country INNER JOIN city
ON code = countrycode
WHERE city.name IN 
   (SELECT * FROM
   		(SELECT name
   		FROM city 
   		WHERE countrycode = code
   		ORDER BY population DESC LIMIT 2
   		) AS sub
   	);
