USE master;
GO
CREATE LOGIN app_dorado WITH PASSWORD = '$(APP_PASSWORD)', CHECK_POLICY = OFF;
GO
USE el_dorado;
GO
CREATE USER app_dorado FOR LOGIN app_dorado;
ALTER ROLE db_datareader ADD MEMBER app_dorado;
ALTER ROLE db_datawriter ADD MEMBER app_dorado;
GO
ALTER TABLE dbo.users ADD CONSTRAINT DF_users_status DEFAULT 1 FOR [status];
ALTER TABLE dbo.users ADD CONSTRAINT DF_users_registration_date DEFAULT SYSDATETIME() FOR [registration_date];
ALTER TABLE dbo.login_history ADD CONSTRAINT DF_login_history_login_time DEFAULT SYSDATETIME() FOR [login_time];
GO
ALTER TABLE dbo.account ADD CONSTRAINT DF_account_opening_date DEFAULT SYSDATETIME() FOR [opening_date];
GO
