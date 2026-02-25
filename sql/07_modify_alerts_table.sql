-- ====================================================================
-- Modifying the Alert Table Structure
-- ====================================================================

-- 1. Renaming the Entity_id to User_id

ALTER TABLE alerts
CHANGE entity_id user_id INT NOT NULL;

-- 2. Adding the User_ID Foreign Key

ALTER TABLE alerts
ADD CONSTRAINT fk_alert_user
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

-- 3. Dropping the Entity FK

ALTER TABLE alerts
DROP FOREIGN KEY fk_alert_entity;