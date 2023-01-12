use covid_nds
go

select REPLACE(phu_group_name, 'West', 'East')
from phu_group

-- [OLE DB Destination [75]] Error: An error occurred while setting up a binding for the 'outcome' column. 
-- The binding status was 'DT_TEXT'. The data flow column type is 'DBBINDSTATUS_UNSUPPORTEDCONVERSION'. 
-- The conversion from the OLE DB type of 'DBTYPE_IUNKNOWN' to the destination column type of 'DBTYPE_VARCHAR' might not 
-- be supported by this provider.

SELECT CAST(REPLACE('2020/03/23 12:00:00',' 12:00:00+00', '') as datetime) as 'as'

SELECT REPLACE('2020/03/23 12:00:00',' 12:00:00+00', '')


use covid_stage
UPDATE public_health_unit
SET [reporting_phu] =  REPLACE(
    REPLACE(
        REPLACE(
            REPLACE( 
                [reporting_phu], 
                'Health Unit', 
                'Public Health'
            ), ' &', ','
        ), ' and', ','
    ), ' District', ''
)

select * from public_health_unit


UPDATE cases_report
SET case_acquisition_info = 'CLOSE CONTACT'
WHERE case_acquisition_info = 'CC'
GO

UPDATE cases_report
SET case_acquisition_info = 'OUTBREAK'
WHERE case_acquisition_info = 'OB'
GO

UPDATE cases_report
SET case_acquisition_info = 'TRAVEL-RELATED'
WHERE case_acquisition_info = 'TRAVEL'
GO

UPDATE compiled_covid_19_case_details
SET exposure = UPPER(exposure)

-- -----------------------------------------------

UPDATE cases_report
SET age = '80+'
WHERE age = '80s' OR age = '90+'
GO

UPDATE cases_report
SET age = '20-29'
WHERE age = '20s'
GO

UPDATE cases_report
SET age = '30-39'
WHERE age = '30s'
GO

UPDATE cases_report
SET age = '40-49'
WHERE age = '40s'
GO

UPDATE cases_report
SET age = '50-59'
WHERE age = '50s'
GO

UPDATE cases_report
SET age = '70-79'
WHERE age = '70s'
GO

use covid_nds
DELETE FROM [vaccines_by_age_phu]
DELETE FROM [ongoing_outbreaks_phu]
DELETE FROM [outbreak_group]
DELETE FROM [vba_age_group]

DELETE FROM [case]

DELETE FROM [public_health_unit]
DELETE FROM [phu_city]
DELETE FROM [phu_group]
DELETE FROM [outcome]
DELETE FROM [exposure]
DELETE FROM [age_group]
DBCC SHRINKDATABASE (covid_nds, 0);
GO