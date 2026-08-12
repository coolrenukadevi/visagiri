<?php
declare(strict_types=1);

/**
 * App-level configuration that isn't practical to store in the
 * database (it has to exist before any DB connection is made, or
 * describes the environment itself rather than editable content).
 * Everything a non-developer would want to change day to day —
 * contact details, mail recipients, the Google Sheets integration URL
 * — lives in the site_settings table instead, editable from
 * /admin/settings.php. No .env file anywhere in this project.
 *
 * Edit these three values directly per environment.
 */

return [
    'app_env' => 'local',              // 'local' or 'production'
    'app_debug' => true,               // false in production
    'app_url' => 'http://127.0.0.1:8106',
    'session_secure_cookie' => false,  // true in production (site is served over HTTPS)
];
