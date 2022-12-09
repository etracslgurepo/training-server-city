CREATE DATABASE [training_notification]
GO

USE [training_notification]
GO


--
-- TABLE STRUCTURES 
--

CREATE TABLE [dbo].[async_notification] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [messagetype] nvarchar(50) NULL, 
   [data] nvarchar(MAX) NULL,
   CONSTRAINT [pk_async_notification] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[async_notification] ([dtfiled])
GO


CREATE TABLE [dbo].[async_notification_delivered] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [refid] nvarchar(50) NULL,
   CONSTRAINT [pk_async_notification_delivered] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[async_notification_delivered] ([dtfiled])
GO
CREATE INDEX [ix_refid] ON [dbo].[async_notification_delivered] ([refid])
GO


CREATE TABLE [dbo].[async_notification_failed] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [refid] nvarchar(50) NULL, 
   [errormessage] nvarchar(MAX) NULL,
   CONSTRAINT [pk_async_notification_failed] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[async_notification_failed] ([dtfiled])
GO
CREATE INDEX [ix_refid] ON [dbo].[async_notification_failed] ([refid])
GO


CREATE TABLE [dbo].[async_notification_pending] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtretry] datetime NULL, 
   [retrycount] smallint NULL,
   CONSTRAINT [pk_async_notification_pending] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[async_notification_processing] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL,
   CONSTRAINT [pk_async_notification_processing] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[cloud_notification] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [sender] nvarchar(160) NULL, 
   [senderid] nvarchar(50) NULL, 
   [groupid] nvarchar(32) NULL, 
   [message] nvarchar(255) NULL, 
   [messagetype] nvarchar(50) NULL, 
   [filetype] nvarchar(50) NULL, 
   [channel] nvarchar(50) NULL, 
   [channelgroup] nvarchar(50) NULL, 
   [origin] nvarchar(50) NULL, 
   [data] nvarchar(MAX) NULL, 
   [attachmentcount] smallint NULL,
   CONSTRAINT [pk_cloud_notification] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification] ([dtfiled])
GO
CREATE INDEX [ix_groupid] ON [dbo].[cloud_notification] ([groupid])
GO
CREATE INDEX [ix_objid] ON [dbo].[cloud_notification] ([objid])
GO
CREATE INDEX [ix_origin] ON [dbo].[cloud_notification] ([origin])
GO
CREATE INDEX [ix_senderid] ON [dbo].[cloud_notification] ([senderid])
GO


CREATE TABLE [dbo].[cloud_notification_attachment] ( 
   [objid] nvarchar(50) NOT NULL, 
   [parentid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [indexno] smallint NULL, 
   [name] nvarchar(50) NULL, 
   [type] nvarchar(50) NULL, 
   [description] nvarchar(255) NULL, 
   [fileid] nvarchar(50) NULL,
   CONSTRAINT [pk_cloud_notification_attachment] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification_attachment] ([dtfiled])
GO
CREATE INDEX [ix_fileid] ON [dbo].[cloud_notification_attachment] ([fileid])
GO
CREATE INDEX [ix_name] ON [dbo].[cloud_notification_attachment] ([name])
GO
CREATE INDEX [ix_parentid] ON [dbo].[cloud_notification_attachment] ([parentid])
GO


CREATE TABLE [dbo].[cloud_notification_delivered] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [traceid] nvarchar(50) NULL, 
   [tracetime] datetime NULL,
   CONSTRAINT [pk_cloud_notification_delivered] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification_delivered] ([dtfiled])
GO
CREATE INDEX [ix_traceid] ON [dbo].[cloud_notification_delivered] ([traceid])
GO
CREATE INDEX [ix_tracetime] ON [dbo].[cloud_notification_delivered] ([tracetime])
GO


CREATE TABLE [dbo].[cloud_notification_failed] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [refid] nvarchar(50) NULL, 
   [reftype] nvarchar(25) NULL, 
   [errormessage] nvarchar(MAX) NULL,
   CONSTRAINT [pk_cloud_notification_failed] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification_failed] ([dtfiled])
