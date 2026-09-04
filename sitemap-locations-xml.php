<?php
/**
 * /sitemap-locations.xml — /visa-consultant/{state}/ and
 * /visa-consultant/{state}/{city}/ pages (published only).
 */
require_once __DIR__ . '/includes/sitemap-helpers.php';
require_once __DIR__ . '/includes/location-db.php';

$today = gmdate('Y-m-d');
$locDb = location_db();

sitemap_open();

$stateStmt = $locDb->query("SELECT id, slug, updated_at FROM states WHERE status = 'published' ORDER BY slug");
foreach ($stateStmt->fetchAll(PDO::FETCH_ASSOC) as $s) {
    $lastmod = substr($s['updated_at'] ?: $today, 0, 10);
    echo sitemap_url(SITEMAP_BASE . '/' . location_state_url($s['slug']), $lastmod, 'monthly', '0.7');

    $cityStmt = $locDb->prepare("SELECT slug, updated_at FROM cities WHERE state_id = ? AND status = 'published' ORDER BY slug");
    $cityStmt->execute([$s['id']]);
    foreach ($cityStmt->fetchAll(PDO::FETCH_ASSOC) as $c) {
        $cityLastmod = substr($c['updated_at'] ?: $today, 0, 10);
        echo sitemap_url(SITEMAP_BASE . '/' . location_city_url($s['slug'], $c['slug']), $cityLastmod, 'monthly', '0.75');
    }
}

sitemap_close();
