use telecom_churn

select * from customer

-- (RENAME COLUMNS)
ALTER TABLE customer RENAME COLUMN customerid TO customer_id;
ALTER TABLE customer RENAME COLUMN Seniorcitizen TO Senior_citizen;
ALTER TABLE customer RENAME COLUMN Tenuregroup TO Tenure_group;
ALTER TABLE customer RENAME COLUMN Phoneservice TO Phone_service;
ALTER TABLE customer RENAME COLUMN Multiplelines TO Multiple_lines;
ALTER TABLE customer RENAME COLUMN Internetservice TO Internet_service;
ALTER TABLE customer RENAME COLUMN Onlinesecurity TO Online_security;
ALTER TABLE customer RENAME COLUMN Onlinebackup TO Online_backup;
ALTER TABLE customer RENAME COLUMN Deviceprotection TO Device_protection ;
ALTER TABLE customer RENAME COLUMN Techsupport TO Tech_support ;
ALTER TABLE customer RENAME COLUMN Streamingtv TO Streaming_tv ;
ALTER TABLE customer RENAME COLUMN Streamingmovies TO Streaming_movies ;
ALTER TABLE customer RENAME COLUMN Contract TO Contract_type ;
ALTER TABLE customer RENAME COLUMN Paperlessbilling TO Paperless_billing ;
ALTER TABLE customer RENAME COLUMN Paymentmethod TO Payment_method ;
ALTER TABLE customer RENAME COLUMN Monthlycharges TO Monthly_charges ;
ALTER TABLE customer RENAME COLUMN Highvaluecustomer TO High_value_customer ;
ALTER TABLE customer RENAME COLUMN Cleanedtotalcharges TO Cleaned_total_charges ;
ALTER TABLE customer RENAME COLUMN Churn TO Churn_status ;

WITH CohortAnalysis AS ( 
    SELECT 
        contract_type,
        internet_service, 
        COUNT(customer_id) AS total_customers, 
        SUM(CASE WHEN churn_status = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
        ROUND(AVG(monthly_charges), 2) AS avg_monthly_bill,
        ROUND(SUM(Cleaned_total_charges), 2) AS total_revenue 
    FROM customer 
    GROUP BY contract_type, internet_service
) 
SELECT 
    contract_type,
    internet_service,
    total_customers,
    churned_customers,
    -- Fixed Line Below: Replaced PostgreSQL ::NUMERIC with MySQL CAST()
    ROUND((CAST(churned_customers AS DECIMAL(10,2)) / CAST(total_customers AS DECIMAL(10,2))) * 100, 2) AS churn_rate,
    avg_monthly_bill, 
    -- Rank contracts by revenue generation 
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank 
FROM CohortAnalysis 
WHERE total_customers > 50 
ORDER BY churn_rate DESC;