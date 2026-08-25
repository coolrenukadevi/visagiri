<?php
declare(strict_types=1);

/**
 * HRMS Recruitment CRM chrome — deliberately distinct from the visa
 * CRM's admin-layout.php (different sidebar branding/nav, its own
 * hrms.css) so it reads as its own product, per the spec's "premium
 * modern recruitment CRM, not a basic admin panel." Reuses the same
 * admin_users session/login/RBAC infrastructure — see includes/hrms.php's
 * require_hrms_login() — and the same component classes (card, btn,
 * admin-table, badge) from components.css/admin.css for everything
 * that isn't specifically HRMS-flavored.
 */

function hrms_header_start(string $pageTitle, string $activeNav): void
{
    $admin = current_admin();
    ?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?> · VisaGiri HRMS</title>
<meta name="robots" content="noindex, nofollow">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/tokens.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/base.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/components.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/admin.css')) ?>">
<link rel="stylesheet" href="<?= e(asset_url('/assets/css/hrms.css')) ?>">
</head>
<body class="admin-body hrms-body">
<div class="admin-shell hrms-shell">
    <aside class="admin-sidebar hrms-sidebar">
        <div class="admin-sidebar__brand">VisaGiri <span>HRMS</span> <small>Recruitment CRM</small></div>
        <nav class="admin-sidebar__nav">
            <a href="/hrms/dashboard/" class="<?= $activeNav === 'dashboard' ? 'is-active' : '' ?>">Dashboard</a>
            <?php if (has_permission('hrms.vacancies.manage')): ?>
            <a href="/hrms/vacancies/" class="<?= $activeNav === 'vacancies' ? 'is-active' : '' ?>">Vacancies</a>
            <?php endif; ?>
            <?php if (has_permission('hrms.candidates.view')): ?>
            <a href="/hrms/candidates/" class="<?= $activeNav === 'candidates' ? 'is-active' : '' ?>">Candidates</a>
            <a href="/hrms/pipeline/" class="<?= $activeNav === 'pipeline' ? 'is-active' : '' ?>">Pipeline</a>
            <?php endif; ?>
        </nav>
        <div class="admin-sidebar__footer">
            <a href="/careers/" target="_blank" rel="noopener">View careers page &rarr;</a>
        </div>
    </aside>
    <div class="admin-main">
        <header class="admin-topbar hrms-topbar">
            <h1><?= e($pageTitle) ?></h1>
            <div class="admin-topbar__account">
                <span><?= e($admin['full_name'] ?? '') ?> <small>(<?= e($admin['role_name'] ?? 'No role') ?>)</small></span>
                <form method="post" action="/hrms/logout/" style="display:contents"><?= csrf_field() ?><button type="submit" class="btn btn-outline btn-sm">Logout</button></form>
            </div>
        </header>
        <main class="admin-content">
    <?php
    $flash = flash_get('hrms_notice');
    if ($flash) {
        echo '<div class="alert alert-success">' . e($flash) . '</div>';
    }
    $flashError = flash_get('hrms_error');
    if ($flashError) {
        echo '<div class="alert alert-danger">' . e($flashError) . '</div>';
    }
}

function hrms_header_end(): void
{
    ?>
        </main>
    </div>
</div>
</body>
</html>
    <?php
}
