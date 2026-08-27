<?php
/**
 * Read-only peek at whether a B2B partner is logged in, for the public
 * site's header nav (includes/nav.php). Deliberately does NOT require
 * partner-auth.php / b2b-db.php — every public page would otherwise pay
 * for a DB connection and its CREATE TABLE IF NOT EXISTS calls just to
 * decide which two nav links to show. Session key names must stay in
 * sync with includes/partner-auth.php.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$b2bPartnerLoggedIn = !empty($_SESSION['partner_user']);
