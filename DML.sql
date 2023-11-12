/*

					SQL Project Name : Cricket Club Management System (CCMS)
							    Trainee Name : Ibrahim Sajib   
						    	  Trainee ID : 1278766       
							Batch ID : WADA/PNTL-A/56/01

 --------------------------------------------------------------------------------
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
			=> SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.1 : UPDATE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.2 : DELETE DATA THROUGH STORED PROCEDURE
			=> SECTION 04: INSERT UPDATE DELETE DATA THROUGH VIEW
				SUB SECTION => 4.1 : INSERT DATA through view
				SUB SECTION => 4.2 : UPDATE DATA through view
				SUB SECTION => 4.3 : DELETE DATA through view
			=> SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR, INLINE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			=> SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			=> SECTION 07: QUERY	

*/


/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/

USE CCMS
GO


INSERT INTO country VALUES
('India'),
('Bangladesh'),
('Afghanistan'),
('West Indies'),
('New Zealand'),
('England'),
('Australia'),
('Netherland'),
('Namibia')
GO
SELECT * FROM country
GO


INSERT INTO [role] VALUES
('Batter'),
('Bowler'),
('Wicket Keeper'),
('All Rounder')
GO
SELECT * FROM [role]
GO

INSERT INTO support_stuff VALUES
('Chandrakant Pandit','Head Coach',1),
('Abhishek Nayar','Assistant Coach',1),
('AR Srikkanth','Talent Scouting & Player Acquisitions',1),
('Bharat Arun','Bowling Coach',1),
('Chris Donaldson','Strength And Conditioning Coach',5),
('James Foster','Assistant Coach',6),
('Omkar Salvi','Assistant Bowling Coach',1),
('Ryan Ten Doeschate','Fielding Coach',8),
('Wayne Bentley','Team Manager',7),
('Abhishek Sawant','Assistant Physio',1),
('Dr. Srikant Narayanswamy','Team Doctor',1),
('Nathan Leamon','Team Analyst',6),
('Prasanth Panchada','Head Physiotherapist',1),
('Sagar V','Asst. Strength And Conditioning Coach',1)
GO

SELECT * FROM support_stuff
GO


INSERT INTO club_info VALUES
(1,'Kolkata Knight Riders','Indian Premier League','Kolkata, West Bengal, India','Shreyas Iyer','Chandrakant Pandit','Venky Mysore','Red Chillies Entertainment','Eden Gardens')
GO

SELECT * FROM club_info
GO

INSERT INTO stadium VALUES
(1,'Eden Gardens',68000)
GO

SELECT * FROM stadium
GO

/*
==============================  SECTION 02  ==============================
					INSERT DATA THROUGH STORED PROCEDURE
==========================================================================
*/

EXEC spInsertPlayers 'N Rana','1993-12-27',1,1
EXEC spInsertPlayers 'Rinku Singh','1997-10-12',1,1
EXEC spInsertPlayers 'Sakib Al Hasan','1987-03-24',4,2
EXEC spInsertPlayers 'Ankul Roy','1998-11-30',4,1
EXEC spInsertPlayers 'Aarya Desai','2003-04-03',1,1
EXEC spInsertPlayers 'Andre Russell','1988-04-29',4,4
EXEC spInsertPlayers 'David Wiese','1985-05-18',4,9
EXEC spInsertPlayers 'Harshit Rana','2001-12-22',2,1
EXEC spInsertPlayers 'Jason Roy','1990-07-21',1,6
EXEC spInsertPlayers 'Johnson Charles','1989-01-14',1,4
EXEC spInsertPlayers 'Kulwant Khejroliya','1992-03-13',2,1
EXEC spInsertPlayers 'Lockie Ferguson','1991-06-13',2,5
EXEC spInsertPlayers 'Mandeep Singh','1991-12-18',1,1
EXEC spInsertPlayers 'Litton Das','1994-10-13',3,2
EXEC spInsertPlayers 'Narayan Jagadeesan','1995-12-24',3,1
EXEC spInsertPlayers 'Rahmanullah Gurbaz','2001-11-28',3,3
EXEC spInsertPlayers 'Shardul Thakur','1991-10-16',2,1
EXEC spInsertPlayers 'Shreyas Iyer','1994-12-06',1,1
EXEC spInsertPlayers 'Sunil Narine','1988-05-26',4,4
EXEC spInsertPlayers 'Suyash Sharma','2003-05-15',2,1
EXEC spInsertPlayers 'Tim Southee','1988-12-11',2,5
EXEC spInsertPlayers 'Umesh Yadav','1987-10-25',2,1
EXEC spInsertPlayers 'Vaibhab Arora','1997-12-14',2,1
EXEC spInsertPlayers 'Varun Chakravarthy','1991-08-29',2,1
EXEC spInsertPlayers 'Venkatesh Iyer','1994-12-25',4,1
GO


