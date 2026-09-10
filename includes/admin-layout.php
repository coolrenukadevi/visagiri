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
            <form method="get" action="/admin/search/" class="admin-topbar__search" role="search">
                <button type="submit" aria-label="Search">
                    <svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" aria-hidden="true"><circle cx="9" cy="9" r="6"/><path d="M17 17L13.5 13.5"/></svg>
                </button>
                <input type="search" name="q" placeholder="Search enquiries, customers, partners…" aria-label="Global search">
            </form>
            <div class="admin-topbar__right">
                <?php $unreadNotifCount = admin_unread_notification_count((int) $admin['id']); ?>
                <div class="admin-bell">
                    <button type="button" class="admin-bell__trigger" id="admin-bell-trigger" aria-haspopup="true" aria-expanded="false" aria-controls="admin-bell-menu" aria-label="Notifications">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 8C5 5.2 7.2 3 10 3S15 5.2 15 8V11.5L16.5 14H3.5L5 11.5Z"/><path d="M8.2 14.5C8.2 15.6 9 16.5 10 16.5S11.8 15.6 11.8 14.5"/></svg>
                        <span class="admin-bell__badge" id="admin-bell-badge"<?= $unreadNotifCount > 0 ? '' : ' hidden' ?>><?= $unreadNotifCount > 99 ? '99+' : $unreadNotifCount ?></span>
                    </button>
                    <div class="admin-bell__menu" id="admin-bell-menu">
                        <div class="admin-bell__menu-header">
                            <span>Notifications</span>
                            <?php if ($unreadNotifCount > 0): ?>
                            <form method="post" action="/admin/notifications/"><?= csrf_field() ?><input type="hidden" name="form" value="mark_all_read"><button type="submit" class="admin-bell__mark-all">Mark all as read</button></form>
                            <?php endif; ?>
                        </div>
                        <div class="admin-bell__list">
                            <?php $recentNotifs = admin_recent_notifications((int) $admin['id'], 6); ?>
                            <?php if (!$recentNotifs): ?>
                            <p class="admin-bell__empty">No notifications yet.</p>
                            <?php else: foreach ($recentNotifs as $n): ?>
                            <form method="post" action="/admin/notifications/" class="admin-bell__item<?= $n['is_read'] ? '' : ' is-unread' ?>">
                                <?= csrf_field() ?>
                                <input type="hidden" name="form" value="open">
                                <input type="hidden" name="notification_id" value="<?= (int) $n['id'] ?>">
                                <button type="submit">
                                    <span class="admin-bell__item-title"><?= e($n['title']) ?></span>
                                    <span class="admin-bell__item-time"><?= e(date('d M, H:i', strtotime($n['created_at']))) ?></span>
                                </button>
                            </form>
                            <?php endforeach; endif; ?>
                        </div>
                        <a href="/admin/notifications/" class="admin-bell__view-all">View All Notifications</a>
                    </div>
                </div>

                <div class="admin-profile">
                    <button type="button" class="admin-profile__trigger" id="admin-profile-trigger" aria-haspopup="true" aria-expanded="false" aria-controls="admin-profile-menu">
                        <span class="admin-profile__avatar"><?= e(admin_initials($admin['full_name'] ?? '')) ?></span>
                        <span><?= e($admin['full_name'] ?? '') ?></span>
                        <?= nav_chevron_icon() ?>
                    </button>
                    <div class="admin-profile__menu" id="admin-profile-menu">
                        <div class="admin-profile__menu-header">
                            <div class="admin-profile__menu-name"><?= e($admin['full_name'] ?? '') ?></div>
                            <div class="admin-profile__menu-role"><?= e($admin['role_name'] ?? '') ?></div>
                        </div>
                        <a href="/admin/profile/">My Profile</a>
                        <?php if (has_permission('settings.manage')): ?>
                        <a href="/admin/settings/">Settings</a>
                        <?php endif; ?>
                        <form method="post" action="/admin/logout/"><?= csrf_field() ?><button type="submit">Logout</button></form>
                    </div>
                </div>
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
        ['nav' => 'reminders', 'label' => 'Reminders', 'href' => '/admin/reminders/', 'permission' => 'reminders.manage'],
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
        ['nav' => 'login-audit', 'label' => 'Login Audit', 'href' => '/admin/login-audit/', 'permission' => 'audit.view'],
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
