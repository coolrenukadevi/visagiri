<?php
declare(strict_types=1);

/**
 * Standalone Our Story page — same treatment as pages/about.php and
 * pages/why-visagiri.php: its own header/nav/footer/CSS
 * (public/assets/css/pages-standalone.css + our-story.css), not the
 * site's shared includes/header.php / includes/footer.php, at the
 * client's explicit request. See pages/about.php's docblock for the
 * tradeoffs this accepts.
 *
 * The timeline below only states the founding date and the "today"
 * snapshot (both sourced from real settings/DB, not hardcoded) — no
 * invented intermediate milestones (an office opening, a specific
 * partnership date, etc.). The source draft flagged this exact point
 * with an HTML comment asking for real milestones to be added; that
 * comment is preserved below rather than filled in with guesses.
 */

$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));
$countryCount = count(countries_all());
$visaTypeCount = count(visa_types_all());
$whatsappHrefStart = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$whatsappNumber = setting('whatsapp_number', '917844819819');
$contactEmail = setting('contact_email', 'info@visagiri.com');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');

$canonicalUrl = APP_URL . '/our-story/';
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
            '@type' => 'AboutPage',
            '@id' => $canonicalUrl . '#webpage',
            'url' => $canonicalUrl,
            'name' => 'Our Story - How Visagiri Began in ' . $foundingYear,
            'description' => "How Visagiri began in April {$foundingYear} as a visa consultancy and document-attestation brand, and why online tools and human consultants still shape how it works.",
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
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'About', 'item' => APP_URL . '/about/'],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Our story', 'item' => $canonicalUrl],
            ],
        ],
        [
            '@type' => 'FAQPage',
            '@id' => $canonicalUrl . '#faq',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'When was Visagiri founded?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "Visagiri was founded in April {$foundingYear} as a visa consultancy and document-attestation brand."],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Which company is behind Visagiri?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'What has stayed the same since ' . $foundingYear . '?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => "Visa and immigration decisions belong to the relevant embassy, consulate or government immigration authority. Visagiri's role has been preparation, documentation and application management, not promising outcomes it does not control."],
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
<title>Our Story - How Visagiri Began in <?= e($foundingYear) ?> | Visagiri</title>
<meta name="description" content="How Visagiri began in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand, and why online tools and human consultants still shape how it works.">
<meta name="robots" content="index, follow, max-image-preview:large">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="Our Story - How Visagiri Began in <?= e($foundingYear) ?> | Visagiri">
<meta property="og:description" content="How Visagiri began in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand, and why online tools and human consultants still shape how it works.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/our-story.css">

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
      <li aria-current="page">Our story</li>
    </ol>
  </nav>

  <section class="story-hero" aria-labelledby="h1">
    <div class="wrap">
      <h1 id="h1">Our story: from paperwork and phone calls to a clearer way through the visa process.</h1>
      <p class="lede">Visagiri began in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. This is how it started, and what it is still built on.</p>
    </div>
  </section>

  <section class="section tint" aria-labelledby="journey-h">
    <div class="wrap">
      <h2 id="journey-h">The journey so far</h2>
      <!--
        ADD REAL MILESTONES HERE as <li class="tl"> items, oldest first
        (e.g. an office opening, the online tracking system going live, a partnership or accreditation).
        Only publish dates the company can back up.
      -->
      <ol class="timeline">
        <li class="tl">
          <span class="when">April <?= e($foundingYear) ?></span>
          <div>
            <h3>Visagiri begins</h3>
            <p>Visagiri was founded as a visa consultancy and document-attestation brand under Tripgation Pvt Ltd. It was built to give travellers, students, professionals and businesses a more organised, technology-enabled way to manage the visa and attestation process.</p>
          </div>
        </li>
        <li class="tl">
          <span class="when">The idea behind it</span>
          <div>
            <h3>Online tools, with a consultant on the other end</h3>
            <p>For many applicants, a visa has meant paperwork and phone calls: tracking requirements by hand, chasing updates and explaining the same case at every step.</p>
            <p>Visagiri started from a different idea. Checking requirements and tracking an application's status could happen online, without losing the human judgement a visa or attestation case often needs.</p>
          </div>
        </li>
        <li class="tl">
          <span class="when">Today</span>
          <div>
            <h3>A directory, a team and four offices</h3>
            <p>Visagiri now covers <?= e((string) $countryCount) ?>+ countries in its visa directory across <?= e((string) $visaTypeCount) ?> visa categories, and supports clients 24&times;7 over WhatsApp, call or enquiry form. The team works from offices in Patna, Ranchi, Raipur and Bhopal.</p>
            <ul class="linklist">
              <li><a href="/countries/">Country directory</a></li>
              <li><a href="/visa-type/">Visa services</a></li>
              <li><a href="/about/#offices">Our offices</a></li>
            </ul>
          </div>
        </li>
      </ol>
    </div>
  </section>

  <section class="section" aria-labelledby="built-h">
    <div class="wrap">
      <h2 id="built-h">What that idea became</h2>
      <div class="built">
        <div>
          <h3>An online system</h3>
          <p>A place to check country-specific requirements and follow your application's status, so you are not waiting on a callback to find out where things stand.</p>
          <p><a class="more" href="/track-visa/">Track your application</a></p>
        </div>
        <div>
          <h3>A team who work each case</h3>
          <p>Visa consultants, document and attestation specialists and application support staff, led by a small team of directors, who work each case directly.</p>
          <p><a class="more" href="/our-team/">Meet the team</a> &nbsp; <a class="more" href="/leadership/">Leadership</a></p>
        </div>
      </div>
    </div>
  </section>

  <section class="section tint" aria-labelledby="same-h">
    <div class="wrap split">
      <div>
        <h2 id="same-h">What has not changed</h2>
        <p>Visa and immigration decisions belong to the relevant embassy, consulate or government immigration authority. That was true in <?= e($foundingYear) ?> and it is true today.</p>
      </div>
      <aside class="notice" aria-labelledby="role-h">
        <h3 id="role-h">Our role</h3>
        <p>Preparation, documentation and application management, not promising outcomes we do not control. Visagiri does not guarantee visa approval.</p>
      </aside>
    </div>
  </section>

  <section class="section" id="faq" aria-labelledby="faq-h">
    <div class="wrap">
      <h2 id="faq-h">Quick answers</h2>
      <div class="faq">
        <details>
          <summary>When was Visagiri founded?</summary>
          <div><p>Visagiri was founded in April <?= e($foundingYear) ?> as a visa consultancy and document-attestation brand.</p></div>
        </details>
        <details>
          <summary>Which company is behind Visagiri?</summary>
          <div><p>Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd.</p></div>
        </details>
        <details>
          <summary>What has stayed the same since <?= e($foundingYear) ?>?</summary>
          <div><p>Visa and immigration decisions belong to the relevant embassy, consulate or government immigration authority. Visagiri's role has been preparation, documentation and application management, not promising outcomes it does not control.</p></div>
        </details>
      </div>
      <p style="margin-top:28px">See what guides the work day to day on the <a href="/why-visagiri/">Why Visagiri</a> page, or read the <a href="/about/">About Visagiri</a> overview.</p>
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
