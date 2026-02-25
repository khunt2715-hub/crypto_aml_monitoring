-- =====================================================================
-- Monitoring Rules 
-- =====================================================================

-- 1. Clear all existing alerts
TRUNCATE TABLE alerts;

-- 2. Generate alerts dynamically based on current transactions and rules

-- Clear existing alerts first
DELETE FROM alerts WHERE alert_id > 0;
ALTER TABLE alerts AUTO_INCREMENT = 1;

-- Large Transaction Rules
-- Generate alerts for large transactions (USD > 10,000) for both the sender wallet (from_sender) and receiver wallet (to_wallet)

INSERT INTO alerts (
    wallet_id, 
    transaction_id,
    user_id,
    rule_name, 
    risk_score
)
-- Alerts for sender (from_wallet)
SELECT 
    w.wallet_id AS wallet_id,
    t.tx_id,
    w.user_id,
    'Large Transaction' AS rule_name,
    CASE 
        WHEN t.usd_value > 50000 THEN 100
        WHEN t.usd_value > 20000 THEN 80
        ELSE 50
    END AS risk_score
FROM transactions t
JOIN wallets w ON t.from_wallet = w.wallet_address
JOIN users u ON w.user_id = u.user_id  -- ensures user FK passes
WHERE t.usd_value > 10000

UNION ALL

-- Alerts for receiver (to_wallet)
SELECT 
    w.wallet_id AS wallet_id,
    t.tx_id,
    w.user_id,
    'Large Transaction' AS rule_name,
    CASE 
        WHEN t.usd_value > 50000 THEN 100
        WHEN t.usd_value > 20000 THEN 80
        ELSE 50
    END AS risk_score
FROM transactions t
JOIN wallets w ON t.to_wallet = w.wallet_address
JOIN users u ON w.user_id = u.user_id
WHERE t.usd_value > 10000;

