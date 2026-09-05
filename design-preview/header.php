<?php
/**
 * Shared header/nav for the design-preview mini-site.
 * Set these variables before including this file:
 *   $pageTitle        (string)  — used in <title>
 *   $pageDescription  (string)  — meta description
 *   $activeNav        (string)  — one of: home, about, payment, contact
 */
$pageTitle       = $pageTitle       ?? 'Visa Agency — Design Preview';
$pageDescription = $pageDescription ?? 'Design concept preview — not the live Visa Agency site.';
$activeNav       = $activeNav       ?? '';

$navItems = [
    ['label' => 'Home',             'href' => 'index.php',                'key' => 'home'],
    ['label' => 'About Us',         'href' => 'about.php#overview',       'key' => 'about'],
    ['label' => 'Why Us?',          'href' => 'about.php#why-choose-us',  'key' => 'about'],
    ['label' => 'Vision & Mission', 'href' => 'about.php#vision-mission', 'key' => 'about'],
    ['label' => 'Leadership',       'href' => 'about.php#leadership',     'key' => 'about'],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?php echo htmlspecialchars($pageTitle); ?></title>
<meta name="description" content="<?php echo htmlspecialchars($pageDescription); ?>">
<meta name="robots" content="noindex, nofollow">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,500;0,9..144,600;1,9..144,500&family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/theme.css">
</head>
<body>

<div class="preview-ribbon">Design concept preview &middot; not the live Visa Agency site &middot; content shown here is illustrative only</div>

<header>
  <input type="checkbox" id="menu-check">
  <div class="wrap nav-row">
    <a class="brand" href="index.php">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.4"><path d="M4 4h16v16H4z"/><circle cx="12" cy="10" r="3"/><path d="M7 18c1-2.5 3-3.5 5-3.5s4 1 5 3.5"/></svg>
      Visa Agency
    </a>
    <nav class="links">
      <?php foreach ($navItems as $item): ?>
        <a href="<?php echo $item['href']; ?>"<?php echo $item['key'] === $activeNav ? ' style="color:var(--gold-bright);border-color:var(--gold);"' : ''; ?>>
          <?php echo htmlspecialchars($item['label']); ?>
        </a>
      <?php endforeach; ?>
    </nav>
    <div class="nav-cta">
      <a class="btn btn-ghost" href="payment.php">Payment Link</a>
      <a class="btn btn-solid" href="contact.php">Support</a>
      <label class="menu-toggle" for="menu-check">
        <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.6"><path d="M3 6h18M3 12h18M3 18h18"/></svg>
      </label>
    </div>
  </div>
</header>

<main>
