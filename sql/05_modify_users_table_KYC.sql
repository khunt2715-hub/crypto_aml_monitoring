-- ====================================================================
-- KYC Risk Fields - Added to Core User Table
-- Adding the PEP_Flag
-- ====================================================================

ALTER TABLE users

ADD COLUMN pep_flag BOOLEAN DEFAULT FALSE;

