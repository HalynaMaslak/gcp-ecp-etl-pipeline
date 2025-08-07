SELECT
  OrderRegion,
  AVG(TotalOrderValue) AS AvgSpending
FROM
  `ecp-tech-assessment.ecp_data.orders` 
GROUP BY
  OrderRegion
ORDER BY
  AvgSpending DESC;