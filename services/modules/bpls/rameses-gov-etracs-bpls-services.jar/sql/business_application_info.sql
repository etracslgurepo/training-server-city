[getAppInfos]
SELECT bi.*, 
b.caption  AS attribute_caption, 
b.datatype AS attribute_datatype, 
b.sortorder AS attribute_sortorder,
b.category AS attribute_category,
b.handler AS attribute_handler
FROM business_application_info bi 
INNER JOIN businessvariable b ON b.objid=bi.attribute_objid
WHERE bi.applicationid=$P{applicationid} AND bi.type = 'appinfo'
ORDER BY b.category, b.sortorder 

[getAssessmentInfos]
SELECT bi.*, 
	b.caption  AS attribute_caption, 
	b.datatype AS attribute_datatype, 
	b.sortorder AS attribute_sortorder,
	b.category AS attribute_category,
	b.handler AS attribute_handler
FROM business_application_info bi 
	INNER JOIN businessvariable b ON b.objid=bi.attribute_objid
WHERE bi.applicationid=$P{applicationid} 
	AND bi.type = 'assessmentinfo'
ORDER BY b.category, b.sortorder 

[removeAppInfos]
DELETE FROM business_application_info WHERE applicationid=$P{applicationid} AND type = 'appinfo'

[removeAssessmentInfos]
DELETE FROM business_application_info WHERE applicationid=$P{applicationid} AND type = 'assessmentinfo'

[getInfos]
select 
	bai.*, 
	ifnull((
		select assessmenttype from business_application_lob 
		where applicationid = bai.applicationid and lobid = bai.lob_objid 
		limit 1 
	), (case 
		when a.apptype = 'ADDITIONAL' then 'NEW'
		when a.apptype = 'RETIRELOB' then 'RETIRE'
		else a.apptype 
	end)) as assessmenttype, 
	v.datatype as attribute_datatype 
from business_application_info bai 
	inner join business_application a on a.objid = bai.applicationid 
	left join businessvariable v on v.objid = bai.attribute_objid 
where bai.applicationid = $P{applicationid} 
order by bai.activeyear, bai.type, bai.attribute_name 
