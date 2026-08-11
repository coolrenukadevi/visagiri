<?php
declare(strict_types=1);

/**
 * Customer dashboard router. $segments comes from public/index.php's
 * dispatch closure ($segments[0] === 'dashboard'). Every sub-page
 * requires a real login — checked once here.
 */

require_login();
require_once __DIR__ . '/../includes/dashboard-layout.php';

$section = $segments[1] ?? null;
$id = isset($segments[2]) ? (int) $segments[2] : null;

switch ($section) {
    case null:
        require __DIR__ . '/pages/overview.php';
        break;

    case 'applications':
        if ($id !== null) {
            require __DIR__ . '/pages/application-detail.php';
        } else {
            require __DIR__ . '/pages/applications.php';
        }
        break;

    case 'documents':
        require __DIR__ . '/pages/documents.php';
        break;

    case 'appointments':
        require __DIR__ . '/pages/appointments.php';
        break;

    case 'payments':
        require __DIR__ . '/pages/payments.php';
        break;

    case 'messages':
        require __DIR__ . '/pages/messages.php';
        break;

    case 'notifications':
        require __DIR__ . '/pages/notifications.php';
        break;

    case 'profile':
        require __DIR__ . '/pages/profile.php';
        break;

    case 'support':
        require __DIR__ . '/pages/support.php';
        break;

    default:
        render_not_found('Dashboard page not found.');
}
