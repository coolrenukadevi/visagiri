<?php
/**
 * Homepage. Hand-authored hero + sections; header/footer/currency are shared
 * includes so they can never drift from the rest of the site.
 */
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';

// Every page that renders header.php must start the session itself, before
// any output — header.php only reads it lazily (customer_current() etc.),
// which is too late once head.php has already flushed HTML.
auth_session_start();

$page = [
  'title'       => SITE['name'] . ' | ' . SITE['tagline'],
  'short_title' => SITE['name'],
  'description' => 'Convercession is an AI-powered visa and global mobility platform that streamlines travel compliance, immigration documentation, and visa applications. Business, Tourist, Family and Employment visa guidance across Delhi, Mumbai, Kolkata, Chennai & Hyderabad. Call ' . SITE['phone'] . '.',
  'path'        => '/',
  'jsonld'      => [[
    '@context' => 'https://schema.org',
    '@type'    => 'Organization',
    'name'     => SITE['name'],
    'url'      => canonical('/'),
    'telephone'=> SITE['phone'],
    'email'    => SITE['email'],
    'parentOrganization' => ['@type' => 'Organization', 'name' => SITE['parent']],
    'address'  => [
      '@type' => 'PostalAddress',
      'streetAddress'   => SITE['address']['street'],
      'addressLocality' => SITE['address']['locality'],
      'addressRegion'   => SITE['address']['region'],
      'postalCode'      => SITE['address']['postcode'],
      'addressCountry'  => SITE['address']['country'],
    ],
    'sameAs' => array_values(SITE['social']),
  ]],
];
$extraScripts = '<script src="/js/home.js" defer></script>';
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<main>
  <!-- Hero -->
  <section class="hero" id="search">
    <div class="hero-bg" aria-hidden="true">
      <svg class="hero-blob hero-blob-1" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
        <path fill="url(#hg1)" d="M451.5,318.5Q447,387,388,428.5Q329,470,264.5,447Q200,424,144,384.5Q88,345,90.5,272.5Q93,200,148,155.5Q203,111,271.5,95Q340,79,391.5,127Q443,175,458.5,246.5Q474,318,451.5,318.5Z"/>
        <defs><linearGradient id="hg1" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#29b6f6"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs>
      </svg>
      <svg class="hero-blob hero-blob-2" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg">
        <path fill="url(#hg2)" d="M441,308Q414,366,362,405.5Q310,445,247.5,436Q185,427,141,382.5Q97,338,101,272.5Q105,207,144.5,157Q184,107,248,90Q312,73,368,105Q424,137,438.5,199Q453,261,441,308Z"/>
        <defs><linearGradient id="hg2" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#2478e0"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs>
      </svg>
    </div>

    <div class="container hero-inner">
      <p class="eyebrow">AI-Powered Visa &amp; Global Mobility Platform</p>
      <h1>Your visa,<br><span class="grad-text">sorted end-to-end.</span></h1>
      <p class="hero-sub">Convercession is an AI-powered visa and global mobility platform that streamlines travel compliance, immigration documentation, and visa applications — with dedicated support for Business, Tourist, Family and Employment visas across Delhi, Mumbai, Kolkata, Chennai &amp; Hyderabad.</p>

      <!-- Search widget -->
      <div class="search-card" role="search">
        <div class="search-tabs" role="tablist" aria-label="Search type">
          <button class="tab active" role="tab" aria-selected="true" data-tab="visa" data-label="Check Visa Requirements">
            <svg viewBox="0 0 24 24" width="18" height="18"><path fill="currentColor" d="M20 3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 7a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm4 10H5v-1c0-1.33 2.67-2 4-2s4 .67 4 2v1zm6-1h-4v-1.5h4V16zm0-3h-4v-1.5h4V13zm0-3h-4V8.5h4V10z"/></svg>
            Visa Search
          </button>
          <button class="tab" role="tab" aria-selected="false" data-tab="tracking" data-label="Track Application">
            <svg viewBox="0 0 24 24" width="18" height="18"><path fill="currentColor" d="M12 2C8.1 2 5 5.1 5 9c0 5.2 7 13 7 13s7-7.8 7-13c0-3.9-3.1-7-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z"/></svg>
            Visa Tracking
          </button>
          <button class="tab" role="tab" aria-selected="false" data-tab="invoice" data-label="View Invoice">
            <svg viewBox="0 0 24 24" width="18" height="18"><path fill="currentColor" d="M6 2c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6H6zm7 7V3.5L18.5 9H13zM8 13h8v1.5H8V13zm0 3.5h8V18H8v-1.5zM8 10h3v1.5H8V10z"/></svg>
            Invoice Details
          </button>
          <button class="tab" role="tab" aria-selected="false" data-tab="payment" data-label="Proceed to Pay">
            <svg viewBox="0 0 24 24" width="18" height="18"><path fill="currentColor" d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/></svg>
            Payment
          </button>
        </div>

        <form class="search-form" id="searchForm">
          <div class="search-fields active" data-tab="visa">
            <div class="field autocomplete-field">
              <label for="visaCountryInput">Country</label>
              <input type="text" id="visaCountryInput" class="autocomplete-input" placeholder="Where do you need a visa for?" autocomplete="off" role="combobox" aria-expanded="false" aria-autocomplete="list" aria-controls="visaCountryList">
              <input type="hidden" id="visaCountry">
              <ul class="autocomplete-list" id="visaCountryList" role="listbox" hidden></ul>
            </div>
            <div class="field">
              <label for="visaCity">Embassy / Consulate / VAC</label>
              <select id="visaCity">
                <option value="">Select city</option>
              </select>
            </div>
            <div class="field autocomplete-field">
              <label for="visaTypeInput">Visa Type</label>
              <input type="text" id="visaTypeInput" class="autocomplete-input" placeholder="Select visa type" autocomplete="off" role="combobox" aria-expanded="false" aria-autocomplete="list" aria-controls="visaTypeList">
              <input type="hidden" id="visaType">
              <ul class="autocomplete-list" id="visaTypeList" role="listbox" hidden></ul>
            </div>
            <div class="field field-narrow">
              <label for="visaDate">Travel date</label>
              <input type="date" id="visaDate">
            </div>
          </div>

          <div class="search-fields" data-tab="tracking">
            <div class="field">
              <label for="trackRef">Application / Reference Number</label>
              <input type="text" id="trackRef" placeholder="e.g. CVR-2026-00142">
            </div>
            <div class="field">
              <label for="trackName">Applicant Last Name</label>
              <input type="text" id="trackName" placeholder="As per application">
            </div>
          </div>

          <div class="search-fields" data-tab="invoice">
            <div class="field">
              <label for="invoiceNumber">Invoice Number</label>
              <input type="text" id="invoiceNumber" placeholder="e.g. INV-2026-00123">
            </div>
            <div class="field">
              <label for="invoiceContact">Registered Email / Mobile</label>
              <input type="text" id="invoiceContact" placeholder="Used at the time of booking">
            </div>
          </div>

          <div class="search-fields" data-tab="payment">
            <div class="field">
              <label for="paymentRef">Invoice / Application Number</label>
              <input type="text" id="paymentRef" placeholder="e.g. INV-2026-00123">
            </div>
            <div class="field field-narrow">
              <label for="paymentAmount">Amount Due (₹)</label>
              <input type="text" id="paymentAmount" placeholder="Auto-filled after lookup">
            </div>
          </div>

          <button type="submit" class="btn btn-primary search-submit">
            <svg viewBox="0 0 24 24" width="18" height="18"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg>
            <span id="searchSubmitLabel">Check Visa Requirements</span>
          </button>
        </form>
      </div>

      <div class="visa-quicklinks">
        <span class="visa-quicklinks-label">Quick apply:</span>
        <button type="button" class="visa-quick-btn" data-visatype="Business Visa">Business Visa</button>
        <button type="button" class="visa-quick-btn" data-visatype="Tourist Visa">Tourist Visa</button>
        <button type="button" class="visa-quick-btn" data-visatype="Family Visit Visa">Family Visa</button>
        <button type="button" class="visa-quick-btn" data-visatype="Employment / Work Visa">Employment Visa</button>
      </div>

      <div class="hero-stats">
        <div><strong>4</strong><span>Visa categories covered</span></div>
        <div><strong>5</strong><span>Consulate / VAC cities</span></div>
        <div><strong>1:1</strong><span>Dedicated consultant</span></div>
        <div><strong>Patna</strong><span>Head office, Bihar</span></div>
      </div>
    </div>
  </section>

  <!-- Trust bar -->
  <section class="trustbar" aria-label="Why Convercession">
    <div class="container trustbar-inner">
      <div class="trust-item">
        <svg viewBox="0 0 24 24" width="22" height="22"><path fill="currentColor" d="M12 1 3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/></svg>
        <div><h3>Dedicated visa consultants</h3><p>One point of contact from first consultation to visa outcome.</p></div>
      </div>
      <div class="trust-item">
        <svg viewBox="0 0 24 24" width="22" height="22"><path fill="currentColor" d="M20 3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 7a2 2 0 1 1 0 4 2 2 0 0 1 0-4zm4 10H5v-1c0-1.33 2.67-2 4-2s4 .67 4 2v1zm6-1h-4v-1.5h4V16zm0-3h-4v-1.5h4V13zm0-3h-4V8.5h4V10z"/></svg>
        <div><h3>Business, Tourist, Family &amp; Employment</h3><p>Documentation guidance across every major visa category.</p></div>
      </div>
      <div class="trust-item">
        <svg viewBox="0 0 24 24" width="22" height="22"><path fill="currentColor" d="M12 1 3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zM10 17l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>
        <div><h3>Application tracking</h3><p>Every step guided, from paperwork to consulate submission.</p></div>
      </div>
      <div class="trust-item">
        <svg viewBox="0 0 24 24" width="22" height="22"><path fill="currentColor" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h1.5v5.2l4.5 2.7-.75 1.3L11 13V7z"/></svg>
        <div><h3>5 consulate cities</h3><p>Guidance for filings out of Delhi, Mumbai, Kolkata, Chennai &amp; Hyderabad.</p></div>
      </div>
    </div>
  </section>

  <!-- Service console: the six primary tasks, one tap from the fold.
       Same include as /visa-finder and /404 so the entry points never diverge. -->
  <?php $console_alt = true; include __DIR__ . '/includes/service-console.php'; ?>

  <!-- Visa types -->
  <section class="section" id="visa">
    <div class="container">
      <div class="section-head center">
        <p class="kicker">Visa &amp; immigration services</p>
        <h2>Visa types we handle</h2>
      </div>

      <div class="visatype-grid">
        <button type="button" class="visatype-card" data-visatype="Business Visa">
          <div class="visatype-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M20 6h-2.18c.11-.31.18-.65.18-1a2.996 2.996 0 0 0-5.5-1.65l-.5.67-.5-.68C10.96 2.54 10.05 2 9 2 7.34 2 6 3.34 6 5c0 .35.07.69.18 1H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2z"/></svg></div>
          <h3>Business Visa</h3>
          <p>For meetings, conferences and corporate travel abroad.</p>
          <span class="link-arrow">Start application →</span>
        </button>
        <button type="button" class="visatype-card" data-visatype="Tourist Visa">
          <div class="visatype-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 2 2 7v6c0 5.5 3.8 10.7 10 12 6.2-1.3 10-6.5 10-12V7l-10-5z"/></svg></div>
          <h3>Tourist Visa</h3>
          <p>Holiday and leisure travel visas, guided end-to-end.</p>
          <span class="link-arrow">Start application →</span>
        </button>
        <button type="button" class="visatype-card" data-visatype="Family Visit Visa">
          <div class="visatype-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 12c2.7 0 8 1.34 8 4v2H4v-2c0-2.66 5.3-4 8-4zm0-2a4 4 0 1 1 0-8 4 4 0 0 1 0 8z"/></svg></div>
          <h3>Family / Dependent Visa</h3>
          <p>Reuniting with family, spouses and dependents overseas.</p>
          <span class="link-arrow">Start application →</span>
        </button>
        <a class="visatype-card" href="/visa/schengen">
          <div class="visatype-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm6.93 6h-2.95a15.65 15.65 0 0 0-1.38-3.56A8.03 8.03 0 0 1 18.93 8zM12 4.04c.83 1.2 1.48 2.53 1.91 3.96h-3.82c.43-1.43 1.08-2.76 1.91-3.96zM4.26 14C4.1 13.36 4 12.69 4 12s.1-1.36.26-2h3.38c-.08.66-.14 1.32-.14 2s.06 1.34.14 2H4.26zm.82 2h2.95c.32 1.25.78 2.45 1.38 3.56A7.99 7.99 0 0 1 5.08 16zm2.95-8H5.08a7.99 7.99 0 0 1 4.33-3.56A15.65 15.65 0 0 0 8.03 8zM12 19.96c-.83-1.2-1.48-2.53-1.91-3.96h3.82c-.43 1.43-1.08 2.76-1.91 3.96zM14.34 14H9.66c-.09-.66-.16-1.32-.16-2s.07-1.35.16-2h4.68c.09.65.16 1.32.16 2s-.07 1.34-.16 2zm.25 5.56c.6-1.11 1.06-2.31 1.38-3.56h2.95a8.03 8.03 0 0 1-4.33 3.56zM16.36 14c.08-.66.14-1.32.14-2s-.06-1.34-.14-2h3.38c.16.64.26 1.31.26 2s-.1 1.36-.26 2h-3.38z"/></svg></div>
          <h3>Schengen Visa</h3>
          <p>One visa for short stays across the 29 Schengen countries.</p>
          <span class="link-arrow">See the checklist &rarr;</span>
        </a>
        <button type="button" class="visatype-card" data-visatype="Employment / Work Visa">
          <div class="visatype-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M20 6h-2.18c.11-.31.18-.65.18-1a2.996 2.996 0 0 0-5.5-1.65l-.5.67-.5-.68C10.96 2.54 10.05 2 9 2 7.34 2 6 3.34 6 5c0 .35.07.69.18 1H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zM9 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm6 0c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1z"/></svg></div>
          <h3>Employment Visa</h3>
          <p>Work permits and employment visas for overseas roles.</p>
          <span class="link-arrow">Start application →</span>
        </button>
      </div>
    </div>
  </section>

  <!-- Popular visa destinations -->
  <section class="section section-alt" id="destinations">
    <div class="container">
      <div class="section-head">
        <div>
          <p class="kicker">Where are you headed?</p>
          <h2>Popular visa destinations</h2>
        </div>
        <a href="#search" class="link-arrow">Search all countries →</a>
      </div>

      <div class="visa-grid" id="visaDestGrid">
        <button type="button" class="visa-card" data-country="Kenya"><span class="visa-flag">🇰🇪</span><span><span class="visa-card-name">Kenya</span><span class="visa-card-meta">Tourist &amp; Business</span></span></button>
        <button type="button" class="visa-card" data-country="United States"><span class="visa-flag">🇺🇸</span><span><span class="visa-card-name">United States</span><span class="visa-card-meta">Tourist, Business &amp; Employment</span></span></button>
        <button type="button" class="visa-card" data-country="United Kingdom"><span class="visa-flag">🇬🇧</span><span><span class="visa-card-name">United Kingdom</span><span class="visa-card-meta">Tourist, Business &amp; Family</span></span></button>
        <button type="button" class="visa-card" data-country="United Arab Emirates"><span class="visa-flag">🇦🇪</span><span><span class="visa-card-name">United Arab Emirates</span><span class="visa-card-meta">Tourist &amp; Employment</span></span></button>
        <button type="button" class="visa-card" data-country="France"><span class="visa-flag">🇫🇷</span><span><span class="visa-card-name">France</span><span class="visa-card-meta">Schengen — Tourist &amp; Business</span></span></button>
        <button type="button" class="visa-card" data-country="Singapore"><span class="visa-flag">🇸🇬</span><span><span class="visa-card-name">Singapore</span><span class="visa-card-meta">Tourist &amp; Business</span></span></button>
        <button type="button" class="visa-card" data-country="Canada"><span class="visa-flag">🇨🇦</span><span><span class="visa-card-name">Canada</span><span class="visa-card-meta">Tourist, Family &amp; Employment</span></span></button>
        <button type="button" class="visa-card" data-country="Australia"><span class="visa-flag">🇦🇺</span><span><span class="visa-card-name">Australia</span><span class="visa-card-meta">Tourist, Family &amp; Employment</span></span></button>
      </div>
    </div>
  </section>

  <!-- How it works -->
  <section class="section" id="how">
    <div class="container">
      <div class="section-head center">
        <p class="kicker">Simple, guided, transparent</p>
        <h2>How Convercession works</h2>
      </div>

      <div class="steps">
        <div class="step">
          <div class="step-num">1</div>
          <div class="step-icon"><svg viewBox="0 0 24 24" width="26" height="26"><path fill="currentColor" d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5L20.49 19zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z"/></svg></div>
          <h3>Tell us your requirement</h3>
          <p>Share your destination country and visa type — Business, Tourist, Family or Employment.</p>
        </div>
        <div class="step">
          <div class="step-num">2</div>
          <div class="step-icon"><svg viewBox="0 0 24 24" width="26" height="26"><path fill="currentColor" d="M12 12c2.7 0 8 1.34 8 4v2H4v-2c0-2.66 5.3-4 8-4zm0-2a4 4 0 1 1 0-8 4 4 0 0 1 0 8z"/></svg></div>
          <h3>Talk to a visa consultant</h3>
          <p>A dedicated consultant reviews your documents and prepares your application.</p>
        </div>
        <div class="step">
          <div class="step-num">3</div>
          <div class="step-icon"><svg viewBox="0 0 24 24" width="26" height="26"><path fill="currentColor" d="M9 16.2 4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4z"/></svg></div>
          <h3>Apply &amp; track</h3>
          <p>We guide submission at the relevant consulate / embassy and keep you updated.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Callback banner -->
  <section class="deal-banner" id="deals">
    <div class="container deal-banner-inner">
      <div>
        <p class="kicker kicker-light">Talk to a consultant</p>
        <h2>Planning to apply for a visa?</h2>
        <p class="deal-sub">Share your travel requirement and one of our visa consultants will call you back with next steps.</p>
        <form class="deal-form" id="dealForm">
          <input type="tel" placeholder="Your mobile number" aria-label="Mobile number" required>
          <button type="submit" class="btn btn-light">Request a callback</button>
        </form>
        <p class="deal-note" id="dealNote" aria-live="polite"></p>
      </div>
      <div class="deal-art" aria-hidden="true">
        <svg viewBox="0 0 200 200" width="180" height="180">
          <circle cx="100" cy="100" r="90" fill="rgba(255,255,255,0.12)"/>
          <circle cx="100" cy="100" r="65" fill="rgba(255,255,255,0.18)"/>
          <path d="M100 40 L110 90 L160 100 L110 110 L100 160 L90 110 L40 100 L90 90 Z" fill="white" fill-opacity="0.9"/>
        </svg>
      </div>
    </div>
  </section>

  <!-- About / why choose us -->
  <section class="section" id="about">
    <div class="container">
      <div class="section-head center">
        <p class="kicker">Who we are</p>
        <h2>Why applicants trust Convercession</h2>
      </div>
      <p style="max-width:760px;margin:0 auto 40px;text-align:justify;text-align-last:center;hyphens:auto;color:var(--ink-500);">
        Convercession is an AI-powered visa and global mobility platform that streamlines travel compliance,
        immigration documentation, and visa applications for individuals, families and businesses. Our consultants
        guide Business, Tourist, Family and Employment visa applications — with support for filings out of
        Delhi, Mumbai, Kolkata, Chennai and Hyderabad, on a site that's just as easy to use from your phone as your desktop.
      </p>

      <div class="value-grid">
        <div class="value-card">
          <div class="value-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 2 2 7v6c0 5.5 3.8 10.7 10 12 6.2-1.3 10-6.5 10-12V7l-10-5z"/></svg></div>
          <h3>Guided, not generic</h3>
          <p>Every application is reviewed by a consultant against the destination country's current requirements.</p>
        </div>
        <div class="value-card">
          <div class="value-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm6.9 6H16a15.6 15.6 0 0 0-1.3-3.9A8 8 0 0 1 18.9 8zM12 4.1c.8 1.1 1.5 2.4 1.9 3.9h-3.8c.4-1.5 1.1-2.8 1.9-3.9zM4.3 14a8 8 0 0 1 0-4h3.3a16.5 16.5 0 0 0 0 4H4.3zm.8 2h2.8a15.6 15.6 0 0 0 1.3 3.9A8 8 0 0 1 5.1 16zm2.8-8H5.1a8 8 0 0 1 4.1-3.9A15.6 15.6 0 0 0 7.9 8zM12 19.9c-.8-1.1-1.5-2.4-1.9-3.9h3.8c-.4 1.5-1.1 2.8-1.9 3.9zM14.3 14H9.7a14.4 14.4 0 0 1 0-4h4.6a14.4 14.4 0 0 1 0 4zm.2 5.9A15.6 15.6 0 0 0 15.8 16h2.8a8 8 0 0 1-4.1 3.9zM16.4 14a16.5 16.5 0 0 0 0-4h3.3a8 8 0 0 1 0 4h-3.3z"/></svg></div>
          <h3>All major visa categories</h3>
          <p>Business, Tourist, Family and Employment visas handled under one roof.</p>
        </div>
        <div class="value-card">
          <div class="value-icon"><svg viewBox="0 0 24 24" width="22" height="22" fill="white"><path d="M12 12c2.7 0 8 1.34 8 4v2H4v-2c0-2.66 5.3-4 8-4zm0-2a4 4 0 1 1 0-8 4 4 0 0 1 0 8z"/></svg></div>
          <h3>A consultant you can reach</h3>
          <p>Direct phone and email access to your consultant throughout the process.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Office / contact -->
  <section class="offices" id="contact">
    <div class="container offices-inner">
      <div class="section-head center">
        <p class="kicker kicker-light">Reach us</p>
        <h2 style="color:#fff;">Our office</h2>
      </div>

      <div class="office-grid">
        <div class="office-card">
          <span class="office-tag">Head Office</span>
          <h3>Patna, Bihar</h3>
          <address>
            203, Sharda Mansion Apartment, Kailashpuri,<br>
            Kankarbagh, Hanuman Nagar,<br>
            Patna, Bihar – 800020
          </address>
          <a class="office-phone" href="tel:+917065819819">
            <svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z"/></svg>
            +91-7065-819-819
          </a>
        </div>
        <div class="office-card">
          <span class="office-tag">Consulate / VAC coverage</span>
          <h3>We guide filings in</h3>
          <p class="office-line">New Delhi · Mumbai · Kolkata · Chennai · Hyderabad</p>
          <a class="office-phone" href="mailto:hello@convercession.com">
            <svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6l8 5 8-5v2z"/></svg>
            hello@convercession.com
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- Contact CTA -->
  <section class="concierge">
    <div class="container concierge-inner">
      <div class="concierge-art" aria-hidden="true">
        <svg viewBox="0 0 24 24" width="56" height="56" fill="white"><path d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z"/></svg>
      </div>
      <div>
        <p class="kicker">Talk to us</p>
        <h2>Prefer to speak with a visa consultant?</h2>
        <p>Reach out any way that's convenient — our team responds from the Patna head office.</p>
        <div class="contact-btns">
          <a href="tel:+917065819819" class="contact-btn">
            <svg viewBox="0 0 24 24" width="20" height="20"><path fill="currentColor" d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.2.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z"/></svg>
            <span><strong>Call us</strong><span>+91-7065-819-819</span></span>
          </a>
          <a href="https://wa.me/917065819819" target="_blank" rel="noopener" class="contact-btn">
            <svg viewBox="0 0 24 24" width="20" height="20"><path fill="currentColor" d="M12 2a10 10 0 0 0-8.6 15.1L2 22l5.1-1.3A10 10 0 1 0 12 2zm5.7 14.2c-.2.6-1.4 1.2-1.9 1.2-.5 0-1-.1-3.2-1-2.7-1.1-4.4-3.8-4.6-4-.1-.2-1.1-1.4-1.1-2.7 0-1.3.7-1.9.9-2.2.2-.2.5-.3.7-.3h.5c.2 0 .4 0 .6.4.2.5.7 1.8.8 1.9.1.2.1.3 0 .5-.1.2-.1.3-.3.5-.1.2-.3.4-.4.5-.1.1-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1 .2-.3.4-.2.6-.1.2.1 1.5.7 1.7.8.2.1.4.2.4.3.1.2.1.7-.1 1.3z"/></svg>
            <span><strong>WhatsApp</strong><span>Chat with our team</span></span>
          </a>
          <a href="mailto:hello@convercession.com" class="contact-btn">
            <svg viewBox="0 0 24 24" width="20" height="20"><path fill="currentColor" d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6l8 5 8-5v2z"/></svg>
            <span><strong>Email us</strong><span>hello@convercession.com</span></span>
          </a>
        </div>
      </div>
    </div>
  </section>
</main>

<!-- Footer -->
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
