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
    <section class="visa-detail<?= $checklist !== null ? ' visa-detail--checklist' : '' ?>">
        <div class="container">
            <?php if ($checklist === null): ?>
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/countries/">Countries</a></li>
                <li><a href="/visa/<?= e($country['slug']) ?>/"><?= e($country['name']) ?></a></li>
                <li><?= e($visaType['name']) ?></li>
            </ul>
            <?php endif; ?>

            <?php if ($checklist !== null): ?>
            <?php
            $feeDisplay = $fee !== null
                ? ($fee['amount'] !== null ? $fee['currency'] . ' ' . number_format((float) $fee['amount'], 2) : ($fee['label'] ?: 'Check latest fee'))
                : 'Check latest fee';
            $unlockAttrs = 'data-open-enquiry-modal-checklist data-country="' . e($country['slug']) . '" data-visa-type="' . e($visaType['slug']) . '" data-checklist-ref="' . e($checklist['reference']) . '"';
            $enquireHref = '/enquire/?country=' . e($country['slug']) . '&amp;visa_type=' . e($visaType['slug']) . '&amp;checklist_ref=' . e($checklist['reference']);
            $heroStyle = !empty($checklist['hero_image_url']) ? " style=\"background-image: url('" . e($checklist['hero_image_url']) . "')\"" : '';
            $lastReviewedDisplay = !empty($checklist['last_reviewed_at']) ? date('d M Y', strtotime((string) $checklist['last_reviewed_at'])) : null;
            // Small flat outline icons for the hero's meta row — inline SVG
            // rather than an icon font/library, matching this project's
            // zero-external-dependency convention (see AUDIT.md).
            $vcIcons = [
                'passport' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="2" width="14" height="20" rx="2"/><circle cx="12" cy="9" r="2.5"/><path d="M8 16h8M9 19h6"/></svg>',
                'user' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="3.5"/><path d="M4.5 20c1.5-4 5-5.5 7.5-5.5s6 1.5 7.5 5.5"/></svg>',
                'flag' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M5 3v18"/><path d="M5 4h13l-3 4 3 4H5"/></svg>',
                'checklist' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M9 3v2h6V3M8 11l2 2 4-4M8 17h8"/></svg>',
                'calendar' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M16 3v4M8 3v4M3 10h18"/></svg>',
                'lock' => '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg>',
                'lock-sm' => '<svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="11" width="14" height="9" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg>',
                'check' => '<svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg>',
                'shield' => '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6l7-3z"/></svg>',
                'shield-check' => '<svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6l7-3z"/><path d="M9 12l2 2 4-4"/></svg>',
            ];
            // Locked-section titles are collected while looping the real
            // checklist below, then rendered once as a single consolidated
            // panel (never per-section) — a section's title is not
            // sensitive, but this keeps the locked experience compact
            // instead of repeating the same CTA once per hidden section.
            $lockedSectionTitles = [];
            ?>
            <div class="visa-checklist-page">
                <div class="vc-hero-full"<?= $heroStyle ?>>
                    <div class="vc-hero-inner">
                        <ul class="breadcrumb">
                            <li><a href="/">Home</a></li>
                            <li><a href="/countries/">Visa</a></li>
                            <li><a href="/visa/<?= e($country['slug']) ?>/"><?= e($country['name']) ?></a></li>
                            <li><?= e($visaType['name']) ?></li>
                        </ul>
                        <div class="vc-hero-grid">
                            <h1><?= e($country['name']) ?> <?= e($visaType['name']) ?><span>Complete Visa Document Checklist for Indian Applicants</span></h1>
                            <p class="vc-hero-lede">Prepare your documents with confidence. Get the latest requirements and let our experts guide you through a smooth visa application process.</p>
                            <div class="vc-hero-cta">
                                <?php if (!$hasChecklistAccess): ?>
                                <a href="<?= $enquireHref ?>" class="btn btn-gold" <?= $unlockAttrs ?>>Get Complete Checklist</a>
                                <?php else: ?>
                                <a href="#vc-print-trigger" class="btn btn-gold" data-vc-print>View Complete Checklist</a>
                                <?php endif; ?>
                                <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to talk to a visa expert about the {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline" target="_blank" rel="noopener noreferrer">Speak to an Expert</a>
                            </div>
                            <div class="vc-meta-row">
                                <div class="vc-pills">
                                    <span class="vc-pill"><span class="vc-pill-icon"><?= $vcIcons['passport'] ?></span> <?= e($visaType['name']) ?></span>
                                    <span class="vc-pill"><span class="vc-pill-icon"><?= $vcIcons['user'] ?></span> India Applicants</span>
                                    <span class="vc-pill"><span class="vc-pill-icon"><?= $vcIcons['flag'] ?></span> <?= e($country['name']) ?></span>
                                    <span class="vc-pill"><span class="vc-pill-icon"><?= $vcIcons['checklist'] ?></span> Document Checklist</span>
                                </div>
                                <?php if ($lastReviewedDisplay): ?>
                                <div class="vc-hero-reviewed"><span class="vc-pill-icon"><?= $vcIcons['calendar'] ?></span> <span>Last Reviewed<b><?= e($lastReviewedDisplay) ?></b></span></div>
                                <?php endif; ?>
                            </div>
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

                <div class="vc-overview">
                    <h2>Visa Overview</h2>
                    <div class="vc-overview-grid">
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#128179;</span><div><b>Visa Type</b><span><?= e($visaType['name']) ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#129517;</span><div><b>Purpose of Travel</b><span><?= e($checklist['purpose'] ?: 'As per application') ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#128337;</span><div><b>Typical Stay</b><span><?= e($checklist['typical_stay'] ?: 'As permitted by visa decision') ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#127974;</span><div><b>Application Method</b><span><?= e($checklist['application_method'] ?: 'Check current guidance') ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#128100;</span><div><b>Personal Appearance</b><span><?= $checklist['personal_appearance'] ? 'Required' : 'May be required' ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#9201;</span><div><b>Processing Time</b><span><?= e($checklist['processing_note'] ?: 'Variable; check current guidance') ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#128179;</span><div><b>Visa Fee</b><span><?= e($feeDisplay) ?></span></div></div>
                        <div class="vc-overview-item"><span class="vc-overview-icon">&#127963;</span><div><b>Consular Office</b><span><?= e($checklist['consular_office'] ?: 'Check current guidance') ?></span></div></div>
                    </div>
                </div>

                <div class="vc-info-note">
                    <span class="vc-info-icon">&#8505;</span>
                    <span><b>Note:</b> This information is a general guide. Visa requirements may change. Always verify the latest requirements from the official website of the Embassy/Consulate of <?= e($country['name']) ?> in India.</span>
                </div>

                <div class="vc-checklist-heading">
                    <h2><?= e($country['name']) ?> <?= e($visaType['name']) ?> Document Checklist</h2>
                    <p><?= $hasChecklistAccess ? 'Your complete, unlocked document checklist is below — print or download the full A4 guide any time.' : 'Essential documents you should start preparing. The complete and updated checklist will be available after you submit the enquiry form.' ?></p>
                </div>

                <?php foreach ($checklist['sections'] as $sectionIndex => $section): ?>
                <?php
                $sectionIsPublic = $hasChecklistAccess || checklist_section_is_public($section);
                if (!$sectionIsPublic) {
                    $lockedSectionTitles[] = $section['title'];
                    continue;
                }
                ?>
                <div class="vc-section-card">
                    <div class="vc-section-head">
                        <span class="vc-section-num"><?= sprintf('%02d', $sectionIndex + 1) ?></span>
                        <h3><?= e($section['title']) ?></h3>
                        <span class="vc-section-tag"><?= $hasChecklistAccess ? 'Unlocked' : 'Mandatory for all applicants' ?></span>
                    </div>
                    <table class="vc-doc-table">
                        <tr><th>#</th><th>Document</th><th>Details / Guidelines</th><th>Original / Copy</th></tr>
                        <?php foreach ($section['documents'] as $docIndex => $doc): ?>
                        <tr>
                            <td><input type="checkbox" disabled></td>
                            <td class="vc-doc-name"><?= e($doc['name']) ?></td>
                            <td class="vc-doc-desc"><?= e($doc['description'] ?: '—') ?></td>
                            <td><span class="vc-doc-type"><?= e(ucfirst(str_replace('_', ' ', $doc['document_type']))) ?></span></td>
                        </tr>
                        <?php endforeach; ?>
                    </table>
                </div>
                <?php endforeach; ?>

                <?php if ($lockedSectionTitles): ?>
                <?php
                $lockedCount = count($lockedSectionTitles);
                $lockedListSentence = $lockedCount === 1
                    ? $lockedSectionTitles[0]
                    : implode(', ', array_slice($lockedSectionTitles, 0, -1)) . ' and ' . end($lockedSectionTitles);
                ?>
                <div class="vc-locked-panel">
                    <div class="vc-locked-panel-main">
                        <div class="vc-locked-panel-head">
                            <span class="vc-locked-panel-icon"><?= $vcIcons['lock'] ?></span>
                            <div>
                                <h3>Remaining Checklist Locked</h3>
                                <p>The complete checklist includes <?= e($lockedListSentence) ?>.</p>
                            </div>
                        </div>
                        <ul class="vc-locked-list">
                            <?php foreach ($lockedSectionTitles as $lockedTitle): ?>
                            <li><span class="vc-locked-list-icon"><?= $vcIcons['lock-sm'] ?></span> <?= e($lockedTitle) ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                    <div class="vc-locked-panel-cta">
                        <h4>Get the Complete Checklist</h4>
                        <ul class="vc-locked-benefits">
                            <li><?= $vcIcons['check'] ?> Latest &amp; updated document list</li>
                            <li><?= $vcIcons['check'] ?> Personalized as per your profile</li>
                            <li><?= $vcIcons['check'] ?> Prepared by visa experts</li>
                            <li><?= $vcIcons['check'] ?> Instant access after enquiry</li>
                        </ul>
                        <a href="<?= $enquireHref ?>" class="btn btn-gold vc-locked-btn" <?= $unlockAttrs ?>>Enquire Now &amp; Unlock Checklist &rarr;</a>
                    </div>
                </div>
                <?php endif; ?>

                <div class="vc-trust-row">
                    <div class="vc-trust-item"><span class="vc-trust-icon"><?= $vcIcons['shield'] ?></span><div><b>Trusted Visa Experts</b><span>For Indian Travellers</span></div></div>
                    <div class="vc-trust-item"><span class="vc-trust-icon"><?= $vcIcons['shield-check'] ?></span><div><b>Accurate &amp; Updated Information</b></div></div>
                    <div class="vc-trust-item"><span class="vc-trust-icon"><?= $vcIcons['user'] ?></span><div><b>End-to-End Support</b><span>Till Visa Decision</span></div></div>
                    <div class="vc-trust-item"><span class="vc-trust-icon"><?= $vcIcons['lock'] ?></span><div><b>Secure &amp; Confidential</b><span>Your Data is Safe</span></div></div>
                </div>

                <div class="vc-download-panel">
                    <div>
                        <h3>Need the complete A4 Visa Checklist?</h3>
                        <p>Print or save a branded, ready-to-follow PDF with full guidance for every document.</p>
                    </div>
                    <div class="vc-download-buttons">
                        <?php if ($hasChecklistAccess): ?>
                        <button type="button" class="btn btn-outline" data-vc-print>&#128424; Print Checklist</button>
                        <button type="button" class="btn btn-gold" data-vc-print>&#8595; Download A4 PDF</button>
                        <?php else: ?>
                        <a href="<?= $enquireHref ?>" class="btn btn-outline" <?= $unlockAttrs ?>>&#128424; Print Checklist</a>
                        <a href="<?= $enquireHref ?>" class="btn btn-gold" <?= $unlockAttrs ?>>&#8595; Download A4 PDF</a>
                        <?php endif; ?>
                    </div>
                </div>

                <div class="vc-note">
                    <b>Important:</b> <?= e($checklist['disclaimer'] ?: CHECKLIST_DEFAULT_DISCLAIMER) ?>
                    <?php if (!empty($checklist['source_url'])): ?> <a href="<?= e($checklist['source_url']) ?>" rel="nofollow noopener" target="_blank">Source</a><?php endif; ?>
                </div>
            </div>

            <?php if ($hasChecklistAccess): ?>
            <?php
            // The complete, branded A4 document — only ever present in the
            // response when $hasChecklistAccess is true (server-verified
            // above), so there is nothing for a locked-out visitor to find
            // in the page source, view-source, or a saved-as-PDF copy.
            $pageGroups = array_chunk($checklist['sections'], 3);
            $totalPages = count($pageGroups);
            $sectionCounter = 0;
            ?>
            <div class="print-document">
                <?php foreach ($pageGroups as $pageIndex => $pageSections): ?>
                <?php $pageNum = $pageIndex + 1; $isFirst = $pageIndex === 0; $isLast = $pageNum === $totalPages; ?>
                <section class="p-page">
                    <div class="p-head">
                        <div class="p-brand">VISA<span>GIRI</span><small>VISA MANAGEMENT</small></div>
                        <div class="p-tag">Your Journey<br>Our Expertise</div>
                    </div>
                    <div class="p-title">
                        <h1><?= e(strtoupper($country['name'])) ?> <span><?= e(strtoupper($visaType['name'])) ?></span></h1>
                        <p><b><?= $isFirst ? 'Document Checklist for Applicants Applying from India' : ($isLast ? 'Appointment, Submission &amp; Final Verification' : 'Document Checklist — Continued') ?></b></p>
                    </div>
                    <div class="p-meta">
                        <div><b>Visa Type</b><span><?= e($visaType['name']) ?></span></div>
                        <div><b>Applicant</b><span>Indian Passport Holder</span></div>
                        <div><b>Checklist Ref.</b><span><?= e($checklist['reference']) ?></span></div>
                        <div><b>Page</b><span><?= $pageNum ?> of <?= $totalPages ?></span></div>
                        <div><b>Last Reviewed</b><span><?= !empty($checklist['last_reviewed_at']) ? e(date('d M Y', strtotime((string) $checklist['last_reviewed_at']))) : 'N/A' ?></span></div>
                    </div>

                    <?php if ($isFirst): ?>
                    <div class="p-cols">
                        <div>
                            <?php foreach ($pageSections as $section): $sectionCounter++; ?>
                            <section class="p-section">
                                <div class="p-section-head"><div class="p-num"><?= sprintf('%02d', $sectionCounter) ?></div><h2><?= e(strtoupper($section['title'])) ?></h2></div>
                                <table class="p-table">
                                    <tr><th>&#10003;</th><th>Document</th><th>Details / Guidelines</th><th>Type</th></tr>
                                    <?php foreach ($section['documents'] as $doc): ?>
                                    <tr>
                                        <td><span class="p-box"></span></td>
                                        <td><b><?= e($doc['name']) ?></b></td>
                                        <td><?= e($doc['description'] ?: '—') ?></td>
                                        <td><?= e(ucfirst(str_replace('_', ' ', $doc['document_type']))) ?></td>
                                    </tr>
                                    <?php endforeach; ?>
                                </table>
                            </section>
                            <?php endforeach; ?>
                        </div>
                        <div>
                            <div class="p-side-box">
                                <h3>AT A GLANCE</h3>
                                <div class="p-glance-row"><b>Purpose</b><span><?= e($checklist['purpose'] ?: 'Not specified') ?></span></div>
                                <div class="p-glance-row"><b>Stay</b><span><?= e($checklist['typical_stay'] ?: 'As permitted by visa decision') ?></span></div>
                                <div class="p-glance-row"><b>Processing</b><span><?= e($checklist['processing_note'] ?: 'Variable; check current guidance') ?></span></div>
                                <div class="p-glance-row"><b>Visa Fee</b><span><?= e($feeDisplay) ?></span></div>
                                <div class="p-glance-row"><b>Submission</b><span><?= e($checklist['application_method'] ?: 'Check current guidance') ?></span></div>
                                <div class="p-glance-row"><b>Appearance</b><span><?= $checklist['personal_appearance'] ? 'Required' : 'Follow current instructions' ?></span></div>
                            </div>
                            <div class="p-note-box">
                                <h3>IMPORTANT NOTES</h3>
                                <ul>
                                    <li>This is a preparation guide, not a guarantee of visa approval.</li>
                                    <li>Additional documents may be requested based on the applicant profile.</li>
                                    <li>Verify the latest official requirements before submission.</li>
                                </ul>
                            </div>
                            <div class="p-order-box">
                                <h3>DOCUMENT ORDERING GUIDE</h3>
                                <ol>
                                    <?php foreach ($checklist['sections'] as $orderSection): ?>
                                    <li><?= e($orderSection['title']) ?></li>
                                    <?php endforeach; ?>
                                </ol>
                            </div>
                            <div class="p-cta-box">
                                <h3>VISAGIRI ASSISTANCE</h3>
                                <p>Professional assistance with document preparation, visa guidance and appointment support.</p>
                                <p><b>www.visagiri.com</b><br>info@visagiri.com<br>+91 7065819819 / +91 7844819819</p>
                            </div>
                        </div>
                    </div>
                    <?php else: ?>
                    <div style="margin-top:4mm">
                        <?php foreach ($pageSections as $section): $sectionCounter++; ?>
                        <section class="p-section">
                            <div class="p-section-head"><div class="p-num"><?= sprintf('%02d', $sectionCounter) ?></div><h2><?= e(strtoupper($section['title'])) ?></h2></div>
                            <table class="p-table">
                                <tr><th>&#10003;</th><th>Document</th><th>Details / Guidelines</th><th>Type</th></tr>
                                <?php foreach ($section['documents'] as $doc): ?>
                                <tr>
                                    <td><span class="p-box"></span></td>
                                    <td><b><?= e($doc['name']) ?></b></td>
                                    <td><?= e($doc['description'] ?: '—') ?></td>
                                    <td><?= e(ucfirst(str_replace('_', ' ', $doc['document_type']))) ?></td>
                                </tr>
                                <?php endforeach; ?>
                            </table>
                        </section>
                        <?php endforeach; ?>
                    </div>

                    <?php if ($isLast): ?>
                    <div class="p-cols">
                        <div>
                            <div class="p-note-box">
                                <h3>IMPORTANT NOTES</h3>
                                <ul>
                                    <li>Requirements can change without notice.</li>
                                    <li>Additional documents may be requested.</li>
                                    <li>This checklist does not guarantee visa issuance.</li>
                                </ul>
                            </div>
                            <div class="p-order-box">
                                <h3>DOCUMENT ORDERING GUIDE</h3>
                                <ol>
                                    <?php foreach ($checklist['sections'] as $orderSection): ?>
                                    <li><?= e($orderSection['title']) ?></li>
                                    <?php endforeach; ?>
                                </ol>
                            </div>
                        </div>
                        <div>
                            <div class="p-cta-box">
                                <h3>VISAGIRI APPLICATION SUPPORT</h3>
                                <p>Professional assistance with document preparation, visa guidance and appointment support.</p>
                                <p><b>www.visagiri.com</b><br>info@visagiri.com<br>+91 7065819819 / +91 7844819819</p>
                            </div>
                            <div class="p-note-box">
                                <h3>SOURCE &amp; DISCLAIMER</h3>
                                <ul>
                                    <li><?= e($checklist['disclaimer'] ?: CHECKLIST_DEFAULT_DISCLAIMER) ?></li>
                                    <?php if (!empty($checklist['source'])): ?><li>Source: <?= e($checklist['source']) ?></li><?php endif; ?>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <?php else: ?>
                    <div class="p-note-box">
                        <h3>DOCUMENT QUALITY CHECK</h3>
                        <ul>
                            <li>Check names, dates and passport details for consistency across every document.</li>
                            <li>Follow current instructions for originals, signatures, stamps and copies.</li>
                            <li>Never submit altered, fabricated or misleading documents.</li>
                        </ul>
                    </div>
                    <?php endif; ?>
                    <?php endif; ?>

                    <div class="p-contact">
                        <span>+91 7065819819 &middot; +91 7844819819</span>
                        <span>info@visagiri.com</span>
                        <span>www.visagiri.com</span>
                    </div>
                    <div class="p-footer"><b>YOUR GLOBAL VISA PARTNER</b><span>Page <?= $pageNum ?> of <?= $totalPages ?></span></div>
                </section>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

            <script src="<?= e(asset_url('/assets/js/visa-checklist.js')) ?>" defer></script>
            <?php else: ?>

            <div class="visa-detail__header">
                <span class="destination-card__flag"><?= flag_emoji($country['iso2']) ?></span>
                <div>
                    <h1><?= $hasRichRequirement ? e("{$country['name']} {$visaType['name']} Consultant in India") : (e($visaType['name']) . ' &mdash; ' . e($country['name'])) ?></h1>
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

            <?php endif; // end $checklist !== null / else ?>

            <?php if ($checklist === null): ?>
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
            <?php endif; // checklist pages replace both blocks above with the consolidated locked panel + trust-badges row rendered inside the checklist branch itself ?>

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

            <?php if ($checklist !== null): ?>
            <div style="margin-top:var(--space-10)">
                <?php
                $testimonials = fetch_testimonials((int) $country['id'], (int) $visaType['id']);
                require __DIR__ . '/../includes/testimonials.php';
                ?>
            </div>
            <?php else: ?>
            <div class="final-cta" style="margin-top:var(--space-10)">
                <h2>Ready to start your <?= e($country['name']) ?> <?= e(strtolower($visaType['name'])) ?> application?</h2>
                <div class="button-group" style="justify-content:center">
                    <a href="/enquire/?country=<?= e($country['slug']) ?>&amp;visa_type=<?= e($visaType['slug']) ?>" class="btn btn-gold btn-lg" data-open-enquiry-modal>Start Your Visa Enquiry</a>
                    <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about {$visaType['name']} for {$country['name']}.")) ?>" class="btn btn-outline btn-lg" target="_blank" rel="noopener noreferrer">Talk to a Visa Expert</a>
                </div>
            </div>
            <?php endif; ?>
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
