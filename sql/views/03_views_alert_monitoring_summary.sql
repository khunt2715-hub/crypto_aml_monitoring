-- ====================================================================
-- Alert Monitoring View
-- ====================================================================

CREATE OR REPLACE VIEW alert_monitoring_summary AS
SELECT 
    rule_name,
    COUNT(*) AS total_alerts,
    SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END) AS open_alerts,
    AVG(risk_score) AS avg_risk_score
FROM alerts
GROUP BY rule_name
ORDER BY total_alerts DESC;