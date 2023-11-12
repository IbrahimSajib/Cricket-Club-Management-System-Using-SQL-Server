
/*
					SQL Project Name : Cricket Club Management System (CCMS)
							    Trainee Name : Ibrahim Sajib   
						    	  Trainee ID : 1278766       
							Batch ID : WADA/PNTL-A/56/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database [CCMS]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)

*/


/*
==============================  SECTION 01  ==============================
	   CHECK DATABASE EXISTANCE & CREATE DATABASE WITH ATTRIBUTES
==========================================================================
*/
USE master
GO

DROP DATABASE IF EXISTS CCMS
GO

CREATE DATABASE CCMS
ON
(
	name = 'ccm_data',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ccm_data.mdf',
	size = 5MB,
	maxsize = 50MB,
	filegrowth = 5%
)
LOG ON
(
	name = 'ccm_log',
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ccm_log.ldf',
	size = 8MB,
	maxsize = 40MB,
	filegrowth = 5MB
)
GO

USE CCMS
GO

/*
==============================  SECTION 02  ==============================
		          CREATE TABLES WITH COLUMN DEFINITION 
==========================================================================
*/

--============== Table with IDENTITY, PRIMARY KEY & NULL Ability CONSTRAINT... ============--

CREATE TABLE country
(
	countryId INT IDENTITY PRIMARY KEY,
	countryName CHAR(30) NOT NULL
)
GO

CREATE TABLE [role]
(
	roleId INT IDENTITY PRIMARY KEY,
	roleName CHAR(30) NOT NULL
)
GO

--============== Table with PRIMARY KEY & FOREIGN KEY CONSTRAINT... ============--
CREATE TABLE players
(
	playerId INT IDENTITY PRIMARY KEY,
	playerName VARCHAR(50) NOT NULL,
	dob DATE NOT NULL,
	roleId INT REFERENCES [role](roleId),
	countryId INT REFERENCES country(countryId),
)
GO

CREATE TABLE support_stuff
(
	support_Stuff_Id INT IDENTITY PRIMARY KEY,
	support_Stuff_Name VARCHAR(50) NOT NULL,
	position VARCHAR(50) NOT NULL,
	countryId INT REFERENCES country(countryId),
)
GO

--============== Table with composite PRIMARY KEY ============--

CREATE TABLE club_info
(
Id INT,
club_Name VARCHAR(50) NOT NULL,
league VARCHAR(50) NOT NULL,
[location] VARCHAR(50) NOT NULL,
captain VARCHAR(50),
coach VARCHAR(50) ,
ceo VARCHAR(50) ,
[owner] VARCHAR(50),
home_ground VARCHAR(50) ,
PRIMARY KEY(Id,club_Name)
)
GO

--========Sample table===========
CREATE TABLE stadium
(
Id INT,
[name] varchar(30),
capacity int
)
GO

--============== CREATE A SCHEMA ============--

CREATE SCHEMA ccm
GO
--============== USE SCHEMA IN A TABLE ============--

CREATE TABLE ccm.faninfo
(
	fanId INT,
	fan_comment NVARCHAR(100) NULL,
	
)
GO

/*
==============================  SECTION 03  ==============================
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
==========================================================================
*/


--============== ALTER TABLE SCHEMA AND TRANSFER TO [DBO] ============--

ALTER SCHEMA dbo TRANSFER ccm.faninfo
GO

--============== Update column definition ============--

ALTER TABLE faninfo
ALTER COLUMN fan_comment VARCHAR(80)
GO

--============== ADD column with DEFAULT CONSTRAINT ============--

ALTER TABLE faninfo
ADD Fan_Age INT DEFAULT 20
GO


--============== DROP COLUMN ============--

ALTER TABLE faninfo
DROP COLUMN fan_comment
GO

--============== DROP TABLE ============--

IF OBJECT_ID('faninfo') IS NOT NULL
DROP TABLE faninfo
GO

