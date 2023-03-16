{% test is_in_increment_of_five(model, column_name) %}

{{ config(severity = 'warn') }}

with validation as (

    select
        {{ column_name }} as check_field
    from {{ model }}

),

validation_errors as (

    select
        check_field
    from validation
    where (even_field % 1) <> 0

)

select *
from validation_errors

{% endtest %}