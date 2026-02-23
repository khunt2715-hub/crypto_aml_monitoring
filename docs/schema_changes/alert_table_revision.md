**## Alerts Table Revision**



Originally, the `alerts` table included:



\- `alert\_id` (PK)  

\- `wallet\_id`  

\- `rule\_name`  

\- `risk\_score`  

\- `alert\_timestamp`  

\- `status`



\*\*Limitation:\*\* It did not track \*\*which transaction\*\* or \*\*which high-risk entity\*\* triggered the alert.  



**\*\*Revision Rationale:\*\***  



\- In real-world compliance monitoring, knowing \*\*the specific transaction and entity\*\* is critical for auditability, investigation, and reporting.  

\- Including this information makes risk aggregation and analytics more accurate.



**\*\*Revised `alerts` table structure:\*\***



| Column            | Type | Description |

|------------------|------|-------------|

| `alert\_id`       | INT AUTO\_INCREMENT PK | Unique alert identifier |

| `wallet\_id`      | INT | Wallet that triggered the alert |

| `transaction\_id` | INT | Transaction that caused the alert |

| `entity\_id`      | INT | High-risk entity involved |

| `rule\_name`      | VARCHAR(100) | Monitoring rule that triggered the alert |

| `risk\_score`     | INT | Severity of the alert |

| `alert\_timestamp`| TIMESTAMP | When the alert was generated |

| `status`         | ENUM('open','reviewed','dismissed') | Current alert status |

| `notes`          | VARCHAR(255) | Analyst notes or context |



**\*\*Foreign Keys:\*\***



\- `wallet\_id` → `wallets(wallet\_id)`  

\- `transaction\_id` → `transactions(tx\_id)`  

\- `entity\_id` → `entities(entity\_id)`



**\*\*Impact on Monitoring Logic:\*\***



\- The monitoring SQL now \*\*includes `transaction\_id` and `entity\_id`\*\* when generating alerts.  

\- This allows \*\*wallet risk summaries\*\* and \*\*entity exposure reports\*\* to be generated accurately.  

\- Default values for `alert\_timestamp` and `status` are used unless overridden.  

