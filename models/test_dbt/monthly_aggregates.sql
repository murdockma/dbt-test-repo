{{ config(materialized = 'table') }}

WITH monthly_transactions as (
  SELECT * FROM UNNEST(
    GENERATE_DATE_ARRAY(
      DATE('2019-01-01'),
      CURRENT_DATE(),
      INTERVAL 1 MONTH
    )
  ) as month_date
)

SELECT 
  m.month_date,
  array_agg(DISTINCT yc.product_category) as purchase_categories,
  COUNT(DISTINCT yc.product_id) as total_transaction,
  ROUND(SUM(yc.cost), 2) as total_revenue
FROM 
  monthly_transactions m
LEFT JOIN
  `electric-cortex-289700`.dbt_mmurdock.yearly_inventory_count yc
  ON m.month_date >= DATE(yc.sold_at)
WHERE
  yc.product_category IS NOT NULL
GROUP BY
  m.month_date
ORDER BY m.month_date
