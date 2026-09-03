<?php
/**
 * Read-only peek at whether a Forex customer is logged in, for the public
 * site's header nav — mirrors includes/partner-nav-state.php exactly.
 * Deliberately does NOT require forex-customer-auth.php / forex-db.php, so
 * every public page doesn't pay for a DB connection just to decide which
 * nav link to show. Session key name must stay in sync with
 * includes/forex-customer-auth.php.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$forexCustomerLoggedIn = !empty($_SESSION['forex_customer_mobile']);
