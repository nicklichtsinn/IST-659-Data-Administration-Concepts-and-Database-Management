
--Dropping my tables
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CharacterAbilities')
BEGIN
	DROP TABLE CharacterAbilities
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Characters')
BEGIN
	DROP TABLE Characters
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Abilities')
BEGIN
	DROP TABLE Abilities
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Affiliation')
BEGIN
	DROP TABLE Affiliation
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PowerLevel')
BEGIN
	DROP TABLE PowerLevel
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Species')
BEGIN
	DROP TABLE Species
END
GO

--Creating my tables

--Creating Species table
CREATE TABLE Species (
	-- Columns for the Species Table
	SpeciesID int identity,
	Classification varchar(20) not null,
	ClassificationDescription varchar(750) not null
	-- Constraints
	CONSTRAINT PK_Species PRIMARY KEY (SpeciesID),
	CONSTRAINT U1_Species UNIQUE (Classification)
)
--Creating PowerLevel table
CREATE TABLE PowerLevel (
	-- Columns for the PowerLevel Table
	PowerLevelID int identity,
	Class varchar(20) not null,
	ClassDescription VARCHAR(1000) not null,
	-- Constraints
	CONSTRAINT PK_PowerLevel PRIMARY KEY (PowerLevelID),
	CONSTRAINT U1_PowerLevel UNIQUE (Class)
)
	-- adding INSERT statements that show how to insert when a column value is not provided anne server is responsible for setting a column to a default.
	ALTER TABLE PowerLevel ADD CONSTRAINT DF_PowerLevel DEFAULT 'N/A' FOR ClassDescription -- setting default for class description to 'N/A'

-- Creating Affiliation table
CREATE TABLE Affiliation (
	-- Columns for the Affiliation Table
	AffiliationID int identity,
	TeamName varchar(50) not null,
	TeamStatus varchar(30) not null,
	MemberNumber int not null
	-- Constraints
	CONSTRAINT PK_Affiliation PRIMARY KEY (AffiliationID),
	CONSTRAINT U1_Affiliation UNIQUE (TeamName)
)
-- Creating Abilities table
CREATE TABLE Abilities (
	-- Columns for the Abilities Table
	AbilityID int identity,
	AbilityName varchar(50) not null,
	AbilityDescription varchar(1000) not null
	-- Constraints
	CONSTRAINT PK_Abilites PRIMARY KEY (AbilityID),
	CONSTRAINT U1_Abilities UNIQUE (AbilityName)
)

-- Creating the Characters Table
CREATE TABLE Characters (
	-- Columns for the Characters Table
	CharacterID int identity,
	FullName varchar(50) not null,
	SpeciesID int not null,
	PowerLevelID int not null,
	AffiliationID int not null,
	-- Constraints on the Characters Table
	CONSTRAINT PK_Characters PRIMARY KEY (CharacterID),
	CONSTRAINT FK1_Characters FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
	CONSTRAINT FK2_Characters FOREIGN KEY (PowerLevelID) REFERENCES PowerLevel(PowerLevelID),
	CONSTRAINT FK3_Characters FOREIGN KEY (AffiliationID) REFERENCES Affiliation(AffiliationID),
	CONSTRAINT U1_Characters UNIQUE (FullName)
)
-- Creating the CharacterAbilities table
CREATE TABLE CharacterAbilities (
	-- Columns for the CharacterAbilities Table
	CharAbilityID int identity,
	CharacterID int not null,
	AbilityID int not null
	-- Constraints
	CONSTRAINT PK_CharacterAbilities PRIMARY KEY (CharAbilityID),
	CONSTRAINT FK1_CharacterAbilities FOREIGN KEY (CharacterID) REFERENCES Characters(CharacterID),
	CONSTRAINT FK2_CharacterAbilities FOREIGN KEY (AbilityID) REFERENCES Abilities(AbilityID)
)

