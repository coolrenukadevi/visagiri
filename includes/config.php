<?php
declare(strict_types=1);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

define('SITE_NAME', 'Videshia');
define('SITE_DOMAIN', 'videshia.com');
define('SITE_TAGLINE', 'Premium Visa Consultancy');
define('SITE_URL', (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'videshia.com'));

// The app is deployed at the domain root. If it ever moves under a sub-folder,
// set that prefix here once rather than deriving it per-script (which breaks
// for nested pages like crm/login.php).
define('BASE_PATH', '');

date_default_timezone_set('Asia/Kolkata');

error_reporting(E_ALL);
ini_set('display_errors', '0');
