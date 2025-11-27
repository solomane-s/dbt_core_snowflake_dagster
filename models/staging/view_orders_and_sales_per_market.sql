{{ config(
    materialized='view'
) }}

with source as (

    select *
    from {{ source('RAW', 'SNF_DATA_CO_SUPPLY_CHAIN_DATASET') }}

),

transformed as (

    select
        market,
        order_country,
        order_city,
        latitude,
        longitude,
        category_name,
        round(sum(order_item_total), 0) as orders,
        round(sum(sales), 0) as sales
    from source
    group by
        market,
        order_country,
        order_city,
        latitude,
        longitude,
        category_name

),

final as (

    select *
    from transformed

)

select *
from final
