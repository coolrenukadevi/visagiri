<?php
/**
 * POST /mark-notifications-read — the one mutation the notification list in
 * header.php needs. Lives on every page (the dialog it's posted from does
 * too), so it redirects back to wherever the visitor already was rather
 * than owning a page of its own — same shape as the logout forms already
 * scattered across account.php/employee.php.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/notifications.php';

auth_session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && auth_csrf_valid($_POST['csrf'] ?? null)) {
    $for = (string) ($_POST['for'] ?? '');
    if ($for === 'customer') {
        $customer = customer_current();
        if ($customer) notifications_mark_all_read('customer', (int) $customer['id']);
    } elseif ($for === 'employee') {
        $employee = employee_current();
        if ($employee) notifications_mark_all_read('employee', (int) $employee['id']);
    }
}

header('Location: ' . url(auth_safe_next($_POST['next'] ?? '/')), true, 302);
