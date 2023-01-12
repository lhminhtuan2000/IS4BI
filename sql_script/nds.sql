-- use tempdb
-- go
-- Drop DATABASE covid_nds
-- GO
CREATE DATABASE covid_nds
GO
USE covid_nds
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
    id INT IDENTITY,
    [name] NVARCHAR(255),
    phu_group_id INT,

    source_id INT,

    CONSTRAINT pk__phu_city PRIMARY KEY (id)
)
GO


CREATE TABLE [phu_group]
(
    id INT IDENTITY,
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
    id INT IDENTITY,
    
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
    id INT IDENTITY,
    
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
    id INT IDENTITY,
    source_id INT, 
    age_group NVARCHAR(255),

    CONSTRAINT pk__vba_age_group PRIMARY KEY (id)
)
GO


CREATE TABLE [outcome]
(
    id INT IDENTITY,
    outcome NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__outcome PRIMARY KEY (id)
)
GO


CREATE TABLE [exposure]
(
    id INT IDENTITY,
    exposure NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__exposure PRIMARY KEY (id)
)
GO


CREATE TABLE [age_group]
(
    id INT IDENTITY,
    age_group NVARCHAR(255),

    source_id INT,

    CONSTRAINT pk__age_group PRIMARY KEY (id)
)
GO


CREATE TABLE [case] 
(
    id INT IDENTITY,
    
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
    id INT IDENTITY,
    
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


CREATE TABLE [source]
(
    id INT IDENTITY,
    name NVARCHAR(255),

    CONSTRAINT pk__source PRIMARY KEY (id)
)
GO


ALTER TABLE [case]
    ADD CONSTRAINT fk__case__outcome
    FOREIGN KEY (outcome_id) REFERENCES outcome (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__exposure
    FOREIGN KEY (exposure_id) REFERENCES exposure (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__age_group
    FOREIGN KEY (age_group_id) REFERENCES age_group (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__public_health_unit
    FOREIGN KEY (reporting_phu_id) REFERENCES public_health_unit (id)
ALTER TABLE [case]
    ADD CONSTRAINT fk__case__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [phu_city]
    ADD CONSTRAINT fk__phu_city__phu_group
    FOREIGN KEY (phu_group_id) REFERENCES phu_group (id)
ALTER TABLE [phu_city]
    ADD CONSTRAINT fk__phu_city_phu__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [ongoing_outbreaks_phu]
    ADD CONSTRAINT fk__ongoing_outbreaks_phu__outbreak_group
    FOREIGN KEY (outbreak_group_id) REFERENCES outbreak_group (id)
ALTER TABLE [ongoing_outbreaks_phu]
    ADD CONSTRAINT fk__ongoing_outbreaks_phu__public_health_unit
    FOREIGN KEY (phu_id) REFERENCES public_health_unit (id)
ALTER TABLE [ongoing_outbreaks_phu]
    ADD CONSTRAINT fk__ongoing_outbreaks_phu__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [public_health_unit]
    ADD CONSTRAINT fk__public_health_unit__phu_city
    FOREIGN KEY (phu_city_id) REFERENCES phu_city (id)
ALTER TABLE [public_health_unit]
    ADD CONSTRAINT fk__public_health_unit__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [vaccines_by_age_phu]
    ADD CONSTRAINT fk__vaccines_by_age_phu__public_health_unit
    FOREIGN KEY (phu_id) REFERENCES public_health_unit (id)
ALTER TABLE [vaccines_by_age_phu]
    ADD CONSTRAINT fk__vaccines_by_age_phu__vba_age_group
    FOREIGN KEY (age_group_id) REFERENCES vba_age_group (id)
ALTER TABLE [vaccines_by_age_phu]
    ADD CONSTRAINT fk__vaccines_by_age_phu__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [phu_group]
    ADD CONSTRAINT fk__phu_group__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [outbreak_group]
    ADD CONSTRAINT fk__outbreak_group__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [outcome]
    ADD CONSTRAINT fk__outcome__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [exposure]
    ADD CONSTRAINT fk__exposure__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [age_group]
    ADD CONSTRAINT fk__age_group__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO


ALTER TABLE [vba_age_group]
    ADD CONSTRAINT fk__vba_age_group__source
    FOREIGN KEY (source_id) REFERENCES source (id)
GO
----------------------------------------------------------


INSERT INTO source (name) VALUES ('Cases Report.csv')
INSERT INTO source (name) VALUES ('Compiled_COVID-19_Case_Details_Canada.csv')
INSERT INTO source (name) VALUES ('ongoing_outbreaks_phu.csv')
INSERT INTO source (name) VALUES ('Public health unit.csv')
INSERT INTO source (name) VALUES ('Public Health Units GROUP.csv')
INSERT INTO source (name) VALUES ('vaccines_by_age_phu.csv')

SET IDENTITY_INSERT phu_group  ON
GO
INSERT INTO phu_group 
    (id, phu_group_name, source_id) 
    VALUES
    (0, 'PHU groups outside Ontario', 2)
SET IDENTITY_INSERT phu_group  OFF
GO

SET IDENTITY_INSERT phu_city  ON
GO
INSERT INTO phu_city 
    (id, [name], phu_group_id, source_id) 
    VALUES
    (0, 'Cities outside Ontario', 0, 2)
GO
SET IDENTITY_INSERT phu_city  OFF
GO
-- DELETE FROM phu_city
-- DELETE FROM phu_group
-- DELETE FROM outbreak_group
-- DELETE FROM ongoing_outbreaks_phu
-- DELETE FROM vaccines_by_age_phu
-- DELETE FROM outcome
-- DELETE FROM exposure
-- DELETE FROM age_group
-- DELETE FROM [case]
-- DELETE FROM public_health_unit
-- DELETE FROM source [OLE DB Destination [52]] Error: SSIS Error Code DTS_E_INDUCEDTRANSFORMFAILUREONERROR.  The "OLE DB Destination.Inputs[OLE DB Destination Input]" failed because error code 0xC020907B occurred, and the error row disposition on "OLE DB Destination.Inputs[OLE DB Destination Input]" specifies failure on error. An error occurred on the specified object of the specified component.  There may be error messages posted before this with more information about the failure.