-- inserting values into Species table with comma delimiter
INSERT INTO Species(Classification, ClassificationDescription)	VALUES ('Human','The term psychic is used to define a human who possesses supernatural powers and has the ability to use Spirit Energy (or Demon Energy in some cases) as well as heightened spiritual awareness to see ghosts and demons, telepathy, shaping energy, and manipulating objects and/or matter. The known psychics in the English anime were either fighters like Genkai, who gained such abilities through severe martial arts training, people born with unnaturally high spiritual awareness like the Kuwabara siblings, or people who gained their powers as a result of the Sensui Seven''s Gatekeeper opening the Makai Barrier.')
, ('Demon', 'While the demons of Yu Yu Hakusho are not necessarily "demonic" one way or another, they amusingly all hail from Makai (Demon World) and eventually are ruled by a Mao (Demon King). There are several species of spirits/demons that inhabit the planes or worlds of Yu Yu Hakusho. Many of them appear very similar to humans and most have a humanoid features.')
, ('Example', 'Example for delete statement')

SELECT * FROM Species

-- iserting values into Power Level table with individual lines
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('S', 'This class is remarkably harder to reach than other classes, however, though the powers of A class were already so high, they are nothing compared to this rank. S class warriors are viewed as deities of destruction, and A classes are fodder to S classes. S classes are incredibly more intelligent than A classes, barring a few exceptions, and are viewed as the nearly omniscient. Because of this, the strongest characters in the YuYu Hakusho franchise are put in this class')
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('A', 'The only humans who have reached this class went through an overwhelming trauma, and leveled into this class to deal with it. They were unaware of this jump in class. Demons with this power do not reside in the Human or Spirit World. They are only of Demon World, and are either born with this power, or have acquired it through immense training. The abilities are even more astounding than what can be displayed at B class power, however, this is the second smallest class, as just a few more months of intense training is what is necessary to reach the last class. Demons with this rank are typically far more intelligent than average humans. They are considered to be country level threats by Spirit World.')
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('B', 'Other than Genkai and Toguro, each human that has reached this class underwent a spiritual metamorphosis, profound emotional turbulence, or had powers of this level from the start. This class is presumably the second largest class, when demons and humans enter it, an extremely overwhelming situation is required to push them further. Abilities truly begin to become impressive and exhilarating in this class, while demons carrying this letter are typically more intelligent than average humans.')
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('C', 'Other than extremely rare cases, the only humans that can reach this class endure rigorous training along with their spiritual awareness. Demons with this class are as intelligent as humans, however, due to the difficulty of breaking out of this class and reaching the B class, they may have much more wisdom, and thus intellect.')
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('D', 'Only spiritually aware humans, and weak demons possess this class. The strongest psychics without training are this class, under most circumstances, and the intelligence of demons with this class are still typically lower than E class humans'' intelligence.')
INSERT INTO PowerLevel(Class, ClassDescription) VALUES ('E', 'A class that normal humans, spiritually aware humans, abnormally potent humans, and the weakest of demons have. Lower E classes represent humans, while mid to upper E classes are the rest of the prior listed. Usually less intelligent than humans.')
INSERT INTO PowerLevel(Class) VALUES ('Unknown')

SELECT * FROM PowerLevel

-- inserting values into Affiliation table
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Dr. Ichigaki Team', 'Disbanded', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Meikai Gods', 'Active', 4)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Raizen''s Friends', 'Active', 9)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Spirit Warriors', 'Deceased', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Gokai Six', 'Disbanded', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Gorenja', 'Deceased', 5)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Mashotsukai', 'Deceased', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Rokuyukai', 'Disbanded', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Toguro', 'Disbanded', 5)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Urameshi', 'Active', 6)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Team Uraotogi', 'Deceased', 5)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('The Saint Beasts', 'Deceased', 4)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('The Three Kings', 'Disbanded', 3)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('The Triad', 'Deceased', 3)
INSERT INTO Affiliation(TeamName, TeamStatus, MemberNumber) VALUES ('Sensui Seven', 'Deceased', 7)

SELECT * FROM Affiliation	

