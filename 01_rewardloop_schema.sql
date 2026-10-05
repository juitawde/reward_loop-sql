-- RewardLoop database schema
-- Beginner-friendly SQL (PostgreSQL)

DROP VIEW IF EXISTS CustomerPointBalance;
DROP TABLE IF EXISTS LoyaltyPoint;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Reward;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    JoinDate DATE NOT NULL
);

CREATE TABLE Store (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    StoreAddress VARCHAR(200) NOT NULL,
    City VARCHAR(80) NOT NULL
);

CREATE TABLE Purchase (
    PurchaseID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    StoreID INT NOT NULL,
    PurchaseDate TIMESTAMP NOT NULL,
    PurchaseAmount DECIMAL(10,2) NOT NULL CHECK (PurchaseAmount > 0),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);

CREATE TABLE Reward (
    RewardID INT PRIMARY KEY,
    RewardName VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(300) NOT NULL,
    PointsCost INT NOT NULL CHECK (PointsCost > 0),
    RewardTier VARCHAR(30) NOT NULL,
    IsActive BOOLEAN NOT NULL
);

-- Positive PointsChange means points earned.
-- Negative PointsChange means points redeemed.
CREATE TABLE LoyaltyPoint (
    PointID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PurchaseID INT,
    RewardID INT,
    PointsChange INT NOT NULL CHECK (PointsChange <> 0),
    TransactionDate TIMESTAMP NOT NULL,
    Notes VARCHAR(250),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (PurchaseID) REFERENCES Purchase(PurchaseID),
    FOREIGN KEY (RewardID) REFERENCES Reward(RewardID),
    CHECK (
        (PointsChange > 0 AND PurchaseID IS NOT NULL AND RewardID IS NULL)
        OR
        (PointsChange < 0 AND PurchaseID IS NULL AND RewardID IS NOT NULL)
    )
);

-- A view calculates the balance from the transaction history.
CREATE VIEW CustomerPointBalance AS
SELECT Customer.CustomerID, Customer.FullName,
       SUM(LoyaltyPoint.PointsChange) AS CurrentPointBalance
FROM Customer
LEFT JOIN LoyaltyPoint
ON Customer.CustomerID = LoyaltyPoint.CustomerID
GROUP BY Customer.CustomerID, Customer.FullName;
