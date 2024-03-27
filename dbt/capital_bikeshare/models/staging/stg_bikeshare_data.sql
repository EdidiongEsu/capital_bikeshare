{{ config(materialized="view") }}

with bike_data as
(
    select * from {{ source('src','bikeshare_data') }}
    where ride_id is not null
)

select
    -- identifiers
    cast(ride_id as string) as ride_id,
    cast(start_station_id as integer) as start_station_id,
    cast(end_station_id as integer) as end_station_id,

    -- timestamps
    cast(start_datetime as timestamp) as start_datetime,
    cast(end_datetime as timestamp) as end_datetime,

    -- bike information
    cast(bike_type as string) as bike_type,

    -- trip information 
    cast(start_station_name as string) as start_station_name,
    cast(end_station_name as string) as end_station_name,
    
        -- Replace null values with 'Unknown' for latitude and longitude columns
    coalesce(start_lat, CAST('Unknown' AS NUMERIC)) as start_latitude,
    coalesce(start_lng, CAST('Unknown' AS NUMERIC)) as start_longitude,
    coalesce(end_lat, CAST('Unknown' AS NUMERIC)) as end_latitude,
    coalesce(end_lng, CAST('Unknown' AS NUMERIC)) as end_longitude,


    -- - customer info
    cast(membership_type as string) as membership_type

from bike_data

-- dbt build --select stg_bikeshare_data.sql --var '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 1000

{% endif %}