
with produtos as  (
    select 
        ct.category_name,
        sp.company_name as suppliers,
        pd.product_name,
        pd.unit_price,
        pd.product_id
    from {{ source("sources", "products") }} pd
    left join {{ source("sources", "suppliers")}} sp on pd.supplier_id = sp.supplier_id
    left join {{ source("sources", "categories")}} ct on pd.category_id = ct.category_id
)

, detalhes_pedidos as(
    select 
    pd.*, 
    od.order_id, 
    od.quantity, 
    od.desconto
    from {{ref("order_details")}} od
    left join produtos pd on od.product_id = pd.product_id
    
)

, pedidos as(
    select 
        ord.order_date,
        ord.order_id,
        cs.company_name,
        sp.company_name as shipper_name,
       em.idade_do_funcionario,
       em.tempo_de_casa,
       em.idade_contratato,
       em.nome_completo
    from {{source("sources", "orders")}} ord
    left join {{ ref("customers") }} cs on ord.customer_id = cs.customer_id 
    left join {{ ref("employees") }} em on ord.employee_id = em.employee_id 
    left join {{ source("sources", "shippers") }} sp on ord.ship_via = sp.shipper_id
)

, final_joins as (

    select 
    dp.*,  
    pd.order_date,
    pd.shipper_name,
    pd.idade_do_funcionario,
    pd.tempo_de_casa,
    pd.idade_contratato,
    pd.nome_completo
    from detalhes_pedidos dp
    left join pedidos pd on dp.order_id = pd.order_id
 
)
select * from final_joins