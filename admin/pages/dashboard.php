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
 *
 * The pipeline/work-queue/recent-enquiries widgets below all read the
 * unified `enquiries` table (schema-enquiry-v2.sql) specifically — it's
 * the only CRM entity with a real status/priority/assigned_user shape
 * to build honest analytics from. general_enquiries/forex_requests
 * still only contribute to the "New Leads Today" count, same as
 * before; reconciling every module's own status vocabulary into one
 * chart isn't attempted here rather than fake a unified taxonomy none
 * of them actually share.
 */

$pdo = db();
$scopedToAssigned = current_admin_scoped_to_assigned();
$myId = current_admin_id();

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

// The enquiries-table widgets below (pipeline, work queue, recent
// list) share one scope clause: an admin scoped to only their own
// assignments (visa-consultant) sees only their own rows everywhere
// on this page, same rule enquiries.php's own list view already
// enforces — the dashboard must not leak a wider view than the list
// page it links to.
$enqScopeSql = $scopedToAssigned ? ' AND assigned_user = :me' : '';
$enqScopeSqlAliased = $scopedToAssigned ? ' AND e.assigned_user = :me' : '';
$enqScopeParams = $scopedToAssigned ? ['me' => $myId] : [];

$activeEnquiries = 0;
$resolvedToday = 0;
$statusCounts = [];
$workQueue = ['urgent' => 0, 'pending_customer' => 0, 'documents_pending' => 0, 'internal' => 0, 'resolved_today' => 0];
$recentEnquiries = [];

if (has_permission('enquiries.view')) {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND status NOT IN ('completed', 'closed')$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $activeEnquiries = (int) $stmt->fetchColumn();

    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND status IN ('completed', 'closed') AND DATE(updated_at) = CURDATE()$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $resolvedToday = (int) $stmt->fetchColumn();

    $stmt = $pdo->prepare("SELECT status, COUNT(*) AS c FROM enquiries WHERE deleted_at IS NULL$enqScopeSql GROUP BY status");
    $stmt->execute($enqScopeParams);
    foreach ($stmt->fetchAll() as $row) {
        $statusCounts[$row['status']] = (int) $row['c'];
    }

    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND priority = 'urgent' AND status NOT IN ('completed', 'closed')$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $workQueue['urgent'] = (int) $stmt->fetchColumn();
    $workQueue['pending_customer'] = $statusCounts['additional_info_required'] ?? 0;
    $workQueue['documents_pending'] = $statusCounts['documents_pending'] ?? 0;
    $workQueue['internal'] = ($statusCounts['under_review'] ?? 0) + ($statusCounts['processing'] ?? 0) + ($statusCounts['documents_verified'] ?? 0);
    $workQueue['resolved_today'] = $resolvedToday;

    $sql = "SELECT e.id, e.enquiry_number, e.name, e.service_category, e.status, e.priority, e.created_at,
                    co.name AS country_name, emp.full_name AS assigned_name
             FROM enquiries e
             LEFT JOIN countries co ON co.id = e.destination_country_id
             LEFT JOIN admin_users emp ON emp.id = e.assigned_user
             WHERE e.deleted_at IS NULL$enqScopeSqlAliased
             ORDER BY e.created_at DESC LIMIT 8";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($enqScopeParams);
    $recentEnquiries = $stmt->fetchAll();
}

$recentActivity = [];
if (has_permission('audit.view')) {
    $stmt = $pdo->query(
        "SELECT a.action, a.module, a.record_id, a.created_at, adm.full_name AS actor_name
         FROM audit_logs a
         LEFT JOIN admin_users adm ON adm.id = a.admin_user_id
         ORDER BY a.created_at DESC LIMIT 10"
    );
    $recentActivity = $stmt->fetchAll();
}

$stats = [
    'New Leads Today' => $leadsToday,
    'Active Enquiries' => has_permission('enquiries.view') ? $activeEnquiries : null,
    'Resolved Today' => has_permission('enquiries.view') ? $resolvedToday : null,
    'Documents Pending Verification' => has_permission('documents.verify') ? $pendingDocuments : null,
    'Customers' => has_permission('customers.view') ? (int) $pdo->query('SELECT COUNT(*) FROM customers WHERE deleted_at IS NULL')->fetchColumn() : null,
    'Active B2B Partners' => has_permission('partners.view') ? (int) $pdo->query("SELECT COUNT(*) FROM partners WHERE deleted_at IS NULL AND status = 'active'")->fetchColumn() : null,
];
$stats = array_filter($stats, static fn($v) => $v !== null);

$totalEnquiriesForPipeline = array_sum($statusCounts);

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

