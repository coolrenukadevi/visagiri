<?php
declare(strict_types=1);

/**
 * Unified Sales CRM hub — a single lead list pulling together every
 * source that generates a sales lead today: Visa/Apostille Enquiries
 * (enquiries), General & Attestation Enquiries (general_enquiries),
 * Forex Requests (forex_requests), and B2B Partner Enquiries
 * (partner_enquiries). Each of those keeps its own detail/management
 * page and its own RBAC permission (unchanged) — this hub only reads
 * and links out, it never writes. A row is shown here only if the
 * current admin already holds the underlying permission for that
 * lead type, so this page never grants visibility beyond what the
 * role already has.
 */

$canViewEnquiries = has_permission('enquiries.view');
$canViewGeneral = has_permission('general_enquiries.view');
$canViewForex = has_permission('forex.requests.view');
$canViewPartnerEnquiries = has_permission('partners.view');

if (!$canViewEnquiries && !$canViewGeneral && !$canViewForex && !$canViewPartnerEnquiries) {
    http_response_code(403);
    exit('You do not have permission to view the Sales CRM.');
}

$pdo = db();
$typeFilter = in_array($_GET['type'] ?? '', ['visa_apostille', 'general', 'forex', 'partner'], true) ? $_GET['type'] : null;

$leads = [];

if ($canViewEnquiries && (!$typeFilter || $typeFilter === 'visa_apostille')) {
    $stmt = $pdo->query(
        "SELECT id, enquiry_number AS reference, name, email, mobile_number AS phone,
                (CASE WHEN service_category = 'visa' THEN 'Visa Enquiry' ELSE 'Apostille Enquiry' END) AS subject,
                status, created_at
         FROM enquiries WHERE deleted_at IS NULL ORDER BY created_at DESC LIMIT 50"
    );
    foreach ($stmt->fetchAll() as $row) {
        $leads[] = [
            'type' => 'visa_apostille', 'type_label' => 'Visa/Apostille', 'badge' => 'info',
            'reference' => $row['reference'], 'name' => $row['name'], 'contact' => $row['email'] . ' · ' . $row['phone'],
            'subject' => $row['subject'], 'status' => enquiry_customer_status_label($row['status']),
            'created_at' => $row['created_at'], 'url' => '/admin/enquiries/?id=' . $row['id'],
        ];
    }
}

if ($canViewGeneral && (!$typeFilter || $typeFilter === 'general')) {
    $stmt = $pdo->query(
        "SELECT id, enquiry_reference_no AS reference, name, email, phone, subject, status, created_at
         FROM general_enquiries WHERE deleted_at IS NULL ORDER BY created_at DESC LIMIT 50"
    );
    foreach ($stmt->fetchAll() as $row) {
        $leads[] = [
            'type' => 'general', 'type_label' => 'General/Attestation', 'badge' => 'neutral',
            'reference' => $row['reference'], 'name' => $row['name'], 'contact' => $row['email'] . ' · ' . ($row['phone'] ?? ''),
            'subject' => $row['subject'] ?? 'General Enquiry', 'status' => ucwords(str_replace('_', ' ', $row['status'])),
            'created_at' => $row['created_at'], 'url' => '/admin/general-enquiries/?id=' . $row['id'],
        ];
    }
}

if ($canViewForex && (!$typeFilter || $typeFilter === 'forex')) {
    $stmt = $pdo->query(
        "SELECT f.id, f.forex_reference_no AS reference, f.status, f.created_at, f.country_of_visit,
                CONCAT(c.first_name, ' ', COALESCE(c.last_name, '')) AS name, c.email, c.mobile AS phone
         FROM forex_requests f JOIN customers c ON c.id = f.customer_id
         WHERE f.deleted_at IS NULL ORDER BY f.created_at DESC LIMIT 50"
    );
    foreach ($stmt->fetchAll() as $row) {
        $leads[] = [
            'type' => 'forex', 'type_label' => 'Forex', 'badge' => 'warning',
            'reference' => $row['reference'], 'name' => trim((string) $row['name']), 'contact' => $row['email'] . ' · ' . ($row['phone'] ?? ''),
            'subject' => 'Forex — ' . $row['country_of_visit'], 'status' => ucwords(str_replace('_', ' ', $row['status'])),
            'created_at' => $row['created_at'], 'url' => '/admin/forex-requests/?action=view&id=' . $row['id'],
        ];
    }
}

if ($canViewPartnerEnquiries && (!$typeFilter || $typeFilter === 'partner')) {
    $stmt = $pdo->query(
        "SELECT id, reference_number AS reference, contact_name AS name, email, company_name, status, created_at
         FROM partner_enquiries WHERE deleted_at IS NULL ORDER BY created_at DESC LIMIT 50"
    );
    foreach ($stmt->fetchAll() as $row) {
        $leads[] = [
            'type' => 'partner', 'type_label' => 'B2B Partner', 'badge' => 'success',
            'reference' => $row['reference'], 'name' => $row['name'], 'contact' => $row['email'],
            'subject' => 'B2B: ' . $row['company_name'], 'status' => ucwords($row['status']),
            'created_at' => $row['created_at'], 'url' => '/admin/partner-enquiries/?id=' . $row['id'],
        ];
    }
}

