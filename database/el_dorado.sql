/* =====================================================================
   Base de datos: el_dorado   (SQL Server / T-SQL)
   Convertida desde el volcado MariaDB/MySQL de `tdeabet`
   Ejecutar completo en SSMS / Azure Data Studio.
   ===================================================================== */

USE master;
GO

IF DB_ID(N'el_dorado') IS NOT NULL
BEGIN
    ALTER DATABASE el_dorado SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE el_dorado;
END
GO

CREATE DATABASE el_dorado;
GO

USE el_dorado;
GO

SET NOCOUNT ON;
GO

/* ---------------------------- TABLAS ---------------------------------- */

CREATE TABLE dbo.[sport] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] VARCHAR(100) NOT NULL,
    CONSTRAINT [PK_sport] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[country] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] VARCHAR(100) NOT NULL,
    [code] CHAR(3) NULL,
    CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[league] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [country_id] INT NOT NULL,
    [sport_id] INT NOT NULL,
    [name] VARCHAR(150) NOT NULL,
    [season] VARCHAR(20) NOT NULL,
    CONSTRAINT [PK_league] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[stadium] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] VARCHAR(150) NOT NULL,
    [city] VARCHAR(100) NOT NULL,
    [capacity] INT NULL,
    CONSTRAINT [PK_stadium] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[team] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [league_id] INT NOT NULL,
    [stadium_id] INT NOT NULL,
    [name] VARCHAR(150) NOT NULL,
    [crest_url] VARCHAR(255) NULL,
    CONSTRAINT [PK_team] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[matchday] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [league_id] INT NOT NULL,
    [number] TINYINT NOT NULL,
    [date] DATE NULL,
    CONSTRAINT [PK_matchday] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[match_status] (
    [id_status_match] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_match_status] PRIMARY KEY CLUSTERED ([id_status_match])
);
GO

CREATE TABLE dbo.[match] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [league_id] INT NOT NULL,
    [matchday_id] INT NOT NULL,
    [home_team_id] INT NOT NULL,
    [away_team_id] INT NOT NULL,
    [stadium_id] INT NOT NULL,
    [match_date] DATETIME2(0) NOT NULL,
    [status] TINYINT NOT NULL,
    [home_goals] TINYINT NULL,
    [away_goals] TINYINT NULL,
    CONSTRAINT [PK_match] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[player_position] (
    [id_position] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_player_position] PRIMARY KEY CLUSTERED ([id_position])
);
GO

CREATE TABLE dbo.[player] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [team_id] INT NOT NULL,
    [name] VARCHAR(150) NOT NULL,
    [position] TINYINT NULL,
    [jersey_number] TINYINT NULL,
    [nationality_id] INT NULL,
    [birth_date] DATE NULL,
    CONSTRAINT [PK_player] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[user_status] (
    [id_status_user] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_user_status] PRIMARY KEY CLUSTERED ([id_status_user])
);
GO

CREATE TABLE dbo.[users] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [username] VARCHAR(50) NOT NULL,
    [email] VARCHAR(150) NOT NULL,
    [password_hash] VARCHAR(255) NOT NULL,
    [registration_date] DATETIME2(0) NOT NULL,
    [status] TINYINT NOT NULL,
    CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[customer] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [user_id] INT NOT NULL,
    [full_name] VARCHAR(150) NOT NULL,
    [document_number] VARCHAR(30) NOT NULL,
    [birth_date] DATE NOT NULL,
    [phone] VARCHAR(30) NULL,
    [address] VARCHAR(200) NULL,
    CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[account_status] (
    [id_status_account] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_account_status] PRIMARY KEY CLUSTERED ([id_status_account])
);
GO

CREATE TABLE dbo.[account] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [customer_id] INT NOT NULL,
    [account_number] VARCHAR(30) NOT NULL,
    [opening_date] DATETIME2(0) NOT NULL,
    [status] TINYINT NOT NULL,
    CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[movement_type] (
    [id_movement] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_movement_type] PRIMARY KEY CLUSTERED ([id_movement])
);
GO

CREATE TABLE dbo.[balance_movement] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [account_id] INT NOT NULL,
    [type] TINYINT NOT NULL,
    [amount] DECIMAL(12,2) NOT NULL,
    [movement_date] DATETIME2(0) NOT NULL,
    [resulting_balance] DECIMAL(12,2) NOT NULL,
    CONSTRAINT [PK_balance_movement] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[odds_market] (
    [id_odds] TINYINT NOT NULL,
    [name] VARCHAR(40) NOT NULL,
    CONSTRAINT [PK_odds_market] PRIMARY KEY CLUSTERED ([id_odds])
);
GO

CREATE TABLE dbo.[odds_outcome] (
    [id_outcome] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_odds_outcome] PRIMARY KEY CLUSTERED ([id_outcome])
);
GO

