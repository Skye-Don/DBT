{{
    config(
        materialized='table'
    )
}}

WITH CTE AS (
    select 
    t.*,
    w.*
    from {{ ref('trip_fact') }} t
    left join {{ ref('daily_weather') }} w
    on t.TRIP_DATE = w.daily_weather
    limit 10
)

select *
from CTE