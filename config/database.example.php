<?php
declare(strict_types=1);

/**
 * Template for config/database.php — copy this to config/database.php
 * and fill in the real values for this environment. config/database.php
 * itself is gitignored (same discipline this project used for .env
 * before): a real database password should never land in version
 * control, even though this file is a plain PHP config rather than an
 * .env file. See config/database.php's own docblock for why it's a
 * plain PHP file at all, and public/.htaccess for how it stays
 * unreachable by any URL.
 */

return [
    'host' => '127.0.0.1',
    'port' => '3306',
    'database' => 'visagiri',
    'username' => 'visagiri_app',
    'password' => 'CHANGE-ME',
    'charset' => 'utf8mb4',
];
