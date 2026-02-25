-- ====================================================================
-- Risk Engine - Aggregate Wallet - User Risk
-- Revised to add KYC factors
-- ====================================================================

-- Step 1: Calculate total risk per user first
INSERT INTO user_risk_summary 
    (user_id, total_risk_score, wallet_count, last_updated, risk_tier)
SELECT 
    t.user_id,
    t.total_risk_score,
    t.wallet_count,
    NOW(),
    CASE
        WHEN t.total_risk_score >= 200 THEN 'high'
        WHEN t.total_risk_score >= 100 THEN 'medium'
        ELSE 'low'
    END AS risk_tier
FROM (
    SELECT 
        u.user_id,
        COALESCE(SUM(wrs.total_risk_score), 0) 
            + COALESCE(jr.risk_score, 0)
            + CASE WHEN u.pep_flag THEN 50 ELSE 0 END AS total_risk_score,
        COUNT(DISTINCT w.wallet_id) AS wallet_count
    FROM users u
    LEFT JOIN wallets w 
        ON u.user_id = w.user_id
    LEFT JOIN wallet_risk_summary wrs 
        ON w.wallet_id = wrs.wallet_id
    LEFT JOIN jurisdiction_risk jr 
        ON u.country_of_residence = jr.country_code
    GROUP BY u.user_id, jr.risk_score, u.pep_flag
) AS t
ON DUPLICATE KEY UPDATE
    total_risk_score = t.total_risk_score,
    wallet_count = t.wallet_count,
    last_updated = NOW(),
    risk_tier = CASE
        WHEN t.total_risk_score >= 200 THEN 'high'
        WHEN t.total_risk_score >= 100 THEN 'medium'
        ELSE 'low'
    END;
    
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


