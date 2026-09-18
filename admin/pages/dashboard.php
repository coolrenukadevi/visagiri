<?php
declare(strict_types=1);

/**
 * Visagiri CMS Operations Control Centre — the CMS blueprint's
 * Dashboard row ("Overview / Control Centre... View KPIs; drill-down;
 * Focus Mode; customize widgets", P0, role-based). Three-layer
 * progressive disclosure per Architecture Rules:
 *   Glance — SLA alert, Top Priorities, essential KPI groups (always visible)
 *   Scan   — Enquiry Analytics, Visa Funnel, SLA Overview, Team Performance (collapsible)
 *   Dig    — Recent Enquiries, Tasks, Unassigned Cases (collapsible)
 *
 * Every number on this page is a real query against the same tables
 * each module's own list page already reads (enquiries, visa_applications,
 * documents, reminders, forex_requests, partner_invoices, customers,
 * audit_logs) — nothing here is mocked. Where the CMS blueprint names a
 * widget this schema can't yet honestly back (e.g. a true "at risk"
 * SLA tier beyond breached/not-breached would need a stored SLA-stage
 * timestamp this schema doesn't have), the widget derives its buckets
 * from what IS real (time-to-due-date math) rather than inventing data.
 */

$pdo = db();
$admin = current_admin();
$scopedToAssigned = current_admin_scoped_to_assigned();
$myId = current_admin_id();

// ---------------------------------------------------------------
// Greeting
// ---------------------------------------------------------------
$hour = (int) date('G');
$greetingWord = $hour < 12 ? 'Good Morning' : ($hour < 17 ? 'Good Afternoon' : 'Good Evening');
$firstName = trim((string) explode(' ', (string) ($admin['full_name'] ?? 'Admin'))[0]);

// ---------------------------------------------------------------
// SLA + priorities (enquiries.sla_due_at is the only table-wide SLA
// clock that exists — visa_applications/forex_requests/grievances
// don't carry their own SLA timestamp in this schema, so SLA-driven
// widgets below are built on the enquiries table specifically,
// same honest scope the pre-existing dashboard already used).
// ---------------------------------------------------------------
$enqScopeSql = $scopedToAssigned ? ' AND assigned_user = :me' : '';
$enqScopeSqlAliased = $scopedToAssigned ? ' AND e.assigned_user = :me' : '';
$enqScopeParams = $scopedToAssigned ? ['me' => $myId] : [];

$slaBreachedCount = 0;
$slaBuckets = ['green' => 0, 'yellow' => 0, 'orange' => 0, 'red' => 0];
$worstOverdue = null;
if (has_permission('enquiries.view')) {
    notify_breached_enquiry_slas();

    $stmt = $pdo->prepare(
        "SELECT sla_due_at FROM enquiries
         WHERE deleted_at IS NULL AND sla_due_at IS NOT NULL AND status NOT IN ('completed', 'closed')$enqScopeSql"
    );
    $stmt->execute($enqScopeParams);
    $now = new DateTimeImmutable();
    foreach ($stmt->fetchAll(PDO::FETCH_COLUMN) as $dueAt) {
        $due = new DateTimeImmutable((string) $dueAt);
        $hoursLeft = ($due->getTimestamp() - $now->getTimestamp()) / 3600;
        if ($hoursLeft < 0) { $slaBuckets['red']++; }
        elseif ($hoursLeft <= 6) { $slaBuckets['orange']++; }
        elseif ($hoursLeft <= 24) { $slaBuckets['yellow']++; }
        else { $slaBuckets['green']++; }
    }
    $slaBreachedCount = $slaBuckets['red'];

    $stmt = $pdo->prepare(
        "SELECT e.id, e.enquiry_number, e.name, e.service_category, e.sla_due_at, dc.name AS country_name, emp.full_name AS assigned_name
         FROM enquiries e
         LEFT JOIN countries dc ON dc.id = e.destination_country_id
         LEFT JOIN admin_users emp ON emp.id = e.assigned_user
         WHERE e.deleted_at IS NULL AND e.sla_due_at IS NOT NULL AND e.status NOT IN ('completed', 'closed')$enqScopeSqlAliased
         ORDER BY e.sla_due_at ASC LIMIT 1"
    );
    $stmt->execute($enqScopeParams);
    $worstOverdue = $stmt->fetch() ?: null;
}
$slaTotal = array_sum($slaBuckets);
$slaOnTrackPct = $slaTotal > 0 ? round($slaBuckets['green'] / $slaTotal * 100) : 100;

$pendingDocuments = has_permission('documents.verify')
    ? (int) $pdo->query("SELECT COUNT(*) FROM documents WHERE deleted_at IS NULL AND verification_status = 'pending'")->fetchColumn()
    : 0;

$reminderCounts = ['overdue' => 0, 'today' => 0, 'upcoming' => 0];
if (has_permission('reminders.manage')) {
    notify_due_reminders();
    $reminderCounts = reminder_due_counts($scopedToAssigned ? $myId : null);
}

