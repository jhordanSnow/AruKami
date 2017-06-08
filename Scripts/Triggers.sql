
CREATE TRIGGER NewUser
	ON dbo.[User]
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @idCard VARCHAR(50);
	DECLARE @username VARCHAR(25);
	DECLARE @firstName VARCHAR(50);
	DECLARE @lastName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
	DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
	SET @table = 'User'

	SELECT @idCard = CONVERT(NVARCHAR(MAX), IdCard),
		   @username = Username,
		   @firstName = FirstName,
		   @lastName = LastName
	FROM INSERTED
	
	SET @description = 'Succesfully created user ' + @username + ' belonging to ' + @firstName + ' ' + @lastName + ' with ID ' + @idCard

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TRIGGER NewHiker
	ON dbo.Hiker
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @idCard VARCHAR(50);
	DECLARE @username VARCHAR(25);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
    SET @table = 'Hiker'

	SELECT @idCard = CONVERT(NVARCHAR(MAX), IdCard)
	FROM INSERTED
	
	SET @username = (SELECT U.Username 
					 FROM [USER] U 
					 WHERE CONVERT(NUMERIC(50), @idCard) = U.IdCard)

	SET @description = 'The User ' + @username + ' with ID ' + @idCard + ' is now a registered hiker'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER NewDifficulty
	ON dbo.Difficulty
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
    SET @table = 'Difficulty'

	SELECT @name = [Name]
	FROM INSERTED
	
	SET @description = 'New difficulty level named ' + @name + ' succesfully added '

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER NewPrice
	ON dbo.Price
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
    SET @table = 'Price'

	SELECT @name = [Name]
	FROM INSERTED
	
	SET @description = 'New price level named ' + @name + ' succesfully added'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER NewQuality
	ON dbo.Quality
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
    SET @table = 'Quality'

	SELECT @name = [Name]
	FROM INSERTED
	
	SET @description = 'New quality level named ' + @name + ' succesfully added'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER NewHikeType
	ON dbo.HikeType
	AFTER INSERT
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Insert'
    SET @table = 'HikeType'

	SELECT @name = [Name]
	FROM INSERTED
	
	SET @description = 'New hike type named ' + @name + ' succesfully added'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER DeleteDifficulty
	ON dbo.Difficulty
	AFTER DELETE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'Difficulty'

	SELECT @name = [Name]
	FROM DELETED
	
	SET @description = 'Difficulty level named ' + @name + ' was succesfully deleted'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER DeletePrice
	ON dbo.Price
	AFTER DELETE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'Price'

	SELECT @name = [Name]
	FROM DELETED
	
	SET @description = 'Price level named ' + @name + ' was succesfully deleted'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER DeleteQuality
	ON dbo.Quality
	AFTER DELETE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'Quality'

	SELECT @name = [Name]
	FROM DELETED
	
	SET @description = 'Quality level named ' + @name + ' was succesfully deleted'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER DeleteHikeType
	ON dbo.HikeType
	AFTER DELETE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @name VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'HikeType'

	SELECT @name = [Name]
	FROM DELETED
	
	SET @description = 'Hike type named ' + @name + ' was succesfully deleted'

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdateDifficulty
	ON dbo.Difficulty
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @oldName VARCHAR(50);
	DECLARE @newName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Update'
    SET @table = 'Difficulty'

	SELECT @oldName = [Name]
	FROM DELETED
	
	SELECT @newName = [Name]
	FROM INSERTED

	SET @description = 'Difficulty level named ' + @oldName + ' is now called ' + @newName

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdatePrice
	ON dbo.Price
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @oldName VARCHAR(50);
	DECLARE @newName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'Price'

	SELECT @oldName = [Name]
	FROM DELETED
	
	SELECT @newName = [Name]
	FROM INSERTED
	
	SET @description = 'Price level named ' + @oldName + ' is now called ' + @newName

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdateQuality
	ON dbo.Quality
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @oldName VARCHAR(50);
	DECLARE @newName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'Quality'

	SELECT @oldName = [Name]
	FROM DELETED
	
	SELECT @newName = [Name]
	FROM INSERTED
	
	SET @description = 'Quality level named ' + @oldName + ' is now called ' + @newName

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdateHikeType
	ON dbo.HikeType
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @oldName VARCHAR(50);
	DECLARE @newName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Delete'
    SET @table = 'HikeType'

	SELECT @oldName = [Name]
	FROM DELETED
	
	SELECT @newName = [Name]
	FROM INSERTED
	
	SET @description = 'Hike type named ' + @oldName + ' is now called ' + @newName

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END
 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdateUser
	ON dbo.[User]
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @oldUsername VARCHAR(25);
	DECLARE @newUsername VARCHAR(25);
	DECLARE @oldFirstName VARCHAR(50);
	DECLARE @newFirstName VARCHAR(50);
	DECLARE @oldMiddleName VARCHAR(50);
	DECLARE @newMiddleName VARCHAR(50);
	DECLARE @oldLastName VARCHAR(50);
	DECLARE @newLastName VARCHAR(50);
	DECLARE @oldSecondLastName VARCHAR(50);
	DECLARE @newSecondLastName VARCHAR(50);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
	DECLARE @table VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Update'
	SET @table = 'User'

	SELECT @oldUsername = Username,
		   @oldFirstName = FirstName,
		   @oldMiddleName = MiddleName,
		   @oldLastName = LastName,
		   @oldSecondLastName = SecondLastName
	FROM DELETED

	SELECT @newUsername = Username,
		   @newFirstName = FirstName,
		   @newMiddleName = MiddleName,
		   @newLastName = LastName,
		   @newSecondLastName = SecondLastName
	FROM INSERTED
	
	SET @description = 'Data from the user with the username ' + @oldUsername + ' was updated. '
	IF @oldUsername <> @newUsername	SET @description += 'Username changed from ' + @oldUsername + ' to '+ @newUsername + '. '
	IF @oldFirstName <> @newFirstName	SET @description += 'FirstName changed from ' + @oldFirstName + ' to '+ @newFirstName + '. '
	IF NULLIF(@newMiddleName, @oldMiddleName) IS NOT NULL SET @description += 'MiddleName changed from ' + ISNULL(@oldMiddleName,'NULL') + ' to '+ @newMiddleName + '. '
	IF @oldLastName <> @newLastName	SET @description += 'LastName changed from ' + @oldLastName + ' to '+ @newLastName + '. '
	IF NULLIF(@newSecondLastName, @oldSecondLastName) IS NOT NULL SET @description += 'SecondLastName changed from ' + ISNULL(@oldSecondLastName,'NULL') + ' to '+ @newSecondLastName + '. '
	
	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TRIGGER UpdateHiker
	ON dbo.Hiker
	AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;

	DECLARE @idCard VARCHAR(50);
	DECLARE @username VARCHAR(25);
	DECLARE @creator VARCHAR(50);
	DECLARE @description VARCHAR(MAX);
	DECLARE @date DATETIME;
	DECLARE @type VARCHAR(50);
    DECLARE @table VARCHAR(50);
	DECLARE @oldGender VARCHAR(1);
	DECLARE @newGender VARCHAR(1);
	DECLARE @oldBirthdate VARCHAR(50);
	DECLARE @newBirthdate VARCHAR(50);
	DECLARE @oldNationality VARCHAR(50);
	DECLARE @newNationality VARCHAR(50);
	DECLARE @oldAccountNumber VARCHAR(50);
	DECLARE @newAccountNumber VARCHAR(50);

	SET @creator = SYSTEM_USER
	SET @date = GETDATE()
	SET @type = 'Update'
    SET @table = 'Hiker'

	SELECT @idCard = CONVERT(NVARCHAR(MAX), IdCard)
	FROM INSERTED
	
	SET @username = (SELECT U.Username 
					 FROM [USER] U 
					 WHERE CONVERT(NUMERIC(50), @idCard) = U.IdCard)

	SELECT @oldGender = CONVERT(NVARCHAR(MAX),Gender),
		   @oldBirthdate = CONVERT(NVARCHAR(MAX),BirthDate),
		   @oldNationality = CONVERT(NVARCHAR(MAX),Nationality),
		   @oldAccountNumber = CONVERT(NVARCHAR(MAX),AccountNumber)
	FROM DELETED		   

	SELECT @newGender = CONVERT(NVARCHAR(MAX),Gender),
		   @newBirthdate = CONVERT(NVARCHAR(MAX),BirthDate),
		   @newNationality = CONVERT(NVARCHAR(MAX),Nationality),
		   @newAccountNumber = CONVERT(NVARCHAR(MAX),AccountNumber)
	FROM INSERTED	

	SET @description = 'Data of the hiker with the username ' + @username + ' was updated. '
	IF @oldGender <> @newGender	SET @description += 'Gender changed from ' + @oldGender + ' to '+ @newGender + '. '
	IF @oldBirthdate <> @newBirthdate	SET @description += 'BirthDate changed from ' + @oldBirthdate + ' to '+ @newBirthdate + '. '
	IF @oldNationality <> @newNationality	SET @description += 'Nationality changed from ' + @oldNationality + ' to '+ @newNationality + '. '
	IF @oldAccountNumber <> @newAccountNumber	SET @description += 'Account Number changed from ' + @oldAccountNumber + ' to '+ @newAccountNumber + '. '

	INSERT INTO EventLog([Description],[User],ChangeType,AffectedTable,[Date])
	VALUES (@description , @creator, @type , @table , @date)
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
