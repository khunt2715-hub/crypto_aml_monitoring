-- =============================================================================
-- Inserting Mock Data for Testing Purposes
-- =============================================================================

-- 1. User Data

INSERT INTO users (full_name, date_of_birth, country_of_residence, nationality, kyc_status, onboarding_risk_rating)
VALUES
('Alice Johnson', '1990-05-12', 'US', 'US', 'verified', 'low'),
('Bob Smith', '1985-11-03', 'UK', 'UK', 'verified', 'medium'),
('Carlos Reyes', '1992-07-20', 'MX', 'MX', 'verified', 'medium'),
('Diana Lee', '1988-02-15', 'SG', 'SG', 'verified', 'low'),
('Ethan Chen', '1995-09-30', 'CA', 'CA', 'verified', 'high');

-- 2. Wallet Data

INSERT INTO wallets (user_id, blockchain, wallet_address)
VALUES
(1, 'Ethereum', '0xAlice1'),
(1, 'Bitcoin', '1AliceBTC'),
(2, 'Ethereum', '0xBob1'),
(2, 'Bitcoin', '1BobBTC'),
(3, 'Ethereum', '0xCarlos1'),
(3, 'Bitcoin', '1CarlosBTC'),
(4, 'Ethereum', '0xDiana1'),
(4, 'Bitcoin', '1DianaBTC'),
(5, 'Ethereum', '0xEthan1'),
(5, 'Bitcoin', '1EthanBTC');

-- 3. Entities (Risky Actors)

INSERT INTO entities (entity_name, entity_type, risk_category, base_risk_score)
VALUES
('OFAC SDN Wallet Cluster', 'sanctioned', 'high', 100),
('Mixer Alpha', 'mixer', 'medium', 70),
('Darknet Market X', 'darknet_market', 'high', 90);

-- 4. Entity Addresses

INSERT INTO entity_addresses (entity_id, wallet_address, blockchain)
VALUES
(1, '0xSDN1', 'Ethereum'),
(1, '1SDN1', 'Bitcoin'),
(2, '0xMixer1', 'Ethereum'),
(2, '0xMixer2', 'Ethereum'),
(3, '0xDarkX1', 'Ethereum'),
(3, '1DarkX1', 'Bitcoin');

-- 5. Transactions

INSERT INTO transactions (tx_hash, blockchain, from_wallet, to_wallet, amount, token_symbol, usd_value, tx_timestamp)
VALUES
-- Normal transactions
('tx001', 'Ethereum', '0xAlice1', '0xBob1', 1.2, 'ETH', 2000, '2026-02-23 10:00:00'),
('tx002', 'Bitcoin', '1AliceBTC', '1BobBTC', 0.05, 'BTC', 1500, '2026-02-23 11:00:00'),
('tx003', 'Ethereum', '0xCarlos1', '0xDiana1', 0.8, 'ETH', 1300, '2026-02-23 12:00:00'),
('tx004', 'Bitcoin', '1CarlosBTC', '1DianaBTC', 0.03, 'BTC', 900, '2026-02-23 12:30:00'),
('tx005', 'Ethereum', '0xEthan1', '0xAlice1', 2.5, 'ETH', 4200, '2026-02-23 13:00:00'),

-- Transactions to risky addresses (should trigger alerts)
('tx006', 'Ethereum', '0xAlice1', '0xSDN1', 0.5, 'ETH', 850, '2026-02-23 14:00:00'),
('tx007', 'Bitcoin', '1BobBTC', '1SDN1', 0.02, 'BTC', 600, '2026-02-23 14:30:00'),
('tx008', 'Ethereum', '0xCarlos1', '0xMixer1', 1.0, 'ETH', 1700, '2026-02-23 15:00:00'),
('tx009', 'Ethereum', '0xDiana1', '0xDarkX1', 0.3, 'ETH', 510, '2026-02-23 15:30:00'),
('tx010', 'Bitcoin', '1EthanBTC', '1DarkX1', 0.01, 'BTC', 300, '2026-02-23 16:00:00');