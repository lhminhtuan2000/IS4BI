/*
Thống kê số ca nhiễm, tử vong 
theo Mức Độ Nghiêm Trọng 
theo Ngày Trong Tháng của các năm
*/
select t.year, sum(t.Number) as 'total'
from
	(select [phu_id],
		[vba_age_group_id],
		dd.[year],
		max([at_least_one_dose_cumulative]) as 'Number'
	from [covid_dds].[dbo].[fact_vaccines] inner join dim_date dd on dd.id = date_id
	group by [phu_id],[vba_age_group_id],dd.[year]) as t
group by t.year