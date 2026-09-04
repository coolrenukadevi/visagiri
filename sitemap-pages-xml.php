<?php
/**
 * /sitemap-pages.xml — every static (non-database-driven) indexable page.
 * One of the three sitemaps sitemap.xml (a <sitemapindex>) references.
 */
require_once __DIR__ . '/includes/sitemap-helpers.php';

$today = gmdate('Y-m-d');

sitemap_open();
foreach (sitemap_static_pages() as [$path, $freq, $priority]) {
    echo sitemap_url(SITEMAP_BASE . '/' . $path, $today, $freq, $priority);
}
sitemap_close();
