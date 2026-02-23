-- ===========================================================================
-- Indexes for Optimized Performance 
-- ===========================================================================

-- 1. Wallet Address Index - for improved Transaction Monitoring performance

CREATE INDEX idx_wallet_address
ON wallets(wallet_address);

-- 2. Transaction Table Indexes - for improved performance with monitoring rules

CREATE INDEX idx_from_wallet ON transactions(from_wallet);
CREATE INDEX idx_to_wallet ON transactions(to_wallet);
CREATE INDEX idx_tx_timestamp ON transactions(tx_timestamp);

-- 3. Entity Addresses - for matching against transactions

CREATE INDEX idx_entity_wallet
ON entity_addresses(wallet_address);

-- 4. Alert Table Indexes - for reporting

CREATE INDEX idx_alert_wallet
ON alerts(wallet_id);