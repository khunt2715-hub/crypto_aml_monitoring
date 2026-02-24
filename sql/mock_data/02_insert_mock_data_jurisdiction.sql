-- =====================================================================
-- Mock Data for Jurisdiction Risk Table
-- Note - Some codes might not be ISO compliant. Modified to match pre-existing mock data
-- Note - Risk scores were selected randomly and not a true reflection of risk
-- =====================================================================

INSERT INTO jurisdiction_risk (country_code, country_name, risk_score) VALUES
('UK', 'United Kingdom', 10),     -- modified to match mock data
('DE', 'Germany', 10),
('US', 'United States', 15),
('AE', 'United Arab Emirates', 30),
('MX', 'Mexico', 30),
('SG', 'Singapore', 25),
('CA', 'Candada', 10),
('HR', 'HighRiskCountry', 60);