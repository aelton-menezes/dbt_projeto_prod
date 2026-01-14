
with calculos_funcionarios as (
select
    employee_id,
    date_part(year, current_date) - date_part(year, birth_date) idade_do_funcionario,
    date_part(year, current_date) - date_part(year, hire_date) tempo_de_casa, 
    date_part(year, hire_date) - date_part(year, birth_date) idade_contratato,
    first_name || ' ' || last_name  nome_completo,
    title, city, country,notes, salary    
    
from {{ source("sources", "employees") }}
)

select * from calculos_funcionarios
