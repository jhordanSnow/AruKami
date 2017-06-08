
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

CREATE VIEW [Districts] AS
SELECT D.IdDistrict AS [Id], CONCAT(P.[Name],' - ' , C.[Name],' - ' ,D.[Name]) AS [Name] FROM Province P
INNER JOIN Canton C ON p.IdProvince = C.IdProvince
INNER JOIN District D ON C.IdCanton = D.IdCanton
GO

