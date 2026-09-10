<?php
/**
 * Expects: $pageTitle set, crm_require_login() already called.
 * Optional: $crmActive = current nav key for highlighting.
 */
$crmUser = crm_current_user();
$fullAccess = crm_has_full_access($crmUser['role_slug']);
?><!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle ?? 'Videshia CRM') ?></title>
<meta name="robots" content="noindex, nofollow">
<link rel="icon" type="image/svg+xml" href="<?= asset('images/favicon.svg') ?>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<?= asset('css/style.css') ?>">
</head>
<body>
<div class="crm-shell">
    <aside class="crm-sidebar">
        <div class="crm-sidebar-brand"><?= videshia_logo('sm', 'dark') ?></div>
        <nav class="crm-nav">
            <a href="<?= url('crm/dashboard.php') ?>" class="<?= ($crmActive ?? '') === 'dashboard' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="9"/><rect x="14" y="3" width="7" height="5"/><rect x="14" y="12" width="7" height="9"/><rect x="3" y="16" width="7" height="5"/></svg>
                Dashboard
            </a>
            <a href="<?= url('crm/enquiries.php') ?>" class="<?= ($crmActive ?? '') === 'enquiries' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg>
                Enquiries
            </a>
            <a href="<?= url('crm/customers.php') ?>" class="<?= ($crmActive ?? '') === 'customers' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
                Customers
            </a>
            <a href="<?= url('crm/followups.php') ?>" class="<?= ($crmActive ?? '') === 'followups' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg>
                Follow-ups
            </a>
            <?php if ($fullAccess): ?>
            <div class="crm-nav-label">Admin</div>
            <a href="<?= url('crm/users.php') ?>" class="<?= ($crmActive ?? '') === 'users' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-6 8-6s8 2 8 6"/></svg>
                Team &amp; Roles
            </a>
            <a href="<?= url('crm/audit-log.php') ?>" class="<?= ($crmActive ?? '') === 'audit' ? 'active' : '' ?>">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg>
                Audit Log
            </a>
            <?php endif; ?>
        </nav>
        <div class="crm-sidebar-foot">
            <a href="<?= url('index.php') ?>" style="color:rgba(243,247,252,.6)">&larr; Back to website</a>
        </div>
    </aside>

    <div class="crm-main">
        <div class="crm-topbar">
            <h1><?= e($pageTitle ?? 'Dashboard') ?></h1>
            <div class="crm-user-chip">
                <div class="avatar"><?= e(strtoupper(substr($crmUser['name'], 0, 2))) ?></div>
                <div>
                    <strong style="display:block;color:var(--navy-900)"><?= e($crmUser['name']) ?></strong>
                    <span style="color:var(--muted)"><?= e($crmUser['role_name']) ?></span>
                </div>
                <a href="<?= url('crm/logout.php') ?>" class="btn btn-ghost" style="padding:8px 14px;font-size:13px">Sign out</a>
            </div>
        </div>
        <div class="crm-content">
