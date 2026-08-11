<?php
declare(strict_types=1);

/**
 * Consultant router — Phase 14. Gated to the `consultant` role only;
 * admins already have full system-wide access via /admin/, so this
 * panel isn't dual-purposed for them. Mirrors admin/index.php's
 * $segments-based dispatch.
 */

require_role(['consultant']);
require_once __DIR__ . '/../includes/consultant-layout.php';
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

    default:
        render_not_found('Consultant page not found.');
}
