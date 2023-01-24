/*
3. Thống kê tổng số người tử vong 
theo Giới Tính và Nhóm Tuổi 
theo các năm.
*/

SELECT
    dg.[gender],
    dag.[age_group],
    dd.[year],
    SUM(total_fatal_cases) AS 'TOTAL_FATAL_CASES'
FROM (covid_dds.dbo.fact_cases f 
    INNER JOIN covid_dds.dbo.dim_age_group dag ON f.[age_group_id] = dag.[id]
    INNER JOIN covid_dds.dbo.dim_gender dg ON f.[gender_id] = dg.[id]
    INNER JOIN covid_dds.dbo.dim_date dd ON f.[date_id] = dd.[id])
GROUP BY
    grouping sets((dg.[gender],dag.[age_group],dd.[year]))
ORDER BY
    dd.[year]
