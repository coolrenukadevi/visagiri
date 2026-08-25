<?php
/**
 * Country x visa-category content page: /countries/{country-slug}-{category-slug}/
 * Expects $pdo (PDO) and $page (assoc array, joined countries+visa_categories+country_visa_pages)
 * from countries.php.
 */

$countryName = $page['country_name'];
$categoryName = $page['category_name'];
$titleBase = "{$countryName} {$categoryName}";

$docsStmt = $pdo->prepare('SELECT * FROM visa_documents WHERE country_visa_page_id = ? ORDER BY category, sort_order');
$docsStmt->execute([$page['id']]);
$documentsByCategory = [];
foreach ($docsStmt->fetchAll(PDO::FETCH_ASSOC) as $d) {
    $documentsByCategory[$d['category']][] = $d;
}
$docCategoryOrder = ['Basic Documents', 'Financial Documents', 'Travel Documents', 'Supporting Documents'];

$stepsStmt = $pdo->prepare('SELECT * FROM visa_process_steps WHERE country_visa_page_id = ? ORDER BY step_number');
$stepsStmt->execute([$page['id']]);
$steps = $stepsStmt->fetchAll(PDO::FETCH_ASSOC);
if (!$steps) {
    $decoded = json_decode((string) $page['default_process_steps_json'], true);
    $steps = [];
    foreach ((array) $decoded as $i => $s) {
        $steps[] = ['step_number' => $i + 1, 'title' => $s['title'], 'description' => $s['description']];
    }
}

$faqsStmt = $pdo->prepare('SELECT * FROM visa_faqs WHERE country_visa_page_id = ? ORDER BY sort_order');
$faqsStmt->execute([$page['id']]);
$faqs = $faqsStmt->fetchAll(PDO::FETCH_ASSOC);

$feesStmt = $pdo->prepare('SELECT * FROM visa_fees WHERE country_visa_page_id = ? ORDER BY sort_order');
$feesStmt->execute([$page['id']]);
$fees = $feesStmt->fetchAll(PDO::FETCH_ASSOC);
$govFees = array_filter($fees, fn($f) => (int) $f['is_government'] === 1);
$serviceFees = array_filter($fees, fn($f) => (int) $f['is_government'] === 0);

$sourcesStmt = $pdo->prepare('SELECT * FROM visa_sources WHERE country_visa_page_id = ? ORDER BY id');
$sourcesStmt->execute([$page['id']]);
$sources = $sourcesStmt->fetchAll(PDO::FETCH_ASSOC);

