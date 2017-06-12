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

---- Permisos del usuario hiker
--GRANT EXEC ON [PR_CreateHiker] TO AruHiker
--GRANT EXEC ON [PR_HikerLogin] TO AruHiker
--GRANT EXEC ON [PR_CreateHike] TO AruHiker
--GRANT EXEC ON [PR_CreatePoint] TO AruHiker
--GRANT EXEC ON [PR_GetUser] TO AruHiker
--GRANT SELECT ON [Nationalities] TO AruHiker
--GRANT SELECT ON [Hike_Difficulty] TO AruHiker
--GRANT SELECT ON [Hike_Quality] TO AruHiker
--GRANT SELECT ON [Hike_Price] TO AruHiker
--GRANT SELECT ON [Hike_Type] TO AruHiker

---- Permisos del usuario administrador
--GRANT EXEC ON [PR_CreateAdmin] TO AruAdmin
--GRANT EXEC ON [PR_AdminLogin] TO AruAdmin
--GRANT SELECT ON [View_User] TO AruAdmin
--GRANT SELECT ON [View_Quality] TO AruAdmin
--GRANT EXEC ON [PR_InactiveQuality] TO AruAdmin
--GRANT EXEC ON [PR_ActiveQuality] TO AruAdmin
--GRANT EXEC ON [PR_AddQuality] TO AruAdmin
--GRANT EXEC ON [PR_EditQuality] TO AruAdmin



GO


