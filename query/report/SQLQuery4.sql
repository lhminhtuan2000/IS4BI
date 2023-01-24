/*
4. Thống kê số ca nhiễm, tử vong 
theo Mức Độ Nghiêm Trọng
theo Ngày Trong Tháng 
của các năm.
*/

SELECT
    dd.[day_in_month] AS 'DAY',
    dd.[month_in_year] AS 'MONTH',
    dd.[year] AS 'YEAR',
    CASE
        WHEN SUM(total_cases) < 10 THEN 1
        WHEN SUM(total_cases) < 50 THEN 2
        WHEN SUM(total_cases) < 100 THEN 3
        WHEN SUM(total_cases) < 500 THEN 4
        WHEN SUM(total_cases) < 1000 THEN 5
        ELSE 6
    END AS 'SERIOUS_LEVEL',
    SUM(total_cases) AS 'TOTAL_CASES',
    SUM(total_fatal_cases) AS 'TOTAL_FATAL_CASES'
FROM (covid_dds.dbo.fact_cases f 
    INNER JOIN covid_dds.dbo.dim_date dd ON f.date_id = dd.id)
GROUP BY
    grouping sets((dd.[year],dd.[month_in_year],dd.[day_in_month]))
ORDER BY dd.[year],dd.[month_in_year],dd.[day_in_month]
