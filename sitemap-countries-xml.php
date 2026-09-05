<?php
/**
 * /sitemap-countries.xml — the real, live country pages: the flat
 * /country-{slug} pages linked from the header, homepage and footer.
 *
 * The /countries/{slug} and /countries/{slug}-{category} routes (see
 * countries.php) now 301-redirect to these flat pages, so they must
 * never appear here — a sitemap should only ever list canonical,
 * directly-indexable URLs, never redirects.
 */
require_once __DIR__ . '/includes/sitemap-helpers.php';
require_once __DIR__ . '/includes/countries-data.php';

$today = gmdate('Y-m-d');

sitemap_open();

foreach ($VISA_AGENCY_COUNTRIES as $c) {
    echo sitemap_url(SITEMAP_BASE . '/country-' . $c['slug'], $today, 'monthly', '0.6');
}

sitemap_close();
