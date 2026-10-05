-- RewardLoop queries (beginner-friendly SQL)

-- Q1. Current balance of every customer.
-- Positive points are earned; negative points are redeemed.
SELECT Customer.CustomerID, Customer.FullName,
       SUM(LoyaltyPoint.PointsChange) AS CurrentBalance
FROM Customer
LEFT JOIN LoyaltyPoint
ON Customer.CustomerID = LoyaltyPoint.CustomerID
GROUP BY Customer.CustomerID, Customer.FullName
ORDER BY Customer.CustomerID;

-- Q2. Total points earned by each customer.
SELECT Customer.CustomerID, Customer.FullName,
       SUM(LoyaltyPoint.PointsChange) AS PointsEarned
FROM Customer
JOIN LoyaltyPoint
ON Customer.CustomerID = LoyaltyPoint.CustomerID
WHERE LoyaltyPoint.PointsChange > 0
GROUP BY Customer.CustomerID, Customer.FullName;

-- Q3. Total points redeemed by each customer.
SELECT Customer.CustomerID, Customer.FullName,
       SUM(-LoyaltyPoint.PointsChange) AS PointsRedeemed
FROM Customer
JOIN LoyaltyPoint
ON Customer.CustomerID = LoyaltyPoint.CustomerID
WHERE LoyaltyPoint.PointsChange < 0
GROUP BY Customer.CustomerID, Customer.FullName;

-- Q4. Show each purchase with customer and store names.
SELECT Purchase.PurchaseID, Customer.FullName, Store.StoreName,
       Purchase.PurchaseDate, Purchase.PurchaseAmount
FROM Purchase
JOIN Customer ON Purchase.CustomerID = Customer.CustomerID
JOIN Store ON Purchase.StoreID = Store.StoreID;

-- Q5. Show loyalty transaction history with reward details if redeemed.
SELECT LoyaltyPoint.PointID, Customer.FullName,
       LoyaltyPoint.PointsChange, LoyaltyPoint.TransactionDate,
       Reward.RewardName, Reward.PointsCost
FROM LoyaltyPoint
JOIN Customer ON LoyaltyPoint.CustomerID = Customer.CustomerID
LEFT JOIN Reward ON LoyaltyPoint.RewardID = Reward.RewardID
ORDER BY LoyaltyPoint.PointID;

-- Q6. Customers whose balance is at least 100 points.
SELECT CustomerID, FullName, CurrentPointBalance
FROM CustomerPointBalance
WHERE CurrentPointBalance >= 100;

-- Q7. Rewards a customer can afford (example for customer 1).
SELECT RewardName, PointsCost
FROM Reward
WHERE PointsCost <= (
    SELECT SUM(PointsChange)
    FROM LoyaltyPoint
    WHERE CustomerID = 1
);

-- Q8. Customers who have made at least one purchase.
SELECT FullName
FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Purchase
);

-- Q9. Total sales for each store.
SELECT Store.StoreName, SUM(Purchase.PurchaseAmount) AS TotalSales
FROM Store
JOIN Purchase ON Store.StoreID = Purchase.StoreID
GROUP BY Store.StoreName;

-- Q10. Customers eligible for Gold tier (500 points or more).
SELECT CustomerID, FullName, CurrentPointBalance
FROM CustomerPointBalance
WHERE CurrentPointBalance >= 500;
