{{ config(materialized="table") }}

WITH ride_duration AS (
    SELECT
        ride_id,
        TIMESTAMP_DIFF(end_datetime, start_datetime, SECOND) AS duration_seconds
    FROM
        {{ ref('stg_bikeshare_data') }}
)

SELECT
    ride_id,
    start_station_id,
    end_station_id,
    bike_type AS bike_type_id,
    membership_type AS membership_type_id,
    start_datetime,
    end_datetime,
    duration_seconds AS duration,
    -- Calculate distance traveled based on start and end locations (using Haversine formula, for example)

FROM
    {{ ref('stg_bikeshare_data') }}
JOIN
    ride_duration USING (ride_id);