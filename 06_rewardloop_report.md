# RewardLoop — Retail Loyalty Points & Rewards Redemption System

**Student:** Jui Tawde  
**Cohort:** Sam Altman  
**Programme:** B.Tech Computer Science Engineering  
**Subject:** Database Management Systems — Semester III  
**Case Study:** 109

## 1. Problem Statement
RewardLoop needs a database for a retail loyalty programme. Customers earn points on purchases and redeem their points for rewards. The system must check that a customer has enough points before allowing redemption.

## 2. Entities and Relationships
- **Customer:** stores customer information.
- **Store:** stores retail branch information.
- **Purchase:** records purchases made by customers at stores.
- **Reward:** stores each reward's name, description, point cost, and tier.
- **LoyaltyPoint:** records points earned and points redeemed.

Relationships:
- One customer can make many purchases (1:M).
- One store can receive many purchases (1:M).
- One customer can have many loyalty point transactions (1:M).
- A purchase can create a points-earned transaction.
- A reward can be redeemed in many loyalty point transactions (1:M).

## 3. Relational Schema
- Customer(**CustomerID**, FullName, Email, Phone, JoinDate)
- Store(**StoreID**, StoreName, StoreAddress, City)
- Purchase(**PurchaseID**, CustomerID FK, StoreID FK, PurchaseDate, PurchaseAmount)
- Reward(**RewardID**, RewardName, Description, PointsCost, RewardTier, IsActive)
- LoyaltyPoint(**PointID**, CustomerID FK, PurchaseID FK, RewardID FK, PointsChange, TransactionDate, Notes)

## 4. Normalization
**1NF:** Each column contains one value, and each table has a primary key.

**2NF:** Reward details such as Description and PointsCost are stored in the Reward table instead of repeating them in every redemption transaction. Each table uses a single-column primary key.

**3NF:** Customer, store, purchase, reward, and point-transaction details are kept in separate tables. The balance is calculated from transaction history rather than stored repeatedly.

## 5. Points Rule
- Positive `PointsChange` means points earned.
- Negative `PointsChange` means points redeemed.
- Current balance is the sum of `PointsChange` for a customer.
- Sample earning rate: 1 point for every INR 10 spent.

## 6. Transaction Management
The `RedeemReward` procedure checks the customer's balance and reward cost. If the balance is enough, it inserts a negative transaction to deduct the points. If the balance is not enough, it raises an error and does not insert the redemption. This demonstrates the check-and-deduct logic required by the case study.

## 7. Queries
The query file contains queries to:
1. Calculate current balances.
2. Calculate points earned.
3. Calculate points redeemed.
4. Show purchases with customer and store names.
5. Show point history and reward details.
6. Find customers with at least 100 points.
7. Find rewards affordable by a selected customer.
8. Find customers who made purchases.
9. Calculate total sales per store.
10. Find customers meeting the 500-point Gold-tier threshold.

## 8. Expected Current Balance from Sample Data

| Customer | Earned | Redeemed | Balance |
|---|---:|---:|---:|
| Aarav Mehta | 200 | 100 | 100 |
| Diya Shah | 205 | 100 | 105 |
| Kabir Rao | 50 | 0 | 50 |
| Mira Iyer | 220 | 0 | 220 |

## 9. Execution Order
1. Create a PostgreSQL database named `rewardloop_db`.
2. Run `01_rewardloop_schema.sql`.
3. Run `02_rewardloop_sample_data.sql`.
4. Run the SELECT queries in `03_rewardloop_queries.sql`.
5. Run `04_rewardloop_redemption_transaction.sql`.
6. Test a successful redemption and a rejected redemption.
7. Render `05_rewardloop_er_diagram.mmd` using a Mermaid-compatible editor.

## 10. Conclusion
The RewardLoop database uses related tables, primary and foreign keys, constraints, SQL joins, aggregate functions, and a redemption procedure. It calculates point balances from the transaction history and checks the balance before recording a redemption.
