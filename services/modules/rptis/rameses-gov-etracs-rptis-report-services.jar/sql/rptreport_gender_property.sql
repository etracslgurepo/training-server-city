[getSummaries]
select 
	taxpayer_type,
	count(*) as count 
from vw_report_gender_property
where state = 'CURRENT' 
group by taxpayer_type
order by typeid