SELECT * FROM players
GO

--============== INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER ============--


DECLARE @support_Stuff_Id INT
EXEC insert_support_stuff 'Sagar V','Asst. Strength And Conditioning Coach',1, @support_Stuff_Id OUTPUT
SELECT @support_Stuff_Id AS 'New Support Staff Id'
PRINT 'New Support Staff Id is : '+str(@support_Stuff_Id)
GO
/*
==============================  SECTION 03  ==============================
			UPDATE DELETE DATA THROUGH STORED PROCEDURE
==========================================================================
*/


--============== UPDATE DATA THROUGH STORED PROCEDURE ============--

EXEC spUpdatePlayers 'Nitish Rana','1993-12-27',1
GO

SELECT * FROM players
GO

--============== DELETE DATA THROUGH STORED PROCEDURE ============--
EXEC spDeleteplayers 'Rinku Singh'
GO

SELECT * FROM players
GO

--============== STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR ============--
EXEC delete_support_stuff 1
GO

/*
==============================  SECTION 04  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/

--============== INSERT DATA through view ============--
SELECT * FROM VW_playerinfo
GO

INSERT INTO VW_playerinfo(playerName,dob) VALUES ('Lorem Ipsum','1994-12-27')
GO

SELECT * FROM VW_playerinfo
GO



--============== UPDATE DATA through view ============--
UPDATE VW_playerinfo
SET dob = '1994-12-26'
WHERE  playerName = 'Lorem Ipsum'
GO
SELECT * FROM VW_playerinfo
GO

--============== DELETE DATA through view ============--
DELETE FROM VW_playerinfo
WHERE playerName = 'Lorem Ipsum'
GO

SELECT * FROM VW_playerinfo
GO

/*
==============================  SECTION 05  ==============================
						RETREIVE DATA USING FUNCTION
==========================================================================
*/

-- A Scalar Function to get age of players
SELECT playerId, playerName, dob, dbo.fnCalculateAge(dob) AS Age 
FROM players
GO

-- A Inline Table Valued Function to get players by roleId
SELECT * FROM fnGetPlayerByRoleId(2)
GO
-- A Multi Statement Table Valued Function to get monthly net sales using two parameter @year & @month

SELECT * FROM fnGetPlayerbyCountry('Bangladesh')
GO

/*
==============================  SECTION 06  ==============================
							   TEST TRIGGER
==========================================================================
*/
--============== FOR/AFTER TRIGGER ON TABLE ============--

-- EX - 01
-- INSERT DATA IN players TABLE and AUTOMATICALLY UPDATE data in PlayerAudit Table

SELECT * FROM players
SELECT * FROM PlayerAudit
GO

INSERT INTO players VALUES ('Amet','1994-09-09',4,1)
GO

SELECT * FROM players
SELECT * FROM PlayerAudit
GO

-- EX - 02
-- UPDATE DATA IN players TABLE and AUTOMATICALLY UPDATE data in PlayerAudit Table

SELECT * FROM players
SELECT * FROM PlayerAudit
GO

UPDATE players
	SET
	playerName = 'Amet B'
	WHERE dob = '1994-09-09'
	GO
