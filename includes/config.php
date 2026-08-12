<?php
declare(strict_types=1);

/**
 * Loads environment variables from .env (if present) into getenv()/$_ENV
 * without a Composer dependency, then exposes them as constants.
 */
function visagiri_load_env(string $path): void
{
    if (!is_readable($path)) {
        return;
    }

    foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        $line = trim($line);
        if ($line === '' || str_starts_with($line, '#')) {
            continue;
        }
        if (!str_contains($line, '=')) {
            continue;
        }
        [$name, $value] = explode('=', $line, 2);
        $name = trim($name);
        $value = trim($value);
        $value = trim($value, "\"'");

        if (getenv($name) === false) {
            putenv("$name=$value");
            $_ENV[$name] = $value;
        }
    }
}

visagiri_load_env(__DIR__ . '/../.env');

function env(string $key, ?string $default = null): ?string
{
    $value = getenv($key);
    return $value === false ? $default : $value;
}

define('APP_ENV', env('APP_ENV', 'production'));
define('APP_DEBUG', env('APP_DEBUG', 'false') === 'true');
define('APP_URL', rtrim((string) env('APP_URL', 'https://visagiri.com'), '/'));

define('MAIL_FROM_NAME', env('MAIL_FROM_NAME', 'Visagiri Website'));
define('MAIL_FROM_ADDRESS', env('MAIL_FROM_ADDRESS', 'info@visagiri.com'));
define('MAIL_ENQUIRY_RECIPIENTS', env('MAIL_ENQUIRY_RECIPIENTS', 'info@visagiri.com,accounts@visagiri.com'));

// Google Apps Script Web App URL that appends enquiries to a Sheet and
// saves a copy to Drive — see docs/google-sheets-setup.md. Left empty
// until deployed; submit_enquiry() falls back to email-only in that case.
define('GOOGLE_APPS_SCRIPT_URL', env('GOOGLE_APPS_SCRIPT_URL', ''));

// Writable directory for small local state (currently just the rate
// limiter — see includes/security.php). Not web-reachable: blocked by
// public/.htaccess in both the two-folder and flattened layouts.
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
