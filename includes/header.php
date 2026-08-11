<?php
declare(strict_types=1);

/**
 * Shared page head + sticky global header. Included by every page
 * handler (directly, or via render_scaffold_page() for now). Expects
 * $pageTitle, $pageDescription, $canonicalUrl to already be set by
 * the caller; falls back to sane defaults if a handler forgets to.
 */

$pageTitle ??= 'Visagiri - Visa Management';
$pageDescription ??= 'Technology-enabled visa consultancy and application management from Visagiri, a unit of Tripgation Pvt Ltd.';
$canonicalUrl ??= APP_URL . ($_SERVER['REQUEST_URI'] ?? '/');

$currentPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$activeUser = current_user();

$navLinks = [
    ['label' => 'Countries', 'href' => '/countries/'],
    ['label' => 'Attestation', 'href' => '/attestation/'],
    ['label' => 'Visa Process', 'href' => '/visa-process/'],
    ['label' => 'Visa Updates', 'href' => '/blog/'],
    ['label' => 'About', 'href' => '/about/'],
];

$visaServiceLinks = [
    ['label' => 'Tourist Visa', 'href' => '/visa-type/tourist/'],
    ['label' => 'Business Visa', 'href' => '/visa-type/business/'],
    ['label' => 'Student Visa', 'href' => '/visa-type/student/'],
    ['label' => 'Work Visa', 'href' => '/visa-type/work/'],
    ['label' => 'Family Visit Visa', 'href' => '/visa-type/family/'],
    ['label' => 'Transit Visa', 'href' => '/visa-type/transit/'],
];

$isActive = static fn(string $href): bool => $href !== '/' && str_starts_with($currentPath, $href);
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?></title>
<meta name="description" content="<?= e($pageDescription) ?>">
<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:title" content="<?= e($pageTitle) ?>">
<meta property="og:description" content="<?= e($pageDescription) ?>">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta name="twitter:card" content="summary">
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' rx='6' fill='%23123F91'/><text x='16' y='22' font-size='16' font-family='Arial,sans-serif' font-weight='700' fill='%23F4B400' text-anchor='middle'>V</text></svg>">
<link rel="stylesheet" href="/assets/css/main.css">
</head>
<body>
<a class="skip-link" href="#main">Skip to content</a>

<header class="site-header" id="site-header">
    <div class="container site-header__bar">
        <a href="/" class="site-header__logo" aria-label="Visagiri home">
            <span class="site-header__logo-mark">VISA<span>GIRI</span></span>
            <span class="site-header__logo-sub">Visa Management</span>
        </a>

        <nav class="site-header__nav" aria-label="Primary">
            <ul>
                <li class="has-dropdown">
                    <a href="/visa-type/" aria-haspopup="true"<?= $isActive('/visa-type/') ? ' class="is-active"' : '' ?>>Visa Services</a>
                    <ul class="dropdown-menu">
                        <?php foreach ($visaServiceLinks as $link): ?>
                        <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </li>
                <?php foreach ($navLinks as $link): ?>
                <li><a href="<?= e($link['href']) ?>"<?= $isActive($link['href']) ? ' class="is-active"' : '' ?>><?= e($link['label']) ?></a></li>
                <?php endforeach; ?>
            </ul>
        </nav>

        <div class="site-header__actions">
            <a href="/countries/" class="site-header__icon-btn" aria-label="Search visas">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true"><circle cx="9" cy="9" r="6.5" stroke="currentColor" stroke-width="1.6"/><path d="M17 17L13.6 13.6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
            </a>
            <?php if ($activeUser): ?>
                <a href="/dashboard/" class="btn btn-ghost btn-sm"><?= e($activeUser['full_name']) ?></a>
                <a href="/logout/" class="btn btn-outline btn-sm">Logout</a>
            <?php else: ?>
                <a href="/login/" class="site-header__text-link">Login</a>
                <a href="/register/" class="site-header__text-link">Sign Up</a>
            <?php endif; ?>
            <a href="/dashboard/" class="btn btn-gold btn-sm site-header__cta">Start Application</a>
        </div>

        <button type="button" class="site-header__burger" id="site-header-burger" aria-expanded="false" aria-controls="site-header-mobile" aria-label="Open menu">
            <span></span><span></span><span></span>
        </button>
    </div>

    <div class="site-header__mobile" id="site-header-mobile">
        <nav aria-label="Mobile primary">
            <ul>
                <li><a href="/visa-type/">Visa Services</a></li>
                <?php foreach ($navLinks as $link): ?>
                <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                <?php endforeach; ?>
            </ul>
        </nav>
        <div class="site-header__mobile-actions">
            <?php if ($activeUser): ?>
                <a href="/dashboard/" class="btn btn-outline">My Dashboard</a>
                <a href="/logout/" class="btn btn-ghost">Logout</a>
            <?php else: ?>
                <a href="/login/" class="btn btn-outline">Login</a>
                <a href="/register/" class="btn btn-ghost">Sign Up</a>
            <?php endif; ?>
            <a href="/dashboard/" class="btn btn-gold">Start Application</a>
        </div>
    </div>
</header>

<main id="main">
