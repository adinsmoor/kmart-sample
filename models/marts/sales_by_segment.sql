select 
    market_segment
    , sum(net_item_sales_amount) as total_sales_amount
from {{ ref('order_items') }} 
left join {{ ref('stg_tpch_customers') }} 
on order_items.customer_key = stg_tpch_customers.customer_key
group by 1