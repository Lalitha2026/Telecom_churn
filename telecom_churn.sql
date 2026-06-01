select * from customer;

-- Optional: Quick sanity check to inspect your loaded rows
SELECT * FROM customer LIMIT 10;

WITH CohortAnalysis AS (
    SELECT 
        contract,
        internetservice,
        COUNT(customerid) AS total_customers,
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
        ROUND(AVG(monthlycharges):: Numeric, 2) AS avg_monthly_bill,
        ROUND(SUM(cleanedtotalcharges):: Numeric, 2) AS total_revenue 
    FROM customer 
    GROUP BY contract, internetservice
)
SELECT 
    contract,
    internetservice,
    total_customers,
    churned_customers,
    -- This PostgreSQL ::NUMERIC syntax will work perfectly here
    ROUND((churned_customers::NUMERIC / total_customers::NUMERIC) * 100, 2) AS churn_rate, avg_monthly_bill,
    -- Rank contracts by revenue generation
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM CohortAnalysis
WHERE total_customers > 50
ORDER BY churn_rate DESC;