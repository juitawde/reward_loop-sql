# RewardLoop — Retail Loyalty Points & Rewards Redemption System

RewardLoop is a PostgreSQL-based database management system designed for managing customer loyalty points, purchases, stores, and reward redemptions.

The project demonstrates core DBMS concepts such as relational database design, normalization, SQL queries, views, joins, aggregate functions, subqueries, and stored procedures.

---

## 📌 Project Overview

RewardLoop is a retail loyalty management system where customers earn loyalty points through purchases and use those points to redeem rewards.

The database maintains information about:

- Customers
- Stores
- Purchases
- Loyalty points
- Rewards
- Reward redemptions

The system also provides queries for analyzing customer balances, earned and redeemed points, purchases, and store sales.

---

## 🎯 Objectives

The main objectives of this project are:

- Design a relational database for a retail loyalty system.
- Store and manage customer information.
- Track purchases made at different stores.
- Maintain loyalty point transactions.
- Manage available rewards and their point costs.
- Calculate customer loyalty point balances.
- Allow customers to redeem rewards when sufficient points are available.
- Demonstrate SQL queries using joins, subqueries, grouping, and aggregate functions.
- Implement a stored procedure for reward redemption.
- Demonstrate database concepts such as normalization and transactions.

---

## 🗂️ Project Structure

    RewardLoop/
    │
    ├── 01_rewardloop_schema.sql
    ├── 02_rewardloop_sample_data.sql
    ├── 03_rewardloop_queries.sql
    ├── 04_rewardloop_redemption_transaction.sql
    ├── 05_rewardloop_er_diagram.mmd
    ├── 06_rewardloop_report.md
    └── README.md

---

## 🛠️ Technologies Used

- PostgreSQL — Database Management System
- SQL — Database queries and operations
- PL/pgSQL — Stored procedure
- Mermaid — ER diagram
- pgAdmin / PostgreSQL client — Database execution and management

---

## 🗃️ Database Tables

The project contains the following main tables:

### 1. Customer

Stores customer information.

Important attributes include:

- `CustomerID`
- `FullName`
- `Tier`

### 2. Store

Stores information about retail stores.

Important attributes include:

- `StoreID`
- `StoreName`

### 3. Purchase

Stores customer purchase information.

It connects customers with stores and records purchase amounts.

### 4. LoyaltyPoint

Stores loyalty point transactions.

A positive `PointsChange` represents points earned, while a negative `PointsChange` represents points redeemed.

Important attributes include:

- `PointID`
- `CustomerID`
- `PurchaseID`
- `RewardID`
- `PointsChange`
- `TransactionDate`
- `Notes`

### 5. Reward

Stores the rewards available for redemption.

Important attributes include:

- `RewardID`
- `RewardName`
- `PointsCost`
- `IsActive`

---

## 🔗 Relationships

The main relationships in the database are:

    Customer 1 ──────── M Purchase
    Store    1 ──────── M Purchase
    Customer 1 ──────── M LoyaltyPoint
    Reward   1 ──────── M LoyaltyPoint

This means:

- One customer can make many purchases.
- One store can have many purchases.
- One customer can have many loyalty point transactions.
- One reward can be associated with many loyalty point redemption transactions.

---

## 👁️ Database View

The project includes a view called:

`CustomerPointBalance`

The view calculates the current loyalty point balance of customers by aggregating their loyalty point transactions.

It makes it easier to query customer balances without repeatedly writing the aggregation logic.

Example:

    SELECT *
    FROM CustomerPointBalance;

---

## 🔎 SQL Queries

The project contains queries demonstrating different SQL concepts, including:

### Customer Point Balance

The project calculates the current loyalty point balance for each customer using `SUM(PointsChange)`.

### Total Points Earned

The project calculates the total positive points earned by each customer.

### Total Points Redeemed

The project calculates redeemed points by using negative point transactions.

### Customer and Store Purchase Details

The project uses `JOIN` operations to display customer, store, and purchase information together.

### Loyalty Point Transaction Details

The project uses `LEFT JOIN` to connect loyalty point transactions with customers and rewards.

### Customers With At Least 100 Points

The project uses the `CustomerPointBalance` view to find customers whose balance is at least 100 points.

### Affordable Rewards

A subquery is used to find rewards that a particular customer can currently afford.

### Customers With Purchases

A subquery using `IN` identifies customers who have made at least one purchase.

### Total Sales Per Store

Aggregate functions and `GROUP BY` are used to calculate total sales for each store.

