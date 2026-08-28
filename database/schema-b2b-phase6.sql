-- B2B Partner CRM — Phase 6: wallet ledger + invoicing. Additive, run
-- after schema-b2b-phase5.sql. Manual/staff-driven throughout — no
-- payment gateway, matching the forex module's own stated stance
-- (Forex Phase A never integrated one either).

SET FOREIGN_KEY_CHECKS = 0;

-- Running account for each partner. A partner's wallet balance is
-- computed on the fly as SUM(credit) - SUM(debit) rather than stored
-- as a denormalized column — this table is the only source of truth,
-- so there's nothing that can drift out of sync with it.
CREATE TABLE partner_wallet_transactions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    partner_id BIGINT UNSIGNED NOT NULL,
    type ENUM('credit', 'debit') NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    reason VARCHAR(255) NOT NULL,
    -- Set when this transaction was generated automatically (e.g. a
    -- commission approval auto-crediting the wallet) so that action
    -- can check "has this already been credited?" before crediting
    -- again. NULL for a manually-entered transaction.
    reference_type VARCHAR(50) NULL,
    reference_id BIGINT UNSIGNED NULL,
    created_by BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_wallet_partner (partner_id, created_at),
    KEY idx_wallet_reference (reference_type, reference_id),
    CONSTRAINT fk_wallet_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_wallet_admin FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE partner_invoices (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    invoice_reference_no VARCHAR(30) NOT NULL UNIQUE,
    partner_id BIGINT UNSIGNED NOT NULL,
    period_start DATE NULL,
    period_end DATE NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'INR',
    status ENUM('draft', 'issued', 'paid') NOT NULL DEFAULT 'draft',
    notes VARCHAR(500) NULL,
    created_by BIGINT UNSIGNED NULL,
    issued_at DATETIME NULL,
    paid_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_invoice_partner (partner_id, created_at),
    CONSTRAINT fk_invoice_partner FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE,
    CONSTRAINT fk_invoice_admin FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
