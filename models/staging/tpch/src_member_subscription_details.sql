with source_data as (

    select 1 as digipass_id, '2023-03-20 20:45:19.113 -0700' as updated_at, 'pending' as status union all
    select 1, dateadd(minute, 10, '2023-03-20 20:45:19.113 -0700'), 'active' union all
    select 2, dateadd(minute, 20, '2023-03-20 20:45:19.113 -0700'), 'pending'
    
    union all 
    select 1 as digipass_id, dateadd(minute, 30, '2023-03-20 20:45:19.113 -0700') as updated_at, 'deleted' as status union all
    select 2, dateadd(minute, 40, '2023-03-20 20:45:19.113 -0700'), 'active' union all
    select 3, dateadd(minute, 50, '2023-03-20 20:45:19.113 -0700'), 'pending'

    union all 
    select 2 as digipass_id, dateadd(minute, 60, '2023-03-20 20:45:19.113 -0700') as updated_at, 'deleted' as status union all
    select 2, dateadd(minute, 70, '2023-03-20 20:45:19.113 -0700'), 'restored' union all
    select 4, dateadd(minute, 80, '2023-03-20 20:45:19.113 -0700'), 'active'

)

select * from source_data