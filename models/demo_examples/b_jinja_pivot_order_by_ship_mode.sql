with fct_order_items as (
    select * from {{ ref('fct_order_items') }}
)

{% set ship_modes = ['AIR', 'TRUCK'] %}

select
    ship_mode
        {% for ship_mode in ship_modes %}
            , sum(case when ship_mode = '{{ship_mode}}' 
                then gross_item_sales_amount end) as {{ship_mode|replace(' ', '_')}}_amount      
        {% endfor %}
from {{ ref('fct_order_items') }}
group by 1