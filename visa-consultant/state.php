<?php
declare(strict_types=1);

/**
 * /visa-consultant/{state}/ — state overview page. $state is resolved
 * by visa-consultant/index.php. Renders for every active state
 * (including is_indexable = 0 rows, so an admin can preview a draft
 * before flipping it live) but sets $noindex accordingly — see
 * database/schema-location-seo.sql's docblock for why this gate
 * exists at all.
 *
 * Always emits Service schema (never LocalBusiness/PostalAddress) —
 * a state is not a single geocoded location, so a genuine physical
 * address (where one exists) belongs on the specific city page
 * instead. See visa-consultant/city.php.
 */

$cities = cities_by_state((int) $state['id']);
$popularCountries = array_values(array_filter(countries_all(), static fn($c) => $c['is_popular_destination']));
$faqs = location_faqs_for((int) $state['id'], null);

$noindex = !$state['is_indexable'];
$pageTitle = $state['meta_title'] ?: "Visa Consultant & Visa Agency in {$state['name']} | Visagiri";
$pageDescription = $state['meta_description'] ?: "Visagiri offers visa consultancy, application assistance, and document attestation services to applicants across {$state['name']}. Enquire online.";
$canonicalUrl = APP_URL . "/visa-consultant/{$state['slug']}/";
$structuredData = [
    [
        '@context' => 'https://schema.org',
        '@type' => 'BreadcrumbList',
        'itemListElement' => [
            ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
            ['@type' => 'ListItem', 'position' => 2, 'name' => 'Visa Consultant', 'item' => APP_URL . '/visa-consultant/'],
            ['@type' => 'ListItem', 'position' => 3, 'name' => $state['name'], 'item' => $canonicalUrl],
        ],
    ],
    [
        '@context' => 'https://schema.org',
        '@type' => 'Service',
        'serviceType' => 'Visa Consultancy',
        'provider' => ['@type' => 'Organization', 'name' => 'Visagiri'],
        'areaServed' => ['@type' => 'State', 'name' => $state['name']],
    ],
];
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
        <ul class="breadcrumb"><li><a href="/">Home</a></li><li><a href="/visa-consultant/">Visa Consultant</a></li><li><?= e($state['name']) ?></li></ul>

        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Consultant &amp; Visa Agency in <?= e($state['name']) ?></span>
            <h1>Visa Consultant &amp; Visa Agency in <?= e($state['name']) ?></h1>
        </div>

        <?php if ($state['intro_content']): ?>
        <div class="prose" style="margin-bottom:var(--space-8)"><?= nl2br(e($state['intro_content'])) ?></div>
        <?php else: ?>
        <p style="color:var(--text-muted);margin-bottom:var(--space-8)">
            Visagiri provides visa consultancy and application-management assistance to applicants across
            <?= e($state['name']) ?>. Detailed local information for this page is being prepared —
            <a href="/contact/">contact us</a> for assistance in the meantime.
        </p>
        <?php endif; ?>

        <?php if ($cities): ?>
        <h2>Cities We Serve in <?= e($state['name']) ?></h2>
        <ul style="columns:2;gap:var(--space-6);padding-left:var(--space-5);margin-bottom:var(--space-8)">
            <?php foreach ($cities as $c): ?>
            <li>
                <?php if ($c['is_indexable']): ?>
                <a href="/visa-consultant/<?= e($state['slug']) ?>/<?= e($c['slug']) ?>/"><?= e($c['name']) ?></a>
                <?php else: ?>
                <?= e($c['name']) ?>
                <?php endif; ?>
            </li>
            <?php endforeach; ?>
        </ul>
        <?php endif; ?>

        <h2>Popular Visa Destinations</h2>
        <p>We assist <?= e($state['name']) ?> applicants with visa applications for destinations including:</p>
        <ul style="columns:2;gap:var(--space-6);padding-left:var(--space-5);margin-bottom:var(--space-8)">
            <?php foreach ($popularCountries as $c): ?>
            <li><a href="/visa/<?= e($c['slug']) ?>/"><?= e($c['name']) ?></a></li>
            <?php endforeach; ?>
        </ul>

        <h2>How Visagiri Visa Assistance Works</h2>
        <ol style="padding-left:var(--space-5);margin-bottom:var(--space-8)">
            <li>Share your travel purpose and destination through our <a href="/contact/">enquiry form</a> or WhatsApp.</li>
            <li>Our team reviews your case and provides a document checklist for your visa category.</li>
            <li>We help you prepare and organise your application, including document apostille/attestation where needed.</li>
            <li>Your application is submitted through the appropriate embassy, consulate, or visa application centre.</li>
            <li>We keep you updated on your application status until a decision is issued.</li>
        </ol>
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
            <p>Ready to start your visa application from <?= e($state['name']) ?>?</p>
            <a href="/contact/" class="btn btn-primary">Enquire Now</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
