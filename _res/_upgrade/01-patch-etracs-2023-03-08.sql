use `training_etracs`
;

CREATE TABLE `sys_message_queue` (
  `objid` varchar(50) NOT NULL,
  `state` int NULL,
  `dtsent` datetime NULL,
  `email` varchar(355) NULL,
  `mobileno` varchar(50) NULL,
  `subject` varchar(255) NULL,
  `message` mediumtext NULL,
  `errmsg` varchar(255) NULL,
  `connection` varchar(255) NULL,
  PRIMARY KEY (`objid`) 
);

CREATE TABLE `sys_message_template` (
  `objid` varchar(50) NOT NULL,
  `statement` mediumtext NULL,
  `subject` varchar(255) NULL,
  `message` mediumtext NULL,
  `emailfield` varchar(255) NULL,
  `mobilenofield` varchar(255) NULL,
  `connection` varchar(255) NULL,
  PRIMARY KEY (`objid`) 
);

alter table sys_report_def add paramhandler varchar(255) null
; 
