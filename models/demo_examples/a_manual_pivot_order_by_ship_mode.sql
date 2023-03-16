with fct_order_items as (
    select * from {{ ref('fct_order_items') }}
)

select 
    ship_mode
    , sum(case when ship_mode = 'RAIL' then gross_item_sales_amount end) as RAIL_amount
    , sum(case when ship_mode = 'MAIL' then gross_item_sales_amount end) as MAIL_amount
    , sum(case when ship_mode = 'SHIP' then gross_item_sales_amount end) as SHIP_amount
    , sum(case when ship_mode = 'REG AIR' then gross_item_sales_amount end) as REG_AIR_amount
    , sum(case when ship_mode = 'TRUCK' then gross_item_sales_amount end) as TRUCK_amount
    , sum(case when ship_mode = 'AIR' then gross_item_sales_amount end) as AIR_amount
from fct_order_items
group by 1
