<?php
declare(strict_types=1);

/**
 * Shared admin panel chrome (sidebar + header). Every admin page
 * (except login) calls require_admin_login() then admin_header_start(),
 * renders its own content, then admin_header_end().
 *
 * Sidebar architecture is the Visagiri CMS Blueprint's fixed Module →
 * Submenu grouping (see ADMIN_NAV_GROUPS below) — every group and item
 * name here must match that blueprint exactly; do not invent or rename
 * groups here. "Child Menu / Function" items from the blueprint (e.g.
 * Sales CRM's "Visa Enquiries" / "Apostille Enquiries" / "Unassigned
 * Queue") live as in-page tab-strips via admin_subnav(), not as a
 * third sidebar level — keeps the sidebar scannable at a glance.
 */

/**
 * Module → Submenu, matching the CMS blueprint's sidebar architecture
 * 1:1. Each item's `nav` key matches admin_header_start()'s $activeNav
 * so the correct row highlights; `permission` gates visibility exactly
 * like every other permission check in this app (server-side, not
 * just a hidden link) — null means "always visible once logged in".
 * `builtHref` false renders the item as a disabled "Coming soon" row
 * instead of a link — used only for blueprint items with no page
 * built yet (Reports & Analytics, Automation), never to fake a
 * finished feature.
 */
const ADMIN_NAV_GROUPS = [
    'Sales & Customers' => [
        ['nav' => 'sales-crm', 'label' => 'Sales CRM', 'href' => '/admin/sales-crm/', 'permission' => null],
        ['nav' => 'customers', 'label' => 'Customers', 'href' => '/admin/customers/', 'permission' => 'customers.view'],
    ],
    'Operations' => [
        ['nav' => 'visa-applications', 'label' => 'Visa Operations', 'href' => '/admin/visa-applications/', 'permission' => 'visa.view'],
        ['nav' => 'apostille', 'label' => 'Apostille &amp; Attestation', 'href' => '/admin/enquiries/?category=apostille', 'permission' => 'enquiries.view'],
        ['nav' => 'forex-dashboard', 'label' => 'Forex', 'href' => '/admin/forex-dashboard/', 'permission' => 'forex.requests.view'],
    ],
    'Finance' => [
        ['nav' => 'finance', 'label' => 'Finance', 'href' => '/admin/finance/', 'permission' => null, 'permissionAny' => ['partners.manage', 'forex.requests.view']],
    ],
    'People' => [
        ['nav' => 'hrms', 'label' => 'HRMS', 'href' => '/hrms/dashboard/', 'permission' => null],
    ],
    'Customer Support' => [
        ['nav' => 'grievances', 'label' => 'Grievances', 'href' => '/admin/grievances/', 'permission' => 'grievances.view'],
        ['nav' => 'mail-log', 'label' => 'Communications', 'href' => '/admin/mail-log/', 'permission' => 'settings.manage'],
    ],
    'Content' => [
        ['nav' => 'countries', 'label' => 'Content / CMS', 'href' => '/admin/countries/', 'permission' => 'content.view'],
    ],
    'Insights' => [
        ['nav' => 'reports', 'label' => 'Reports &amp; Analytics', 'href' => null, 'permission' => null, 'builtHref' => false],
        ['nav' => 'automation', 'label' => 'Automation', 'href' => null, 'permission' => null, 'builtHref' => false],
    ],
    'System' => [
        ['nav' => 'users', 'label' => 'System Settings', 'href' => '/admin/users/', 'permission' => null, 'permissionAny' => ['users.manage', 'settings.manage']],
        ['nav' => 'audit-log', 'label' => 'Audit Log', 'href' => '/admin/audit-log/', 'permission' => 'audit.view'],
        ['nav' => 'recycle-bin', 'label' => 'Recycle Bin', 'href' => '/admin/recycle-bin/', 'permission' => 'recycle_bin.manage'],
    ],
];

