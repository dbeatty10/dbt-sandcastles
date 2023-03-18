{{
  config(
    materialized='table',
  )
}}

select 1 as id union all
select 2 as id union all
select 3 as id union all
select 4 as id