$siblingStmt = $pdo->prepare("SELECT vc.name, vc.slug, cvp.page_slug
    FROM visa_categories vc
    LEFT JOIN country_visa_pages cvp ON cvp.visa_category_id = vc.id AND cvp.country_id = ? AND cvp.status = 'published'
    ORDER BY vc.sort_order");
$siblingStmt->execute([$page['c_id']]);
$siblingCategories = $siblingStmt->fetchAll(PDO::FETCH_ASSOC);

$relatedStmt = $pdo->prepare("SELECT c2.name, c2.slug, c2.flag, cvp2.page_slug
    FROM country_visa_pages cvp2
    JOIN countries c2 ON c2.id = cvp2.country_id
    WHERE cvp2.visa_category_id = ? AND cvp2.status = 'published' AND c2.id != ?
    ORDER BY c2.popularity DESC, c2.name ASC LIMIT 6");
$relatedStmt->execute([$page['vc_id'], $page['c_id']]);
$relatedDestinations = $relatedStmt->fetchAll(PDO::FETCH_ASSOC);

$pageUrl = 'https://visaagency.in/' . visa_country_page_url($page['page_slug']);
$page_title = $page['seo_title'] ?: "{$titleBase} from India | Requirements, Documents &amp; Application";
$page_description = $page['meta_description'] ?: "Apply for {$titleBase} from India. Check eligibility, documents, application process, fees, processing information and visa assistance.";
$page_canonical = $pageUrl;
$page_og_title = $page['og_title'] ?: $page_title;
$page_og_description = $page['og_description'] ?: $page_description;
include __DIR__ . '/../header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title"><?php echo htmlspecialchars($titleBase); ?></h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="country-list">Countries</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="<?php echo htmlspecialchars(visa_country_url($page['country_slug'])); ?>"><?php echo htmlspecialchars($countryName); ?></a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo htmlspecialchars($categoryName); ?></li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Hero / overview -->
        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp"><?php echo htmlspecialchars($page['country_flag'] ?: ''); ?> <?php echo htmlspecialchars($countryName); ?></span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($titleBase); ?></h2>
                </div>
                <p class="svc-lede">
                    Apply for <?php echo htmlspecialchars($titleBase); ?> from India with professional visa assistance.
                    <?php echo $page['intro_html'] ?: ''; ?>
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num"><?php echo htmlspecialchars($countryName); ?></span><span class="lbl">Country</span></div>
                    <div><span class="num"><?php echo htmlspecialchars($categoryName); ?></span><span class="lbl">Visa Type</span></div>
                    <div><span class="num">Indian</span><span class="lbl">Passport Holder</span></div>
                    <div><span class="num"><?php echo htmlspecialchars($page['official_visa_name'] ?: $categoryName); ?></span><span class="lbl">Official Visa Name</span></div>
                </div>
                <div class="mt-4 d-flex flex-wrap gap-3 justify-content-center">
                    <a href="<?php echo htmlspecialchars(visa_country_page_url($page['page_slug'])); ?>#eligibility" class="theme-btn style-2">Check Eligibility</a>
                    <a href="contact" class="theme-btn" data-open-enquiry
                       data-country="<?php echo htmlspecialchars($countryName); ?>"
                       data-visa-type="<?php echo htmlspecialchars($categoryName); ?>"
                       data-purpose="<?php echo htmlspecialchars($categoryName); ?> &ndash; <?php echo htmlspecialchars($countryName); ?>">Start Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="<?php echo htmlspecialchars(visa_country_page_url($page['page_slug'])); ?>#documents" class="theme-btn style-2">Document Checklist</a>
                    <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Consultant</a>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Visa categories for <?php echo htmlspecialchars($countryName); ?>">
            <div class="svc-sibling-inner">
                <?php foreach ($siblingCategories as $sib): ?>
                    <?php if ($sib['page_slug']): ?>
                    <a href="<?php echo htmlspecialchars(visa_country_page_url($sib['page_slug'])); ?>" class="<?php echo $sib['slug'] === $page['category_slug'] ? 'current' : ''; ?>"><?php echo htmlspecialchars($countryName . ' ' . $sib['name']); ?></a>
                    <?php else: ?>
                    <span class="is-soon" style="opacity:.45;padding:0 10px;"><?php echo htmlspecialchars($countryName . ' ' . $sib['name']); ?></span>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>
        </nav>

        <!-- Quick visa information -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">At A Glance</span>
                    <h2 class="split-text-right split-text-in-right">Quick Visa Information</h2>
                </div>
                <div class="visa-info-card">
                    <div><label>Visa Type</label><span><?php echo htmlspecialchars($categoryName); ?></span></div>
                    <div><label>Official Visa Name</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['official_visa_name'])); ?></span></div>
                    <?php if ($page['visa_subclass_code']): ?>
                    <div><label>Subclass / Category Code</label><span><?php echo htmlspecialchars($page['visa_subclass_code']); ?></span></div>
                    <?php endif; ?>
                    <div><label>Typical Stay</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['typical_stay'])); ?></span></div>
                    <div><label>Entry Type</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['entry_type'])); ?></span></div>
                    <div><label>Processing Time</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['processing_time_text'], 'Check current official requirements before applying.')); ?></span></div>
                    <div><label>Visa Validity</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['validity_text'])); ?></span></div>
                    <div><label>Application Method</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['application_method'])); ?></span></div>
                    <div><label>Interview Required</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['interview_required'])); ?></span></div>
                    <div><label>Biometric Requirement</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['biometric_required'])); ?></span></div>
                    <div><label>Approx. Government Fee</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['government_fee_text'], 'Check current official fee before applying.')); ?></span></div>
                    <div><label>Application Centre</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['application_centre'])); ?></span></div>
                    <div><label>Official Immigration Authority</label><span><?php if ($page['authority_url']): ?><a href="<?php echo htmlspecialchars($page['authority_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars(visa_field_or_fallback($page['authority_name'])); ?></a><?php else: echo htmlspecialchars(visa_field_or_fallback($page['authority_name'])); endif; ?></span></div>
                </div>
                <p class="visa-info-note">Information above reflects the visa category in general. Exact requirements can vary by applicant profile &mdash; where details vary, this is noted rather than assumed.</p>
            </div>
        </section>

        <!-- Eligibility -->
        <?php if ($page['eligibility_html']): ?>
        <section id="eligibility" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Eligibility</span>
                    <h2 class="split-text-right split-text-in-right">Who Can Apply for <?php echo htmlspecialchars($titleBase); ?>?</h2>
                </div>
                <div class="svc-lede" style="text-align:left;max-width:900px;">
                    <?php echo $page['eligibility_html']; ?>
                </div>
            </div>
        </section>
        <?php endif; ?>

        <!-- Documents -->
        <section id="documents" class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Document Checklist</span>
                    <h2 class="split-text-right split-text-in-right">Documents You'll Need</h2>
                </div>
                <?php if ($documentsByCategory): ?>
                <div class="visa-doc-groups">
                    <?php foreach ($docCategoryOrder as $catLabel): if (empty($documentsByCategory[$catLabel])) continue; ?>
                    <div class="visa-doc-group">
                        <h4><?php echo htmlspecialchars($catLabel); ?></h4>
                        <div class="svc-checklist">
                            <?php foreach ($documentsByCategory[$catLabel] as $doc): ?>
                            <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt"><?php echo htmlspecialchars($doc['label']); ?></span></div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php else: ?>
                <p class="svc-lede">Document checklist for this visa category is being finalised. Contact us for the current requirements.</p>
                <?php endif; ?>
            </div>
        </section>

        <!-- Application process -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Step By Step</span>
                    <h2 class="split-text-right split-text-in-right">Application Process</h2>
                </div>
                <div class="svc-steps">
                    <?php foreach ($steps as $i => $step): ?>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num"><?php echo $i + 1; ?></div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3><?php echo htmlspecialchars($step['title']); ?></h3><p><?php echo htmlspecialchars($step['description']); ?></p></div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- Fees -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Visa Fees</span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($titleBase); ?> Fees</h2>
                </div>
                <div class="visa-fee-cols">
                    <div class="visa-fee-col">
                        <h4>Government / Application Fees</h4>
                        <?php if ($govFees): foreach ($govFees as $f): ?>
                        <div class="visa-fee-row"><span><?php echo htmlspecialchars($f['label']); ?></span><strong><?php echo htmlspecialchars($f['amount_display']); ?></strong></div>
                        <?php endforeach; else: ?>
                        <p class="visa-info-note">Check current official fee before applying.</p>
                        <?php endif; ?>
                    </div>
                    <div class="visa-fee-col">
                        <h4>Visa Agency Service Fee</h4>
                        <?php if ($serviceFees): foreach ($serviceFees as $f): ?>
                        <div class="visa-fee-row"><span><?php echo htmlspecialchars($f['label']); ?></span><strong><?php echo htmlspecialchars($f['amount_display']); ?></strong></div>
                        <?php endforeach; else: ?>
                        <p class="visa-info-note">Contact us for our current service fee for this visa category.</p>
                        <?php endif; ?>
                    </div>
                </div>
                <p class="visa-info-note">Visa fees may change without notice. Applicants should verify the latest fee with the relevant government authority before submission.</p>
            </div>
        </section>

        <!-- Authority -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Where It's Decided</span>
                    <h2 class="split-text-right split-text-in-right">Official Immigration Authority</h2>
                </div>
                <div class="visa-info-card" style="max-width:640px;margin:0 auto;">
                    <div><label>Authority</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['authority_name'])); ?></span></div>
                    <?php if ($page['authority_url']): ?>
                    <div><label>Official Website</label><span><a href="<?php echo htmlspecialchars($page['authority_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($page['authority_url']); ?></a></span></div>
                    <?php endif; ?>
                    <div><label>Application Centre</label><span><?php echo htmlspecialchars(visa_field_or_fallback($page['application_centre'])); ?></span></div>
                </div>
            </div>
        </section>

        <!-- Indian applicant information -->
        <?php if ($page['indian_applicant_html']): ?>
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">For Indian Citizens</span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($titleBase); ?> for Indian Citizens</h2>
                </div>
                <div class="svc-lede" style="text-align:left;max-width:900px;">
                    <?php echo $page['indian_applicant_html']; ?>
                </div>
            </div>
        </section>
        <?php endif; ?>

        <!-- FAQs -->
        <?php if ($faqs): ?>
        <section id="visa-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($titleBase); ?>, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <?php foreach ($faqs as $i => $faq): ?>
                            <div class="faq-item<?php echo $i === 0 ? ' active' : ''; ?>">
                                <div class="faq-question"><?php echo htmlspecialchars($faq['question']); ?> <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p><?php echo $faq['answer']; ?></p></div>
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <?php endif; ?>

        <!-- Related destinations -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title mb-3">
                    <h3 class="split-text-right split-text-in-right">Related Destinations &mdash; <?php echo htmlspecialchars($categoryName); ?></h3>
                </div>
                <?php if ($relatedDestinations): ?>
                <div class="country-explorer-grid country-nav-grid mb-4">
                    <?php foreach ($relatedDestinations as $rd): ?>
                    <a href="<?php echo htmlspecialchars(visa_country_page_url($rd['page_slug'])); ?>" class="country-chip">
                        <span class="flag"><?php echo htmlspecialchars($rd['flag'] ?: ''); ?></span>
                        <span><?php echo htmlspecialchars($rd['name']); ?> <?php echo htmlspecialchars($categoryName); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php else: ?>
                <p class="svc-lede">More <?php echo htmlspecialchars($categoryName); ?> destinations are being added. <a href="<?php echo htmlspecialchars(visa_country_url($page['country_slug'])); ?>">View all <?php echo htmlspecialchars($countryName); ?> visa categories &rarr;</a></p>
                <?php endif; ?>

                <div class="compliance-note mt-4">
                    Visa requirements, fees, processing times and immigration policies may change without notice.
                    Information provided by VisaAgency.in is for general guidance and does not constitute legal or
                    immigration advice. Applicants should verify current requirements with the relevant government
                    or immigration authority before submitting an application. Visa approval is solely at the
                    discretion of the concerned authority.
                </div>

                <?php if ($page['last_reviewed_date'] || $sources): ?>
                <p class="visa-info-note mt-3">
                    <?php if ($page['last_reviewed_date']): ?>Last Reviewed: <?php echo htmlspecialchars(date('j F Y', strtotime($page['last_reviewed_date']))); ?><?php endif; ?>
                    <?php foreach ($sources as $src): ?>
                        &middot; Source: <?php if ($src['source_url']): ?><a href="<?php echo htmlspecialchars($src['source_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($src['source_authority']); ?></a><?php else: echo htmlspecialchars($src['source_authority']); endif; ?>
                    <?php endforeach; ?>
                </p>
                <?php endif; ?>

                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry
                       data-country="<?php echo htmlspecialchars($countryName); ?>"
                       data-visa-type="<?php echo htmlspecialchars($categoryName); ?>">Start Your <?php echo htmlspecialchars($titleBase); ?> Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php
