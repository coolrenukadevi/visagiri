<?php
/**
 * Renders every published visa-category section for ONE country, inline on
 * its existing flat /country-{slug} page — no new URLs. Adapted from the
 * fuller per-category template at includes/visa-content/country-visa-page.php
 * (built for the retired /countries/{slug}-{category} URL system, which
 * 301-redirects here instead of serving a second, duplicate URL per the
 * decision already recorded in countries.php).
 *
 * Expects $countrySlugForContent to be set by the including country-*.php
 * file. Renders nothing (silently) if the country or its categories aren't
 * found, so a missing/misspelled slug never breaks the page.
 *
 * Honesty rules enforced here, not just assumed:
 * - A field is only displayed if the DB value is non-empty; empty fields
 *   are omitted rather than filled with a guess (visa_field_or_fallback()
 *   already returns a neutral "varies / check official source" string,
 *   never a fabricated specific).
 * - The "Official Source" line only renders when a real visa_sources row
 *   exists for that category. For the categories that don't have one yet,
 *   no source link is shown or invented.
 * - last_reviewed_date is shown as "Content last updated", not "verified
 *   against the official source", unless a real source row backs it up.
 */

require_once __DIR__ . '/../visa-content-db.php';

$cpc_pdo = visa_content_db();

$cpc_country = null;
if (!empty($countrySlugForContent)) {
    $cpc_stmt = $cpc_pdo->prepare('SELECT * FROM countries WHERE slug = ? AND is_active = 1');
    $cpc_stmt->execute([$countrySlugForContent]);
    $cpc_country = $cpc_stmt->fetch(PDO::FETCH_ASSOC);
}

