<?php
/**
 * Dev-only router for `php -S localhost:8000 router.php`.
 * Mirrors the clean-URL rules in .htaccess (which Apache handles in
 * production) so clean URLs work under the PHP built-in server too.
 * Legacy 301 redirects are not replicated here — that's Apache-only,
 * production-only behaviour and not needed to develop against.
 */

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$visaRoutes = [
    '#^/visa-services/?$#' => ['view' => 'services_hub'],
    '#^/visa-services/([a-z0-9-]+)/?$#' => ['view' => 'services_type', 'category' => 1],
    '#^/visa-by-country/?$#' => ['view' => 'country_hub'],
    '#^/visa-by-country/([a-z0-9-]+)/([a-z0-9-]+)/?$#' => ['view' => 'category', 'country' => 1, 'category' => 2],
    '#^/visa-by-country/([a-z0-9-]+)/?$#' => ['view' => 'country', 'country' => 1],
];

foreach ($visaRoutes as $pattern => $map) {
    if (preg_match($pattern, $path, $m)) {
        foreach ($map as $key => $value) {
            $_GET[$key] = is_int($value) ? $m[$value] : $value;
        }
        require __DIR__ . '/visa.php';
        return true;
    }
}

$infoRoutes = [
    '#^/visa-information/?$#' => ['view' => 'hub'],
    '#^/visa-information/([a-z0-9-]+)/?$#' => ['view' => 'topic', 'topic' => 1],
];

foreach ($infoRoutes as $pattern => $map) {
    if (preg_match($pattern, $path, $m)) {
        foreach ($map as $key => $value) {
            $_GET[$key] = is_int($value) ? $m[$value] : $value;
        }
        require __DIR__ . '/visa-information.php';
        return true;
    }
}

if (rtrim($path, '/') === '/enquiry') {
    header('Location: /index.php#enquiry');
    return true;
}

$cleanUrlMap = [
    '/about-us' => 'about-us.php',
    '/leadership' => 'leadership.php',
    '/why-choose-us' => 'why-choose-us.php',
    '/careers' => 'careers.php',
    '/partners' => 'partners.php',
    '/support-24x7' => 'support-24x7.php',
    '/contact' => 'contact.php',
    '/track-application' => 'track-application.php',
    '/privacy-policy' => 'privacy-policy.php',
    '/terms-and-conditions' => 'terms-and-conditions.php',
    '/refund-policy' => 'refund-policy.php',
    '/cookie-policy' => 'cookie-policy.php',
    '/disclaimer' => 'disclaimer.php',
    '/accessibility' => 'accessibility.php',
    '/blog' => 'blog.php',
];
$trimmedPath = rtrim($path, '/');
if (isset($cleanUrlMap[$trimmedPath])) {
    require __DIR__ . '/' . $cleanUrlMap[$trimmedPath];
    return true;
}

$xmlMap = ['/sitemap.xml' => 'sitemap.php', '/sitemap-pages.xml' => 'sitemap-pages.php', '/sitemap-visa.xml' => 'sitemap-visa.php'];
if (isset($xmlMap[$path])) {
    require __DIR__ . '/' . $xmlMap[$path];
    return true;
}

// Everything else (index.php, about-us.php, assets/*, ...): default built-in server handling.
return false;
