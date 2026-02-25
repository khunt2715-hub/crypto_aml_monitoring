-- =========================================================================
-- Wallet level risk aggregation (non-deprecated)
-- =========================================================================

INSERT INTO wallet_risk_summary (wallet_id, total_risk_score, last_updated)
SELECT src.wallet_id, src.total_risk_score, NOW()
FROM (
    SELECT wallet_id, COALESCE(SUM(risk_score), 0) AS total_risk_score
    FROM alerts
    GROUP BY wallet_id
) AS src
ON DUPLICATE KEY UPDATE
    total_risk_score = src.total_risk_score,
    last_updated = NOW();