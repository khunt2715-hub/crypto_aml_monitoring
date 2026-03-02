-- =====================================================================
-- Mock Data - Alet Types Table
-- =====================================================================

INSERT INTO alert_types (alert_type_code, description, risk_category)
VALUES
('RAPID_TXN', 'High transaction velocity within short time window', 'BEHAVIORAL'),
('STRUCTURING', 'Multiple transactions just below reporting threshold', 'BEHAVIORAL'),
('HIGH_RISK_EXPOSURE', 'Exposure to high-risk counterparty wallet', 'COUNTERPARTY'),
('PEP_ASSOCIATION', 'User associated with Politically Exposed Person', 'SANCTIONS');