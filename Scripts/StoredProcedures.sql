USE AruKami
GO

CREATE PROCEDURE [PR_CreateUser] (
	@IdCard NUMERIC(20),
	@Username VARCHAR(25),
    @Password VARCHAR(255),
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50) = NULL,
    @LastName VARCHAR(50),
    @SecondLastName VARCHAR(50) = NULL,
	@responseMessage NVARCHAR(250) OUTPUT
) AS BEGIN
	SET NOCOUNT ON
	DECLARE @Salt UNIQUEIDENTIFIER = NEWID()
	BEGIN TRY
		INSERT INTO [User] ([IdCard], [Username], [PasswordHash], [FirstName], [MiddleName],[LastName], [SecondLastName], [Salt])
		VALUES(@IdCard, @Username, HASHBYTES('SHA2_512', @Password + CAST(@salt AS NVARCHAR(36))), @FirstName, @MiddleName, @LastName, @SecondLastName, @Salt)
	SET @responseMessage = 'Success'
    END TRY
    BEGIN CATCH
        SET @responseMessage = ERROR_MESSAGE() 
    END CATCH
END
GO

CREATE PROCEDURE [PR_CreateHiker] (
	@IdCard NUMERIC(20),
	@Username VARCHAR(25),
    @Password VARCHAR(255),
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50) = NULL,
    @LastName VARCHAR(50),
    @SecondLastName VARCHAR(50) = NULL,
	@Gender CHAR(1),
    @BirthDate DATE,
    @Nationality INT,
	@AccountNumber NUMERIC(20),
	@responseMessage NVARCHAR(250) OUTPUT
) AS BEGIN
	EXEC PR_CreateUser @IdCard, @Username, @Password, @FirstName, @MiddleName, @LastName, @SecondLastName, @responseMessage OUTPUT
	IF @responseMessage = 'Success'
	BEGIN
		BEGIN TRY
			INSERT INTO [Hiker](IdCard, [Gender], [BirthDate], [Nationality], [AccountNumber]) VALUES (@IdCard, @Gender, @BirthDate, @Nationality, @AccountNumber)
		SET @responseMessage = 'Success'
		END TRY
		BEGIN CATCH
			SET @responseMessage = ERROR_MESSAGE() 
		END CATCH
	END
END
GO

CREATE PROCEDURE [PR_UserLogin](
    @Username NVARCHAR(254),
    @Password NVARCHAR(50),
    @responseMessage NVARCHAR(250)='' OUTPUT,
	@IdCard NUMERIC(20) = NULL OUTPUT
)AS BEGIN
    SET NOCOUNT ON
    DECLARE @userID INT
	SET @IdCard=(SELECT [IdCard] FROM [User] WHERE Username=@Username AND PasswordHash=HASHBYTES('SHA2_512', @Password+CAST(Salt AS NVARCHAR(36))))
	IF(@IdCard IS NULL)
		SET @responseMessage='Incorrect password'
	ELSE 
		SET @responseMessage='User successfully logged in'
END
GO


ALTER PROCEDURE [PR_HikerLogin](
    @Username NVARCHAR(254),
    @Password NVARCHAR(50),
    @responseMessage NVARCHAR(250)='' OUTPUT,
	@IdCard NUMERIC(20) = NULL OUTPUT
)AS BEGIN
	IF EXISTS (SELECT TOP 1 H.[IdCard] FROM [Hiker] H INNER JOIN [User] U ON U.[IdCard] = H.[IdCard] WHERE U.Username=@Username)
		EXEC PR_UserLogin @Username, @Password, @responseMessage OUTPUT, @IdCard OUTPUT
	ELSE
		SET @responseMessage = 'Invalid Login'
END
GO

CREATE PROCEDURE [PR_InactiveQuality](
	@idQuality INT
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idQuality,1)
END
GO

CREATE PROCEDURE [PR_InactivePrice](
	@idPrice INT
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idPrice,2)
END
GO

CREATE PROCEDURE [PR_InactiveDifficulty](
	@idDifficulty INT
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idDifficulty,3)
END
GO

CREATE PROCEDURE [PR_InactiveHikeType](
	@idHikeType INT
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idHikeType,4)
END
GO

CREATE PROCEDURE [PR_InactiveHiker](
	@idHiker INT
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idHiker,5)
END
GO

-- EL SIGNIFICADO DE LOS VALORES DE LA COLUMNA IdType
-- DE LA TABLA Inactives SON LOS SIGUIENTES:
-- 1 -> Quality
-- 2 -> Price
-- 3 -> Difficulty
-- 4 -> HikeType
-- 5 -> Hiker

CREATE PROCEDURE [PR_ActiveQuality](
	@idQuality INT
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idQuality AND IdType = 1
END
GO

CREATE PROCEDURE [PR_ActivePrice](
	@idPrice INT
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idPrice AND IdType = 2
END
GO

CREATE PROCEDURE [PR_ActiveDifficulty](
	@idDifficulty INT
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idDifficulty AND IdType = 3
END
GO

CREATE PROCEDURE [PR_ActiveHikeType](
	@idHikeType INT
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idHikeType AND IdType = 4
END
GO

CREATE PROCEDURE [PR_ActiveHiker](
	@idHiker INT
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idHiker AND IdType = 5
END
GO

ALTER PROCEDURE [PR_CreateHike](
	@Name VARCHAR(100),
	@StartDate DATETIME,
	@EndDate DATETIME,
	@Route VARCHAR(MAX),
	@Photo VARBINARY(MAX) = NULL,
	@District INT,
	@QualityLevel INT,
	@PriceLevel INT,
	@Difficulty INT,
	@HikeType INT,
	@StartPoint INT,
	@EndPoint INT,
	@responseMessage NVARCHAR(250) OUTPUT
)AS BEGIN
	BEGIN TRY
		INSERT INTO Hike([Name],StartDate, EndDate, [Route], Photo, District, QualityLevel, PriceLevel, Difficulty, HikeType, StartPoint, [EndPoint])
			 VALUES (@Name, @StartDate, @EndDate, @Route, @Photo, @District, @QualityLevel, @PriceLevel, @Difficulty, @HikeType, @StartPoint, @EndPoint)
	SET @responseMessage = 'Success'
    END TRY
    BEGIN CATCH
        SET @responseMessage = ERROR_MESSAGE()
    END CATCH
END
GO

CREATE PROCEDURE [PR_CreatePoint](
	@Latitude VARCHAR(255),
	@Longitude VARCHAR(255),
	@IdPoint INT OUTPUT,
	@responseMessage NVARCHAR(250) OUTPUT
)AS BEGIN

	BEGIN TRY
		INSERT INTO GeoPoint(Latitude, Longitude)
			 VALUES (@Latitude, @Longitude)
		SET @responseMessage = 'Success'
		SET @IdPoint = @@IDENTITY
    END TRY
    BEGIN CATCH
        SET @responseMessage = ERROR_MESSAGE()
    END CATCH
END

CREATE PROCEDURE [PR_GetUser](
	@IdCard NUMERIC(20)
)AS BEGIN
	SELECT * FROM [UserDetails] WHERE IdCard = @IdCard
END
GO

