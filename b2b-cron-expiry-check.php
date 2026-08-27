<?php
/**
 * Cron entry point for B2B document expiry monitoring (spec §24/§9 of the
 * B2B Partner Portal build). Checks every Verified document of a
 * monitored type (see B2B_DOC_TYPES_WITH_EXPIRY in includes/b2b-db.php)
 * for expiry and sends 30/15/7-day-out alerts plus a final "expired"
 * notice, via b2b_check_document_expiries() — the same function the
 * "Run Expiry Check Now" button on admin/b2b-documents.php calls, so
 * both paths give identical, deduped results.
 *
 * Deployment (cPanel):
 *   Preferred — real CLI cron, once daily:
 *     0 6 * * *  /usr/bin/php /home/USERNAME/public_html/b2b-cron-expiry-check.php
 *
 *   Fallback — shared hosts that only offer "cron via URL" (wget/curl),
 *   not real CLI cron:
 *     0 6 * * *  wget -q -O /dev/null "https://visaagency.in/b2b-cron-expiry-check.php?token=YOUR_CRON_SECRET_TOKEN"
 *   The token is the b2b_settings 'cron_secret_token' value (auto-generated
 *   at first run; view/rotate it from B2B Settings once that admin page
 *   ships). Requests without a valid token are rejected — this endpoint
 *   is not left open to the public internet.
 */
require_once __DIR__ . '/includes/b2b-db.php';

$isCli = PHP_SAPI === 'cli';

if (!$isCli) {
    $pdo = b2b_db();
    $expected = b2b_setting($pdo, 'cron_secret_token', '');
    $provided = $_GET['token'] ?? '';
    if ($expected === '' || !hash_equals($expected, (string) $provided)) {
        http_response_code(403);
        header('Content-Type: text/plain');
        exit("Forbidden.\n");
    }
}

$pdo = b2b_db();
$result = b2b_check_document_expiries($pdo);

$summary = sprintf(
    "B2B document expiry check complete. Checked: %d. Newly expired: %d. New alerts sent: %d.\n",
    $result['checked'], $result['expired'], $result['alerted']
);

if ($isCli) {
    fwrite(STDOUT, $summary);
} else {
    header('Content-Type: text/plain');
    echo $summary;
}
