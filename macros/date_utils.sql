
{% macro get_season(x) %}

CASE WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (12, 1, 2)
    THEN 'Winter'
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (3, 4, 5)
    THEN 'Spring'
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (6, 7, 8)
    THEN 'Summer'
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (9, 10, 11)
    THEN 'Automn'
ELSE 'ERROR'
END

{% endmacro %}

{% macro day_type(x)%}

CASE WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) in ('Sat', 'Sun')
THEN 'Weekend'
ELSE 'Business Day'
END 

{% endmacro %}