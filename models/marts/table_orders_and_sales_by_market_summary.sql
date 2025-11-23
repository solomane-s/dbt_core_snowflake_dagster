{{ config(
    materialized='table'
) }}

with source as (

    select *
    from {{ ref('view_orders_and_sales_per_market') }}

),

transformed as (

    select
        market,
        sum(orders) as orders,
        sum(sales) as sales
    from source
    group by market

),

final as (

    select *
    from transformed

)

select *
from final
