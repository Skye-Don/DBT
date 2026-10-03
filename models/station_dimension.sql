{{ config(materialized='table') }}
WITH BIKE as(
    select
        distinct start_station_id AS station_id,
        start_station_name AS sation_name,
        start_lat AS start_lat,
        start_lng AS start_lng
    from {{ ref('stg_bike') }}
    where RIDE_ID != 'ride_id'

)

select 
*
from BIKE