--============== DROP SCHEMA ============--

DROP SCHEMA ccm
GO



/*
==============================  SECTION 04  ==============================
		          CREATE CLUSTERED AND NONCLUSTERED INDEX
==========================================================================
*/

-- Clustered Index
CREATE CLUSTERED INDEX IX_stadium_Id
ON stadium
(
	Id
)
GO

-- Nonclustered Index
CREATE UNIQUE NONCLUSTERED INDEX IX_stadium_name
ON stadium
(
	[name]
)
GO

/*
==============================  SECTION 05  ==============================
							 CREATE SEQUENCE
==========================================================================
*/

CREATE SEQUENCE seqNum
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 200
	CYCLE
	CACHE 10
GO

--============== ALTER SEQUENCE ============--

ALTER SEQUENCE seqNum
	MAXVALUE 200
	CYCLE
	CACHE 9
GO


/*
==============================  SECTION 06  ==============================
							  CREATE A VIEW
==========================================================================
*/

CREATE VIEW VW_playerinfo
AS
SELECT playerId,playerName FROM players
GO

-- VIEW WITH ENCRYPTION


CREATE VIEW VW_Stuffinfo
WITH ENCRYPTION
AS
SELECT support_Stuff_Id,support_Stuff_Name FROM support_stuff
GO



--============== ALTER VIEW ============--

ALTER VIEW VW_playerinfo
AS
SELECT playerId,playerName,dob FROM players
GO

/*
==============================  SECTION 07  ==============================
							 STORED PROCEDURE
==========================================================================
*/

--============== STORED PROCEDURE for insert data using parameter ============--
CREATE PROCEDURE spInsertPlayers	@playerName VARCHAR(50),
									@dob DATE,
									@roleId INT,
									@countryId INT
							
						
AS
BEGIN
	INSERT INTO players (playerName, dob, roleId, countryId) 
	VALUES(@playerName,@dob,@roleId,@countryId)
END
GO


--============== STORED PROCEDURE for insert data with OUTPUT parameter ============--

CREATE PROCEDURE insert_support_stuff
    @support_Stuff_Name VARCHAR(50),
    @position VARCHAR(50),
    @countryId INT,
    @support_Stuff_Id INT OUTPUT
AS
BEGIN
    INSERT INTO support_stuff (support_Stuff_Name, position, countryId)
    VALUES (@support_Stuff_Name, @position, @countryId)

    SET @support_Stuff_Id = IDENT_CURRENT('support_stuff')
END
GO

--============== STORED PROCEDURE for UPDATE data ============--
CREATE PROCEDURE spUpdatePlayers	@playerName VARCHAR(50),
									@dob DATE
AS
BEGIN
	UPDATE players
	SET
	playerName = @playerName
	WHERE dob = @dob
END
GO

--============== STORED PROCEDURE for DELETE Table data ============--

CREATE PROCEDURE spDeleteplayers	@playerName VARCHAR(50)
AS
BEGIN
	DELETE FROM players
	WHERE playerName = @playerName
END
GO
--============== TRY CATCH IN A STORED PROCEDURE & RAISERROR WITH ERROR NUMBER AND ERROR MESSAGE ============--

CREATE PROCEDURE delete_support_stuff
    @support_Stuff_Id INT
AS
BEGIN TRY
    DELETE FROM support_stuff WHERE support_Stuff_Id = @support_Stuff_Id
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO

--============== ALTER STORED PROCEDURE ============--

ALTER PROCEDURE spUpdateplayers	@playerName VARCHAR(50),
								@dob DATE,
								@countryId INT
AS
BEGIN
	UPDATE players
	SET
	playerName = @playerName,
	dob = @dob
	WHERE countryId = @countryId
END
GO


/*
==============================  SECTION 08  ==============================
								 FUNCTION
==========================================================================
*/

