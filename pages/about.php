<?php
declare(strict_types=1);

/**
 * About page. Facts used here (founding date, parent company, CIN,
 * visa/country counts) are client-confirmed or sourced live from the
 * DB/settings — see AUDIT.md §1/§7 — not invented. Bespoke "vintage
 * travel document" visual treatment (see public/assets/css/about.css),
 * matching pages/why-visagiri.php, at the client's request. The "why"
 * strip here is the condensed version of why_visagiri_features()
 * (includes/functions.php), used as-is; the full elaborated version
 * lives on its own page at /why-visagiri/.
 */

$visaTypeCount = count(visa_types_all());
$countryCount = count(countries_all());
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));

$pageTitle = 'About Visagiri - Visa Consultancy Since April 2015';
$pageDescription = 'Visagiri is a visa consultancy brand under Tripgation Pvt Ltd, serving visa and travel-related requirements since April 2015.';
$canonicalUrl = APP_URL . '/about/';
$structuredData = [breadcrumb_schema([
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'About Us', 'url' => $canonicalUrl],
])];
require __DIR__ . '/../includes/header.php';
?>
<div class="about-page">

    <div class="ap-hero">
        <div class="ap-hero-seal">
            <div class="ap-hero-seal-inner">SINCE<br>APR <?= e($foundingYear) ?></div>
        </div>
        <div class="ap-page">
            <p class="ap-kicker">ABOUT VISAGIRI</p>
            <h1>Shaping global journeys since <?= e($foundingYear) ?>.</h1>
            <p>Trusted immigration expertise, personalised guidance, and seamless end-to-end support — for travellers, students, professionals, and businesses.</p>
        </div>
    </div>

    <div class="ap-page">

        <div class="ap-statement">
            <p>Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd.</p>
            <p class="ap-fine">We offer visa consultancy, application-management assistance, and attestation services — apostille, MEA, embassy, and commercial attestation — for travellers, students, professionals, and businesses moving across borders. Visa and immigration decisions are always made by the relevant embassy, consulate, or government immigration authority; Visagiri assists with preparation, documentation, and application management, and does not guarantee visa approval.</p>
        </div>

        <div class="ap-stats">
            <div class="ap-stat">
                <p class="ap-stat-num"><?= e($foundingYear) ?></p>
                <p class="ap-stat-label">Serving visa &amp; travel requirements since April</p>
            </div>
            <div class="ap-stat">
                <p class="ap-stat-num"><?= e((string) $countryCount) ?>+</p>
                <p class="ap-stat-label">Countries covered in our visa directory</p>
            </div>
            <div class="ap-stat">
                <p class="ap-stat-num"><?= e((string) $visaTypeCount) ?></p>
                <p class="ap-stat-label">Visa categories, from tourist to work &amp; dependent</p>
            </div>
            <div class="ap-stat">
                <p class="ap-stat-num">24&times;7</p>
                <p class="ap-stat-label">Support over WhatsApp, call, or enquiry form</p>
            </div>
        </div>

        <div class="ap-story" id="our-story">
            <span class="ap-section-label">OUR STORY</span>
            <div>
                <p>Visagiri was founded in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand under <strong>Tripgation Pvt Ltd</strong>, built to give travellers, students, professionals, and businesses a more organised, technology-enabled way to manage the visa and attestation process.</p>
                <p>That meant replacing paperwork and phone calls with real digital tools — checking requirements, tracking an application's status online — while keeping a consultant on the other end for the parts a form can't handle. That combination is still what the brand is built on today.</p>
            </div>
        </div>

        <div class="ap-why">
            <span class="ap-section-label">WHY VISAGIRI</span>
            <div>
                <div class="ap-why-head">
                    <h2>Visa management, reimagined.</h2>
                    <a href="/why-visagiri/">Read the full page &rarr;</a>
                </div>
                <div class="ap-why-strip">
                    <?php foreach (why_visagiri_features() as $f): ?>
                    <div class="ap-why-item">
                        <div class="ap-why-stamp"><?= e(strtoupper(substr($f['title'], 0, 2))) ?></div>
                        <h4><?= e($f['title']) ?></h4>
                        <p><?= e($f['desc']) ?></p>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>

        <div class="ap-directory">
            <span class="ap-section-label">PEOPLE &amp; TRUST</span>
            <div class="ap-dir-list">
                <a class="ap-dir-row" href="/leadership/">
                    <span class="ap-dir-name">Leadership</span>
                    <span class="ap-dir-desc">Leadership and management</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
                <a class="ap-dir-row" href="/our-team/">
                    <span class="ap-dir-name">Our Team</span>
                    <span class="ap-dir-desc">Meet our visa and travel professionals</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
                <a class="ap-dir-row" href="/careers/">
                    <span class="ap-dir-name">Careers</span>
                    <span class="ap-dir-desc">Opportunities to join our team</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
                <a class="ap-dir-row" href="/partners/">
                    <span class="ap-dir-name">Become a Partner</span>
                    <span class="ap-dir-desc">Join our B2B travel &amp; visa referral partner program</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
                <a class="ap-dir-row" href="/affiliations/">
                    <span class="ap-dir-name">Affiliations &amp; Accreditations</span>
                    <span class="ap-dir-desc">Industry relationships and credentials</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
                <a class="ap-dir-row" href="/contact/">
                    <span class="ap-dir-name">Contact Us</span>
                    <span class="ap-dir-desc">Speak with our experts</span>
                    <span class="ap-dir-arrow">&rarr;</span>
                </a>
            </div>
        </div>

        <div class="ap-cta">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>

        <div class="ap-disclaimer">
            <p>Visa and immigration decisions are always made by the relevant embassy, consulate, or government immigration authority. Visagiri assists with preparation, documentation, and application management, and does not guarantee visa approval.</p>
            <p class="ap-cin">CIN: <?= e(setting('company_cin', 'U63030UP2020PTC128661')) ?> &middot; &copy; <?= e(date('Y')) ?> <?= e(setting('company_name', 'Visagiri')) ?></p>
        </div>

    </div>

</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
