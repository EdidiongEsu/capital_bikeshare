{{ config(materialized="table") }}

SELECT
    start_station_id AS station_id,
    start_station_name AS station_name,
    start_latitude AS latitude,
    start_longitude AS longitude,
    'start_station' as station_type
FROM
    {{ ref("stg_bikeshare_data") }}
UNION ALL
SELECT
    end_station_id AS station_id,
    end_station_name AS station_name,
    end_latitude AS latitude,
    end_longitude AS longitude,
    'end_station' as station_type
FROM
    {{ ref('stg_bikeshare_data') }}