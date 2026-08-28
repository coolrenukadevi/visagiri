<?php
/**
 * Authenticated dashboard shell (head + sidebar + topbar open).
 * Expects: $auth_user, $dashboard_area, $dashboard_page, optional $page_meta.
 */
require_once __DIR__ . '/dashboard-nav.php';

$page_meta = $page_meta ?? [];
$page_meta['title'] = $page_meta['title'] ?? (dashboard_area_label($dashboard_area) . ' | Paynancial');
$navItems = dashboard_nav_items($dashboard_area);
$initials = strtoupper(substr((string) ($auth_user['name'] ?? 'U'), 0, 1));
?><!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<?php seo_meta($page_meta); ?>
<link rel="icon" type="image/png" href="<?= asset('images/paynancial-icon.png') ?>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;650;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= asset('css/main.css') ?>">
<link rel="stylesheet" href="<?= asset('css/dashboard.css') ?>">
</head>
<body>
<div class="app-shell">
  <aside class="app-sidebar">
    <a href="/" class="brand"><span class="brand-mark">P</span> PAYNANCIAL</a>
    <div class="role-badge"><?= e(dashboard_area_label($dashboard_area)) ?></div>
    <nav class="side-nav">
      <?php foreach ($navItems as $item): ?>
        <a href="/<?= e($dashboard_area) ?>/<?= e($item['page']) ?>" class="<?= $dashboard_page === $item['page'] ? 'is-active' : '' ?>">
          <span class="dot"></span><?= e($item['label']) ?>
        </a>
      <?php endforeach; ?>
    </nav>
    <div class="sidebar-footer">
      <a href="/support"><span class="dot"></span>Support</a>
      <a href="#" id="logout-link"><span class="dot"></span>Logout</a>
    </div>
  </aside>

  <div class="app-main">
    <div class="app-topbar">
      <div class="flex gap-2" style="align-items:center;">
        <button class="sidebar-toggle" aria-label="Toggle menu">&#9776;</button>
        <h1><?= e($page_meta['heading'] ?? dashboard_area_label($dashboard_area)) ?></h1>
      </div>
      <div class="topbar-user">
        <span class="text-muted" style="font-size:0.85rem;"><?= e($auth_user['name'] ?? '') ?></span>
        <div class="topbar-avatar"><?= e($initials) ?></div>
      </div>
    </div>
    <div class="app-content">