SELECT * FROM players
SELECT * FROM PlayerAudit
GO

-- EX - 03
-- DELETE DATA IN players TABLE and AUTOMATICALLY UPDATE data in PlayerAudit Table

SELECT * FROM players
SELECT * FROM PlayerAudit
GO

DELETE FROM players
WHERE playerName = 'Amet B'
GO


SELECT * FROM PlayerAudit
GO



--============== INSTEAD OF TRIGGER ON TABLE ============--


--INSTEAD OF INSERT TRIGGER ON support_Stuff TO get countryId from support_Stuff table and manipulate data in current table

SELECT * FROM support_Stuff
SELECT * FROM country
GO
INSERT INTO support_Stuff(support_Stuff_Name, position,countryId) VALUES
('Sagar V2','Asst. Strength And Conditioning Coach',1)
GO
SELECT * FROM support_Stuff
GO


--============== AN INSTEAD OF TRIGGER ON VIEW ============--

SELECT * FROM VW_playerinfo

INSERT INTO VW_playerinfo(playerName, dob) VALUES('Dolor Ipsum', '1994-12-25')

SELECT * FROM VW_playerinfo
GO


/*
==============================  SECTION 07  ==============================
								  QUERY
==========================================================================
*/

--============== A SELECT STATEMENT TO GET ALL THE DATA FROM PLAYERS TABLE ============--

SELECT * FROM players
GO

--============== A SELECT STATEMENT TO GET 3 Column From players Table ============--

SELECT playerId,playerName,dob FROM players
GO


--==========A SELECT STATEMENT TO GET Data with dob older than 2000 From players Table ============--
SELECT * FROM players
WHERE dob<'2000-01-01'
GO

--USE OF DISTINCT KEYWORD:
SELECT DISTINCT countryId FROM players
GO

--USE of TOP Clause:
SELECT TOP 10 playerName FROM players
GO

--TOP Clause WITH PERCENT KEYWORD
SELECT TOP 50 PERCENT playerName FROM players
GO

--WITH TIES KEYWORD
SELECT TOP 15 WITH TIES countryId FROM players
ORDER BY countryId
GO

--==================WHERE CLAUSE:=======================
--AND OPERATOR

SELECT * FROM players
WHERE countryId=1 AND roleId=1
GO

--OR OPERATOR
SELECT * FROM players
WHERE countryId=1 OR roleId=1
GO

--NOT OPERATOR
SELECT * FROM players
WHERE NOT(countryId=1)
GO

--IN PHRASE

SELECT * FROM players
WHERE countryId IN(1,2,3)
GO

--BETWEEN PHRASE
SELECT * FROM players
WHERE dob BETWEEN '1995-01-01' AND '2000-01-01'
GO

--LIKE OPERATOR
SELECT * FROM players
WHERE playerName LIKE 'A%'
GO

SELECT * FROM players
WHERE playerName LIKE '[AJS]%'
GO

SELECT * FROM players
WHERE playerName LIKE '_[A-K]%'
GO

SELECT * FROM players
WHERE countryId LIKE '[1-4]%'
GO

SELECT * FROM players
WHERE countryId LIKE '[^1-4]%'
GO

--IS NULL CLAUSE
SELECT * FROM players
WHERE playerName IS NULL
GO
--IS NOT NULL CLAUSE
SELECT * FROM players
WHERE roleId IS NOT NULL
GO

--ORDER BY CLAUSE
SELECT * FROM players
ORDER BY playerName
GO

--ORDER BY DESC 
SELECT * FROM players
ORDER BY playerName DESC
GO


--ORDER BY 2 COLUMN
SELECT * FROM players
ORDER BY countryId,roleId
GO


--OFFSET & FETCH
SELECT * FROM players
ORDER BY playerId
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY
GO


--===========================JOIN============================

--INNER JOIN
SELECT playerName,roleName FROM players
INNER JOIN [role] ON players.roleId=[role].roleId
GO

--LEFT OUTER JOIN
SELECT playerName,roleName FROM players
LEFT JOIN [role] ON players.roleId=[role].roleId
GO

