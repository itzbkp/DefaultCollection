USE [master]
GO
/****** Object:  Database [IMDB]    Script Date: 07/30/2018 21:51:02 ******/
CREATE DATABASE [IMDB] ON  PRIMARY 
( NAME = N'IMDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER_2008R2\MSSQL\DATA\IMDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IMDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER_2008R2\MSSQL\DATA\IMDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [IMDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [IMDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [IMDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [IMDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [IMDB] SET ARITHABORT OFF
GO
ALTER DATABASE [IMDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [IMDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [IMDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [IMDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [IMDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [IMDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [IMDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [IMDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [IMDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [IMDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [IMDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [IMDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [IMDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [IMDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [IMDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [IMDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [IMDB] SET  READ_WRITE
GO
ALTER DATABASE [IMDB] SET RECOVERY FULL
GO
ALTER DATABASE [IMDB] SET  MULTI_USER
GO
ALTER DATABASE [IMDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [IMDB] SET DB_CHAINING OFF
GO
USE [IMDB]
GO
/****** Object:  UserDefinedTableType [dbo].[CelebrityIDs]    Script Date: 07/30/2018 21:51:02 ******/
CREATE TYPE [dbo].[CelebrityIDs] AS TABLE(
	[celebrity_id] [int] NULL
)
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 07/30/2018 21:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (1, N'Actor')
INSERT [dbo].[Roles] ([role_id], [role_name]) VALUES (2, N'Producer')
SET IDENTITY_INSERT [dbo].[Roles] OFF
/****** Object:  Table [dbo].[Movies]    Script Date: 07/30/2018 21:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[record_ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[yearOfRelease] [int] NULL,
	[plot] [nvarchar](200) NULL,
	[poster] [nvarchar](100) NULL,
	[created_By] [nvarchar](50) NULL,
	[created_On] [datetime] NULL,
	[modified_By] [nvarchar](50) NULL,
	[modified_On] [datetime] NULL,
	[record_Status] [bit] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[record_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Movies] ON
INSERT [dbo].[Movies] ([record_ID], [name], [yearOfRelease], [plot], [poster], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (12, N'Pardes', 2013, N'Family Story', N'chicago.jpg', N'::1', CAST(0x0000A92D0160F0AF AS DateTime), N'::1', CAST(0x0000A92D01670FB5 AS DateTime), 1)
INSERT [dbo].[Movies] ([record_ID], [name], [yearOfRelease], [plot], [poster], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (13, N'Raazi', 2010, N'Sacrifice', N'la.jpg', N'::1', CAST(0x0000A92D0161E826 AS DateTime), N'::1', CAST(0x0000A92D0165E175 AS DateTime), 1)
INSERT [dbo].[Movies] ([record_ID], [name], [yearOfRelease], [plot], [poster], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (14, N'Amar', 2014, N'Old Style', N'wallpaper.jpeg', N'::1', CAST(0x0000A92D01657A6A AS DateTime), N'::1', CAST(0x0000A92D0166E1F6 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Movies] OFF
/****** Object:  UserDefinedTableType [dbo].[MovieCasts]    Script Date: 07/30/2018 21:51:03 ******/
CREATE TYPE [dbo].[MovieCasts] AS TABLE(
	[movie_id] [int] NULL,
	[celebrity_id] [int] NULL,
	[saved_By] [nvarchar](50) NULL,
	[saved_On] [datetime] NULL DEFAULT (getdate())
)
GO
/****** Object:  Table [dbo].[Celebrities]    Script Date: 07/30/2018 21:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Celebrities](
	[record_ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[sex] [bit] NULL,
	[date_Of_Birth] [nvarchar](50) NULL,
	[bio] [nvarchar](500) NULL,
	[role] [int] NOT NULL,
	[created_By] [nvarchar](50) NULL,
	[created_On] [datetime] NULL,
	[modified_By] [nvarchar](50) NULL,
	[modified_On] [datetime] NULL,
	[record_Status] [bit] NOT NULL,
 CONSTRAINT [PK_Celebrities] PRIMARY KEY CLUSTERED 
(
	[record_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Celebrities] ON
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (6, N'Sohail Khan', 0, N'14-06-2014', N'Big Brother', 1, N'192.168.1.1', CAST(0x0000A92C00A8B6DF AS DateTime), N'::1', CAST(0x0000A92D00D407F7 AS DateTime), 1)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (7, N'Sonia', 1, N'20-08-1990', N'Popular', 2, N'138.5.6.8', CAST(0x0000A92C00ADF59F AS DateTime), N'::1', CAST(0x0000A92D00D305F1 AS DateTime), 1)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (8, N'Irfan Khan', 0, N'24-05-2004', N'Best Actor', 1, N'145.16.3.2', CAST(0x0000A92C0119932A AS DateTime), N'::1', CAST(0x0000A92C016F823C AS DateTime), 0)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (16, N'Raj', NULL, NULL, NULL, 1, N'::1', CAST(0x0000A92C0123FBD8 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (17, N'Geeta', 1, N'', N'Top Designer', 1, N'::1', CAST(0x0000A92C012412CB AS DateTime), N'::1', CAST(0x0000A92D00D5980F AS DateTime), 1)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (18, N'Rakul', 0, N'', N'Telugu Actress', 2, N'::1', CAST(0x0000A92C0127B530 AS DateTime), N'::1', CAST(0x0000A92D00D5A489 AS DateTime), 1)
INSERT [dbo].[Celebrities] ([record_ID], [name], [sex], [date_Of_Birth], [bio], [role], [created_By], [created_On], [modified_By], [modified_On], [record_Status]) VALUES (19, N'Virat', 1, N'', N'Cricketer', 2, N'::1', CAST(0x0000A92C0127E5D4 AS DateTime), N'::1', CAST(0x0000A92D015D5DC4 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Celebrities] OFF
/****** Object:  UserDefinedFunction [dbo].[isEligible]    Script Date: 07/30/2018 21:51:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[isEligible] (
    @CELEBRITYID INT,
    @MOVIEID INT
)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT * FROM Celebrities C JOIN Roles R ON C.role = R.role_id WHERE C.record_ID = @CELEBRITYID AND R.role_name = 'Producer' AND C.record_Status = 1)
		IF EXISTS (SELECT * FROM FilmCredits F JOIN Celebrities C ON F.celebrity_id = C.record_ID JOIN Roles R ON C.role = R.role_id WHERE R.role_name = 'Producer' AND C.record_Status = 1 AND F.movie_id = @MOVIEID)		
			return 0
			
    return 1
END
GO
/****** Object:  Table [dbo].[FilmCredits]    Script Date: 07/30/2018 21:51:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmCredits](
	[record_ID] [int] IDENTITY(1,1) NOT NULL,
	[movie_id] [int] NOT NULL,
	[celebrity_id] [int] NOT NULL,
	[saved_By] [nvarchar](50) NULL,
	[saved_On] [datetime] NOT NULL,
 CONSTRAINT [PK_FilmCredits] PRIMARY KEY CLUSTERED 
(
	[record_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Movie_Celebrity] UNIQUE NONCLUSTERED 
(
	[movie_id] ASC,
	[celebrity_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[FilmCredits] ON
INSERT [dbo].[FilmCredits] ([record_ID], [movie_id], [celebrity_id], [saved_By], [saved_On]) VALUES (91, 14, 16, N'::1', CAST(0x0000A92D01657A6A AS DateTime))
INSERT [dbo].[FilmCredits] ([record_ID], [movie_id], [celebrity_id], [saved_By], [saved_On]) VALUES (92, 14, 7, N'::1', CAST(0x0000A92D01657A6A AS DateTime))
INSERT [dbo].[FilmCredits] ([record_ID], [movie_id], [celebrity_id], [saved_By], [saved_On]) VALUES (93, 12, 6, N'::1', CAST(0x0000A92D0166F4B0 AS DateTime))
INSERT [dbo].[FilmCredits] ([record_ID], [movie_id], [celebrity_id], [saved_By], [saved_On]) VALUES (94, 12, 19, N'::1', CAST(0x0000A92D0166F4B0 AS DateTime))
SET IDENTITY_INSERT [dbo].[FilmCredits] OFF
/****** Object:  StoredProcedure [dbo].[saveMovieDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[saveMovieDetails] (
@RECORD_ID int,
@NAME nvarchar(50),
@YEAROFRELEASE int,
@PLOT nvarchar(200),
@POSTER nvarchar(100),
@USER nvarchar(50),
@IDS AS CelebrityIDs READONLY
)

AS

BEGIN

BEGIN TRANSACTION

IF @RECORD_ID IS NULL 
BEGIN

	INSERT INTO Movies(name, yearOfRelease, plot, poster, created_By, created_On, record_Status) VALUES(@NAME, @YEAROFRELEASE, @PLOT, @POSTER, @USER, CURRENT_TIMESTAMP, 1);
	SELECT @RECORD_ID = MAX(record_ID) FROM Movies
	SELECT @@ROWCOUNT AS Count;
	
END
ELSE 
BEGIN

	IF EXISTS (SELECT * FROM @IDS)
		DELETE FROM FilmCredits WHERE movie_id = @RECORD_ID;
	
	UPDATE Movies SET 
	name = @NAME,
	yearOfRelease = @YEAROFRELEASE,
	plot = @PLOT,
	poster = @POSTER,
	modified_By = @USER,
	modified_On = CURRENT_TIMESTAMP
	WHERE record_ID = @RECORD_ID;
	SELECT @@ROWCOUNT AS Count;
	
END

IF EXISTS (SELECT * FROM @IDS)
BEGIN

DECLARE @ROWS MovieCasts;
INSERT INTO @ROWS(celebrity_id) SELECT * FROM @IDS;
UPDATE @ROWS SET 
movie_id = @RECORD_ID,
saved_By = @USER,
saved_On = CURRENT_TIMESTAMP;

INSERT INTO FilmCredits SELECT * FROM @ROWS;

END

IF @@ERROR = 0
COMMIT TRANSACTION

ELSE
ROLLBACK TRANSACTION

END
GO
/****** Object:  StoredProcedure [dbo].[loadMovieNames]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[loadMovieNames]
AS

BEGIN

SELECT record_ID, name FROM Movies M WHERE record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[showMovieDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showMovieDetails](
@RECORD_ID INT
)

AS

BEGIN

SELECT * 
FROM Movies M
WHERE M.record_ID = @RECORD_ID 
AND M.record_Status = 1;

SELECT F.celebrity_id, C.role
FROM FilmCredits F 
JOIN Celebrities C ON F.celebrity_id = C.record_ID 
JOIN Movies M ON F.movie_id = M.record_ID 
WHERE F.movie_id = @RECORD_ID 
AND C.record_Status = 1
AND M.record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[deleteMovieDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteMovieDetails] (
@RECORD_ID int,
@USER nvarchar(50)
)

AS

BEGIN

BEGIN TRANSACTION

	UPDATE Movies SET 
	modified_By = @USER,
	modified_On = CURRENT_TIMESTAMP,
	record_Status = 0
	WHERE record_ID = @RECORD_ID

	SELECT @@ROWCOUNT AS Count;

IF @@ERROR = 0
COMMIT

ELSE
ROLLBACK

END
GO
/****** Object:  StoredProcedure [dbo].[getRoles]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getRoles]
AS

BEGIN

SELECT * FROM Roles;

END
GO
/****** Object:  StoredProcedure [dbo].[getMoviesList]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getMoviesList]
AS

BEGIN

SELECT * FROM Movies M WHERE record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[showCelebrityDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[showCelebrityDetails](
@RECORD_ID INT 
)
AS

BEGIN

SELECT C.* FROM Celebrities C WHERE record_ID = @RECORD_ID AND record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[saveCelebrityDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[saveCelebrityDetails] (
@RECORD_ID int,
@NAME nvarchar(50),
@SEX bit,
@DATE_OF_BIRTH nvarchar(50),
@BIO nvarchar(500),
@ROLE int,
@USER nvarchar(50)
)

AS

BEGIN

BEGIN TRANSACTION

IF @RECORD_ID IS NULL
	INSERT INTO Celebrities(name, sex, date_Of_Birth, bio, role, created_By, created_On, record_Status) VALUES(@NAME, @SEX, @DATE_OF_BIRTH, @BIO, @ROLE, @USER, CURRENT_TIMESTAMP, 1)
	
ELSE
	UPDATE Celebrities SET 
	name = @NAME,
	sex = @SEX,
	date_Of_Birth = @DATE_OF_BIRTH,
	bio = @BIO,
	role = @ROLE,
	modified_By = @USER,
	modified_On = CURRENT_TIMESTAMP
	WHERE record_ID = @RECORD_ID
	
	SELECT @@ROWCOUNT AS Count, MAX(record_ID) AS record_ID FROM Celebrities;
	
IF @@ERROR = 0
COMMIT TRANSACTION

ELSE
ROLLBACK TRANSACTION

END
GO
/****** Object:  StoredProcedure [dbo].[getCelebritiesList]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCelebritiesList]
AS

BEGIN

SELECT record_ID, name, role FROM Celebrities WHERE record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[getActorsList]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getActorsList]
AS

BEGIN

SELECT C.record_ID, C.name FROM Celebrities C JOIN Roles R ON C.role = R.role_id WHERE role_name = 'Actor' AND record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[getProducersList]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProducersList]
AS

BEGIN

SELECT C.record_ID, C.name FROM Celebrities C JOIN Roles R ON C.role = R.role_id WHERE role_name = 'Producer' AND record_Status = 1;

END
GO
/****** Object:  StoredProcedure [dbo].[deleteCelebrityDetails]    Script Date: 07/30/2018 21:51:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[deleteCelebrityDetails] (
@RECORD_ID int,
@USER nvarchar(50)
)

AS

BEGIN

BEGIN TRANSACTION

	UPDATE Celebrities SET 
	modified_By = @USER,
	modified_On = CURRENT_TIMESTAMP,
	record_Status = 0
	WHERE record_ID = @RECORD_ID

	SELECT @@ROWCOUNT AS Count;

IF @@ERROR = 0
COMMIT

ELSE
ROLLBACK



END
GO
/****** Object:  Check [CK_FilmCredits]    Script Date: 07/30/2018 21:51:04 ******/
ALTER TABLE [dbo].[FilmCredits]  WITH NOCHECK ADD  CONSTRAINT [CK_FilmCredits] CHECK  (([dbo].[isEligible]([celebrity_id],[movie_id])='1'))
GO
ALTER TABLE [dbo].[FilmCredits] NOCHECK CONSTRAINT [CK_FilmCredits]
GO
/****** Object:  ForeignKey [FK_Celebrities_Roles]    Script Date: 07/30/2018 21:51:03 ******/
ALTER TABLE [dbo].[Celebrities]  WITH CHECK ADD  CONSTRAINT [FK_Celebrities_Roles] FOREIGN KEY([role])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Celebrities] CHECK CONSTRAINT [FK_Celebrities_Roles]
GO
/****** Object:  ForeignKey [FK_FilmCredits_Celebrities]    Script Date: 07/30/2018 21:51:04 ******/
ALTER TABLE [dbo].[FilmCredits]  WITH CHECK ADD  CONSTRAINT [FK_FilmCredits_Celebrities] FOREIGN KEY([celebrity_id])
REFERENCES [dbo].[Celebrities] ([record_ID])
GO
ALTER TABLE [dbo].[FilmCredits] CHECK CONSTRAINT [FK_FilmCredits_Celebrities]
GO
/****** Object:  ForeignKey [FK_FilmCredits_Movies]    Script Date: 07/30/2018 21:51:04 ******/
ALTER TABLE [dbo].[FilmCredits]  WITH CHECK ADD  CONSTRAINT [FK_FilmCredits_Movies] FOREIGN KEY([movie_id])
REFERENCES [dbo].[Movies] ([record_ID])
GO
ALTER TABLE [dbo].[FilmCredits] CHECK CONSTRAINT [FK_FilmCredits_Movies]
GO
