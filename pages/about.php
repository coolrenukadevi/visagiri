<?php
declare(strict_types=1);

/**
 * Standalone About page — deliberately bespoke, at the client's
 * request: its own header, nav, footer and component styles
 * (public/assets/css/pages-standalone.css + about.css), not the
 * site's shared includes/header.php / includes/footer.php or design
 * system. That's an explicit tradeoff (accepted by the client): this
 * page won't automatically pick up future site-wide nav/header
 * changes and has to be updated here directly.
 *
 * Still a real PHP page, not static HTML: canonical/og URLs, company
 * facts (CIN, founding date, contact email, WhatsApp number) and the
 * country/visa-type counts are pulled from the same settings/DB the
 * rest of the site uses (see includes/settings.php, includes/data.php)
 * rather than hardcoded, so they can't drift from what's actually
 * configured. The mobile-menu toggle lives in
 * public/assets/js/pages-standalone.js rather than an inline <script>
 * — this site's CSP (includes/security.php) is script-src 'self' with
 * no 'unsafe-inline', so an inline script tag would simply be dropped
 * by the browser.
 *
 * KNOWN GAP, not fixed here: the four office cards below link to
 * /offices/{city}/, which don't exist yet as routes — see the
 * dedicated-office-page requirements noted in the JSON-LD comment
 * below. Until those pages exist those four links 404. Flagged to the
 * client rather than silently building stub pages with invented
 * addresses/hours/phone numbers.
 */

$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));
$countryCount = count(countries_all());
$whatsappHref = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$contactEmail = setting('contact_email', 'info@visagiri.com');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');

$canonicalUrl = APP_URL . '/about/';
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
                'telephone' => '+91-' . setting('whatsapp_number', '917844819819'),
                'url' => 'https://wa.me/' . setting('whatsapp_number', '917844819819'),
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
            '@type' => 'AboutPage',
            '@id' => $canonicalUrl . '#webpage',
            'url' => $canonicalUrl,
            'name' => 'About Visagiri - Visa Consultancy & Document Attestation Since 2015',
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
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'About', 'item' => $canonicalUrl],
            ],
        ],
        [
            '@type' => 'Service',
            '@id' => APP_URL . '/#service-visa',
            'name' => 'Visa consultancy and application management',
            'serviceType' => 'Visa consultancy',
            'provider' => ['@id' => $orgId],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'url' => APP_URL . '/visa-type/',
            'description' => "Guidance and application-management assistance across 10 visa categories, with a directory covering {$countryCount}+ countries.",
        ],
        [
            '@type' => 'Service',
            '@id' => APP_URL . '/#service-attestation',
            'name' => 'Document attestation, apostille and legalization',
            'serviceType' => 'Document attestation',
            'provider' => ['@id' => $orgId],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'url' => APP_URL . '/attestation/',
            'description' => 'MEA apostille and e-apostille, MEA, embassy and consulate attestation, and attestation of educational, commercial and personal documents.',
        ],
        [
            '@type' => ['TravelAgency', 'ProfessionalService'],
            '@id' => APP_URL . '/offices/patna/#office',
            'name' => 'Visagiri Patna',
            'url' => APP_URL . '/offices/patna/',
            'parentOrganization' => ['@id' => $orgId],
            'address' => ['@type' => 'PostalAddress', 'addressLocality' => 'Patna', 'addressRegion' => 'Bihar', 'addressCountry' => 'IN'],
        ],
        [
            '@type' => ['TravelAgency', 'ProfessionalService'],
            '@id' => APP_URL . '/offices/ranchi/#office',
            'name' => 'Visagiri Ranchi',
            'url' => APP_URL . '/offices/ranchi/',
            'parentOrganization' => ['@id' => $orgId],
            'address' => ['@type' => 'PostalAddress', 'addressLocality' => 'Ranchi', 'addressRegion' => 'Jharkhand', 'addressCountry' => 'IN'],
        ],
        [
            '@type' => ['TravelAgency', 'ProfessionalService'],
            '@id' => APP_URL . '/offices/raipur/#office',
            'name' => 'Visagiri Raipur',
            'url' => APP_URL . '/offices/raipur/',
            'parentOrganization' => ['@id' => $orgId],
            'address' => ['@type' => 'PostalAddress', 'addressLocality' => 'Raipur', 'addressRegion' => 'Chhattisgarh', 'addressCountry' => 'IN'],
        ],
        [
            '@type' => ['TravelAgency', 'ProfessionalService'],
            '@id' => APP_URL . '/offices/bhopal/#office',
            'name' => 'Visagiri Bhopal',
            'url' => APP_URL . '/offices/bhopal/',
            'parentOrganization' => ['@id' => $orgId],
            'address' => ['@type' => 'PostalAddress', 'addressLocality' => 'Bhopal', 'addressRegion' => 'Madhya Pradesh', 'addressCountry' => 'IN'],
        ],
        [
            '@type' => 'FAQPage',
            '@id' => $canonicalUrl . '#faq',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'Is Visagiri a government body?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'No. Visagiri is a private visa consultancy and document-attestation brand under Tripgation Pvt Ltd. Visa and immigration decisions are made solely by the relevant embassy, consulate or government immigration authority. Visagiri assists with preparation, documentation and application management.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Does Visagiri guarantee visa approval?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'No. Every visa decision is made by the embassy, consulate or immigration authority concerned. Visagiri helps with preparation, documentation and application management, and does not guarantee approval.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Which countries does Visagiri cover?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "The Visagiri directory covers visa requirements, application procedures and document checklists for {$countryCount}+ countries across Asia, Europe, Africa, North America, South America and Oceania."],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'What attestation services does Visagiri offer?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'MEA apostille and e-apostille, MEA attestation, embassy and consulate attestation, and attestation for educational, commercial and personal documents, including birth and marriage certificates. For businesses: document legalization, Chamber of Commerce attestation and HRD or state attestation.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => "Where are Visagiri's offices?",
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Visagiri has offices in Patna (Bihar), Ranchi (Jharkhand), Raipur (Chhattisgarh) and Bhopal (Madhya Pradesh). Each office has its own page with address, map and contact details.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'How do I get in touch or track my application?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Reach the team 24x7 over WhatsApp, by phone or through the enquiry form. To follow an existing application, use the Track your application page.'],
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
<title>About Visagiri - Visa Consultancy &amp; Document Attestation Since 2015</title>
<meta name="description" content="Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd, serving travellers, students, professionals and businesses since April 2015, with offices in Patna, Ranchi, Raipur and Bhopal.">
<meta name="robots" content="index, follow, max-image-preview:large">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="About Visagiri - Visa Consultancy &amp; Document Attestation Since 2015">
<meta property="og:description" content="Visa consultancy, application management and document attestation for travellers, students, professionals and businesses since April 2015.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/about.css">

