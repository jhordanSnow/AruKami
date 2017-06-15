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


CREATE PROCEDURE [PR_HikerLogin](
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
	@idHikeType DECIMAL(20)
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idHikeType,4)
END
GO

CREATE PROCEDURE [PR_InactiveHiker](
	@idHiker DECIMAL(20)
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
-- 6 -> Admin
-- 7 -> AdminICT

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
	@idHiker DECIMAL(20)
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
GO

CREATE PROCEDURE [PR_GetUser](
	@IdCard NUMERIC(20)
)AS BEGIN
	SELECT * FROM [UserDetails] WHERE IdCard = @IdCard
END
GO


-- ADMINISTRADOR

CREATE PROCEDURE [PR_CreateAdmin] (
	@IdCard NUMERIC(20),
	@Username VARCHAR(25),
    @Password VARCHAR(255),
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50) = NULL,
    @LastName VARCHAR(50),
    @SecondLastName VARCHAR(50) = NULL,
	@responseMessage NVARCHAR(250) OUTPUT
) AS BEGIN
	EXEC PR_CreateUser @IdCard, @Username, @Password, @FirstName, @MiddleName, @LastName, @SecondLastName, @responseMessage OUTPUT
	IF @responseMessage = 'Success'
	BEGIN
		BEGIN TRY
			INSERT INTO [Admin](IdCard) VALUES (@IdCard)
		SET @responseMessage = 'Success'
		END TRY
		BEGIN CATCH
			SET @responseMessage = ERROR_MESSAGE() 
		END CATCH
	END
END
GO

CREATE PROCEDURE [PR_CreateAdminICT] (
	@IdCard NUMERIC(20),
	@Username VARCHAR(25),
    @Password VARCHAR(255),
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50) = NULL,
    @LastName VARCHAR(50),
    @SecondLastName VARCHAR(50) = NULL,
	@responseMessage NVARCHAR(250) OUTPUT
) AS BEGIN
	EXEC PR_CreateUser @IdCard, @Username, @Password, @FirstName, @MiddleName, @LastName, @SecondLastName, @responseMessage OUTPUT
	IF @responseMessage = 'Success'
	BEGIN
		BEGIN TRY
			INSERT INTO [AdminICT](IdCard) VALUES (@IdCard)
		SET @responseMessage = 'Success'
		END TRY
		BEGIN CATCH
			SET @responseMessage = ERROR_MESSAGE() 
		END CATCH
	END
END
GO

CREATE PROCEDURE [PR_AdminLogin](
    @Username NVARCHAR(254),
    @Password NVARCHAR(50),
    @responseMessage NVARCHAR(250)='' OUTPUT
)AS BEGIN
	IF EXISTS (SELECT TOP 1 A.[IdCard] FROM [Admin] A INNER JOIN [User] U ON U.[IdCard] = A.[IdCard] WHERE U.Username=@Username)
		EXEC PR_UserLogin @Username, @Password, @responseMessage OUTPUT
	ELSE
		SET @responseMessage = 'Invalid Login'
END
GO

CREATE PROCEDURE [PR_AddQuality](
	@Name VARCHAR(MAX)
)AS BEGIN
	INSERT INTO Quality([Name]) VALUES(@Name)
END
GO

CREATE PROCEDURE [PR_AddPrice](
	@Name VARCHAR(MAX)
)AS BEGIN
	INSERT INTO Price([Name]) VALUES(@Name)
END
GO


CREATE PROCEDURE [PR_AddDifficulty](
	@Name VARCHAR(MAX)
)AS BEGIN
	INSERT INTO Difficulty([Name]) VALUES(@Name)
END
GO

CREATE PROCEDURE [PR_AddHikeType](
	@Name VARCHAR(MAX)
)AS BEGIN
	INSERT INTO HikeType([Name]) VALUES(@Name)
END
GO

CREATE PROCEDURE [PR_EditQuality](
	@Name VARCHAR(MAX),
	@Id INT
)AS BEGIN
	UPDATE Quality SET [Name] = @Name WHERE IdQuality = @Id
END
GO

CREATE PROCEDURE [PR_EditPrice](
	@Name VARCHAR(MAX),
	@Id INT
)AS BEGIN
	UPDATE Price SET [Name] = @Name WHERE IdPrice = @Id
END
GO

CREATE PROCEDURE [PR_EditDifficulty](
	@Name VARCHAR(MAX),
	@Id INT
)AS BEGIN
	UPDATE Difficulty SET [Name] = @Name WHERE IdDifficulty = @Id
END
GO

CREATE PROCEDURE [PR_EditHikeType](
	@Name VARCHAR(MAX),
	@Id INT
)AS BEGIN
	UPDATE HikeType SET [Name] = @Name WHERE IdType = @Id
END
GO


CREATE PROCEDURE [PR_ChangePassword](
    @IdCard NUMERIC(20),
    @OldPassword NVARCHAR(255),
	@NewPassword NVARCHAR(255),
    @responseMessage NVARCHAR(250)='' OUTPUT
)AS BEGIN
    SET NOCOUNT ON
    DECLARE @userID INT
	SET @userID=(SELECT [IdCard] FROM [User] WHERE IdCard=@IdCard AND PasswordHash=HASHBYTES('SHA2_512', @OldPassword+CAST(Salt AS NVARCHAR(36))))
	IF(@userID IS NULL)
		SET @responseMessage='Current Password do not match'
	ELSE 
		BEGIN TRY
			DECLARE @Salt UNIQUEIDENTIFIER = NEWID()
			UPDATE [User] SET PasswordHash = HASHBYTES('SHA2_512', @NewPassword + CAST(@salt AS NVARCHAR(36))), Salt = @Salt 
				WHERE IdCard = @IdCard
			SET @responseMessage='Profile correctly updated.'
		END TRY
		BEGIN CATCH
			SET @responseMessage='Error'
		END CATCH
END
GO

CREATE PROCEDURE [PR_UpdateUser](
	@IdCard NUMERIC(20),
	@Username VARCHAR(25),
    @FirstName VARCHAR(50),
    @MiddleName VARCHAR(50) = NULL,
    @LastName VARCHAR(50),
    @SecondLastName VARCHAR(50) = NULL,
	@responseMessage NVARCHAR(250) OUTPUT
)AS BEGIN

	BEGIN TRY
		UPDATE [User] SET FirstName = @FirstName, MiddleName = @MiddleName, LastName = @LastName, SecondLastName = @SecondLastName WHERE IdCard = @IdCard
		SET @responseMessage = 'Success'
	END TRY
	BEGIN CATCH
		SET @responseMessage = 'Error'
	END CATCH
END
GO

CREATE PROCEDURE [PR_InactiveAdmin](
	@idAdmin NUMERIC(20)
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idAdmin,6)
END
GO

ALTER PROCEDURE [PR_ActiveAdmin](
	@idAdmin DECIMAL(20)
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idAdmin AND IdType = 6
END
GO

CREATE PROCEDURE [PR_InactiveAdminICT](
	@idAdmin NUMERIC(20)
)AS BEGIN
	INSERT INTO Inactives(IdObject,IdType)
	VALUES(@idAdmin,7)
END
GO

CREATE PROCEDURE [PR_ActiveAdminICT](
	@idAdmin DECIMAL(20)
)AS BEGIN
	DELETE FROM Inactives WHERE IdObject = @idAdmin AND IdType = 7
END
GO