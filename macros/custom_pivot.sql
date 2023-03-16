{% macro custom_pivot( m_name = 'fct_order_items', column_name = 'ship_mode') %}
    
    {% set grab_cols  %}
        select {{column_name}} from {{ref( m_name )}}  group by 1  
    {% endset %}
    
    {%- set results = run_query(grab_cols) -%}

    {%- if execute %}
    {# Return the first column #}
    {%- set col_list = results.columns[0].values() -%}
    {%- else -%}
    {%- set results_list = [] -%}
    {%- endif -%}    
    
    {# Loop over ship_modes array from above, and sum based on whether the record matches the ship mode #}
    {%- for col in col_list -%}
        {%- if not loop.first %},{% endif -%}
        sum(case when ship_mode = '{{col}}' then gross_item_sales_amount end) as {{col|replace(' ', '_')}}_amount
    {% endfor -%}
    

{% endmacro %}