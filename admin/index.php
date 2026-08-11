<?php
declare(strict_types=1);

/**
 * Admin router — Phase 13. Every admin page requires super_admin or
 * admin; nothing here is reachable by a customer or consultant
 * account. Mirrors dashboard/index.php's $segments-based dispatch.
 */

require_role(['super_admin', 'admin']);
require_once __DIR__ . '/../includes/admin-layout.php';
require_once __DIR__ . '/../includes/dashboard-layout.php';
require_once __DIR__ . '/../includes/document-management.php';

$section = $segments[1] ?? null;
$id = isset($segments[2]) ? (int) $segments[2] : null;
$action = $segments[3] ?? null;

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
        if ($id !== null && $action === 'approve') {
            require __DIR__ . '/pages/document-approve.php';
        } elseif ($id !== null && $action === 'reject') {
            require __DIR__ . '/pages/document-reject.php';
        } elseif ($id !== null && $action === 'download') {
            require __DIR__ . '/pages/document-download.php';
        } else {
            require __DIR__ . '/pages/documents.php';
        }
        break;

    case 'users':
        if ($id !== null && $action === 'toggle-status') {
            require __DIR__ . '/pages/user-toggle-status.php';
        } else {
            require __DIR__ . '/pages/users.php';
        }
        break;

    case 'support':
        if ($id !== null) {
            require __DIR__ . '/pages/support-update.php';
        } else {
            require __DIR__ . '/pages/support.php';
        }
        break;

    default:
        render_not_found('Admin page not found.');
}
