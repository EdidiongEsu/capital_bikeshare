{{ config(materialized="table") }}

WITH combined_stations AS (
    SELECT
        start_station_id AS station_id,
        start_station_name AS station_name,
        start_latitude AS latitude,
        start_longitude AS longitude,
    FROM
        {{ ref("stg_bikeshare_data") }}
    
    UNION ALL
    
    SELECT
        end_station_id AS station_id,
        end_station_name AS station_name,
        end_latitude AS latitude,
        end_longitude AS longitude,
    FROM
        {{ ref('stg_bikeshare_data') }}
)

SELECT
    station_id,
    station_name,
    latitude,
    longitude,

FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY station_id ORDER BY station_id) AS row_num
    FROM
        combined_stations
) AS ranked_stations
WHERE row_num = 1