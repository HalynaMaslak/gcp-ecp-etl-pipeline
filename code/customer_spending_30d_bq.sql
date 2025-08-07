SELECT
  o1.*,
  (
    SELECT AVG(o2.TotalOrderValue)
    FROM `ecp-tech-assessment.ecp_data.orders` o2
    WHERE o2.CustomerID = o1.CustomerID
      AND o2.OrderDate BETWEEN DATE_SUB(o1.OrderDate, INTERVAL 30 DAY) AND o1.OrderDate
  ) AS RollingAvg30Days
FROM `ecp-tech-assessment.ecp_data.orders` o1
ORDER BY o1.CustomerID, o1.OrderDate