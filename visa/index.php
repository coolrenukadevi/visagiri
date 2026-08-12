<?php
declare(strict_types=1);

/**
 * Handles /visa/{country}/ (overview) and /visa/{country}/{type}/
 * (detail). $segments is provided by public/index.php's dispatch
 * closure ($segments[0] === 'visa').
 *
 * No per-country/per-type requirement data (eligibility, documents,
 * fees) has ever been sourced for this site — the visa_requirements
 * table this used to query was never populated, so country+type
 * combinations always rendered the honest "not yet verified" state.
 * With the database gone entirely, that's now simply the only state
 * this page has, rather than one branch of a query result — see
 * AUDIT.md, "Single-folder no-database rebuild".
 */

$countrySlug = $segments[1] ?? null;
$typeSlug = $segments[2] ?? null;

if ($countrySlug === null) {
    redirect('/countries/');
}

$country = country_by_slug($countrySlug);

if (!$country) {
    render_not_found("We couldn't find that destination.");
}

$searchContext = array_filter([
    'nationality' => $_GET['nationality'] ?? '',
    'travel_date' => $_GET['travel_date'] ?? '',
]);

if ($typeSlug !== null) {
    $visaType = visa_type_by_slug($typeSlug);

    if (!$visaType) {
        render_not_found("We couldn't find that visa type for {$country['name']}.");
    }

    $contactPoints = fetch_country_contact_points();
    $countryName = $country['name'];
    $faqs = faqs_general();

    $pageTitle = "{$visaType['name']} for {$country['name']} - Visagiri";
    $pageDescription = "{$visaType['name']} eligibility, required documents, fees, and processing time for {$country['name']} — enquire with Visagiri.";
    $canonicalUrl = APP_URL . "/visa/{$country['slug']}/{$visaType['slug']}/";
    $structuredData = [[
        '@context' => 'https://schema.org',
        '@type' => 'BreadcrumbList',
        'itemListElement' => [
            ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
            ['@type' => 'ListItem', 'position' => 2, 'name' => 'Countries', 'item' => APP_URL . '/countries/'],
            ['@type' => 'ListItem', 'position' => 3, 'name' => $country['name'], 'item' => APP_URL . "/visa/{$country['slug']}/"],
            ['@type' => 'ListItem', 'position' => 4, 'name' => $visaType['name'], 'item' => $canonicalUrl],
        ],
    ]];
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
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/countries/">Countries</a></li>
                <li><a href="/visa/<?= e($country['slug']) ?>/"><?= e($country['name']) ?></a></li>
                <li><?= e($visaType['name']) ?></li>
            </ul>

            <div class="visa-detail__header">
                <span class="destination-card__flag"><?= flag_emoji($country['iso2']) ?></span>
                <div>
                    <h1><?= e($visaType['name']) ?> &mdash; <?= e($country['name']) ?></h1>
                    <p><?= e($visaType['description'] ?? '') ?></p>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-gold" target="_blank" rel="noopener noreferrer">Enquire Now</a>
                </div>
            </div>

            <?php if ($searchContext): ?>
            <div class="alert alert-info">
                Showing results for
                <?php if (!empty($searchContext['nationality'])): ?><strong><?= e($searchContext['nationality']) ?></strong> nationality<?php endif; ?>
                <?php if (!empty($searchContext['travel_date'])): ?>, travelling <strong><?= e($searchContext['travel_date']) ?></strong><?php endif; ?>.
            </div>
            <?php endif; ?>

            <div class="alert alert-warning">
                <div>
                    <strong>Requirements not yet verified.</strong>
                    We haven't published verified <?= e($visaType['name']) ?> requirements for <?= e($country['name']) ?> yet.
                    Contact our team for current requirements, or check back soon.
                </div>
            </div>
            <div class="button-group" style="margin-top:var(--space-5)">
                <a href="/contact/" class="btn btn-primary">Contact Us</a>
                <a href="/visa/<?= e($country['slug']) ?>/" class="btn btn-outline">See other visa types for <?= e($country['name']) ?></a>
            </div>

            <div style="margin-top:var(--space-10)">
                <?php require __DIR__ . '/../includes/contact-points.php'; ?>
            </div>

            <?php if ($faqs): ?>
            <div style="margin-top:var(--space-10);max-width:760px">
                <h2 class="country-directory__subheading">Frequently Asked Questions</h2>
                <?php foreach ($faqs as $faq): ?>
                <div class="accordion-item">
                    <details>
                        <summary><?= e($faq['question']) ?></summary>
                        <div class="accordion-body"><?= e($faq['answer']) ?></div>
                    </details>
                </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

// Country overview: no specific visa type requested — list the
// catalog of visa types to explore for this country.
$visaTypes = visa_types_all();
$contactPoints = fetch_country_contact_points();
$countryName = $country['name'];

$pageTitle = "{$country['name']} Visa Requirements - Visagiri";
$pageDescription = "Visa types, eligibility, and application information for {$country['name']}. Explore requirements by visa type and enquire with Visagiri.";
$canonicalUrl = APP_URL . "/visa/{$country['slug']}/";
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Countries', 'item' => APP_URL . '/countries/'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $country['name'], 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="visa-detail">
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="/">Home</a></li>
            <li><a href="/countries/">Countries</a></li>
            <li><?= e($country['name']) ?></li>
        </ul>

        <div class="visa-detail__header">
            <span class="destination-card__flag"><?= flag_emoji($country['iso2']) ?></span>
            <div>
                <h1><?= e($country['name']) ?> Visa Requirements</h1>
                <?php if (!empty($country['region'])): ?><span class="badge badge-neutral"><?= e($country['region']) ?></span><?php endif; ?>
                <p style="margin-top:var(--space-3)">
                    Visa requirements for <?= e($country['name']) ?> vary by nationality, purpose of travel, and visa type.
                    Select a visa type below to check eligibility, required documents, fees, and processing time.
                </p>
            </div>
        </div>

        <div class="card-grid">
            <?php foreach ($visaTypes as $t): ?>
            <a href="/visa/<?= e($country['slug']) ?>/<?= e($t['slug']) ?>/" class="card service-card">
                <div class="service-card__icon">&#128196;</div>
                <div class="card-title"><?= e($t['name']) ?></div>
                <p><?= e($t['description']) ?></p>
            </a>
            <?php endforeach; ?>
        </div>

        <div style="margin-top:var(--space-10)">
            <?php require __DIR__ . '/../includes/contact-points.php'; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
