#### **Crypto AML Monitoring \& Risk Scoring Engine**



##### **Overview**



This project simulates a crypto exchange Anti-Money Laundering (AML) monitoring system, built in MySQL 8.



It demonstrates how a fintech or crypto platform can detect high-risk activity, generate compliance alerts, and prioritize wallet-level risk for review — translating regulatory requirements into actionable data insights.



The system reflects **real-world compliance workflows**, including:



* Customer onboarding with KYC and risk profiling
* Wallet ownership and transaction tracking
* Monitoring exposure to sanctioned or high-risk external entities
* Alert generation and risk aggregation for decision-making



##### **Business Goals**



* **Reduce regulatory risk:** Identify suspicious activity and risky wallets before escalation
* **Increase efficiency:** Automate detection rules and alert generation
* **Enable actionable insights:** Provide wallet-level risk scoring to prioritize investigation
* **Maintain auditability:** Track monitoring rules, alerts, and scoring logic in a structured database



##### **How It Works**



The system models two core environments:



1. **Internal Exchange Environment**



* Users and their wallets

* On-chain transactions they initiate or receive



**2. External Risk Intelligence**



* Known high-risk wallet addresses (sanctioned, mixers, darknet markets)
* Linked entities with risk categories and scores



Monitoring rules detect interactions between internal wallets and external risk entities, producing alerts that roll up into a wallet-level risk score, helping compliance teams focus on the highest-risk cases.



##### **Current Capabilities**



* Relational database schema with foreign keys and indexing for performance
* Rule-ready structure for sanctions exposure, mixer interaction, and rapid movement patterns
* Alerts table for operational tracking
* Wallet risk summary table for prioritization



Future enhancements will include additional behavioral monitoring rules and automated risk scoring logic.



##### **Tech Stack**



* MySQL 8 (database design and analytics)
* MySQL Workbench (schema visualization and query testing)
* GitHub (version control and documentation)
