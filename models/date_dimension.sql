{{ config(materialized='table') }}

with CTE as (
    select 
    TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
    DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
    HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,
    {{day_type('STARTED_AT')}} AS DAY_TYPE,
    {{get_season('STARTED_AT')}} AS SEASON_OF_THE_YEAR

    from {{ ref('stg_bike') }}
    where UPPER(TRIM(STARTED_AT)) != 'STARTED_AT'
      and TRIM(STARTED_AT) != ''
      and STARTED_AT is not null
      and TRY_TO_TIMESTAMP(STARTED_AT) is not null
)

select 
    *
from CTE
order by DATE_STARTED_AT desc 