/*
1. Thống kê Số ca nhiễm, số ca tử vong, số ca phục hồi của dịch Covid-19 
theo từng PHU 
trong từng năm.
*/

SELECT
    dp.name AS 'phu_name', dd.[year],
    SUM(f.total_cases) AS 'total_cases',
    SUM(f.total_fatal_cases) AS 'total_fatal_cases',
    SUM(f.total_resolved_cases) AS 'total_resolved_cases'
FROM ((covid_dds.dbo.fact_cases f 
    INNER JOIN covid_dds.dbo.dim_phu dp ON f.phu_id = dp.id)
    INNER JOIN covid_dds.dbo.dim_date dd ON f.date_id = dd.id)
GROUP BY GROUPING SETS
(
(dp.name, dd.[year])--,(dp.name)
)
ORDER BY dp.name, dd.[year]
