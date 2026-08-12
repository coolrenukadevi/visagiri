<?php
declare(strict_types=1);

/**
 * App bootstrap. No .env file anywhere in this project — per-
 * environment values live in plain PHP files under config/ (outside
 * public/, unreachable by any URL), and editable content (contact
 * details, mail recipients, integration URLs) lives in the
 * site_settings database table instead, changeable from
 * /admin/settings.php without a code deploy. See config/site.php and
 * config/database.php.
 */

$siteConfig = require __DIR__ . '/../config/site.php';

define('APP_ENV', $siteConfig['app_env']);
define('APP_DEBUG', (bool) $siteConfig['app_debug']);
define('APP_URL', rtrim($siteConfig['app_url'], '/'));
define('SESSION_SECURE_COOKIE', (bool) $siteConfig['session_secure_cookie']);

// Writable directory for small local state (rate limiter fallback,
// if ever needed). Not web-reachable: blocked by public/.htaccess in
// both the two-folder and flattened layouts.
define('STORAGE_PATH', __DIR__ . '/../storage');
if (!is_dir(STORAGE_PATH)) {
    mkdir(STORAGE_PATH, 0755, true);
}

if (APP_DEBUG) {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    error_reporting(E_ALL & ~E_DEPRECATED);
}

date_default_timezone_set('Asia/Kolkata');
