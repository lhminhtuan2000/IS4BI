/*
7. Thống kê Số ca nhiễm, số ca tử vong
theo từng loại phơi nhiễm
trong từng năm.
*/

CREATE
--ALTER 
PROCEDURE GetYearRange @res NVARCHAR(MAX) OUT
AS
DECLARE 
    @columns NVARCHAR(MAX) = ''

-- select the year
SELECT @columns += QUOTENAME(t.year) +','
FROM
(
SELECT DISTINCT dd.[year] AS year
FROM dim_date dd
INNER JOIN fact_cases f ON dd.id = f.date_id
) AS t
ORDER BY year

-- remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);
-- return result
SET @res = @columns

GO
DECLARE
    @columns NVARCHAR(MAX),
    @sql     NVARCHAR(MAX) = '';
EXEC GetYearRange @columns output
-- construct dynamic SQL
SET @sql ='
SELECT * FROM   
(
    SELECT 
        de.exposure AS EXPOSURE_NAME, 
        dd.year,
        f.total_cases
    FROM 
        fact_cases f
        INNER JOIN dim_exposure de
            ON f.exposure_id = de.id
        INNER JOIN dim_date dd
            ON f.date_id = dd.id
) t 
PIVOT(
    SUM(total_cases) 
    FOR year IN ('+ @columns +')
) AS pivot_table;';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;
