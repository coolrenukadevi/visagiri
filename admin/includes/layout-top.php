<?php
/**
 * Shared CRM shell: <head>, sidebar, topbar. Pages set $ADMIN_PAGE_TITLE and
 * $ADMIN_ACTIVE_NAV before including this, then close with layout-bottom.php.
 */
require_once __DIR__ . '/admin-auth.php';
require_once __DIR__ . '/../../includes/forex-db.php';
require_once __DIR__ . '/forex-permissions.php';
require_once __DIR__ . '/../../includes/b2b-db.php';
require_once __DIR__ . '/b2b-permissions.php';
require_once __DIR__ . '/../../includes/b2b-csrf.php';
admin_require_login();

$pdo = enquiry_db();
forex_db();
b2b_db();
$stmt = $pdo->prepare('SELECT COUNT(*) FROM notifications WHERE is_read = 0 AND (user_id IS NULL OR user_id = ?)');
$stmt->execute([admin_user_id()]);
$unreadCount = (int) $stmt->fetchColumn();

$ADMIN_ACTIVE_NAV = $ADMIN_ACTIVE_NAV ?? '';
$ADMIN_PAGE_TITLE = $ADMIN_PAGE_TITLE ?? 'CRM';
$ADMIN_BREADCRUMB = $ADMIN_BREADCRUMB ?? ['CRM'];

