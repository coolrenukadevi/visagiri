<?php
/**
 * Front controller for the legacy /countries/{slug} SEO system.
 *
 * This system (203 country-hub rows + 1624 country x visa-category rows)
 * was built as a second, parallel country-page architecture alongside the
 * site's real, live one: the flat /country-{slug} pages linked from the
 * header, homepage, footer and every other page. Because nothing site-wide
 * ever linked into /countries/{slug} (only two stray internal links did),
 * it ended up as ~1800 orphaned/duplicate URLs rather than a real second
 * section of the site.
 *
 * Rather than serve duplicate or thin content under a second URL for the
 * same country, every request here permanently redirects to the flat page
 * that's actually part of the site's real navigation and already indexed.
 */
require_once __DIR__ . '/includes/visa-content-db.php';

$pdo = visa_content_db();
$slug = trim((string) ($_GET['slug'] ?? ''), '/');

if (!preg_match('#^[a-z0-9-]+$#', $slug)) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$countryStmt = $pdo->prepare('SELECT slug FROM countries WHERE slug = ? AND is_active = 1');
$countryStmt->execute([$slug]);
$country = $countryStmt->fetch(PDO::FETCH_ASSOC);

if ($country) {
    header('Location: /country-' . $country['slug'], true, 301);
    exit;
}

$pageStmt = $pdo->prepare("SELECT c.slug AS country_slug
    FROM country_visa_pages cvp
    JOIN countries c ON c.id = cvp.country_id
    WHERE cvp.page_slug = ? AND cvp.status = 'published'");
$pageStmt->execute([$slug]);
$page = $pageStmt->fetch(PDO::FETCH_ASSOC);

if ($page) {
    header('Location: /country-' . $page['country_slug'], true, 301);
    exit;
}

http_response_code(404);
require __DIR__ . '/404.php';
