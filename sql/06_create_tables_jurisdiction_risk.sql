-- ====================================================================
-- Creating the Jurisdication Risk Table
-- Note - Will capture the jurisdicion score only. Risk Rating based on scoring threshold to be maintained at the policy level
-- ====================================================================

CREATE TABLE jurisdiction_risk (
	country_code CHAR(2) PRIMARY KEY,      -- ISO 3166-1 alpha-2
    country_name VARCHAR(100) NOT NULL,
    risk_score INT NOT NULL
);
