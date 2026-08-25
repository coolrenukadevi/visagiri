<?php
/**
 * Dev-only router for PHP's built-in server (php -S host:port -t . router.php).
 * Mirrors the clean-URL behaviour of .htaccess, since the built-in server does
 * not read .htaccess. Not used on real Apache/Nginx hosting.
 */
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$path = __DIR__ . $uri;

if ($uri !== '/' && file_exists($path) && !is_dir($path)) {
    return false; // serve the requested asset as-is (css/js/images/etc.)
}

if ($uri === '/' || $uri === '') {
    require __DIR__ . '/index.php';
    return true;
}

$clean = trim($uri, '/');

if ($clean === 'sitemap.xml') {
    require __DIR__ . '/sitemap-xml.php';
    return true;
}

if (preg_match('#^countries/([a-z0-9-]+)$#', $clean, $m)) {
    $_GET['slug'] = $m[1];
    require __DIR__ . '/countries.php';
    return true;
}

if (preg_match('#^[a-zA-Z0-9_-]+$#', $clean) && file_exists(__DIR__ . '/' . $clean . '.php')) {
    require __DIR__ . '/' . $clean . '.php';
    return true;
}

http_response_code(404);
require __DIR__ . '/404.php';
return true;