### Gold Tier Customers

The project identifies Gold-tier customers who meet the required loyalty point balance.

---

## ⚙️ Reward Redemption Procedure

The project includes a PostgreSQL stored procedure:

`RedeemReward`

The procedure accepts:

- Customer ID
- Reward ID

It then:

1. Calculates the customer's current loyalty point balance.
2. Retrieves the cost of the selected active reward.
3. Checks whether the customer has enough points.
4. Deducts the reward cost by inserting a negative loyalty point transaction.
5. Raises an exception if the customer does not have enough points.

Example:

    CALL RedeemReward(1, 1);

If the customer has insufficient points:

    CALL RedeemReward(3, 4);

the procedure raises an exception.

---

## 🧮 Normalization

The database design follows normalization principles to reduce data redundancy and avoid data anomalies.

The project demonstrates concepts related to:

- First Normal Form (1NF)
- Second Normal Form (2NF)
- Third Normal Form (3NF)
- Boyce-Codd Normal Form (BCNF)

The data is separated into related tables such as `Customer`, `Store`, `Purchase`, `Reward`, and `LoyaltyPoint` instead of storing all information in one large table.

---

## 🔐 ACID Properties

The reward redemption operation demonstrates transaction-related database concepts.

### Atomicity

The operation should be completed as a whole or not completed.

### Consistency

Database constraints and rules should remain valid after a transaction.

### Isolation

Concurrent transactions should not interfere incorrectly with each other.

### Durability

Once a transaction is committed, the changes remain stored in the database.

---

## 🧰 SQL Command Categories Used

### DDL — Data Definition Language

Used to define database structures.

Examples:

    CREATE
    ALTER
    DROP
    TRUNCATE

### DML — Data Manipulation Language

Used to modify data.

Examples:

    INSERT
    UPDATE
    DELETE

### DQL — Data Query Language

Used to retrieve data.

Example:

    SELECT

### TCL — Transaction Control Language

Used to control transactions.

Examples:

    BEGIN
    COMMIT
    ROLLBACK

### DCL — Data Control Language

Used to manage database permissions.

Examples:

    GRANT
    REVOKE

---

## 🚀 How to Run the Project

### Step 1 — Create the Database

Create a PostgreSQL database, for example:

    rewardloop

### Step 2 — Run the Schema

Execute:

    01_rewardloop_schema.sql

This creates the required tables and database view.

### Step 3 — Insert Sample Data

Execute:

    02_rewardloop_sample_data.sql

This populates the database with sample customers, stores, purchases, rewards, and loyalty point transactions.

### Step 4 — Run the Queries

Execute:

    03_rewardloop_queries.sql

This demonstrates the project's SQL queries.

### Step 5 — Create the Redemption Procedure

Execute:

    04_rewardloop_redemption_transaction.sql

This creates the `RedeemReward` stored procedure.

### Step 6 — Test Reward Redemption

Example:

    CALL RedeemReward(1, 1);

---

## 📊 Sample Customer Point Balances

Based on the sample data, customer point balances are calculated from their loyalty point transactions.

The balance is calculated as:

    Total Points Earned - Total Points Redeemed

Positive point transactions represent earning points, while negative transactions represent redemption.

---

## 📁 ER Diagram

The Entity Relationship diagram is provided in:

    05_rewardloop_er_diagram.mmd

It represents the entities, attributes, primary keys, foreign keys, and relationships in the RewardLoop database.

---

## 📄 Project Report

The detailed case study report is available in:

    06_rewardloop_report.md

It contains:

- Introduction
- Problem Statement
- Case Study Design
- Technologies and Methods
- Implementation Details
- Results and Conclusion
- References

---

## 🎓 DBMS Concepts Demonstrated

This project demonstrates the following concepts:

- Relational Database Design
- Primary Keys
- Foreign Keys
- Entity Relationships
- Cardinality
- Normalization
- SQL
- DDL
- DML
- DQL
- DCL
- TCL
- Aggregate Functions
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- Subqueries
- Views
- Stored Procedures
- Transactions
- Exception Handling
- ACID Properties

---

## 👩‍💻 Author

**Jui Tawde**

B.Tech Computer Science Engineering  
Cohort: Sam Altman

---

## 📌 Conclusion

RewardLoop provides a structured relational database solution for managing retail loyalty points and reward redemptions.

The project demonstrates how database concepts can be combined to maintain customer loyalty data, analyze transactions, calculate point balances, and implement reward redemption logic using PostgreSQL and PL/pgSQL.