CREATE TABLE dbo.[odds] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [match_id] INT NOT NULL,
    [player_id] INT NULL,
    [market] TINYINT NOT NULL,
    [outcome] TINYINT NOT NULL,
    [odd_value] DECIMAL(6,2) NOT NULL,
    [updated_at] DATETIME2(0) NOT NULL,
    CONSTRAINT [PK_odds] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[bet_status] (
    [id_status_bet] TINYINT NOT NULL,
    [name] VARCHAR(30) NOT NULL,
    CONSTRAINT [PK_bet_status] PRIMARY KEY CLUSTERED ([id_status_bet])
);
GO

CREATE TABLE dbo.[bet] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [customer_id] INT NOT NULL,
    [match_id] INT NOT NULL,
    [odd_id] INT NOT NULL,
    [amount] DECIMAL(12,2) NOT NULL,
    [odd_value_at_bet] DECIMAL(6,2) NOT NULL,
    [potential_payout] DECIMAL(12,2) NOT NULL,
    [status] TINYINT NOT NULL,
    [bet_date] DATETIME2(0) NOT NULL,
    CONSTRAINT [PK_bet] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[company] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [name] VARCHAR(150) NOT NULL,
    [tax_id] VARCHAR(30) NOT NULL,
    [license] VARCHAR(100) NULL,
    [address] VARCHAR(200) NULL,
    [phone] VARCHAR(30) NULL,
    [email] VARCHAR(150) NULL,
    CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[game_rule] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [sport_id] INT NOT NULL,
    [description] VARCHAR(500) NOT NULL,
    CONSTRAINT [PK_game_rule] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[login_history] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [user_id] INT NOT NULL,
    [login_time] DATETIME2(0) NOT NULL,
    [ip_address] VARCHAR(45) NULL,
    [successful] BIT NOT NULL,
    CONSTRAINT [PK_login_history] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[player_stats] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [player_id] INT NOT NULL,
    [goals] TINYINT NOT NULL,
    [assists] TINYINT NOT NULL,
    [yellow_cards] TINYINT NOT NULL,
    [red_cards] TINYINT NOT NULL,
    [matches_played] TINYINT NOT NULL,
    CONSTRAINT [PK_player_stats] PRIMARY KEY CLUSTERED ([id])
);
GO

CREATE TABLE dbo.[team_stats] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [team_id] INT NOT NULL,
    [points] TINYINT NOT NULL,
    [matches_played] TINYINT NOT NULL,
    [wins] TINYINT NOT NULL,
    [draws] TINYINT NOT NULL,
    [losses] TINYINT NOT NULL,
    [goals_for] TINYINT NOT NULL,
    [goals_against] TINYINT NOT NULL,
    CONSTRAINT [PK_team_stats] PRIMARY KEY CLUSTERED ([id])
);
GO

/* ---------------------------- DATOS ----------------------------------- */

SET IDENTITY_INSERT dbo.[sport] ON;
INSERT INTO dbo.[sport] ([id], [name]) VALUES
(1, 'Futbol'),
(2, 'Baloncesto'),
(3, 'Tenis'),
(4, 'Beisbol'),
(5, 'Voleibol'),
(6, 'Boxeo'),
(7, 'Ciclismo'),
(8, 'Atletismo'),
(9, 'Natacion'),
(10, 'Formula 1');
SET IDENTITY_INSERT dbo.[sport] OFF;
GO

SET IDENTITY_INSERT dbo.[country] ON;
INSERT INTO dbo.[country] ([id], [name], [code]) VALUES
(1, 'Colombia', 'COL'),
(2, 'Espana', 'ESP'),
(3, 'Argentina', 'ARG'),
(4, 'Brasil', 'BRA'),
(5, 'Mexico', 'MEX'),
(6, 'Chile', 'CHL'),
(7, 'Peru', 'PER'),
(8, 'Uruguay', 'URY'),
(9, 'Italia', 'ITA'),
(10, 'Francia', 'FRA');
SET IDENTITY_INSERT dbo.[country] OFF;
GO

SET IDENTITY_INSERT dbo.[league] ON;
INSERT INTO dbo.[league] ([id], [country_id], [sport_id], [name], [season]) VALUES
(1, 1, 1, 'Liga Colombiana', '2026'),
(2, 2, 1, 'La Liga', '2026'),
(3, 3, 1, 'Liga Argentina', '2026'),
(4, 4, 1, 'Brasileirao', '2026'),
(5, 5, 1, 'Liga MX', '2026'),
(6, 6, 1, 'Liga Chilena', '2026'),
(7, 7, 1, 'Liga Peruana', '2026'),
(8, 8, 1, 'Liga Uruguaya', '2026'),
(9, 9, 1, 'Serie A', '2026'),
(10, 10, 1, 'Ligue 1', '2026');
SET IDENTITY_INSERT dbo.[league] OFF;
GO

SET IDENTITY_INSERT dbo.[stadium] ON;
INSERT INTO dbo.[stadium] ([id], [name], [city], [capacity]) VALUES
(1, 'Atanasio Girardot', 'Medellin', 40000),
(2, 'Metropolitano', 'Barranquilla', 46000),
(3, 'El Campin', 'Bogota', 36000),
(4, 'Pascual Guerrero', 'Cali', 38000),
(5, 'General Santander', 'Cucuta', 42000),
(6, 'Palogrande', 'Manizales', 28000),
(7, 'Hernan Ramirez', 'Pereira', 30000),
(8, 'Centenario', 'Armenia', 20000),
(9, 'Libertad', 'Pasto', 20000),
(10, 'Deportivo Cali', 'Palmira', 52000);
SET IDENTITY_INSERT dbo.[stadium] OFF;
GO