-- inserting values into Abilities table
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Demon-Gun', 'Yusuke concentrates his Demon-Energy at the tip of the index finger, until it becomes unstable, then focuses on core energy and expands it and releases a mental trigger.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Dimension Sword', 'Kuwabara channels all of his energy in the palm of the hand, and then increases the load so that a small peak of yellow/green energy starts to glow until it illuminates his entire hand. He manifests the energy into a sword, albeit different from his normal Spirit Sword.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Double Spirit Sword', 'In essence, the technique is only one standard Spirit Sword, and as such form also manifest. Kuwabara focuses its energy on both hands to create peaks of light, and then shapes the energy so that they take the form of swords.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Dragon of the Darkness Flame', 'A powerful technique that summons black flames from the depths of Spirit World and shaping it in the form of a dragon capable of instantly incinerating nearly anything in its path.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Earth Manipulation', 'A kind of elemental manipulation, based on using energy user, to connect and manipulate the earth and its properties.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Fire Manipulation', 'A kind of elemental manipulation, which is based on central, energy use, to connect the properties of fire, and handles it well.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Ice Manipulation', 'A kind of elemental manipulation based on energy use, to connect to the ice, and handles it.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Jagan Eye', 'An additional eye that can be implanted that allows its user to amass various capabilities. It was used only by Hiei who received it through surgery by Shigure.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Lightning Manipulation', 'An elemental manipulation, which is based on using energy to connect with electricity and manipulates it. The user can change the properties of your energy, to create an electro magnetic field of attraction, and so summon lightning in its pure form, both redirects them to a target, but also manipulate the energy of the lightning itself.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Mafuuken', 'The most powerful defensive spell in all creation, and Spirit Realm''s last, best line of defense.  It is a swell of pure Spirit energy, often focused in a relic.  It also has other uses, including the ability to restore life to the deceased. In the case of the example seen in the storyline, it is contained in Koenma''s pacifier, and had been storing his energy for centuries.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Ogre Killer', 'After drinking the beverage Ogre Killer, Chu positions both hands, one above the other, in front of his adomem then focuses his Demon Energy between them, he goes on to shape the energy in a circular format and expands constantly, when the ball reaches a size of a ball of Baseball, Chu stabilizes, making him extremely maneuverable. So Chu, pierces the ground with force, using his leg, and throws the ball at high speed,to launching a bid as fast a game of Baseball.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Gun', 'The signature technique of Yusuke Urameshi. It concentrates spirit energy into the user''s hand, releasing it through one''s finger tips in the form of a blast.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Kick', 'This move utilizes sprite energy to surround the foot to increase the power of the kicks.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Punch', 'The user must first concentrate your energy on a hand or both hands, and then stabilize the energy, then attack with punches.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Shotgun', 'The User closes their hand and positioned backwards, so they focuses their spiritual energy in the palm compressing it, then throws a punch towards the target, releasing energy in the form of various energy projectiles.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Sword', 'The signature technique of Kuwabara. Its typical form is that of a sword comprised of fire energy, and the technique''s cutting power is based on the amount of energy put into it by its user.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Wave', 'The user focuses all of their Spirit Energy, thus releasing a powerful flow of energy through the body. During this flow of energy, this flow is directed to a focal point to from which the user''s spirit energy will be released. When the user has selected a target, they release a wave of energy.') 
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Spirit Gun Mega', 'Spirit Mega-Gun is the most powerful version of Spirit-Gun common, being more powerful, and with a destructive capacity incalculable.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Sword of the Darkness Flame', 'Hiei channels the power of the Dragon of the Darkness Flame into his sword, coating it with deadly green and black flames that increase the sword''s cutting power.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Water Manipulation', 'A kind of elemental manipulation based on energy use, to connect the properties of water and manipulate it.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Wind Manipulation', 'A kind of elemental manipulation, based on energy use to connect to the wind and their properties, and handles it well.')
INSERT INTO Abilities(AbilityName, AbilityDescription) VALUES ('Rose Whip', 'Kurama''s signature technique, where he uses his demon energy to grow a rose from its seed state to its flowering state and then into a long thorny whip that''s capable of cutting even through steel. With this he is able to conceal seeds of different plants with such stealth that the opponent doesn''t realize it until it has already happened.')

SELECT * FROM Abilities

