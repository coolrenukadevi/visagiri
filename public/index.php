<?php

declare(strict_types=1);

/**
 * Front controller. Every request that isn't a real static file under
 * /public is routed through here (see public/.htaccess). Resolves the
 * request path to a handler script and includes it; nothing else on
 * disk outside /public and /uploads is web-reachable directly.
 */

// PHP's built-in dev server (php -S) runs this router for every
// request, including real static files — unlike Apache, which
// public/.htaccess already tells to serve existing files directly.
// Bow out here so `php -S ... index.php` matches production behavior.
if (PHP_SAPI === 'cli-server') {
    $staticPath = urldecode(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/');
    $staticFile = __DIR__ . $staticPath;
    if ($staticPath !== '/' && is_file($staticFile)) {
        return false;
    }
}

require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/database.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/security.php';
require_once __DIR__ . '/../includes/auth.php';

start_secure_session();
send_security_headers();

$requestPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$requestPath = rawurldecode($requestPath);
$segments = array_values(array_filter(explode('/', trim($requestPath, '/'))));

$root = dirname(__DIR__);

/** Includes a handler script with $segments in scope, then stops routing. */
$dispatch = static function (string $absolutePath) use ($segments): void {
    require $absolutePath;
    exit;
};

// Static-looking paths that somehow reach the router (missing file, no
// rewrite match) should 404 rather than fall through to page routing.
if (isset($segments[0]) && preg_match('/\.(css|js|png|jpe?g|svg|webp|gif|ico|woff2?|ttf|map)$/i', $requestPath)) {
    http_response_code(404);
    exit;
}

switch ($segments[0] ?? '') {
    case '':
        $dispatch("$root/pages/home.php");

    case 'about':
        $dispatch("$root/pages/about.php");

    case 'contact':
        $dispatch("$root/pages/contact.php");

    case 'faq':
        $dispatch("$root/pages/faq.php");

    case 'privacy':
    case 'terms':
    case 'refund-policy':
    case 'cookie-policy':
    case 'grievance':
    case 'disclaimer':
        $dispatch("$root/pages/legal.php");

    case 'track-visa':
        $dispatch("$root/pages/track.php");

    case 'visa-process':
        $dispatch("$root/pages/process.php");

    case 'countries':
        $dispatch("$root/countries/index.php");

    case 'visa':
        // /visa/{country}/ or /visa/{country}/{type}/ — country + optional
        // visa-type slug are resolved from the DB inside the handler.
        $dispatch("$root/visa/index.php");

    case 'visa-type':
        $dispatch("$root/visa-type/index.php");

    case 'blog':
        $dispatch("$root/blog/index.php");

    case 'login':
        $dispatch("$root/auth/login.php");

    case 'register':
        $dispatch("$root/auth/register.php");

    case 'logout':
        $dispatch("$root/auth/logout.php");

    case 'forgot-password':
        $dispatch("$root/auth/forgot-password.php");

    case 'dashboard':
        $dispatch("$root/dashboard/index.php");

    case 'admin':
        $dispatch("$root/admin/index.php");

    default:
        $dispatch("$root/pages/404.php");
}
