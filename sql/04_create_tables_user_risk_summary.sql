-- =====================================================================
-- TABLE CREATION - for User Leve Risk Aggregation
-- =====================================================================

CREATE TABLE user_risk_summary (
	user_id INT PRIMARY KEY,
    total_risk_score INT NOT NULL,
    wallet_count INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_user_risk
		FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);