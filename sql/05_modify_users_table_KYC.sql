-- ====================================================================
-- KYC Risk Fields - Added to Core User Table
-- Alerting the Users table to capture Country of Residence, PEP_Flag and KYC_Risk Score
-- ====================================================================

ALTER TABLE users
ADD COLUMN country_of_residence VARCHAR(100),
ADD COLUMN pep_flag BOOLEAN DEFAULT FALSE,
ADD COLUMN key_risk_score INT DEFAULT 0;
