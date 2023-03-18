{{ config (materialized = 'table') }}

SELECT
    month_date,
    total_transaction,
    SUM(total_revenue) AS cat_revenues
FROM
    {{ ref('monthly_aggregates') }},
    UNNEST(purchase_categories) AS pc
WHERE 
    pc = 'Shorts'
GROUP BY
    month_date,
    total_transaction
