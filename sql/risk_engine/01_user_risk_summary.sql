-- ====================================================================
-- Risk Engine - Aggregate Wallet - User Risk
-- ====================================================================

INSERT INTO user_risk_summary (user_id, total_risk_score, wallet_count, last_updated)
SELECT user_id, total_risk_score, wallet_count, last_updated
FROM (
    SELECT 
        w.user_id,
        SUM(wrs.total_risk_score) AS total_risk_score,
        COUNT(DISTINCT w.wallet_id) AS wallet_count,
        NOW() AS last_updated
    FROM wallets w
    LEFT JOIN wallet_risk_summary wrs
        ON w.wallet_id = wrs.wallet_id
    GROUP BY w.user_id
) AS agg
ON DUPLICATE KEY UPDATE
    total_risk_score = agg.total_risk_score,
    wallet_count = agg.wallet_count,
    last_updated = agg.last_updated;
    
-- ========================================================================
-- Validation
-- ========================================================================

SELECT *
FROM user_risk_summary
ORDER BY total_risk_score DESC;

-- ========================================================================
-- VALIDATION - SANTIY CHECK
-- ========================================================================
SELECT 
    u.user_id,
    SUM(wrs.total_risk_score) AS expected_total
FROM users u
JOIN wallets w ON u.user_id = w.user_id
JOIN wallet_risk_summary wrs ON w.wallet_id = wrs.wallet_id
GROUP BY u.user_id;


