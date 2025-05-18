USE adashi_staging; 

SELECT
    pl.id AS plan_id,
    pl.owner_id,
    CASE
        WHEN pl.is_regular_savings = 1 THEN 'Savings'
        WHEN pl.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.transaction_date) AS last_transaction_date,
    CAST(DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS UNSIGNED) AS inactivity_days
FROM
    plans_plan pl
LEFT JOIN
    savings_savingsaccount sa ON pl.id = sa.plan_id AND sa.confirmed_amount > 0
WHERE
    pl.is_regular_savings = 1 OR pl.is_a_fund = 1
GROUP BY
    pl.id, pl.owner_id, type
HAVING
    MAX(sa.transaction_date) IS NULL OR DATEDIFF(CURDATE(), MAX(sa.transaction_date)) > 365;