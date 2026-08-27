<?php
declare(strict_types=1);

require_once __DIR__ . '/../includes/partner-layout.php';

switch ($segments[1] ?? null) {
    case 'login':
        require __DIR__ . '/pages/login.php';
        exit;

    case 'register':
        require __DIR__ . '/pages/register.php';
        exit;

    case 'logout':
        require __DIR__ . '/pages/logout.php';
        exit;

    case 'forgot-password':
        require __DIR__ . '/pages/forgot-password.php';
        exit;

    case 'reset-password':
        require __DIR__ . '/pages/reset-password.php';
        exit;

    case 'dashboard':
    case null:
    case '':
        require_partner_login();
        require __DIR__ . '/pages/dashboard.php';
        exit;

    case 'profile':
        require_partner_login();
        require __DIR__ . '/pages/profile.php';
        exit;

    default:
        require __DIR__ . '/../pages/404.php';
        exit;
}