SET IDENTITY_INSERT dbo.[team] ON;
INSERT INTO dbo.[team] ([id], [league_id], [stadium_id], [name], [crest_url]) VALUES
(1, 1, 1, 'Nacional', NULL),
(2, 1, 1, 'Medellin', NULL),
(3, 2, 3, 'Barcelona', NULL),
(4, 2, 3, 'Real Madrid', NULL),
(5, 3, 2, 'River Plate', NULL),
(6, 3, 2, 'Boca Juniors', NULL),
(7, 4, 4, 'Flamengo', NULL),
(8, 4, 4, 'Palmeiras', NULL),
(9, 5, 5, 'America MX', NULL),
(10, 5, 5, 'Chivas', NULL);
SET IDENTITY_INSERT dbo.[team] OFF;
GO

SET IDENTITY_INSERT dbo.[matchday] ON;
INSERT INTO dbo.[matchday] ([id], [league_id], [number], [date]) VALUES
(1, 1, 1, '2026-02-01'),
(2, 1, 2, '2026-02-08'),
(3, 2, 1, '2026-02-02'),
(4, 2, 2, '2026-02-09'),
(5, 3, 1, '2026-02-03'),
(6, 3, 2, '2026-02-10'),
(7, 4, 1, '2026-02-04'),
(8, 4, 2, '2026-02-11'),
(9, 5, 1, '2026-02-05'),
(10, 5, 2, '2026-02-12');
SET IDENTITY_INSERT dbo.[matchday] OFF;
GO

INSERT INTO dbo.[match_status] ([id_status_match], [name]) VALUES
(1, 'Programado'),
(2, 'En vivo'),
(3, 'Finalizado'),
(4, 'Suspendido'),
(5, 'Cancelado'),
(6, 'Aplazado'),
(7, 'Descanso'),
(8, 'Proximo'),
(9, 'Terminado'),
(10, 'Revisando');
GO

SET IDENTITY_INSERT dbo.[match] ON;
INSERT INTO dbo.[match] ([id], [league_id], [matchday_id], [home_team_id], [away_team_id], [stadium_id], [match_date], [status], [home_goals], [away_goals]) VALUES
(1, 1, 1, 1, 2, 1, '2026-03-01 18:00:00', 3, 2, 1),
(2, 2, 3, 3, 4, 3, '2026-03-02 20:00:00', 3, 1, 1),
(3, 3, 5, 5, 6, 2, '2026-03-03 19:00:00', 3, 2, 2),
(4, 4, 7, 7, 8, 4, '2026-03-04 18:00:00', 3, 3, 1),
(5, 5, 9, 9, 10, 5, '2026-03-05 20:00:00', 3, 1, 0),
(6, 1, 2, 2, 1, 1, '2026-03-10 18:00:00', 1, NULL, NULL),
(7, 2, 4, 4, 3, 3, '2026-03-11 20:00:00', 1, NULL, NULL),
(8, 3, 6, 6, 5, 2, '2026-03-12 19:00:00', 1, NULL, NULL),
(9, 4, 8, 8, 7, 4, '2026-03-13 18:00:00', 1, NULL, NULL),
(10, 5, 10, 10, 9, 5, '2026-03-14 20:00:00', 1, NULL, NULL);
SET IDENTITY_INSERT dbo.[match] OFF;
GO

INSERT INTO dbo.[player_position] ([id_position], [name]) VALUES
(1, 'Portero'),
(2, 'Defensa'),
(3, 'Lateral'),
(4, 'Mediocampista'),
(5, 'Extremo'),
(6, 'Delantero'),
(7, 'Volante'),
(8, 'Central'),
(9, 'Carrilero'),
(10, 'Segundo delantero');
GO

SET IDENTITY_INSERT dbo.[player] ON;
INSERT INTO dbo.[player] ([id], [team_id], [name], [position], [jersey_number], [nationality_id], [birth_date]) VALUES
(1, 1, 'David Ospina', 1, 1, 1, '1988-08-31'),
(2, 1, 'Juan Torres', 2, 4, 1, '1998-02-10'),
(3, 2, 'Luis Diaz', 5, 7, 1, '1997-01-13'),
(4, 3, 'Pedri Gonzalez', 4, 8, 2, '2002-11-25'),
(5, 4, 'Vinicius Junior', 5, 7, 4, '2000-07-12'),
(6, 5, 'Franco Armani', 1, 1, 3, '1986-10-16'),
(7, 6, 'Edinson Cavani', 6, 9, 8, '1987-02-14'),
(8, 7, 'Gabriel Barbosa', 6, 9, 4, '1996-08-30'),
(9, 8, 'Raphael Veiga', 4, 23, 4, '1995-06-29'),
(10, 9, 'Henry Martin', 6, 21, 5, '1992-11-18');
SET IDENTITY_INSERT dbo.[player] OFF;
GO

