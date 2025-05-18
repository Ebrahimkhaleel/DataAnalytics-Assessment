USE adashi_staging;
-- Customers with at least one funded savings plan and one funded investment plan,
-- sorted by total deposits.

SELECT
    u.id AS owner_id,
    u.name,
    COUNT(CASE WHEN pl.is_regular_savings = 1 AND sa.confirmed_amount > 0 THEN pl.id END) AS savings_count,
    COUNT(CASE WHEN pl.is_a_fund = 1 AND sa.confirmed_amount > 0 THEN pl.id END) AS investment_count,
    SUM(sa.confirmed_amount / 100.0) AS total_deposits
FROM
    users_customuser u
JOIN
    plans_plan pl ON u.id = pl.owner_id
LEFT JOIN
    savings_savingsaccount sa ON pl.id = sa.plan_id
WHERE
    pl.is_regular_savings = 1 OR pl.is_a_fund = 1
GROUP BY
    u.id, u.name
HAVING
    SUM(CASE WHEN pl.is_regular_savings = 1 AND sa.confirmed_amount > 0 THEN 1 ELSE 0 END) >= 1
    AND SUM(CASE WHEN pl.is_a_fund = 1 AND sa.confirmed_amount > 0 THEN 1 ELSE 0 END) >= 1
ORDER BY
    total_deposits DESC;