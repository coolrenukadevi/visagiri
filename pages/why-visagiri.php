<?php
declare(strict_types=1);

/**
 * Standalone Why Visagiri page — same treatment as pages/about.php:
 * its own header/nav/footer/CSS (public/assets/css/pages-standalone.css
 * + why-visagiri.css), not the site's shared includes/header.php /
 * includes/footer.php, at the client's explicit request. See
 * pages/about.php's docblock for the tradeoffs this accepts.
 *
 * Canonical/og URLs, company facts and country/visa-type counts are
 * still pulled from real settings/DB (see includes/settings.php,
 * includes/data.php), and the mobile-menu toggle lives in the shared
 * public/assets/js/pages-standalone.js rather than an inline <script>,
 * for the same CSP reason documented in about.php.
 */

$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));
$countryCount = count(countries_all());
$visaTypeCount = count(visa_types_all());
$whatsappHrefStart = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$whatsappHrefEnquiry = whatsapp_enquiry_href('Hello Visagiri, I would like assistance with my travel/visa-related enquiry.');
$whatsappNumber = setting('whatsapp_number', '917844819819');
$contactEmail = setting('contact_email', 'info@visagiri.com');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');

$canonicalUrl = APP_URL . '/why-visagiri/';
$ogImage = APP_URL . '/assets/images/og-image.png';
$orgId = APP_URL . '/#organization';
$websiteId = APP_URL . '/#website';

$jsonLd = [
    '@context' => 'https://schema.org',
    '@graph' => [
        [
            '@type' => 'WebSite',
            '@id' => $websiteId,
            'url' => APP_URL . '/',
            'name' => 'Visagiri',
            'publisher' => ['@id' => $orgId],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'Organization',
            '@id' => $orgId,
            'name' => 'Visagiri',
            'url' => APP_URL . '/',
            'logo' => APP_URL . '/assets/images/logo-horizontal.png',
            'description' => 'Visa consultancy, application-management assistance and document-attestation services for travellers, students, professionals and businesses.',
            'foundingDate' => setting('company_founding_date', '2015-04'),
            'parentOrganization' => ['@type' => 'Organization', 'name' => 'Tripgation Pvt Ltd'],
            'email' => $contactEmail,
            'contactPoint' => [
                '@type' => 'ContactPoint',
                'contactType' => 'customer support',
                'telephone' => '+91-' . $whatsappNumber,
                'url' => 'https://wa.me/' . $whatsappNumber,
            ],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'sameAs' => [
                'https://www.facebook.com/Visagiri',
                'https://www.instagram.com/hi_visagiri/',
                'https://x.com/visagiri',
                'https://www.youtube.com/@visagiri',
            ],
        ],
        [
            '@type' => 'WebPage',
            '@id' => $canonicalUrl . '#webpage',
            'url' => $canonicalUrl,
            'name' => 'Why Visagiri - Technology-Driven Visa Management with Human Support',
            'description' => 'Technology-driven visa solutions backed by experienced professionals: expert guidance, document attestation, a transparent process, quick response and human support.',
            'isPartOf' => ['@id' => $websiteId],
            'about' => ['@id' => $orgId],
            'breadcrumb' => ['@id' => $canonicalUrl . '#breadcrumb'],
            'mainEntity' => ['@id' => $canonicalUrl . '#commitments'],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'BreadcrumbList',
            '@id' => $canonicalUrl . '#breadcrumb',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'About', 'item' => APP_URL . '/about/'],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Why Visagiri', 'item' => $canonicalUrl],
            ],
        ],
        [
            '@type' => 'ItemList',
            '@id' => $canonicalUrl . '#commitments',
            'name' => "Visagiri's five commitments",
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Expert visa guidance', 'url' => $canonicalUrl . '#expert-guidance'],
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'Document attestation', 'url' => $canonicalUrl . '#document-attestation'],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Transparent process', 'url' => $canonicalUrl . '#transparent-process'],
                ['@type' => 'ListItem', 'position' => 4, 'name' => 'Quick response', 'url' => $canonicalUrl . '#quick-response'],
                ['@type' => 'ListItem', 'position' => 5, 'name' => 'Human support', 'url' => $canonicalUrl . '#human-support'],
            ],
        ],
        [
            '@type' => 'FAQPage',
            '@id' => $canonicalUrl . '#faq',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'How does Visagiri work?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "Visagiri pairs online tools with consultant support. You can check country-specific requirements and track your application's status online, and a consultant handles the parts a form cannot. Visa decisions remain with the embassy, consulate or immigration authority concerned."],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Does Visagiri guarantee visa approval?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'No. Every visa decision is made by the relevant embassy, consulate or government authority. Visagiri assists with preparation, documentation and application management, and does not guarantee approval.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'How are my documents handled?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "Documents you share with Visagiri are handled with AES-256 encryption. The privacy policy explains how your information is used."],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'How can I reach the Visagiri team?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'The team is available 24x7 over WhatsApp, by phone or through the enquiry form.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Can I track my application online?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "Yes. Once your application is underway, you can follow its progress on the Track your application page."],
                ],
            ],
        ],
    ],
];
?>
<!DOCTYPE html>
<html lang="en-IN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Why Visagiri - Technology-Driven Visa Management with Human Support</title>
<meta name="description" content="Technology-driven visa solutions backed by experienced professionals: expert guidance, document attestation, a transparent process, quick response and human support.">
<meta name="robots" content="index, follow, max-image-preview:large">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="Why Visagiri - Technology-Driven Visa Management with Human Support">
<meta property="og:description" content="Technology-driven visa solutions backed by experienced professionals: expert guidance, document attestation, a transparent process, quick response and human support.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/why-visagiri.css">

