{{ config(materialized='table') }}

with daily_weather as (

    select 
    date(time) as date,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    from {{source('demo', 'weather')}}
),

daily_weather_aggregate as (
    select 
    date,
    weather,
    round(avg(temp), 2) as avg_temp,
    round(avg(pressure), 2) as avg_pressure,
    round(avg(humidity), 2) as avg_humidity,
    round(avg(clouds), 2) as avg_clouds
    from daily_weather
    group by date, weather

    qualify row_number() over (partition by date order by count(weather) desc) = 1
)

select *
from daily_weather_aggregate
order by date desc