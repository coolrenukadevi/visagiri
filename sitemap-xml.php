<?php
/**
 * /sitemap.xml — a <sitemapindex> referencing the three type-segmented
 * sitemaps (brief section 26: split sitemaps by type). Was previously a
 * single flat <urlset> with every URL in it; split so each sub-sitemap
 * stays independently manageable and under search-engine size limits as
 * the location/country pages keep growing.
 */
header('Content-Type: application/xml; charset=UTF-8');

$base = 'https://visaagency.in';
$today = gmdate('Y-m-d');

$sitemaps = [
    'sitemap-pages.xml',
    'sitemap-countries.xml',
    'sitemap-locations.xml',
];

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
foreach ($sitemaps as $s) {
    echo "  <sitemap>\n    <loc>" . htmlspecialchars($base . '/' . $s) . "</loc>\n    <lastmod>$today</lastmod>\n  </sitemap>\n";
}
echo '</sitemapindex>' . "\n";
