<?php
declare(strict_types=1);

/**
 * Shared admin panel chrome (sidebar + header). Every admin page
 * (except login) calls require_admin_login() then admin_header_start(),
 * renders its own content, then admin_header_end().
 */

function admin_header_start(string $pageTitle, string $activeNav): void
{
    $admin = current_admin();
    ?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?> · Visagiri Admin</title>
<meta name="robots" content="noindex, nofollow">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/tokens.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin.css')) ?>">
</head>
<body class="admin-body">
<div class="admin-shell">
    <aside class="admin-sidebar">
        <div class="admin-sidebar__brand">VISA<span>GIRI</span> <small>Admin</small></div>
        <nav class="admin-sidebar__nav">
            <a href="/admin/dashboard/" class="<?= $activeNav === 'dashboard' ? 'is-active' : '' ?>">Dashboard</a>
            <a href="/admin/countries/" class="<?= $activeNav === 'countries' ? 'is-active' : '' ?>">Countries</a>
            <a href="/admin/visa-types/" class="<?= $activeNav === 'visa-types' ? 'is-active' : '' ?>">Visa Types</a>
            <a href="/admin/visa-requirements/" class="<?= $activeNav === 'countries' ? '' : '' ?>">Visa Requirements</a>
            <a href="/admin/faqs/" class="<?= $activeNav === 'faqs' ? 'is-active' : '' ?>">FAQs</a>
            <a href="/admin/embassies/" class="<?= $activeNav === 'embassies' ? 'is-active' : '' ?>">Embassies / Consulates / VACs</a>
            <a href="/admin/enquiries/" class="<?= $activeNav === 'enquiries' ? 'is-active' : '' ?>">Enquiries</a>
            <a href="/admin/contact-messages/" class="<?= $activeNav === 'contact-messages' ? 'is-active' : '' ?>">Contact Messages</a>
            <a href="/admin/settings/" class="<?= $activeNav === 'settings' ? 'is-active' : '' ?>">Settings</a>
        </nav>
        <div class="admin-sidebar__footer">
            <a href="/" target="_blank" rel="noopener">View site &rarr;</a>
        </div>
    </aside>
    <div class="admin-main">
        <header class="admin-topbar">
            <h1><?= e($pageTitle) ?></h1>
            <div class="admin-topbar__account">
                <span><?= e($admin['full_name'] ?? '') ?></span>
                <form method="post" action="/admin/logout/" style="display:contents"><?= csrf_field() ?><button type="submit" class="btn btn-outline btn-sm">Logout</button></form>
            </div>
        </header>
        <main class="admin-content">
    <?php
    $flash = flash_get('admin_notice');
    if ($flash) {
        echo '<div class="alert alert-success">' . e($flash) . '</div>';
    }
    $flashError = flash_get('admin_error');
    if ($flashError) {
        echo '<div class="alert alert-danger">' . e($flashError) . '</div>';
    }
}

function admin_header_end(): void
{
    ?>
        </main>
    </div>
</div>
</body>
</html>
    <?php
}