--RIGHT OUTER JOIN
SELECT playerName,roleName FROM players
LEFT JOIN [role] ON players.roleId=[role].roleId
GO

--FULL OUTER JOIN
SELECT playerName,roleName FROM players
FULL JOIN [role] ON players.roleId=[role].roleId
GO

--INNER JOIN THAT JOIN MORE THAN TWO TABLE
SELECT playerId,playerName,dob,roleName,countryName FROM players
JOIN role ON players.roleId=role.roleId
JOIN country ON players.countryId=country.countryId
GO

--INNER JOIN WITH IMPLICT SYNTEX
SELECT playerId,playerName,dob,roleName 
FROM players, role
WHERE players.roleId=role.roleId
GO


--==UNION OPERATION==
SELECT * FROM players
WHERE playerId <=10
UNION
SELECT * FROM players
WHERE playerId >10
GO

--==EXCEPT OPERATION==
SELECT * FROM players
EXCEPT
SELECT * FROM players
WHERE playerId < 10
GO

--==INTERSECT OPERATION==
SELECT * FROM players
WHERE playerId BETWEEN  2 AND 12
INTERSECT
SELECT * FROM players
WHERE playerId BETWEEN 7 AND 17
GO

--=============AGGREGATE FUNCTIONS===============

--COUNT
SELECT COUNT(playerId) AS TOTAL_PLAYER FROM players
GO

--MIN
SELECT MIN(dob) AS OLD_PLAYER_DOB FROM players
GO

--MAX
SELECT MIN(dob) AS YOUNG_PLAYER_DOB FROM players
GO

--SUM
SELECT SUM(playerId) AS SUM_fn FROM players
GO

--AVG
SELECT AVG(playerId) AS AVG_FN FROM players
GO

--====================SUMMARY QUERIES===================

--GROUP BY
SELECT countryId,COUNT(playerId) AS no_of_players FROM players
GROUP BY countryId
GO

--ROLLUP
SELECT countryId,COUNT(playerId) AS no_of_players FROM players
GROUP BY ROLLUP(countryId)
GO

--CUBE
SELECT countryId,COUNT(playerId) AS no_of_players FROM players
GROUP BY CUBE(countryId)
GO


--GROUPING SETS
SELECT countryId,COUNT(playerId) AS no_of_players FROM players
GROUP BY GROUPING SETS(countryId,())
GO

--HAVING CLAUSE
SELECT countryId,COUNT(playerId) AS no_of_players FROM players
GROUP BY countryId
HAVING countryId<5
GO

--OVER CLAUSE
SELECT playerName,dob,countryId,
COUNT(playerId) OVER (PARTITION BY countryId) AS player_count
 FROM players
GO

--=====SUB QUERIES=============

SELECT * FROM players
WHERE countryId IN(SELECT countryId FROM country)
GO

--ALL KEYWORD

SELECT * FROM players
WHERE countryId <= ALL
(SELECT countryId FROM country)

--ANY KEYWORD
SELECT * FROM players
WHERE countryId < ANY
(SELECT countryId FROM country)

--SOME KEYWORD
SELECT * FROM players
WHERE countryId < SOME
(SELECT countryId FROM country)

--CORRELATED SUBQUERIES
SELECT playerName,countryId FROM players
WHERE countryId=(
SELECT countryId FROM country
WHERE players.countryId=country.countryId
)
GO

--EXISTS OPERATOR
SELECT playerName,countryId FROM players
WHERE EXISTS (
SELECT * FROM country
WHERE players.countryId=country.countryId
)
GO


--CTE

WITH newcte (countryId,total_player) AS
(
	SELECT countryId,COUNT(playerId) AS total_player
	FROM players
	GROUP BY countryId
)

SELECT countryName,total_player FROM country
JOIN newcte ON country.countryId=newcte.countryId
ORDER BY total_player
GO

--============================== CONVERT DATA TYPES===========================

--CONVERT
SELECT playerId,playerName,CONVERT(VARCHAR(50),dob,101) AS DOB FROM players
GO

