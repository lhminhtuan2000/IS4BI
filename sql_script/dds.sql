-- USE tempdb
-- GO
-- DROP DATABASE covid_dds
-- GO

CREATE DATABASE covid_dds
GO
USE covid_dds
GO


CREATE TABLE dim_exposure 
(
    id INT IDENTITY,
    
    nds_id INT,
    
    source_id INT,
    exposure NVARCHAR(255),

    CONSTRAINT pk__dim_exposure PRIMARY KEY (id)
)
GO




CREATE TABLE dim_date
(
    id INT IDENTITY,
    
    day_in_month INT,
    month_in_year INT,
    quarter_in_year INT,
    [year] INT,

    CONSTRAINT pk__dim_date PRIMARY KEY (id)
)
GO


CREATE TABLE dim_gender
(
    id INT IDENTITY,

    gender NVARCHAR(255),

    CONSTRAINT pk__dim_gender PRIMARY KEY (id)
)
GO


CREATE TABLE dim_age_group
(
    id INT IDENTITY,

    nds_id INT,

    source_id INT,
    age_group NVARCHAR(255),

    CONSTRAINT pk__dim_age_group PRIMARY KEY (id)
)
GO


CREATE TABLE dim_vba_age_group
(
    id INT IDENTITY,

    nds_id INT,

    source_id INT,
    age_group NVARCHAR(255),

    CONSTRAINT pk__dim_vba_age_group PRIMARY KEY (id)
)
GO


CREATE TABLE dim_phu
(
    id INT IDENTITY,

    nds_id INT,

    phu_nk INT,
    source_id INT,
    [name] NVARCHAR(255),
    [address] NVARCHAR(255),
    phu_city_id INT,
    postal_code NVARCHAR(255),
    website NVARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,

    CONSTRAINT pk__dim_phu PRIMARY KEY (id)
)
GO


CREATE TABLE dim_phu_city
(
    id INT IDENTITY,

    nds_id INT,

    source_id INT,
    [name] NVARCHAR(255),
    phu_group_id INT,

    CONSTRAINT pk__dim_phu_city PRIMARY KEY (id)
)
GO


CREATE TABLE dim_phu_group
(
    id INT IDENTITY,

    nds_id INT,

    source_id INT,
    [name] NVARCHAR(255)

    CONSTRAINT pk__dim_phu_group PRIMARY KEY (id)
)
GO


CREATE TABLE fact_cases
(
    phu_id INT,
    exposure_id INT,
    gender_id INT,
    age_group_id INT,
    date_id INT,
    total_cases INT,
    total_fatal_cases INT,
    total_resolved_cases INT,
    severity INT,

    CONSTRAINT pk__fact_cases PRIMARY KEY (phu_id, exposure_id, gender_id, age_group_id, date_id)
)
GO


CREATE TABLE fact_vaccines
(
    phu_id INT,
    vba_age_group_id INT,
    date_id INT,
    at_least_one_dose_cumulative INT,
    second_dose_cumulative INT,
    fully_vaccinated_cumulative INT,
    third_dose_cumulative INT


    CONSTRAINT pk__fact_vaccines PRIMARY KEY (phu_id, vba_age_group_id, date_id)
)
GO


-- Generate dim_date table
GO
DECLARE @StartDate  date = '20200101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 3, @StartDate));

;WITH seq(n) AS 
(
    SELECT 0 UNION ALL SELECT n + 1 FROM seq
    WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
    SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
    SELECT
        TheDate         = CONVERT(date, d),
        TheDay          = DATEPART(DAY,       d),
        TheMonth        = DATEPART(MONTH,     d),
        TheQuarter      = DATEPART(Quarter,   d),
        TheYear         = DATEPART(YEAR,      d)
    FROM d
),
dim AS
(
    SELECT
        TheDate, 
        TheDay,
        TheMonth,
        TheQuarter,
        TheYear
    FROM src
)

INSERT INTO dim_date(day_in_month,month_in_year,quarter_in_year,year)
SELECT TheDay,TheMonth,TheQuarter,TheYear FROM dim
    ORDER BY TheDate
    OPTION (MAXRECURSION 0);

GO


-- Add Foreign key

ALTER TABLE dim_phu
    ADD CONSTRAINT fk__dim_phu__dim_phu_city FOREIGN KEY (phu_city_id)
    REFERENCES dim_phu_city (id)
GO


ALTER TABLE dim_phu_city
    ADD CONSTRAINT fk__dim_phu_city__dim_phu_group FOREIGN KEY (phu_group_id)
    REFERENCES dim_phu_group (id)
GO


ALTER TABLE fact_cases
    ADD CONSTRAINT fk__fact_cases__dim_phu FOREIGN KEY (phu_id)
    REFERENCES dim_phu (id)
ALTER TABLE fact_cases
    ADD CONSTRAINT fk__fact_cases__dim_exposure FOREIGN KEY (exposure_id)
    REFERENCES dim_exposure (id)
ALTER TABLE fact_cases
    ADD CONSTRAINT fk__fact_cases__dim_date FOREIGN KEY (date_id)
    REFERENCES dim_date (id)
ALTER TABLE fact_cases
    ADD CONSTRAINT fk__fact_cases__dim_gender FOREIGN KEY (gender_id)
    REFERENCES dim_gender (id)
ALTER TABLE fact_cases
    ADD CONSTRAINT fk__fact_cases__dim_age_group FOREIGN KEY (age_group_id)
    REFERENCES dim_age_group (id)
GO


ALTER TABLE fact_vaccines
    ADD CONSTRAINT fk__fact_vaccines__dim_phu FOREIGN KEY (phu_id)
    REFERENCES dim_phu (id)
ALTER TABLE fact_vaccines
    ADD CONSTRAINT fk__fact_vaccines__dim_date FOREIGN KEY (date_id)
    REFERENCES dim_date (id)
ALTER TABLE fact_vaccines
    ADD CONSTRAINT fk__fact_vaccines__dim_vba_age_group FOREIGN KEY (vba_age_group_id)
    REFERENCES dim_vba_age_group (id)
GO