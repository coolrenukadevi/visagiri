<?php
declare(strict_types=1);

/**
 * Customer dashboard router. $segments comes from public/index.php's
 * dispatch closure; sub-pages are required directly via __DIR__
 * (not via $root/$dispatch, which aren't imported into that closure's
 * scope) — same convention as admin/index.php.
 */

require_once __DIR__ . '/../includes/dashboard-layout.php';

require_customer_login();

switch ($segments[1] ?? null) {
    case null:
    case '':
        require __DIR__ . '/pages/overview.php';
        exit;

    case 'applications':
        require __DIR__ . '/pages/applications.php';
        exit;

    case 'documents':
        require __DIR__ . '/pages/documents.php';
        exit;

    case 'document-download':
        require __DIR__ . '/pages/document-download.php';
        exit;

    case 'document-upload':
        require __DIR__ . '/pages/document-upload.php';
        exit;

    case 'appointments':
        require __DIR__ . '/pages/appointments.php';
        exit;

    case 'payments':
        require __DIR__ . '/pages/payments.php';
        exit;

    case 'messages':
        require __DIR__ . '/pages/messages.php';
        exit;

    case 'notifications':
        require __DIR__ . '/pages/notifications.php';
        exit;

    case 'profile':
        require __DIR__ . '/pages/profile.php';
        exit;

    default:
        require __DIR__ . '/../pages/404.php';
        exit;
}
