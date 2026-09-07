<?php
declare(strict_types=1);

/**
 * Shared admin panel chrome (sidebar + header). Every admin page
 * (except login) calls require_admin_login() then admin_header_start(),
 * renders its own content, then admin_header_end(). The sidebar only
 * ever shows "Dashboard" — that page is the single command center
 * (a tile per business module); everything a module needs beyond its
 * own tile is reached via admin_subnav() calls inside that module's
 * own pages, not a global sidebar tree.
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

/**
 * Named groups of related module pages, each keyed by its own module's
 * home page ('href' + label) plus a permission gate — mirrors the
 * sidebar's old grouping exactly, now rendered as an in-page tab strip
 * on the module's own pages instead of a global sidebar tree. Call
 * admin_subnav() right after admin_header_start() on any page whose
 * $activeNav appears in one of these groups' items.
 */
const ADMIN_SUBNAV_GROUPS = [
    'partners' => [
        ['nav' => 'partners', 'label' => 'Referral Partners', 'href' => '/admin/partners/', 'permission' => 'partners.view'],
        ['nav' => 'partner-tiers', 'label' => 'Partner Tiers', 'href' => '/admin/partner-tiers/', 'permission' => 'partners.manage'],
        ['nav' => 'partner-invoices', 'label' => 'Partner Invoices', 'href' => '/admin/partner-invoices/', 'permission' => 'partners.manage'],
        ['nav' => 'partner-document-expiry', 'label' => 'Document Expiry', 'href' => '/admin/partner-document-expiry/', 'permission' => 'partners.view'],
        ['nav' => 'partner-enquiries', 'label' => 'Partner Enquiries', 'href' => '/admin/partner-enquiries/', 'permission' => 'partners.view'],
    ],
    'b2b' => [
        ['nav' => 'b2b-partners', 'label' => 'B2B Partners', 'href' => '/admin/b2b-partners/', 'permission' => 'b2b_travel_partners.view'],
        ['nav' => 'b2b-enquiries', 'label' => 'B2B Visa Enquiries', 'href' => '/admin/b2b-enquiries/', 'permission' => 'b2b_travel_partners.view'],
        ['nav' => 'b2b-support-tickets', 'label' => 'B2B Support Tickets', 'href' => '/admin/b2b-support-tickets/', 'permission' => 'b2b_travel_partners.view'],
    ],
    'leads' => [
        ['nav' => 'sales-crm', 'label' => 'Sales CRM', 'href' => '/admin/sales-crm/', 'permission' => null],
        ['nav' => 'enquiries', 'label' => 'Enquiries (Visa + Apostille)', 'href' => '/admin/enquiries/', 'permission' => 'enquiries.view'],
        ['nav' => 'visa-enquiries', 'label' => 'Visa Enquiries (Legacy)', 'href' => '/admin/visa-enquiries/', 'permission' => 'visa.view'],
        ['nav' => 'general-enquiries', 'label' => 'General &amp; Attestation Enquiries', 'href' => '/admin/general-enquiries/', 'permission' => 'general_enquiries.view'],
    ],
    'forex' => [
        ['nav' => 'forex-dashboard', 'label' => 'Forex Dashboard', 'href' => '/admin/forex-dashboard/', 'permission' => 'forex.requests.view'],
        ['nav' => 'forex', 'label' => 'All Requests', 'href' => '/admin/forex-requests/?view=all', 'permission' => 'forex.requests.view'],
        ['nav' => 'forex-rates', 'label' => 'Exchange Rates', 'href' => '/admin/forex-rates/', 'permission' => 'forex.rates.manage'],
        ['nav' => 'forex-country-rules', 'label' => 'Country Rules', 'href' => '/admin/forex-country-rules/', 'permission' => 'forex.country_rules.manage'],
        ['nav' => 'forex-fema-audit', 'label' => 'FEMA / Audit Records', 'href' => '/admin/forex-fema-audit/', 'permission' => 'forex.compliance.view'],
    ],
    'content' => [
        ['nav' => 'countries', 'label' => 'Countries', 'href' => '/admin/countries/', 'permission' => 'content.manage'],
        ['nav' => 'visa-types', 'label' => 'Visa Types', 'href' => '/admin/visa-types/', 'permission' => 'content.manage'],
        ['nav' => 'visa-requirements', 'label' => 'Visa Requirements', 'href' => '/admin/visa-requirements/', 'permission' => 'content.manage'],
        ['nav' => 'faqs', 'label' => 'FAQs', 'href' => '/admin/faqs/', 'permission' => 'content.manage'],
        ['nav' => 'embassies', 'label' => 'Embassies / Consulates / VACs', 'href' => '/admin/embassies/', 'permission' => 'content.manage'],
        ['nav' => 'locations', 'label' => 'Locations (States/Cities)', 'href' => '/admin/locations/', 'permission' => 'content.manage'],
    ],
    'system' => [
        ['nav' => 'users', 'label' => 'Users', 'href' => '/admin/users/', 'permission' => 'users.manage'],
        ['nav' => 'roles', 'label' => 'Roles &amp; Permissions', 'href' => '/admin/roles/', 'permission' => 'users.manage'],
        ['nav' => 'audit-log', 'label' => 'Audit Log', 'href' => '/admin/audit-log/', 'permission' => 'audit.view'],
        ['nav' => 'settings', 'label' => 'Settings', 'href' => '/admin/settings/', 'permission' => 'settings.manage'],
        ['nav' => 'mail-log', 'label' => 'Mail Log', 'href' => '/admin/mail-log/', 'permission' => 'settings.manage'],
        ['nav' => 'recycle-bin', 'label' => 'Recycle Bin', 'href' => '/admin/recycle-bin/', 'permission' => 'recycle_bin.manage'],
    ],
];

/** Renders a small pill-tab strip of related module pages. Call right after admin_header_start(). */
function admin_subnav(string $groupKey, string $activeNav): void
{
    $items = ADMIN_SUBNAV_GROUPS[$groupKey] ?? [];
    $items = array_filter($items, static fn(array $item): bool => $item['permission'] === null || has_permission($item['permission']));
    if (count($items) < 2) {
        return;
    }
    ?>
    <div class="admin-toolbar" style="margin-bottom:var(--space-5)">
        <?php foreach ($items as $item): ?>
        <a href="<?= e($item['href']) ?>" class="btn btn-sm <?= $item['nav'] === $activeNav ? 'btn-primary' : 'btn-outline' ?>"><?= $item['label'] ?></a>
        <?php endforeach; ?>
    </div>
    <?php
}
