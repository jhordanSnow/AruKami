----Step 1: (create a new user)
--CREATE LOGIN AruHiker WITH PASSWORD='caca', CHECK_POLICY = OFF;
---- Step 2:(deny view to any database)
--USE master;
--GO
--DENY VIEW ANY DATABASE TO AruHiker; 
---- step 3 (then authorized the user for that specific database , you have to use the  master by doing use master as below)
--USE master;
--GO

--USE AruKami
--CREATE USER AruHiker FOR LOGIN AruHiker
--GO


--GRANT EXEC ON [PR_CreateHiker] to AruHiker
--GRANT EXEC ON [PR_HikerLogin] to AruHiker
GO