-- inserting values into Characters tables
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Yusuke Urameshi', 1, 1, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kazuma Kuwabara', 1, 1, 10)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kurama', 2, 1, 10)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Hiei', 2, 1, 10)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Genkai', 1, 3, 10)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Suzaku', 2, 4, 12)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Seiryu', 2, 4, 12)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Byakko', 2, 4, 12)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Genbu', 2, 4, 12)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Rinku', 2, 1, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Roto', 2, 5, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Zeru', 2, 4, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Chu', 2, 1, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Gaou', 2, 5, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Imajin', 2, 5, 8)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Rugby', 2, 4, 4)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Topaz', 2, 4, 4)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Dr. Ichigaki', 2, 6, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('En (M1)', 1, 4, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kai (M2)', 1, 4, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Ryo (M3)', 1, 4, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('M4', 2, 5, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('M5', 2, 5, 1)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Risho', 2, 4, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Bakken', 2, 5, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Touya', 2, 1, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Gama', 2, 4, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Jin', 2, 1, 7)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Makintaro', 2, 4, 11)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Ura Urashima', 2, 4, 11)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Shishiwakamaru', 2, 1, 11)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Suzuki', 2, 1, 11)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kuro Momotaro', 2, 4, 11)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Akarenjya', 2, 4, 6)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Aorenjya', 2, 4, 6)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Momorenjya', 2, 4, 6)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kirenjya', 2, 4, 6)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Midorenjya', 2, 4, 6)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Bui', 2, 3, 9)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Karasu', 2, 3, 9)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Elder Toguro', 2, 3, 9)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Younger Toguro', 2, 2, 9)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Sakyo', 1, 7, 9)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Shinobu Sensui', 1, 1, 15) 
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Itsuki', 2, 2, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kaname Hagiri', 1, 4, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Minoru Kamiya', 1, 5, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kiyoshi Mitarai', 1, 5, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Tsukihito Amanuma', 1, 5, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Sadao Makihara', 1, 3, 15)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Raizen', 2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Hokushin', 2, 1, 3)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Touou', 2, 2, 3)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Seitei', 2, 2, 3)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Raizen''s Lover', 1, 7, 3)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Mukuro', 2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Kirin', 2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Shigure',2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Yomi', 2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Shura', 2, 1, 13)
INSERT INTO Characters(FullName, SpeciesID, PowerLevelID, AffiliationID) VALUES ('Shachi', 2, 1, 13)

GO

-- dropping stored procedure
IF OBJECT_ID ('InsertStoredProcedure', 'P') IS not null
	DROP PROCEDURE InsertStoredProcedure;
GO
-- insert from a stored procedure
CREATE PROCEDURE InsertStoredProcedure
AS
BEGIN
	INSERT INTO [Characters]([FullName], [SpeciesID], [PowerLevelID], [AffiliationID]) 
	VALUES ('Yakumo', 2, 1, 2)
		, ('Raigo', 2, 2, 2)
		, ('Majari', 2, 2, 2)
		, ('Kaiki', 2, 2, 2)
END
GO


SELECT * FROM Characters

-- inserting values into CharacterAbilities table
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 12)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 13)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 14)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 15)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 17)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (2, 16)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (2, 2)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (2, 3)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (2, 13)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (2, 14)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (3, 22)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (4, 4)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (4, 19)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (4, 8)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (5, 9)
INSERT INTO CharacterAbilities(CharacterID, AbilityID) VALUES (1, 1)

SELECT * FROM CharacterAbilities

-- example of an update statement
UPDATE Characters SET AffiliationID = 10 WHERE CharacterID= 1

SELECT * FROM Characters

-- example of a delete statement
DELETE FROM Species WHERE Classification = 'Example'

SELECT * FROM Species

-- executing insert stored procedure
EXEC dbo.InsertStoredProcedure
GO

SELECT * FROM Characters
GO
-- Answering Data Questions
-- Question 1. What is the average power level of the characters in the series?
-- dropping an creating a view to show characters and their power level
IF OBJECT_ID ('CharacterPowerLevel') IS not null
	DROP VIEW CharacterPowerLevel;
GO

CREATE VIEW CharacterPowerLevel AS
	SELECT FullName, PowerLevel.PowerLevelID, Class, ClassDescription
	FROM Characters, PowerLevel
