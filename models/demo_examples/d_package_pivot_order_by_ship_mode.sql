select
    ship_mode, 

    {{ dbt_utils.pivot(
        'ship_mode',
        dbt_utils.get_column_values(ref('fct_order_items'), 'ship_mode') ,
        then_value='gross_item_sales_amount'
    ) }}

from {{ ref('fct_order_items') }}
group by 1
