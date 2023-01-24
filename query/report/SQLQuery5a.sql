/*
5a. Thống kê số ca nhiễm, tử vong 
theo Mức Độ Nghiêm Trọng, 
khu vực (PHU_Group, City)
*/

SELECT
    dg.[name],
    dc.[name],
    CASE
        WHEN SUM(total_cases) < 10 THEN 1
        WHEN SUM(total_cases) < 50 THEN 2
        WHEN SUM(total_cases) < 100 THEN 3
        WHEN SUM(total_cases) < 500 THEN 4
        WHEN SUM(total_cases) < 1000 THEN 5
        ELSE 6
    END AS 'SEVERITY',
    SUM(total_cases) AS 'TOTAL_CASES',
    SUM(total_fatal_cases) AS 'TOTAL_FATAL_CASES'
FROM (covid_dds.dbo.fact_cases f 
    INNER JOIN covid_dds.dbo.dim_phu dp ON f.phu_id = dp.id
    INNER JOIN covid_dds.dbo.dim_phu_city dc ON dp.phu_city_id = dc.id
    INNER JOIN covid_dds.dbo.dim_phu_group dg ON dc.phu_group_id = dg.id)
GROUP BY 
    grouping sets((dg.[name],dc.[name]))
ORDER BY dg.[name],dc.[name]
