{{ 
    config(
        materialized='incremental',
        unique_key='md5(concat(digipass_id, updated_at))',
        incremental_strategy='delete+insert',
        on_schema_change='sync_all_columns'
    ) 
}}

with source_rows as (
  
    select *
           , updated_at as dbt_valid_from
           , null as dbt_valid_to
           , md5(concat(digipass_id, updated_at)) as dbt__scd_id 
     from {{ ref('src_member_subscription_details') }}
  
    {% if is_incremental() %} where updated_at > (select max(updated_at) from {{this}}) {% endif %}

)

{% if is_incremental() %}
    , destination_rows as (
    
        select *
               , md5(concat(digipass_id, updated_at)) as dbt__scd_id 
         from {{ this }} 
        where dbt_valid_to is null
    
    )

    , new_valid_to as (
    
        select 
            d.digipass_id
            , min(s.dbt_valid_from) as dbt_valid_to
        from source_rows s
        join destination_rows d
            on s.digipass_id = d.digipass_id
            and s.dbt__scd_id != d.dbt__scd_id
        group by 1
    )

    , add_new_valid_to as (
    
        select d.digipass_id
               , d.updated_at
               , d.status
               , d.dbt_valid_from
               , n.dbt_valid_to 
          from destination_rows d
          left join new_valid_to n
            on d.digipass_id = n.digipass_id  

    )

    select n.digipass_id
           , n.updated_at
           , n.status
           , n.dbt_valid_from
           , n.dbt_valid_to 
           , (case when n.dbt_valid_to is null then true else false end) as current_status
      from add_new_valid_to n
     union
{% endif %}

select s.digipass_id
       , s.updated_at
       , s.status
       , s.dbt_valid_from
       , lead(s.updated_at, 1) over (partition by s.digipass_id order by s.updated_at) as dbt_valid_to 
       , (case when 
           lead(s.updated_at, 1) over (partition by s.digipass_id order by s.updated_at)
         is null then true else false end) as current_status
  from source_rows s