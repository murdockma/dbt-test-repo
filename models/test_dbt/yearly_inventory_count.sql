{{ config(materialized='table') }}

SELECT 
    product_id,
    created_at,
    sold_at,
    cost,
    product_category,
    product_brand,
    product_retail_price,
    product_distribution_center_id,
    e.name
FROM
    `electric-cortex-289700`.thelook_ecommerce.inventory_items as i
LEFT JOIN 
    `electric-cortex-289700`.thelook_ecommerce.distribution_centers as e
ON
    i.product_distribution_center_id = e.id

WHERE
    created_at > TIMESTAMP('2019-01-01')
