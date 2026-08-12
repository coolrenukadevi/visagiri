<?php
declare(strict_types=1);

/**
 * Editable site configuration — contact details, mail recipients, the
 * Google Sheets/Drive integration URL, company facts — all live in
 * the site_settings table (see database/schema.sql) instead of an
 * .env file, so an admin can change any of it from
 * /admin/settings.php without a code deploy.
 */
function site_settings(): array
{
    static $cache = null;
    if ($cache === null) {
        $rows = db()->query('SELECT setting_key, setting_value FROM site_settings')->fetchAll();
        $cache = array_column($rows, 'setting_value', 'setting_key');
    }
    return $cache;
}

function setting(string $key, string $default = ''): string
{
    return site_settings()[$key] ?? $default;
}
