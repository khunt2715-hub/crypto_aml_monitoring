-- =====================================================================
-- Indexes - Rules Metadata
-- =====================================================================

CREATE INDEX idx_rule_active
ON rules_metadata (is_active);

CREATE INDEX idx_alert_type
ON rules_metadata(alert_type_code);