$navItems = [
    ['key' => 'dashboard', 'label' => 'Dashboard', 'icon' => 'gauge-high', 'href' => 'index.php'],
    ['key' => 'enquiries', 'label' => 'Enquiries', 'icon' => 'inbox', 'href' => 'enquiries.php'],
    ['key' => 'my-enquiries', 'label' => 'My Enquiries', 'icon' => 'user-check', 'href' => 'enquiries.php?mine=1'],
    ['key' => 'followups', 'label' => 'Follow-ups', 'icon' => 'phone-volume', 'href' => 'followups.php'],
    ['key' => 'applications', 'label' => 'Visa Applications', 'icon' => 'passport', 'href' => 'applications.php'],
    ['key' => 'customers', 'label' => 'Customers', 'icon' => 'users', 'href' => 'customers.php'],
    ['key' => 'documents', 'label' => 'Documents', 'icon' => 'folder-open', 'href' => 'documents.php'],
    ['key' => 'payments', 'label' => 'Payments', 'icon' => 'credit-card', 'href' => 'payments.php', 'roles' => ['Super Admin', 'Admin', 'Accounts']],
    ['key' => 'reports', 'label' => 'Reports', 'icon' => 'chart-line', 'href' => 'reports.php', 'roles' => ['Super Admin', 'Admin', 'Sales Manager']],
    ['key' => 'team', 'label' => 'Team Management', 'icon' => 'people-group', 'href' => 'team.php', 'roles' => ['Super Admin']],
    ['key' => 'countries', 'label' => 'Countries', 'icon' => 'earth-americas', 'href' => 'countries.php'],
    ['key' => 'visa-pages', 'label' => 'Content Pages', 'icon' => 'file-lines', 'href' => 'visa-pages.php'],
    ['key' => 'visa-types', 'label' => 'Visa Types', 'icon' => 'stamp', 'href' => 'visa-types.php'],

    ['section' => 'Forex'],
    ['key' => 'forex-dashboard', 'label' => 'Forex Dashboard', 'icon' => 'gauge-high', 'href' => 'forex-dashboard.php'],
    ['key' => 'forex-new', 'label' => 'New Forex Request', 'icon' => 'plus', 'href' => 'forex-request-new.php'],
    ['key' => 'forex-all', 'label' => 'All Requests', 'icon' => 'money-bill-transfer', 'href' => 'forex-requests.php'],
    ['key' => 'forex-pending-docs', 'label' => 'Pending Documents', 'icon' => 'file-circle-exclamation', 'href' => 'forex-documents.php'],
    ['key' => 'forex-quotations', 'label' => 'Quotations', 'icon' => 'file-invoice-dollar', 'href' => 'forex-quotations.php'],
    ['key' => 'forex-approved', 'label' => 'Approved Requests', 'icon' => 'circle-check', 'href' => 'forex-requests.php?status=Approved+for+Processing'],
    ['key' => 'forex-delivered', 'label' => 'Delivered', 'icon' => 'hand-holding-dollar', 'href' => 'forex-requests.php?status=Delivered'],
    ['key' => 'forex-cancelled', 'label' => 'Cancelled', 'icon' => 'ban', 'href' => 'forex-requests.php?status=Cancelled'],
    ['key' => 'forex-audit', 'label' => 'FEMA / Audit Records', 'icon' => 'shield-alt', 'href' => 'forex-audit.php', 'roles' => ['Super Admin', 'Forex Manager', 'Compliance / Audit']],
    ['key' => 'forex-reports', 'label' => 'Reports', 'icon' => 'chart-pie', 'href' => 'forex-reports.php'],
    ['key' => 'forex-country-rules', 'label' => 'Country Rules', 'icon' => 'gavel', 'href' => 'forex-country-rules.php', 'roles' => ['Super Admin', 'Forex Manager', 'Compliance / Audit']],
    ['key' => 'forex-rates', 'label' => 'Rates', 'icon' => 'coins', 'href' => 'forex-rates.php', 'roles' => ['Super Admin', 'Forex Manager']],
    ['key' => 'forex-declaration-templates', 'label' => 'Declaration Templates', 'icon' => 'file-contract', 'href' => 'forex-declaration-templates.php', 'roles' => ['Super Admin', 'Forex Manager']],
    ['key' => 'forex-settings', 'label' => 'Forex Settings', 'icon' => 'sliders', 'href' => 'forex-settings.php', 'roles' => ['Super Admin', 'Forex Manager']],

    ['section' => 'B2B Partners'],
    ['key' => 'b2b-partners', 'label' => 'Partner Applications', 'icon' => 'building', 'href' => 'b2b-partners.php'],
    ['key' => 'b2b-documents', 'label' => 'Document Verification', 'icon' => 'file-check', 'href' => 'b2b-documents.php', 'roles' => ['Super Admin', 'B2B Admin', 'B2B Relationship Manager']],
    ['key' => 'b2b-quotations', 'label' => 'Quotations', 'icon' => 'file-invoice-dollar', 'href' => 'b2b-quotations.php', 'roles' => ['Super Admin', 'B2B Admin', 'B2B Relationship Manager', 'Visa Consultant']],
    ['key' => 'b2b-invoices', 'label' => 'Invoices &amp; Payments', 'icon' => 'file-invoice', 'href' => 'b2b-invoices.php', 'roles' => ['Super Admin', 'B2B Admin', 'Accounts']],
    ['key' => 'b2b-tiers', 'label' => 'Tiers &amp; Pricing', 'icon' => 'layer-group', 'href' => 'b2b-tiers.php', 'roles' => ['Super Admin', 'B2B Admin']],
    ['key' => 'b2b-announcements', 'label' => 'Announcements', 'icon' => 'bullhorn', 'href' => 'b2b-announcements.php', 'roles' => ['Super Admin', 'B2B Admin']],
    ['key' => 'b2b-reports', 'label' => 'Partner Reports', 'icon' => 'chart-column', 'href' => 'b2b-reports.php'],
    ['key' => 'b2b-audit', 'label' => 'Audit Log', 'icon' => 'shield-alt', 'href' => 'b2b-audit.php', 'roles' => ['Super Admin', 'B2B Admin', 'Compliance / Audit']],
    ['key' => 'b2b-settings', 'label' => 'B2B Settings', 'icon' => 'sliders', 'href' => 'b2b-settings.php', 'soon' => true, 'roles' => ['Super Admin', 'B2B Admin']],

    ['section' => 'Marketing'],
    ['key' => 'newsletter', 'label' => 'Newsletter Subscribers', 'icon' => 'envelope-open-text', 'href' => 'newsletter.php', 'roles' => ['Super Admin', 'Admin', 'Sales Manager']],
    ['key' => 'enquiry-analytics', 'label' => 'Get Assistance Analytics', 'icon' => 'chart-line', 'href' => 'enquiry-analytics.php', 'roles' => ['Super Admin', 'Admin', 'Sales Manager']],

    ['key' => 'settings', 'label' => 'Settings', 'icon' => 'gear', 'href' => 'settings.php'],
];
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<meta name="b2b-csrf-token" content="<?php echo htmlspecialchars(b2b_csrf_token()); ?>">
<title><?php echo htmlspecialchars($ADMIN_PAGE_TITLE); ?> &ndash; Visa Agency CRM</title>
<link rel="stylesheet" href="../assets/css/all.min.css">
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="crm-shell">
    <button type="button" class="crm-sidebar-toggle" id="crmSidebarToggle" aria-label="Toggle menu"><i class="fa-solid fa-bars"></i></button>
    <div class="crm-sidebar" id="crmSidebar">
        <div class="crm-brand">
            <img src="../assets/img/logo/white-logo.svg" alt="Visa Agency">
        </div>
        <nav class="crm-nav">
            <?php foreach ($navItems as $item): ?>
                <?php if (isset($item['section'])): ?>
                <div class="crm-nav-section"><?php echo htmlspecialchars($item['section']); ?></div>
                <?php continue; ?>
                <?php endif; ?>
                <?php if (!empty($item['roles']) && !in_array(admin_role(), $item['roles'], true)) continue; ?>
                <?php if (!empty($item['soon'])): ?>
                <span class="crm-nav-item is-soon" title="Coming in a later phase">
                    <i class="fa-solid fa-<?php echo $item['icon']; ?>"></i> <?php echo $item['label']; ?>
                    <span class="crm-soon-pill">Soon</span>
                </span>
                <?php else: ?>
                <a href="<?php echo $item['href']; ?>" class="crm-nav-item <?php echo $ADMIN_ACTIVE_NAV === $item['key'] ? 'active' : ''; ?>">
                    <i class="fa-solid fa-<?php echo $item['icon']; ?>"></i> <?php echo $item['label']; ?>
                </a>
                <?php endif; ?>
            <?php endforeach; ?>
        </nav>
        <div class="crm-sidebar-user">
            <div class="crm-user-avatar"><?php echo strtoupper(substr(admin_name(), 0, 1)); ?></div>
            <div class="crm-user-meta">
                <div class="crm-user-name"><?php echo htmlspecialchars(admin_name()); ?></div>
                <div class="crm-user-role"><?php echo htmlspecialchars(admin_role()); ?></div>
            </div>
            <a href="logout.php" class="crm-user-logout" title="Log out"><i class="fa-solid fa-right-from-bracket"></i></a>
        </div>
    </div>

    <div class="crm-main">
        <div class="crm-topbar">
            <div class="crm-breadcrumb">
                <?php echo implode(' <i class="fa-solid fa-chevron-right"></i> ', array_map('htmlspecialchars', $ADMIN_BREADCRUMB)); ?>
            </div>
            <div class="crm-global-search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="crmGlobalSearch" placeholder="Search enquiry, customer, passport no., phone, email...">
                <div class="crm-search-results" id="crmSearchResults" hidden></div>
            </div>
            <div class="crm-topbar-actions">
                <a href="enquiries.php?new=1" class="crm-icon-btn" title="Quick Add"><i class="fa-solid fa-plus"></i></a>
                <button type="button" class="crm-icon-btn" id="crmNotifBtn" title="Notifications">
                    <i class="fa-solid fa-bell"></i>
                    <?php if ($unreadCount > 0): ?><span class="crm-badge"><?php echo min($unreadCount, 99); ?></span><?php endif; ?>
                </button>
                <div class="crm-notif-panel" id="crmNotifPanel" hidden></div>
                <div class="crm-topbar-user">
                    <div class="crm-user-avatar small"><?php echo strtoupper(substr(admin_name(), 0, 1)); ?></div>
                </div>
            </div>
        </div>
        <div class="crm-content">