/** True if this nav item should render for the current admin — mirrors has_permission()/is_admin_logged_in() exactly, never a client-side-only hide. */
function admin_nav_item_visible(array $item): bool
{
    if (isset($item['permissionAny'])) {
        foreach ($item['permissionAny'] as $perm) {
            if (has_permission($perm)) {
                return true;
            }
        }
        return false;
    }
    return $item['permission'] === null || has_permission($item['permission']);
}

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
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin-dashboard.css')) ?>">
</head>
<body class="admin-body">
<div class="admin-shell">
    <button type="button" class="btn btn-sm btn-outline admin-mobile-nav-toggle" id="admin-mobile-nav-toggle" aria-label="Open menu" aria-expanded="false" aria-controls="admin-sidebar" style="position:fixed;top:var(--space-3);left:var(--space-3);z-index:60;">
        <svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" aria-hidden="true"><path d="M3 5h14M3 10h14M3 15h14"/></svg>
    </button>
    <aside class="admin-sidebar" id="admin-sidebar">
        <div class="admin-sidebar__brand">VISA<span>GIRI</span> <small>Admin</small></div>
        <nav class="admin-sidebar__nav">
            <a href="/admin/dashboard/" class="<?= $activeNav === 'dashboard' ? 'is-active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" aria-hidden="true"><rect x="3" y="3" width="6" height="6" rx="1"/><rect x="11" y="3" width="6" height="6" rx="1"/><rect x="3" y="11" width="6" height="6" rx="1"/><rect x="11" y="11" width="6" height="6" rx="1"/></svg>
                Dashboard
            </a>
            <?php foreach (ADMIN_NAV_GROUPS as $groupLabel => $items):
                $visibleItems = array_filter($items, 'admin_nav_item_visible');
                if (!$visibleItems) {
                    continue;
                }
                $groupKey = 'navgroup-' . strtolower(str_replace([' ', '&', '/'], ['-', 'and', ''], $groupLabel));
                $groupHasActive = (bool) array_filter($visibleItems, static fn(array $i): bool => $i['nav'] === $activeNav);
            ?>
            <div class="admin-nav-group" data-group-key="<?= e($groupKey) ?>">
                <button type="button" class="admin-nav-group__toggle" data-nav-group-toggle="<?= e($groupKey) ?>" aria-expanded="true">
                    <span><?= e($groupLabel) ?></span>
                    <svg class="admin-nav-group__chevron" width="12" height="12" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 7l5 5 5-5"/></svg>
                </button>
                <div class="admin-nav-group__items">
                    <?php foreach ($visibleItems as $item): ?>
                        <?php if (($item['builtHref'] ?? true) === false): ?>
                        <span class="is-disabled" title="Coming soon" style="opacity:.45;cursor:default;padding:var(--space-2) var(--space-5) var(--space-2) calc(var(--space-5) + var(--space-3));color:rgba(255,255,255,0.6);font-size:var(--font-size-sm);display:flex;align-items:center;justify-content:space-between;">
                            <?= $item['label'] ?>
                            <span class="admin-nav-group__badge" style="background:rgba(255,255,255,0.15);color:rgba(255,255,255,0.7);">Soon</span>
                        </span>
                        <?php else: ?>
                        <a href="<?= e($item['href']) ?>" class="<?= $item['nav'] === $activeNav ? 'is-active' : '' ?>"><?= $item['label'] ?></a>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </nav>
        <button type="button" class="admin-sidebar__collapse-all" id="admin-sidebar-collapse-all">Collapse all groups</button>
        <div class="admin-sidebar__footer">
            <a href="/" target="_blank" rel="noopener">View site &rarr;</a>
        </div>
    </aside>
    <div class="admin-main">
        <header class="admin-topbar">
            <h1><?= e($pageTitle) ?></h1>
            <button type="button" class="admin-topbar__search" id="admin-cmdk-trigger" style="cursor:pointer;">
                <svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" aria-hidden="true"><circle cx="9" cy="9" r="6"/><path d="M17 17L13.5 13.5"/></svg>
                <span style="color:var(--text-muted);">Search enquiries, customers, passports, documents&hellip;</span>
                <span class="admin-cmdk__hint" style="margin-left:auto;">Ctrl K</span>
            </button>
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

<div class="admin-cmdk-backdrop" id="admin-cmdk-backdrop">
    <div class="admin-cmdk" role="dialog" aria-modal="true" aria-label="Global search">
        <form method="get" action="/admin/search/" class="admin-cmdk__input-row">
            <svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" aria-hidden="true"><circle cx="9" cy="9" r="6"/><path d="M17 17L13.5 13.5"/></svg>
            <input type="search" name="q" id="admin-cmdk-input" placeholder="Search customer, mobile, email, passport, enquiry ID, application ID, employee&hellip;" aria-label="Global search" autocomplete="off">
            <span class="admin-cmdk__hint">Esc</span>
        </form>
        <div class="admin-cmdk__results">
            <p class="admin-cmdk__empty">Type to search, then press Enter — results respect your permissions, same as every list page.</p>
        </div>
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
        ['nav' => 'countries', 'label' => 'Countries', 'href' => '/admin/countries/', 'permission' => 'content.view'],
        ['nav' => 'visa-types', 'label' => 'Visa Types', 'href' => '/admin/visa-types/', 'permission' => 'content.view'],
        ['nav' => 'visa-requirements', 'label' => 'Visa Requirements', 'href' => '/admin/visa-requirements/', 'permission' => 'content.view'],
        ['nav' => 'visa-checklists', 'label' => 'Visa Checklists', 'href' => '/admin/visa-checklists/', 'permission' => 'content.view'],
        ['nav' => 'faqs', 'label' => 'FAQs', 'href' => '/admin/faqs/', 'permission' => 'content.view'],
        ['nav' => 'embassies', 'label' => 'Embassies / Consulates / VACs', 'href' => '/admin/embassies/', 'permission' => 'content.view'],
        ['nav' => 'locations', 'label' => 'Locations (States/Cities)', 'href' => '/admin/locations/', 'permission' => 'content.view'],
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