usort($leads, static fn($a, $b) => strtotime((string) $b['created_at']) <=> strtotime((string) $a['created_at']));
$leads = array_slice($leads, 0, 100);

// Lightweight "new today" / "new this 7 days" counts per type — real
// SQL, not derived from the $leads array above (which is capped at
// 50/type before merge, so it isn't reliable for counting).
$countNewToday = static function (string $table, string $dateCol = 'created_at') use ($pdo): int {
    return (int) $pdo->query("SELECT COUNT(*) FROM `$table` WHERE deleted_at IS NULL AND DATE($dateCol) = CURDATE()")->fetchColumn();
};
$todayCounts = [
    'visa_apostille' => $canViewEnquiries ? $countNewToday('enquiries') : 0,
    'general' => $canViewGeneral ? $countNewToday('general_enquiries') : 0,
    'forex' => $canViewForex ? $countNewToday('forex_requests') : 0,
    'partner' => $canViewPartnerEnquiries ? $countNewToday('partner_enquiries') : 0,
];
$todayTotal = array_sum($todayCounts);

admin_header_start('Sales CRM', 'sales-crm');
admin_subnav('leads', 'sales-crm');
?>
<p style="color:var(--text-muted);max-width:70ch;margin-bottom:var(--space-5)">Every lead your team captures — visa/apostille, general &amp; attestation, forex, and B2B partner enquiries — in one place. Each row opens its own record for full management; nothing here is duplicated data, this is a live combined view.</p>

<div class="admin-stat-grid">
    <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $todayTotal ?></div><div class="admin-stat-card__label">New Leads Today</div></div>
    <?php if ($canViewEnquiries): ?><div class="admin-stat-card"><div class="admin-stat-card__value"><?= $todayCounts['visa_apostille'] ?></div><div class="admin-stat-card__label">Visa/Apostille Today</div></div><?php endif; ?>
    <?php if ($canViewGeneral): ?><div class="admin-stat-card"><div class="admin-stat-card__value"><?= $todayCounts['general'] ?></div><div class="admin-stat-card__label">General/Attestation Today</div></div><?php endif; ?>
    <?php if ($canViewForex): ?><div class="admin-stat-card"><div class="admin-stat-card__value"><?= $todayCounts['forex'] ?></div><div class="admin-stat-card__label">Forex Today</div></div><?php endif; ?>
    <?php if ($canViewPartnerEnquiries): ?><div class="admin-stat-card"><div class="admin-stat-card__value"><?= $todayCounts['partner'] ?></div><div class="admin-stat-card__label">B2B Partner Today</div></div><?php endif; ?>
</div>

<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/sales-crm/" class="btn btn-sm <?= !$typeFilter ? 'btn-primary' : 'btn-outline' ?>">All Leads</a>
        <?php if ($canViewEnquiries): ?><a href="/admin/sales-crm/?type=visa_apostille" class="btn btn-sm <?= $typeFilter === 'visa_apostille' ? 'btn-primary' : 'btn-outline' ?>">Visa/Apostille</a><?php endif; ?>
        <?php if ($canViewGeneral): ?><a href="/admin/sales-crm/?type=general" class="btn btn-sm <?= $typeFilter === 'general' ? 'btn-primary' : 'btn-outline' ?>">General/Attestation</a><?php endif; ?>
        <?php if ($canViewForex): ?><a href="/admin/sales-crm/?type=forex" class="btn btn-sm <?= $typeFilter === 'forex' ? 'btn-primary' : 'btn-outline' ?>">Forex</a><?php endif; ?>
        <?php if ($canViewPartnerEnquiries): ?><a href="/admin/sales-crm/?type=partner" class="btn btn-sm <?= $typeFilter === 'partner' ? 'btn-primary' : 'btn-outline' ?>">B2B Partner</a><?php endif; ?>
    </div>
</div>

<?php if ($leads): ?>
<table class="admin-table">
    <thead><tr><th>Type</th><th>Reference</th><th>Name</th><th>Contact</th><th>Subject</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($leads as $lead): ?>
    <tr>
        <td><span class="badge badge-<?= e($lead['badge']) ?>"><?= e($lead['type_label']) ?></span></td>
        <td><?= e($lead['reference']) ?></td>
        <td><?= e($lead['name']) ?></td>
        <td><?= e($lead['contact']) ?></td>
        <td><?= e($lead['subject']) ?></td>
        <td><?= e($lead['status']) ?></td>
        <td><?= e(date('d M Y H:i', strtotime((string) $lead['created_at']))) ?></td>
        <td class="actions"><a href="<?= e($lead['url']) ?>" class="btn btn-outline btn-sm">View</a></td>
    </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No leads yet.</p>
<?php endif; ?>
<?php
admin_header_end();