--============== A SCALAR FUNCTION ============--
CREATE FUNCTION fnCalculateAge
(
  @DOB DATE
)
RETURNS INT
AS
BEGIN
  DECLARE @AGE INT
  SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())-
  CASE
    WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
       (MONTH(@DOB) = MONTH(GETDATE()) AND
        DAY(@DOB) > DAY(GETDATE()))
    THEN 1
    ELSE 0
  END
  RETURN @AGE
END
GO

--============== A INLINE TABLE VALUED FUNCTION ============--

CREATE FUNCTION fnGetPlayerByRoleId
(
  @roleId INT
)
RETURNS TABLE
AS
RETURN (SELECT * FROM players WHERE roleId = @roleId)
GO
--============== A MULTISTATEMENT TABLE VALUED FUNCTION ============--

CREATE FUNCTION fnGetPlayerbyCountry(@country varchar(30))
RETURNS @Table Table (PlayerName varchar(50),CountryName varchar(30))
AS
BEGIN
  INSERT INTO @Table
    SELECT players.playerName,country.countryName FROM players
	INNER JOIN country on players.countryId=country.countryId
	WHERE country.countryName=@country
  Return
End
GO
--============== ALTER FUNCTION ============--
AlTER FUNCTION fnGetPlayerByRoleId
(
  @roleId INT
)
RETURNS TABLE
AS
RETURN (SELECT playerName,roleId FROM players WHERE roleId = @roleId)
GO

/*
==============================  SECTION 09  ==============================
							FOR/AFTER TRIGGER
==========================================================================
*/
--Create playerAudit table for capture info:
CREATE TABLE PlayerAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)
GO

--Example for AFTER TRIGGER for INSERT event on players table:
CREATE TRIGGER tr_players_ForInsert
ON players
FOR INSERT
AS
BEGIN
 Declare @Id int
 Select @Id = playerId from inserted
 
 insert into PlayerAudit 
 values('New Player with Id  = ' + Cast(@Id as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END
GO

--Example for AFTER TRIGGER for DELETE event on players table:
CREATE TRIGGER tr_players_ForDelete
ON players
FOR DELETE
AS
BEGIN
 Declare @Id int
 Select @Id = playerId from deleted
 
 insert into PlayerAudit 
 values('An existing player with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + Cast(Getdate() as nvarchar(20)))
END
GO

--Create AFTER UPDATE trigger for UPDATE event on players table:
CREATE TRIGGER tr_player_ForUpdate
on players
for Update
as
Begin
 Declare @Id int
 Select @Id = playerId from inserted
 
 insert into PlayerAudit 
 values('An existing player with Id  = ' + Cast(@Id as nvarchar(5)) + ' is updated at ' + Cast(Getdate() as nvarchar(20)))
End
GO

select * from PlayerAudit
go


/*
==============================  SECTION 10  ==============================
							INSTEAD OF TRIGGER
==========================================================================
*/

-- Trigger For get CountryId from another table and manipulate data in current table

CREATE TRIGGER trSupportStuffCountry
ON support_Stuff
INSTEAD OF INSERT
AS
BEGIN
	IF ((SELECT COUNT(*) FROM inserted) > 0)
		BEGIN
			INSERT INTO support_Stuff(support_Stuff_Name, position,countryId)
			SELECT
			i.support_Stuff_Name,
			i.position,
			country.countryId
			from inserted i
			INNER JOIN country ON country.countryId = i.countryId
		END
	ELSE
	BEGIN
		PRINT 'Error Occured for Inserting Data Into support_Stuff Table !'
	END
END
GO

--============== AN INSTEAD OF TRIGGER ON VIEW ============--


CREATE TRIGGER trViewInsteadInsert
ON VW_playerinfo
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO players(playerName)
	SELECT  i.playerName FROM inserted i
END
GO

--============== ALTER TRIGGER ============--

ALTER TRIGGER trViewInsteadInsert
ON VW_playerinfo
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO players( playerName,dob)
	SELECT  i.playerName,i.dob FROM inserted i
END
GO

