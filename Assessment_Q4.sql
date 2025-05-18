USE adashi_staging;

WITH CustomerTransactions AS (
    SELECT
        pl.owner_id AS customer_id,
        COUNT(sa.id) AS total_transactions
    FROM
        plans_plan pl
    JOIN
        savings_savingsaccount sa ON pl.id = sa.plan_id AND sa.confirmed_amount IS NOT NULL AND sa.confirmed_amount > 0
    GROUP BY
        pl.owner_id
),
AccountTenure AS (
    SELECT
        id AS customer_id,
        CAST(DATEDIFF(CURDATE(), date_joined) / 30.44 AS REAL) AS tenure_months
    FROM
        users_customuser
)
SELECT
    u.id AS customer_id,
    u.name,
    COALESCE(at.tenure_months, 0) AS tenure_months,
    COALESCE(ct.total_transactions, 0) AS total_transactions,
    ROUND(COALESCE((CAST(ct.total_transactions AS REAL) / at.tenure_months) * 12 * (AVG(sa.confirmed_amount) * 0.001 / 100.0), 2), 2) AS estimated_clv
FROM
    users_customuser u
LEFT JOIN
    AccountTenure at ON u.id = at.customer_id
LEFT JOIN
    CustomerTransactions ct ON u.id = ct.customer_id
LEFT JOIN
    plans_plan pl ON u.id = pl.owner_id
LEFT JOIN
    savings_savingsaccount sa ON pl.id = sa.plan_id AND sa.confirmed_amount IS NOT NULL AND sa.confirmed_amount > 0
GROUP BY
    u.id, u.name, tenure_months, total_transactions
ORDER BY
    estimated_clv DESC;