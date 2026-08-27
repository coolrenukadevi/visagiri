<?php
declare(strict_types=1);

/**
 * JSON endpoint backing the header's client-side rate refresh
 * (assets/js/site.js polls this every few minutes so the number can
 * update while a visitor's tab stays open, without a full page
 * reload). Read-only, no input taken, so no CSRF/auth concern —
 * same trust level as any other public page on this site.
 */

header('Content-Type: application/json');
header('Cache-Control: no-store');

$result = get_usd_inr_rate();
echo json_encode([
    'rate' => $result['rate'],
    'as_of' => $result['as_of'],
    'stale' => $result['stale'],
]);
