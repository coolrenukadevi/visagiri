<?php
declare(strict_types=1);

/**
 * HRMS Recruitment CRM router. Distinct from /admin/ — its own login
 * page and branded chrome (includes/hrms-layout.php) — but the same
 * underlying admin_users session and RBAC (includes/rbac.php). Every
 * route except /hrms/login/, /hrms/forgot-password/, and
 * /hrms/reset-password/ requires require_hrms_login() before
 * rendering anything, and fine-grained access beyond "logged in" is
 * enforced per-page via require_permission() — see each page.
 */

require_once __DIR__ . '/../includes/hrms-layout.php';

$hrmsSegment = $segments[1] ?? null;

switch ($hrmsSegment) {
    case 'login':
        require __DIR__ . '/pages/login.php';
        exit;

    case 'forgot-password':
        require __DIR__ . '/pages/forgot-password.php';
        exit;

    case 'reset-password':
        require __DIR__ . '/pages/reset-password.php';
        exit;

    case 'logout':
        require __DIR__ . '/pages/logout.php';
        exit;

    case null:
    case '':
        redirect(is_admin_logged_in() ? '/hrms/dashboard/' : '/hrms/login/');

    case 'dashboard':
        require_hrms_login();
        require __DIR__ . '/pages/dashboard.php';
        exit;

    case 'vacancies':
        require_hrms_login();
        require __DIR__ . '/pages/vacancies.php';
        exit;

    case 'candidates':
        require_hrms_login();
        require __DIR__ . '/pages/candidates.php';
        exit;

    case 'pipeline':
        require_hrms_login();
        require __DIR__ . '/pages/pipeline.php';
        exit;

    case 'document-download':
        require_hrms_login();
        require __DIR__ . '/pages/document-download.php';
        exit;

    default:
        http_response_code(404);
        exit('HRMS page not found.');
}
