SET FOREIGN_KEY_CHECKS = 0;

-- General enquiries (pages/contact.php — Visa/Attestation/Forex/Travel/
-- General service types) gain the same two-factor download protection
-- as the unified Visa+Apostille enquiry system (enquiries.tracking_token,
-- database/schema-enquiry-v2.sql): a random per-record token, required
-- alongside the (sequential, guessable) reference number before a PDF
-- receipt can be downloaded — otherwise anyone could enumerate other
-- customers' submissions by reference number alone. Nullable since
-- existing historic rows never had a token generated for them; every
-- new submission from here on populates it.
ALTER TABLE general_enquiries
    ADD COLUMN IF NOT EXISTS tracking_token VARCHAR(20) NULL AFTER enquiry_reference_no,
    ADD COLUMN IF NOT EXISTS pdf_path VARCHAR(255) NULL AFTER tracking_token;

-- Forex requests are staff-created (admin/pages/forex-requests.php),
-- never self-submitted, so there's no moment to hand a customer a
-- fresh random token the way the other two flows do. The public
-- /forex/track/ page already gates access with reference number +
-- registered mobile number (two-factor, non-enumerating) — the new PDF
-- download route reuses that exact same check rather than adding a
-- token nobody could ever give the customer.
ALTER TABLE forex_requests
    ADD COLUMN IF NOT EXISTS pdf_path VARCHAR(255) NULL AFTER status;

SET FOREIGN_KEY_CHECKS = 1;