INSERT INTO dbo.[user_status] ([id_status_user], [name]) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Bloqueado'),
(4, 'Pendiente'),
(5, 'Suspendido'),
(6, 'Verificado'),
(7, 'No verificado'),
(8, 'Temporal'),
(9, 'Administrador'),
(10, 'Invitado');
GO

SET IDENTITY_INSERT dbo.[users] ON;
INSERT INTO dbo.[users] ([id], [username], [email], [password_hash], [registration_date], [status]) VALUES
(1, 'juan123', 'juan@gmail.com', 'hash001', '2026-01-10 10:00:00', 1),
(2, 'maria22', 'maria@gmail.com', 'hash002', '2026-01-11 11:00:00', 1),
(3, 'carlos88', 'carlos@gmail.com', 'hash003', '2026-01-12 12:00:00', 2),
(4, 'ana456', 'ana@gmail.com', 'hash004', '2026-01-13 13:00:00', 1),
(5, 'pedro77', 'pedro@gmail.com', 'hash005', '2026-01-14 14:00:00', 3),
(6, 'laura99', 'laura@gmail.com', 'hash006', '2026-01-15 15:00:00', 1),
(7, 'diego10', 'diego@gmail.com', 'hash007', '2026-01-16 16:00:00', 4),
(8, 'sofia55', 'sofia@gmail.com', 'hash008', '2026-01-17 17:00:00', 1),
(9, 'andres33', 'andres@gmail.com', 'hash009', '2026-01-18 18:00:00', 2),
(10, 'valentina44', 'valentina@gmail.com', 'hash010', '2026-01-19 19:00:00', 1);
SET IDENTITY_INSERT dbo.[users] OFF;
GO

SET IDENTITY_INSERT dbo.[customer] ON;
INSERT INTO dbo.[customer] ([id], [user_id], [full_name], [document_number], [birth_date], [phone], [address]) VALUES
(1, 1, 'Juan Perez', '100000001', '1998-05-10', '3001111111', 'Calle 1 #10-20'),
(2, 2, 'Maria Gomez', '100000002', '1997-06-15', '3002222222', 'Calle 2 #20-30'),
(3, 3, 'Carlos Rodriguez', '100000003', '1999-07-20', '3003333333', 'Calle 3 #30-40'),
(4, 4, 'Ana Martinez', '100000004', '2000-08-25', '3004444444', 'Calle 4 #40-50'),
(5, 5, 'Pedro Sanchez', '100000005', '1996-09-30', '3005555555', 'Calle 5 #50-60'),
(6, 6, 'Laura Torres', '100000006', '1998-10-05', '3006666666', 'Calle 6 #60-70'),
(7, 7, 'Diego Ramirez', '100000007', '2001-11-10', '3007777777', 'Calle 7 #70-80'),
(8, 8, 'Sofia Castro', '100000008', '1999-12-15', '3008888888', 'Calle 8 #80-90'),
(9, 9, 'Andres Moreno', '100000009', '1997-03-20', '3009999999', 'Calle 9 #90-10'),
(10, 10, 'Valentina Rojas', '100000010', '2000-04-25', '3010000000', 'Calle 10 #10-20');
SET IDENTITY_INSERT dbo.[customer] OFF;
GO

INSERT INTO dbo.[account_status] ([id_status_account], [name]) VALUES
(1, 'Activa'),
(2, 'Inactiva'),
(3, 'Bloqueada'),
(4, 'Suspendida'),
(5, 'Pendiente'),
(6, 'Cancelada'),
(7, 'Verificacion'),
(8, 'Congelada'),
(9, 'Cerrada'),
(10, 'Disponible');
GO

SET IDENTITY_INSERT dbo.[account] ON;
INSERT INTO dbo.[account] ([id], [customer_id], [account_number], [opening_date], [status]) VALUES
(1, 1, 'ACC000001', '2026-01-20 10:00:00', 1),
(2, 2, 'ACC000002', '2026-01-21 10:00:00', 1),
(3, 3, 'ACC000003', '2026-01-22 10:00:00', 2),
(4, 4, 'ACC000004', '2026-01-23 10:00:00', 1),
(5, 5, 'ACC000005', '2026-01-24 10:00:00', 1),
(6, 6, 'ACC000006', '2026-01-25 10:00:00', 3),
(7, 7, 'ACC000007', '2026-01-26 10:00:00', 1),
(8, 8, 'ACC000008', '2026-01-27 10:00:00', 1),
(9, 9, 'ACC000009', '2026-01-28 10:00:00', 4),
(10, 10, 'ACC000010', '2026-01-29 10:00:00', 1);
SET IDENTITY_INSERT dbo.[account] OFF;
GO

INSERT INTO dbo.[movement_type] ([id_movement], [name]) VALUES
(1, 'Deposito'),
(2, 'Retiro'),
(3, 'Apuesta'),
(4, 'Premio'),
(5, 'Reembolso'),
(6, 'Bonificacion'),
(7, 'Ajuste'),
(8, 'Comision'),
(9, 'Devolucion'),
(10, 'Transferencia');
GO

