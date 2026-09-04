<?php
/**
 * Shared B2B partner portal shell: <head>, sidebar, topbar. Mirrors the
 * structure of admin/includes/layout-top.php (own minimal <head>, not the
 * full public marketing asset bundle) but branded and scoped for partners
 * — separate session (partner-auth.php), separate nav, separate .pp-*
 * CSS classes in assets/css/custom.css so nothing here can be confused
 * with the internal staff CRM.
 *
 * Pages set $PP_PAGE_TITLE and $PP_ACTIVE_NAV before including this, then
 * close with partner-layout-bottom.php.
 */
require_once __DIR__ . '/partner-auth.php';
require_once __DIR__ . '/b2b-csrf.php';
partner_require_login();

$pdo = b2b_db();
$stmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ?');
$stmt->execute([partner_id()]);
$ppPartner = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$ppPartner) {
    partner_logout();
    header('Location: b2b-login.php');
    exit;
}

$PP_ACTIVE_NAV = $PP_ACTIVE_NAV ?? '';
$PP_PAGE_TITLE = $PP_PAGE_TITLE ?? 'Partner Dashboard';

$ppUnreadStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_partner_notifications WHERE partner_id = ? AND is_read = 0');
$ppUnreadStmt->execute([partner_id()]);
$ppUnreadCount = (int) $ppUnreadStmt->fetchColumn();

$ppNavItems = [
    ['key' => 'dashboard', 'label' => 'Dashboard', 'icon' => 'gauge-high', 'href' => 'b2b-dashboard.php'],
    ['key' => 'applications', 'label' => 'Visa Applications', 'icon' => 'passport', 'href' => 'b2b-applications.php', 'permission' => 'view_applications'],
    ['key' => 'quotations', 'label' => 'Quotations', 'icon' => 'file-invoice-dollar', 'href' => 'b2b-quotations.php', 'permission' => 'view_quotations'],
    ['key' => 'invoices', 'label' => 'Invoices &amp; Payments', 'icon' => 'file-invoice', 'href' => 'b2b-invoices.php', 'permission' => 'view_invoices'],
    ['key' => 'wallet', 'label' => 'Wallet &amp; Credit', 'icon' => 'wallet', 'href' => 'b2b-wallet.php', 'permission' => 'view_payments'],
    ['key' => 'documents', 'label' => 'Documents', 'icon' => 'folder-open', 'href' => 'b2b-documents-partner.php', 'soon' => true],
    ['key' => 'messages', 'label' => 'Messages', 'icon' => 'comments', 'href' => 'b2b-messages.php'],
    ['key' => 'team', 'label' => 'Team Management', 'icon' => 'people-group', 'href' => 'b2b-team.php', 'permission' => 'manage_users'],
    ['key' => 'reports', 'label' => 'Reports', 'icon' => 'chart-line', 'href' => 'b2b-reports-partner.php'],
    ['key' => 'profile', 'label' => 'Company Profile', 'icon' => 'building', 'href' => 'b2b-profile.php'],
    ['key' => 'support', 'label' => 'Support', 'icon' => 'headset', 'href' => 'b2b-support.php', 'soon' => true],
];
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<meta name="b2b-csrf-token" content="<?php echo htmlspecialchars(b2b_csrf_token()); ?>">
<title><?php echo htmlspecialchars($PP_PAGE_TITLE); ?> &ndash; VisaAgency.in B2B Partner Portal</title>
<link rel="shortcut icon" href="assets/img/favicon.png">
<link rel="stylesheet" href="assets/css/all.min.css">
<link rel="stylesheet" href="assets/css/custom.css">
</head>
<body>
<div class="pp-shell">
    <button type="button" class="pp-sidebar-toggle" id="ppSidebarToggle" aria-label="Toggle menu"><i class="fa-solid fa-bars"></i></button>
    <div class="pp-sidebar" id="ppSidebar">
        <div class="pp-brand">
            <img src="assets/img/logo/visaagency-logo-dark.png" alt="Visa Agency">
            <span>B2B Partner Portal</span>
        </div>
        <nav class="pp-nav">
            <?php foreach ($ppNavItems as $item): ?>
                <?php if (!empty($item['permission']) && !partner_has_permission($item['permission'])) continue; ?>
                <?php if (!empty($item['soon'])): ?>
                <span class="pp-nav-item is-soon" title="Coming in a later phase">
                    <i class="fa-solid fa-<?php echo $item['icon']; ?>"></i> <?php echo $item['label']; ?>
                    <span class="pp-soon-pill">Soon</span>
                </span>
                <?php else: ?>
                <a href="<?php echo $item['href']; ?>" class="pp-nav-item <?php echo $PP_ACTIVE_NAV === $item['key'] ? 'active' : ''; ?>">
                    <i class="fa-solid fa-<?php echo $item['icon']; ?>"></i> <?php echo $item['label']; ?>
                </a>
                <?php endif; ?>
            <?php endforeach; ?>
        </nav>
        <div class="pp-sidebar-user">
            <div class="pp-user-avatar"><?php echo strtoupper(substr(partner_name(), 0, 1)); ?></div>
            <div class="pp-user-meta">
                <div class="pp-user-name"><?php echo htmlspecialchars(partner_name()); ?></div>
                <div class="pp-user-role"><?php echo htmlspecialchars(partner_role()); ?> &middot; <?php echo htmlspecialchars(partner_company()); ?></div>
            </div>
            <a href="b2b-logout.php" class="pp-user-logout" title="Log out"><i class="fa-solid fa-right-from-bracket"></i></a>
        </div>
    </div>

    <div class="pp-main">
        <div class="pp-topbar">
            <div class="pp-topbar-title"><?php echo htmlspecialchars($PP_PAGE_TITLE); ?></div>
            <div class="pp-topbar-meta">
                <span class="pp-ref-chip"><?php echo htmlspecialchars($ppPartner['application_ref']); ?></span>
                <button type="button" class="pp-icon-btn" id="ppNotifBtn" title="Notifications">
                    <i class="fa-solid fa-bell"></i>
                    <?php if ($ppUnreadCount > 0): ?><span class="pp-badge"><?php echo min($ppUnreadCount, 99); ?></span><?php endif; ?>
                </button>
                <div class="pp-notif-panel" id="ppNotifPanel" hidden></div>
                <div class="pp-user-avatar small"><?php echo strtoupper(substr(partner_name(), 0, 1)); ?></div>
            </div>
        </div>
        <div class="pp-content">
