-- RewardLoop redemption transaction (PostgreSQL)
-- Beginner explanation:
-- 1. Find the reward cost.
-- 2. Find the customer's current balance.
-- 3. If balance is enough, insert a negative points row.
-- 4. Otherwise, stop with an error.
--
-- PostgreSQL uses a procedure to perform the check and insert together.

CREATE OR REPLACE PROCEDURE RedeemReward(
    p_customer_id INT,
    p_reward_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    customer_balance INT;
    reward_cost INT;
BEGIN
    SELECT SUM(PointsChange)
    INTO customer_balance
    FROM LoyaltyPoint
    WHERE CustomerID = p_customer_id;

    SELECT PointsCost
    INTO reward_cost
    FROM Reward
    WHERE RewardID = p_reward_id AND IsActive = TRUE;

    IF customer_balance >= reward_cost THEN
        INSERT INTO LoyaltyPoint
            (PointID, CustomerID, PurchaseID, RewardID, PointsChange, TransactionDate, Notes)
        VALUES
            ((SELECT MAX(PointID) + 1 FROM LoyaltyPoint),
             p_customer_id, NULL, p_reward_id, -reward_cost,
             CURRENT_TIMESTAMP, 'Reward redeemed');
    ELSE
        RAISE EXCEPTION 'Not enough loyalty points to redeem this reward';
    END IF;
END;
$$;

-- Example successful redemption:
-- CALL RedeemReward(1, 1);
--
-- Example rejected redemption:
-- CALL RedeemReward(3, 4);
-- Customer 3 has 50 points, but reward 4 costs 900.
-- If an error occurs inside an explicit transaction, use ROLLBACK.
--
-- Note: this introductory version demonstrates the balance check and insert.
-- In a real multi-user production system, use row locking and a concurrency-safe ID.