SET IDENTITY_INSERT dbo.[balance_movement] ON;
INSERT INTO dbo.[balance_movement] ([id], [account_id], [type], [amount], [movement_date], [resulting_balance]) VALUES
(1, 1, 1, 200000.00, '2026-02-01 10:00:00', 200000.00),
(2, 2, 1, 300000.00, '2026-02-02 10:00:00', 300000.00),
(3, 3, 1, 150000.00, '2026-02-03 10:00:00', 150000.00),
(4, 4, 1, 500000.00, '2026-02-04 10:00:00', 500000.00),
(5, 5, 1, 250000.00, '2026-02-05 10:00:00', 250000.00),
(6, 6, 1, 400000.00, '2026-02-06 10:00:00', 400000.00),
(7, 7, 1, 350000.00, '2026-02-07 10:00:00', 350000.00),
(8, 8, 1, 450000.00, '2026-02-08 10:00:00', 450000.00),
(9, 9, 1, 180000.00, '2026-02-09 10:00:00', 180000.00),
(10, 10, 1, 600000.00, '2026-02-10 10:00:00', 600000.00);
SET IDENTITY_INSERT dbo.[balance_movement] OFF;
GO

INSERT INTO dbo.[odds_market] ([id_odds], [name]) VALUES
(1, 'Ganador'),
(2, 'Resultado exacto'),
(3, 'Total goles'),
(4, 'Ambos marcan'),
(5, 'Primer goleador'),
(6, 'Doble oportunidad'),
(7, 'Handicap'),
(8, 'Tarjetas'),
(9, 'Corners'),
(10, 'Primer tiempo');
GO

INSERT INTO dbo.[odds_outcome] ([id_outcome], [name]) VALUES
(1, 'Local'),
(2, 'Visitante'),
(3, 'Empate'),
(4, 'Mas de 2.5'),
(5, 'Menos de 2.5'),
(6, 'Si'),
(7, 'No'),
(8, 'Primer gol'),
(9, 'Segundo gol'),
(10, 'Sin gol');
GO

SET IDENTITY_INSERT dbo.[odds] ON;
INSERT INTO dbo.[odds] ([id], [match_id], [player_id], [market], [outcome], [odd_value], [updated_at]) VALUES
(1, 1, NULL, 1, 1, 1.80, '2026-03-01 10:00:00'),
(2, 2, NULL, 1, 2, 2.10, '2026-03-02 10:00:00'),
(3, 3, 7, 5, 8, 3.50, '2026-03-03 10:00:00'),
(4, 4, 8, 1, 1, 1.70, '2026-03-04 10:00:00'),
(5, 5, 10, 5, 8, 2.90, '2026-03-05 10:00:00'),
(6, 6, NULL, 1, 2, 2.40, '2026-03-10 10:00:00'),
(7, 7, 5, 5, 8, 3.20, '2026-03-11 10:00:00'),
(8, 8, NULL, 3, 4, 1.95, '2026-03-12 10:00:00'),
(9, 9, 9, 5, 8, 2.80, '2026-03-13 10:00:00'),
(10, 10, NULL, 1, 3, 3.10, '2026-03-14 10:00:00');
SET IDENTITY_INSERT dbo.[odds] OFF;
GO

INSERT INTO dbo.[bet_status] ([id_status_bet], [name]) VALUES
(1, 'Pendiente'),
(2, 'Ganada'),
(3, 'Perdida'),
(4, 'Cancelada'),
(5, 'Reembolsada'),
(6, 'En proceso'),
(7, 'Validada'),
(8, 'Rechazada'),
(9, 'Finalizada'),
(10, 'Suspendida');
GO

SET IDENTITY_INSERT dbo.[bet] ON;
INSERT INTO dbo.[bet] ([id], [customer_id], [match_id], [odd_id], [amount], [odd_value_at_bet], [potential_payout], [status], [bet_date]) VALUES
(1, 1, 1, 1, 50000.00, 1.80, 90000.00, 2, '2026-03-01 12:00:00'),
(2, 2, 2, 2, 100000.00, 2.10, 210000.00, 3, '2026-03-02 13:00:00'),
(3, 3, 3, 3, 75000.00, 3.50, 262500.00, 2, '2026-03-03 14:00:00'),
(4, 4, 4, 4, 150000.00, 1.70, 255000.00, 1, '2026-03-04 15:00:00'),
(5, 5, 5, 5, 50000.00, 2.90, 145000.00, 3, '2026-03-05 16:00:00'),
(6, 6, 6, 6, 200000.00, 2.40, 480000.00, 1, '2026-03-10 12:00:00'),
(7, 7, 7, 7, 80000.00, 3.20, 256000.00, 1, '2026-03-11 13:00:00'),
(8, 8, 8, 8, 120000.00, 1.95, 234000.00, 1, '2026-03-12 14:00:00'),
(9, 9, 9, 9, 90000.00, 2.80, 252000.00, 1, '2026-03-13 15:00:00'),
(10, 10, 10, 10, 60000.00, 3.10, 186000.00, 1, '2026-03-14 16:00:00');
SET IDENTITY_INSERT dbo.[bet] OFF;
GO

