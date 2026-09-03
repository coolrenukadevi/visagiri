<?php
require __DIR__ . '/includes/config.php';

header('Content-Type: application/xml; charset=UTF-8');

$pages = [
    ['index.php', '1.0', 'daily'],
    ['about.php', '0.6', 'monthly'],
    ['travel-services.php', '0.8', 'weekly'],
    ['contact.php', '0.6', 'monthly'],
    ['legal.php', '0.3', 'yearly'],
    ['login.php', '0.4', 'yearly'],
    ['signup.php', '0.4', 'yearly'],
];

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
foreach ($pages as [$path, $priority, $freq]) {
    echo '  <url>';
    echo '<loc>' . htmlspecialchars(SITE_URL . '/' . $path, ENT_XML1) . '</loc>';
    echo '<changefreq>' . $freq . '</changefreq>';
    echo '<priority>' . $priority . '</priority>';
    echo '</url>' . "\n";
}
echo '</urlset>';
