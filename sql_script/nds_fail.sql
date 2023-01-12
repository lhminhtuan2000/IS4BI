-- use tempdb
-- go
-- Drop DATABASE covid_nds_fail
-- GO
CREATE DATABASE covid_nds_fail
GO
USE covid_nds_fail
GO

-- DROP TABLE [vaccines_by_age_phu]
-- DROP TABLE [ongoing_outbreaks_phu]
-- DROP TABLE [outbreak_group]
-- DROP TABLE [case]
-- DROP TABLE [public_health_unit]
-- DROP TABLE [phu_city]
-- DROP TABLE [phu_group]
-- DROP TABLE [vba_age_group]
-- DROP TABLE [outcome]
-- DROP TABLE [exposure]
-- DROP TABLE [age_group]
-- DROP TABLE [source]



CREATE TABLE [phu_city]
(
    id INT,
    error_description NVARCHAR(255),
    [name] NVARCHAR(255),
    phu_group_id INT,

    source_id INT,

    CONSTRAINT pk__phu_city PRIMARY KEY (id)
)
GO


CREATE TABLE [phu_group]
(
    id INT,
    error_description NVARCHAR(255),
    phu_group_name NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__phu_group PRIMARY KEY (id)
)
GO


CREATE TABLE [outbreak_group]
(
    id INT,
    outbreak_group NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__outbreak_group PRIMARY KEY (id)
)
GO


CREATE TABLE [ongoing_outbreaks_phu]
(
    id INT,
    error_description NVARCHAR(255),
    
    [date] DATE,
    phu_id INT,
    outbreak_group_id INT,
    source_id INT,
    
    number_ongoing_outbreaks INT,

    CONSTRAINT pk__ongoing_outbreaks_phu PRIMARY KEY (id)
)
GO


CREATE TABLE [vaccines_by_age_phu] 
(
    id INT,
    error_description NVARCHAR(255),
    
    [date] DATE,
    phu_id INT,
    age_group_id INT,
    source_id INT,

    at_least_one_dose_cumulative INT,
    second_dose_cumulative INT,
    fully_vaccinated_cumulative INT,
    third_dose_cumulative INT

    CONSTRAINT pk__vaccines_by_age_phu PRIMARY KEY (id)
)
GO


CREATE TABLE [vba_age_group]
(
    id INT,
    error_description NVARCHAR(255),
    source_id INT, 
    age_group NVARCHAR(255),

    CONSTRAINT pk__vba_age_group PRIMARY KEY (id)
)
GO


CREATE TABLE [outcome]
(
    id INT,
    error_description NVARCHAR(255),
    outcome NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__outcome PRIMARY KEY (id)
)
GO


CREATE TABLE [exposure]
(
    id INT,
    error_description NVARCHAR(255),
    exposure NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__exposure PRIMARY KEY (id)
)
GO


CREATE TABLE [age_group]
(
    id INT,
    error_description NVARCHAR(255),
    age_group NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__age_group PRIMARY KEY (id)
)
GO


CREATE TABLE [case] 
(
    id INT,
    error_description NVARCHAR(255),
    
    case_nk INT,
    source_id INT,
    
    reported_date DATE,
    reporting_phu_id INT,
    gender NVARCHAR(255),
    age_group_id INT,
    exposure_id INT,
    outcome_id INT

    CONSTRAINT pk__case PRIMARY KEY (id)
)   
GO


CREATE TABLE [public_health_unit]
(
    id INT,
    error_description NVARCHAR(255),
    
    phu_nk INT,
    source_id INT,
    
    [name] NVARCHAR(255),
    [address] NVARCHAR(255),
    phu_city_id INT,
    postal_code NVARCHAR(255),
    website NVARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,

    CONSTRAINT pk__public_health_unit PRIMARY KEY (id)
)
GO
