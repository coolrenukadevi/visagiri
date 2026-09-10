<?php
/**
 * Expects (optional) before include:
 *   $pageTitle, $pageDescription, $canonical, $robotsMeta, $ogImage,
 *   $schemaBlocks (array of arrays, each json_encode-ready), $breadcrumbs (array of [label, url|null])
 */
require_once __DIR__ . '/db.php';
require_once __DIR__ . '/seo.php';

$pageTitle = $pageTitle ?? SITE_NAME . ' — ' . SITE_TAGLINE;
$pageDescription = $pageDescription ?? 'Videshia is a premium visa consultancy for Indian travellers: document review, application support and a named consultant on every case.';
$robotsMeta = $robotsMeta ?? 'index, follow';
$canonical = $canonical ?? (SITE_URL . $_SERVER['REQUEST_URI']);
$current = current_page();

$megaCountries = db()->query("SELECT slug, name, region FROM countries WHERE indexable = 1 ORDER BY region, name")->fetchAll();
$countriesByRegion = [];
foreach ($megaCountries as $c) {
    $countriesByRegion[$c['region']][] = $c;
}
$megaCategories = db()->query("SELECT slug, name FROM visa_categories ORDER BY name")->fetchAll();
$catBySlug = [];
foreach ($megaCategories as $c) {
    $catBySlug[$c['slug']] = $c['name'];
}

$visaInfoTopics = [
    'visa-requirements' => 'Visa Requirements',
    'visa-documents' => 'Visa Documents',
    'visa-checklist' => 'Visa Checklist',
    'visa-fees' => 'Visa Fees',
    'processing-time' => 'Processing Time',
    'visa-appointment' => 'Visa Appointment',
    'visa-faqs' => 'Visa FAQs',
];
?><!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?></title>
<meta name="description" content="<?= e($pageDescription) ?>">
<meta name="robots" content="<?= e($robotsMeta) ?>">
<link rel="canonical" href="<?= e($canonical) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="<?= e(SITE_NAME) ?>">
<meta property="og:title" content="<?= e($pageTitle) ?>">
<meta property="og:description" content="<?= e($pageDescription) ?>">
<meta property="og:url" content="<?= e($canonical) ?>">
<?php if (!empty($ogImage)): ?><meta property="og:image" content="<?= e($ogImage) ?>"><?php endif; ?>
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="<?= e($pageTitle) ?>">
<meta name="twitter:description" content="<?= e($pageDescription) ?>">
<link rel="icon" type="image/svg+xml" href="<?= asset('images/favicon.svg') ?>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= asset('css/style.css') ?>">
<?php foreach (array_merge([organization_schema()], $schemaBlocks ?? []) as $block): ?>
<script type="application/ld+json"><?= json_encode($block, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) ?></script>
<?php endforeach; ?>
</head>
<body>

<div class="utility-bar">
    <div class="container">
        <span class="utility-bar-left">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>
            24&times;7 Support
        </span>
        <div class="utility-bar-right">
            <a href="https://wa.me/917844819819" class="whatsapp" target="_blank" rel="noopener" data-hide-mobile>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 00-8.6 15L2 22l5.2-1.4A10 10 0 1012 2zm5.8 14.3c-.3.7-1.4 1.3-2 1.4-.5.1-1.2.1-1.9-.1-.4-.1-1-.3-1.7-.6-3-1.3-4.9-4.3-5.1-4.5-.1-.2-1.2-1.6-1.2-3.1s.8-2.2 1.1-2.5c.3-.3.6-.4.8-.4h.6c.2 0 .4 0 .6.5.2.5.8 1.9.8 2 .1.2.1.3 0 .5-.1.2-.1.3-.3.5l-.4.5c-.1.2-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1.1.2-.3.4-.2.6-.1l1.8.9c.2.1.4.2.4.3.1.3.1.9-.2 1.5z"/></svg>
                <span class="label">WhatsApp</span>
            </a>
            <a href="tel:+917844819819" data-hide-mobile>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3.1 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3.1-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 2.9a2 2 0 01-.5 2.1L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012.1-.5c.9.3 1.9.5 2.9.6a2 2 0 011.7 2z"/></svg>
                <span class="label">Call Us</span>
            </a>
            <a href="mailto:info@tripgation.com" data-hide-mobile>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16v16H4z"/><path d="M22 6l-10 7L2 6"/></svg>
                <span class="label">Email</span>
            </a>
            <span class="utility-bar-divider" data-hide-mobile></span>
            <a href="<?= url('track-application/') ?>">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg>
                <span class="label">Track Application</span>
            </a>
            <a href="<?= url('login.php') ?>">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 3h4a2 2 0 012 2v14a2 2 0 01-2 2h-4M10 17l5-5-5-5M15 12H3"/></svg>
                <span class="label">Login</span>
            </a>
        </div>
    </div>
