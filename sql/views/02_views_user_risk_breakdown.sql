-- =====================================================================
-- User Risk Breakdown
-- =====================================================================

CREATE OR REPLACE VIEW user_risk_breakdown AS
SELECT 
    u.user_id,
    u.full_name,
    COALESCE(SUM(wrs.total_risk_score), 0) AS wallet_risk,
    COALESCE(jr.risk_score, 0) AS jurisdiction_risk,
    CASE WHEN u.pep_flag THEN 50 ELSE 0 END AS pep_risk,
    urs.total_risk_score,
    urs.risk_tier
FROM users u
LEFT JOIN wallets w ON u.user_id = w.user_id
LEFT JOIN wallet_risk_summary wrs ON w.wallet_id = wrs.wallet_id
LEFT JOIN jurisdiction_risk jr ON u.country_of_residence = jr.country_code
LEFT JOIN user_risk_summary urs ON u.user_id = urs.user_id
GROUP BY 
    u.user_id,
    u.full_name,
    jr.risk_score,
    u.pep_flag,
    urs.total_risk_score,
    urs.risk_tier;