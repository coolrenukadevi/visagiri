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

// A handful of URLs used in past marketing briefs don't match the real
// visa_types catalog (e.g. "students"/"employment" instead of the
// catalog's "student"/"work") — redirect rather than duplicating the
// catalog with near-identical entries, so search engines consolidate
// on one canonical URL per real visa type.
const VISA_TYPE_SLUG_ALIASES = ['students' => 'student', 'employment' => 'work'];
if ($typeSlug !== null && isset(VISA_TYPE_SLUG_ALIASES[$typeSlug])) {
    redirect("/visa/{$countrySlug}/" . VISA_TYPE_SLUG_ALIASES[$typeSlug] . '/', 301);
}

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
    $hasRichRequirement = $requirement !== null && !empty($requirement['overview']);

    // Visa Checklist Engine — independent of $requirement above (a
    // country+type can have rich requirement content, a checklist,
    // both, or neither; see includes/visa-checklist.php).
    $checklist = fetch_visa_checklist((int) $country['id'], (int) $visaType['id']);
    $fee = fetch_visa_fee((int) $country['id'], (int) $visaType['id']);
    $hasChecklistAccess = $checklist !== null && has_checklist_access((int) $country['id'], (int) $visaType['id']);
    $checklistVisibility = $checklist !== null ? split_checklist_for_visibility($checklist, $hasChecklistAccess) : null;

    $pageTitle = $checklist !== null
        ? "{$country['name']} {$visaType['name']} Checklist for Indians | Documents Required | Visagiri"
        : ($hasRichRequirement
            ? "{$country['name']} {$visaType['name']} Consultant in India | Visagiri"
            : "{$visaType['name']} for {$country['name']} - Visagiri");
    $pageDescription = $checklist !== null
        ? "Complete, independently maintained {$country['name']} {$visaType['name']} document checklist for Indian applicants — core requirements shown here, with the full checklist available after a quick enquiry."
        : ($hasRichRequirement
            ? "{$country['name']} {$visaType['name']} eligibility, documents, application process, and consultant support for Indian applicants, including Patna and Bihar — enquire with Visagiri."
            : "{$visaType['name']} eligibility, required documents, fees, and processing time for {$country['name']} — enquire with Visagiri.");
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
                    <?php if ($checklist !== null): ?>
                    <p class="section-eyebrow"><?= e(strtoupper($country['name'])) ?> <?= e(strtoupper($visaType['name'])) ?></p>
                    <h1>Complete Visa Document Checklist for Indian Applicants</h1>
                    <p>Prepare your documents with confidence. Review the essential requirements below and request the complete, latest checklist applicable to your visa profile.</p>
                    <div class="checklist-meta-row" style="display:flex;gap:var(--space-5);flex-wrap:wrap;margin:var(--space-4) 0;font-size:var(--font-size-sm)">
                        <span><strong>Visa Type:</strong> <?= e($visaType['name']) ?></span>
                        <span><strong>Applicant Country:</strong> India</span>
                        <span><strong>Country:</strong> <?= e($country['name']) ?></span>
                        <span><strong>Checklist Reference:</strong> <?= e($checklist['reference']) ?></span>
                        <?php if (!empty($checklist['last_reviewed_at'])): ?>
                        <span><strong>Last Reviewed:</strong> <?= e(date('d M Y', strtotime((string) $checklist['last_reviewed_at']))) ?></span>
                        <?php endif; ?>
                    </div>
                    <div class="button-group">
                        <?php if (!$hasChecklistAccess): ?>
                        <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>&amp;checklist_ref=<?= e($checklist['reference']) ?>"
                           class="btn btn-gold"
                           data-open-enquiry-modal-checklist
                           data-country="<?= e($country['slug']) ?>"
                           data-visa-type="<?= e($visaType['slug']) ?>"
                           data-checklist-ref="<?= e($checklist['reference']) ?>">Enquire Now &amp; Unlock Full Checklist</a>
                        <?php else: ?>
                        <a href="#complete-checklist" class="btn btn-gold">View Complete Checklist</a>
                        <?php endif; ?>
                        <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to talk to a visa expert about the {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Talk to a Visa Expert</a>
                    <?php else: ?>
                    <h1><?= $hasRichRequirement ? e("{$country['name']} {$visaType['name']} Consultant in India") : (e($visaType['name']) . ' &mdash; ' . e($country['name'])) ?></h1>
                    <p><?= e($visaType['description'] ?? '') ?></p>
                    <div class="button-group">
                        <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>" class="btn btn-gold">Submit Enquiry</a>
                        <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">WhatsApp Us</a>
                    <?php endif; ?>
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

            <?php if ($checklist !== null): ?>

            <?php if ($fee !== null): ?>
            <div class="card" style="margin-bottom:var(--space-6);max-width:420px">
                <div class="card-title">Visa Fee</div>
                <p style="font-size:var(--font-size-lg);font-weight:600">
                    <?= $fee['amount'] !== null ? e($fee['currency'] . ' ' . number_format((float) $fee['amount'], 2)) : e($fee['label'] ?: 'As per current consular fee schedule') ?>
                </p>
                <?php if (!empty($fee['label']) && $fee['amount'] !== null): ?><p style="font-size:var(--font-size-sm);color:var(--text-muted)"><?= e($fee['label']) ?></p><?php endif; ?>
                <?php if (!empty($fee['note'])): ?><p style="font-size:var(--font-size-sm);color:var(--text-muted)"><?= e($fee['note']) ?></p><?php endif; ?>
                <p style="font-size:var(--font-size-xs);color:var(--text-muted)">Last updated: <?= e(date('d M Y', strtotime((string) $fee['last_updated']))) ?></p>
            </div>
            <?php endif; ?>

            <div id="complete-checklist">
                <h2 class="country-directory__subheading"><?= e($country['name']) ?> <?= e($visaType['name']) ?> Document Checklist</h2>
                <p style="font-size:var(--font-size-sm);color:var(--text-muted)">Checklist Reference: <?= e($checklist['reference']) ?> &middot; Version <?= e($checklist['version']) ?></p>

                <?php foreach ($checklistVisibility['public'] as $i => $section): ?>
                <div class="card" style="margin-bottom:var(--space-5)">
                    <div class="card-title"><?= sprintf('%02d', $i + 1) ?> &mdash; <?= e($section['title']) ?></div>
                    <?php if (!empty($section['description'])): ?><p style="font-size:var(--font-size-sm);color:var(--text-muted)"><?= e($section['description']) ?></p><?php endif; ?>
                    <ul class="document-checklist">
                        <?php foreach ($section['documents'] as $doc): ?>
                        <li class="document-checklist__item">
                            <label>
                                <input type="checkbox">
                                <span>
                                    <?= e($doc['name']) ?>
                                    <?php if ($doc['mandatory']): ?><span class="badge badge-warning" style="margin-left:6px">Mandatory</span>
                                    <?php elseif ($doc['conditional']): ?><span class="badge badge-neutral" style="margin-left:6px">Conditional</span>
                                    <?php endif; ?>
                                    &mdash; <?= e(ucfirst(str_replace('_', ' ', $doc['document_type']))) ?>
                                </span>
                            </label>
                            <?php if (!empty($doc['description'])): ?><p style="font-size:var(--font-size-sm);color:var(--text-muted);margin-left:26px"><?= e($doc['description']) ?></p><?php endif; ?>
                        </li>
                        <?php endforeach; ?>
                    </ul>
                </div>
                <?php endforeach; ?>

                <?php if ($checklistVisibility['lockedTitles']): ?>
                <div class="card" style="background:var(--bg-alt, #f7f8fa);text-align:center;padding:var(--space-8) var(--space-6)">
                    <div class="card-title">&#128274; Complete Visa Checklist</div>
                    <h3 style="margin-top:var(--space-2)">Get the Complete &amp; Updated Checklist</h3>
                    <p>The complete checklist includes detailed financial, employment, travel, supporting-document, appointment and submission requirements applicable to this visa category.</p>
                    <ul style="list-style:none;padding:0;margin:var(--space-4) 0;color:var(--text-muted)">
                        <?php foreach ($checklistVisibility['lockedTitles'] as $title): ?>
                        <li>&#128274; <?= e($title) ?></li>
                        <?php endforeach; ?>
                    </ul>
                    <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>&amp;checklist_ref=<?= e($checklist['reference']) ?>"
                       class="btn btn-gold btn-lg"
                       data-open-enquiry-modal-checklist
                       data-country="<?= e($country['slug']) ?>"
                       data-visa-type="<?= e($visaType['slug']) ?>"
                       data-checklist-ref="<?= e($checklist['reference']) ?>">Enquire Now &amp; Unlock Full Checklist &rarr;</a>
                </div>
                <?php else: ?>
                <div class="button-group">
                    <button type="button" class="btn btn-outline" onclick="window.print()">Print Checklist</button>
                </div>
                <?php endif; ?>

                <p style="font-size:var(--font-size-xs);color:var(--text-muted);margin-top:var(--space-4)">
                    <?= e($checklist['disclaimer'] ?: CHECKLIST_DEFAULT_DISCLAIMER) ?>
                    <?php if (!empty($checklist['source_url'])): ?> <a href="<?= e($checklist['source_url']) ?>" rel="nofollow noopener" target="_blank">Source</a><?php endif; ?>
                </p>
            </div>
            <?php endif; ?>

            <?php if ($requirement): ?>

            <?php if (!empty($requirement['overview'])): ?>
            <div class="prose" style="margin-bottom:var(--space-6)">
                <?= nl2br(e($requirement['overview'])) ?>
            </div>
            <?php endif; ?>

            <?php if (!empty($requirement['who_should_apply'])): ?>
            <div style="margin-bottom:var(--space-6)">
                <h2 class="country-directory__subheading">Who Should Apply</h2>
                <div class="prose"><?= nl2br(e($requirement['who_should_apply'])) ?></div>
            </div>
            <?php endif; ?>

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
                <div class="card"><div class="card-title">Processing Time</div><p>
                    <?= e($requirement['processing_time'] ?? 'Not specified') ?>
                    <br><span style="font-size:var(--font-size-xs);color:var(--text-muted)">Processing times can vary depending on visa category, applicant profile, completeness of documents, and immigration authority workload.</span>
                </p></div>
                <div class="card"><div class="card-title">Fees</div><p>
                    <?php if ($requirement['government_fee']): ?>Government fee: <?= e(format_money((float) $requirement['government_fee'], $requirement['currency'])) ?><br><?php endif; ?>
                    <?php if ($requirement['service_fee']): ?>Visagiri service fee: <?= e(format_money((float) $requirement['service_fee'], $requirement['currency'])) ?><br><?php endif; ?>
                    <?php if (!$requirement['government_fee'] && !$requirement['service_fee']): ?>Not specified<?php endif; ?>
                    <?php if (!empty($requirement['fee_notes'])): ?><span style="font-size:var(--font-size-xs);color:var(--text-muted)"><?= e($requirement['fee_notes']) ?></span><?php endif; ?>
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
                <?php if (!empty($requirement['common_mistakes'])): ?>
                <div class="card"><div class="card-title">Common Mistakes &amp; Reasons for Delay or Refusal</div><p><?= nl2br(e($requirement['common_mistakes'])) ?></p></div>
                <?php endif; ?>
            </div>

            <?php if (!empty($requirement['local_notes'])): ?>
            <div class="card" style="margin-top:var(--space-6)">
                <div class="card-title"><?= e($visaType['name']) ?> Consultant Across India</div>
                <p><?= nl2br(e($requirement['local_notes'])) ?></p>
            </div>
            <?php endif; ?>

            <p class="visa-detail__verified">
                <?php if (!empty($requirement['last_verified_at'])): ?>Last verified: <?= e(date('d M Y', strtotime((string) $requirement['last_verified_at']))) ?><?php endif; ?>
                <?php if (!empty($requirement['source_url'])): ?> &middot; <a href="<?= e($requirement['source_url']) ?>" rel="nofollow noopener" target="_blank">Official source</a><?php endif; ?>
            </p>
            <?php elseif ($checklist === null): ?>
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

            <div style="margin-top:var(--space-10)">
                <h2 class="country-directory__subheading">Why Choose Visagiri</h2>
                <div class="card-grid">
                    <?php foreach (why_visagiri_features() as $f): ?>
                    <div class="card feature-card">
                        <div class="card-title"><?= e($f['title']) ?></div>
                        <p><?= e($f['desc']) ?></p>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>

            <?php
            $otherTypes = array_values(array_filter(visa_types_for_country((int) $country['id']), static fn(array $t): bool => $t['id'] !== $visaType['id']));
            ?>
            <?php if ($otherTypes): ?>
            <div style="margin-top:var(--space-10)">
                <h2 class="country-directory__subheading">Other <?= e($country['name']) ?> Visa Categories</h2>
                <div style="display:flex;gap:var(--space-3);flex-wrap:wrap">
                    <?php foreach ($otherTypes as $ot): ?>
                    <a href="/visa/<?= e($country['slug']) ?>/<?= e($ot['slug']) ?>/" class="btn btn-outline"><?= e($country['name']) ?> <?= e($ot['name']) ?> &rarr;</a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>

            <?php if ($faqs): ?>
            <div style="margin-top:var(--space-10)">
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

            <div class="final-cta" style="margin-top:var(--space-10)">
                <h2>Ready to start your <?= e($country['name']) ?> <?= e(strtolower($visaType['name'])) ?> application?</h2>
                <div class="button-group" style="justify-content:center">
                    <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>" class="btn btn-gold btn-lg" data-open-enquiry-modal>Start Your Visa Enquiry</a>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline btn-lg" target="_blank" rel="noopener noreferrer">Talk to a Visa Expert</a>
                </div>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

// Country overview: no specific visa type requested — list the
// catalog of visa types actually available for this country, plus any
// rich hub-level content (country_content) an admin has published.
$visaTypes = visa_types_for_country((int) $country['id']);
$contactPoints = fetch_country_contact_points((int) $country['id']);
$countryContent = fetch_country_content((int) $country['id']);
$countryFaqs = fetch_country_faqs((int) $country['id']);
$countryName = $country['name'];

$hasRichContent = $countryContent !== null;

$pageTitle = $hasRichContent
    ? "{$country['name']} Visa Consultant in India | {$country['name']} Visa Services | Visagiri"
    : "{$country['name']} Visa Requirements - Visagiri";
$pageDescription = $hasRichContent
    ? "Visagiri is a {$country['name']} visa consultant serving Indian applicants nationwide, with local support for Patna and Bihar — eligibility, documents, application assistance, and enquiry support for every {$country['name']} visa category."
    : "Visa types, eligibility, and application information for {$country['name']}. Explore requirements by visa type and enquire with Visagiri.";
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
if ($hasRichContent) {
    $structuredData[] = [
        '@context' => 'https://schema.org',
        '@type' => 'Service',
        'serviceType' => "{$country['name']} Visa Consultancy",
        'provider' => ['@type' => 'Organization', 'name' => setting('company_name', 'Visagiri')],
        'areaServed' => ['@type' => 'Country', 'name' => 'India'],
        'name' => "{$country['name']} Visa Consultant in India",
        'description' => $pageDescription,
    ];
}
if ($countryFaqs) {
    $structuredData[] = [
        '@context' => 'https://schema.org',
        '@type' => 'FAQPage',
        'mainEntity' => array_map(static fn($f) => [
            '@type' => 'Question',
            'name' => $f['question'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['answer']],
        ], $countryFaqs),
    ];
}
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
                <h1><?= $hasRichContent ? e("{$country['name']} Visa Consultant in India") : e("{$country['name']} Visa Requirements") ?></h1>
                <?php if (!empty($country['region'])): ?><span class="badge badge-neutral"><?= e($country['region']) ?></span><?php endif; ?>
                <p style="margin-top:var(--space-3)">
                    <?php if ($hasRichContent && !empty($countryContent['hero_tagline'])): ?>
                        <?= e($countryContent['hero_tagline']) ?>
                    <?php else: ?>
                        Visa requirements for <?= e($country['name']) ?> vary by nationality, purpose of travel, and visa type.
                        Select a visa type below to check eligibility, required documents, fees, and processing time.
                    <?php endif; ?>
                </p>
                <div class="button-group" style="margin-top:var(--space-4)">
                    <a href="#visa-categories" class="btn btn-gold">Check <?= e($country['name']) ?> Visa Requirements</a>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to talk to a visa expert about {$country['name']}.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Talk to a Visa Expert</a>
                    <a href="/enquire/?country=<?= e($country['slug']) ?>" class="btn btn-outline" data-open-enquiry-modal>Start Your Visa Enquiry</a>
                </div>
            </div>
        </div>

        <?php if ($hasRichContent && !empty($countryContent['overview'])): ?>
        <div class="prose" style="margin:var(--space-8) 0">
            <?= nl2br(e($countryContent['overview'])) ?>
        </div>
        <?php endif; ?>

        <div id="visa-categories" style="margin-top:var(--space-8)">
            <h2 class="country-directory__subheading"><?= e($country['name']) ?> Visa Categories</h2>
            <div class="card-grid">
                <?php foreach ($visaTypes as $t): ?>
                <a href="/visa/<?= e($country['slug']) ?>/<?= e($t['slug']) ?>/" class="card service-card">
                    <div class="service-card__icon">&#128196;</div>
                    <div class="card-title"><?= e($country['name']) ?> <?= e($t['name']) ?></div>
                    <p><?= e($t['description']) ?></p>
                </a>
                <?php endforeach; ?>
            </div>
        </div>

        <?php if ($hasRichContent && !empty($countryContent['who_needs_visa'])): ?>
        <div style="margin-top:var(--space-10)">
            <h2 class="country-directory__subheading">Who Needs a <?= e($country['name']) ?> Visa?</h2>
            <div class="prose"><?= nl2br(e($countryContent['who_needs_visa'])) ?></div>
        </div>
        <?php endif; ?>

        <?php if ($hasRichContent && !empty($countryContent['common_mistakes'])): ?>
        <div style="margin-top:var(--space-10)">
            <h2 class="country-directory__subheading">Reasons Applications Can Face Delays or Refusal</h2>
            <div class="prose"><?= nl2br(e($countryContent['common_mistakes'])) ?></div>
        </div>
        <?php endif; ?>

        <?php if ($hasRichContent && !empty($countryContent['local_seo_patna'])): ?>
        <div style="margin-top:var(--space-10)" id="patna">
            <h2 class="country-directory__subheading"><?= e($country['name']) ?> Visa Consultant in Patna</h2>
            <div class="prose"><?= nl2br(e($countryContent['local_seo_patna'])) ?></div>
        </div>
        <?php endif; ?>

        <?php if ($hasRichContent && !empty($countryContent['services_across_india'])): ?>
        <div style="margin-top:var(--space-10)">
            <h2 class="country-directory__subheading"><?= e($country['name']) ?> Visa Services Across India</h2>
            <div class="prose"><?= nl2br(e($countryContent['services_across_india'])) ?></div>
        </div>
        <?php endif; ?>

        <?php if ($hasRichContent): ?>
        <div style="margin-top:var(--space-10)">
            <h2 class="country-directory__subheading">Why Choose Visagiri</h2>
            <div class="card-grid">
                <?php foreach (why_visagiri_features() as $f): ?>
                <div class="card feature-card">
                    <div class="card-title"><?= e($f['title']) ?></div>
                    <p><?= e($f['desc']) ?></p>
                </div>
                <?php endforeach; ?>
            </div>
        </div>
        <?php endif; ?>

        <div style="margin-top:var(--space-10)">
            <?php require __DIR__ . '/../includes/contact-points.php'; ?>
        </div>

        <?php if ($countryFaqs): ?>
        <div style="margin-top:var(--space-10)">
            <h2 class="country-directory__subheading"><?= e($country['name']) ?> Visa FAQ</h2>
            <?php foreach ($countryFaqs as $faq): ?>
            <div class="accordion-item">
                <details>
                    <summary><?= e($faq['question']) ?></summary>
                    <div class="accordion-body"><?= e($faq['answer']) ?></div>
                </details>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <?php if (!empty($countryContent['last_reviewed_at']) || !empty($countryContent['source_url'])): ?>
        <p class="visa-detail__verified">
            <?php if (!empty($countryContent['last_reviewed_at'])): ?>Last reviewed: <?= e(date('d M Y', strtotime((string) $countryContent['last_reviewed_at']))) ?><?php endif; ?>
            <?php if (!empty($countryContent['source_url'])): ?> &middot; <a href="<?= e($countryContent['source_url']) ?>" rel="nofollow noopener" target="_blank">Official source</a><?php endif; ?>
        </p>
        <?php endif; ?>

        <div class="final-cta" style="margin-top:var(--space-10)">
            <h2>Ready to start your <?= e($country['name']) ?> visa journey?</h2>
            <div class="button-group" style="justify-content:center">
                <a href="/enquire/?country=<?= e($country['slug']) ?>" class="btn btn-gold btn-lg" data-open-enquiry-modal>Start Your Visa Enquiry</a>
                <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$country['name']} visas.")) ?>" class="btn btn-outline btn-lg" target="_blank" rel="noopener noreferrer">WhatsApp a Visa Expert</a>
            </div>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
