<?php
declare(strict_types=1);

/**
 * Standalone Leadership page — same treatment as pages/about.php,
 * pages/why-visagiri.php and pages/our-story.php: its own header/nav/
 * footer/CSS (public/assets/css/pages-standalone.css + leadership.css),
 * not the site's shared includes/header.php / includes/footer.php, at
 * the client's explicit request. See pages/about.php's docblock for
 * the tradeoffs this accepts.
 *
 * Leader data (names, titles, LinkedIn profiles, photos) is the same
 * client-confirmed data the previous includes/header.php-based version
 * of this page used — not re-verified or changed here, just carried
 * over. Photos use asset_url() for real filemtime-based cache-busting
 * rather than a hardcoded ?v= query string.
 */

$leaders = [
    ['name' => 'Anisha Bharti', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolanishabharti', 'photo' => '/assets/images/leadership/anisha-bharti.jpg', 'slug' => 'anisha-bharti'],
    ['name' => 'Renuka Devi', 'title' => 'Director', 'linkedin' => 'https://www.linkedin.com/in/coolrenukadevi/', 'photo' => '/assets/images/leadership/renuka-devi.jpg', 'slug' => 'renuka-devi'],
];

$whatsappHrefStart = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$whatsappNumber = setting('whatsapp_number', '917844819819');
$contactEmail = setting('contact_email', 'info@visagiri.com');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));

$canonicalUrl = APP_URL . '/leadership/';
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
            'name' => 'Leadership - Visagiri Directors',
            'description' => "Meet Visagiri's directors, Anisha Bharti and Renuka Devi, who lead the visa consultancy and document-attestation brand under Tripgation Pvt Ltd.",
            'isPartOf' => ['@id' => $websiteId],
            'about' => ['@id' => $orgId],
            'breadcrumb' => ['@id' => $canonicalUrl . '#breadcrumb'],
            'mainEntity' => [
                '@type' => 'ItemList',
                'itemListElement' => array_map(static fn(array $l, int $i): array => [
                    '@type' => 'ListItem',
                    'position' => $i + 1,
                    'item' => ['@id' => $canonicalUrl . '#' . $l['slug'] . '-person'],
                ], $leaders, array_keys($leaders)),
            ],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'BreadcrumbList',
            '@id' => $canonicalUrl . '#breadcrumb',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'About', 'item' => APP_URL . '/about/'],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Leadership', 'item' => $canonicalUrl],
            ],
        ],
        ...array_map(static fn(array $l): array => [
            '@type' => 'Person',
            '@id' => $canonicalUrl . '#' . $l['slug'] . '-person',
            'name' => $l['name'],
            'jobTitle' => $l['title'],
            'image' => APP_URL . asset_url($l['photo']),
            'sameAs' => [$l['linkedin']],
            'worksFor' => ['@id' => $orgId],
        ], $leaders),
        [
            '@type' => 'FAQPage',
            '@id' => $canonicalUrl . '#faq',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'Who leads Visagiri?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Visagiri is led by its directors, Anisha Bharti and Renuka Devi, under Tripgation Pvt Ltd.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Who handles day-to-day case work?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'A broader team of visa consultants, document and attestation specialists and application support staff works each case day to day. The directors set the direction.'],
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
<title>Leadership - Anisha Bharti and Renuka Devi, Directors | Visagiri</title>
<meta name="description" content="Meet Visagiri's directors, Anisha Bharti and Renuka Devi, who lead the visa consultancy and document-attestation brand under Tripgation Pvt Ltd.">
<meta name="robots" content="index, follow, max-image-preview:large">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="Leadership - Anisha Bharti and Renuka Devi, Directors | Visagiri">
<meta property="og:description" content="Meet Visagiri's directors, Anisha Bharti and Renuka Devi, who lead the visa consultancy and document-attestation brand under Tripgation Pvt Ltd.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/leadership.css">

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
      <li aria-current="page">Leadership</li>
    </ol>
  </nav>

  <section class="lead-hero" aria-labelledby="h1">
    <div class="wrap">
      <h1 id="h1">Our leadership: the directors behind Visagiri.</h1>
      <p class="lede">Visagiri is led by directors committed to technology-driven visa consultancy and transparent, dependable service for travellers, students, professionals and businesses.</p>
    </div>
  </section>

  <section class="wrap" style="padding-bottom:clamp(44px,7vw,84px)" aria-labelledby="directors-h">
    <h2 id="directors-h" style="position:absolute;left:-9999px">Directors</h2>
    <!--
      ADD when the directors are happy to publish them: a short bio (2-3 sentences), relevant experience or qualifications,
      and, if wanted, a short first-person note. Do not add claims that cannot be backed up.
    -->
    <ul class="people">
      <?php foreach ($leaders as $leader): ?>
      <li class="person" id="<?= e($leader['slug']) ?>">
        <img src="<?= e(asset_url($leader['photo'])) ?>" alt="<?= e($leader['name']) ?>, Director at Visagiri" width="480" height="600" loading="lazy">
        <h3><?= e($leader['name']) ?></h3>
        <p class="role">Director, Visagiri</p>
        <a class="in" href="<?= e($leader['linkedin']) ?>" rel="noopener" target="_blank" aria-label="<?= e($leader['name']) ?> on LinkedIn">LinkedIn profile</a>
      </li>
      <?php endforeach; ?>
    </ul>
  </section>

  <section class="section tint" aria-labelledby="shape-h">
    <div class="wrap split">
      <div>
        <h2 id="shape-h">How leadership shapes Visagiri</h2>
      </div>
      <div>
        <p>Under Anisha Bharti and Renuka Devi, Visagiri has been built as a technology-driven visa consultancy under Tripgation Pvt Ltd. It pairs an online system for checking requirements and tracking application status with hands-on consultant support, rather than choosing one over the other.</p>
        <p>The same emphasis on transparent, dependable service carries into document attestation and legalization: apostille, MEA, embassy and consulate attestation.</p>
        <p><a class="more" href="/why-visagiri/">Why Visagiri</a> &nbsp; <a class="more" href="/our-story/">Our story</a></p>
      </div>
    </div>
  </section>

  <section class="section" aria-labelledby="team-h">
    <div class="wrap">
      <h2 id="team-h">Beyond the directors</h2>
      <p>Directors set the direction. Day-to-day case work runs through a broader team of visa consultants, document and attestation specialists and application support staff.</p>
      <ul class="linklist">
        <li><a href="/our-team/">Meet our team</a></li>
        <li><a href="/careers/">Careers</a></li>
        <li><a href="/contact/">Contact us</a></li>
        <li><a href="/grievance/">Grievance redressal</a></li>
      </ul>
    </div>
  </section>

  <section class="section tint" id="faq" aria-labelledby="faq-h">
    <div class="wrap">
      <h2 id="faq-h">Common questions</h2>
      <div class="faq">
        <details>
          <summary>Who leads Visagiri?</summary>
          <div><p>Visagiri is led by its directors, Anisha Bharti and Renuka Devi, under Tripgation Pvt Ltd.</p></div>
        </details>
        <details>
          <summary>Who handles day-to-day case work?</summary>
          <div><p>A broader team of visa consultants, document and attestation specialists and application support staff works each case day to day. The directors set the direction.</p></div>
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
