-- ===================================================================================================
-- Rules Meta Data Table
-- What - A centralized table that defines alert detection rules, versions, risk scores and parameters
-- Purpose - serves as an audit trail and maintains consistent risk classification
-- ===================================================================================================

CREATE TABLE rules_metadata (
	rule_id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Business Mapping
    alert_type_code VARCHAR(50),
    FOREIGN KEY (alert_type_code) REFERENCES alert_types(alert_type_code),
    
    -- Technical identification
    rule_name VARCHAR(100) NOT NULL,
    rule_version VARCHAR(20) NOT NULL,
    
    -- Governance
    description TEXT,
    owner VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Status control
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Risk configuration
    default_risk_score INT NOT NULL,
    
    -- Configurable 
    parameters JSON,
    
	-- Prevent duplicate versions
    UNIQUE KEY unique_rule_version (rule_name, rule_version)
);