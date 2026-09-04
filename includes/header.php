<?php
/**
 * Expects (optional) before include:
 *   $pageTitle, $pageDescription, $canonical, $robotsMeta, $ogImage,
 *   $schemaBlocks (array of arrays, each json_encode-ready), $breadcrumbs (array of [label, url|null])
 */
require_once __DIR__ . '/db.php';
require_once __DIR__ . '/seo.php';

$pageTitle = $pageTitle ?? SITE_NAME . ' — ' . SITE_TAGLINE;
$pageDescription = $pageDescription ?? 'Videshia is the AI-powered visa management platform: intelligent routing, autonomous agents, and global visa operations in one place.';
$robotsMeta = $robotsMeta ?? 'index, follow';
$canonical = $canonical ?? (SITE_URL . $_SERVER['REQUEST_URI']);
$current = current_page();

$megaCountries = db()->query("SELECT slug, name FROM countries WHERE indexable = 1 ORDER BY name LIMIT 10")->fetchAll();
$megaCategories = db()->query("SELECT slug, name FROM visa_categories ORDER BY name")->fetchAll();

$navLinks = [
    'index.php' => 'Home',
    'about.php' => 'About',
    'contact.php' => 'Contact',
];

$travelDropdowns = [
    'Tours' => ['travel-services.php#tours', ['Domestic Tours' => '#tours', 'International Tours' => '#tours', 'Honeymoon & Family' => '#tours', 'Adventure & Solo' => '#tours']],
    'Hotels' => ['travel-services.php#hotels', ['Domestic Hotels' => '#hotels', 'International Hotels' => '#hotels', 'Corporate Hotels' => '#hotels', 'Hotel Enquiry' => '#hotels']],
    'Flights' => ['travel-services.php#flights', ['Domestic Flights' => '#flights', 'International Flights' => '#flights', 'Flight Enquiry' => '#flights']],
    'Forex' => ['travel-services.php#forex', ['Currency Exchange' => '#forex', 'Forex Card' => '#forex', 'Currency Rates' => '#forex', 'Forex Enquiry' => '#forex']],
    'Travel Insurance' => ['travel-services.php#insurance', ['International Insurance' => '#insurance', 'Schengen Insurance' => '#insurance', 'Domestic Insurance' => '#insurance', 'Insurance Enquiry' => '#insurance']],
    'Corporate Travel' => ['travel-services.php#corporate', ['Travel Management' => '#corporate', 'Employee Travel' => '#corporate', 'MIS & Reporting' => '#corporate', 'Corporate Enquiry' => '#corporate']],
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

<header class="site-header">
    <div class="container">
        <a href="<?= url('index.php') ?>"><?= videshia_logo('md', 'light') ?></a>

        <nav class="main-nav" aria-label="Primary">
            <div class="nav-item"><a href="<?= url('index.php') ?>" class="<?= $current === 'index.php' ? 'active' : '' ?>">Home</a></div>

            <div class="nav-item has-mega">
                <button class="nav-link" type="button">Visa Services <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="mega-panel">
                    <div class="mega-col">
                        <h5>Visa by Country</h5>
                        <?php foreach ($megaCountries as $c): ?>
                        <a href="<?= url('visa/' . $c['slug'] . '/') ?>"><?= e($c['name']) ?></a>
                        <?php endforeach; ?>
                        <a href="<?= url('visa/') ?>" style="color:var(--teal-500);font-weight:600">View all countries &rarr;</a>
                    </div>
                    <div class="mega-col">
                        <h5>Visa by Type</h5>
                        <?php foreach ($megaCategories as $cat): ?>
                        <a href="<?= url('visa/type/' . $cat['slug'] . '/') ?>"><?= e($cat['name']) ?></a>
                        <?php endforeach; ?>
                    </div>
                    <div class="mega-col">
                        <h5>Resources</h5>
                        <a href="<?= url('visa/') ?>#fees">Visa Fees</a>
                        <a href="<?= url('visa/') ?>#processing-time">Processing Time</a>
                        <a href="<?= url('visa/') ?>#requirements">Visa Requirements</a>
                        <a href="<?= url('visa/') ?>#faqs">Visa FAQs</a>
                        <a href="<?= url('contact.php') ?>">Visa Appointment</a>
                        <a href="<?= url('contact.php') ?>">Visa Assistance</a>
                    </div>
                    <div class="mega-promo">
                        <h5>Need help choosing?</h5>
                        <p>Tell us your destination and purpose — we'll match you to the right visa category.</p>
                        <a href="<?= url('index.php') ?>#enquiry" class="btn btn-light" style="padding:9px 16px;font-size:13px">Enquire Now</a>
                    </div>
                </div>
            </div>

            <?php foreach ($travelDropdowns as $label => [$mainHref, $items]): ?>
            <div class="nav-item">
                <button class="nav-link" type="button"><?= e($label) ?> <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><path d="M6 9l6 6 6-6"/></svg></button>
                <div class="dropdown-panel">
                    <?php foreach ($items as $itemLabel => $itemHref): ?>
                    <a href="<?= url($mainHref) ?>"><?= e($itemLabel) ?></a>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>

            <div class="nav-item"><a href="<?= url('about.php') ?>" class="<?= $current === 'about.php' ? 'active' : '' ?>">About</a></div>
            <div class="nav-item"><a href="<?= url('contact.php') ?>" class="<?= $current === 'contact.php' ? 'active' : '' ?>">Contact</a></div>
        </nav>

        <div class="header-actions">
            <div class="header-contact">
                <a href="tel:+917844819819" aria-label="Call us"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3.1 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3.1-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 2.9a2 2 0 01-.5 2.1L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012.1-.5c.9.3 1.9.5 2.9.6a2 2 0 011.7 2z"/></svg></a>
                <a href="https://wa.me/917844819819" class="whatsapp" aria-label="WhatsApp us" target="_blank" rel="noopener"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 00-8.6 15L2 22l5.2-1.4A10 10 0 1012 2zm5.8 14.3c-.3.7-1.4 1.3-2 1.4-.5.1-1.2.1-1.9-.1-.4-.1-1-.3-1.7-.6-3-1.3-4.9-4.3-5.1-4.5-.1-.2-1.2-1.6-1.2-3.1s.8-2.2 1.1-2.5c.3-.3.6-.4.8-.4h.6c.2 0 .4 0 .6.5.2.5.8 1.9.8 2 .1.2.1.3 0 .5-.1.2-.1.3-.3.5l-.4.5c-.1.2-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1.1.2-.3.4-.2.6-.1l1.8.9c.2.1.4.2.4.3.1.3.1.9-.2 1.5z"/></svg></a>
            </div>
            <?php if (is_logged_in()): ?>
                <a href="<?= url('dashboard.php') ?>" class="btn btn-ghost">Dashboard</a>
            <?php else: ?>
                <a href="<?= url('login.php') ?>" class="btn btn-ghost">Sign in</a>
            <?php endif; ?>
            <a href="<?= url('index.php') ?>#enquiry" class="btn btn-primary">Enquire Now</a>
            <button class="nav-toggle" id="navToggle" aria-label="Toggle menu" aria-expanded="false"><span></span></button>
        </div>
    </div>
    <nav class="mobile-nav" id="mobileNav" aria-label="Mobile">
        <a href="<?= url('index.php') ?>">Home</a>

        <details>
            <summary>Visa Services</summary>
            <div class="mobile-submenu">
                <?php foreach ($megaCountries as $c): ?>
                <a href="<?= url('visa/' . $c['slug'] . '/') ?>"><?= e($c['name']) ?> Visa</a>
                <?php endforeach; ?>
                <a href="<?= url('visa/') ?>">View all countries</a>
            </div>
        </details>

        <?php foreach ($travelDropdowns as $label => [$mainHref, $items]): ?>
        <details>
            <summary><?= e($label) ?></summary>
            <div class="mobile-submenu">
                <a href="<?= url($mainHref) ?>">View <?= e($label) ?></a>
            </div>
        </details>
        <?php endforeach; ?>

        <a href="<?= url('about.php') ?>">About</a>
        <a href="<?= url('contact.php') ?>">Contact</a>
        <?php if (!is_logged_in()): ?>
            <a href="<?= url('login.php') ?>">Sign in</a>
        <?php endif; ?>
        <a href="<?= url('index.php') ?>#enquiry">Enquire Now</a>
    </nav>
</header>
