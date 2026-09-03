<?php
/**
 * Dev-only router for `php -S localhost:8000 router.php`.
 * Mirrors the clean-URL rules in .htaccess (which Apache handles in
 * production) so /visa/... routes work under the PHP built-in server too.
 */

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if (preg_match('#^/visa/type/([a-z0-9-]+)/?$#', $path, $m)) {
    $_GET['view'] = 'type';
    $_GET['category'] = $m[1];
    require __DIR__ . '/visa.php';
    return true;
}

if (preg_match('#^/visa/([a-z0-9-]+)/([a-z0-9-]+)/?$#', $path, $m)) {
    $_GET['view'] = 'category';
    $_GET['country'] = $m[1];
    $_GET['category'] = $m[2];
    require __DIR__ . '/visa.php';
    return true;
}

if (preg_match('#^/visa/([a-z0-9-]+)/?$#', $path, $m)) {
    $_GET['view'] = 'country';
    $_GET['country'] = $m[1];
    require __DIR__ . '/visa.php';
    return true;
}

if (preg_match('#^/visa/?$#', $path)) {
    require __DIR__ . '/visa.php';
    return true;
}

$xmlMap = ['/sitemap.xml' => 'sitemap.php', '/sitemap-pages.xml' => 'sitemap-pages.php', '/sitemap-visa.xml' => 'sitemap-visa.php'];
if (isset($xmlMap[$path])) {
    require __DIR__ . '/' . $xmlMap[$path];
    return true;
}

// Everything else (index.php, about.php, assets/*, ...): default built-in server handling.
return false;
