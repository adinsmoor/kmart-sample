{{ config(materialized="table") }}

select
    1 as order_id,
    1 as customer_id,
    'cancelled' as status,
    cast('2018-01-01' as date) as order_date,
    cast('2018-01-04' as date) as modified_at

-- union
-- select
--     2 as order_id,
--     1 as customer_id,
--     'completed' as status,
--     cast('2018-01-02' as date) as order_date,
--     cast('2018-01-02' as date) as modified_at
-- union
-- select
--     2 as order_id,
--     1 as customer_id,
--     'under_fraud_review' as status,
--     cast('2018-01-03' as date) as order_date,
--     cast('2018-01-03' as date) as modified_at
-- union
-- select
--     2 as order_id,
--     1 as customer_id,
--     'cancelled' as status,
--     cast('2018-01-03' as date) as order_date,
--     cast('2018-01-04' as date) as modified_at    