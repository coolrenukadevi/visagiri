<?php
declare(strict_types=1);

/**
 * About page, using the site's standard design system (.section /
 * .container / .card-grid / .accordion-item, same as
 * pages/leadership.php, pages/our-team.php, pages/partners.php) rather
 * than a bespoke treatment. Facts used here (founding date, parent
 * company, CIN, visa/country counts) are client-confirmed or sourced
 * live from the DB/settings — see AUDIT.md — not invented; the visa
 * category list is built from visa_types_all() rather than hardcoded,
 * so it can't drift from the real catalog. "Why Visagiri" keeps its
 * own separate, deliberately distinct bespoke page at /why-visagiri/
 * (why_visagiri_features()), linked from here rather than duplicated.
 */

$visaTypes = visa_types_all();
$visaTypeCount = count($visaTypes);
$countryCount = count(countries_all());
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));

$visaTypeNames = array_map(static fn(array $t): string => $t['name'], $visaTypes);
$visaTypeList = '';
if (count($visaTypeNames) > 1) {
    $last = array_pop($visaTypeNames);
    $visaTypeList = implode(', ', $visaTypeNames) . ', and ' . $last;
} elseif ($visaTypeNames) {
    $visaTypeList = $visaTypeNames[0];
}

$aboutFaqs = [
    [
        'q' => 'Is Visagiri a government body?',
        'a' => 'No. Visagiri is a private visa consultancy and document-attestation brand under Tripgation Pvt Ltd. Visa and immigration decisions are made solely by the relevant embassy, consulate, or government immigration authority — we assist with preparation, documentation, and application management.',
    ],
    [
        'q' => 'Which countries does Visagiri cover?',
        'a' => "Our directory covers visa requirements, application procedures, and document checklists for {$countryCount}+ countries across Asia, Europe, Africa, North America, South America, and Oceania.",
    ],
    [
        'q' => 'How do I get in touch?',
        'a' => 'You can reach our team 24×7 over WhatsApp, by phone, or through our enquiry form — see our Contact Us page for details.',
    ],
];

$pageTitle = 'About Visagiri - Visa Consultancy & Document Attestation Since 2015';
$pageDescription = 'Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd, serving travellers, students, professionals, and businesses since April 2015 with visa guidance, apostille, MEA and embassy attestation.';
$canonicalUrl = APP_URL . '/about/';
$structuredData = [
    breadcrumb_schema([
        ['name' => 'Home', 'url' => APP_URL . '/'],
        ['name' => 'About Us', 'url' => $canonicalUrl],
    ]),
    [
        '@context' => 'https://schema.org',
        '@type' => 'FAQPage',
        'mainEntity' => array_map(static fn(array $f): array => [
            '@type' => 'Question',
            'name' => $f['q'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => $f['a']],
        ], $aboutFaqs),
    ],
];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8);padding-bottom:var(--space-6)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">About Visagiri</span>
            <h1>Visa consultancy and document attestation, built on technology and trust.</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd, offering visa
            consultancy, application-management assistance, and attestation services for travellers, students,
            professionals, and businesses since April <?= e($foundingYear) ?>.
        </p>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>Who we are</h2>
        </div>
        <p>
            Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. We offer visa
            consultancy, application-management assistance, and attestation services — apostille, MEA, embassy, and
            commercial attestation — for travellers, students, professionals, and businesses moving across borders.
        </p>
        <p>
            Visa and immigration decisions are always made by the relevant embassy, consulate, or government
            immigration authority. Visagiri assists with preparation, documentation, and application management,
            and does not guarantee visa approval.
        </p>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>Visagiri at a glance</h2>
        </div>
        <div class="card-grid" style="grid-template-columns:repeat(4,1fr)">
            <div class="card" style="text-align:center">
                <div class="card-title" style="color:var(--visa-blue)"><?= e($foundingYear) ?></div>
                <p style="font-size:var(--font-size-sm)">Serving visa &amp; travel requirements since April</p>
            </div>
            <div class="card" style="text-align:center">
                <div class="card-title" style="color:var(--visa-blue)"><?= e((string) $countryCount) ?>+</div>
                <p style="font-size:var(--font-size-sm)">Countries covered in our visa directory</p>
            </div>
            <div class="card" style="text-align:center">
                <div class="card-title" style="color:var(--visa-blue)"><?= e((string) $visaTypeCount) ?></div>
                <p style="font-size:var(--font-size-sm)">Visa categories, from tourist to work &amp; dependent</p>
            </div>
            <div class="card" style="text-align:center">
                <div class="card-title" style="color:var(--visa-blue)">24&times;7</div>
                <p style="font-size:var(--font-size-sm)">Support over WhatsApp, call, or enquiry form</p>
            </div>
        </div>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>What we do</h2>
        </div>
        <?php if ($visaTypeList !== ''): ?>
        <p>
            Our visa services span <?= e((string) $visaTypeCount) ?> categories — <?= e($visaTypeList) ?> visas —
            across a directory covering <?= e((string) $countryCount) ?>+ countries, from major destinations like
            the United States, United Kingdom, Canada, and the Schengen Area to less-travelled routes across
            Africa, South America, and Oceania.
        </p>
        <?php endif; ?>
        <p>
            Alongside visa consultancy, we handle document attestation and legalization: MEA apostille and
            e-apostille, MEA and embassy attestation, consulate attestation, and attestation for educational,
            commercial, and personal documents, including birth and marriage certificates. For businesses, we also
            assist with document legalization, Chamber of Commerce attestation, and HRD/state attestation.
        </p>
    </div>
