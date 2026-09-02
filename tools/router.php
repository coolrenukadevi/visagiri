<?php
/**
 * Dev router for `php -S` — mirrors the .htaccess rewrite rules so clean URLs
 * can be tested locally without Apache. NOT used in production.
 *
 * Rule order mirrors .htaccess exactly: block -> redirect -> asset passthrough
 * -> internal rewrite. Doing the asset passthrough first (the obvious way)
 * silently serves /index.php and /includes/config.php verbatim, which is both
 * a duplicate-content bug and an information leak.
 */
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// 1. Blocked internals
if (preg_match('#^/(includes|lib-php|lib|cache|tools|data|node_modules)/#', $uri) ||
    preg_match('#^/(\.env|DEVELOPMENT\.md|REDIRECT-MAP\.md)#', $uri)) {
    http_response_code(403); echo 'Forbidden'; return true;
}

// 2. External 301s — before anything can serve the file directly
if (preg_match('#^(.+)\.php$#', $uri, $m)) {
    header('Location: ' . ($m[1] === '/index' ? '/' : $m[1]), true, 301); return true;
}
if ($uri === '/index' || $uri === '/index.html') { header('Location: /', true, 301); return true; }
if (preg_match('#^/visa/([a-z0-9-]+)\.html$#', $uri, $m)) { header('Location: /visa/' . $m[1], true, 301); return true; }
if (preg_match('#^/(countries|payments)\.html$#', $uri, $m)) { header('Location: /' . $m[1], true, 301); return true; }
if ($uri !== '/' && substr($uri, -1) === '/') { header('Location: ' . rtrim($uri, '/'), true, 301); return true; }

// 3. Genuine static assets only
if (preg_match('#^/(css|js|assets|images)/#', $uri) || preg_match('#^/(robots\.txt|favicon\.ico)$#', $uri)) {
    $file = __DIR__ . '/..' . $uri;
    if (file_exists($file) && !is_dir($file)) return false;
}

// 4. Internal rewrites
if ($uri === '/') { require __DIR__ . '/../index.php'; return true; }
if ($uri === '/sitemap.xml') { require __DIR__ . '/../sitemap.php'; return true; }
if (preg_match('#^/sitemap-([a-z]+)\.xml$#', $uri, $m)) { $_GET['set'] = $m[1]; require __DIR__ . '/../sitemap.php'; return true; }
if ($uri === '/visa/request-info') { require __DIR__ . '/../request-info.php'; return true; }
// Sign-in: callback before the provider rule, same ordering as .htaccess.
if (preg_match('#^/auth/callback/(google|facebook|x)$#', $uri, $m)) {
    $_GET['action'] = 'callback'; $_GET['provider'] = $m[1];
    require __DIR__ . '/../auth.php'; return true;
}
if (preg_match('#^/auth/(google|facebook|x)$#', $uri, $m)) {
    $_GET['action'] = 'start'; $_GET['provider'] = $m[1];
    require __DIR__ . '/../auth.php'; return true;
}
if ($uri === '/logout') { $_GET['action'] = 'logout'; require __DIR__ . '/../auth.php'; return true; }
if (preg_match('#^/enquiry/(CV-\d{4}-\d{6})$#', $uri, $m)) { $_GET['code'] = $m[1]; require __DIR__ . '/../enquiry.php'; return true; }
if (preg_match('#^/employee/enquiry/(CV-\d{4}-\d{6})$#', $uri, $m)) { $_GET['code'] = $m[1]; require __DIR__ . '/../employee-enquiry.php'; return true; }
if (preg_match('#^/support/(TK-\d{4}-\d{6})$#', $uri, $m)) { $_GET['code'] = $m[1]; require __DIR__ . '/../support-ticket.php'; return true; }
if (preg_match('#^/employee/ticket/(TK-\d{4}-\d{6})$#', $uri, $m)) { $_GET['code'] = $m[1]; require __DIR__ . '/../employee-ticket.php'; return true; }
if ($uri === '/employee/admin/guidelines') { require __DIR__ . '/../employee-admin-guidelines.php'; return true; }
if ($uri === '/employee/admin') { require __DIR__ . '/../employee-admin.php'; return true; }
if ($uri === '/employee/reports/export') { require __DIR__ . '/../employee-reports-export.php'; return true; }
if ($uri === '/employee/reports') { require __DIR__ . '/../employee-reports.php'; return true; }
// Visa CATEGORY before country, same ordering as .htaccess
$types = 'tourist|business|student|employment|family-dependent|transit|medical|conference|official-diplomatic|renewal|schengen';
if (preg_match("#^/visa/($types)$#", $uri, $m)) { $_GET['type'] = $m[1]; require __DIR__ . '/../visa-type.php'; return true; }
if (preg_match('#^/visa/([a-z0-9-]+)$#', $uri, $m)) { $_GET['country'] = $m[1]; require __DIR__ . '/../visa.php'; return true; }
require_once __DIR__ . '/../data/pages.php';
$slug = ltrim($uri, '/');
if (isset(page_definitions()[$slug])) { $_GET['p'] = $slug; require __DIR__ . '/../page.php'; return true; }

$candidate = __DIR__ . '/..' . $uri . '.php';
if (preg_match('#^/[a-z0-9-]+$#', $uri) && file_exists($candidate)) { require $candidate; return true; }

require __DIR__ . '/../404.php'; return true;
