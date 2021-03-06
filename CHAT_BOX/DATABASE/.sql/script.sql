USE [master]
GO
/****** Object:  Database [CHAT_BOX]    Script Date: 3/10/2021 9:22:36 AM ******/
CREATE DATABASE [CHAT_BOX]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CHAT_BOX', FILENAME = N'D:\Project_MXH\CHAT_BOX\DATABASE\CHAT_BOX.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CHAT_BOX_log', FILENAME = N'D:\Project_MXH\CHAT_BOX\DATABASE\CHAT_BOX_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CHAT_BOX] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CHAT_BOX].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CHAT_BOX] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CHAT_BOX] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CHAT_BOX] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CHAT_BOX] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CHAT_BOX] SET ARITHABORT OFF 
GO
ALTER DATABASE [CHAT_BOX] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CHAT_BOX] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CHAT_BOX] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CHAT_BOX] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CHAT_BOX] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CHAT_BOX] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CHAT_BOX] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CHAT_BOX] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CHAT_BOX] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CHAT_BOX] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CHAT_BOX] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CHAT_BOX] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CHAT_BOX] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CHAT_BOX] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CHAT_BOX] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CHAT_BOX] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CHAT_BOX] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CHAT_BOX] SET RECOVERY FULL 
GO
ALTER DATABASE [CHAT_BOX] SET  MULTI_USER 
GO
ALTER DATABASE [CHAT_BOX] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CHAT_BOX] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CHAT_BOX] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CHAT_BOX] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CHAT_BOX] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CHAT_BOX', N'ON'
GO
ALTER DATABASE [CHAT_BOX] SET QUERY_STORE = OFF
GO
USE [CHAT_BOX]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 3/10/2021 9:22:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[names] [nvarchar](20) NULL,
	[avatar] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messengers]    Script Date: 3/10/2021 9:22:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messengers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NULL,
	[times] [datetime] NULL,
	[accounts_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[messengers]  WITH CHECK ADD  CONSTRAINT [fk_messengers_accounts] FOREIGN KEY([accounts_id])
REFERENCES [dbo].[accounts] ([id])
GO
ALTER TABLE [dbo].[messengers] CHECK CONSTRAINT [fk_messengers_accounts]
GO
/****** Object:  StoredProcedure [dbo].[proc_crud_accounts]    Script Date: 3/10/2021 9:22:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_crud_accounts] 
(
	@select int = null,

	@id int = null,
	@names nvarchar(20) = null,
	@avatar varchar(max) = null
)
as
begin

	if(@select = 1) -- insert
	begin
		insert into accounts
		(
			names,
			avatar
		) 
		values
		(
			@names,
			@avatar
		)

		if(@@rowcount > 1) select 'insert'
	end

	if(@select = 2) -- update
	begin
		update accounts 
		set 
			names = @names,
			avatar = @avatar
		where id = @id	

		if(@@rowcount > 1) select 'update'
	end

	if(@select = 3) -- delete // account không chạy hàm delete
	begin
		delete from accounts 
		where id = @id	

		select 'delete'
	end

	if(@select = 4) -- search by name // account không chạy hàm delete
	begin
		select *
		from accounts
		where names like '%'+@names+'%'

		if(@@rowcount > 1) select 'select completed'
	end

end
GO
USE [master]
GO
ALTER DATABASE [CHAT_BOX] SET  READ_WRITE 
GO
