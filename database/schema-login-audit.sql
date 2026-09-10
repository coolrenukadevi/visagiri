SET FOREIGN_KEY_CHECKS = 0;

-- Best-effort IP -> approximate location cache for the Login Audit page
-- (admin/pages/login-audit.php). IP is already captured on every login
-- attempt today (login_attempts.ip_address, includes/auth.php) — this
-- table only caches the *resolved* geolocation for an IP so the lookup
-- happens once per IP ever seen, not once per page view. Resolution is
-- lazy (only when an admin actually opens the Login Audit page, never
-- during the login request itself) and best-effort: lookup_status
-- records whether it actually resolved, failed (no outbound network
-- reachable, provider error, etc.), or was skipped because the address
-- is a private/reserved range (localhost, LAN) where geolocation is
-- meaningless anyway.
CREATE TABLE IF NOT EXISTS ip_geolocation_cache (
    ip_address VARCHAR(45) NOT NULL PRIMARY KEY,
    country VARCHAR(100) NULL,
    region VARCHAR(100) NULL,
    city VARCHAR(100) NULL,
    lookup_status ENUM('resolved', 'failed', 'private') NOT NULL DEFAULT 'failed',
    resolved_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
