<?php
declare(strict_types=1);

/**
 * /visa-consultant/{state}/{city}/ — city detail page. $state and
 * $city are resolved by visa-consultant/index.php. Renders for every
 * active city (including is_indexable = 0 rows) but sets $noindex
 * accordingly.
 *
 * LocalBusiness/PostalAddress schema is emitted only when
 * $city['office_address'] is genuinely set — the sole gate, enforced
 * structurally rather than by content-review convention. Every other
 * city states honestly that it is served remotely from the state's
 * office (if the state has one) or by the wider team.
 */

$popularCountries = array_values(array_filter(countries_all(), static fn($c) => $c['is_popular_destination']));
$faqs = location_faqs_for(null, (int) $city['id']);
$hasOffice = $city['office_address'] !== null && $city['office_address'] !== '';

$noindex = !$city['is_indexable'];
$pageTitle = $city['meta_title'] ?: "Visa Consultant & Visa Agency in {$city['name']} | Visagiri";
$pageDescription = $city['meta_description'] ?: "Visagiri offers visa consultancy, application assistance, and document attestation services in {$city['name']}. Enquire online.";
$canonicalUrl = APP_URL . "/visa-consultant/{$state['slug']}/{$city['slug']}/";
$structuredData = [
    [
        '@context' => 'https://schema.org',
        '@type' => 'BreadcrumbList',
        'itemListElement' => [
            ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
            ['@type' => 'ListItem', 'position' => 2, 'name' => 'Visa Consultant', 'item' => APP_URL . '/visa-consultant/'],
            ['@type' => 'ListItem', 'position' => 3, 'name' => $state['name'], 'item' => APP_URL . "/visa-consultant/{$state['slug']}/"],
            ['@type' => 'ListItem', 'position' => 4, 'name' => $city['name'], 'item' => $canonicalUrl],
        ],
    ],
];
if ($hasOffice) {
    $structuredData[] = [
        '@context' => 'https://schema.org',
        '@type' => 'LocalBusiness',
        'name' => "Visagiri — {$city['name']}",
        'parentOrganization' => ['@type' => 'Organization', 'name' => 'Visagiri'],
        'address' => ['@type' => 'PostalAddress', 'streetAddress' => $city['office_address'], 'addressLocality' => $city['name'], 'addressRegion' => $state['name'], 'addressCountry' => 'IN'],
        'url' => $canonicalUrl,
    ];
} else {
    $structuredData[] = [
        '@context' => 'https://schema.org',
        '@type' => 'Service',
        'serviceType' => 'Visa Consultancy',
        'provider' => ['@type' => 'Organization', 'name' => 'Visagiri'],
        'areaServed' => ['@type' => 'City', 'name' => $city['name']],
    ];
}
if ($faqs) {
    $structuredData[] = [
        '@context' => 'https://schema.org',
        '@type' => 'FAQPage',
        'mainEntity' => array_map(static fn($f) => [
            '@type' => 'Question',
            'name' => $f['question'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['answer']],
        ], $faqs),
    ];
}
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:900px">
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li><a href="/visa-consultant/">Visa Consultant</a></li><li><a href="/visa-consultant/<?= e($state['slug']) ?>/"><?= e($state['name']) ?></a></li><li><?= e($city['name']) ?></li></ul>

        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Consultant &amp; Visa Agency in <?= e($city['name']) ?></span>
            <h1>Visa Consultant &amp; Visa Agency in <?= e($city['name']) ?></h1>
        </div>

        <?php if ($hasOffice): ?>
        <div class="card" style="margin-bottom:var(--space-8)">
            <p style="margin:0"><strong>Our office address:</strong><br><?= nl2br(e($city['office_address'])) ?></p>
        </div>
        <?php endif; ?>

        <?php if ($city['intro_content']): ?>
        <div class="prose" style="margin-bottom:var(--space-8)"><?= nl2br(e($city['intro_content'])) ?></div>
        <?php else: ?>
        <p style="color:var(--text-muted);margin-bottom:var(--space-8)">
            Visagiri assists applicants in <?= e($city['name']) ?> as part of our <?= e($state['name']) ?> service area.
            Detailed local information for this page is being prepared —
            <a href="/contact/">contact us</a> for assistance in the meantime.
        </p>
        <?php endif; ?>

        <h2>Popular Visa Destinations</h2>
        <p>We assist <?= e($city['name']) ?> applicants with visa applications for destinations including:</p>
        <ul style="columns:2;gap:var(--space-6);padding-left:var(--space-5);margin-bottom:var(--space-8)">
            <?php foreach ($popularCountries as $c): ?>
            <li><a href="/visa/<?= e($c['slug']) ?>/"><?= e($c['name']) ?></a></li>
            <?php endforeach; ?>
        </ul>

        <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-bottom:var(--space-8)">
            Disclaimer: Visa decisions are made solely by the relevant embassy, consulate, or government immigration
            authority. Visagiri provides visa consultancy and application-management assistance and does not
            guarantee visa approval.
        </p>

        <?php if ($faqs): ?>
        <h2>Frequently Asked Questions</h2>
        <?php foreach ($faqs as $faq): ?>
        <details class="accordion-item" style="margin-bottom:var(--space-3)">
            <summary><?= e($faq['question']) ?></summary>
            <div><?= nl2br(e($faq['answer'])) ?></div>
        </details>
        <?php endforeach; ?>
        <?php endif; ?>

        <div class="card" style="margin-top:var(--space-8);text-align:center">
            <p>Ready to start your visa application from <?= e($city['name']) ?>?</p>
            <a href="/contact/" class="btn btn-primary">Enquire Now</a>
        </div>

        <p style="margin-top:var(--space-6)"><a href="/visa-consultant/<?= e($state['slug']) ?>/">&larr; More about visa assistance in <?= e($state['name']) ?></a></p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
