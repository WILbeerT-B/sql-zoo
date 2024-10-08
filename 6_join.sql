/* JOIN and UEFA EURO 2012
This tutorial introduces JOIN which allows you to use data from two or more tables. 
The tables contain all matches and goals from UEFA EURO 2012 Football Championship in Poland and Ukraine.
The data is available (mysql format) at http://sqlzoo.net/euro2012.sql
*/


/* 1. Bender
The first example shows the goal scored by a player with the last name 'Bender'. 
The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime */
-- Modify it to show the matchid and player name for all goals scored by Germany. 
-- To identify German players, check for: teamid = 'GER'
SELECT matchid, player
  FROM goal
 WHERE teamid = 'GER'


/* 2. Game 1012
From the previous query you can see that Lars Bender's scored a goal in game 1012. 
Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. 
We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012 */
SELECT DISTINCT id, stadium, team1, team2
  FROM game
  INNER JOIN goal
    ON game.id = goal.matchid
  WHERE game.id = '1012'


/* 3. JOIN
You can combine the two steps into a single query with a JOIN.
SELECT *
  FROM game JOIN goal ON (id=matchid)
The FROM clause says to merge data from the goal table with that from the game table. 
The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. 
(If we wanted to be more clear/specific we could say ON (game.id=goal.matchid) */

-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
  FROM goal JOIN game ON (matchid=id)
 WHERE teamid = 'GER'


/* 4. Mario goals
Use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%' */
SELECT team1, team2, player
  FROM goal JOIN game ON (matchid=id)
 WHERE player LIKE 'Mario%'


/* 5. Ten minute goals
The table eteam gives details of every national team including the coach.
You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid=id
 WHERE gtime<=10


/* 6. Coach Fernando
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */
SELECT mdate, teamname
  FROM game JOIN eteam ON (team1=eteam.id)
 WHERE coach = 'Fernando Santos'


/* 7. Players at the National Stadium
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */
SELECT player
  FROM goal JOIN game ON (matchid=id)
 WHERE stadium = 'National Stadium, Warsaw'

-- More difficult questions

/* 8. */



/* 9. Goals by team
Show teamname and the total number of goals scored.
COUNT and GROUP BY */
SELECT teamname, COUNT(gtime)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname


/* 10. Goals by Stadium
Show the stadium and the number of goals scored in each stadium. */
SELECT stadium, COUNT(gtime)
  FROM game JOIN goal ON id=matchid
  GROUP BY stadium


/* 11. Matches for POL
For every match involving 'POL', show the matchid, date and the number of goals scored. */
SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
 GROUP BY matchid


/* 12. Goals for GER
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */
SELECT matchid, mdate, COUNT(teamid)
  FROM goal JOIN game ON matchid = id
 WHERE teamid = 'GER'
 GROUP BY matchid

/* will update in the future */
