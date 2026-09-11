-- Customer testimonials — a real, admin-curated table rather than
-- hardcoded/fabricated quotes in a template. country_id/visa_type_id
-- are both nullable so a testimonial can be general (shown everywhere)
-- or specific to one destination/visa type (shown there first — see
-- fetch_testimonials() in includes/data.php). Nothing renders here
-- until a row is actually inserted and published; see
-- includes/testimonials.php's honest empty state.

CREATE TABLE testimonials (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    customer_location VARCHAR(150) NULL,
    country_id BIGINT UNSIGNED NULL,
    visa_type_id BIGINT UNSIGNED NULL,
    rating TINYINT UNSIGNED NOT NULL DEFAULT 5,
    quote VARCHAR(1000) NOT NULL,
    status ENUM('draft', 'published') NOT NULL DEFAULT 'draft',
    display_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_testimonial_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL,
    CONSTRAINT fk_testimonial_visa_type FOREIGN KEY (visa_type_id) REFERENCES visa_types(id) ON DELETE SET NULL,
    CONSTRAINT chk_testimonial_rating CHECK (rating BETWEEN 1 AND 5)
) ENGINE=InnoDB;

CREATE INDEX idx_testimonials_status_order ON testimonials (status, display_order);
