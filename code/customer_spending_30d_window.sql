SELECT
  *,
  AVG(TotalOrderValue) OVER (
    PARTITION BY CustomerID
    ORDER BY OrderDate
    RANGE BETWEEN INTERVAL '30' DAY PRECEDING AND CURRENT ROW
  ) AS RollingAvg30Days
FROM `ecp-tech-assessment.ecp_data.orders`;