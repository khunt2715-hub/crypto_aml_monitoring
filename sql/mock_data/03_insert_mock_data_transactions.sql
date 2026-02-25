-- ======================================================================
-- Updating Transaction Table with Mock Data
-- ======================================================================

-- Clearing previously populated mock transaction data

-- Turn off safe updates
SET SQL_SAFE_UPDATES = 0;

-- Delete all rows
DELETE FROM transactions;

-- Reset AUTO_INCREMENT
ALTER TABLE transactions AUTO_INCREMENT = 1;

-- Turn safe updates back on
SET SQL_SAFE_UPDATES = 1;

-- Inserting Mock Transactions 

INSERT INTO transactions
(tx_hash, blockchain, from_wallet, to_wallet, amount, token_symbol, usd_value, tx_timestamp)
VALUES
-- Alice's transactions (UK-based)
('0xTxHashA1', 'Ethereum', '0xAliceWallet1', '0xBobWallet1', 5.00000000, 'ETH', 15000.00, '2026-02-23 14:30:00'),
('0xTxHashA2', 'Ethereum', '0xAliceWallet2', '0xCharlieWallet1', 2.50000000, 'ETH', 8000.00, '2026-02-23 16:00:00'),

-- Bob's transactions (PEP user, Germany)
('0xTxHashB1', 'Ethereum', '0xBobWallet1', '0xDinaWallet1', 0.10000000, 'BTC', 500.00, '2026-02-23 10:45:00'),
('0xTxHashB2', 'Ethereum', '0xBobWallet2', '0xEveWallet1', 10.00000000, 'ETH', 20000.00, '2026-02-24 09:20:00'),

-- Charlie's transactions (US-based)
('0xTxHashC1', 'Ethereum', '0xCharlieWallet1', '0xAliceWallet1', 3.00000000, 'ETH', 15000.00, '2026-02-24 11:15:00'),

-- Dina's transactions (UAE-based)
('0xTxHashD1', 'Ethereum', '0xDinaWallet1', '0xEveWallet2', 8.00000000, 'ETH', 30000.00, '2026-02-23 13:00:00'),

-- Eve's transactions (High risk jurisdiction)
('0xTxHashE1', 'Ethereum', '0xEveWallet1', '0xAliceWallet2', 20.00000000, 'ETH', 60000.00, '2026-02-24 15:45:00'),
('0xTxHashE2', 'Ethereum', '0xEveWallet2', '0xBobWallet2', 15.00000000, 'ETH', 50000.00, '2026-02-24 16:30:00');