USE [master]
GO
/****** Object:  Database [GWFApp]    Script Date: 9/20/2022 10:09:35 PM ******/
CREATE DATABASE [GWFApp1]
GO
ALTER DATABASE [GWFApp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GWFApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GWFApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GWFApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GWFApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GWFApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GWFApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [GWFApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GWFApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GWFApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GWFApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GWFApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GWFApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GWFApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GWFApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GWFApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GWFApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GWFApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GWFApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
ALTER DATABASE [GWFApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GWFApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GWFApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GWFApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GWFApp] SET  MULTI_USER 
GO
ALTER DATABASE [GWFApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GWFApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GWFApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GWFApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GWFApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GWFApp] SET QUERY_STORE = OFF
GO

USE GWFApp1
/****** Object:  UserDefinedFunction [dbo].[FN_AverageStars]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_AverageStars](@Id int, @NumOfRev int)
RETURNS float
AS
BEGIN
RETURN
	(CAST((SELECT SUM(Stars) FROM ReviewDetail 
	WHERE AccountID = @Id AND Status = 1) AS float) / CAST (@NumOfRev AS float))
END
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TotalOfReviews]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_TotalOfReviews](@Id int)
RETURNS int
AS
BEGIN
RETURN
	(SELECT COUNT(*) FROM ReviewDetail
	WHERE AccountID = @Id AND Status = 1)
END
GO
/****** Object:  Table [dbo].[Location]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [int] NOT NULL,
	[Province] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[City] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Province]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_Province]
AS
SELECT DISTINCT Province FROM Location

GO
/****** Object:  UserDefinedFunction [dbo].[FN_ListCity]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_ListCity](@Pro nvarchar(255))
RETURNS TABLE
AS
RETURN 
	SELECT City FROM Location
	WHERE Province LIKE @Pro
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AccountID] [int] IDENTITY(3,5) NOT NULL,
	[UserName] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [nchar](65) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Applicant]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Applicant](
	[AccountID] [int] IDENTITY(1,5) NOT NULL,
	[LocationID] [int] NULL,
	[DegreeID] [int] NULL,
	[FirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DOB] [date] NULL,
	[Gender] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalOfReviews]  AS ([dbo].[FN_TotalOfReviews]([AccountID])),
	[AverageStars]  AS ([dbo].[FN_AverageStars]([AccountID],[dbo].[FN_TotalOfReviews]([AccountID]))),
	[Verify] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Applicant] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Business]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Business](
	[BusinessID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BusinessName] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BusinessLogo] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Business] PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[ChatID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[CreatedTime] [smalldatetime] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[RepByID] [int] NOT NULL,
 CONSTRAINT [PK_Chat] PRIMARY KEY CLUSTERED 
(
	[ChatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatLine]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatLine](
	[LineID] [int] IDENTITY(1,1) NOT NULL,
	[ChatID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[CreatedTime] [smalldatetime] NOT NULL,
	[Message] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ChatLine] PRIMARY KEY CLUSTERED 
(
	[LineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[OfferID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[RepToID] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[UpdatedTime] [smalldatetime] NULL,
	[CreatedTime] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentContent]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentContent](
	[CommentID] [int] NOT NULL,
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[Content] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CommentContent] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Degree]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Degree](
	[DegreeID] [int] IDENTITY(1,1) NOT NULL,
	[DegreeName] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Degree] PRIMARY KEY CLUSTERED 
(
	[DegreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobApplication]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobApplication](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Salary] [int] NULL,
	[Age] [int] NOT NULL,
	[Visual] [int] NULL,
	[Other] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartTime] [time](0) NULL,
	[EndTime] [time](0) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_JobApplication] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobMapping]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobMapping](
	[OfferID] [int] NOT NULL,
	[ApplicationID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobOffer]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobOffer](
	[OfferID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[DegreeID] [int] NULL,
	[NumOfRecruit] [int] NOT NULL,
	[OfferEndTime] [smalldatetime] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[Status] [int] NOT NULL,
	[Salary] [int] NULL,
	[Age] [int] NULL,
	[Visual] [int] NULL,
	[JobDescription] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Other] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StartTime] [time](0) NULL,
	[EndTime] [time](0) NULL,
	[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BusinessID] [int] NULL,
 CONSTRAINT [PK_JobOffer] PRIMARY KEY CLUSTERED 
(
	[OfferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobType]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobType](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_JobType] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recruiter]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recruiter](
	[AccountID] [int] IDENTITY(2,5) NOT NULL,
	[FirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Gender] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TotalOfReviews]  AS ([dbo].[FN_TotalOfReviews]([AccountID])),
	[AverageStars]  AS ([dbo].[FN_AverageStars]([AccountID],[dbo].[FN_TotalOfReviews]([AccountID]))),
	[Verify] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Recruiter] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewContent]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewContent](
	[ContentID] [int] IDENTITY(1,1) NOT NULL,
	[ReviewID] [int] NOT NULL,
	[Content] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ReviewContent] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewDetail]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewDetail](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[Stars] [int] NOT NULL,
	[CreatedTime] [smalldatetime] NOT NULL,
	[UpdatedTime] [smalldatetime] NULL,
	[Status] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
 CONSTRAINT [PK_ReviewDetail] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seen]    Script Date: 9/20/2022 10:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seen](
	[SeenID] [int] IDENTITY(1,1) NOT NULL,
	[LineID] [int] NOT NULL,
	[SeenTime] [smalldatetime] NOT NULL,
	[AccountID] [int] NOT NULL,
 CONSTRAINT [PK_Seen] PRIMARY KEY CLUSTERED 
(
	[SeenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applicant]  WITH CHECK ADD  CONSTRAINT [FK_Applicant_Degree] FOREIGN KEY([DegreeID])
REFERENCES [dbo].[Degree] ([DegreeID])
GO
ALTER TABLE [dbo].[Applicant] CHECK CONSTRAINT [FK_Applicant_Degree]
GO
ALTER TABLE [dbo].[Applicant]  WITH CHECK ADD  CONSTRAINT [FK_Applicant_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[Applicant] CHECK CONSTRAINT [FK_Applicant_Location]
GO
ALTER TABLE [dbo].[Business]  WITH CHECK ADD  CONSTRAINT [FK_Business_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[Business] CHECK CONSTRAINT [FK_Business_Location]
GO
ALTER TABLE [dbo].[Business]  WITH CHECK ADD  CONSTRAINT [FK_Business_Recruiter] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Recruiter] ([AccountID])
GO
ALTER TABLE [dbo].[Business] CHECK CONSTRAINT [FK_Business_Recruiter]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Applicant] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Applicant] ([AccountID])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Applicant]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Recruiter] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Recruiter] ([AccountID])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Recruiter]
GO
ALTER TABLE [dbo].[ChatLine]  WITH CHECK ADD  CONSTRAINT [FK_ChatLine_Chat] FOREIGN KEY([ChatID])
REFERENCES [dbo].[Chat] ([ChatID])
GO
ALTER TABLE [dbo].[ChatLine] CHECK CONSTRAINT [FK_ChatLine_Chat]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_JobOffer] FOREIGN KEY([OfferID])
REFERENCES [dbo].[JobOffer] ([OfferID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_JobOffer]
GO
ALTER TABLE [dbo].[CommentContent]  WITH CHECK ADD  CONSTRAINT [FK_CommentContent_Comment] FOREIGN KEY([CommentID])
REFERENCES [dbo].[Comment] ([CommentID])
GO
ALTER TABLE [dbo].[CommentContent] CHECK CONSTRAINT [FK_CommentContent_Comment]
GO
ALTER TABLE [dbo].[JobApplication]  WITH CHECK ADD  CONSTRAINT [FK_JobApplication_Applicant] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Applicant] ([AccountID])
GO
ALTER TABLE [dbo].[JobApplication] CHECK CONSTRAINT [FK_JobApplication_Applicant]
GO
ALTER TABLE [dbo].[JobMapping]  WITH CHECK ADD  CONSTRAINT [FK_JobMapping_JobApplication] FOREIGN KEY([ApplicationID])
REFERENCES [dbo].[JobApplication] ([ApplicationID])
GO
ALTER TABLE [dbo].[JobMapping] CHECK CONSTRAINT [FK_JobMapping_JobApplication]
GO
ALTER TABLE [dbo].[JobMapping]  WITH CHECK ADD  CONSTRAINT [FK_JobMapping_JobOffer] FOREIGN KEY([OfferID])
REFERENCES [dbo].[JobOffer] ([OfferID])
GO
ALTER TABLE [dbo].[JobMapping] CHECK CONSTRAINT [FK_JobMapping_JobOffer]
GO
ALTER TABLE [dbo].[JobOffer]  WITH CHECK ADD  CONSTRAINT [FK_JobOffer_Degree] FOREIGN KEY([DegreeID])
REFERENCES [dbo].[Degree] ([DegreeID])
GO
ALTER TABLE [dbo].[JobOffer] CHECK CONSTRAINT [FK_JobOffer_Degree]
GO
ALTER TABLE [dbo].[JobOffer]  WITH CHECK ADD  CONSTRAINT [FK_JobOffer_JobType] FOREIGN KEY([TypeID])
REFERENCES [dbo].[JobType] ([TypeID])
GO
ALTER TABLE [dbo].[JobOffer] CHECK CONSTRAINT [FK_JobOffer_JobType]
GO
ALTER TABLE [dbo].[JobOffer]  WITH CHECK ADD  CONSTRAINT [FK_JobOffer_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[JobOffer] CHECK CONSTRAINT [FK_JobOffer_Location]
GO
ALTER TABLE [dbo].[JobOffer]  WITH CHECK ADD  CONSTRAINT [FK_JobOffer_Recruiter] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Recruiter] ([AccountID])
GO
ALTER TABLE [dbo].[JobOffer] CHECK CONSTRAINT [FK_JobOffer_Recruiter]
GO
ALTER TABLE [dbo].[ReviewContent]  WITH CHECK ADD  CONSTRAINT [FK_ReviewContent_ReviewDetail] FOREIGN KEY([ReviewID])
REFERENCES [dbo].[ReviewDetail] ([ReviewID])
GO
ALTER TABLE [dbo].[ReviewContent] CHECK CONSTRAINT [FK_ReviewContent_ReviewDetail]
GO
ALTER TABLE [dbo].[Seen]  WITH CHECK ADD  CONSTRAINT [FK_Seen_ChatLine] FOREIGN KEY([LineID])
REFERENCES [dbo].[ChatLine] ([LineID])
GO
ALTER TABLE [dbo].[Seen] CHECK CONSTRAINT [FK_Seen_ChatLine]
GO
USE [master]
GO
ALTER DATABASE [GWFApp] SET  READ_WRITE 
GO
