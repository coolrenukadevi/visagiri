<?php
/**
 * /sitemap-countries.xml — legacy static country-{slug} pages, the
 * /countries/{slug}/ hub pages, and the /countries/{slug}-{category}/
 * content pages (published only — draft/under_review/needs_update/
 * archived are intentionally excluded, per the brief's "never include
 * a non-indexable page in the sitemap" rule).
 */
require_once __DIR__ . '/includes/sitemap-helpers.php';
require_once __DIR__ . '/includes/visa-content-db.php';
require_once __DIR__ . '/includes/countries-data.php';

$today = gmdate('Y-m-d');
$pdo = visa_content_db();

sitemap_open();

foreach ($VISA_AGENCY_COUNTRIES as $c) {
    echo sitemap_url(SITEMAP_BASE . '/country-' . $c['slug'], $today, 'monthly', '0.6');
}

$countryStmt = $pdo->query("SELECT slug, updated_at FROM countries WHERE is_active = 1 ORDER BY slug");
foreach ($countryStmt->fetchAll(PDO::FETCH_ASSOC) as $c) {
    $lastmod = substr($c['updated_at'] ?: $today, 0, 10);
    echo sitemap_url(SITEMAP_BASE . '/' . visa_country_url($c['slug']), $lastmod, 'monthly', '0.7');
}

$pageStmt = $pdo->query("SELECT page_slug, updated_at FROM country_visa_pages WHERE status = 'published' ORDER BY page_slug");
foreach ($pageStmt->fetchAll(PDO::FETCH_ASSOC) as $p) {
    $lastmod = substr($p['updated_at'] ?: $today, 0, 10);
    echo sitemap_url(SITEMAP_BASE . '/' . visa_country_page_url($p['page_slug']), $lastmod, 'monthly', '0.85');
}

sitemap_close();
