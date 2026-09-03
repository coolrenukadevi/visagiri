<?php
declare(strict_types=1);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

define('SITE_NAME', 'Videshia');
define('SITE_DOMAIN', 'videshia.com');
define('SITE_TAGLINE', 'AI-Powered Visa Management');
define('SITE_URL', (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'videshia.com'));

// Base path so links work whether the app sits at the domain root or a sub-folder.
$scriptDir = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '/'));
define('BASE_PATH', $scriptDir === '/' ? '' : rtrim($scriptDir, '/'));

date_default_timezone_set('Asia/Kolkata');

error_reporting(E_ALL);
ini_set('display_errors', '0');
