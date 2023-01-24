/*
2. Thống kê Mức Độ Nghiêm Trọng (tiêu chí nghiêm trọng sinh viên tự định nghĩa) của dịch Covid-19 
theo PHU và 
theo các Quý trong từng năm.
*/

SELECT
    dp.name AS 'PHU_NAME',
    dd.[quarter_in_year] AS 'QUARTER',
    dd.[year] AS 'YEAR',
    SUM(total_cases) AS 'TOTAL_CASES',
    CASE
        WHEN SUM(total_cases) < 10 THEN 1
        WHEN SUM(total_cases) < 50 THEN 2
        WHEN SUM(total_cases) < 100 THEN 3
        WHEN SUM(total_cases) < 500 THEN 4
        WHEN SUM(total_cases) < 1000 THEN 5
        ELSE 6
    END AS 'SEVERITY'
FROM ((covid_dds.dbo.fact_cases f 
    INNER JOIN covid_dds.dbo.dim_phu dp ON f.phu_id = dp.id)
    INNER JOIN covid_dds.dbo.dim_date dd ON f.date_id = dd.id)
GROUP BY 
    dp.name,
    grouping sets((dd.[year], dd.[quarter_in_year]))
ORDER BY dp.name, dd.[year], dd.[quarter_in_year]
