--
-- Current Database: training_etracs
--

USE [training_etracs]
go


-- ## 2023-03-16

CREATE TABLE [sys_message_queue] (
  [objid] varchar(50) NOT NULL,
  [state] int NULL,
  [dtsent] datetime NULL,
  [email] varchar(355) NULL,
  [mobileno] varchar(50) NULL,
  [subject] varchar(255) NULL,
  [message] text NULL,
  [errmsg] varchar(255) NULL,
  [connection] varchar(255) NULL,
  constraint pk_sys_message_queue PRIMARY KEY ([objid]) 
)
go

CREATE TABLE [sys_message_template] (
  [objid] varchar(50) NOT NULL,
  [statement] text NULL,
  [subject] varchar(255) NULL,
  [message] text NULL,
  [emailfield] varchar(255) NULL,
  [mobilenofield] varchar(255) NULL,
  [connection] varchar(255) NULL,
  constraint pk_sys_message_template PRIMARY KEY (objid) 
)
go

alter table sys_report_def add paramhandler varchar(255) null
go
