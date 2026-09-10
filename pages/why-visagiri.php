<?php
declare(strict_types=1);

/**
 * "Why Visagiri" brand-story page — a deliberately distinct, bespoke
 * visual treatment from the rest of the site (see
 * public/assets/css/why-visagiri.css), replacing the old
 * /about/#why-visagiri anchor section at the client's request. The
 * five "register" entries below are an elaborated version of the exact
 * same five items why_visagiri_features() (includes/functions.php)
 * already returns for the homepage's condensed version — same real
 * claims, just told at more length here, not new facts. Every number
 * on this page is sourced live (visa type count, country count,
 * founding year) rather than hardcoded, so it can't drift stale the
 * way a copy-pasted stat would.
 */

$visaTypeCount = count(visa_types_all());
$countryCount = count(countries_all());
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));

$pageTitle = 'Why Visagiri - Visa Management, Reimagined';
$pageDescription = 'Technology-driven visa solutions backed by experienced professionals — expert visa guidance, document attestation, a transparent process, quick response, and human support.';
$canonicalUrl = APP_URL . '/why-visagiri/';
$structuredData = [breadcrumb_schema([
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'Why Visagiri', 'url' => $canonicalUrl],
])];
require __DIR__ . '/../includes/header.php';
?>
<div class="why-visagiri-page">

    <div class="wv-hero">
        <div class="wv-hero-seal">
            <div class="wv-hero-seal-inner">SINCE<br>APR <?= e($foundingYear) ?></div>
        </div>
        <div class="wv-page">
            <p class="wv-kicker">WHY VISAGIRI</p>
            <h1>Visa management, reimagined.</h1>
            <p>Technology-driven visa solutions backed by experienced professionals — built to give travellers, students, professionals, and businesses a clearer way through the visa process.</p>
        </div>
    </div>

    <div class="wv-page">
        <div class="wv-stats">
            <div class="wv-stat">
                <p class="wv-stat-num"><?= e($foundingYear) ?></p>
                <p class="wv-stat-label">Serving visa &amp; travel requirements since April</p>
            </div>
            <div class="wv-stat">
                <p class="wv-stat-num"><?= e((string) $countryCount) ?>+</p>
                <p class="wv-stat-label">Countries covered in our visa directory</p>
            </div>
            <div class="wv-stat">
                <p class="wv-stat-num"><?= e((string) $visaTypeCount) ?></p>
                <p class="wv-stat-label">Visa categories, from tourist to work &amp; dependent</p>
            </div>
            <div class="wv-stat">
                <p class="wv-stat-num">24&times;7</p>
                <p class="wv-stat-label">Support over WhatsApp, call, or enquiry form</p>
            </div>
        </div>

        <div class="wv-story">
            <span class="wv-story-label">01 / OUR STORY</span>
            <div>
                <p>Visagiri was founded in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand under Tripgation Pvt Ltd, built to give travellers, students, professionals, and businesses a more organised, technology-enabled way to manage the visa and attestation process.</p>
                <p>That meant replacing paperwork and phone calls with real digital tools — checking requirements, tracking an application's status online — while keeping a consultant on the other end for the parts a form can't handle. That combination is still what the brand is built on today.</p>
            </div>
        </div>

        <div class="wv-intro">
            <span class="wv-intro-label">02 / OUR APPROACH</span>
            <p class="wv-intro-text">Five commitments run through every application we handle, from a first-time tourist visa to a multi-document attestation case.</p>
        </div>

        <div class="wv-register">
            <div class="wv-entry">
                <div class="wv-stamp">EX</div>
                <div>
                    <h3>Expert Visa Guidance</h3>
                    <p>Guidance from a team familiar with country-specific visa requirements — across tourist, business, student, work, dependent, family visit, transit, medical, conference, and sports visa categories, for <?= e((string) $countryCount) ?>+ countries.</p>
                </div>
            </div>
            <div class="wv-entry">
                <div class="wv-stamp">DA</div>
                <div>
                    <h3>Document Attestation</h3>
                    <p>Apostille, MEA, and embassy attestation for documents used abroad, covering educational, commercial, and personal documents, plus birth and marriage certificates — including e-apostille and consulate attestation where required.</p>
                </div>
            </div>
            <div class="wv-entry">
                <div class="wv-stamp">TP</div>
                <div>
                    <h3>Transparent Process</h3>
                    <p>Clear guidance on eligibility, documents, and fees before you commit — visa and immigration decisions are always made by the relevant embassy, consulate, or government authority, and we're upfront that we assist with preparation rather than guarantee approval.</p>
                </div>
            </div>
            <div class="wv-entry">
                <div class="wv-stamp">QR</div>
                <div>
                    <h3>Quick Response</h3>
                    <p>Reach our team directly by WhatsApp, call, or enquiry form, with 24&times;7 support and AES-256 encrypted handling of the documents you share with us.</p>
                </div>
            </div>
            <div class="wv-entry">
                <div class="wv-stamp">HS</div>
                <div>
                    <h3>Human Support</h3>
                    <p>Speak with a consultant about your specific visa or attestation needs, and track your application's progress online once it's underway rather than waiting on a callback.</p>
                </div>
            </div>
        </div>

        <div class="wv-cta">
            <h2>Ready to start your visa journey?</h2>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.")) ?>" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>

</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
