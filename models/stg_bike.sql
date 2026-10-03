{{
    config(
        materialized='table'
    )
}}

WITH BIKE AS (
    select 
        RIDE_ID,
        USER_TYPE,
        REPLACE(STARTED_AT,'"','') AS STARTED_AT,
        REPLACE(ENDED_AT,'"','') AS ENDED_AT,
        START_STATION_NAME,
        START_STATION_ID,
        END_STATION_NAME,
        END_STATION_ID,
        START_LAT,
        START_LNG,
        END_LAT,
        END_ING,
        GENDER
    from {{ source('demo', 'bike_new') }}
    where RIDE_ID != 'bikeid' and STARTED_AT != '"startime"' and STARTED_AT != 'startime'
)

select 
*
from BIKE