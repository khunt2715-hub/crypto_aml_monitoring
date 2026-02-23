-- ===========================================================================
-- Creating the Table Structure for the Crypto AML Monitoring Project
-- Project Focus - Wallet-level behaviour, alerts and risk scoring.
-- ===========================================================================

-- 1. Users Table - to capture the customers

CREATE TABLE users (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    date_of_birth DATE,
    country_of_residence VARCHAR(100),
    nationality VARCHAR(100),
    kyc_status ENUM('pending', 'verified', 'rejected') DEFAULT 'pending',
    onboarding_risk_rating ENUM('low', 'medium', 'high') DEFAULT 'low',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Wallets Table

CREATE TABLE wallets (
	wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    blockchain VARCHAR(50) NOT NULL,
    wallet_address VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_wallet_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
	);
    
-- 3. Transactions Table

CREATE TABLE transactions (
	tx_id INT AUTO_INCREMENT PRIMARY KEY,
    tx_hash VARCHAR(255) NOT NULL UNIQUE,
    blockchain VARCHAR(50) NOT NULL,
    from_wallet VARCHAR(255) NOT NULL,
    to_wallet VARCHAR(255) NOT NULL,
    amount DECIMAL(18,8) NOT NULL,
    token_symbol VARCHAR(20),
    usd_value DECIMAL(18,2) NOT NULL,
    tx_timestamp DATETIME NOT NULL
);

-- 4. Entities Table - Named Actors

CREATE TABLE entities (
	entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(255) NOT NULL,
    entity_type ENUM('sanctioned', 'mixer', 'darknet_market', 'scam', 'high_risk_exchange') NOT NULL,
    risk_category ENUM('low', 'medium', 'high') NOT NULL DEFAULT 'medium',
    base_risk_score INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Entity Addresses - Maps wallet addresses to entities

CREATE TABLE entity_addresses (
	entity_address_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    wallet_address VARCHAR(255) NOT NULL,
    blockchain VARCHAR(50) NOT NULL,
    
    CONSTRAINT fk_entity
		FOREIGN KEY (entity_id)
        REFERENCES entities(entity_id)
        ON DELETE CASCADE
);

-- 6. Alerts Table 
-- **Revised to include additional value-add fields that weren't included in the original structure

CREATE TABLE alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    wallet_id INT NOT NULL,
    transaction_id INT NOT NULL,
    entity_id INT NOT NULL,
    rule_name VARCHAR(100) NOT NULL,
    risk_score INT NOT NULL,
    alert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('open', 'reviewed', 'dismissed') DEFAULT 'open',
    notes VARCHAR(255),

    CONSTRAINT fk_alert_wallet
        FOREIGN KEY (wallet_id)
        REFERENCES wallets(wallet_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_alert_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(tx_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_alert_entity
        FOREIGN KEY (entity_id)
        REFERENCES entities(entity_id)
        ON DELETE CASCADE
);

-- 7. Wallet Risk Summary Table

CREATE TABLE wallet_risk_summary (
	wallet_id INT PRIMARY KEY,
    total_risk_score INT NOT NULL,
    risk_category ENUM('low', 'medium', 'high') NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_summary_wallet
		FOREIGN KEY (wallet_id)
        REFERENCES wallets(wallet_id)
        ON DELETE CASCADE
);
    
