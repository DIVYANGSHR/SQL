--CREATING table
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix (

	show_id	 VARCHAR(5),
	type     VARCHAR(10),
	title    VARCHAR(250),
	director VARCHAR(550),
	casts    VARCHAR(1050),
	country	 VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	 VARCHAR(15),
	duration VARCHAR(15),
	listed_in   VARCHAR(250),
	description VARCHAR(550)
);

--import dataset

SELECT * FROM netflix;

SELECT COUNT(*)as Total_content
FROM netflix;

--Business Problems
--Q1. Count the number of Movies vs TV Shows
SELECT type ,COUNT(*) AS total_content
FROM netflix
GROUP BY type;

--Q2. Find the most common rating for movies and TV shows
SELECT type,
       rating,
	   COUNT(*) AS no_of_times,
	   RANK ()OVER (PARTITION BY type ORDER BY COUNT(*) DESC)AS ranking
FROM netflix
GROUP BY type,rating
-- Creating sub-queries of it
SELECT 
       type,
       rating
FROM 
(
SELECT type,
       rating,
	   COUNT(*) AS no_of_times,
	   RANK ()OVER (PARTITION BY type ORDER BY COUNT(*) DESC)AS ranking
FROM netflix
GROUP BY type,rating

)AS t1
WHERE  ranking=1

--3. List all movies released in a specific year (e.g., 2020)
SELECT * FROM netflix
WHERE type ='Movie' AND
release_year =2020

--4. Find the top 5 countries with the most content on Netflix
SELECT 
       country,
       COUNT(*)AS total_content
FROM netflix
GROUP BY country
ORDER BY total_content DESC
	LIMIT 5 ;  

--separate each country name from counrty column	
SELECT 
      UNNEST( string_to_array (country,',')) AS new_country_list
	   FROM netflix;



SELECT 
       UNNEST( string_to_array (country,',')) AS new_country_list,
       COUNT(*)AS total_content
FROM netflix
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

--Q5. Identify the longest movie
select * from netflix
WHERE type='Movie'
      AND
	  duration = (SELECT MAX(duration) FROM netflix);

--Q6. Find content added in the last 5 years
SELECT * FROM netflix
where TO_DATE (date_added, 'Month-DD-YYYY')>= CURRENT_DATE - INTERVAL '5 years'


--Q7. Find all the movies/TV shows by director 'Rajiv Chilaka'!	 
SELECT * FROM netflix
WHERE director='Rajiv Chilaka';
 
 SELECT * FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';      --use LIKE func bcoz some colunmn 2-3 directors together given

--OTHER METHOD
SELECT *
FROM
(

SELECT 
	*,
	UNNEST(STRING_TO_ARRAY(director, ',')) as director_name
FROM 
netflix
)
WHERE 
	director_name = 'Rajiv Chilaka'

-- Q8. List all TV shows with more than 5 seasons	
SELECT * FROM netflix
WHERE 
     type='TV Show' 
	 AND 
	 SPLIT_PART(duration,' ',1)::INT>5
      
-- Q9. Count the number of content items in each genre
SELECT 
     UNNEST(string_to_array(listed_in,','))AS genre,
	 COUNT(*)AS Number_of_contents
	 FROM netflix
	GROUP BY genre
	 
	 
-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !
SELECT 
      EXTRACT (year FROM TO_DATE(date_added,'month,dd,yyyy')) AS year,
	  count(*)as yearly_content,
	  CAST
	  ( COUNT(*)::numeric /(SELECT COUNT(*)FROM netflix WHERE country='India')::numeric * 100 as DECIMAL(10,2)) as Avg_content_for_year
FROM netflix                -- total content each year eg;2018 333/972
WHERE country='India'
GROUP BY year
LIMIT 5;


-- Q11. List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries%';

--or use ILIKE so that spelling doesnt matter
SELECT * FROM netflix
WHERE listed_in ILIKE '%documentaries%'

-- Q12. Find all content without a director
SELECT * FROM netflix
WHERE director is null


-- Q13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT * FROM netflix
WHERE casts ILIKE '%salman khan%'
        AND release_year> EXTRACT(YEAR FROM CURRENT_DATE)- 10


-- Q14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
      UNNEST(STRING_TO_ARRAY(casts,',')) AS actors,
      COUNT(*)AS NO_of_movies_filmed  
FROM netflix
WHERE country ILIKE '%India%'	
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/
WITH new_label
AS
(
SELECT *, 
        CASE
		    WHEN description ILIKE '%kill%' OR description ILIKE 'violence%' THEN 'Bad_Content'
			ELSE 'Good_Content'
		END as Category	
FROM netflix
)

SELECT category,
       COUNT(*)AS Total_Content
from new_label
GROUP BY category;