SET IDENTITY_INSERT dbo.[company] ON;
INSERT INTO dbo.[company] ([id], [name], [tax_id], [license], [address], [phone], [email]) VALUES
(1, 'BetColombia', '900100001-1', 'LIC001', 'Calle 10 #20-30', '3001000001', 'contacto@betcolombia.com'),
(2, 'SportBet', '900100002-2', 'LIC002', 'Calle 20 #30-40', '3001000002', 'contacto@sportbet.com'),
(3, 'MegaBet', '900100003-3', 'LIC003', 'Carrera 30 #40-50', '3001000003', 'info@megabet.com'),
(4, 'WinSportsBet', '900100004-4', 'LIC004', 'Carrera 40 #50-60', '3001000004', 'info@winsportsbet.com'),
(5, 'GolBet', '900100005-5', 'LIC005', 'Calle 50 #60-70', '3001000005', 'info@golbet.com'),
(6, 'FutbolBet', '900100006-6', 'LIC006', 'Calle 60 #70-80', '3001000006', 'info@futbolbet.com'),
(7, 'SuperSport', '900100007-7', 'LIC007', 'Carrera 70 #80-90', '3001000007', 'info@supersport.com'),
(8, 'ApuestaYa', '900100008-8', 'LIC008', 'Carrera 80 #90-10', '3001000008', 'info@apuestaya.com'),
(9, 'BetPro', '900100009-9', 'LIC009', 'Calle 90 #10-20', '3001000009', 'info@betpro.com'),
(10, 'LuckyBet', '900100010-0', 'LIC010', 'Calle 100 #20-30', '3001000010', 'info@luckybet.com');
SET IDENTITY_INSERT dbo.[company] OFF;
GO

SET IDENTITY_INSERT dbo.[game_rule] ON;
INSERT INTO dbo.[game_rule] ([id], [sport_id], [description]) VALUES
(1, 1, 'El equipo con mas goles gana'),
(2, 2, 'El equipo con mas puntos gana'),
(3, 3, 'Gana el jugador que consiga dos sets'),
(4, 4, 'Gana el equipo con mas carreras'),
(5, 5, 'Gana el equipo que consiga tres sets'),
(6, 6, 'Gana el boxeador con mayor puntuacion'),
(7, 7, 'Gana el ciclista con menor tiempo'),
(8, 8, 'Gana el atleta que llegue primero'),
(9, 9, 'Gana el nadador con menor tiempo'),
(10, 10, 'Gana el piloto con menor tiempo');
SET IDENTITY_INSERT dbo.[game_rule] OFF;
GO

SET IDENTITY_INSERT dbo.[login_history] ON;
INSERT INTO dbo.[login_history] ([id], [user_id], [login_time], [ip_address], [successful]) VALUES
(1, 1, '2026-03-01 08:00:00', '192.168.1.1', 1),
(2, 2, '2026-03-01 08:10:00', '192.168.1.2', 1),
(3, 3, '2026-03-01 08:20:00', '192.168.1.3', 0),
(4, 4, '2026-03-01 08:30:00', '192.168.1.4', 1),
(5, 5, '2026-03-01 08:40:00', '192.168.1.5', 0),
(6, 6, '2026-03-01 08:50:00', '192.168.1.6', 1),
(7, 7, '2026-03-01 09:00:00', '192.168.1.7', 1),
(8, 8, '2026-03-01 09:10:00', '192.168.1.8', 1),
(9, 9, '2026-03-01 09:20:00', '192.168.1.9', 0),
(10, 10, '2026-03-01 09:30:00', '192.168.1.10', 1);
SET IDENTITY_INSERT dbo.[login_history] OFF;
GO

SET IDENTITY_INSERT dbo.[player_stats] ON;
INSERT INTO dbo.[player_stats] ([id], [player_id], [goals], [assists], [yellow_cards], [red_cards], [matches_played]) VALUES
(1, 1, 0, 1, 1, 0, 10),
(2, 2, 1, 2, 2, 0, 9),
(3, 3, 6, 4, 1, 0, 10),
(4, 4, 3, 5, 2, 0, 10),
(5, 5, 8, 3, 1, 0, 10),
(6, 6, 0, 0, 1, 0, 8),
(7, 7, 7, 2, 3, 0, 9),
(8, 8, 9, 3, 2, 1, 10),
(9, 9, 5, 6, 1, 0, 10),
(10, 10, 6, 2, 2, 0, 9);
SET IDENTITY_INSERT dbo.[player_stats] OFF;
GO