<?php if (has_permission('enquiries.view')): ?>
<div class="admin-panel-row">
    <div class="admin-panel">
        <h2 class="admin-panel__title">Enquiry Status Distribution<?= $scopedToAssigned ? ' — Your Enquiries' : '' ?></h2>
        <?php if ($totalEnquiriesForPipeline === 0): ?>
        <p class="admin-empty-state">No enquiry data available yet.</p>
        <?php else: ?>
        <div class="admin-status-bars">
            <?php foreach (enquiry_internal_statuses() as $key => $label):
                $count = $statusCounts[$key] ?? 0;
                $pct = $totalEnquiriesForPipeline > 0 ? round($count / $totalEnquiriesForPipeline * 100) : 0;
            ?>
            <div class="admin-status-bar">
                <div class="admin-status-bar__label"><span><?= e($label) ?></span><span><?= $count ?></span></div>
                <div class="admin-status-bar__track"><div class="admin-status-bar__fill" style="width:<?= $pct ?>%"></div></div>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
    </div>

    <div class="admin-panel">
        <h2 class="admin-panel__title">Today's Work Queue</h2>
        <?php if ($totalEnquiriesForPipeline === 0): ?>
        <p class="admin-empty-state">No enquiry data available yet.</p>
        <?php else: ?>
        <ul class="admin-work-queue">
            <li class="admin-work-queue__item is-urgent"><span class="admin-work-queue__dot"></span><span class="admin-work-queue__label">Urgent Priority</span><span class="admin-work-queue__count"><?= $workQueue['urgent'] ?></span></li>
            <li class="admin-work-queue__item is-pending"><span class="admin-work-queue__dot"></span><span class="admin-work-queue__label">Pending Customer Action</span><span class="admin-work-queue__count"><?= $workQueue['pending_customer'] ?></span></li>
            <li class="admin-work-queue__item is-docs"><span class="admin-work-queue__dot"></span><span class="admin-work-queue__label">Documents Pending</span><span class="admin-work-queue__count"><?= $workQueue['documents_pending'] ?></span></li>
            <li class="admin-work-queue__item is-internal"><span class="admin-work-queue__dot"></span><span class="admin-work-queue__label">Internal Processing</span><span class="admin-work-queue__count"><?= $workQueue['internal'] ?></span></li>
            <li class="admin-work-queue__item is-resolved"><span class="admin-work-queue__dot"></span><span class="admin-work-queue__label">Resolved Today</span><span class="admin-work-queue__count"><?= $workQueue['resolved_today'] ?></span></li>
        </ul>
        <?php endif; ?>
    </div>
</div>