</div>

<header class="site-header">
    <div class="container">
        <a href="<?= url('index.php') ?>" aria-label="Videshia — home"><?= videshia_logo('md', 'light') ?></a>

        <nav class="main-nav" aria-label="Primary">
            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Visa Services <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="mega-panel">
                    <div class="mega-col">
                        <h5>By Visa Type</h5>
                        <?php foreach ($megaCategories as $cat): ?>
                        <a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>"><?= e($cat['name']) ?></a>
                        <?php endforeach; ?>
                    </div>
                    <div class="mega-col">
                        <h5>Support Services</h5>
                        <a href="<?= url('visa-services/') ?>#support-services">Visa Documentation</a>
                        <a href="<?= url('visa-services/') ?>#support-services">Visa Appointment Assistance</a>
                        <a href="<?= url('visa-services/') ?>#support-services">Visa Application Support</a>
                        <a href="<?= url('visa-services/') ?>#support-services">Visa Extension</a>
                        <a href="<?= url('visa-services/') ?>#support-services">Visa Renewal</a>
                    </div>
                    <div class="mega-col">
                        <h5>Resources</h5>
                        <a href="<?= url('visa-information/visa-fees/') ?>">Visa Fees</a>
                        <a href="<?= url('visa-information/processing-time/') ?>">Processing Time</a>
                        <a href="<?= url('visa-information/visa-requirements/') ?>">Visa Requirements</a>
                        <a href="<?= url('visa-information/visa-faqs/') ?>">Visa FAQs</a>
                    </div>
                    <div class="mega-promo">
                        <h5>Ready to apply?</h5>
                        <p>Tell us your destination and purpose — we'll match you to the right visa category.</p>
                        <a href="<?= url('enquiry/') ?>" class="btn btn-light" style="padding:9px 16px;font-size:13px">Start Your Visa Application</a>
                    </div>
                </div>
            </div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Visa by Country <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="mega-panel mega-panel-wide">
                    <div class="mega-country-grid">
                        <?php foreach ($megaCountries as $c): ?>
                        <a href="<?= url('visa-by-country/' . $c['slug'] . '/') ?>"><?= e($c['name']) ?></a>
                        <?php endforeach; ?>
                    </div>
                    <p style="margin:16px 0 0;padding-top:14px;border-top:1px solid var(--border)">
                        <a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">View All 190+ Countries &rarr;</a>
                    </p>
                </div>
            </div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Visa Types <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="mega-panel mega-panel-2col">
                    <div class="mega-col">
                        <h5>Personal &amp; Family</h5>
                        <?php foreach (['tourist-visa', 'family-visa', 'medical-visa', 'dependent-visa'] as $slug): if (!isset($catBySlug[$slug])) continue; ?>
                        <a href="<?= url('visa-services/' . $slug . '/') ?>"><?= e($catBySlug[$slug]) ?></a>
                        <?php endforeach; ?>
                    </div>
                    <div class="mega-col">
                        <h5>Business &amp; Official</h5>
                        <?php foreach (['business-visa', 'employment-visa', 'conference-visa', 'official-visa', 'transit-visa'] as $slug): if (!isset($catBySlug[$slug])) continue; ?>
                        <a href="<?= url('visa-services/' . $slug . '/') ?>"><?= e($catBySlug[$slug]) ?></a>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Visa Information <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="mega-panel mega-panel-2col">
                    <div class="mega-col">
                        <h5>Reference</h5>
                        <?php $half = array_slice($visaInfoTopics, 0, 4, true); foreach ($half as $slug => $label): ?>
                        <a href="<?= url('visa-information/' . $slug . '/') ?>"><?= e($label) ?></a>
                        <?php endforeach; ?>
                    </div>
                    <div class="mega-col">
                        <h5>Support</h5>
                        <?php $rest = array_slice($visaInfoTopics, 4, null, true); foreach ($rest as $slug => $label): ?>
                        <a href="<?= url('visa-information/' . $slug . '/') ?>"><?= e($label) ?></a>
                        <?php endforeach; ?>
                        <a href="<?= url('track-application/') ?>">Visa Tracking</a>
                    </div>
                </div>
            </div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Resources <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="dropdown-panel">
                    <a href="<?= url('blog/') ?>">Visa Blog</a>
                    <a href="<?= url('blog/') ?>#tips">Visa Tips</a>
                    <a href="<?= url('blog/') ?>#guides">Travel Guides</a>
                    <a href="<?= url('visa-by-country/') ?>">Country Guides</a>
                    <a href="<?= url('visa-information/visa-faqs/') ?>">Visa FAQs</a>
                </div>
            </div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Company <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="dropdown-panel">
                    <a href="<?= url('about-us/') ?>">About Us</a>
                    <a href="<?= url('leadership/') ?>">Leadership</a>
                    <a href="<?= url('why-choose-us/') ?>">Why Choose Us?</a>
                    <a href="<?= url('careers/') ?>">Career</a>
                    <a href="<?= url('partners/') ?>">Partners</a>
                    <a href="<?= url('support-24x7/') ?>">Support 24&times;7</a>
                    <a href="<?= url('contact/') ?>">Contact</a>
                </div>
            </div>
        </nav>

        <div class="header-actions">
            <a href="<?= url('enquiry/') ?>" class="btn btn-primary">Enquiry Now</a>
            <button class="nav-toggle" id="navToggle" aria-label="Toggle menu" aria-expanded="false"><span></span></button>
        </div>
    </div>

    <nav class="mobile-nav" id="mobileNav" aria-label="Mobile">
        <details>
            <summary>Visa Services</summary>
            <div class="mobile-submenu">
                <?php foreach ($megaCategories as $cat): ?>
                <a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>"><?= e($cat['name']) ?></a>
                <?php endforeach; ?>
            </div>
        </details>
        <details>
            <summary>Visa by Country</summary>
            <div class="mobile-submenu">
                <?php foreach ($megaCountries as $c): ?>
                <a href="<?= url('visa-by-country/' . $c['slug'] . '/') ?>"><?= e($c['name']) ?></a>
                <?php endforeach; ?>
                <a href="<?= url('visa-by-country/') ?>">View all countries</a>
            </div>
        </details>
        <details>
            <summary>Visa Information</summary>
            <div class="mobile-submenu">
                <?php foreach ($visaInfoTopics as $slug => $label): ?>
                <a href="<?= url('visa-information/' . $slug . '/') ?>"><?= e($label) ?></a>
                <?php endforeach; ?>
                <a href="<?= url('track-application/') ?>">Visa Tracking</a>
            </div>
        </details>
        <details>
            <summary>Resources</summary>
            <div class="mobile-submenu"><a href="<?= url('blog/') ?>">Visa Blog</a></div>
        </details>
        <details>
            <summary>Company</summary>
            <div class="mobile-submenu">
                <a href="<?= url('about-us/') ?>">About Us</a>
                <a href="<?= url('leadership/') ?>">Leadership</a>
                <a href="<?= url('why-choose-us/') ?>">Why Choose Us?</a>
                <a href="<?= url('careers/') ?>">Career</a>
                <a href="<?= url('partners/') ?>">Partners</a>
                <a href="<?= url('support-24x7/') ?>">Support 24&times;7</a>
                <a href="<?= url('contact/') ?>">Contact</a>
            </div>
        </details>
        <a href="<?= url('login.php') ?>">Login</a>
        <a href="https://wa.me/917844819819" target="_blank" rel="noopener">WhatsApp Us</a>
        <a href="<?= url('enquiry/') ?>">Enquiry Now</a>
    </nav>
</header>

<?php if ($flash = flash_get('success')): ?>
<div class="container" style="padding-top:18px"><div class="alert alert-success"><?= e($flash) ?></div></div>
<?php elseif ($flash = flash_get('error')): ?>
<div class="container" style="padding-top:18px"><div class="alert alert-error"><?= e($flash) ?></div></div>
<?php endif; ?>
