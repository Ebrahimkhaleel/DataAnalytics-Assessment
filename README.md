### DataAnalytics-Assessment


This repository contains the SQL queries developed in response to the SQL Proficiency Assessment. Each query addresses a specific business problem outlined in the assessment instructions.

### Question-Specific Solutions and Explanations

* Assessment_Q1.sql: High-Value Customer Identification
I developed a query that identifies customers with diversified financial portfolios. Specifically, I:

- Implemented multiple table joins across user, plan, and savings account tables
- Applied conditional COUNT aggregates with GROUP BY clauses to analyze customer product adoption
- Engineered filtering logic using HAVING clauses to isolate high-value customers
- Optimized the query to sort results by total deposit value, providing immediate business value

Assessment_Q2.sql: Transaction Frequency Analysis
I created a customer segmentation system based on transaction behaviors by:

- Designing multiple CTEs (Common Table Expressions) to establish a transaction analysis pipeline
- Calculating personalized monthly transaction metrics for each customer
- Implementing custom classification logic to segment customers into frequency categories
- Ensuring accurate time-based calculations by accounting for varying customer history durations

Assessment_Q3.sql: Account Inactivity Detection
I built an automated account monitoring system that:

- Joins multiple financial data tables to track transaction patterns
Filters specifically for inflow transactions using conditional statements
- Implements date difference calculations to identify inactive accounts
Establishes a 365-day threshold based on business requirements

Assessment_Q4.sql: Customer Lifetime Value (CLV) Calculation
I engineered a financial analysis query that:

- Creates a multi-stage data pipeline using CTEs to process customer tenure data
- Calculates precise account tenure in months using date manipulation functions
- Implements business-specific CLV formula with appropriate profit assumptions
- Prioritizes high-value customers through strategic result ordering

Technical Challenges Overcome
Cross-Database Compatibility Issues
When I discovered that my initial queries contained SQLite-specific functions that wouldn't work in the production MySQL environment, I:

Researched MySQL equivalent functions for date manipulation
Refactored all date calculations from STRFTIME/JULIANDAY to appropriate MySQL DATE_FORMAT/DATEDIFF functions
Tested extensively to ensure consistent results across database platforms

### Challenges Encountered and Resolutions

During the development of these queries, several challenges were addressed:

##### Cross-Database Compatibility Issues
When I discovered that my initial queries contained SQLite-specific functions that wouldn't work in the production MySQL environment, I:

- Researched MySQL equivalent functions for date manipulation
- Refactored all date calculations from STRFTIME/JULIANDAY to appropriate MySQL DATE_FORMAT/DATEDIFF functions
- Tested to ensure consistent results across database platforms

##### Calculating Average Monthly Transactions (Q2):
I encountered several calculation challenges that required creative solutions:
- For the transaction frequency analysis, I built a custom calculation method that used the earliest transaction date to establish an accurate baseline
- When estimating account tenure, I investigated the database schema to identify the most appropriate date column after discovering inconsistencies
- I validated all calculations against sample data to ensure business logic accuracy

##### Lost Connection Errors:
When executing long-running queries, I encountered connection timeout issues which I addressed by:
- Analyzing execution plans to identify optimization opportunities
- Restructuring queries to improve indexing efficiency
- Implementing appropriate aggregation techniques to reduce computational load
