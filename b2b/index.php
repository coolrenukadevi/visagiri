<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal router. Standalone from /partner/ by
 * design — own auth (includes/b2b-partner-auth.php), own session key,
 * own entity tables (database/schema-b2b-portal.sql).
 */

switch ($segments[1] ?? null) {
    case 'register':
        require __DIR__ . '/pages/register.php';
        exit;

    case 'register-contact':
        require __DIR__ . '/pages/register-contact.php';
        exit;

    case 'register-documents':
        require_b2b_partner_login();
        require __DIR__ . '/pages/register-documents.php';
        exit;

    case 'register-services':
        require_b2b_partner_login();
        require __DIR__ . '/pages/register-services.php';
        exit;

    case 'register-billing':
        require_b2b_partner_login();
        require __DIR__ . '/pages/register-billing.php';
        exit;

    case 'register-declaration':
        require_b2b_partner_login();
        require __DIR__ . '/pages/register-declaration.php';
        exit;

    case 'register-complete':
        require_b2b_partner_login();
        require __DIR__ . '/pages/register-complete.php';
        exit;

    case 'login':
        require __DIR__ . '/pages/login.php';
        exit;

    case 'logout':
        log_out_b2b_partner_user();
        redirect('/b2b/login/');

    case 'dashboard':
        require_b2b_partner_login();
        require __DIR__ . '/pages/dashboard.php';
        exit;

    default:
        redirect('/b2b-partner/');
}