GO
CREATE INDEX [ix_refid] ON [dbo].[cloud_notification_failed] ([refid])
GO


CREATE TABLE [dbo].[cloud_notification_pending] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [dtexpiry] datetime NULL, 
   [dtretry] datetime NULL, 
   [type] nvarchar(25) NULL, 
   [state] nvarchar(50) NULL,
   CONSTRAINT [pk_cloud_notification_pending] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtexpiry] ON [dbo].[cloud_notification_pending] ([dtexpiry])
GO
CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification_pending] ([dtfiled])
GO
CREATE INDEX [ix_dtretry] ON [dbo].[cloud_notification_pending] ([dtretry])
GO


CREATE TABLE [dbo].[cloud_notification_received] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NULL, 
   [traceid] nvarchar(50) NULL, 
   [tracetime] datetime NULL,
   CONSTRAINT [pk_cloud_notification_received] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[cloud_notification_received] ([dtfiled])
GO
CREATE INDEX [ix_traceid] ON [dbo].[cloud_notification_received] ([traceid])
GO
CREATE INDEX [ix_tracetime] ON [dbo].[cloud_notification_received] ([tracetime])
GO


CREATE TABLE [dbo].[notification] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtfiled] datetime NOT NULL, 
   [sender] nvarchar(160) NOT NULL, 
   [senderid] nvarchar(50) NOT NULL, 
   [groupid] nvarchar(32) NULL, 
   [message] nvarchar(255) NULL, 
   [messagetype] nvarchar(50) NULL, 
   [filetype] nvarchar(50) NULL, 
   [channel] nvarchar(50) NOT NULL, 
   [channelgroup] nvarchar(50) NOT NULL, 
   [origin] nvarchar(50) NOT NULL, 
   [origintype] nvarchar(25) NULL, 
   [chunksize] int NOT NULL, 
   [chunkcount] int NOT NULL, 
   [txnid] nvarchar(50) NULL, 
   [txnno] nvarchar(50) NULL,
   CONSTRAINT [pk_notification] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[notification] ([dtfiled])
GO
CREATE INDEX [ix_groupid] ON [dbo].[notification] ([groupid])
GO
CREATE INDEX [ix_senderid] ON [dbo].[notification] ([senderid])
GO
CREATE INDEX [ix_txnid] ON [dbo].[notification] ([txnid])
GO
CREATE INDEX [ix_txnno] ON [dbo].[notification] ([txnno])
GO


