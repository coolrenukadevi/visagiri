<?php
/**
 * Front controller for the Country x Visa-Purpose SEO system.
 * /countries/{country-slug}/            -> country hub page
 * /countries/{country-slug}-{category}/ -> country x visa-category content page
 * Dispatched here by .htaccess (production) and router.php (local dev).
 */
require_once __DIR__ . '/includes/visa-content-db.php';

$pdo = visa_content_db();
$slug = trim((string) ($_GET['slug'] ?? ''), '/');

if (!preg_match('#^[a-z0-9-]+$#', $slug)) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$countryStmt = $pdo->prepare('SELECT * FROM countries WHERE slug = ? AND is_active = 1');
$countryStmt->execute([$slug]);
$country = $countryStmt->fetch(PDO::FETCH_ASSOC);

if ($country) {
    require __DIR__ . '/includes/visa-content/country-hub.php';
    return;
}

$pageStmt = $pdo->prepare("SELECT cvp.*, c.id AS c_id, c.name AS country_name, c.slug AS country_slug, c.flag AS country_flag,
        c.region AS country_region, vc.id AS vc_id, vc.name AS category_name, vc.slug AS category_slug,
        vc.icon AS category_icon, vc.default_process_steps_json
    FROM country_visa_pages cvp
    JOIN countries c ON c.id = cvp.country_id
    JOIN visa_categories vc ON vc.id = cvp.visa_category_id
    WHERE cvp.page_slug = ? AND cvp.status = 'published'");
$pageStmt->execute([$slug]);
$page = $pageStmt->fetch(PDO::FETCH_ASSOC);

if ($page) {
    require __DIR__ . '/includes/visa-content/country-visa-page.php';
    return;
}

http_response_code(404);
require __DIR__ . '/404.php';
