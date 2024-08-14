/* More JOIN operations
This tutorial introduces the notion of a join. The database consists of 
three tables movie , actor and casting . */


/* 1. 1962 movies
List the films where the yr is 1962 [Show id, title] */
SELECT id, title
  FROM movie
 WHERE yr=1962


/* 2. When was Citizen Kane released?
Give year of 'Citizen Kane'. */
SELECT yr
  FROM movie
 WHERE title='Citizen Kane'


/* 3. Star Trek movies
List all of the Star Trek movies, include the id, title and yr (all of these movies 
include the  words Star Trek in the title). Order results by year. */
SELECT id, title, yr
  FROM movie
 WHERE title LIKE 'Star Trek%'
  ORDER BY yr


/* 4. id for actor Glenn Close
What id number does the actor 'Glenn Close' have? */
SELECT id FROM actor
 WHERE name='Glenn Close'


/* 5. id for Casablanca
What is the id of the film 'Casablanca' */
SELECT id FROM movie
 WHERE title='Casablanca'


/* 6. Cast list for Casablanca
Obtain the cast list for 'Casablanca'.
what is a cast list?
The cast list is the names of the actors who were in the movie.
Use movieid=11768, (or whatever value you got from the previous question) */
SELECT name 
  FROM actor JOIN casting
    ON id=actorid
  WHERE movieid=11768


/* 7. Alien cast list
Obtain the cast list for the film 'Alien' */
SELECT name 
  FROM actor JOIN casting
    ON id=actorid
  WHERE movieid=10522


/* 8. Harrison Ford movies
List the films in which 'Harrison Ford' has appeared */
SELECT title
  FROM movie JOIN casting
    ON movie.id=casting.movieid
  JOIN actor 
    ON casting.actorid=actor.id
  WHERE name='Harrison Ford'


/* 9. Harrison Ford as a supporting actor
List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role] */
SELECT title
  FROM movie JOIN casting
    ON movie.id=casting.movieid
  JOIN actor 
    ON casting.actorid=actor.id
  WHERE name='Harrison Ford' AND ord!=1


/* 10. Lead actors in 1962 movies
List the films together with the leading star for all 1962 films. */
SELECT title, name
  FROM movie JOIN casting
    ON movie.id=casting.movieid
  JOIN actor 
    ON casting.actorid=actor.id
  WHERE yr=1962 AND ord=1


/* 11. Busy years for Rock Hudson
Which were the busiest years for 'Rock Hudson', show the year and the number of movies 
he made each year for any year in which he made more than 2 movies. */
SELECT yr,COUNT(title) 
  FROM movie JOIN casting 
    ON movie.id=movieid
  JOIN actor 
    ON actorid=actor.id
 WHERE name='Rock Hudson'
 GROUP BY yr
 HAVING COUNT(title) > 2

 /* will update in the future */



