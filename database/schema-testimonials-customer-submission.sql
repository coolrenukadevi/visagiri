-- Lets a logged-in customer submit (and later edit) their own review,
-- tied to their real account — see includes/customer-reviews.php and
-- dashboard/pages/review.php. customer_id is nullable so the existing
-- admin-curated rows (no customer behind them) are untouched; the
-- UNIQUE key means "submit" is really an upsert — one review per
-- customer, editable, never duplicated. photo_path is nullable and
-- points at a public, web-servable file (NOT storage/documents/, which
-- is deliberately private) — see TESTIMONIAL_PHOTO_DIR.

ALTER TABLE testimonials
    ADD COLUMN customer_id BIGINT UNSIGNED NULL AFTER id,
    ADD COLUMN photo_path VARCHAR(255) NULL AFTER quote,
    ADD CONSTRAINT fk_testimonial_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    ADD UNIQUE KEY uniq_testimonial_customer (customer_id);
