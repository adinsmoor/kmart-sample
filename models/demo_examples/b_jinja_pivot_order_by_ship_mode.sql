with fct_order_items as (
    select * from {{ ref('fct_order_items') }}
)

select
    ship_mode
        
    -- , sum(case when ship_mode = '[??]' then gross_item_sales_amount end) as [??|replace(' ', '_')]_amount      
        
from {{ ref('fct_order_items') }}
group by 1