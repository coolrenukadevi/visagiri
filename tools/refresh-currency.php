#!/usr/bin/env php
<?php
/**
 * Cron entry point for refreshing exchange rates.
 *
 * Run every 30 minutes, e.g.:
 *   30-minute crontab line:  0,30 * * * * /usr/bin/php /path/to/tools/refresh-currency.php
 *
 * Running from CLI always permits the remote call (see currency_rates()), so
 * visitors never pay the API latency during a page render.
 */
declare(strict_types=1);
require_once __DIR__ . '/../lib-php/currency.php';

$rates = currency_fetch_remote();
if ($rates) {
    currency_write_cache($rates);
    fwrite(STDOUT, 'ok: ' . json_encode($rates) . PHP_EOL);
    exit(0);
}
fwrite(STDERR, 'failed to refresh rates; existing cache left untouched' . PHP_EOL);
exit(1);
