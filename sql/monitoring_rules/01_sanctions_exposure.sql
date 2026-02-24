-- ===========================================================================
-- Monitoring Rule - Sanctions Exposure
-- Purpose - To check if any Tranaction's to_wallet matches any wallet in entity_addresses
-- ===========================================================================

-- Step 1: Insert alerts for transactions to risky addresses

INSERT INTO alerts (wallet_id, transaction_id, entity_id, rule_name, risk_score)
SELECT 
    w.wallet_id,
    t.tx_id,
    e.entity_id,
    CONCAT('Exposure to ', e.entity_type) AS rule_name,
    e.base_risk_score AS risk_score
FROM transactions t
JOIN wallets w ON w.wallet_address = t.from_wallet
JOIN entity_addresses ea ON ea.wallet_address = t.to_wallet
JOIN entities e ON e.entity_id = ea.entity_id
WHERE t.tx_timestamp >= '2026-01-01';

-- Step 2: Update wallet risk summary

INSERT INTO wallet_risk_summary (wallet_id, total_risk_score, last_updated)
SELECT wallet_id, total_risk_score, last_updated
FROM (
    SELECT 
        wallet_id,
        SUM(risk_score) AS total_risk_score,
        NOW() AS last_updated
    FROM alerts
    GROUP BY wallet_id
) AS agg
ON DUPLICATE KEY UPDATE
    total_risk_score = agg.total_risk_score,
    last_updated = agg.last_updated;