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

    // Which sidebar group (if any) the current page belongs to — used
    // to auto-expand only that one group server-side, so the sidebar
    // renders in the right state on first paint with no JS-dependent
    // flash, and still works if JS fails to load at all.
    $navGroups = [
        'forex' => ['forex-dashboard', 'forex', 'forex-rates', 'forex-country-rules', 'forex-fema-audit'],
        'content' => ['countries', 'visa-types', 'faqs', 'embassies'],
        'system' => ['users', 'audit-log', 'settings'],
    ];
    $activeGroup = null;
    foreach ($navGroups as $groupKey => $groupNavs) {
        if (in_array($activeNav, $groupNavs, true)) {
            $activeGroup = $groupKey;
            break;
        }
    }
    $isGroupOpen = static fn(string $groupKey): bool => $activeGroup === $groupKey;
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
            <?php if (has_permission('customers.view')): ?>
            <a href="/admin/customers/" class="<?= $activeNav === 'customers' ? 'is-active' : '' ?>">Customers</a>
            <?php endif; ?>
            <?php if (has_permission('partners.view')): ?>
            <a href="/admin/partners/" class="<?= $activeNav === 'partners' ? 'is-active' : '' ?>">Partners</a>
            <?php endif; ?>
            <?php if (has_permission('visa.view')): ?>
            <a href="/admin/visa-enquiries/" class="<?= $activeNav === 'visa-enquiries' ? 'is-active' : '' ?>">Visa Enquiries</a>
            <a href="/admin/visa-applications/" class="<?= $activeNav === 'visa-applications' ? 'is-active' : '' ?>">Visa Applications</a>
            <?php endif; ?>
            <?php if (has_permission('general_enquiries.view')): ?>
            <a href="/admin/general-enquiries/" class="<?= $activeNav === 'general-enquiries' ? 'is-active' : '' ?>">General &amp; Attestation Enquiries</a>
            <?php endif; ?>
            <?php if (has_permission('forex.requests.view')): ?>
            <button type="button" class="admin-sidebar__group" aria-expanded="<?= $isGroupOpen('forex') ? 'true' : 'false' ?>" aria-controls="sidebar-group-forex">Forex <?= nav_chevron_icon() ?></button>
            <div class="admin-sidebar__subgroup<?= $isGroupOpen('forex') ? ' is-open' : '' ?>" id="sidebar-group-forex">
            <a href="/admin/forex-dashboard/" class="<?= $activeNav === 'forex-dashboard' ? 'is-active' : '' ?>">Forex Dashboard</a>
            <?php if (has_permission('forex.requests.manage')): ?>
            <a href="/admin/forex-requests/?action=create" class="<?= '' ?>">New Forex Request</a>
            <?php endif; ?>
            <a href="/admin/forex-requests/?view=all" class="<?= $activeNav === 'forex' ? 'is-active' : '' ?>">All Requests</a>
            <a href="/admin/forex-requests/?view=pending_documents">Pending Documents</a>
            <a href="/admin/forex-requests/?view=quotations">Quotations</a>
            <a href="/admin/forex-requests/?view=approved">Approved Requests</a>
            <a href="/admin/forex-requests/?view=delivered">Delivered</a>
            <a href="/admin/forex-requests/?view=cancelled">Cancelled</a>
            <?php if (has_permission('forex.compliance.view')): ?>
            <a href="/admin/forex-fema-audit/">FEMA / Audit Records</a>
            <?php endif; ?>
            <?php if (has_permission('forex.rates.manage')): ?>
            <a href="/admin/forex-rates/" class="<?= $activeNav === 'forex-rates' ? 'is-active' : '' ?>">Exchange Rates</a>
            <?php endif; ?>
            <?php if (has_permission('forex.country_rules.manage')): ?>
            <a href="/admin/forex-country-rules/" class="<?= $activeNav === 'forex-country-rules' ? 'is-active' : '' ?>">Country Rules</a>
            <?php endif; ?>
            </div>
            <?php endif; ?>
            <?php if (has_permission('content.manage')): ?>
            <button type="button" class="admin-sidebar__group" aria-expanded="<?= $isGroupOpen('content') ? 'true' : 'false' ?>" aria-controls="sidebar-group-content">Content <?= nav_chevron_icon() ?></button>
            <div class="admin-sidebar__subgroup<?= $isGroupOpen('content') ? ' is-open' : '' ?>" id="sidebar-group-content">
            <a href="/admin/countries/" class="<?= $activeNav === 'countries' ? 'is-active' : '' ?>">Countries</a>
            <a href="/admin/visa-types/" class="<?= $activeNav === 'visa-types' ? 'is-active' : '' ?>">Visa Types</a>
            <a href="/admin/visa-requirements/" class="<?= $activeNav === 'visa-requirements' ? 'is-active' : '' ?>">Visa Requirements</a>
            <a href="/admin/faqs/" class="<?= $activeNav === 'faqs' ? 'is-active' : '' ?>">FAQs</a>
            <a href="/admin/embassies/" class="<?= $activeNav === 'embassies' ? 'is-active' : '' ?>">Embassies / Consulates / VACs</a>
            </div>
            <?php endif; ?>
            <?php if (has_permission('users.manage') || has_permission('settings.manage') || has_permission('audit.view')): ?>
            <button type="button" class="admin-sidebar__group" aria-expanded="<?= $isGroupOpen('system') ? 'true' : 'false' ?>" aria-controls="sidebar-group-system">System <?= nav_chevron_icon() ?></button>
            <div class="admin-sidebar__subgroup<?= $isGroupOpen('system') ? ' is-open' : '' ?>" id="sidebar-group-system">
            <?php if (has_permission('users.manage')): ?>
            <a href="/admin/users/" class="<?= $activeNav === 'users' ? 'is-active' : '' ?>">Users &amp; Roles</a>
            <?php endif; ?>
            <?php if (has_permission('audit.view')): ?>
            <a href="/admin/audit-log/" class="<?= $activeNav === 'audit-log' ? 'is-active' : '' ?>">Audit Log</a>
            <?php endif; ?>
            <?php if (has_permission('settings.manage')): ?>
            <a href="/admin/settings/" class="<?= $activeNav === 'settings' ? 'is-active' : '' ?>">Settings</a>
            <?php endif; ?>
            </div>
            <?php endif; ?>
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
<script src="<?= e(asset_url('/assets/js/admin.js')) ?>"></script>
</body>
</html>
    <?php
}
