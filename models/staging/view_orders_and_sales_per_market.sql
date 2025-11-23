{{ config(
    materialized='view'
) }}

with source as (

    select *
    from {{ source('raw', 'data_co_supply_chain_dataset') }}

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
