<?php
/**
 * Public, GET-only JSON endpoint the header's currency widget polls to
 * refresh itself after the initial (server-rendered) value. Deliberately
 * unauthenticated and cheap to call: in the common case it's just a
 * local cache-file read, since exchange_rate_get() only calls out to
 * the live API when the cache has actually gone stale.
 */

header('Content-Type: application/json');
header('Cache-Control: no-store');

require_once __DIR__ . '/includes/exchange-rates.php';

$pair = $_GET['pair'] ?? 'USD_INR';
if (!is_string($pair) || !isset(EXCHANGE_RATE_PAIRS[$pair])) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Unknown currency pair.']);
    exit;
}

$result = exchange_rate_get($pair);

if ($result === null) {
    http_response_code(503);
    echo json_encode(['success' => false, 'message' => 'Exchange rate temporarily unavailable.']);
    exit;
}

echo json_encode(array_merge(['success' => true], $result));
