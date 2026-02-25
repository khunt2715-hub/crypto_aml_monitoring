-- ====================================================================
-- Analyst Review Queue
-- ====================================================================

CREATE OR REPLACE VIEW analyst_review_queue AS
SELECT 
    urs.user_id,
    u.full_name,
    urs.risk_tier,
    urs.total_risk_score,
    COUNT(a.alert_id) AS open_alerts,
    MAX(a.alert_timestamp) AS most_recent_alert
FROM user_risk_summary urs
JOIN users u ON urs.user_id = u.user_id
LEFT JOIN wallets w ON u.user_id = w.user_id
LEFT JOIN alerts a ON w.wallet_id = a.wallet_id
    AND a.status = 'open'  -- keep the filter here in the JOIN
WHERE urs.risk_tier IN ('medium','high')
GROUP BY urs.user_id, u.full_name, urs.risk_tier, urs.total_risk_score
ORDER BY urs.total_risk_score DESC;