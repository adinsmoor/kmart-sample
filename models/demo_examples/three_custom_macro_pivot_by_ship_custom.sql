with fct_order_items as (
    select * from {{ ref('fct_order_items') }}
)

select
    ship_mode, 
    {{ custom_pivot( 'fct_order_items', 'ship_mode' ) }}
from {{ ref('fct_order_items') }}
group by 1