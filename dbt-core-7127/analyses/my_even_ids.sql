select *
from {{ ref("my_model") }}
where (id % 2) = 0
