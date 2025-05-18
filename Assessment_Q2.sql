USE adashi_staging;

WITH MonthlyTransactions AS (
    SELECT
        u.id AS customer_id,
        DATE_FORMAT(sa.transaction_date, '%Y-%m') AS transaction_month,
        COUNT(sa.id) AS monthly_transaction_count,
        MIN(sa.transaction_date) AS first_transaction_date
    FROM
        users_customuser u
    JOIN
        plans_plan pl ON u.id = pl.owner_id
    JOIN
        savings_savingsaccount sa ON pl.id = sa.plan_id
    WHERE
        sa.confirmed_amount IS NOT NULL
        AND sa.confirmed_amount > 0
    GROUP BY
        u.id,
        DATE_FORMAT(sa.transaction_date, '%Y-%m')
),
AvgMonthlyTransactions AS (
    SELECT
        customer_id,
        CAST(COUNT(transaction_month) AS DECIMAL(10,2)) / 
        GREATEST(DATEDIFF(CURDATE(), MIN(first_transaction_date)) / 30.44, 1) AS avg_transactions_per_month
    FROM
        MonthlyTransactions
    GROUP BY
        customer_id
)
SELECT
    CASE
        WHEN amt.avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN amt.avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(DISTINCT u.id) AS customer_count,
    AVG(amt.avg_transactions_per_month) AS avg_transactions_per_month
FROM
    users_customuser u
JOIN
    AvgMonthlyTransactions amt ON u.id = amt.customer_id
GROUP BY
    frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;