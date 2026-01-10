with clientes_marcados as (
select * , 
first_value(customer_id)
over(partition by company_name, contact_name
order by company_name
rows between unbounded preceding and unbounded following) as resultado
from {{ source("sources", "customers") }}
), 

    removendo_duplicacao as (
        select distinct resultado from clientes_marcados
),

    final as (
    select * from {{ source("sources", "customers") }} where customer_id in (select resultado from removendo_duplicacao)
)

select * from final