<script type="application/ld+json"><?= json_encode($jsonLd, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT) ?></script>
</head>

<body>
<a class="skip" href="#main">Skip to content</a>

<header class="site-header">
  <div class="wrap bar">
    <a class="brand" href="/"><img src="/assets/images/logo-horizontal.png" alt="Visagiri" height="34"></a>
    <button class="menu-btn" type="button" aria-expanded="false" aria-controls="site-nav">Menu</button>
    <nav class="nav" id="site-nav" aria-label="Main">
      <ul>
        <li><a href="/visa-type/">Visa services</a></li>
        <li><a href="/attestation/">Attestation</a></li>
        <li><a href="/countries/">Countries</a></li>
        <li><a href="/forex/">Forex</a></li>
        <li><a href="/resources/">Resources</a></li>
        <li><a href="/about/" aria-current="page">Company</a></li>
      </ul>
      <a class="btn primary" href="/enquire/">Enquire now</a>
    </nav>
  </div>
</header>

<main id="main">

  <nav class="wrap crumbs" aria-label="Breadcrumb">
    <ol>
      <li><a href="/">Home</a></li>
      <li><a href="/about/">About</a></li>
      <li aria-current="page">Why Visagiri</li>
    </ol>
  </nav>

  <!-- HERO -->
  <section class="hero" aria-labelledby="h1">
    <div class="wrap hero-grid">
      <div>
        <h1 id="h1">Why Visagiri: technology-driven visa management with human support.</h1>
        <p class="lede">Visa management, reimagined. Technology-driven visa solutions backed by experienced professionals, built to give travellers, students, professionals and businesses a clearer way through the visa process.</p>
        <div class="actions">
          <a class="btn go" href="<?= e($whatsappHrefStart) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
          <a class="btn ghost" href="#commitments">See our five commitments</a>
        </div>
      </div>

      <figure class="split-card" aria-label="What happens online and what a consultant handles">
        <div>
          <h2>Online</h2>
          <ul>
            <li>Check country-specific requirements</li>
            <li>Track your application's status</li>
            <li>Share documents with AES-256 encrypted handling</li>
          </ul>
        </div>
        <div>
          <h2>With a consultant</h2>
          <ul>
            <li>Choose the right visa category for your trip</li>
            <li>Handle the parts of a case a form cannot</li>
            <li>Get answers on your specific visa or attestation needs</li>
          </ul>
        </div>
        <figcaption>Digital tools for the routine steps, a person for the rest.</figcaption>
      </figure>
    </div>
  </section>

  <!-- AT A GLANCE -->
  <section class="wrap" aria-label="Visagiri at a glance">
    <dl class="ledger">
      <div><dt>Serving visa and travel requirements since April</dt><dd><?= e($foundingYear) ?></dd></div>
      <div><dt>Countries covered in our visa directory</dt><dd><?= e((string) $countryCount) ?>+</dd></div>
      <div><dt>Visa categories, from tourist to work and dependent</dt><dd><?= e((string) $visaTypeCount) ?></dd></div>
      <div><dt>Support over WhatsApp, call or enquiry form</dt><dd>24&times;7</dd></div>
    </dl>
  </section>

  <!-- FIVE COMMITMENTS -->
  <section class="section" id="commitments" aria-labelledby="commit-h">
    <div class="wrap">
      <h2 id="commit-h">Five commitments behind every application</h2>
      <p class="lede" style="margin-bottom:36px">They apply from a first-time tourist visa to a multi-document attestation case.</p>
      <div class="reasons">
      <div class="reason" id="expert-guidance">
        <h3>Expert visa guidance</h3>
        <div>
          <p>Guidance from a team familiar with country-specific visa requirements, across tourist, business, student, work, dependent, family visit, transit, medical, conference and sports visas, for <?= e((string) $countryCount) ?>+ countries.</p>
          <ul class="linklist">
            <li><a href="/visa-type/">Visa services</a></li>
            <li><a href="/countries/">Country directory</a></li>
            <li><a href="/embassy-directory/">Embassy directory</a></li>
          </ul>
        </div>
      </div>
      <div class="reason" id="document-attestation">
        <h3>Document attestation</h3>
        <div>
          <p>Apostille, MEA and embassy attestation for documents used abroad. We handle educational, commercial and personal documents, plus birth and marriage certificates, including e-apostille and consulate attestation where required.</p>
          <ul class="linklist">
            <li><a href="/attestation/mea-apostille/">MEA apostille</a></li>
            <li><a href="/attestation/e-apostille/">E-apostille</a></li>
            <li><a href="/attestation/embassy-attestation/">Embassy attestation</a></li>
            <li><a href="/attestation/consulate-attestation/">Consulate attestation</a></li>
            <li><a href="/attestation/document-legalization/">Document legalization</a></li>
          </ul>
        </div>
      </div>
      <div class="reason" id="transparent-process">
        <h3>Transparent process</h3>
        <div>
          <p>You get clear guidance on eligibility, documents and fees before you commit. Visa and immigration decisions are always made by the relevant embassy, consulate or government authority, so we say plainly that we assist with preparation and do not guarantee approval.</p>
          <ul class="linklist">
            <li><a href="/payment-policy/">Payment policy</a></li>
            <li><a href="/refund-policy/">Refund policy</a></li>
            <li><a href="/faq/">Visa FAQs</a></li>
          </ul>
        </div>
      </div>
      <div class="reason" id="quick-response">
        <h3>Quick response</h3>
        <div>
          <p>Reach the team directly by WhatsApp, call or enquiry form, 24&times;7. Documents you share with us are handled with AES-256 encryption.</p>
          <ul class="linklist">
            <li><a href="<?= e($whatsappHrefEnquiry) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a></li>
            <li><a href="/enquire/">Send an enquiry</a></li>
            <li><a href="/privacy/">Privacy policy</a></li>
          </ul>
        </div>
      </div>
      <div class="reason" id="human-support">
        <h3>Human support</h3>
        <div>
          <p>Speak with a consultant about your specific visa or attestation needs. Once your application is underway, track its progress online instead of waiting for a callback.</p>
          <ul class="linklist">
            <li><a href="/track-visa/">Track your application</a></li>
            <li><a href="/our-team/">Meet the team</a></li>
            <li><a href="/contact/">Contact us</a></li>
          </ul>
        </div>
      </div>
      </div>
    </div>
  </section>

  <!-- WHAT WE DO / DO NOT -->
  <section class="section tint" aria-labelledby="scope-h">
    <div class="wrap">
      <h2 id="scope-h">What Visagiri does, and what it does not</h2>
      <div class="dodont" style="margin-top:24px">
        <div>
          <h3>Visagiri assists with</h3>
          <ul>
            <li>Preparation and documentation for your application</li>
            <li>Application management, from the first question onward</li>
            <li>Clear guidance on eligibility, documents and fees before you commit</li>
            <li>Document attestation, apostille and legalization</li>
          </ul>
        </div>
        <div>
          <h3>Visagiri does not</h3>
          <ul>
            <li>Make visa or immigration decisions. The relevant embassy, consulate or government authority does.</li>
            <li>Guarantee visa approval.</li>
          </ul>
        </div>
      </div>
    </div>
  </section>

  <!-- OFFICES -->
  <section class="section" aria-labelledby="near-h">
    <div class="wrap">
      <h2 id="near-h">Speak to someone near you</h2>
      <!-- Links go to the dedicated office pages proposed in the About redesign; those routes don't exist yet — see pages/about.php's docblock. -->
      <ul class="linklist">
        <li><a href="/offices/patna/">Patna, Bihar</a></li>
        <li><a href="/offices/ranchi/">Ranchi, Jharkhand</a></li>
        <li><a href="/offices/raipur/">Raipur, Chhattisgarh</a></li>
        <li><a href="/offices/bhopal/">Bhopal, Madhya Pradesh</a></li>
      </ul>
      <p>Read more <a href="/about/">about Visagiri</a> and <a href="/our-story/">how it started</a>.</p>
    </div>
  </section>

  <!-- FAQ (text mirrors the FAQPage JSON-LD) -->
  <section class="section tint" id="faq" aria-labelledby="faq-h">
    <div class="wrap">
      <h2 id="faq-h">Common questions</h2>
      <div class="faq">
        <details>
          <summary>How does Visagiri work?</summary>
          <div><p>Visagiri pairs online tools with consultant support. You can check country-specific requirements and track your application's status online, and a consultant handles the parts a form cannot. Visa decisions remain with the embassy, consulate or immigration authority concerned.</p></div>
        </details>
        <details>
          <summary>Does Visagiri guarantee visa approval?</summary>
          <div><p>No. Every visa decision is made by the relevant embassy, consulate or government authority. Visagiri assists with preparation, documentation and application management, and does not guarantee approval.</p></div>
        </details>
        <details>
          <summary>How are my documents handled?</summary>
          <div><p>Documents you share with Visagiri are handled with AES-256 encryption. The <a href="/privacy/">privacy policy</a> explains how your information is used.</p></div>
        </details>
        <details>
          <summary>How can I reach the Visagiri team?</summary>
          <div><p>The team is available 24&times;7 over <a href="<?= e($whatsappHrefEnquiry) ?>" target="_blank" rel="noopener noreferrer">WhatsApp</a>, by phone or through the <a href="/enquire/">enquiry form</a>.</p></div>
        </details>
        <details>
          <summary>Can I track my application online?</summary>
          <div><p>Yes. Once your application is underway, you can follow its progress on the <a href="/track-visa/">Track your application</a> page.</p></div>
        </details>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section class="cta" aria-labelledby="cta-h">
    <div class="wrap">
      <div>
        <h2 id="cta-h">Ready to start your visa journey?</h2>
        <p>Tell us where you are travelling and why. A consultant will take it from there.</p>
      </div>
      <div class="actions">
        <a class="btn go" href="<?= e($whatsappHrefStart) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
        <a class="btn ghost" style="color:#fff;border-color:#fff" href="/enquire/">Send an enquiry</a>
      </div>
    </div>
  </section>
