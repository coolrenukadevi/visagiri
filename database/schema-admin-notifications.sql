-- Admin notification bell — one row per recipient admin, same shape
-- as the existing customer_notifications/partner_notifications/
-- b2b_partner_notifications tables (type/title/body/link/is_read),
-- plus read_at since "never lose when it was read" was explicitly
-- asked for and costs nothing to add. No separate read_by column:
-- unlike a shared/broadcast notification, each row already belongs to
-- exactly one admin via admin_user_id, so the row owner IS the reader
-- — a redundant read_by would just duplicate that.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS admin_notifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admin_user_id BIGINT UNSIGNED NOT NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NULL,
    link VARCHAR(255) NULL,
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    read_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_admin_notif_admin (admin_user_id, is_read, created_at),
    CONSTRAINT fk_admin_notif_admin FOREIGN KEY (admin_user_id) REFERENCES admin_users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