$serviceLd = [
    '@context' => 'https://schema.org',
    '@type' => 'Service',
    'name' => $titleBase . ' Consultancy',
    'serviceType' => $categoryName . ' Consultancy',
    'description' => $page_description,
    'url' => $pageUrl,
    'provider' => ['@id' => 'https://visaagency.in/#organization'],
    'areaServed' => ['@type' => 'Country', 'name' => 'India'],
    'audience' => ['@type' => 'Audience', 'audienceType' => 'Indian passport holders travelling to ' . $countryName],
];
echo json_encode($serviceLd, JSON_UNESCAPED_SLASHES);
?>
</script>
<script type="application/ld+json">
<?php
$webPageLd = [
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => $titleBase,
    'url' => $pageUrl,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
    'about' => ['@type' => 'Country', 'name' => $countryName],
];
if ($page['last_reviewed_date']) {
    $webPageLd['dateModified'] = $page['last_reviewed_date'];
}
echo json_encode($webPageLd, JSON_UNESCAPED_SLASHES);
?>
</script>
<script type="application/ld+json">
<?php
$breadcrumbLd = [
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Countries', 'item' => 'https://visaagency.in/country-list'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $countryName, 'item' => 'https://visaagency.in/' . visa_country_url($page['country_slug'])],
        ['@type' => 'ListItem', 'position' => 4, 'name' => $titleBase, 'item' => $pageUrl],
    ],
];
echo json_encode($breadcrumbLd, JSON_UNESCAPED_SLASHES);
?>
</script>
<?php if ($faqs): ?>
<script type="application/ld+json">
<?php
$faqLd = [
    '@context' => 'https://schema.org',
    '@type' => 'FAQPage',
    'mainEntity' => array_map(function ($f) {
        return [
            '@type' => 'Question',
            'name' => $f['question'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => strip_tags($f['answer'])],
        ];
    }, $faqs),
];
echo json_encode($faqLd, JSON_UNESCAPED_SLASHES);
?>
</script>
<?php endif; ?>

<?php include __DIR__ . '/../footer.php'; ?>
