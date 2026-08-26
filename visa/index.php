<?php
declare(strict_types=1);

/**
 * Handles /visa/{country}/ (overview) and /visa/{country}/{type}/
 * (detail). $segments is provided by public/index.php's dispatch
 * closure ($segments[0] === 'visa').
 *
 * Requirement data (eligibility, documents, fees) is admin-managed
 * via /admin/countries/ + the visa_requirements table — see
 * includes/data.php's fetch_visa_requirement(). Any country+type
 * combination with no row yet renders the honest "not yet verified"
 * state; this page's job is query logic and template, never to
 * fabricate what it can't find.
 */

$countrySlug = $segments[1] ?? null;
$typeSlug = $segments[2] ?? null;

if ($countrySlug === null) {
    require __DIR__ . '/hub.php';
    exit;
}

if (isset(CONTINENT_HUBS[$countrySlug])) {
    require __DIR__ . '/continent.php';
    exit;
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

    $requirement = fetch_visa_requirement((int) $country['id'], (int) $visaType['id']);
    $contactPoints = fetch_country_contact_points((int) $country['id']);
    $countryName = $country['name'];
    $faqs = fetch_relevant_faqs((int) $country['id'], (int) $visaType['id']);

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
                    <div class="button-group">
                        <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>" class="btn btn-gold">Submit Enquiry</a>
                        <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">WhatsApp Us</a>
                    </div>
                </div>
            </div>

            <?php if ($searchContext): ?>
            <div class="alert alert-info">
                Showing results for
                <?php if (!empty($searchContext['nationality'])): ?><strong><?= e($searchContext['nationality']) ?></strong> nationality<?php endif; ?>
                <?php if (!empty($searchContext['travel_date'])): ?>, travelling <strong><?= e($searchContext['travel_date']) ?></strong><?php endif; ?>.
            </div>
            <?php endif; ?>

            <?php if ($requirement): ?>
            <div class="visa-spec-grid">
                <div class="card"><div class="card-title">Eligibility</div><p><?= nl2br(e($requirement['eligibility'] ?? 'Not specified')) ?></p></div>
                <div class="card">
                    <div class="card-title">Required Documents</div>
                    <?php
                    $documentLines = array_values(array_filter(array_map('trim', explode("\n", (string) ($requirement['documents_required'] ?? '')))));
                    ?>
                    <?php if ($documentLines): ?>
                    <ul class="document-checklist">
                        <?php foreach ($documentLines as $line): ?>
                        <li class="document-checklist__item"><label><input type="checkbox"> <span><?= e($line) ?></span></label></li>
                        <?php endforeach; ?>
                    </ul>
                    <div class="button-group" style="margin-top:var(--space-3)">
                        <button type="button" class="btn btn-outline btn-sm" onclick="window.print()">Print Checklist</button>
                    </div>
                    <?php else: ?>
                    <p>Not specified</p>
                    <?php endif; ?>
                </div>
                <div class="card"><div class="card-title">Application Process</div><p><?= nl2br(e($requirement['application_process'] ?? 'Not specified')) ?></p></div>
                <div class="card"><div class="card-title">Processing Time</div><p><?= e($requirement['processing_time'] ?? 'Not specified') ?></p></div>
                <div class="card"><div class="card-title">Fees</div><p>
                    <?php if ($requirement['government_fee']): ?>Government fee: <?= e(format_money((float) $requirement['government_fee'], $requirement['currency'])) ?><br><?php endif; ?>
                    <?php if ($requirement['service_fee']): ?>Service fee: <?= e(format_money((float) $requirement['service_fee'], $requirement['currency'])) ?><?php endif; ?>
                </p></div>
                <div class="card"><div class="card-title">Validity &amp; Stay</div><p>
                    Validity: <?= e($requirement['validity_period'] ?? 'Not specified') ?><br>
                    Stay duration: <?= e($requirement['stay_duration'] ?? 'Not specified') ?><br>
                    Entry type: <?= e($requirement['entry_type'] ?? 'Not specified') ?>
                </p></div>
                <div class="card"><div class="card-title">Biometrics &amp; Interview</div><p>
                    Biometrics required: <span class="badge <?= $requirement['biometrics_required'] ? 'badge-warning' : 'badge-neutral' ?>"><?= $requirement['biometrics_required'] ? 'Yes' : 'No' ?></span><br>
                    Interview required: <span class="badge <?= $requirement['interview_required'] ? 'badge-warning' : 'badge-neutral' ?>"><?= $requirement['interview_required'] ? 'Yes' : 'No' ?></span>
                </p></div>
                <?php if (!empty($requirement['notes'])): ?>
                <div class="card"><div class="card-title">Important Notes</div><p><?= nl2br(e($requirement['notes'])) ?></p></div>
                <?php endif; ?>
            </div>
            <p class="visa-detail__verified">
                <?php if (!empty($requirement['last_verified_at'])): ?>Last verified: <?= e(date('d M Y', strtotime((string) $requirement['last_verified_at']))) ?><?php endif; ?>
                <?php if (!empty($requirement['source_url'])): ?> &middot; <a href="<?= e($requirement['source_url']) ?>" rel="nofollow noopener" target="_blank">Official source</a><?php endif; ?>
            </p>
            <?php else: ?>
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
            <?php endif; ?>

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
$contactPoints = fetch_country_contact_points((int) $country['id']);
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
