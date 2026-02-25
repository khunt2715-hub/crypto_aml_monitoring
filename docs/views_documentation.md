###### **# Monitoring Views Documentation**



This document describes the three core SQL views created for the crypto/fintech compliance monitoring system.



---



**## 1️⃣ Analyst Review Queue (`analyst\_review\_queue`)**



\*\*Purpose:\*\*  

Surfaces medium and high risk users for analyst review, showing open alerts and recent activity.



\*\*Key Columns:\*\*

\- `user\_id` – ID of the user.

\- `full\_name` – User's full name.

\- `risk\_tier` – Risk tier assigned (Low, Medium, High).

\- `total\_risk\_score` – Aggregated risk score from wallets, alerts, jurisdiction, and PEP flag.

\- `open\_alerts` – Number of open alerts for the user.

\- `most\_recent\_alert` – Timestamp of the most recent alert.



\*\*Logic Highlights:\*\*

\- Users are included if their `risk\_tier` is medium or high.

\- Alerts are counted only if `status = 'open'`.

\- LEFT JOIN ensures users without open alerts still appear.

\- Ordered by `total\_risk\_score` descending for analyst prioritization.



---



**## 2️⃣ User Risk Breakdown (`user\_risk\_breakdown`)**



\*\*Purpose:\*\*  

Shows a detailed breakdown of how each user’s total risk score is composed.



\*\*Key Columns:\*\*

\- `user\_id`, `full\_name`

\- `wallet\_risk` – Total risk from user’s wallets.

\- `jurisdiction\_risk` – Risk associated with the user’s country.

\- `pep\_risk` – Additional risk if user is a Politically Exposed Person.

\- `total\_risk\_score` – Combined risk score.

\- `risk\_tier` – Assigned risk tier (Low, Medium, High).



\*\*Logic Highlights:\*\*

\- Aggregates wallet-level risk scores.

\- Includes jurisdiction and PEP weighting.

\- Useful for explainability and audit purposes.



---



**## 3️⃣ Alert Monitoring Summary (`alert\_monitoring\_summary`)**



\*\*Purpose:\*\*  

Provides an overview of alerts generated in the system by rule type.



\*\*Key Columns:\*\*

\- `rule\_name` – Name of the alert rule.

\- `total\_alerts` – Total number of alerts generated.

\- `open\_alerts` – Number of alerts currently open.

\- `avg\_risk\_score` – Average risk score of alerts per rule.



\*\*Logic Highlights:\*\*

\- Aggregates alerts by rule for operational monitoring.

\- Supports identifying high-volume alert types for tuning and investigation.



---



\## Notes



\- These views are intended for internal analyst review and dashboard integration.

\- All views are based on `users`, `wallets`, `alerts`, and risk aggregation tables.

\- They are modular and can be extended with new rules or aggregation logic.