</main>

<footer class="site-footer">
  <div class="wrap">
    <div class="fgrid">
      <div class="fbrand">
        <img src="/assets/images/logo-horizontal-white.png" alt="Visagiri" height="32" loading="lazy">
        <p>Visa consultancy, application management and document attestation for travellers, professionals, families and businesses from India.</p>
        <div class="social">
          <a href="https://www.facebook.com/Visagiri" rel="noopener">Facebook</a>
          <a href="https://www.instagram.com/hi_visagiri/" rel="noopener">Instagram</a>
          <a href="https://x.com/visagiri" rel="noopener">X</a>
          <a href="https://www.youtube.com/@visagiri" rel="noopener">YouTube</a>
        </div>
      </div>
      <div>
        <h2>Visa services</h2>
        <ul>
          <li><a href="/visa-type/tourist/">Tourist visa</a></li>
          <li><a href="/visa-type/business/">Business visa</a></li>
          <li><a href="/visa-type/student/">Student visa</a></li>
          <li><a href="/visa-type/work/">Work visa</a></li>
          <li><a href="/visa-type/dependent/">Dependent visa</a></li>
          <li><a href="/visa-type/family/">Family visit visa</a></li>
          <li><a href="/visa-type/transit/">Transit visa</a></li>
          <li><a href="/visa-type/medical/">Medical visa</a></li>
          <li><a href="/visa-type/conference/">Conference visa</a></li>
          <li><a href="/visa-type/sports/">Sports visa</a></li>
        </ul>
      </div>
      <div>
        <h2>Attestation</h2>
        <ul>
          <li><a href="/attestation/mea-apostille/">MEA apostille</a></li>
          <li><a href="/attestation/mea-attestation/">MEA attestation</a></li>
          <li><a href="/attestation/embassy-attestation/">Embassy attestation</a></li>
          <li><a href="/attestation/educational-document-attestation/">Educational</a></li>
          <li><a href="/attestation/commercial-document-attestation/">Commercial</a></li>
          <li><a href="/attestation/document-legalization/">Document legalization</a></li>
          <li><a href="/attestation/">All attestation services</a></li>
        </ul>
      </div>
      <div>
        <h2>Offices</h2>
        <ul>
          <li><a href="/offices/patna/">Patna</a></li>
          <li><a href="/offices/ranchi/">Ranchi</a></li>
          <li><a href="/offices/raipur/">Raipur</a></li>
          <li><a href="/offices/bhopal/">Bhopal</a></li>
          <li><a href="/contact/">Contact us</a></li>
        </ul>
      </div>
      <div>
        <h2>Company</h2>
        <ul>
          <li><a href="/about/">About us</a></li>
          <li><a href="/why-visagiri/">Why Visagiri</a></li>
          <li><a href="/our-story/">Our story</a></li>
          <li><a href="/leadership/">Leadership</a></li>
          <li><a href="/our-team/">Our team</a></li>
          <li><a href="/careers/">Careers</a></li>
          <li><a href="/partners/">Become a partner</a></li>
          <li><a href="/affiliations/">Affiliations</a></li>
        </ul>
      </div>
    </div>

    <div class="legal">
      <ul>
        <li><a href="/countries/">Countries</a></li>
        <li><a href="/resources/">Resources</a></li>
        <li><a href="/faq/">Visa FAQs</a></li>
        <li><a href="/track-visa/">Track application</a></li>
        <li><a href="/blog/">Visa updates</a></li>
        <li><a href="/login/">Customer login</a></li>
        <li><a href="/partner/login/">Partner login</a></li>
        <li><a href="/admin/login/">Employee login</a></li>
      </ul>
      <ul>
        <li><a href="/privacy/">Privacy policy</a></li>
        <li><a href="/terms/">Terms and conditions</a></li>
        <li><a href="/travel-terms/">Travel terms</a></li>
        <li><a href="/payment-policy/">Payment policy</a></li>
        <li><a href="/refund-policy/">Refund policy</a></li>
        <li><a href="/cookie-policy/">Cookie policy</a></li>
        <li><a href="/grievance/">Grievance redressal</a></li>
        <li><a href="/sitemap/">Sitemap</a></li>
      </ul>
      <p>Disclaimer: Visa decisions are made solely by the relevant embassy, consulate or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
      <p>&copy; <?= e(date('Y')) ?> Visagiri. Serving visa and travel-related requirements since April <?= e($foundingYear) ?>. CIN: <?= e($companyCin) ?>. All rights reserved.</p>
    </div>
  </div>
</footer>

<script src="/assets/js/pages-standalone.js"></script>
</body>
</html>