if ($cpc_country):
    $cpc_catStmt = $cpc_pdo->prepare("SELECT cvp.*, vc.name AS category_name, vc.slug AS category_slug
        FROM country_visa_pages cvp
        JOIN visa_categories vc ON vc.id = cvp.visa_category_id
        WHERE cvp.country_id = ? AND cvp.status = 'published'
        ORDER BY vc.sort_order");
    $cpc_catStmt->execute([$cpc_country['id']]);
    $cpc_categories = $cpc_catStmt->fetchAll(PDO::FETCH_ASSOC);
endif;

if (!empty($cpc_country) && !empty($cpc_categories)):
    $cpc_countryName = $cpc_country['name'];
    $cpc_allFaqs = [];
    $cpc_latestReview = null;
    $cpc_anySource = false;
?>
        <nav class="svc-sibling-nav" aria-label="Visa categories for <?php echo htmlspecialchars($cpc_countryName); ?>">
            <div class="svc-sibling-inner">
                <?php foreach ($cpc_categories as $cpc_cat): ?>
                <a href="#<?php echo htmlspecialchars($cpc_cat['category_slug']); ?>"><?php echo htmlspecialchars($cpc_cat['category_name']); ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <?php foreach ($cpc_categories as $cpc_cat):
            $cpc_titleBase = $cpc_countryName . ' ' . $cpc_cat['category_name'];

            $cpc_docsStmt = $cpc_pdo->prepare('SELECT * FROM visa_documents WHERE country_visa_page_id = ? ORDER BY category, sort_order');
            $cpc_docsStmt->execute([$cpc_cat['id']]);
            $cpc_docsByCategory = [];
            foreach ($cpc_docsStmt->fetchAll(PDO::FETCH_ASSOC) as $cpc_d) {
                $cpc_docsByCategory[$cpc_d['category']][] = $cpc_d;
            }
            $cpc_docCategoryOrder = ['Basic Documents', 'Financial Documents', 'Travel Documents', 'Supporting Documents'];

            $cpc_stepsStmt = $cpc_pdo->prepare('SELECT * FROM visa_process_steps WHERE country_visa_page_id = ? ORDER BY step_number');
            $cpc_stepsStmt->execute([$cpc_cat['id']]);
            $cpc_steps = $cpc_stepsStmt->fetchAll(PDO::FETCH_ASSOC);

            $cpc_faqsStmt = $cpc_pdo->prepare('SELECT * FROM visa_faqs WHERE country_visa_page_id = ? ORDER BY sort_order');
            $cpc_faqsStmt->execute([$cpc_cat['id']]);
            $cpc_faqs = $cpc_faqsStmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($cpc_faqs as $cpc_f) { $cpc_allFaqs[] = $cpc_f; }

            $cpc_feesStmt = $cpc_pdo->prepare('SELECT * FROM visa_fees WHERE country_visa_page_id = ? ORDER BY sort_order');
            $cpc_feesStmt->execute([$cpc_cat['id']]);
            $cpc_fees = $cpc_feesStmt->fetchAll(PDO::FETCH_ASSOC);
            $cpc_govFees = array_filter($cpc_fees, function ($f) { return (int) $f['is_government'] === 1; });
            $cpc_serviceFees = array_filter($cpc_fees, function ($f) { return (int) $f['is_government'] === 0; });

            $cpc_sourcesStmt = $cpc_pdo->prepare('SELECT * FROM visa_sources WHERE country_visa_page_id = ? ORDER BY id');
            $cpc_sourcesStmt->execute([$cpc_cat['id']]);
            $cpc_sources = $cpc_sourcesStmt->fetchAll(PDO::FETCH_ASSOC);
            if ($cpc_sources) { $cpc_anySource = true; }

            if ($cpc_cat['last_reviewed_date'] && (!$cpc_latestReview || $cpc_cat['last_reviewed_date'] > $cpc_latestReview)) {
                $cpc_latestReview = $cpc_cat['last_reviewed_date'];
            }
        ?>
        <section id="<?php echo htmlspecialchars($cpc_cat['category_slug']); ?>" class="section-padding fix" style="scroll-margin-top:80px;">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp"><?php echo htmlspecialchars($cpc_countryName); ?></span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($cpc_titleBase); ?></h2>
                </div>

                <?php if ($cpc_cat['intro_html']): ?>
                <div class="svc-lede"><?php echo $cpc_cat['intro_html']; ?></div>
                <?php endif; ?>

                <!-- At a glance -->
                <div class="visa-info-card">
                    <div><label>Visa Type</label><span><?php echo htmlspecialchars($cpc_cat['category_name']); ?></span></div>
                    <?php if ($cpc_cat['official_visa_name']): ?><div><label>Official Visa Name</label><span><?php echo htmlspecialchars($cpc_cat['official_visa_name']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['visa_subclass_code']): ?><div><label>Subclass / Category Code</label><span><?php echo htmlspecialchars($cpc_cat['visa_subclass_code']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['typical_stay']): ?><div><label>Typical Stay</label><span><?php echo htmlspecialchars($cpc_cat['typical_stay']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['entry_type']): ?><div><label>Entry Type</label><span><?php echo htmlspecialchars($cpc_cat['entry_type']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['validity_text']): ?><div><label>Visa Validity</label><span><?php echo htmlspecialchars($cpc_cat['validity_text']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['application_method']): ?><div><label>Application Method</label><span><?php echo htmlspecialchars($cpc_cat['application_method']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['interview_required']): ?><div><label>Interview Required</label><span><?php echo htmlspecialchars($cpc_cat['interview_required']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['biometric_required']): ?><div><label>Biometric Requirement</label><span><?php echo htmlspecialchars($cpc_cat['biometric_required']); ?></span></div><?php endif; ?>
                    <div><label>Processing Time</label><span><?php echo htmlspecialchars(visa_field_or_fallback($cpc_cat['processing_time_text'], 'Check current official processing times before applying.')); ?></span></div>
                    <div><label>Approx. Government Fee</label><span><?php echo htmlspecialchars(visa_field_or_fallback($cpc_cat['government_fee_text'], 'Check the current official fee before applying.')); ?></span></div>
                    <?php if ($cpc_cat['application_centre']): ?><div><label>Application Centre</label><span><?php echo htmlspecialchars($cpc_cat['application_centre']); ?></span></div><?php endif; ?>
                    <?php if ($cpc_cat['authority_name']): ?>
                    <div><label>Official Immigration Authority</label><span><?php if ($cpc_cat['authority_url']): ?><a href="<?php echo htmlspecialchars($cpc_cat['authority_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($cpc_cat['authority_name']); ?></a><?php else: echo htmlspecialchars($cpc_cat['authority_name']); endif; ?></span></div>
                    <?php endif; ?>
                </div>
                <p class="visa-info-note">Information above reflects the visa category in general. Exact requirements can vary by applicant profile &mdash; where details vary, this is noted rather than assumed.</p>

                <?php if ($cpc_cat['eligibility_html']): ?>
                <h3 style="margin:32px 0 14px; font-size:18px;">Who Can Apply</h3>
                <div class="svc-lede"><?php echo $cpc_cat['eligibility_html']; ?></div>
                <?php endif; ?>

                <?php if ($cpc_docsByCategory): ?>
                <h3 style="margin:32px 0 14px; font-size:18px;">Documents You'll Need</h3>
                <div class="visa-doc-groups">
                    <?php foreach ($cpc_docCategoryOrder as $cpc_catLabel): if (empty($cpc_docsByCategory[$cpc_catLabel])) continue; ?>
                    <div class="visa-doc-group">
                        <h4><?php echo htmlspecialchars($cpc_catLabel); ?></h4>
                        <div class="svc-checklist">
                            <?php foreach ($cpc_docsByCategory[$cpc_catLabel] as $cpc_doc): $cpc_reqLevel = $cpc_doc['requirement_level'] ?? 'mandatory'; ?>
                            <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt"><?php echo htmlspecialchars($cpc_doc['label']); ?><?php if ($cpc_reqLevel === 'conditional'): ?> <em>(conditional &mdash; where applicable)</em><?php elseif ($cpc_reqLevel === 'recommended'): ?> <em>(recommended, not mandatory)</em><?php endif; ?></span></div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <?php if ($cpc_steps): ?>
                <h3 style="margin:32px 0 14px; font-size:18px;">Application Process</h3>
                <div class="svc-steps">
                    <?php foreach ($cpc_steps as $cpc_i => $cpc_step): ?>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num"><?php echo $cpc_i + 1; ?></div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3><?php echo htmlspecialchars($cpc_step['title']); ?></h3><p><?php echo htmlspecialchars($cpc_step['description']); ?></p></div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <h3 style="margin:32px 0 14px; font-size:18px;">Visa Fees</h3>
                <div class="visa-fee-cols">
                    <div class="visa-fee-col">
                        <h4>Government / Application Fees</h4>
                        <?php if ($cpc_govFees): foreach ($cpc_govFees as $cpc_f): ?>
                        <div class="visa-fee-row"><span><?php echo htmlspecialchars($cpc_f['label']); ?></span><strong><?php echo htmlspecialchars($cpc_f['amount_display']); ?></strong></div>
                        <?php endforeach; else: ?>
                        <p class="visa-info-note">Check the current official fee before applying.</p>
                        <?php endif; ?>
                    </div>
                    <div class="visa-fee-col">
                        <h4>Visa Agency Service Fee</h4>
                        <?php if ($cpc_serviceFees): foreach ($cpc_serviceFees as $cpc_f): ?>
                        <div class="visa-fee-row"><span><?php echo htmlspecialchars($cpc_f['label']); ?></span><strong><?php echo htmlspecialchars($cpc_f['amount_display']); ?></strong></div>
                        <?php endforeach; else: ?>
                        <p class="visa-info-note">Contact us for our current service fee for this visa category.</p>
                        <?php endif; ?>
                    </div>
                </div>

                <?php if ($cpc_cat['indian_applicant_html']): ?>
                <h3 style="margin:32px 0 14px; font-size:18px;">For Indian Citizens</h3>
                <div class="svc-lede"><?php echo $cpc_cat['indian_applicant_html']; ?></div>
                <?php endif; ?>

                <?php if ($cpc_faqs): ?>
                <h3 style="margin:32px 0 14px; font-size:18px;"><?php echo htmlspecialchars($cpc_titleBase); ?> FAQs</h3>
                <div class="faq-accordion">
                    <?php foreach ($cpc_faqs as $cpc_i => $cpc_faq): ?>
                    <div class="faq-item<?php echo $cpc_i === 0 ? ' active' : ''; ?>">
                        <div class="faq-question"><?php echo htmlspecialchars($cpc_faq['question']); ?> <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p><?php echo $cpc_faq['answer']; ?></p></div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <?php if ($cpc_sources && ($cpc_cat['content_status'] ?? '') === 'verified'): ?>
                <p class="visa-info-note mt-3">
                    <?php if ($cpc_cat['last_reviewed_date']): ?>Verified against the official source on <?php echo htmlspecialchars(date('j F Y', strtotime($cpc_cat['last_reviewed_date']))); ?><?php endif; ?>
                    <?php foreach ($cpc_sources as $cpc_src): ?>
                        &middot; Source: <?php if ($cpc_src['source_url']): ?><a href="<?php echo htmlspecialchars($cpc_src['source_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($cpc_src['source_authority']); ?></a><?php else: echo htmlspecialchars($cpc_src['source_authority']); endif; ?>
                    <?php endforeach; ?>
                </p>
                <?php elseif ($cpc_sources): ?>
                <p class="visa-info-note mt-3">
                    Researched from <?php foreach ($cpc_sources as $cpc_srcI => $cpc_src): ?><?php echo $cpc_srcI > 0 ? ', ' : ''; ?><?php if ($cpc_src['source_url']): ?><a href="<?php echo htmlspecialchars($cpc_src['source_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($cpc_src['source_authority']); ?></a><?php else: echo htmlspecialchars($cpc_src['source_authority']); endif; ?><?php endforeach; ?><?php if ($cpc_cat['last_reviewed_date']): ?> &middot; content last updated <?php echo htmlspecialchars(date('j F Y', strtotime($cpc_cat['last_reviewed_date']))); ?><?php endif; ?>. Fees and processing times change — always confirm current figures on the official source before applying or paying.
                </p>
                <?php elseif ($cpc_cat['last_reviewed_date']): ?>
                <p class="visa-info-note mt-3">Content last updated <?php echo htmlspecialchars(date('j F Y', strtotime($cpc_cat['last_reviewed_date']))); ?>. Always confirm current requirements with the relevant embassy, consulate or immigration authority before applying.</p>
                <?php endif; ?>

                <p class="visa-info-note mt-3"><?php echo htmlspecialchars($cpc_cat['category_name']); ?> assistance is available online for applicants across India, regardless of which state or city you're applying from.</p>

                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry
                       data-country="<?php echo htmlspecialchars($cpc_countryName); ?>"
                       data-visa-type="<?php echo htmlspecialchars($cpc_cat['category_name']); ?>">Start Your <?php echo htmlspecialchars($cpc_titleBase); ?> Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>
        <?php endforeach; ?>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="compliance-note">
                    Visa requirements, fees, processing times and immigration policies may change without notice.
                    Information provided by VisaAgency.in is for general guidance and does not constitute legal or
                    immigration advice. Applicants should verify current requirements with the relevant government
                    or immigration authority before submitting an application. Visa approval is solely at the
                    discretion of the concerned authority.
                </div>
                <div class="mt-4 d-flex flex-wrap gap-3 justify-content-center">
                    <a href="visa-requirements" class="theme-btn style-2">Check Visa Requirements</a>
                    <a href="visa-checklist" class="theme-btn style-2">Document Checklist Tool</a>
                    <a href="visa-fee-calculator" class="theme-btn style-2">Fee Calculator</a>
                    <a href="visa-appointment" class="theme-btn style-2">Book an Appointment</a>
                    <a href="visa-consultant" class="theme-btn style-2">Find Visa Consultant Near You</a>
                </div>
            </div>
        </section>

<?php if ($cpc_allFaqs): ?>
<script type="application/ld+json">
<?php
echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'FAQPage',
    'mainEntity' => array_map(function ($f) {
        return ['@type' => 'Question', 'name' => $f['question'], 'acceptedAnswer' => ['@type' => 'Answer', 'text' => strip_tags($f['answer'])]];
    }, $cpc_allFaqs),
], JSON_UNESCAPED_SLASHES);
?>
</script>
<?php endif; ?>
<script type="application/ld+json">
<?php
$cpc_serviceLd = [
    '@context' => 'https://schema.org',
    '@type' => 'Service',
    'name' => $cpc_countryName . ' Visa Consultancy',
    'serviceType' => 'Visa Consultancy',
    'provider' => ['@id' => 'https://visaagency.in/#organization'],
    'areaServed' => ['@type' => 'Country', 'name' => 'India'],
    'audience' => ['@type' => 'Audience', 'audienceType' => 'Indian passport holders travelling to ' . $cpc_countryName],
    'hasOfferCatalog' => [
        '@type' => 'OfferCatalog',
        'name' => $cpc_countryName . ' Visa Categories',
        'itemListElement' => array_map(function ($c) use ($cpc_countryName) {
            return ['@type' => 'Offer', 'itemOffered' => ['@type' => 'Service', 'name' => $cpc_countryName . ' ' . $c['category_name']]];
        }, $cpc_categories),
    ],
];
if ($cpc_latestReview) { $cpc_serviceLd['dateModified'] = $cpc_latestReview; }
echo json_encode($cpc_serviceLd, JSON_UNESCAPED_SLASHES);
?>
</script>
<?php
endif; // cpc_country && cpc_categories
?>
