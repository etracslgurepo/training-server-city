USE [training_etracs]
GO


-- LGU SPECIFIC SETTINGS
-- 
INSERT INTO sys_orgclass ([name], [title], [parentclass], [handler]) VALUES ('CITY', 'CITY', NULL, 'city');
INSERT INTO sys_orgclass ([name], [title], [parentclass], [handler]) VALUES ('DISTRICT', 'DISTRICT', 'CITY', 'district');

INSERT INTO sys_org ([objid], [name], [orgclass], [code], [root]) VALUES ('001', 'CITY', 'CITY', '001', 1);

INSERT INTO city (
	[objid], [state], [indexno], [pin], [name], 
	[mayor_name], [mayor_title], [mayor_office], 
	[assessor_name], [assessor_title], [assessor_office], 
	[treasurer_name], [treasurer_title], [treasurer_office], 
	[address], [fullname]
) VALUES (
	'001', 'DRAFT', '001', '001', 'CITY', 
	'-', 'CITY MAYOR', 'OFFICE OF THE CITY MAYOR', 
	'-', 'CITY ASSESSOR', 'OFFICE OF THE CITY ASSESSOR', 
	'-', 'CITY TREASURER', 'OFFICE OF THE CITY TREASURER', 
	'TRAINING CITY, PHILIPPINES', 
	'CITY OF TRAINING'
);

delete from barangay;
delete from municipality;
delete from sys_org where orgclass = 'BARANGAY';
delete from sys_org where orgclass = 'MUNICIPALITY';
delete from sys_orgclass where name = 'BARANGAY';
delete from sys_orgclass where name = 'MUNICIPALITY';
