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

define('DB_HOST', env('DB_HOST', '127.0.0.1'));
define('DB_PORT', env('DB_PORT', '3306'));
define('DB_NAME', env('DB_NAME', 'visagiri'));
define('DB_USER', env('DB_USER', 'visagiri_app'));
define('DB_PASS', env('DB_PASS', ''));
define('DB_CHARSET', env('DB_CHARSET', 'utf8mb4'));

define('MAIL_FROM_NAME', env('MAIL_FROM_NAME', 'Visagiri Website'));
define('MAIL_FROM_ADDRESS', env('MAIL_FROM_ADDRESS', 'info@visagiri.com'));
define('MAIL_ENQUIRY_RECIPIENTS', env('MAIL_ENQUIRY_RECIPIENTS', 'info@visagiri.com,accounts@visagiri.com'));

define('UPLOADS_PATH', realpath(__DIR__ . '/../uploads') ?: __DIR__ . '/../uploads');

if (APP_DEBUG) {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    error_reporting(E_ALL & ~E_DEPRECATED);
}

date_default_timezone_set('Asia/Kolkata');
