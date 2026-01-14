
   select 
    od.unit_price * od.quantity as valor_total,
    (pr.unit_price * od.quantity) - valor_total as desconto,
    od.order_id,
    od.product_id,
    od.quantity,
    od.unit_price,
    pr.product_name,
    pr.supplier_id,
    pr.category_id    
    from {{source("sources", "order_details")}} od
    left join {{source("sources", "products")}} pr on od.product_id = pr.product_id


