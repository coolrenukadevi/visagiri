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

// The one layout-dependent line in this file: two-folder dev/deploy
// (this file lives in public/, everything else is a sibling one level
// up) uses dirname(__DIR__); the flattened single-folder cPanel
// package (bin/package-cpanel.sh, which patches exactly this line)
// uses __DIR__, since index.php IS the root there. Every other path
// in this file is built from $root, so this is the only place that
// needs to differ between the two layouts.
$root = dirname(__DIR__);

require_once "$root/includes/config.php";
require_once "$root/includes/functions.php";
require_once "$root/includes/data.php";
require_once "$root/includes/security.php";

start_secure_session();
send_security_headers();

$requestPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$requestPath = rawurldecode($requestPath);
$segments = array_values(array_filter(explode('/', trim($requestPath, '/'))));

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
    case 'travel-terms':
    case 'payment-policy':
    case 'refund-policy':
    case 'cookie-policy':
    case 'grievance':
    case 'disclaimer':
        $dispatch("$root/pages/legal.php");

    case 'sitemap':
        $dispatch("$root/pages/sitemap.php");

    case 'sitemap.xml':
        $dispatch("$root/pages/sitemap-xml.php");

    case 'support':
        // The old support-ticket system needed an account to sign into;
        // there's no account system anymore, so this now goes straight
        // to the one real enquiry channel.
        redirect('/contact/', 301);

    case 'visa-process':
        $dispatch("$root/pages/process.php");

    case 'visa-search':
        $dispatch("$root/pages/visa-search.php");

    case 'attestation':
        $dispatch("$root/attestation/index.php");

    case 'careers':
        $dispatch("$root/pages/careers.php");

    case 'leadership':
        $dispatch("$root/pages/leadership.php");

    case 'our-team':
        $dispatch("$root/pages/our-team.php");

    case 'affiliations':
        $dispatch("$root/pages/affiliations.php");

    case 'partners':
        $dispatch("$root/pages/partners.php");

    case 'corporate-services':
        $dispatch("$root/pages/corporate-services.php");

    case 'document-checklists':
        $dispatch("$root/pages/document-checklists.php");

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

    default:
        $dispatch("$root/pages/404.php");
}
