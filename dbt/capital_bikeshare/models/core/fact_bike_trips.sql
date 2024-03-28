{{ config(materialized='table') }}

-- Join the staging data with the dimension tables
WITH bike_data AS (
    SELECT
        -- identifiers
        CAST(ride_id AS STRING) AS ride_id,
        CAST(start_station_id AS INTEGER) AS start_station_id,
        CAST(end_station_id AS INTEGER) AS end_station_id,
        -- timestamps
        CAST(start_datetime AS TIMESTAMP) AS start_datetime,
        CAST(end_datetime AS TIMESTAMP) AS end_datetime,
        -- bike information
        CAST(bike_type AS STRING) AS bike_type,
        -- trip information
        CAST(start_station_name AS STRING) AS start_station_name,
        CAST(end_station_name AS STRING) AS end_station_name,
        CAST(start_latitude AS NUMERIC) AS start_latitude,
        CAST(start_longitude AS NUMERIC) AS start_longitude,
        CAST(end_latitude AS NUMERIC) AS end_latitude,
        CAST(end_longitude AS NUMERIC) AS end_longitude,
        -- customer info
        CAST(membership_type AS STRING) AS membership_type
    FROM
        {{ ref('stg_bikeshare_data') }}
)

SELECT
    bd.ride_id,
    bd.start_station_id,
    bd.end_station_id,
    bd.start_datetime,
    bd.end_datetime,
    -- Calculate duration in seconds
    TIMESTAMP_DIFF(bd.end_datetime, bd.start_datetime, SECOND) AS duration_seconds,
    bd.bike_type,
    bd.start_station_name,
    bd.end_station_name,
    bd.start_latitude,
    bd.start_longitude,
    bd.end_latitude,
    bd.end_longitude,
    ---Calculate distance in meters using created distance_from_cordinates macro
    {{ distance_from_cordinates('bd.start_longitude', 'bd.start_latitude', 'bd.end_longitude', 'bd.end_latitude') }},
    
    bd.membership_type,
    s.station_id AS station_id_fk,
    m.membership_type_id,
    t.bike_type_id
FROM
    bike_data bd
LEFT JOIN
    {{ ref('dim_stations') }} s ON bd.start_station_id = s.station_id
LEFT JOIN
    {{ ref('dim_bike_membership') }} m ON bd.membership_type = m.membership_type
LEFT JOIN
    {{ ref('dim_bike_types') }} t ON bd.bike_type = t.bike_type