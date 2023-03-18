{{ config(materialized='table') }}

SELECT 
    oi.id as order_items_id,
    oi.status,
    oi.created_at as order_items_created_at,
    oi.shipped_at as order_items_shipped_at,
    oi.delivered_at as order_items_delivered_at,
    oi.returned_at as order_items_returned_at,
    oi.sale_price,
    p.cost,
    p.category,
    p.name,
    p.brand,
    p.retail_price,
    p.department,
    ii.created_at as inventory_items_created_at,
    ii.sold_at,
    ii.product_name,
    ii.product_brand,
    ii.product_category,
    ii.product_retail_price,
    u.first_name,
    u.last_name,
    u.id as user_id,
    u.email,
    u.age,
    u.gender,
    u.state,
    u.city,
    u.country,
    o.created_at as order_created_at,
    o.shipped_at as order_shipped_at,
    o.delivered_at as order_delivered_at,
    o.num_of_item
FROM 
    electric-cortex-289700.thelook_ecommerce.order_items as oi
LEFT JOIN 
    electric-cortex-289700.thelook_ecommerce.products as p
    ON
        oi.product_id = p.id
LEFT JOIN 
    electric-cortex-289700.thelook_ecommerce.inventory_items as ii
    ON
        oi.inventory_item_id = ii.id
LEFT JOIN 
    electric-cortex-289700.thelook_ecommerce.users as u
    ON 
        oi.user_id = u.id
LEFT JOIN 
    electric-cortex-289700.thelook_ecommerce.orders as o
    ON
        oi.order_id = o.order_id

WHERE oi.status in ('Complete', 'Shipped')

