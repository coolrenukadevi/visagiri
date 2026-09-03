<?php
/**
 * Expects (optional) before include: $pageTitle, $pageDescription
 */
$pageTitle = $pageTitle ?? SITE_NAME . ' — ' . SITE_TAGLINE;
$pageDescription = $pageDescription ?? 'Videshia is the AI-powered visa management platform: intelligent routing, autonomous agents, and global visa operations in one place.';
$current = current_page();

$navLinks = [
    'index.php' => 'Home',
    'services.php' => 'Services',
    'about.php' => 'About',
    'contact.php' => 'Contact',
];
?><!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?></title>
<meta name="description" content="<?= e($pageDescription) ?>">
<link rel="icon" type="image/svg+xml" href="<?= asset('images/favicon.svg') ?>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= asset('css/style.css') ?>">
</head>
<body>

<header class="site-header">
    <div class="container">
        <a href="<?= url('index.php') ?>"><?= videshia_logo('md', 'light') ?></a>

        <nav class="main-nav" aria-label="Primary">
            <?php foreach ($navLinks as $href => $label): ?>
                <a href="<?= url($href) ?>" class="<?= $current === $href ? 'active' : '' ?>"><?= e($label) ?></a>
            <?php endforeach; ?>
        </nav>

        <div class="header-actions">
            <?php if (is_logged_in()): ?>
                <a href="<?= url('dashboard.php') ?>" class="btn btn-ghost">Dashboard</a>
            <?php else: ?>
                <a href="<?= url('login.php') ?>" class="btn btn-ghost">Sign in</a>
                <a href="<?= url('signup.php') ?>" class="btn btn-primary">Get Started</a>
            <?php endif; ?>
            <button class="nav-toggle" id="navToggle" aria-label="Toggle menu" aria-expanded="false"><span></span></button>
        </div>
    </div>
    <nav class="mobile-nav" id="mobileNav" aria-label="Mobile">
        <?php foreach ($navLinks as $href => $label): ?>
            <a href="<?= url($href) ?>"><?= e($label) ?></a>
        <?php endforeach; ?>
        <?php if (!is_logged_in()): ?>
            <a href="<?= url('login.php') ?>">Sign in</a>
            <a href="<?= url('signup.php') ?>">Get Started</a>
        <?php endif; ?>
    </nav>
</header>
