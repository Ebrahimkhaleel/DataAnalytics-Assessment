# SQL_Assessment
# DataAnalytics-Assessment

This repository contains the SQL queries developed in response to the SQL Proficiency Assessment. Each query addresses a specific business problem outlined in the assessment instructions.

# Question-Specific Solutions and Explanations

Assessment_Q1.sql: High-Value Customers with Multiple Products
This query identifies customers who possess at least one funded savings account and one funded investment plan. It joins the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables. Conditional `COUNT` aggregates are used within a `GROUP BY` clause to determine the number of each plan type per customer. A `HAVING` clause then filters the results to include only customers meeting the specified criteria. The output is ordered by the total deposit amount.

Assessment_Q2.sql: Transaction Frequency Analysis
This query categorizes customers based on their average monthly transaction frequency. It utilizes Common Table Expressions (CTEs) to first calculate the monthly transaction count per customer and then the average monthly transaction rate based on their transaction history duration. Customers are then classified into "High Frequency", "Medium Frequency", and "Low Frequency" categories based on these averages.

Assessment_Q3.sql: Account Inactivity Alert
This query flags active savings or investment accounts that have not had any inflow transactions within the last 365 days. It joins the `plans_plan` and `savings_savingsaccount` tables, filtering for inflow transactions. The query groups results by account and identifies the last transaction date, subsequently calculating the period of inactivity.

Assessment_Q4.sql: Customer Lifetime Value (CLV) Estimation
This query estimates a simplified Customer Lifetime Value for each customer based on their account tenure and total transaction volume. CTEs are employed to calculate the account tenure in months and the total number of transactions. The final calculation applies the provided CLV formula, assuming a 0.1% profit per transaction. The results are ordered by the estimated CLV in descending order.

# Challenges Encountered and Resolutions

During the development of these queries, several challenges were addressed:

* Database System Compatibility: Queries utilized functions (`STRFTIME`, `JULIANDAY`) that are specific to SQLite and not directly available in MySQL. These functions were replaced with their MySQL equivalents (`DATE_FORMAT`, `DATEDIFF`) to ensure compatibility.
* Calculating Average Monthly Transactions (Q2): Accurately determining the duration of a customer's transaction history for the average calculation required using the earliest transaction date as the starting point.
* Estimating Account Tenure (Q4): The absence of a direct "signup date" column initially caused errors. The query was adapted to use the `joined_date` column; however, subsequent errors indicated this was also incorrect. It is crucial to identify the correct signup/registration date column in the `users_customuser` table for accurate tenure calculation.
* Lost Connection Errors: During the execution of potentially long-running queries, "Lost connection to MySQL server" errors were encountered. This suggests potential timeout issues or resource limitations. While the queries were optimized, adjusting server timeout settings might be necessary for prolonged operations.