--CAST
SELECT playerId,playerName,CAST(dob AS VARCHAR(50)) AS DOB FROM players
GO

--TRY CONVERT
SELECT playerId,playerName,TRY_CONVERT(VARCHAR(50),dob,107) AS DOB FROM players
GO

--===============OTHER FUNCTION========================
--LTRIM
SELECT LTRIM('    HELLO SQL') AS 'LTRIM'
GO
--RTRIM
SELECT RTRIM('HELLO SQL    ') AS 'RTRIM'
GO
--LEFT
SELECT LEFT('HELLO SQL',4) AS 'LEFT'
GO
--RIGHT
SELECT RIGHT('HELLO SQL',2) AS 'RIGHT'
GO
--SUBSTRING
SELECT SUBSTRING('HELLO SQL',3,8) AS 'SUBSTRING'
GO
--LOWER
SELECT LOWER('Hello Sql') AS 'LOWER'
GO

--UPPER
SELECT UPPER('Hello Sql') AS 'UPPER'
GO

--LEN
SELECT LEN('SQL Server') AS 'LEN'
GO

--ROUND
SELECT ROUND(12.5,0) AS 'ROUND'
GO

--CEILING
SELECT CEILING(12.5) AS 'CEILING'
GO

--FLOOR
SELECT FLOOR(12.5) AS 'FLOOR'
GO

--SQUARE
SELECT SQUARE(12) AS 'SQUARE'
GO

--SQRT
SELECT SQRT(49) AS 'SQRT'
GO

--GETDATE()
SELECT GETDATE() AS 'CURRENT DATE'
GO

--DAY
SELECT DAY(GETDATE()) AS 'DAY'
GO

--MONTH
SELECT MONTH(GETDATE()) AS 'MONTH'
GO

--YEAR
SELECT YEAR(GETDATE()) AS 'YEAR'
GO

--===============DATENAME==================
SELECT DATENAME(DAY,GETDATE()) AS 'DAY'
GO

SELECT DATENAME(MONTH,GETDATE()) AS 'MONTH'
GO

SELECT DATENAME(YEAR,GETDATE()) AS 'YEAR'
GO

SELECT DATENAME(HOUR,GETDATE()) AS 'HOUR'
GO

SELECT DATENAME(MINUTE,GETDATE()) AS 'MINUTE'
GO

SELECT DATENAME(SECOND,GETDATE()) AS 'SECOND'
GO

SELECT DATENAME(WEEKDAY,GETDATE()) AS 'WEEKDAY'
GO

--=======================DATEADD===================
SELECT DATEADD(DAY,3,GETDATE())
GO

SELECT DATEADD(MONTH,2,GETDATE())
GO

SELECT DATEADD(YEAR,3,GETDATE())
GO

SELECT DATEADD(HOUR,10,GETDATE())
GO

SELECT DATEADD(MINUTE,16,GETDATE())
GO

--================DATEDIFF===================
SELECT DATEDIFF(DAY,'2001-01-01',GETDATE()) AS 'DAY'
GO

SELECT DATEDIFF(MONTH,'2001-01-01',GETDATE()) AS 'MONTH'
GO

SELECT DATEDIFF(YEAR,'2001-01-01',GETDATE()) AS 'YEAR'
GO

--CASE FUNCTION
SELECT 
playerName,roleId,
CASE roleID
WHEN 1 THEN 'BATTER'
WHEN 2 THEN 'BOWLER'
WHEN 3 THEN 'WICKET KEEPER'
WHEN 4 THEN 'ALL ROUNDER'
END AS 'Role'
FROM players
GO

--CHOOSE FUNCTION
SELECT playerName, roleId,
CHOOSE(roleId, 'BATTER', 'BOWLER', 'WICKET KEEPER', 'ALL ROUNDER') AS 'Role'
FROM players
GO

--IFF FUNCTION
SELECT 
playerId,playerName,countryId,
IIF(countryId=1,'Local','Foreign') AS 'Quota'
FROM players
GO
