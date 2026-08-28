-- B2B Partner CRM — Phase 8: CSV exports, document-expiry panel, and
-- admin-triggered tier recalculation. Additive, run after
-- schema-b2b-phase7.sql. CSV export and the expiry panel need no
-- schema changes at all (they only read existing tables); this file
-- exists purely for the recalculation feature's qualification
-- threshold.

SET FOREIGN_KEY_CHECKS = 0;

-- NULL means "no minimum" — a tier with no threshold can never be
-- reached by recalculation (only assigned manually), which is exactly
-- what an existing tier created before this phase should do: nothing
-- changes for it until an admin deliberately sets a threshold.
ALTER TABLE partner_tiers
    ADD COLUMN min_referred_customers INT UNSIGNED NULL AFTER commission_value;

SET FOREIGN_KEY_CHECKS = 1;
