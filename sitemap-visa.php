<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/db.php';

header('Content-Type: application/xml; charset=UTF-8');
$pdo = db();

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

$url = static function (string $loc, string $priority, string $freq = 'monthly', ?string $lastmod = null) {
    echo '  <url><loc>' . htmlspecialchars($loc, ENT_XML1) . '</loc>';
    echo '<changefreq>' . $freq . '</changefreq><priority>' . $priority . '</priority>';
    if ($lastmod) {
        echo '<lastmod>' . htmlspecialchars(date('Y-m-d', strtotime($lastmod)), ENT_XML1) . '</lastmod>';
    }
    echo '</url>' . "\n";
};

$url(SITE_URL . '/visa-services/', '0.9', 'weekly');
$url(SITE_URL . '/visa-by-country/', '0.9', 'weekly');

foreach ($pdo->query('SELECT slug FROM visa_categories ORDER BY slug') as $cat) {
    $url(SITE_URL . '/visa-services/' . $cat['slug'] . '/', '0.6');
}

// Only indexable content is listed — noindex pages are deliberately excluded
// rather than sent with conflicting signals.
foreach ($pdo->query('SELECT slug, updated_at FROM countries WHERE indexable = 1 ORDER BY slug') as $c) {
    $url(SITE_URL . '/visa-by-country/' . $c['slug'] . '/', '0.7', 'weekly', $c['updated_at']);
}

$catStmt = $pdo->query(
    'SELECT co.slug AS country_slug, vc.slug AS category_slug, cvc.last_reviewed_at
     FROM country_visa_categories cvc
     JOIN countries co ON co.id = cvc.country_id
     JOIN visa_categories vc ON vc.id = cvc.visa_category_id
     WHERE cvc.indexable = 1 ORDER BY co.slug, vc.slug'
);
foreach ($catStmt as $row) {
    $url(SITE_URL . '/visa-by-country/' . $row['country_slug'] . '/' . $row['category_slug'] . '/', '0.8', 'monthly', $row['last_reviewed_at']);
}

echo '</urlset>';
