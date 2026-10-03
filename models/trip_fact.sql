{{ config(materialized='table') }}

WITH BIKE as(
    select
        RIDE_ID,
        RIDE_TYPE,
        TO_TIMESTAMP(STARTED_AT) AS TRIP_DATE,
        START_STATION_ID AS START_STATION_ID,
        END_STATION_ID,
        MEMBER_CASUAL AS MEMBER_CASUAL,
        TIMESTAMPDIFF(SECOND, TO_TIMESTAMP(STARTED_AT), TO_TIMESTAMP(ENDED_AT)) AS TRIP_DURATION_SECONDS

    from {{source('demo', 'bike')}}
    where RIDE_ID != 'ride_id'

    limit 10
)

select 
*
from BIKE