{{ config(materialized="table") }}

with
    unique_bike_types as (
        select distinct bike_type from {{ ref("stg_bikeshare_data") }}
    )


select {{ dbt_utils.generate_surrogate_key(["bike_type"]) }} as bike_type_id,
    bike_type
from unique_bike_types