WHERE Characters.PowerLevelID = PowerLevel.PowerLevelID 
GO

SELECT * FROM CharacterPowerLevel ORDER BY PowerLevelID DESC -- looking at the view with the higher power levels on top

SELECT TOP 1 PowerLevelID FROM Characters  GROUP BY [PowerLevelID] ORDER BY COUNT(*) DESC -- counting the powerlevelid's to get the most common power level
SELECT Class FROM PowerLevel WHERE PowerLevelID = 4 -- getting the class for the associated power level id
-- The most common power level is Class 'C'
GO
-- Question 2. How many Demons vs Humans are there in the show

IF OBJECT_ID ('DemonsVsHumans') IS not null
	DROP VIEW DemonsVsHumans;
GO

CREATE VIEW DemonsVSHumans AS
	SELECT TOP 1 (SELECT TOP 1 COUNT(SpeciesID) FROM Characters WHERE SpeciesID = 1) AS 'Human Count', (SELECT TOP 1 COUNT(SpeciesID) FROM Characters WHERE SpeciesID = 2) AS 'Demon Count'
	FROM Species
	INNER JOIN Characters ON Characters.SpeciesID = Species.SpeciesID
GO

SELECT * FROM DemonsVsHumans -- There are 14 Humans and 51 Demons
GO

-- Question 3. What is the number of teams/affiliations that are still active?
IF OBJECT_ID ('ActiveAffiliations') IS not null -- dropping procedure
	DROP PROCEDURE ActiveAffiliations;
GO

CREATE PROCEDURE ActiveAffiliations AS -- creating procedure to show current active teams since this can be prone to change
	SELECT TeamName, FullName 
	FROM Affiliation 
	INNER JOIN Characters ON Characters.AffiliationID = Affiliation.AffiliationID
	WHERE TeamStatus = 'Active'
GO

EXEC dbo.ActiveAffiliations

-- Question 4. Who are the strongest characters? Who are the weakest?
IF OBJECT_ID ('StrongestCharacters') IS not null -- dropping procedure
	DROP PROCEDURE StrongestCharacters;
GO

CREATE PROCEDURE StrongestCharacters AS -- creating procedure to show strongest characters since this can be prone to change
	SELECT FullName, Class
	FROM Characters 
	INNER JOIN PowerLevel ON Characters.PowerLevelID = PowerLevel.PowerLevelID
	WHERE Characters.PowerLevelID = 1
GO

EXEC dbo.StrongestCharacters -- shows list of the current characters that are classed in the strongest power level class
GO 

IF OBJECT_ID ('WeakestCharacters') IS not null -- dropping procedure
	DROP PROCEDURE WeakestCharacters;
GO

CREATE PROCEDURE WeakestCharacters AS -- creating procedure to show strongest characters since this can be prone to change
	SELECT FullName, PowerLevel.Class
	FROM Characters 
	INNER JOIN PowerLevel ON Characters.PowerLevelID = PowerLevel.PowerLevelID
	WHERE Characters.PowerLevelID >= 5
	GROUP BY PowerLevel.PowerLevelID, PowerLevel.Class, FullName
	ORDER BY PowerLevel.PowerLevelID ASC
GO

EXEC dbo.WeakestCharacters -- shows list of the current characters that are classed in the weakest or unkown power levels ordered by power level
GO
-- Question 5. If the humans and demons all fought, which group would win based on power level?
IF OBJECT_ID ('SpeciesPowerLevels') IS not null -- dropping procedure
	DROP PROCEDURE SpeciesPowerLevels;
GO

CREATE PROCEDURE SpeciesPowerLevels AS -- creating procedure to show species power level
	SELECT Species.Classification, SUM(Characters.PowerLevelID) AS 'Species PowerLevel'
	FROM Characters
	JOIN Species ON Characters.SpeciesID = Species.SpeciesID
	GROUP BY Characters.SpeciesID, Species.Classification
	ORDER BY 'Species PowerLevel' ASC
GO

EXEC dbo.SpeciesPowerLevels -- shows the sum of the power level ID's giving us the total power level of each group
GO
-- Humans are much stronger because Power Levels are inverse to the PowerLevelID's