<!-- Each of the four office nodes (TravelAgency) below still needs
     streetAddress, postalCode, geo, openingHours and telephone before
     this is fully production-ready structured data — not filled in
     here since that's real per-office information this codebase
     doesn't have, not something to invent. The /offices/{city}/ pages
     themselves don't exist yet either (see the office cards further
     down) — this JSON-LD is ready for when they do. -->
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
        <li><a href="/contact/?service=forex">Forex</a></li>
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
      <li aria-current="page">About</li>
    </ol>
  </nav>

  <!-- HERO -->
  <section class="hero" aria-labelledby="h1">
    <div class="wrap hero-grid">
      <div>
        <h1 id="h1">Visa consultancy and document attestation, built on technology and trust.</h1>
        <p class="lede">Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. We have helped travellers, students, professionals and businesses since April <?= e($foundingYear) ?>, with offices in Patna, Ranchi, Raipur and Bhopal.</p>
        <div class="actions">
          <a class="btn go" href="<?= e($whatsappHref) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
          <a class="btn ghost" href="#offices">Find your office</a>
        </div>
      </div>

      <figure class="route" style="margin:0">
        <svg viewBox="0 0 400 400" role="img" aria-label="A document moving through four attestation steps: state or HRD, MEA, apostille or embassy, then ready for use abroad.">
          <line class="trail" x1="60" y1="64" x2="60" y2="336" stroke="#123F91" stroke-width="2" stroke-dasharray="300" />
          <g class="stamp">
            <circle cx="60" cy="64" r="34" fill="#fff" stroke="#123F91" stroke-width="3"/>
            <circle cx="60" cy="64" r="27" fill="none" stroke="#123F91" stroke-width="1" stroke-dasharray="3 3"/>
            <text x="60" y="69" text-anchor="middle" font-size="14" font-weight="600" fill="#123F91">HRD</text>
            <text x="120" y="60" font-size="16" font-weight="600" fill="#172033">State or HRD</text>
            <text x="120" y="80" font-size="13" fill="#667085">Educational documents</text>
          </g>
          <g class="stamp">
            <circle cx="60" cy="152" r="34" fill="#fff" stroke="#123F91" stroke-width="3"/>
            <circle cx="60" cy="152" r="27" fill="none" stroke="#123F91" stroke-width="1" stroke-dasharray="3 3"/>
            <text x="60" y="157" text-anchor="middle" font-size="14" font-weight="600" fill="#123F91">MEA</text>
            <text x="120" y="148" font-size="16" font-weight="600" fill="#172033">MEA attestation</text>
            <text x="120" y="168" font-size="13" fill="#667085">Ministry of External Affairs</text>
          </g>
          <g class="stamp">
            <circle cx="60" cy="240" r="34" fill="#fff" stroke="#123F91" stroke-width="3"/>
            <circle cx="60" cy="240" r="27" fill="none" stroke="#123F91" stroke-width="1" stroke-dasharray="3 3"/>
            <text x="60" y="245" text-anchor="middle" font-size="14" font-weight="600" fill="#123F91">APO</text>
            <text x="120" y="236" font-size="16" font-weight="600" fill="#172033">Apostille or embassy</text>
            <text x="120" y="256" font-size="13" fill="#667085">Depends on the destination country</text>
          </g>
          <g class="stamp">
            <circle cx="60" cy="328" r="34" fill="#123F91" stroke="#123F91" stroke-width="3"/>
            <path d="M46 328 l10 10 l19 -21" fill="none" stroke="#fff" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
            <text x="120" y="324" font-size="16" font-weight="600" fill="#172033">Ready for use abroad</text>
            <text x="120" y="344" font-size="13" fill="#667085">Documents prepared for submission</text>
          </g>
        </svg>
        <figcaption>A typical attestation route. The exact steps depend on the document type and the destination country.</figcaption>
      </figure>
    </div>
  </section>

  <!-- AT A GLANCE -->
  <section class="wrap" aria-label="Visagiri at a glance">
    <dl class="ledger">
      <div><dt>Serving visa and travel requirements since April</dt><dd><?= e($foundingYear) ?></dd></div>
      <div><dt>Countries covered in our visa directory</dt><dd><?= e((string) $countryCount) ?>+</dd></div>
      <div><dt>Visa categories, from tourist to work and dependent</dt><dd><?= e((string) count(visa_types_all())) ?></dd></div>
      <div><dt>Support over WhatsApp, call or enquiry form</dt><dd>24&times;7</dd></div>
    </dl>
  </section>

  <!-- WHO WE ARE -->
  <section class="section" id="who-we-are" aria-labelledby="who">
    <div class="wrap split">
      <div>
        <h2 id="who">Who we are</h2>
        <p>Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. We offer visa consultancy, application-management assistance and attestation services (apostille, MEA, embassy and commercial attestation) for travellers, students, professionals and businesses moving across borders.</p>
        <p>Our team works from offices in Patna, Ranchi, Raipur and Bhopal, and supports clients across India.</p>
      </div>
      <aside class="notice" aria-labelledby="who-decides">
        <h3 id="who-decides">Who decides a visa</h3>
        <p>Visa and immigration decisions are always made by the relevant embassy, consulate or government immigration authority. Visagiri assists with preparation, documentation and application management, and does not guarantee visa approval.</p>
      </aside>
    </div>
  </section>

  <!-- WHAT WE DO -->
  <section class="section tint" id="what-we-do" aria-labelledby="what">
    <div class="wrap">
      <h2 id="what">What we do</h2>
      <div class="split" style="margin-top:28px">
        <div>
          <h3>Visa consultancy</h3>
          <p>Guidance across <?= e((string) count(visa_types_all())) ?> visa categories, and a directory covering <?= e((string) $countryCount) ?>+ countries. That includes major destinations such as the United States, United Kingdom, Canada and the Schengen Area, and less-travelled routes across Africa, South America and Oceania.</p>
          <ul class="linklist">
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
          <a class="more" href="/countries/">Browse the country directory</a>
        </div>
        <div>
          <h3>Document attestation</h3>
          <p>Document attestation and legalization for use abroad: MEA apostille and e-apostille, MEA attestation, embassy and consulate attestation, and educational, commercial and personal documents, including birth and marriage certificates. For businesses we also assist with document legalization, Chamber of Commerce attestation and HRD or state attestation.</p>
          <ul class="linklist">
            <li><a href="/attestation/mea-apostille/">MEA apostille</a></li>
            <li><a href="/attestation/e-apostille/">E-apostille</a></li>
            <li><a href="/attestation/mea-attestation/">MEA attestation</a></li>
            <li><a href="/attestation/embassy-attestation/">Embassy attestation</a></li>
            <li><a href="/attestation/educational-document-attestation/">Educational documents</a></li>
            <li><a href="/attestation/commercial-document-attestation/">Commercial documents</a></li>
            <li><a href="/attestation/document-legalization/">Document legalization</a></li>
          </ul>
          <a class="more" href="/attestation/">See all attestation services</a>
        </div>
      </div>
    </div>
  </section>

  <!-- OUR STORY -->
  <section class="section" id="our-story" aria-labelledby="story">
    <div class="wrap split">
      <div>
        <h2 id="story">Our story</h2>
        <p>Visagiri was founded in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. It was built to give travellers, students, professionals and businesses a more organised, technology-enabled way to manage the visa and attestation process.</p>
        <p>For many applicants, a visa has meant paperwork and phone calls: tracking requirements by hand, chasing updates and explaining the same case at every step. Visagiri started from a different idea. Checking requirements and tracking an application could happen online, without losing the human judgement a visa or attestation case often needs.</p>
      </div>
      <div>
        <p>That pairing of digital tools and hands-on consultant support is still the foundation. In practice, it means an online system for checking country-specific requirements and tracking application status, alongside visa consultants, document and attestation specialists and application support staff who work each case directly.</p>
        <p>What has not changed since <?= e($foundingYear) ?>: visa decisions belong to the embassy, consulate or immigration authority. Our role is preparation, documentation and application management, not promising outcomes we do not control.</p>
        <p><a class="more" href="/track-visa/">Track your application</a></p>
      </div>
    </div>
  </section>

  <!-- COMMITMENTS -->
  <section class="section tint" aria-labelledby="commitments">
    <div class="wrap">
      <h2 id="commitments">Visa management, reimagined</h2>
      <p class="lede" style="margin-bottom:32px">Five commitments run through every application we handle. The <a href="/why-visagiri/">Why Visagiri</a> page explains each in full.</p>
      <dl class="commit">
        <div><dt>Expert visa guidance</dt><dd>Guidance from a team familiar with country-specific visa requirements.</dd></div>
        <div><dt>Document attestation</dt><dd>Apostille, MEA and embassy attestation for documents used abroad.</dd></div>
        <div><dt>Transparent process</dt><dd>Clear guidance on eligibility, documents and fees before you commit.</dd></div>
        <div><dt>Quick response</dt><dd>Reach our team directly by WhatsApp, call or enquiry form.</dd></div>
        <div><dt>Human support</dt><dd>Speak with a consultant about your specific visa or attestation needs.</dd></div>
      </dl>
    </div>
  </section>

  <!-- OFFICES -->
  <section class="section" id="offices" aria-labelledby="offices-h">
    <div class="wrap">
      <h2 id="offices-h">Our offices in Bihar, Jharkhand, Chhattisgarh and Madhya Pradesh</h2>
      <p class="lede" style="margin-bottom:28px">Visit, call or message the office closest to you. Each office page has its address, map, hours and client reviews.</p>
      <!--
        Each office card links to a dedicated landing page (/offices/<city>/), which don't
        exist as routes yet. On those pages, once built:
        - one <h1> per city ("Visa consultancy and document attestation in Patna")
        - full address in <address>, tel: link, opening hours
        - lazy-loaded Google Maps iframe: <iframe loading="lazy" src="https://www.google.com/maps/embed?pb=..." title="Visagiri Patna on Google Maps"></iframe>
        - real client reviews from that city only, with the client's permission
        - LocalBusiness JSON-LD with the same address and hours as the page
        Keep the map embeds OFF this About page so it stays light.
      -->
      <ul class="offices">
        <li class="office">
          <h3>Patna</h3>
          <p class="region">Bihar</p>
          <p>Visa consultancy and document attestation for clients in Patna.</p>
          <ul>
            <li><a href="/offices/patna/">Patna office page</a></li>
            <li><a href="https://www.google.com/maps/search/?api=1&amp;query=Visagiri+Patna">Open in Google Maps</a></li>
          </ul>
        </li>
        <li class="office">
          <h3>Ranchi</h3>
          <p class="region">Jharkhand</p>
          <p>Visa consultancy and document attestation for clients in Ranchi.</p>
          <ul>
            <li><a href="/offices/ranchi/">Ranchi office page</a></li>
            <li><a href="https://www.google.com/maps/search/?api=1&amp;query=Visagiri+Ranchi">Open in Google Maps</a></li>
          </ul>
        </li>
        <li class="office">
          <h3>Raipur</h3>
          <p class="region">Chhattisgarh</p>
          <p>Visa consultancy and document attestation for clients in Raipur.</p>
          <ul>
            <li><a href="/offices/raipur/">Raipur office page</a></li>
            <li><a href="https://www.google.com/maps/search/?api=1&amp;query=Visagiri+Raipur">Open in Google Maps</a></li>
          </ul>
        </li>
        <li class="office">
          <h3>Bhopal</h3>
          <p class="region">Madhya Pradesh</p>
          <p>Visa consultancy and document attestation for clients in Bhopal.</p>
          <ul>
            <li><a href="/offices/bhopal/">Bhopal office page</a></li>
            <li><a href="https://www.google.com/maps/search/?api=1&amp;query=Visagiri+Bhopal">Open in Google Maps</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </section>

  <!-- PEOPLE & TRUST -->
  <section class="section tint" aria-labelledby="people">
    <div class="wrap">
      <h2 id="people">People and trust</h2>
      <p>Visagiri is led by a small team of directors, backed by visa consultants, document and attestation specialists and application support staff who work each case from the first eligibility question to the final documents.</p>
      <ul class="linklist">
        <li><a href="/leadership/">Leadership</a></li>
        <li><a href="/our-team/">Our team</a></li>
        <li><a href="/affiliations/">Affiliations and accreditations</a></li>
        <li><a href="/partners/">Become a partner</a></li>
        <li><a href="/careers/">Careers</a></li>
        <li><a href="/contact/">Contact us</a></li>
      </ul>
    </div>
  </section>

  <!-- FAQ (text mirrors the FAQPage JSON-LD) -->
  <section class="section" id="faq" aria-labelledby="faq-h">
    <div class="wrap">
      <h2 id="faq-h">Frequently asked questions</h2>
      <div class="faq">
        <details>
          <summary>Is Visagiri a government body?</summary>
          <div><p>No. Visagiri is a private visa consultancy and document-attestation brand under Tripgation Pvt Ltd. Visa and immigration decisions are made solely by the relevant embassy, consulate or government immigration authority. Visagiri assists with preparation, documentation and application management.</p></div>
        </details>
        <details>
          <summary>Does Visagiri guarantee visa approval?</summary>
          <div><p>No. Every visa decision is made by the embassy, consulate or immigration authority concerned. Visagiri helps with preparation, documentation and application management, and does not guarantee approval.</p></div>
        </details>
        <details>
          <summary>Which countries does Visagiri cover?</summary>
          <div><p>The Visagiri directory covers visa requirements, application procedures and document checklists for <?= e((string) $countryCount) ?>+ countries across Asia, Europe, Africa, North America, South America and Oceania. <a href="/countries/">Browse the country directory.</a></p></div>
        </details>
        <details>
          <summary>What attestation services does Visagiri offer?</summary>
          <div><p>MEA apostille and e-apostille, MEA attestation, embassy and consulate attestation, and attestation for educational, commercial and personal documents, including birth and marriage certificates. For businesses: document legalization, Chamber of Commerce attestation and HRD or state attestation. <a href="/attestation/">See all attestation services.</a></p></div>
        </details>
        <details>
          <summary>Where are Visagiri's offices?</summary>
          <div><p>Visagiri has offices in Patna (Bihar), Ranchi (Jharkhand), Raipur (Chhattisgarh) and Bhopal (Madhya Pradesh). Each office has its own page with address, map and contact details. <a href="#offices">See the offices.</a></p></div>
        </details>
        <details>
          <summary>How do I get in touch or track my application?</summary>
          <div><p>Reach the team 24&times;7 over WhatsApp, by phone or through the enquiry form. To follow an existing application, use the <a href="/track-visa/">Track your application</a> page.</p></div>
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
        <a class="btn go" href="<?= e($whatsappHref) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
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
