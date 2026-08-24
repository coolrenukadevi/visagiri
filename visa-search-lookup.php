<?php
/**
 * Read-only JSON lookup used by the homepage visa search widget to resolve
 * a country + visa-category selection to the correct destination URL.
 */
require_once __DIR__ . '/includes/visa-content-db.php';
header('Content-Type: application/json');

$pdo = visa_content_db();
$countrySlug = trim((string) ($_GET['country'] ?? ''));
$categorySlug = trim((string) ($_GET['category'] ?? ''));

if (!preg_match('#^[a-z0-9-]+$#', $countrySlug)) {
    echo json_encode(['ok' => false]);
    return;
}

$countryStmt = $pdo->prepare('SELECT id, name FROM countries WHERE slug = ? AND is_active = 1');
$countryStmt->execute([$countrySlug]);
$country = $countryStmt->fetch(PDO::FETCH_ASSOC);

if (!$country) {
    echo json_encode(['ok' => false]);
    return;
}

if ($categorySlug !== '' && preg_match('#^[a-z0-9-]+$#', $categorySlug)) {
    $pageStmt = $pdo->prepare("SELECT cvp.page_slug FROM country_visa_pages cvp
        JOIN visa_categories vc ON vc.id = cvp.visa_category_id
        WHERE cvp.country_id = ? AND vc.slug = ? AND cvp.status = 'published'");
    $pageStmt->execute([$country['id'], $categorySlug]);
    $pageSlug = $pageStmt->fetchColumn();
    if ($pageSlug) {
        echo json_encode(['ok' => true, 'type' => 'page', 'url' => visa_country_page_url($pageSlug)]);
        return;
    }
}

echo json_encode([
    'ok' => true,
    'type' => 'hub',
    'url' => visa_country_url($countrySlug),
    'note' => 'Detailed information for this visa category is being finalised for ' . $country['name'] . '. Here\'s what we have so far, or talk to a consultant.',
]);
