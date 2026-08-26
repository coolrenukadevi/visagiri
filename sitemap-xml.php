<?php
/**
 * Dynamically generated XML sitemap, served at the clean URL /sitemap.xml
 * via a dedicated .htaccess/router.php rewrite (see those files). Replaces
 * the old hand-maintained static sitemap.xml, which had no way to know
 * about the new /countries/ hub and content pages as they're published.
 *
 * Core static pages are listed once here (mirrors what was in the old
 * static file) so nothing that was indexed before is lost. Country hub
 * pages come from the `countries` table; country x visa-category content
 * pages only include rows with status = 'published' — draft/under_review/
 * needs_update/archived pages are intentionally excluded so unfinished
 * content never becomes an indexed thin page.
 */
require_once __DIR__ . '/includes/visa-content-db.php';
require_once __DIR__ . '/includes/countries-data.php';

header('Content-Type: application/xml; charset=UTF-8');

$base = 'https://visaagency.in';

// [path, changefreq, priority] — unchanged from the previous static sitemap.
$staticPages = [
    ['', 'weekly', '1.0'],
    ['privacy-policy', 'yearly', '0.4'],
    ['terms-and-conditions', 'yearly', '0.4'],
    ['cookie-policy', 'yearly', '0.4'],
    ['disclaimer', 'yearly', '0.4'],
    ['refund-policy', 'yearly', '0.4'],
    ['data-security', 'yearly', '0.4'],
    ['sitemap', 'monthly', '0.3'],
    ['service', 'weekly', '0.9'],
    ['service-details', 'monthly', '0.7'],
    ['country-list', 'weekly', '0.9'],
    ['apostille', 'monthly', '0.8'],
    ['apostille-mea', 'monthly', '0.7'],
    ['apostille-embassy-attestation', 'monthly', '0.7'],
    ['apostille-certificate-attestation', 'monthly', '0.7'],
    ['apostille-document-legalisation', 'monthly', '0.7'],
    ['apostille-translation-services', 'monthly', '0.7'],
    ['other-services', 'monthly', '0.6'],
    ['pricing', 'monthly', '0.7'],
    ['appointment', 'monthly', '0.7'],
    ['about', 'monthly', '0.7'],
    ['our-services', 'monthly', '0.8'],
    ['visa-requirements', 'monthly', '0.7'],
    ['visa-checklist', 'monthly', '0.7'],
    ['visa-appointment', 'monthly', '0.7'],
    ['visa-news', 'weekly', '0.6'],
    ['careers', 'monthly', '0.4'],
    ['contact', 'monthly', '0.8'],
    ['news', 'weekly', '0.6'],
    ['news-grid', 'weekly', '0.5'],
    ['news-details', 'monthly', '0.5'],
    ['customer-login', 'yearly', '0.3'],
    ['visa-refusal', 'monthly', '0.5'],
    ['visa-consultancy-services', 'weekly', '0.9'],
    ['visa-tourist', 'monthly', '0.8'],
    ['visa-business', 'monthly', '0.8'],
    ['visa-family', 'monthly', '0.8'],
    ['visa-transit', 'monthly', '0.7'],
    ['visa-sports', 'monthly', '0.7'],
    ['visa-medical', 'monthly', '0.7'],
    ['visa-crew', 'monthly', '0.7'],
    ['visa-extension', 'monthly', '0.7'],
];

$today = gmdate('Y-m-d');

function sitemap_url(string $loc, string $lastmod, string $changefreq, string $priority): string
{
    return "  <url>\n    <loc>" . htmlspecialchars($loc) . "</loc>\n    <lastmod>$lastmod</lastmod>\n    <changefreq>$changefreq</changefreq>\n    <priority>$priority</priority>\n  </url>\n";
}

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

foreach ($staticPages as [$path, $freq, $priority]) {
    echo sitemap_url($base . '/' . $path, $today, $freq, $priority);
}

// Existing static country-{slug} pages — untouched by the new /countries/ system.
foreach ($VISA_AGENCY_COUNTRIES as $c) {
    echo sitemap_url($base . '/country-' . $c['slug'], $today, 'monthly', '0.6');
}

$pdo = visa_content_db();

// New /countries/{slug}/ hub pages, one per active country.
$countryStmt = $pdo->query("SELECT slug, updated_at FROM countries WHERE is_active = 1 ORDER BY slug");
foreach ($countryStmt->fetchAll(PDO::FETCH_ASSOC) as $c) {
    $lastmod = substr($c['updated_at'] ?: $today, 0, 10);
    echo sitemap_url($base . '/' . visa_country_url($c['slug']), $lastmod, 'monthly', '0.7');
}

// New /countries/{slug}-{category}/ content pages — published only.
$pageStmt = $pdo->query("SELECT page_slug, updated_at FROM country_visa_pages WHERE status = 'published' ORDER BY page_slug");
foreach ($pageStmt->fetchAll(PDO::FETCH_ASSOC) as $p) {
    $lastmod = substr($p['updated_at'] ?: $today, 0, 10);
    echo sitemap_url($base . '/' . visa_country_page_url($p['page_slug']), $lastmod, 'monthly', '0.85');
}

echo '</urlset>' . "\n";
