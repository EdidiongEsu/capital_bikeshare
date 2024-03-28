{# get distance from cordinates if non of either longitude, latitude are null #}

{% macro distance_from_cordinates(start_longitude, start_latitude, end_longitude, end_latitude) %}
    CASE
        WHEN {{ start_longitude }} IS NOT NULL AND {{ start_latitude }} IS NOT NULL AND {{ end_longitude }} IS NOT NULL AND {{ end_latitude }} IS NOT NULL
        THEN ST_DISTANCE(ST_GEOGPOINT({{ start_longitude }}, {{ start_latitude }}), ST_GEOGPOINT({{ end_longitude }}, {{ end_latitude }}))
        ELSE NULL
    END as distance_in_meters
{% endmacro %}