SET IDENTITY_INSERT dbo.[team_stats] ON;
INSERT INTO dbo.[team_stats] ([id], [team_id], [points], [matches_played], [wins], [draws], [losses], [goals_for], [goals_against]) VALUES
(1, 1, 25, 10, 8, 1, 1, 20, 8),
(2, 2, 20, 10, 6, 2, 2, 18, 10),
(3, 3, 24, 10, 7, 3, 0, 22, 7),
(4, 4, 27, 10, 9, 0, 1, 25, 5),
(5, 5, 21, 10, 6, 3, 1, 19, 9),
(6, 6, 18, 10, 5, 3, 2, 16, 11),
(7, 7, 26, 10, 8, 2, 0, 24, 6),
(8, 8, 22, 10, 7, 1, 2, 21, 10),
(9, 9, 19, 10, 6, 1, 3, 17, 13),
(10, 10, 17, 10, 5, 2, 3, 15, 14);
SET IDENTITY_INSERT dbo.[team_stats] OFF;
GO

/* ---------------------------- INDICES --------------------------------- */

CREATE NONCLUSTERED INDEX [fk_account_customer] ON dbo.[account] ([customer_id]);
CREATE NONCLUSTERED INDEX [fk_account_status] ON dbo.[account] ([status]);
CREATE NONCLUSTERED INDEX [fk_balance_account] ON dbo.[balance_movement] ([account_id]);
CREATE NONCLUSTERED INDEX [fk_balance_movement_type] ON dbo.[balance_movement] ([type]);
CREATE NONCLUSTERED INDEX [fk_bet_customer] ON dbo.[bet] ([customer_id]);
CREATE NONCLUSTERED INDEX [fk_bet_match] ON dbo.[bet] ([match_id]);
CREATE NONCLUSTERED INDEX [fk_bet_odd] ON dbo.[bet] ([odd_id]);
CREATE NONCLUSTERED INDEX [fk_bet_status] ON dbo.[bet] ([status]);
CREATE NONCLUSTERED INDEX [fk_customer_user] ON dbo.[customer] ([user_id]);
CREATE NONCLUSTERED INDEX [fk_game_rule_sport] ON dbo.[game_rule] ([sport_id]);
CREATE NONCLUSTERED INDEX [fk_league_country] ON dbo.[league] ([country_id]);
CREATE NONCLUSTERED INDEX [fk_league_sport] ON dbo.[league] ([sport_id]);
CREATE NONCLUSTERED INDEX [fk_login_history_user] ON dbo.[login_history] ([user_id]);
CREATE NONCLUSTERED INDEX [fk_match_league] ON dbo.[match] ([league_id]);
CREATE NONCLUSTERED INDEX [fk_match_matchday] ON dbo.[match] ([matchday_id]);
CREATE NONCLUSTERED INDEX [fk_match_home_team] ON dbo.[match] ([home_team_id]);
CREATE NONCLUSTERED INDEX [fk_match_away_team] ON dbo.[match] ([away_team_id]);
CREATE NONCLUSTERED INDEX [fk_match_stadium] ON dbo.[match] ([stadium_id]);
CREATE NONCLUSTERED INDEX [fk_match_status] ON dbo.[match] ([status]);
CREATE NONCLUSTERED INDEX [fk_matchday_league] ON dbo.[matchday] ([league_id]);
CREATE NONCLUSTERED INDEX [fk_odds_match] ON dbo.[odds] ([match_id]);
CREATE NONCLUSTERED INDEX [fk_odds_player] ON dbo.[odds] ([player_id]);
CREATE NONCLUSTERED INDEX [fk_odds_market] ON dbo.[odds] ([market]);
CREATE NONCLUSTERED INDEX [fk_odds_outcome] ON dbo.[odds] ([outcome]);
CREATE NONCLUSTERED INDEX [fk_player_team] ON dbo.[player] ([team_id]);
CREATE NONCLUSTERED INDEX [fk_player_position] ON dbo.[player] ([position]);
CREATE NONCLUSTERED INDEX [fk_player_nationality] ON dbo.[player] ([nationality_id]);
CREATE NONCLUSTERED INDEX [fk_player_stats_player] ON dbo.[player_stats] ([player_id]);
CREATE NONCLUSTERED INDEX [fk_team_league] ON dbo.[team] ([league_id]);
CREATE NONCLUSTERED INDEX [fk_team_stadium] ON dbo.[team] ([stadium_id]);
CREATE NONCLUSTERED INDEX [fk_team_stats_team] ON dbo.[team_stats] ([team_id]);
CREATE NONCLUSTERED INDEX [fk_users_status] ON dbo.[users] ([status]);
GO

/* ------------------------ LLAVES FORANEAS ----------------------------- */

