-- USE tempdb
-- GO

-- DROP DATABASE covid_stage
-- GO

-- DROP TABLE cases_report
-- DROP TABLE compiled_covid_19_case_details
-- DROP TABLE ongoing_outbreadks_phu
-- DROP TABLE public_health_unit
-- DROP TABLE public_health_units_group
-- DROP TABLE vaccines_by_age_phu

CREATE DATABASE covid_stage
GO

USE covid_stage
GO


CREATE TABLE cases_report
(
    id INT IDENTITY,
    outcome NVARCHAR(255),
    age NVARCHAR(255),
    gender NVARCHAR(255),
    reporting_phu NVARCHAR(255),
    specimen_date DATE,
    casereported_date DATE,
    test_reported_date DATE,
    accurate_episode_dt DATE,
    case_acquisition_info NVARCHAR(255),
    phu_city NVARCHAR(255),
    phu_address NVARCHAR(255),
    phu_website NVARCHAR(255),
    outbreak_related NVARCHAR(255),
    phu_latitude FLOAT,
    phu_longitude FLOAT,
    phu_postal_code NVARCHAR(255)
)
GO


CREATE TABLE compiled_covid_19_case_details
(
    object_id INT,
    row_id INT,
    date_reported DATETIME,
    health_region NVARCHAR(255),
    age_group NVARCHAR(255),
    gender NVARCHAR(255),
    exposure NVARCHAR(255),
    case_status NVARCHAR(255),
    provine NVARCHAR(255)
)
GO


CREATE TABLE ongoing_outbreadks_phu
(
    date DATE,
    phu_num INT,
    outbreak_group NVARCHAR(255),
    number_ongoing_outbreaks INT
)
GO


CREATE TABLE public_health_unit
(
    phu_id INT,
    reporting_phu NVARCHAR(255),
    reporting_phu_address NVARCHAR(255),
    Reporting_PHU_City NVARCHAR(255),
    Reporting_PHU_Postal_Code NVARCHAR(255),
    Reporting_PHU_Website NVARCHAR(255),
    Reporting_PHU_Latitude FLOAT,
    Reporting_PHU_Longitude FLOAT
)
GO


CREATE TABLE public_health_units_group
(
    phu_group NVARCHAR(255),
    phu_city NVARCHAR(255),
    phu_region NVARCHAR(255)
)
GO


CREATE TABLE vaccines_by_age_phu
(
    date DATE,
    phu_id INT,
    age_group NVARCHAR(255),
    at_least_one_dose_cumulative INT,
    Second_dose_cumulative INT,
    fully_vaccinated_cumulative INT,
    third_dose_cumulative INT,
)

