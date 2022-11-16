{{
    config(
        materialized='incremental',
        incremental_strategy='delete+insert',
        pre_hook= "{% if is_incremental() %}
                 TRUNCATE IF EXISTS {{ this }}
                 {% endif %}",
        on_schema_change='sync_all_columns'
    )
}}

with
seed_ref as (

    select
        id,
        to_number(col_1) as col_1,
        to_number(col_2) as col_2
    from {{ ref('test_seed') }}

)

select
    id,
    round(col_1 / col_2 * 100, 1) as cost_pct,
    round(col_1 * (col_1 / col_2), 2) as cost_dollars
from seed_ref
