-- ====================================================================
-- Modifying the User Risk Summary Table - Risk Tier Addition
-- ====================================================================

ALTER TABLE user_risk_summary
ADD COLUMN risk_tier ENUM('low', 'medium', 'high') DEFAULT 'low'