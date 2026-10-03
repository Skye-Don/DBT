{{ config(materialized='table') }}

WITH BIKE as(
    select
        RIDE_ID,
        USER_TYPE,
        DATE(TRY_TO_TIMESTAMP(STARTED_AT, 'MM/DD/YYYY HH24:MI')) AS TRIP_DATE,
        START_STATION_ID AS START_STATION_ID,
        END_STATION_ID AS END_STATION,
        TIMESTAMPDIFF(
            SECOND,
            TRY_TO_TIMESTAMP(STARTED_AT, 'MM/DD/YYYY HH24:MI'),
            TRY_TO_TIMESTAMP(ENDED_AT, 'MM/DD/YYYY HH24:MI')
        ) AS TRIP_DURATION_SECONDS

    from {{ ref('stg_bike') }}
    where RIDE_ID != 'ride_id'
    and TRY_TO_TIMESTAMP(STARTED_AT, 'MM/DD/YYYY HH24:MI') IS NOT NULL
    and TRY_TO_TIMESTAMP(ENDED_AT, 'MM/DD/YYYY HH24:MI') IS NOT NULL

)

select 
*
from BIKE