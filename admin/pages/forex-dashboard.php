<?php
declare(strict_types=1);

require_permission('forex.dashboard.view');

$pdo = db();
$scoped = current_admin_forex_scoped_to_assigned();
$scopeWhere = $scoped ? ' AND assigned_employee = ' . (int) current_admin_id() : '';

$stats = [
    "Today's Requests" => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND DATE(created_at) = CURDATE()$scopeWhere")->fetchColumn(),
    'Pending Documents' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status IN ('awaiting_documents','documents_submitted','documents_under_verification')$scopeWhere")->fetchColumn(),
    'Pending Quotations' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'quotation_preparing'$scopeWhere")->fetchColumn(),
    'Payment Pending' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'payment_pending'$scopeWhere")->fetchColumn(),
    'Compliance Pending' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'compliance_verification'$scopeWhere")->fetchColumn(),
    'Ready for Delivery' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'ready_for_delivery'$scopeWhere")->fetchColumn(),
    'Delivered Today' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'delivered' AND DATE(updated_at) = CURDATE()$scopeWhere")->fetchColumn(),
    'Cancelled' => (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status IN ('cancelled','rejected')$scopeWhere")->fetchColumn(),
];

$quotationValue = (float) $pdo->query(
    "SELECT COALESCE(SUM(q.total_inr_amount), 0) FROM forex_quotations q
     JOIN forex_requests fr ON fr.id = q.forex_request_id
     WHERE q.status IN ('sent','accepted') AND fr.deleted_at IS NULL" . ($scoped ? ' AND fr.assigned_employee = ' . (int) current_admin_id() : '')
)->fetchColumn();

$totalVolume = (float) $pdo->query(
    "SELECT COALESCE(SUM(amount_delivered), 0) FROM forex_deliveries d
     JOIN forex_requests fr ON fr.id = d.forex_request_id
     WHERE fr.deleted_at IS NULL" . ($scoped ? ' AND fr.assigned_employee = ' . (int) current_admin_id() : '')
)->fetchColumn();

$byCurrency = $pdo->query(
    "SELECT currency_code AS label, COALESCE(SUM(amount_delivered), 0) AS total FROM forex_deliveries d
     JOIN forex_requests fr ON fr.id = d.forex_request_id
     WHERE fr.deleted_at IS NULL" . ($scoped ? ' AND fr.assigned_employee = ' . (int) current_admin_id() : '') . "
     GROUP BY currency_code ORDER BY total DESC"
)->fetchAll();

admin_header_start('Forex Dashboard', 'forex-dashboard');
?>
<div class="hrms-stat-grid">
    <?php foreach ($stats as $label => $value): ?>
    <div class="hrms-stat-card">
        <div class="hrms-stat-card__value"><?= $value ?></div>
        <div class="hrms-stat-card__label"><?= e($label) ?></div>
    </div>
    <?php endforeach; ?>
    <div class="hrms-stat-card hrms-stat-card--gold">
        <div class="hrms-stat-card__value">₹<?= e(number_format($quotationValue, 0)) ?></div>
        <div class="hrms-stat-card__label">Open Quotation Value</div>
    </div>
    <div class="hrms-stat-card hrms-stat-card--success">
        <div class="hrms-stat-card__value">₹<?= e(number_format($totalVolume, 0)) ?></div>
        <div class="hrms-stat-card__label">Total Forex Delivered (INR value at quote)</div>
    </div>
</div>

<div class="card" style="max-width:500px">
    <div class="card-title">Currency-wise Delivered Volume</div>
    <?php if ($byCurrency): ?>
    <?php $max = max(array_column($byCurrency, 'total')) ?: 1; ?>
    <?php foreach ($byCurrency as $row): ?>
    <div style="margin-bottom:var(--space-3)">
        <div style="display:flex;justify-content:space-between;font-size:var(--font-size-sm);margin-bottom:var(--space-1)"><span><?= e($row['label']) ?></span><strong><?= e(number_format((float) $row['total'], 2)) ?></strong></div>
        <div style="background:var(--border);border-radius:var(--radius-full);height:8px;overflow:hidden"><div style="background:var(--visa-blue);height:100%;width:<?= round(((float) $row['total'] / $max) * 100) ?>%"></div></div>
    </div>
    <?php endforeach; ?>
    <?php else: ?>
    <p class="empty-state">No deliveries recorded yet.</p>
    <?php endif; ?>
</div>
<?php
admin_header_end();
