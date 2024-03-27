{{ config(materialized="table") }}

with
    unique_subscriptions as (
        select distinct membership_type from {{ ref("stg_bikeshare_data") }}
    )


select {{ dbt_utils.generate_surrogate_key(["membership_type"]) }} as membership_type_id,
    membership_type
from unique_subscriptions

