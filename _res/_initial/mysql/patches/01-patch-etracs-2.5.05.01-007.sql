--
-- Current Database: `training_etracs`
--

USE `training_etracs`;


-- ## 2022-12-13

CREATE TABLE `business_officefee` (
  `objid` varchar(50) NOT NULL,
  `applicationid` varchar(50) NOT NULL,
  `txntype_objid` varchar(50) NOT NULL,
  `account_objid` varchar(50) NOT NULL,
  `account_title` varchar(100) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `remarks` varchar(255) NULL,
  `department` varchar(50) NULL,
  `dtcreated` datetime NOT NULL,
  `createdby_objid` varchar(50) NOT NULL,
  `createdby_name` varchar(150) NOT NULL,
  `role` varchar(50) NOT NULL,
  constraint pk_business_officefee PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE UNIQUE INDEX `uix_applicationid_account_objid` ON `business_officefee` (`applicationid`,`account_objid`); 
CREATE INDEX `ix_applicationid` ON `business_officefee` (`applicationid`);
CREATE INDEX `ix_account_objid` ON `business_officefee` (`account_objid`);
CREATE INDEX `ix_txntype_objid` ON `business_officefee` (`txntype_objid`);
CREATE INDEX `ix_dtcreated` ON `business_officefee` (`dtcreated`);
CREATE INDEX `ix_createdby_objid` ON `business_officefee` (`createdby_objid`);

ALTER TABLE `business_officefee` 
  ADD CONSTRAINT `fk_business_officefee_applicationid` 
  FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`)
;
ALTER TABLE `business_officefee` 
  ADD CONSTRAINT `fk_business_officefee_txntype_objid` 
  FOREIGN KEY (`txntype_objid`) REFERENCES `business_billitem_txntype` (`objid`)
;




-- ## 2022-12-26
alter table sys_fileitem add filetype varchar(10) null
;
update sys_fileitem set 
  filetype = ( 
    select filetype from sys_file 
    where objid = sys_fileitem.parentid  
  ) 
where filetype is null 
; 
alter table sys_fileitem modify filetype varchar(10) not null
;


alter table sys_fileitem add bytestransferred int null
;




-- ## 2022-12-29

INSERT INTO `sys_var` (`name`, `value`, `description`, `datatype`, `category`) 
VALUES ('bpls_fee_bfp_split_receipt', '0', 'Split the BFP Fee Receipt', 'checkbox', 'BPLS');




-- ## 2023-01-03

insert ignore into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select 
  concat(a.objid,'-',b.name) as objid, a.objid as parentid, 
  b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
from 
  (
    select * from sys_rule_fact 
    where factclass = 'bpls.facts.Payment'
  )a, 
  ( 
    select 
      'option' as name, 'Option' as title, 0 as sortorder, 
      'string' as datatype, 'string' as `handler`, 'string' as vardatatype 
    union 
    select 
      'qtr' as name, 'Qtr' as title, 0 as sortorder, 
      'integer' as datatype, 'integer' as `handler`, 'integer' as vardatatype 
  )b 
;


insert ignore into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select 
  concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
  b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
from 
  (
    select * from sys_rule_fact 
    where factclass = 'bpls.facts.BillItem'
  )a, 
  ( 
    select 
      'amtpaid' as name, 'Amount Paid' as title, 2 as sortorder, 
      'decimal' as datatype, 'decimal' as `handler`, 'decimal' as vardatatype 
  )b 
;



insert into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select * 
from ( 
  select 
    concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
    b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
  from 
    (
      select * from sys_rule_fact 
      where factclass = 'bpls.facts.BillItem'
    )a, 
    ( 
      select 
        'firstItem' as name, 'First Item' as title, 100 as sortorder, 
        'boolean' as datatype, 'boolean' as `handler`, 'boolean' as vardatatype 
      union 
      select 
        'lastItem' as name, 'Last Item' as title, 100 as sortorder, 
        'boolean' as datatype, 'boolean' as `handler`, 'boolean' as vardatatype 
      union 
      select 
        'minqtr' as name, 'Min Qtr' as title, 101 as sortorder, 
        'integer' as datatype, 'integer' as `handler`, 'integer' as vardatatype 
      union 
      select 
        'maxqtr' as name, 'Max Qtr' as title, 101 as sortorder, 
        'integer' as datatype, 'integer' as `handler`, 'integer' as vardatatype 
    )b 
)t0 
where (
  select count(*) from sys_rule_fact_field 
  where parentid = t0.parentid and name = t0.name 
) = 0 
;


insert into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select * 
from ( 
  select 
    concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
    b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
  from 
    (
      select * from sys_rule_fact 
      where factclass = 'bpls.facts.QtrDeadline' 
    )a, 
    ( 
      select 
        'nextdeadline' as name, 'Next Due Date' as title, 10 as sortorder, 
        'date' as datatype, 'date' as `handler`, 'date' as vardatatype 
      union 
      select 
        'prevdeadline' as name, 'Previous Due Date' as title, 10 as sortorder, 
        'date' as datatype, 'date' as `handler`, 'date' as vardatatype 
    )b 
)t0 
where (
  select count(*) from sys_rule_fact_field 
  where parentid = t0.parentid and name = t0.name 
) = 0 
;




-- ## 2023-01-08

INSERT INTO `sys_usergroup` (`objid`, `title`, `domain`, `userclass`, `orgclass`, `role`) 
VALUES ('BPLS.RECORD_ADMIN', 'BPLS RECORD ADMIN', 'BPLS', 'usergroup', NULL, 'RECORD_ADMIN');




-- ## 2023-01-09

insert into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select * 
from ( 
  select 
    concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
    b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
  from 
    (
      select * from sys_rule_fact 
      where factclass = 'bpls.facts.QtrDeadline' 
    )a, 
    ( 
      select 
        'nextBeginQtrDate' as name, 'Next Qtr Begin Date' as title, 10 as sortorder, 
        'date' as datatype, 'date' as `handler`, 'date' as vardatatype 
      union 
      select 
        'prevBeginQtrDate' as name, 'Previous Qtr Begin Date' as title, 10 as sortorder, 
        'date' as datatype, 'date' as `handler`, 'date' as vardatatype 
    )b 
)t0 
where (
  select count(*) from sys_rule_fact_field 
  where parentid = t0.parentid and name = t0.name 
) = 0 
;


insert into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select * 
from ( 
  select 
    concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
    b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
  from 
    (
      select * from sys_rule_fact 
      where factclass = 'bpls.facts.BillItem'
    )a, 
    ( 
      select 
        'groupid' as name, 'Group ID' as title, 110 as sortorder, 
        'string' as datatype, 'string' as `handler`, 'string' as vardatatype 
    )b 
)t0 
where (
  select count(*) from sys_rule_fact_field 
  where parentid = t0.parentid and name = t0.name 
) = 0 
;




-- ## 2023-01-16

alter table sys_fileitem add filedir varchar(255) null 
;



-- ## 2023-01-19

drop table if exists vw_psic_subclass
; 
drop view if exists vw_psic_subclass
; 
create view vw_psic_subclass as 
select sc.*,  
  c.code as class_code, c.description as class_description, 
  g.code as group_code, g.description as group_description,
  d.code as division_code, d.description as division_description,
  s.code as section_code, s.description as section_description
from psic_subclass sc 
  inner join psic_class c on c.code = sc.classid 
  inner join psic_group g on g.code = c.groupid 
  inner join psic_division d on d.`code` = g.divisionid 
  inner join psic_section s on s.code = d.sectionid 
;

drop table if exists vw_lob
; 
drop view if exists vw_lob
; 
create view vw_lob as 
select 
  lob.objid, lob.state, lob.name, lob.classification_objid, 
  lob.psicid, sc.code as psic_code, sc.description as psic_description, 
  sc.class_code as psic_class_code, sc.class_description as psic_class_description, 
  sc.group_code as psic_group_code, sc.group_description as psic_group_description, 
  sc.division_code as psic_division_code, sc.division_description as psic_division_description, 
  sc.section_code as psic_section_code, sc.section_description as psic_section_description 
from lob 
  left join vw_psic_subclass sc on sc.code = lob.psicid 
;

insert into sys_ruleset_fact (
  ruleset, rulefact 
) 
select rs.name as ruleset, rf.objid as rulefact 
from 
  ( select name from sys_ruleset where name = 'bpbilling' ) rs, 
  ( select objid from sys_rule_fact where factclass = 'bpls.facts.BusinessInfo' ) rf 
where 
  (
    select count(*) from sys_ruleset_fact 
    where ruleset = rs.name and rulefact = rf.objid 
  ) = 0 
;



-- ## 2023-01-29

insert into sys_rule_fact_field (
  objid, parentid, name, title, sortorder, datatype, `handler`, vardatatype 
) 
select * 
from ( 
  select 
    concat(a.objid, '-', b.name) as objid, a.objid as parentid, 
    b.name, b.title, b.sortorder, b.datatype, b.`handler`, b.vardatatype 
  from 
    (
      select * from sys_rule_fact 
      where factclass = 'bpls.facts.BillItem'
    )a, 
    ( 
      select 
        'totalav' as name, 'Assessed Value' as title, 11 as sortorder, 
        'decimal' as datatype, 'decimal' as `handler`, 'decimal' as vardatatype 
    )b 
)t0 
where (
  select count(*) from sys_rule_fact_field 
  where parentid = t0.parentid and name = t0.name 
) = 0 
;




-- ## 2023-02-03

drop table if exists vw_remittance_eor 
;
drop view if exists vw_remittance_eor 
;
create view vw_remittance_eor as 
select 
  r.objid AS remittance_objid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  c.remittanceid AS remittanceid, 
  'serial' AS formtype, 
  0 AS formtypeindexno, 
  'EOR' AS formno, 
  (case 
    when c.receiptno like 'EOR%' then substring(c.receiptno,4) 
    else c.receiptno 
  end) as series, 
  c.receiptno AS receiptno, 
  c.receiptdate AS receiptdate, 
  c.amount AS amount, 
  0 AS voided, 
  0.0 AS voidamount, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.payer_objid AS payer_objid, 
  'eor' AS collector_objid, 
  c.objid AS receiptid, 
  c.txntype AS collectiontype_objid, 
  po.txntypename AS collectiontype_name, 
  po.locationid AS org_objid, 
  org.name as org_name 
from eor.eor_remittance r 
  inner join eor.eor c on c.remittanceid = r.objid 
  left join eor.eor_paymentorder_paid po on po.objid = c.paymentrefid 
  left join sys_org org on org.objid = po.locationid 
;

drop table if exists vw_remittance_eoritem
;
drop view if exists vw_remittance_eoritem
;
create view vw_remittance_eoritem as 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.state as remittance_state,
  c.txntype AS collectiontype_objid, 
  po.txntypename AS collectiontype_name, 
  po.locationid AS org_objid, 
  org.name as org_name, 
  'serial' AS formtype, 
  'EOR' AS formno, 
  0 AS formtypeindex, 
  c.objid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  'EOR' AS collectorid, 
  ci.item_fund_objid AS fundid, 
  ci.item_objid AS acctid, 
  ci.item_code AS acctcode, 
  ci.item_title AS acctname, 
  ci.remarks AS remarks, 
  ci.amount as amount, 
  0 AS voided, 0.0 AS voidamount  
from eor.eor_remittance r 
  inner join eor.eor c on c.remittanceid = r.objid 
  inner join eor.eor_item ci on ci.parentid = c.objid 
  left join eor.eor_paymentorder_paid po on po.objid = c.paymentrefid 
  left join sys_org org on org.objid = po.locationid 
;

drop table if exists vw_remittance_eorshare
;
drop view if exists vw_remittance_eorshare
;
create view vw_remittance_eorshare as 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.state as remittance_state,
  c.txntype AS collectiontype_objid, 
  po.txntypename AS collectiontype_name, 
  po.locationid AS org_objid, 
  org.name as org_name, 
  'serial' AS formtype, 
  'EOR' AS formno, 
  0 AS formtypeindex, 
  c.objid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  'EOR' AS collectorid, 
  ci.receiptitemid as receiptitemid, 
  ci.refitem_objid AS refacctid, 
  ci.refitem_fund_objid AS reffundid, 
  ci.payableitem_fund_objid AS fundid, 
  ci.payableitem_objid AS acctid, 
  ci.payableitem_code AS acctcode, 
  ci.payableitem_title AS acctname, 
  null as remarks, 
  ci.amount as amount, 
  0 AS voided, 0.0 AS voidamount  
from eor.eor_remittance r 
  inner join eor.eor c on c.remittanceid = r.objid 
  inner join eor.eor_share ci on ci.parentid = c.objid 
  left join eor.eor_paymentorder_paid po on po.objid = c.paymentrefid 
  left join sys_org org on org.objid = po.locationid 
;




-- ## 2023-02-27

update 
  sys_rule_fact_field aa, 
  ( 
    select ff.objid, 'assessmenttype' as name 
    from sys_rule_fact f, sys_rule_fact_field ff 
    where f.factclass = 'bpls.facts.BillItem' 
      and ff.parentid = f.objid 
      and ff.name = 'asssessmenttype'
  )bb 
set aa.name = bb.name 
where aa.objid = bb.objid 
;