<div class="admin-panel">
    <h2 class="admin-panel__title">Recent Enquiries</h2>
    <?php if (!$recentEnquiries): ?>
    <p class="admin-empty-state">No new enquiries today. You're all caught up.</p>
    <?php else: ?>
    <div class="admin-table-scroll">
    <table class="admin-table">
        <thead><tr><th>Reference</th><th>Customer</th><th>Service</th><th>Status</th><th>Priority</th><th>Assigned To</th><th>Created</th></tr></thead>
        <tbody>
        <?php foreach ($recentEnquiries as $enq): ?>
        <tr>
            <td><a href="/admin/enquiries/?id=<?= (int) $enq['id'] ?>"><?= e($enq['enquiry_number']) ?></a></td>
            <td><?= e($enq['name']) ?></td>
            <td><?= e(ucfirst($enq['service_category'])) ?><?= $enq['country_name'] ? ' — ' . e($enq['country_name']) : '' ?></td>
            <td><span class="badge badge-info"><?= e(enquiry_customer_status_label($enq['status'])) ?></span></td>
            <td><span class="badge <?= $enq['priority'] === 'urgent' ? 'badge-danger' : ($enq['priority'] === 'high' ? 'badge-warning' : 'badge-neutral') ?>"><?= e(ucfirst($enq['priority'])) ?></span></td>
            <td><?= $enq['assigned_name'] ? e($enq['assigned_name']) : '—' ?></td>
            <td><?= e(date('d M, H:i', strtotime($enq['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>
<?php endif; ?>

<?php if (has_permission('audit.view')): ?>
<div class="admin-panel">
    <h2 class="admin-panel__title">Recent Activity</h2>
    <?php if (!$recentActivity): ?>
    <p class="admin-empty-state">No recent activity recorded.</p>
    <?php else: ?>
    <ul class="admin-activity-feed">
        <?php foreach ($recentActivity as $entry): ?>
        <li class="admin-activity-feed__item">
            <span class="admin-activity-feed__text">
                <strong><?= e($entry['actor_name'] ?? 'System') ?></strong>
                <?= e(str_replace('_', ' ', $entry['action'])) ?>
                <?= e(str_replace('_', ' ', $entry['module'])) ?><?= $entry['record_id'] ? ' #' . (int) $entry['record_id'] : '' ?>
            </span>
            <span class="admin-activity-feed__time"><?= e(date('d M, H:i', strtotime($entry['created_at']))) ?></span>
        </li>
        <?php endforeach; ?>
    </ul>
    <?php endif; ?>
</div>
<?php endif; ?>

<h2 class="country-directory__subheading">Modules</h2>
<div class="admin-module-grid">
    <?php if (has_permission('enquiries.view') || has_permission('general_enquiries.view') || has_permission('forex.requests.view') || has_permission('partners.view')): ?>
    <a href="/admin/sales-crm/" class="admin-module-tile">
        <?php if ($leadsToday > 0): ?><span class="admin-module-tile__badge"><?= $leadsToday ?></span><?php endif; ?>
        <span class="admin-module-tile__icon"><?= admin_module_icon('sales-crm') ?></span>
        <span class="admin-module-tile__title">Sales CRM</span>
        <span class="admin-module-tile__desc">Every lead in one place — Visa, Apostille, General/Attestation, Forex, and B2B Partner enquiries.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('customers.view')): ?>
    <a href="/admin/customers/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('customers') ?></span>
        <span class="admin-module-tile__title">Customers</span>
        <span class="admin-module-tile__desc">Converted customer records, registrations, and their full case history.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('visa.view')): ?>
    <a href="/admin/visa-applications/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('visa-operations') ?></span>
        <span class="admin-module-tile__title">Visa Operations</span>
        <span class="admin-module-tile__desc">Applications in progress — documents, appointments, submission, and decisions.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('partners.view')): ?>
    <a href="/admin/partners/" class="admin-module-tile">
        <?php if ($pendingPartnerEnquiries > 0): ?><span class="admin-module-tile__badge"><?= $pendingPartnerEnquiries ?></span><?php endif; ?>
        <span class="admin-module-tile__icon"><?= admin_module_icon('partners') ?></span>
        <span class="admin-module-tile__title">Referral Partners</span>
        <span class="admin-module-tile__desc">Commission-tier referral program: onboarding, tiers, commissions, invoices, and document expiry.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('b2b_travel_partners.view')): ?>
    <a href="/admin/b2b-partners/" class="admin-module-tile">
        <?php if ($pendingB2bPartners > 0): ?><span class="admin-module-tile__badge"><?= $pendingB2bPartners ?></span><?php endif; ?>
        <span class="admin-module-tile__icon"><?= admin_module_icon('b2b-portal') ?></span>
        <span class="admin-module-tile__title">B2B Travel Partner Portal</span>
        <span class="admin-module-tile__desc">The standalone travel partner portal: applications, KYC verification, and account status.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('forex.requests.view')): ?>
    <a href="/admin/forex-dashboard/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('forex') ?></span>
        <span class="admin-module-tile__title">Forex</span>
        <span class="admin-module-tile__desc">Requests, document verification, quotations, compliance, and delivery.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('partners.manage') || has_permission('forex.requests.view')): ?>
    <a href="/admin/finance/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('finance') ?></span>
        <span class="admin-module-tile__title">Finance</span>
        <span class="admin-module-tile__desc">Partner invoices, collections, and forex payment stages.</span>
    </a>
    <?php endif; ?>

    <?php if (is_admin_logged_in()): ?>
    <a href="/hrms/dashboard/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('hrms') ?></span>
        <span class="admin-module-tile__title">HRMS</span>
        <span class="admin-module-tile__desc">Recruitment, candidates, vacancies, and the hiring pipeline.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('grievances.view')): ?>
    <a href="/admin/grievances/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('grievances') ?></span>
        <span class="admin-module-tile__title">Grievances</span>
        <span class="admin-module-tile__desc">Customer complaints, SLA tracking, and escalations.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/countries/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('content') ?></span>
        <span class="admin-module-tile__title">Content / CMS</span>
        <span class="admin-module-tile__desc">Countries, visa types, requirements, embassies, FAQs, and locations.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('users.manage') || has_permission('settings.manage') || has_permission('audit.view')): ?>
    <a href="/admin/users/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('system') ?></span>
        <span class="admin-module-tile__title">System</span>
        <span class="admin-module-tile__desc">Users, roles &amp; permissions, audit log, site settings, and mail log.</span>
    </a>
    <?php endif; ?>

    <?php if (has_permission('recycle_bin.manage')): ?>
    <a href="/admin/recycle-bin/" class="admin-module-tile">
        <span class="admin-module-tile__icon"><?= admin_module_icon('recycle-bin') ?></span>
        <span class="admin-module-tile__title">Recycle Bin</span>
        <span class="admin-module-tile__desc">Restore soft-deleted records — Super Admin only, OTP-gated.</span>
    </a>
    <?php endif; ?>
</div>
<?php
admin_header_end();
