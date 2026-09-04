<?php
require __DIR__ . '/includes/config.php';

header('Content-Type: application/xml; charset=UTF-8');

$sitemaps = ['sitemap-pages.xml', 'sitemap-visa.xml', 'sitemap-locations.xml'];

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
foreach ($sitemaps as $s) {
    echo '  <sitemap><loc>' . htmlspecialchars(SITE_URL . '/' . $s, ENT_XML1) . '</loc></sitemap>' . "\n";
}
echo '</sitemapindex>';