ALTER TABLE dbo.[account] ADD CONSTRAINT [fk_account_customer] FOREIGN KEY ([customer_id]) REFERENCES dbo.[customer] ([id]);
ALTER TABLE dbo.[account] ADD CONSTRAINT [fk_account_status] FOREIGN KEY ([status]) REFERENCES dbo.[account_status] ([id_status_account]);
ALTER TABLE dbo.[balance_movement] ADD CONSTRAINT [fk_balance_account] FOREIGN KEY ([account_id]) REFERENCES dbo.[account] ([id]);
ALTER TABLE dbo.[balance_movement] ADD CONSTRAINT [fk_balance_movement_type] FOREIGN KEY ([type]) REFERENCES dbo.[movement_type] ([id_movement]);
ALTER TABLE dbo.[bet] ADD CONSTRAINT [fk_bet_customer] FOREIGN KEY ([customer_id]) REFERENCES dbo.[customer] ([id]);
ALTER TABLE dbo.[bet] ADD CONSTRAINT [fk_bet_match] FOREIGN KEY ([match_id]) REFERENCES dbo.[match] ([id]);
ALTER TABLE dbo.[bet] ADD CONSTRAINT [fk_bet_odd] FOREIGN KEY ([odd_id]) REFERENCES dbo.[odds] ([id]);
ALTER TABLE dbo.[bet] ADD CONSTRAINT [fk_bet_status] FOREIGN KEY ([status]) REFERENCES dbo.[bet_status] ([id_status_bet]);
ALTER TABLE dbo.[customer] ADD CONSTRAINT [fk_customer_user] FOREIGN KEY ([user_id]) REFERENCES dbo.[users] ([id]);
ALTER TABLE dbo.[game_rule] ADD CONSTRAINT [fk_game_rule_sport] FOREIGN KEY ([sport_id]) REFERENCES dbo.[sport] ([id]);
ALTER TABLE dbo.[league] ADD CONSTRAINT [fk_league_country] FOREIGN KEY ([country_id]) REFERENCES dbo.[country] ([id]);
ALTER TABLE dbo.[league] ADD CONSTRAINT [fk_league_sport] FOREIGN KEY ([sport_id]) REFERENCES dbo.[sport] ([id]);
ALTER TABLE dbo.[login_history] ADD CONSTRAINT [fk_login_history_user] FOREIGN KEY ([user_id]) REFERENCES dbo.[users] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_away_team] FOREIGN KEY ([away_team_id]) REFERENCES dbo.[team] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_home_team] FOREIGN KEY ([home_team_id]) REFERENCES dbo.[team] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_league] FOREIGN KEY ([league_id]) REFERENCES dbo.[league] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_matchday] FOREIGN KEY ([matchday_id]) REFERENCES dbo.[matchday] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_stadium] FOREIGN KEY ([stadium_id]) REFERENCES dbo.[stadium] ([id]);
ALTER TABLE dbo.[match] ADD CONSTRAINT [fk_match_status] FOREIGN KEY ([status]) REFERENCES dbo.[match_status] ([id_status_match]);
ALTER TABLE dbo.[matchday] ADD CONSTRAINT [fk_matchday_league] FOREIGN KEY ([league_id]) REFERENCES dbo.[league] ([id]);
ALTER TABLE dbo.[odds] ADD CONSTRAINT [fk_odds_market] FOREIGN KEY ([market]) REFERENCES dbo.[odds_market] ([id_odds]);
ALTER TABLE dbo.[odds] ADD CONSTRAINT [fk_odds_match] FOREIGN KEY ([match_id]) REFERENCES dbo.[match] ([id]);
ALTER TABLE dbo.[odds] ADD CONSTRAINT [fk_odds_outcome] FOREIGN KEY ([outcome]) REFERENCES dbo.[odds_outcome] ([id_outcome]);
ALTER TABLE dbo.[odds] ADD CONSTRAINT [fk_odds_player] FOREIGN KEY ([player_id]) REFERENCES dbo.[player] ([id]);
ALTER TABLE dbo.[player] ADD CONSTRAINT [fk_player_nationality] FOREIGN KEY ([nationality_id]) REFERENCES dbo.[country] ([id]);
ALTER TABLE dbo.[player] ADD CONSTRAINT [fk_player_position] FOREIGN KEY ([position]) REFERENCES dbo.[player_position] ([id_position]);
ALTER TABLE dbo.[player] ADD CONSTRAINT [fk_player_team] FOREIGN KEY ([team_id]) REFERENCES dbo.[team] ([id]);
ALTER TABLE dbo.[player_stats] ADD CONSTRAINT [fk_player_stats_player] FOREIGN KEY ([player_id]) REFERENCES dbo.[player] ([id]);
ALTER TABLE dbo.[team] ADD CONSTRAINT [fk_team_league] FOREIGN KEY ([league_id]) REFERENCES dbo.[league] ([id]);
ALTER TABLE dbo.[team] ADD CONSTRAINT [fk_team_stadium] FOREIGN KEY ([stadium_id]) REFERENCES dbo.[stadium] ([id]);
ALTER TABLE dbo.[team_stats] ADD CONSTRAINT [fk_team_stats_team] FOREIGN KEY ([team_id]) REFERENCES dbo.[team] ([id]);
ALTER TABLE dbo.[users] ADD CONSTRAINT [fk_users_status] FOREIGN KEY ([status]) REFERENCES dbo.[user_status] ([id_status_user]);
GO

/* ------------------------ PROCEDIMIENTOS ------------------------------ */

CREATE PROCEDURE dbo.listarUsuario
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM dbo.[users];
END
GO

/* Verificacion rapida:
   EXEC dbo.listarUsuario;
*/
