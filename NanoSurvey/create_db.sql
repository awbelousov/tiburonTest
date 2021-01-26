USE [master]
GO
CREATE DATABASE [TiburonTest]
GO
ALTER DATABASE [TiburonTest] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TiburonTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TiburonTest] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [TiburonTest] SET ANSI_NULLS OFF
GO
ALTER DATABASE [TiburonTest] SET ANSI_PADDING OFF
GO
ALTER DATABASE [TiburonTest] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [TiburonTest] SET ARITHABORT OFF
GO
ALTER DATABASE [TiburonTest] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [TiburonTest] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [TiburonTest] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [TiburonTest] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [TiburonTest] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [TiburonTest] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [TiburonTest] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [TiburonTest] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [TiburonTest] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [TiburonTest] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [TiburonTest] SET  DISABLE_BROKER
GO
ALTER DATABASE [TiburonTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [TiburonTest] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [TiburonTest] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [TiburonTest] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [TiburonTest] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [TiburonTest] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [TiburonTest] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [TiburonTest] SET  READ_WRITE
GO
ALTER DATABASE [TiburonTest] SET RECOVERY FULL
GO
ALTER DATABASE [TiburonTest] SET  MULTI_USER
GO
ALTER DATABASE [TiburonTest] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [TiburonTest] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'TiburonTest', N'ON'
GO
USE [TiburonTest]
GO
/****** Object:  Table [dbo].[Survey]    Script Date: 01/26/2021 10:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Survey](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credate] [datetime] NOT NULL,
	[Title] [nvarchar](512) NOT NULL,
 CONSTRAINT [PK_Survey] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 01/26/2021 10:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credate] [datetime] NOT NULL,
	[Title] [nvarchar](512) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[Seqnum] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Question_SurveyId_Seqnum] ON [dbo].[Question] 
(
	[SurveyId] ASC,
	[Seqnum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interview]    Script Date: 01/26/2021 10:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Interview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credate] [datetime] NOT NULL,
	[RespondentUid] [varchar](64) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[CompleteDate] [datetime] NULL,
 CONSTRAINT [PK_Interview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_Interview_RespondentUid_SurveyId] ON [dbo].[Interview] 
(
	[RespondentUid] ASC,
	[SurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 01/26/2021 10:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credate] [datetime] NOT NULL,
	[Title] [nvarchar](128) NOT NULL,
	[QuestionId] [int] NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Result]    Script Date: 01/26/2021 10:27:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Result](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credate] [datetime] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[InterviewId] [int] NOT NULL,
 CONSTRAINT [PK_Result] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Question_Survey]    Script Date: 01/26/2021 10:27:56 ******/
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Survey] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Survey] ([Id])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Survey]
GO
/****** Object:  ForeignKey [FK_Interview_Survey]    Script Date: 01/26/2021 10:27:56 ******/
ALTER TABLE [dbo].[Interview]  WITH CHECK ADD  CONSTRAINT [FK_Interview_Survey] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Survey] ([Id])
GO
ALTER TABLE [dbo].[Interview] CHECK CONSTRAINT [FK_Interview_Survey]
GO
/****** Object:  ForeignKey [FK_Answer_Question]    Script Date: 01/26/2021 10:27:56 ******/
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([Id])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
/****** Object:  ForeignKey [FK_Result_Answer]    Script Date: 01/26/2021 10:27:56 ******/
ALTER TABLE [dbo].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Answer] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[Answer] ([Id])
GO
ALTER TABLE [dbo].[Result] CHECK CONSTRAINT [FK_Result_Answer]
GO
/****** Object:  ForeignKey [FK_Result_Interview]    Script Date: 01/26/2021 10:27:56 ******/
ALTER TABLE [dbo].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Interview] FOREIGN KEY([InterviewId])
REFERENCES [dbo].[Interview] ([Id])
GO
ALTER TABLE [dbo].[Result] CHECK CONSTRAINT [FK_Result_Interview]
GO
