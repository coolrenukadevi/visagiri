<?php
/**
 * Paynancial front controller.
 * All requests are routed here by public/.htaccess. Clean URLs only —
 * no .php extension is ever exposed publicly.
 */

declare(strict_types=1);

require_once __DIR__ . '/../includes/bootstrap.php';

$requestPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$path = trim($requestPath, '/');
$segments = $path === '' ? [] : explode('/', $path);
$current_path = $requestPath;

// ---------------------------------------------------------------------
// API routes — JSON only, no HTML shell.
// ---------------------------------------------------------------------
if (($segments[0] ?? '') === 'api') {
    $apiRoutes = [
        'api/auth/login'            => __DIR__ . '/../api/auth/login.php',
        'api/auth/logout'           => __DIR__ . '/../api/auth/logout.php',
        'api/auth/forgot-password'  => __DIR__ . '/../api/auth/forgot-password.php',
        'api/contact/submit'        => __DIR__ . '/../api/contact/submit.php',
    ];
    $file = $apiRoutes[$path] ?? null;
    if ($file && is_file($file)) {
        require $file;
        exit;
    }
    json_response(['ok' => false, 'error' => 'Not found'], 404);
}

// ---------------------------------------------------------------------
// Authenticated dashboard routes: /{area}/{page}
// ---------------------------------------------------------------------
$dashboardAreas = [
    'customer'    => ['roles' => ['customer'],                         'dir' => 'customer', 'pages' => ['dashboard', 'transactions', 'profile']],
    'partner'     => ['roles' => ['partner'],                          'dir' => 'partner',  'pages' => ['dashboard', 'transactions', 'settlements']],
    'employee'    => ['roles' => ['employee', 'admin', 'super_admin'], 'dir' => 'employee', 'pages' => ['dashboard', 'tasks']],
    'hrms'        => ['roles' => ['hr', 'admin', 'super_admin'],       'dir' => 'hrms',     'pages' => ['dashboard', 'employees', 'recruitment', 'attendance']],
    'admin'       => ['roles' => ['admin', 'super_admin'],             'dir' => 'admin',    'pages' => ['dashboard', 'users', 'transactions', 'cms', 'enquiries']],
    'super-admin' => ['roles' => ['super_admin'],                      'dir' => 'admin',    'pages' => ['dashboard']],
];

if (isset($dashboardAreas[$segments[0] ?? ''])) {
    $areaSlug = $segments[0];
    $area = $dashboardAreas[$areaSlug];
    $page = $segments[1] ?? 'dashboard';

    if (!in_array($page, $area['pages'], true)) {
        http_response_code(404);
        include __DIR__ . '/../pages/404.php';
        exit;
    }

    $auth_user = require_role($area['roles']);
    $dashboard_area = $areaSlug;
    $dashboard_page = $page;
    $file = __DIR__ . '/../' . $area['dir'] . '/' . $page . '.php';

    if (!is_file($file)) {
        http_response_code(404);
        include __DIR__ . '/../pages/404.php';
        exit;
    }

    ob_start();
    require $file; // may set $page_meta
    $dashboard_body = ob_get_clean();

    include __DIR__ . '/../includes/dashboard-head.php';
    echo $dashboard_body;
    include __DIR__ . '/../includes/dashboard-foot.php';
    exit;
}

// ---------------------------------------------------------------------
// Legal pages: /legal/{slug}
// ---------------------------------------------------------------------
if (($segments[0] ?? '') === 'legal') {
    $legal_slug = $segments[1] ?? '';
    ob_start();
    include __DIR__ . '/../pages/legal.php';
    $page_body = ob_get_clean();

    include __DIR__ . '/../includes/site-head.php';
    include __DIR__ . '/../includes/header.php';
    echo '<main id="main-content">' . $page_body . '</main>';
    include __DIR__ . '/../includes/footer.php';
    include __DIR__ . '/../includes/site-foot.php';
    exit;
}

// ---------------------------------------------------------------------
// Public marketing pages.
// ---------------------------------------------------------------------
$publicRoutes = [
    ''                 => 'home',
    'about'            => 'about',
    'solutions'        => 'solutions',
    'products'         => 'products',
    'pricing'          => 'pricing',
    'developers'       => 'developers',
    'partners'         => 'partners',
    'support'          => 'support',
    'contact'          => 'contact',
    'careers'          => 'careers',
    'security'         => 'security-compliance',
    'blog'             => 'blog',
    'login'            => 'home',
    'forgot-password'  => 'forgot-password',
];

$pageSlug = $publicRoutes[$path] ?? null;
$notFound = false;

if ($pageSlug === null) {
    http_response_code(404);
    $pageFile = __DIR__ . '/../pages/404.php';
    $notFound = true;
} else {
    $pageFile = __DIR__ . '/../pages/' . $pageSlug . '.php';
    if (!is_file($pageFile)) {
        http_response_code(404);
        $pageFile = __DIR__ . '/../pages/404.php';
        $notFound = true;
    }
}

ob_start();
include $pageFile;
$page_body = ob_get_clean();

include __DIR__ . '/../includes/site-head.php';
include __DIR__ . '/../includes/header.php';
echo '<main id="main-content">' . $page_body . '</main>';
include __DIR__ . '/../includes/footer.php';
include __DIR__ . '/../includes/site-foot.php';
