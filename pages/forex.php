<?php
declare(strict_types=1);

/**
 * Standalone Forex landing page — same treatment as the other pages
 * in this family (see pages/about.php's docblock). New page: /forex/
 * previously 404'd at the root (only /forex/track/, the real forex
 * status-tracking feature, existed — see public/index.php's 'forex'
 * case). This page doesn't duplicate that tracker; it links to it.
 *
 * No forex-specific facts are stated here beyond what the rest of the
 * site already says (the enquiry form exists, WhatsApp/call/email
 * channels exist) — rates, providers, regulatory status, currencies
 * offered and document requirements are explicitly left as a flagged
 * gap (see the HTML comment below) rather than invented, matching the
 * source draft's own note.
 */

$contactEmail = setting('contact_email', 'info@visagiri.com');
$contactPhoneDisplay = setting('contact_phone_display', '+91 7065 819 819');
$contactPhoneDial = setting('contact_phone_dial', '+917065819819');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));
$whatsappHrefStart = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$whatsappHrefForex = whatsapp_enquiry_href("Hi Visagiri, I'd like help with a forex/currency exchange requirement.");
$countryCount = count(countries_all());

$canonicalUrl = APP_URL . '/forex/';
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
                'telephone' => $contactPhoneDial,
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
            'name' => 'Forex Assistance for Travellers | Visagiri',
            'description' => "Enquire about forex and currency exchange with Visagiri's forex desk. Share your currency requirement and travel plans and the team will get back to you.",
            'isPartOf' => ['@id' => $websiteId],
            'about' => ['@id' => $orgId],
            'breadcrumb' => ['@id' => $canonicalUrl . '#breadcrumb'],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'BreadcrumbList',
            '@id' => $canonicalUrl . '#breadcrumb',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'Forex', 'item' => $canonicalUrl],
            ],
        ],
        [
            '@type' => 'Service',
            '@id' => $canonicalUrl . '#service',
            'name' => 'Forex assistance',
            'serviceType' => 'Foreign currency exchange assistance',
            'provider' => ['@id' => $orgId],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'url' => $canonicalUrl,
            'description' => 'Enquire about forex and currency exchange for travel. Share your currency requirement and travel plans and the forex desk will get back to you.',
        ],
    ],
];
?>
<!DOCTYPE html>
<html lang="en-IN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forex Assistance for Travellers | Visagiri</title>
<meta name="description" content="Enquire about forex and currency exchange with Visagiri's forex desk. Share your currency requirement and travel plans and the team will get back to you.">
<meta name="robots" content="index, follow">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="Forex Assistance for Travellers | Visagiri">
<meta property="og:description" content="Enquire about forex and currency exchange with Visagiri's forex desk. Share your currency requirement and travel plans and the team will get back to you.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/company-page-kit.css">

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
        <li><a href="/forex/" aria-current="page">Forex</a></li>
        <li><a href="/resources/">Resources</a></li>
        <li><a href="/about/">Company</a></li>
      </ul>
      <a class="btn primary" href="/enquire/">Enquire now</a>
    </nav>
  </div>
</header>

<main id="main">

  <nav class="wrap crumbs" aria-label="Breadcrumb">
    <ol>
      <li><a href="/">Home</a></li>
      <li aria-current="page">Forex</li>
    </ol>
  </nav>

  <section class="page-hero" aria-labelledby="h1">
    <div class="wrap">
      <h1 id="h1">Forex assistance for your trip abroad</h1>
      <p class="lede">Tell us your currency requirement and travel plans, and Visagiri's forex desk will get back to you.</p>
      <div class="actions">
        <a class="btn primary" href="/contact/?service=forex">Send a forex enquiry</a>
        <a class="btn go" href="<?= e($whatsappHrefForex) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
      </div>
    </div>
  </section>

  <section class="section tint" aria-labelledby="include-h">
    <div class="wrap split">
      <div>
        <h2 id="include-h">What to include in your enquiry</h2>
        <p>The enquiry form asks for your name, email and an optional phone number and destination country, plus a message. It helps the desk if you mention:</p>
        <ul class="checks">
          <li>the currency you need</li>
          <li>the country you are travelling to</li>
          <li>when you are travelling</li>
        </ul>
      </div>
      <aside class="notice" aria-labelledby="rates-h">
        <h3 id="rates-h">About rates</h3>
        <p>Rates shown on the Visagiri website are indicative and for guidance only.</p>
        <!--
          MUST BE COMPLETED BEFORE PUBLISHING (needs input from the company; nothing is invented here):
          - who provides the forex service and their regulatory status (e.g. the authorised dealer or partner, and licence details)
          - which currencies and products are offered (cash, cards, remittance, etc.)
          - documents required and any limits that apply
          - how quotes are given and how long they are valid
          Add these as plain sentences here, then add matching FAQs and FAQPage schema.
        -->
      </aside>
    </div>
  </section>

  <section class="section" aria-labelledby="reach-h">
    <div class="wrap">
      <h2 id="reach-h">Reach the forex desk</h2>
      <ul class="channels">
        <li class="channel">
          <h3>Enquiry form</h3>
          <p>Choose Forex in the form and send your details.</p>
          <a class="btn primary" href="/contact/?service=forex">Open the form</a>
        </li>
        <li class="channel">
          <h3>WhatsApp</h3>
          <p>Message the team, 24&times;7.</p>
          <a class="btn go" href="<?= e($whatsappHrefForex) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
        </li>
        <li class="channel">
          <h3>Call</h3>
          <p><?= e($contactPhoneDisplay) ?></p>
          <a class="btn ghost" href="tel:<?= e($contactPhoneDial) ?>">Call us</a>
        </li>
        <li class="channel">
          <h3>Email</h3>
          <p><?= e($contactEmail) ?></p>
          <a class="btn ghost" href="mailto:<?= e($contactEmail) ?>">Email us</a>
        </li>
      </ul>
    </div>
  </section>

  <section class="section tint" aria-labelledby="also-h">
    <div class="wrap">
      <h2 id="also-h">Planning the rest of your trip?</h2>
      <p>Visagiri also assists with visas for <?= e((string) $countryCount) ?>+ countries and with document attestation for use abroad.</p>
      <ul class="linklist">
        <li><a href="/visa-type/">Visa services</a></li>
        <li><a href="/countries/">Country directory</a></li>
        <li><a href="/attestation/">Attestation</a></li>
        <li><a href="/forex/track/">Track a forex request</a></li>
      </ul>
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
        <li><a href="/forex/">Forex</a></li>
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
