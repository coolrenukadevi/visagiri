<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/db.php';

header('Content-Type: application/xml; charset=UTF-8');

$pdo = db();
$states = $pdo->query("SELECT slug, updated_at FROM states WHERE indexable = 1 ORDER BY name")->fetchAll();

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

echo '  <url><loc>' . htmlspecialchars(SITE_URL . '/visa-consultants-india/', ENT_XML1) . '</loc><changefreq>monthly</changefreq><priority>0.8</priority></url>' . "\n";
echo '  <url><loc>' . htmlspecialchars(SITE_URL . '/states/', ENT_XML1) . '</loc><changefreq>monthly</changefreq><priority>0.6</priority></url>' . "\n";

foreach ($states as $s) {
    echo '  <url>';
    echo '<loc>' . htmlspecialchars(SITE_URL . '/states/' . $s['slug'] . '/', ENT_XML1) . '</loc>';
    echo '<lastmod>' . htmlspecialchars(substr($s['updated_at'], 0, 10), ENT_XML1) . '</lastmod>';
    echo '<changefreq>monthly</changefreq>';
    echo '<priority>0.6</priority>';
    echo '</url>' . "\n";
}
echo '</urlset>';
