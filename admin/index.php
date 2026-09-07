<?php
declare(strict_types=1);

/**
 * Admin panel router. $root/$segments come from public/index.php's
 * dispatch closure ($segments[0] === 'admin'). /admin/login/ is the
 * only page reachable without a session; every other sub-route
 * requires require_admin_login() before rendering anything. Fine-
 * grained access beyond "logged in" is enforced per-page via
 * require_permission() (includes/rbac.php) — see each page.
 */

require_once __DIR__ . '/../includes/admin-layout.php';

$adminSegment = $segments[1] ?? null;

switch ($adminSegment) {
    case 'login':
        require __DIR__ . '/pages/login.php';
        exit;

    case 'logout':
        require __DIR__ . '/pages/logout.php';
        exit;

    case null:
    case '':
        redirect(is_admin_logged_in() ? '/admin/dashboard/' : '/admin/login/');

    case 'dashboard':
        require_admin_login();
        require __DIR__ . '/pages/dashboard.php';
        exit;

    case 'sales-crm':
        require_admin_login();
        require __DIR__ . '/pages/sales-crm.php';
        exit;

    case 'finance':
        require_admin_login();
        require __DIR__ . '/pages/finance.php';
        exit;

    case 'customers':
        require_admin_login();
        require __DIR__ . '/pages/customers.php';
        exit;

    case 'partners':
        require_admin_login();
        require __DIR__ . '/pages/partners.php';
        exit;

    case 'b2b-partners':
        require_admin_login();
        require __DIR__ . '/pages/b2b-partners.php';
        exit;

    case 'b2b-partner-document-download':
        require_admin_login();
        require __DIR__ . '/pages/b2b-partner-document-download.php';
        exit;

    case 'b2b-enquiries':
        require_admin_login();
        require __DIR__ . '/pages/b2b-enquiries.php';
        exit;

    case 'b2b-enquiry-document-download':
        require_admin_login();
        require __DIR__ . '/pages/b2b-enquiry-document-download.php';
        exit;

    case 'b2b-support-tickets':
        require_admin_login();
        require __DIR__ . '/pages/b2b-support-tickets.php';
        exit;

    case 'partner-tiers':
        require_admin_login();
        require __DIR__ . '/pages/partner-tiers.php';
        exit;

    case 'partner-invoices':
        require_admin_login();
        require __DIR__ . '/pages/partner-invoices.php';
        exit;

    case 'partner-document-expiry':
        require_admin_login();
        require __DIR__ . '/pages/partner-document-expiry.php';
        exit;

    case 'partner-enquiries':
        require_admin_login();
        require __DIR__ . '/pages/partner-enquiries.php';
        exit;

    case 'visa-enquiries':
        require_admin_login();
        require __DIR__ . '/pages/visa-enquiries.php';
        exit;

    case 'visa-applications':
        require_admin_login();
        require __DIR__ . '/pages/visa-applications.php';
        exit;

    case 'general-enquiries':
        require_admin_login();
        require __DIR__ . '/pages/general-enquiries.php';
        exit;

    case 'enquiries':
        require_admin_login();
        require __DIR__ . '/pages/enquiries.php';
        exit;

    case 'enquiry-document-download':
        require_admin_login();
        require __DIR__ . '/pages/enquiry-document-download.php';
        exit;

    case 'recycle-bin':
        require_admin_login();
        require __DIR__ . '/pages/recycle-bin.php';
        exit;

    case 'grievances':
        require_admin_login();
        require __DIR__ . '/pages/grievances.php';
        exit;

    case 'document-download':
        require_admin_login();
        require __DIR__ . '/pages/document-download.php';
        exit;

    case 'partner-document-download':
        require_admin_login();
        require __DIR__ . '/pages/partner-document-download.php';
        exit;

    case 'countries':
        require_admin_login();
        require __DIR__ . '/pages/countries.php';
        exit;

    case 'locations':
        require_admin_login();
        require __DIR__ . '/pages/locations.php';
        exit;

    case 'visa-types':
        require_admin_login();
        require __DIR__ . '/pages/visa-types.php';
        exit;

    case 'visa-requirements':
        require_admin_login();
        require __DIR__ . '/pages/visa-requirements.php';
        exit;

    case 'faqs':
        require_admin_login();
        require __DIR__ . '/pages/faqs.php';
        exit;

    case 'embassies':
        require_admin_login();
        require __DIR__ . '/pages/embassies.php';
        exit;

    case 'forex-requests':
        require_admin_login();
        require __DIR__ . '/pages/forex-requests.php';
        exit;

    case 'forex-document-download':
        require_admin_login();
        require __DIR__ . '/pages/forex-document-download.php';
        exit;

    case 'forex-rates':
        require_admin_login();
        require __DIR__ . '/pages/forex-rates.php';
        exit;

    case 'forex-country-rules':
        require_admin_login();
        require __DIR__ . '/pages/forex-country-rules.php';
        exit;

    case 'forex-fema-audit':
        require_admin_login();
        require __DIR__ . '/pages/forex-fema-audit.php';
        exit;

    case 'forex-dashboard':
        require_admin_login();
        require __DIR__ . '/pages/forex-dashboard.php';
        exit;

    case 'users':
        require_admin_login();
        require __DIR__ . '/pages/users.php';
        exit;

    case 'roles':
        require_admin_login();
        require __DIR__ . '/pages/roles.php';
        exit;

    case 'audit-log':
        require_admin_login();
        require __DIR__ . '/pages/audit-log.php';
        exit;

    case 'settings':
        require_admin_login();
        require __DIR__ . '/pages/settings.php';
        exit;

    case 'mail-log':
        require_admin_login();
        require __DIR__ . '/pages/mail-log.php';
        exit;

    default:
        http_response_code(404);
        exit('Admin page not found.');
}
