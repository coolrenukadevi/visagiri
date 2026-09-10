<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/db.php';

$pdo = db();

$countrySlug = trim((string) ($_GET['country'] ?? ''));
$categorySlug = trim((string) ($_GET['visa_type'] ?? ''));

$country = null;
if ($countrySlug !== '') {
    $stmt = $pdo->prepare('SELECT slug FROM countries WHERE slug = ?');
    $stmt->execute([$countrySlug]);
    $country = $stmt->fetch();
}

$category = null;
if ($categorySlug !== '') {
    $stmt = $pdo->prepare('SELECT slug FROM visa_categories WHERE slug = ?');
    $stmt->execute([$categorySlug]);
    $category = $stmt->fetch();
}

if ($country && $category) {
    $deepStmt = $pdo->prepare(
        'SELECT 1 FROM country_visa_categories cvc
         JOIN countries c ON c.id = cvc.country_id
         JOIN visa_categories vc ON vc.id = cvc.visa_category_id
         WHERE c.slug = ? AND vc.slug = ? AND cvc.indexable = 1'
    );
    $deepStmt->execute([$countrySlug, $categorySlug]);
    if ($deepStmt->fetch()) {
        header('Location: ' . url('visa-by-country/' . $countrySlug . '/' . $categorySlug . '/'));
        exit;
    }
    header('Location: ' . url('visa-by-country/' . $countrySlug . '/'));
    exit;
}

if ($country) {
    header('Location: ' . url('visa-by-country/' . $countrySlug . '/'));
    exit;
}

if ($category) {
    header('Location: ' . url('visa-services/' . $categorySlug . '/'));
    exit;
}

header('Location: ' . url('visa-services/'));
exit;