CREATE TABLE [dbo].[notification_async] ( 
   [objid] nvarchar(50) NOT NULL,
   CONSTRAINT [pk_notification_async] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[notification_async_pending] ( 
   [objid] nvarchar(50) NOT NULL,
   CONSTRAINT [pk_notification_async_pending] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[notification_data] ( 
   [objid] nvarchar(50) NOT NULL, 
   [parentid] nvarchar(50) NOT NULL, 
   [indexno] int NOT NULL, 
   [content] nvarchar(MAX) NOT NULL, 
   [contentlength] int NOT NULL,
   CONSTRAINT [pk_notification_data] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_parentid] ON [dbo].[notification_data] ([parentid])
GO


CREATE TABLE [dbo].[notification_fordownload] ( 
   [objid] nvarchar(50) NOT NULL, 
   [indexno] int NOT NULL,
   CONSTRAINT [pk_notification_fordownload] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[notification_forprocess] ( 
   [objid] nvarchar(50) NOT NULL, 
   [indexno] int NULL,
   CONSTRAINT [pk_notification_forprocess] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[notification_pending] ( 
   [objid] nvarchar(50) NOT NULL, 
   [indexno] int NOT NULL,
   CONSTRAINT [pk_notification_pending] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[notification_setting] ( 
   [objid] nvarchar(50) NOT NULL, 
   [value] nvarchar(255) NULL,
   CONSTRAINT [pk_notification_setting] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[sms_inbox] ( 
   [objid] nvarchar(50) NOT NULL, 
   [state] nvarchar(25) NULL, 
   [dtfiled] datetime NULL, 
   [channel] nvarchar(25) NULL, 
   [keyword] nvarchar(50) NULL, 
   [phoneno] nvarchar(15) NULL, 
   [message] nvarchar(160) NULL,
   CONSTRAINT [pk_sms_inbox] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[sms_inbox] ([dtfiled])
GO
CREATE INDEX [ix_phoneno] ON [dbo].[sms_inbox] ([phoneno])
GO


CREATE TABLE [dbo].[sms_inbox_pending] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtexpiry] datetime NULL, 
   [dtretry] datetime NULL, 
   [retrycount] smallint NULL,
   CONSTRAINT [pk_sms_inbox_pending] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtexpiry] ON [dbo].[sms_inbox_pending] ([dtexpiry])
GO
CREATE INDEX [ix_dtretry] ON [dbo].[sms_inbox_pending] ([dtretry])
GO


CREATE TABLE [dbo].[sms_outbox] ( 
   [objid] nvarchar(50) NOT NULL, 
   [state] nvarchar(25) NULL, 
   [dtfiled] datetime NULL, 
   [refid] nvarchar(50) NULL, 
   [phoneno] nvarchar(15) NULL, 
   [message] nvarchar(MAX) NULL, 
   [creditcount] smallint NULL, 
   [remarks] nvarchar(160) NULL, 
   [dtsend] datetime NULL, 
   [traceid] nvarchar(100) NULL,
   CONSTRAINT [pk_sms_outbox] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[sms_outbox] ([dtfiled])
GO
CREATE INDEX [ix_dtsend] ON [dbo].[sms_outbox] ([dtsend])
GO
CREATE INDEX [ix_phoneno] ON [dbo].[sms_outbox] ([phoneno])
GO
CREATE INDEX [ix_refid] ON [dbo].[sms_outbox] ([refid])
GO
CREATE INDEX [ix_traceid] ON [dbo].[sms_outbox] ([traceid])
GO


CREATE TABLE [dbo].[sms_outbox_pending] ( 
   [objid] nvarchar(50) NOT NULL, 
   [dtexpiry] datetime NULL, 
   [dtretry] datetime NULL, 
   [retrycount] smallint NULL,
   CONSTRAINT [pk_sms_outbox_pending] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtexpiry] ON [dbo].[sms_outbox_pending] ([dtexpiry])
GO
CREATE INDEX [ix_dtretry] ON [dbo].[sms_outbox_pending] ([dtretry])
GO


CREATE TABLE [dbo].[sys_notification] ( 
   [notificationid] nvarchar(50) NOT NULL, 
   [objid] nvarchar(50) NULL, 
   [dtfiled] datetime NULL, 
   [sender] nvarchar(160) NULL, 
   [senderid] nvarchar(50) NULL, 
   [recipientid] nvarchar(50) NULL, 
   [recipienttype] nvarchar(50) NULL, 
   [message] nvarchar(255) NULL, 
   [filetype] nvarchar(50) NULL, 
   [data] nvarchar(MAX) NULL, 
   [tag] nvarchar(255) NULL,
   CONSTRAINT [pk_sys_notification] PRIMARY KEY ([notificationid])
) 
GO

CREATE INDEX [ix_dtfiled] ON [dbo].[sys_notification] ([dtfiled])
GO
CREATE INDEX [ix_objid] ON [dbo].[sys_notification] ([objid])
GO
CREATE INDEX [ix_recipientid] ON [dbo].[sys_notification] ([recipientid])
GO
CREATE INDEX [ix_recipienttype] ON [dbo].[sys_notification] ([recipienttype])
GO
CREATE INDEX [ix_senderid] ON [dbo].[sys_notification] ([senderid])
GO
CREATE INDEX [ix_tag] ON [dbo].[sys_notification] ([tag])
GO
