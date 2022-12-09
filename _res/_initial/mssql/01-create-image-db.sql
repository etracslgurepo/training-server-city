CREATE DATABASE [training_image]
GO

USE [training_image]
GO


--
-- TABLE STRUCTURES 
--

CREATE TABLE [dbo].[image_chunk] ( 
   [objid] nvarchar(50) NOT NULL, 
   [parentid] nvarchar(50) NOT NULL, 
   [fileno] int NOT NULL, 
   [byte] varbinary(MAX) NOT NULL,
   CONSTRAINT [pk_image_chunk] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[image_header] ( 
   [objid] nvarchar(50) NOT NULL, 
   [refid] nvarchar(50) NOT NULL, 
   [title] nvarchar(255) NOT NULL, 
   [filesize] int NULL, 
   [extension] nvarchar(255) NULL, 
   [parentid] nvarchar(50) NULL,
   CONSTRAINT [pk_image_header] PRIMARY KEY ([objid])
) 
GO
