
CREATE VIEW [Nationalities] AS
SELECT IdCountry AS [Id], [Name]  FROM Country
GO

CREATE VIEW [Hike_Difficulty] AS
SELECT IdDifficulty AS [Id], [Name]  FROM Difficulty
GO

CREATE VIEW [Hike_Quality] AS
SELECT IdQuality AS [Id], [Name] FROM Quality
GO

CREATE VIEW [Hike_Price] AS
SELECT IdPrice AS [Id], [Name] FROM Price
GO

CREATE VIEW [Hike_Type] AS
SELECT IdType AS [Id], [Name] FROM HikeType
GO


CREATE VIEW [UserDetails] AS
SELECT U.IdCard,U.Username,U.FirstName,U.MiddleName,U.LastName,U.SecondLastName, H.Gender, H.BirthDate, H.Nationality, H.AccountNumber, H.PhotoURL
FROM [dbo].[User] U
INNER JOIN [dbo].[Hiker] H ON U.IdCard = H.IdCard
GO



-- Administrador
CREATE VIEW [View_User] AS
SELECT IdCard, Username,FirstName, MiddleName, LastName, SecondLastName 
FROM [User]
GO

CREATE VIEW [View_Admin] AS
SELECT U.IdCard, Username,FirstName, MiddleName, LastName, SecondLastName, COUNT(I.IdObject) [Inactive] 
FROM [User] U
INNER JOIN [Admin] A ON A.IdCard = U.IdCard
LEFT JOIN Inactives I ON I.IdType = 6 AND u.IdCard = I.IdObject
GROUP BY U.IdCard, Username,FirstName, MiddleName, LastName, SecondLastName
GO


CREATE VIEW [View_AdminICT] AS
SELECT U.IdCard, Username,FirstName, MiddleName, LastName, SecondLastName, COUNT(I.IdObject) [Inactive] 
FROM [User] U
INNER JOIN [AdminICT] A ON A.IdCard = U.IdCard
LEFT JOIN Inactives I ON I.IdType = 7 AND u.IdCard = I.IdObject
GROUP BY U.IdCard, Username,FirstName, MiddleName, LastName, SecondLastName
GO

CREATE VIEW [View_Quality] AS
 SELECT 
	Q.IdQuality AS [Id], 
	Q.[Name], 
	COUNT(I.IdObject) [Inactive] 
FROM Quality Q
LEFT JOIN Inactives I ON I.IdType = 1 AND Q.IdQuality = I.IdObject
GROUP BY Q.IdQuality, Q.[Name]
GO

CREATE VIEW [View_Price] AS
 SELECT 
	P.IdPrice AS [Id], 
	P.[Name], 
	COUNT(I.IdObject) [Inactive] 
FROM Price P
LEFT JOIN Inactives I ON I.IdType = 2 AND P.IdPrice = I.IdObject
GROUP BY p.IdPrice, p.[Name]
GO


CREATE VIEW [View_Difficulty] AS
 SELECT 
	D.IdDifficulty AS [Id], 
	D.[Name], 
	COUNT(I.IdObject) [Inactive] 
FROM Difficulty D
LEFT JOIN Inactives I ON I.IdType = 3 AND D.IdDifficulty = I.IdObject
GROUP BY D.IdDifficulty, D.[Name]
GO


CREATE VIEW [View_HikeType] AS
 SELECT 
	H.IdType AS [Id], 
	H.[Name], 
	COUNT(I.IdObject) [Inactive] 
FROM HikeType H
LEFT JOIN Inactives I ON I.IdType = 4 AND H.IdType = I.IdObject
GROUP BY H.IdType, H.[Name]
GO


CREATE VIEW [View_Hiker] AS
SELECT 
	U.IdCard,
	CONCAT(U.FirstName, ' ', U.MiddleName, ' ', U.LastName, ' ', U.SecondLastName) [Name],
	U.Gender,
	U.BirthDate,
	C.Name [Nationality],
	COUNT(I.IdObject) [Inactive] 	
FROM UserDetails U
INNER JOIN [Country] C ON C.IdCountry = U.Nationality
LEFT JOIN Inactives I ON I.IdType = 5 AND U.IdCard = I.IdObject
GROUP BY U.IdCard,U.Gender, U.BirthDate, C.Name, U.FirstName, U.MiddleName, U.LastName, U.SecondLastName
GO