</section>

<section class="section" id="our-story" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Our Story</span>
            <h2>Our Journey</h2>
        </div>
        <p>
            Visagiri was founded in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation
            brand under <strong>Tripgation Pvt Ltd</strong>, built to give travellers, students, professionals, and
            businesses a more organised, technology-enabled way to manage the visa and attestation process.
        </p>
        <p>
            Before that shift, managing a visa application typically meant paperwork and phone calls — tracking
            requirements by hand, chasing updates by phone, and re-explaining your case at every step. Visagiri was
            built around a different premise: that checking requirements and tracking an application's status
            could happen online, without losing the human judgement a visa or attestation case often needs.
        </p>
        <p>
            That combination — real digital tools paired with hands-on consultant support — remains the foundation
            Visagiri continues to build on today. In practice, that means an online system for checking
            country-specific requirements and tracking your application's status, alongside a team of visa
            consultants, document and attestation specialists, and application support staff who work each case
            directly.
        </p>
        <p>
            Visa and immigration decisions are always made by the relevant embassy, consulate, or government
            immigration authority — that was true in <?= e($foundingYear) ?> and remains true today. Visagiri's
            role has consistently been to assist with preparation, documentation, and application management, not
            to promise outcomes we don't control.
        </p>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>Visa management, reimagined</h2>
        </div>
        <p>
            Five commitments run through every application we handle — read the full story behind them on our
            <a href="/why-visagiri/">Why Visagiri</a> page.
        </p>
        <div class="card-grid">
            <?php foreach (why_visagiri_features() as $f): ?>
            <div class="card feature-card">
                <div class="card-title"><?= e($f['title']) ?></div>
                <p><?= e($f['desc']) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>People &amp; trust</h2>
        </div>
        <p>
            Visagiri is led by a small team of directors, backed by visa consultants, document and attestation
            specialists, and application support staff who work each case from eligibility question to approved
            documents.
        </p>
        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;margin-top:var(--space-4)">
            <a href="/leadership/" class="btn btn-outline">Leadership &rarr;</a>
            <a href="/our-team/" class="btn btn-outline">Our Team &rarr;</a>
            <a href="/careers/" class="btn btn-outline">Careers &rarr;</a>
            <a href="/partners/" class="btn btn-outline">Become a Partner &rarr;</a>
            <a href="/affiliations/" class="btn btn-outline">Affiliations &rarr;</a>
            <a href="/contact/" class="btn btn-outline">Contact Us &rarr;</a>
        </div>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:840px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">FAQ</span>
            <h2>Frequently asked questions</h2>
        </div>
        <?php foreach ($aboutFaqs as $faq): ?>
        <div class="accordion-item">
            <details>
                <summary><?= e($faq['q']) ?></summary>
                <div class="accordion-body"><?= e($faq['a']) ?></div>
            </details>
        </div>
        <?php endforeach; ?>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="final-cta">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" class="btn btn-gold btn-lg" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
