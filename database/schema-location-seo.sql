-- National Location SEO — Phase 1: states/UTs + cities + a
-- location-scoped FAQ table (mirroring visa_faqs' nullable-scoping
-- shape), mirroring the existing countries table pattern column-for-
-- column where the concept overlaps. Additive, run after schema.sql.
--
-- `is_indexable` is the explicit human quality gate: rows default to
-- 0 (noindexed, admin-previewable) and only flip to 1 once an admin
-- has confirmed real, unique content exists for that page — never
-- automated, never on insert. `office_address` on `cities` is NULL
-- for every row except a genuine walk-in office; its presence is the
-- sole gate for rendering LocalBusiness/PostalAddress schema on that
-- city's page, so a fabricated local presence is structurally
-- impossible rather than merely a content-review convention.

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE states (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    type ENUM('state', 'union_territory') NOT NULL DEFAULT 'state',
    zone ENUM('North', 'South', 'East', 'West', 'Central', 'Northeast') NULL,
    intro_content TEXT NULL,
    meta_title VARCHAR(255) NULL,
    meta_description VARCHAR(500) NULL,
    is_indexable TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_states_active (is_active),
    KEY idx_states_indexable (is_indexable)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cities (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    state_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL,
    is_major TINYINT(1) NOT NULL DEFAULT 0,
    intro_content TEXT NULL,
    office_address TEXT NULL,
    meta_title VARCHAR(255) NULL,
    meta_description VARCHAR(500) NULL,
    is_indexable TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uniq_city_state_slug (state_id, slug),
    KEY idx_cities_active (is_active),
    KEY idx_cities_indexable (is_indexable),
    CONSTRAINT fk_cities_state FOREIGN KEY (state_id) REFERENCES states(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE location_faqs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(500) NOT NULL,
    answer TEXT NOT NULL,
    state_id BIGINT UNSIGNED NULL,
    city_id BIGINT UNSIGNED NULL,
    sort_order INT NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_location_faqs_state FOREIGN KEY (state_id) REFERENCES states(id) ON DELETE CASCADE,
    CONSTRAINT fk_location_faqs_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
