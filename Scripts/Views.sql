
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


-- Administrador
CREATE VIEW [View_User] AS
SELECT IdCard, Username,FirstName, MiddleName, LastName, SecondLastName FROM [User]
GO