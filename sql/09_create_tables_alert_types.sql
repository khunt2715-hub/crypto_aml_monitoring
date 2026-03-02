-- =====================================================================
-- Alert Types Table
-- Purpose - Controlled list of Alert Types for Consistency and Reporting
-- =====================================================================

CREATE TABLE alert_types (
    alert_type_code VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255),
    risk_category VARCHAR(50)  -- e.g., BEHAVIORAL, COUNTERPARTY, SANCTIONS
);