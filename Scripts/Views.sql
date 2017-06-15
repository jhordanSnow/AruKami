
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
SELECT IdCard, Username,FirstName, MiddleName, LastName, SecondLastName FROM [User]
GO


CREATE VIEW View_Quality AS
 SELECT 
	Q.IdQuality AS [Id], 
	Q.[Name], 
	COUNT(I.IdObject) [Inactive] 
FROM Quality Q
LEFT JOIN Inactives I ON I.IdType = 1 AND Q.IdQuality = I.IdObject
GROUP BY Q.IdQuality, Q.[Name]
GO
