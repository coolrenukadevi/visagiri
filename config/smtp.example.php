<?php
declare(strict_types=1);

/**
 * Template for config/smtp.php — copy this to config/smtp.php and
 * fill in real values. config/smtp.php itself is gitignored, same
 * discipline as config/database.php and config/encryption.php: a
 * mailbox password should never land in version control.
 *
 * If config/smtp.php doesn't exist at all, includes/mail.php's
 * send_mail() simply returns false — every caller already treats a
 * failed send as non-fatal (the registration/reset flow still works,
 * just falls back to showing the link on-screen in APP_DEBUG mode,
 * same as before email sending existed). Nothing breaks by leaving
 * this unconfigured; email just doesn't go out yet.
 *
 * 'encryption' is 'tls' for STARTTLS on port 587 (the common case for
 * most providers and standard cPanel mail), or 'ssl' for implicit TLS
 * on port 465. Leave 'from_email' as a real, deliverable mailbox on
 * your own domain — most providers reject or spam-flag mail whose
 * From: address doesn't match the authenticated account's domain.
 *
 * If your cPanel host lets you relay unauthenticated through its own
 * local mail server (common on shared hosting — check with your host
 * if unsure), leave 'username'/'password' empty and 'encryption' as
 * '' with host 'localhost' and port 25.
 */

return [
    'host' => 'smtp.example.com',
    'port' => 587,
    'encryption' => 'tls',
    'username' => 'noreply@visagiri.com',
    'password' => 'CHANGE-ME',
    'from_email' => 'noreply@visagiri.com',
    'from_name' => 'Visagiri',
];
