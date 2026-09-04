<?php
declare(strict_types=1);

/**
 * /visa-consultant/ — the location-SEO hub. Links to all 36
 * states/UTs regardless of is_indexable, so no state page is ever an
 * orphan (non-indexable ones still render for admin preview, just
 * noindexed) — see visa-consultant/state.php.
 */

$byZone = [];
foreach (states_all() as $s) {
    $byZone[$s['zone'] ?? 'Other'][] = $s;
}
$zoneOrder = ['North', 'South', 'East', 'West', 'Central', 'Northeast', 'Other'];
uksort($byZone, static fn($a, $b) => array_search($a, $zoneOrder, true) <=> array_search($b, $zoneOrder, true));

$pageTitle = 'Visa Consultant & Visa Agency in India | Visagiri';
$pageDescription = 'Visagiri provides visa consultancy, application-management assistance, and document attestation services to applicants across India — find your state or union territory below.';
$canonicalUrl = APP_URL . '/visa-consultant/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Visa Consultant', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:1100px">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li>Visa Consultant</li></ul>
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Consultant &amp; Visa Agency in India</span>
            <h1>Visa Assistance Wherever You Are in India</h1>
            <p style="max-width:70ch">
                Visagiri provides visa consultancy and application-management assistance to applicants across India —
                tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa
                categories, plus document apostille and attestation. Find your state or union territory below for
                location-specific information.
            </p>
        </div>

        <?php foreach ($byZone as $zone => $states): ?>
        <h2 class="country-directory__subheading"><?= e($zone) ?> India</h2>
        <div class="card-grid" style="margin-bottom:var(--space-8)">
            <?php foreach ($states as $s): ?>
            <a href="/visa-consultant/<?= e($s['slug']) ?>/" class="card" style="text-decoration:none;color:inherit">
                <div class="card-title"><?= e($s['name']) ?><?= $s['type'] === 'union_territory' ? ' <span style="color:var(--text-muted);font-weight:400">(UT)</span>' : '' ?></div>
            </a>
            <?php endforeach; ?>
        </div>
        <?php endforeach; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
