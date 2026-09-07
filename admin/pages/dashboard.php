<?php
declare(strict_types=1);

/**
 * Single-window front door: one tile per business module. Each tile
 * links into that module's own existing pages (unchanged nav,
 * permissions, and detail views) rather than embedding anything —
 * clicking through still shares the one sidebar+topbar shell every
 * admin page already uses, so nothing here is a new "window".
 *
 * Tiles are gated by has_permission() exactly like the sidebar nav —
 * a role with no visibility into a module doesn't see its tile.
 */

$pdo = db();

$leadsToday = 0;
if (has_permission('enquiries.view')) {
    $leadsToday += (int) $pdo->query("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND DATE(created_at) = CURDATE()")->fetchColumn();
}
if (has_permission('general_enquiries.view')) {
    $leadsToday += (int) $pdo->query("SELECT COUNT(*) FROM general_enquiries WHERE deleted_at IS NULL AND DATE(created_at) = CURDATE()")->fetchColumn();
}
if (has_permission('forex.requests.view')) {
    $leadsToday += (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND DATE(created_at) = CURDATE()")->fetchColumn();
}
$pendingPartnerEnquiries = has_permission('partners.view')
    ? (int) $pdo->query("SELECT COUNT(*) FROM partner_enquiries WHERE deleted_at IS NULL AND status = 'new'")->fetchColumn()
    : 0;
$pendingDocuments = has_permission('documents.verify')
    ? (int) $pdo->query("SELECT COUNT(*) FROM documents WHERE deleted_at IS NULL AND verification_status = 'pending'")->fetchColumn()
    : 0;
$pendingB2bPartners = has_permission('b2b_travel_partners.view')
    ? (int) $pdo->query("SELECT COUNT(*) FROM b2b_partners WHERE deleted_at IS NULL AND status IN ('submitted', 'under_review')")->fetchColumn()
    : 0;

$stats = [
    'New Leads Today' => $leadsToday,
    'Customers' => has_permission('customers.view') ? (int) $pdo->query('SELECT COUNT(*) FROM customers WHERE deleted_at IS NULL')->fetchColumn() : null,
    'Active B2B Partners' => has_permission('partners.view') ? (int) $pdo->query("SELECT COUNT(*) FROM partners WHERE deleted_at IS NULL AND status = 'active'")->fetchColumn() : null,
    'Documents Pending Verification' => has_permission('documents.verify') ? $pendingDocuments : null,
];
$stats = array_filter($stats, static fn($v) => $v !== null);

admin_header_start('Dashboard', 'dashboard');
?>
<div class="admin-stat-grid">
    <?php foreach ($stats as $label => $value): ?>
    <div class="admin-stat-card">
        <div class="admin-stat-card__value"><?= $value ?></div>
        <div class="admin-stat-card__label"><?= e($label) ?></div>
    </div>
    <?php endforeach; ?>
</div>

<h2 class="country-directory__subheading">Modules</h2>
<div class="admin-module-grid">
    <?php if (has_permission('enquiries.view') || has_permission('general_enquiries.view') || has_permission('forex.requests.view') || has_permission('partners.view')): ?>
    <a href="/admin/sales-crm/" class="admin-module-tile">
        <?php if ($leadsToday > 0): ?><span class="admin-module-tile__badge"><?= $leadsToday ?></span><?php endif; ?>
        <span class="admin-module-tile__icon">📇</span>
        <span class="admin-module-tile__title">Sales CRM</span>
        <span class="admin-module-tile__desc">Every lead in one place — Visa, Apostille, General/Attestation, Forex, and B2B Partner enquiries.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('customers.view')): ?>
    <a href="/admin/customers/" class="admin-module-tile">
        <span class="admin-module-tile__icon">👤</span>
        <span class="admin-module-tile__title">Customers</span>
        <span class="admin-module-tile__desc">Converted customer records, registrations, and their full case history.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('visa.view')): ?>
    <a href="/admin/visa-applications/" class="admin-module-tile">
        <span class="admin-module-tile__icon">🛂</span>
        <span class="admin-module-tile__title">Visa Operations</span>
        <span class="admin-module-tile__desc">Applications in progress — documents, appointments, submission, and decisions.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('partners.view')): ?>
    <a href="/admin/partners/" class="admin-module-tile">
        <?php if ($pendingPartnerEnquiries > 0): ?><span class="admin-module-tile__badge"><?= $pendingPartnerEnquiries ?></span><?php endif; ?>
        <span class="admin-module-tile__icon">🤝</span>
        <span class="admin-module-tile__title">Referral Partners</span>
        <span class="admin-module-tile__desc">Commission-tier referral program: onboarding, tiers, commissions, invoices, and document expiry.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('b2b_travel_partners.view')): ?>
    <a href="/admin/b2b-partners/" class="admin-module-tile">
        <?php if ($pendingB2bPartners > 0): ?><span class="admin-module-tile__badge"><?= $pendingB2bPartners ?></span><?php endif; ?>
        <span class="admin-module-tile__icon">🏢</span>
        <span class="admin-module-tile__title">B2B Travel Partner Portal</span>
        <span class="admin-module-tile__desc">The standalone travel partner portal: applications, KYC verification, and account status.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('forex.requests.view')): ?>
    <a href="/admin/forex-dashboard/" class="admin-module-tile">
        <span class="admin-module-tile__icon">💱</span>
        <span class="admin-module-tile__title">Forex</span>
        <span class="admin-module-tile__desc">Requests, document verification, quotations, compliance, and delivery.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('partners.manage') || has_permission('forex.requests.view')): ?>
    <a href="/admin/finance/" class="admin-module-tile">
        <span class="admin-module-tile__icon">💰</span>
        <span class="admin-module-tile__title">Finance</span>
        <span class="admin-module-tile__desc">Partner invoices, collections, and forex payment stages.</span>
    </a>
    <?php endif; ?>

    <?php if (is_admin_logged_in()): ?>
    <a href="/hrms/dashboard/" class="admin-module-tile">
        <span class="admin-module-tile__icon">🧑‍💼</span>
        <span class="admin-module-tile__title">HRMS</span>
        <span class="admin-module-tile__desc">Recruitment, candidates, vacancies, and the hiring pipeline.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('grievances.view')): ?>
    <a href="/admin/grievances/" class="admin-module-tile">
        <span class="admin-module-tile__icon">📮</span>
        <span class="admin-module-tile__title">Grievances</span>
        <span class="admin-module-tile__desc">Customer complaints, SLA tracking, and escalations.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/countries/" class="admin-module-tile">
        <span class="admin-module-tile__icon">🌐</span>
        <span class="admin-module-tile__title">Content / CMS</span>
        <span class="admin-module-tile__desc">Countries, visa types, requirements, embassies, FAQs, and locations.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('users.manage') || has_permission('settings.manage') || has_permission('audit.view')): ?>
    <a href="/admin/users/" class="admin-module-tile">
        <span class="admin-module-tile__icon">⚙️</span>
        <span class="admin-module-tile__title">System</span>
        <span class="admin-module-tile__desc">Users &amp; roles, audit log, site settings, and mail log.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('recycle_bin.manage')): ?>
    <a href="/admin/recycle-bin/" class="admin-module-tile">
        <span class="admin-module-tile__icon">🗑️</span>
        <span class="admin-module-tile__title">Recycle Bin</span>
        <span class="admin-module-tile__desc">Restore soft-deleted records — Super Admin only, OTP-gated.</span>
    </a>
    <?php endif; ?>
</div>
<?php
admin_header_end();