$unassignedCount = 0;
if (has_permission('enquiries.view') && !$scopedToAssigned) {
    $unassignedCount = (int) $pdo->query(
        "SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND assigned_user IS NULL AND status NOT IN ('completed', 'closed')"
    )->fetchColumn();
}

// ---------------------------------------------------------------
// KPI groups
// ---------------------------------------------------------------
$newEnquiriesToday = 0;
$activeEnquiries = 0;
$resolvedToday = 0;
$statusCounts = [];
if (has_permission('enquiries.view')) {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND DATE(created_at) = CURDATE()$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $newEnquiriesToday = (int) $stmt->fetchColumn();

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
}

$activeVisaApplications = has_permission('visa.view')
    ? (int) $pdo->query("SELECT COUNT(*) FROM visa_applications WHERE deleted_at IS NULL AND status NOT IN ('completed', 'cancelled', 'rejected')")->fetchColumn()
    : 0;

$paymentsPending = 0;
$paymentsPendingLabel = null;
if (has_permission('forex.requests.view')) {
    $paymentsPending += (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'payment_pending'")->fetchColumn();
}
if (has_permission('partners.manage')) {
    $paymentsPending += (int) $pdo->query("SELECT COUNT(*) FROM partner_invoices WHERE status = 'issued'")->fetchColumn();
}

$activeCustomers = has_permission('customers.view')
    ? (int) $pdo->query('SELECT COUNT(*) FROM customers WHERE deleted_at IS NULL')->fetchColumn()
    : 0;

$kpiGroups = [];
if (has_permission('enquiries.view')) {
    $kpiGroups['Sales'] = [
        ['label' => 'New Enquiries', 'value' => $newEnquiriesToday, 'href' => '/admin/enquiries/'],
        ['label' => 'Open Enquiries', 'value' => $activeEnquiries, 'href' => '/admin/enquiries/'],
    ];
}
if (has_permission('visa.view') || has_permission('documents.verify')) {
    $ops = [];
    if (has_permission('visa.view')) { $ops[] = ['label' => 'Visa Applications', 'value' => $activeVisaApplications, 'href' => '/admin/visa-applications/']; }
    if (has_permission('documents.verify')) { $ops[] = ['label' => 'Documents Pending', 'value' => $pendingDocuments, 'href' => '/admin/enquiries/?status=documents_pending']; }
    $kpiGroups['Operations'] = $ops;
}
if (has_permission('enquiries.view')) {
    $kpiGroups['Risk'] = [
        ['label' => 'SLA Breached', 'value' => $slaBreachedCount, 'href' => '/admin/enquiries/?sla=breached', 'risk' => true],
    ];
}
if (has_permission('forex.requests.view') || has_permission('partners.manage')) {
    $kpiGroups['Finance'] = [
        ['label' => 'Payments Pending', 'value' => $paymentsPending, 'href' => '/admin/finance/'],
    ];
}
if (has_permission('customers.view') || has_permission('enquiries.view')) {
    $ct = [];
    if (has_permission('customers.view')) { $ct[] = ['label' => 'Active Customers', 'value' => $activeCustomers, 'href' => '/admin/customers/']; }
    if (has_permission('enquiries.view')) { $ct[] = ['label' => 'Cases Completed', 'value' => $resolvedToday, 'href' => '/admin/enquiries/?status=completed']; }
    $kpiGroups['Customer / Team'] = $ct;
}

// ---------------------------------------------------------------
// Enquiry analytics (Layer 2 — Scan)
// ---------------------------------------------------------------
$serviceBreakdown = [];
if (has_permission('enquiries.view')) {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND service_category = 'visa' AND status NOT IN ('completed','closed')$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $serviceBreakdown['Visa'] = (int) $stmt->fetchColumn();
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE deleted_at IS NULL AND service_category = 'apostille' AND status NOT IN ('completed','closed')$enqScopeSql");
    $stmt->execute($enqScopeParams);
    $serviceBreakdown['Apostille & Attestation'] = (int) $stmt->fetchColumn();
}
if (has_permission('forex.requests.view')) {
    $serviceBreakdown['Forex'] = (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status NOT IN ('delivered', 'cancelled', 'rejected')")->fetchColumn();
}
if (has_permission('general_enquiries.view')) {
    $serviceBreakdown['General Enquiry'] = (int) $pdo->query("SELECT COUNT(*) FROM general_enquiries WHERE deleted_at IS NULL AND status NOT IN ('closed')")->fetchColumn();
}
if (has_permission('partners.view')) {
    $serviceBreakdown['B2B Partner'] = (int) $pdo->query("SELECT COUNT(*) FROM partner_enquiries WHERE deleted_at IS NULL AND status = 'new'")->fetchColumn();
}
$serviceBreakdown = array_filter($serviceBreakdown);
$serviceTotal = array_sum($serviceBreakdown);
$donutColors = ['var(--visa-blue)', 'var(--visa-gold-dark)', 'var(--status-green)', 'var(--status-orange)', 'var(--info)'];
$canSeeServiceBreakdown = has_permission('enquiries.view') || has_permission('forex.requests.view') || has_permission('general_enquiries.view') || has_permission('partners.view');

// Visa Application Funnel — real visa_applications.status pipeline.
$funnelStages = [
    'draft' => 'Draft',
    'documents_pending' => 'Documents',
    'submitted' => 'Submitted',
    'under_review' => 'Verification',
    'approved' => 'Approved',
    'completed' => 'Completed',
];
$funnelCounts = [];
if (has_permission('visa.view')) {
    $stmt = $pdo->query('SELECT status, COUNT(*) AS c FROM visa_applications WHERE deleted_at IS NULL GROUP BY status');
    foreach ($stmt->fetchAll() as $row) {
        $funnelCounts[$row['status']] = (int) $row['c'];
    }
}
$funnelBase = $funnelCounts['draft'] ?? array_sum($funnelCounts);
$funnelBase = max($funnelBase, array_sum($funnelCounts), 1);

// Team performance — top 5 by open assignment count this month.
$teamPerformance = [];
if (has_permission('enquiries.view') && !$scopedToAssigned) {
    $stmt = $pdo->query(
        "SELECT emp.id, emp.full_name,
                SUM(e.assigned_user IS NOT NULL AND e.status NOT IN ('completed','closed')) AS assigned_open,
                SUM(e.status IN ('completed','closed') AND MONTH(e.updated_at) = MONTH(CURDATE()) AND YEAR(e.updated_at) = YEAR(CURDATE())) AS completed_month,
                SUM(e.sla_due_at IS NOT NULL AND e.sla_due_at < NOW() AND e.status NOT IN ('completed','closed')) AS breaches
         FROM admin_users emp
         JOIN enquiries e ON e.assigned_user = emp.id AND e.deleted_at IS NULL
         WHERE emp.status = 'active'
         GROUP BY emp.id, emp.full_name
         HAVING assigned_open > 0 OR completed_month > 0
         ORDER BY assigned_open DESC LIMIT 5"
    );
    $teamPerformance = $stmt->fetchAll();
}

// ---------------------------------------------------------------
// Recent enquiries (Layer 3 — Dig)
// ---------------------------------------------------------------
$recentEnquiries = [];
if (has_permission('enquiries.view')) {
    $sql = "SELECT e.id, e.enquiry_number, e.name, e.service_category, e.status, e.priority, e.sla_due_at, e.created_at,
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

$requestedTasksTab = (string) ($_GET['tasks'] ?? 'overdue');
$tasksTab = in_array($requestedTasksTab, ['overdue', 'today', 'upcoming'], true) ? $requestedTasksTab : 'overdue';
$tasks = [];
if (has_permission('reminders.manage')) {
    $tasks = list_reminders($tasksTab, $scopedToAssigned ? $myId : null, $myId);
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

$slaSignature = 'breach-' . $slaBreachedCount . '-' . date('Y-m-d');

admin_header_start('Dashboard', 'dashboard');
?>
<div class="admin-greeting">
    <div class="admin-greeting__illustration" aria-hidden="true"></div>
    <div class="admin-greeting__text">
        <h1><span class="admin-greeting__wave" aria-hidden="true">&#128075;</span> <?= e($greetingWord) ?>, <?= e($firstName ?: 'Admin') ?>!</h1>
        <p>
            <?php if ($slaBreachedCount > 0): ?>
                <?= $slaBreachedCount ?> case<?= $slaBreachedCount === 1 ? '' : 's' ?> need<?= $slaBreachedCount === 1 ? 's' : '' ?> attention before their SLA slips further.
            <?php elseif ($reminderCounts['today'] > 0): ?>
                You have <?= $reminderCounts['today'] ?> follow-up<?= $reminderCounts['today'] === 1 ? '' : 's' ?> due today.
            <?php else: ?>
                Everything is currently on track.
            <?php endif; ?>
        </p>
    </div>
    <div class="admin-greeting__side">
        <div class="admin-greeting__actions">
            <span class="admin-freshness admin-freshness--live">
                <svg width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="4" width="14" height="13" rx="1.5"/><path d="M3 8h14M6 2.5v3M14 2.5v3"/></svg>
                <span class="admin-freshness__dot"></span> Live &middot; <?= e(date('D, d M Y, H:i')) ?>
            </span>
            <button type="button" class="btn btn-sm btn-outline admin-focus-toggle" id="admin-focus-toggle">Focus Mode</button>
            <button type="button" class="btn btn-sm btn-outline" id="admin-customize-toggle">Customize</button>
        </div>
        <p class="admin-greeting__quote">&ldquo;People to Places. Possibilities Together.&rdquo;</p>
    </div>
</div>

<?php if (has_permission('enquiries.view')): ?>
<div class="admin-sla-banner<?= $slaBreachedCount === 0 ? ' is-ok' : '' ?>" id="admin-sla-banner" data-signature="<?= e($slaSignature) ?>">
    <div class="admin-sla-banner__icon">
        <?php if ($slaBreachedCount > 0): ?>
        <svg width="22" height="22" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10 2 18 16H2Z"/><line x1="10" y1="8" x2="10" y2="11.5"/><circle cx="10" cy="14" r="0.6" fill="currentColor" stroke="none"/></svg>
        <?php else: ?>
        <svg width="22" height="22" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>
        <?php endif; ?>
    </div>
    <div class="admin-sla-banner__body">
        <?php if ($slaBreachedCount > 0): ?>
        <p class="admin-sla-banner__title"><?= $slaBreachedCount ?> SLA breach<?= $slaBreachedCount === 1 ? '' : 'es' ?> require<?= $slaBreachedCount === 1 ? 's' : '' ?> attention</p>
        <p class="admin-sla-banner__desc">These cases are overdue and may impact customer service.</p>
        <?php else: ?>
        <p class="admin-sla-banner__title">All SLA commitments are currently on track.</p>
        <?php endif; ?>
    </div>
    <?php if ($slaBreachedCount > 0): ?>
    <a href="/admin/enquiries/?sla=breached" class="btn btn-sm btn-primary">Review Breaches</a>
    <?php endif; ?>
    <button type="button" class="admin-sla-banner__dismiss" id="admin-sla-banner-dismiss" aria-label="Dismiss for this session">
        <svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" aria-hidden="true"><path d="M5 5l10 10M15 5 5 15"/></svg>
    </button>
</div>
<?php endif; ?>

<?php
// ---- Top Priorities (max 3, real cases, not repeated KPI numbers) ----
$priorityIcons = [
    'sla' => '<svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M10 2 18 16H2Z"/><line x1="10" y1="8" x2="10" y2="11.5"/><circle cx="10" cy="14" r="0.6" fill="currentColor" stroke="none"/></svg>',
    'documents' => '<svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M6 2.5h6l3 3V17a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1Z"/><path d="M7.5 9h5M7.5 12h5"/></svg>',
    'followup' => '<svg width="18" height="18" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h12v9H8l-4 3.5V13H4Z"/></svg>',
];
$priorities = [];
if ($worstOverdue) {
    $due = new DateTimeImmutable((string) $worstOverdue['sla_due_at']);
    $hoursOverdue = (int) round((time() - $due->getTimestamp()) / 3600);
    $priorities[] = [
        'tone' => 'red',
        'icon' => $priorityIcons['sla'],
        'title' => e($worstOverdue['name']) . ' &mdash; ' . e(ucfirst($worstOverdue['service_category'])) . ($worstOverdue['country_name'] ? ' (' . e($worstOverdue['country_name']) . ')' : ''),
        'meta' => 'Assigned: ' . e($worstOverdue['assigned_name'] ?? 'Unassigned'),
        'flag' => $hoursOverdue > 0 ? $hoursOverdue . 'h overdue' : 'Due now',
        'href' => '/admin/enquiries/?id=' . (int) $worstOverdue['id'],
        'action' => 'Open Case',
    ];
}
if ($pendingDocuments > 0) {
    $priorities[] = [
        'tone' => 'amber',
        'icon' => $priorityIcons['documents'],
        'title' => $pendingDocuments . ' document' . ($pendingDocuments === 1 ? '' : 's') . ' pending verification',
        'meta' => 'Awaiting document review',
        'flag' => null,
        'href' => '/admin/enquiries/?status=documents_pending',
        'action' => 'Open Queue',
    ];
}
if ($reminderCounts['today'] > 0) {
    $priorities[] = [
        'tone' => 'blue',
        'icon' => $priorityIcons['followup'],
        'title' => $reminderCounts['today'] . ' follow-up' . ($reminderCounts['today'] === 1 ? '' : 's') . ' due today',
        'meta' => 'Customer responses pending',
        'flag' => null,
        'href' => '/admin/reminders/',
        'action' => 'View Tasks',
    ];
}
$priorities = array_slice($priorities, 0, 3);
?>
<?php if ($priorities): ?>
<div class="admin-priorities-section">
    <div class="admin-priorities-section__head">
        <h2>Top Priorities</h2>
        <span>Your most important actions right now.</span>
    </div>
    <div class="admin-priorities">
        <?php foreach ($priorities as $p): ?>
        <a href="<?= e($p['href']) ?>" class="admin-priority-card admin-priority-card--<?= e($p['tone']) ?>">
            <span class="admin-priority-card__icon"><?= $p['icon'] ?></span>
            <div class="admin-priority-card__body">
                <p class="admin-priority-card__title"><?= $p['title'] ?></p>
                <p class="admin-priority-card__meta"><?= $p['meta'] ?><?php if ($p['flag']): ?> &middot; <span class="admin-priority-card__flag"><?= e($p['flag']) ?></span><?php endif; ?></p>
            </div>
            <svg class="admin-priority-card__chevron" width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7.5 4.5 13 10l-5.5 5.5"/></svg>
        </a>
        <?php endforeach; ?>
    </div>
</div>
<?php endif; ?>

<div id="admin-dashboard-widgets">

<div class="admin-widget" data-widget-id="kpi-groups">
    <div class="admin-widget__handle"><button type="button" data-widget-drag-handle title="Drag to reorder"><svg width="14" height="14" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><circle cx="7" cy="5" r="1.3"/><circle cx="13" cy="5" r="1.3"/><circle cx="7" cy="10" r="1.3"/><circle cx="13" cy="10" r="1.3"/><circle cx="7" cy="15" r="1.3"/><circle cx="13" cy="15" r="1.3"/></svg></button><button type="button" data-widget-hide title="Hide widget"><svg width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 10s3-5.5 7-5.5S17 10 17 10s-3 5.5-7 5.5S3 10 3 10Z"/><circle cx="10" cy="10" r="2"/><line x1="3" y1="17" x2="17" y2="3"/></svg></button></div>
<div class="admin-kpi-groups">
    <?php foreach ($kpiGroups as $groupLabel => $cards): if (!$cards) continue; ?>
    <div class="admin-kpi-category<?= $groupLabel === 'Risk' ? ' admin-kpi-category--risk' : '' ?>">
        <p class="admin-kpi-category__label"><?= e($groupLabel) ?></p>
        <div class="admin-kpi-category__metrics">
            <?php foreach ($cards as $card): ?>
            <a href="<?= e($card['href']) ?>" class="admin-kpi-metric<?= !empty($card['risk']) && $card['value'] > 0 ? ' admin-kpi-metric--risk' : '' ?>">
                <span class="admin-kpi-metric__value"><?= (int) $card['value'] ?></span>
                <span class="admin-kpi-metric__label"><?= e($card['label']) ?></span>
            </a>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endforeach; ?>
</div>
</div>

<?php if ($canSeeServiceBreakdown || has_permission('visa.view') || has_permission('enquiries.view')): ?>
<div class="admin-layer admin-widget" data-layer="scan" data-widget-id="layer-scan">
    <div class="admin-widget__handle"><button type="button" data-widget-drag-handle title="Drag to reorder"><svg width="14" height="14" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><circle cx="7" cy="5" r="1.3"/><circle cx="13" cy="5" r="1.3"/><circle cx="7" cy="10" r="1.3"/><circle cx="13" cy="10" r="1.3"/><circle cx="7" cy="15" r="1.3"/><circle cx="13" cy="15" r="1.3"/></svg></button><button type="button" data-widget-hide title="Hide widget"><svg width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 10s3-5.5 7-5.5S17 10 17 10s-3 5.5-7 5.5S3 10 3 10Z"/><circle cx="10" cy="10" r="2"/><line x1="3" y1="17" x2="17" y2="3"/></svg></button></div>
    <div class="admin-layer__header">
        <h2 class="admin-layer__title">What's Happening</h2>
        <button type="button" class="admin-layer__toggle" data-layer-toggle>
            <svg class="admin-layer__toggle-chevron" width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 7l5 5 5-5"/></svg>
            Collapse
        </button>
    </div>
    <div class="admin-layer__body">
    <div class="admin-panel-grid">

        <?php if ($canSeeServiceBreakdown): ?>
        <div class="admin-panel">
            <div class="admin-panel__head"><h3 class="admin-panel__title">Enquiries by Service</h3><span class="admin-freshness"><span class="admin-freshness__dot"></span>Updated just now</span></div>
            <?php if ($serviceTotal === 0): ?>
            <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No active enquiries to break down by service yet.</p>
            <?php else: ?>
            <div class="admin-donut-wrap">
                <?php
                $gradParts = []; $cursor = 0;
                foreach (array_values($serviceBreakdown) as $i => $v) {
                    $pct = $v / $serviceTotal * 100;
                    $gradParts[] = ($donutColors[$i % count($donutColors)]) . ' ' . $cursor . '% ' . ($cursor + $pct) . '%';
                    $cursor += $pct;
                }
                ?>
                <div class="admin-donut" style="background: conic-gradient(<?= implode(', ', $gradParts) ?>);">
                    <div class="admin-donut__inner"><span class="admin-donut__total"><?= $serviceTotal ?></span><span class="admin-donut__label">TOTAL</span></div>
                </div>
                <div class="admin-donut-legend">
                    <?php $i = 0; foreach ($serviceBreakdown as $name => $v): ?>
                    <div class="admin-donut-legend__item"><span class="admin-donut-legend__dot" style="background:<?= $donutColors[$i % count($donutColors)] ?>"></span><span class="admin-donut-legend__name"><?= e($name) ?></span><span class="admin-donut-legend__value"><?= $v ?> (<?= round($v / $serviceTotal * 100) ?>%)</span></div>
                    <?php $i++; endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if (has_permission('visa.view')): ?>
        <div class="admin-panel">
            <div class="admin-panel__head"><h3 class="admin-panel__title">Visa Application Funnel</h3><span class="admin-panel__meta"><?= array_sum($funnelCounts) ?> total</span></div>
            <?php if (array_sum($funnelCounts) === 0): ?>
            <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No active visa applications yet.</p>
            <?php else: ?>
            <div class="admin-funnel">
                <?php foreach ($funnelStages as $key => $label): $count = $funnelCounts[$key] ?? 0; $pct = round($count / $funnelBase * 100); ?>
                <a href="/admin/visa-applications/?status=<?= e($key) ?>" class="admin-funnel__stage">
                    <span class="admin-funnel__stage-label"><?= e($label) ?></span>
                    <span class="admin-funnel__stage-track"><span class="admin-funnel__stage-bar" style="width:<?= max($pct, $count > 0 ? 4 : 0) ?>%"></span></span>
                    <span class="admin-funnel__stage-count"><strong><?= $count ?></strong> <span class="admin-funnel__stage-pct"><?= $pct ?>%</span></span>
                </a>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if (has_permission('enquiries.view')): ?>
        <div class="admin-panel">
            <div class="admin-panel__head"><h3 class="admin-panel__title">SLA Overview</h3><span class="admin-panel__meta"><?= $slaTotal ?> active with SLA</span></div>
            <?php if ($slaTotal === 0): ?>
            <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No active cases currently carry an SLA clock.</p>
            <?php else: ?>
            <div class="admin-sla-ring-wrap">
                <div class="admin-sla-ring" style="--ring-green:<?= round($slaBuckets['green']/$slaTotal*100) ?>%; --ring-yellow:<?= round(($slaBuckets['green']+$slaBuckets['yellow'])/$slaTotal*100) ?>%; --ring-orange:<?= round(($slaBuckets['green']+$slaBuckets['yellow']+$slaBuckets['orange'])/$slaTotal*100) ?>%;">
                    <div class="admin-sla-ring__inner"><span class="admin-sla-ring__pct"><?= $slaOnTrackPct ?>%</span><span class="admin-sla-ring__label">On Track</span></div>
                </div>
                <div class="admin-sla-legend">
                    <div class="admin-sla-legend__item"><span class="admin-sla-legend__dot is-green"></span>On Track<span class="admin-sla-legend__count"><?= $slaBuckets['green'] ?> &middot; <?= round($slaBuckets['green'] / $slaTotal * 100) ?>%</span></div>
                    <div class="admin-sla-legend__item"><span class="admin-sla-legend__dot is-yellow"></span>Due Soon (24h)<span class="admin-sla-legend__count"><?= $slaBuckets['yellow'] ?> &middot; <?= round($slaBuckets['yellow'] / $slaTotal * 100) ?>%</span></div>
                    <div class="admin-sla-legend__item"><span class="admin-sla-legend__dot is-orange"></span>At Risk (6h)<span class="admin-sla-legend__count"><?= $slaBuckets['orange'] ?> &middot; <?= round($slaBuckets['orange'] / $slaTotal * 100) ?>%</span></div>
                    <div class="admin-sla-legend__item"><span class="admin-sla-legend__dot is-red"></span>Breached<span class="admin-sla-legend__count"><?= $slaBuckets['red'] ?> &middot; <?= round($slaBuckets['red'] / $slaTotal * 100) ?>%</span></div>
                </div>
            </div>
            <?php endif; ?>
        </div>
        <?php endif; ?>

    </div>
    </div>
</div>
<?php endif; ?>

<div class="admin-layer admin-widget" data-layer="dig-tasks" data-widget-id="layer-dig">
    <div class="admin-widget__handle"><button type="button" data-widget-drag-handle title="Drag to reorder"><svg width="14" height="14" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><circle cx="7" cy="5" r="1.3"/><circle cx="13" cy="5" r="1.3"/><circle cx="7" cy="10" r="1.3"/><circle cx="13" cy="10" r="1.3"/><circle cx="7" cy="15" r="1.3"/><circle cx="13" cy="15" r="1.3"/></svg></button><button type="button" data-widget-hide title="Hide widget"><svg width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M3 10s3-5.5 7-5.5S17 10 17 10s-3 5.5-7 5.5S3 10 3 10Z"/><circle cx="10" cy="10" r="2"/><line x1="3" y1="17" x2="17" y2="3"/></svg></button></div>
    <div class="admin-layer__header">
        <h2 class="admin-layer__title">What Needs Doing</h2>
        <button type="button" class="admin-layer__toggle" data-layer-toggle>
            <svg class="admin-layer__toggle-chevron" width="14" height="14" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 7l5 5 5-5"/></svg>
            Collapse
        </button>
    </div>
    <div class="admin-layer__body">
    <div class="admin-panel-grid admin-panel-grid--dig<?= $teamPerformance ? '3' : '' ?>">

        <?php if (has_permission('enquiries.view')): ?>
        <div class="admin-panel admin-panel--recent-enquiries">
            <div class="admin-panel__head"><h3 class="admin-panel__title">Recent Enquiries</h3><a href="/admin/enquiries/" class="btn btn-sm btn-outline">View All</a></div>
            <div class="admin-quick-filters">
                <a href="/admin/enquiries/" class="is-active">All</a>
                <a href="/admin/enquiries/?status=new_enquiry">New</a>
                <a href="/admin/enquiries/?status=processing">In Progress</a>
                <a href="/admin/enquiries/?status=additional_info_required">Waiting Customer</a>
                <a href="/admin/enquiries/?sla=breached" data-tone="red">SLA Breached</a>
            </div>
            <?php if (!$recentEnquiries): ?>
            <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No new enquiries today.</p>
            <?php else: ?>
            <?php
            // SLA countdown per row — same overdue/due-soon math already
            // used for Top Priorities/KPI Risk bucket, just rendered per
            // enquiry rather than aggregated.
            $slaCell = static function (?string $dueAt): string {
                if ($dueAt === null) {
                    return '<span class="admin-sla-chip is-none">&mdash;</span>';
                }
                $hoursLeft = ((new DateTimeImmutable($dueAt))->getTimestamp() - time()) / 3600;
                if ($hoursLeft < 0) {
                    return '<span class="admin-sla-chip is-red">' . (int) round(abs($hoursLeft)) . 'h overdue</span>';
                }
                if ($hoursLeft <= 6) {
                    return '<span class="admin-sla-chip is-orange">' . (int) round($hoursLeft) . 'h left</span>';
                }
                if ($hoursLeft <= 24) {
                    return '<span class="admin-sla-chip is-yellow">' . (int) round($hoursLeft) . 'h left</span>';
                }
                return '<span class="admin-sla-chip is-green">' . (int) round($hoursLeft / 24) . 'd left</span>';
            };
            ?>
            <div class="admin-table-scroll">
            <table class="admin-table">
                <thead><tr><th>Reference</th><th>Customer</th><th>Service</th><th>Country</th><th>Status</th><th>Priority</th><th>SLA</th><th>Created</th></tr></thead>
                <tbody>
                <?php foreach ($recentEnquiries as $enq): ?>
                <tr>
                    <td><a href="/admin/enquiries/?id=<?= (int) $enq['id'] ?>"><?= e($enq['enquiry_number']) ?></a></td>
                    <td><?= e($enq['name']) ?></td>
                    <td><?= e(ucfirst($enq['service_category'])) ?></td>
                    <td><?= $enq['country_name'] ? e($enq['country_name']) : '—' ?></td>
                    <td><span class="badge badge-info"><?= e(enquiry_customer_status_label($enq['status'])) ?></span></td>
                    <td><span class="badge <?= $enq['priority'] === 'urgent' ? 'badge-danger' : ($enq['priority'] === 'high' ? 'badge-warning' : 'badge-neutral') ?>"><?= e(ucfirst($enq['priority'])) ?></span></td>
                    <td><?= $slaCell($enq['sla_due_at']) ?></td>
                    <td><?= e(date('d M, H:i', strtotime($enq['created_at']))) ?></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
            <div class="admin-card-list">
                <?php foreach ($recentEnquiries as $enq): ?>
                <div class="admin-record-card">
                    <p class="admin-record-card__title"><?= e($enq['name']) ?></p>
                    <div class="admin-record-card__row"><span>Service</span><strong><?= e(ucfirst($enq['service_category'])) ?><?= $enq['country_name'] ? ' — ' . e($enq['country_name']) : '' ?></strong></div>
                    <div class="admin-record-card__row"><span>Status</span><strong><?= e(enquiry_customer_status_label($enq['status'])) ?></strong></div>
                    <div class="admin-record-card__row"><span>SLA</span><strong><?= $slaCell($enq['sla_due_at']) ?></strong></div>
                    <div class="admin-record-card__action"><a href="/admin/enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-sm btn-outline">Open Case</a></div>
                </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if (has_permission('reminders.manage')): ?>
        <div class="admin-panel admin-panel--tasks">
            <div class="admin-panel__head"><h3 class="admin-panel__title">Tasks</h3><a href="/admin/reminders/" class="btn btn-sm btn-outline">View All</a></div>
            <div class="admin-tabstrip">
                <a href="/admin/dashboard/?tasks=overdue" class="<?= $tasksTab === 'overdue' ? 'is-active' : '' ?>">Overdue <?php if ($reminderCounts['overdue']): ?><span class="badge badge-danger"><?= $reminderCounts['overdue'] ?></span><?php endif; ?></a>
                <a href="/admin/dashboard/?tasks=today" class="<?= $tasksTab === 'today' ? 'is-active' : '' ?>">Due Today <?php if ($reminderCounts['today']): ?><span class="badge badge-warning"><?= $reminderCounts['today'] ?></span><?php endif; ?></a>
                <a href="/admin/dashboard/?tasks=upcoming" class="<?= $tasksTab === 'upcoming' ? 'is-active' : '' ?>">Upcoming <?php if ($reminderCounts['upcoming']): ?><span class="badge badge-neutral"><?= $reminderCounts['upcoming'] ?></span><?php endif; ?></a>
            </div>
            <?php if (!$tasks): ?>
            <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>You're all caught up.</p>
            <?php else: ?>
            <ul class="admin-task-list">
                <?php foreach (array_slice($tasks, 0, 8) as $t): ?>
                <li class="admin-task-row">
                    <div class="admin-task-row__body">
                        <p class="admin-task-row__title"><?= e($t['title']) ?></p>
                        <p class="admin-task-row__meta"><?= $t['enquiry_customer_name'] ? e($t['enquiry_customer_name']) . ' &middot; ' : '' ?><?= e($t['assigned_name'] ?? 'Unassigned') ?></p>
                    </div>
                    <span class="admin-task-row__due<?= $tasksTab === 'overdue' ? ' is-overdue' : ($tasksTab === 'today' ? ' is-today' : '') ?>"><?= e(date('d M', strtotime($t['due_date']))) ?></span>
                    <a href="<?= $t['enquiry_id'] ? '/admin/enquiries/?id=' . (int) $t['enquiry_id'] : '/admin/reminders/' ?>" class="btn btn-sm btn-outline">Open Task</a>
                </li>
                <?php endforeach; ?>
            </ul>
            <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if ($teamPerformance): ?>
        <div class="admin-panel admin-panel--team">
            <div class="admin-panel__head"><h3 class="admin-panel__title">Team Performance</h3><span class="admin-panel__meta">This month</span></div>
            <div class="admin-table-scroll">
            <table class="admin-table admin-team-table">
                <thead><tr><th>Employee</th><th>Open</th><th>Done</th><th>SLA</th></tr></thead>
                <tbody>
                <?php foreach ($teamPerformance as $t):
                    $open = (int) $t['assigned_open'];
                    $breaches = (int) $t['breaches'];
                    // Real, derived from the same counts already computed
                    // above — no new query, no invented figure.
                    $slaPct = $open > 0 ? (int) round(($open - $breaches) / $open * 100) : 100;
                ?>
                <tr>
                    <td>
                        <span class="admin-avatar-chip"><span class="admin-avatar-chip__initials"><?= e(admin_initials($t['full_name'])) ?></span><?= e($t['full_name']) ?></span>
                    </td>
                    <td><?= $open ?></td>
                    <td><?= (int) $t['completed_month'] ?></td>
                    <td>
                        <div class="admin-sla-bar" title="<?= $slaPct ?>% breach-free">
                            <div class="admin-sla-bar__track"><div class="admin-sla-bar__fill<?= $slaPct < 80 ? ' is-low' : '' ?>" style="width:<?= $slaPct ?>%"></div></div>
                            <span class="admin-sla-bar__pct"><?= $slaPct ?>%</span>
                        </div>
                    </td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
        </div>
        <?php endif; ?>

    </div>
    </div>
</div>

</div>

<?php
$quickActions = [];
if (has_permission('customers.manage')) {
    $quickActions[] = ['label' => 'Add Customer', 'href' => '/admin/customers/?action=create', 'icon' => '<svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="8" cy="6.5" r="3"/><path d="M2.5 17c0-3.6 2.5-5.8 5.5-5.8M14 5v6M11 8h6"/></svg>'];
}
if (has_permission('visa.manage')) {
    $quickActions[] = ['label' => 'Visa Application', 'href' => '/admin/visa-applications/?action=create', 'icon' => '<svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="14" height="14" rx="1.5"/><path d="M7 10h6M10 7v6"/></svg>'];
}
if (has_permission('reminders.manage')) {
    $quickActions[] = ['label' => 'Create Task', 'href' => '/admin/reminders/?action=create', 'icon' => '<svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>'];
}
if (has_permission('forex.requests.manage')) {
    $quickActions[] = ['label' => 'Forex Request', 'href' => '/admin/forex-requests/?action=create', 'icon' => '<svg width="16" height="16" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="10" cy="10" r="7"/><path d="M7.5 8.5c0-1 1-1.7 2.5-1.7s2.5.6 2.5 1.5c0 2-5 1.3-5 3.4 0 .9 1 1.5 2.5 1.5s2.5-.7 2.5-1.7M10 5.5v9"/></svg>'];
}
?>
<?php if ($unassignedCount > 0 || $quickActions): ?>
<div class="admin-bottom-ops">
    <?php if ($unassignedCount > 0): ?>
    <div class="admin-panel admin-unassigned-block">
        <span class="admin-unassigned-block__icon"><svg width="22" height="22" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.5" aria-hidden="true"><circle cx="10" cy="6.5" r="3"/><path d="M4.5 17c0-3.6 2.4-5.8 5.5-5.8" stroke-dasharray="2 2"/></svg></span>
        <div class="admin-unassigned-block__body">
            <h3 class="admin-panel__title">Unassigned Cases</h3>
            <p><span class="admin-unassigned-block__count"><?= $unassignedCount ?></span> case<?= $unassignedCount === 1 ? '' : 's' ?> waiting for assignment</p>
        </div>
        <a href="/admin/enquiries/?status=new_enquiry" class="btn btn-sm btn-primary">Assign Now</a>
    </div>
    <?php endif; ?>
    <?php if ($quickActions): ?>
    <div class="admin-panel admin-quick-actions">
        <h3 class="admin-panel__title">Quick Actions</h3>
        <div class="admin-quick-actions__row">
            <?php foreach ($quickActions as $qa): ?>
            <a href="<?= e($qa['href']) ?>" class="admin-quick-action"><?= $qa['icon'] ?><?= e($qa['label']) ?></a>
            <?php endforeach; ?>
        </div>
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

<?php
admin_header_end();
