<?php
declare(strict_types=1);

/**
 * Finance hub — a light landing page over the finance-related data
 * that already exists (B2B partner invoices, the wallet ledger inside
 * each partner's profile, and forex payment stages), rather than a
 * new financial ledger. There is no single "finance" table today, so
 * this reads real KPIs from the tables that already carry money
 * amounts and links out to the existing pages that manage them.
 */

$canViewInvoices = has_permission('partners.manage');
$canViewForex = has_permission('forex.requests.view');

if (!$canViewInvoices && !$canViewForex) {
    http_response_code(403);
    exit('You do not have permission to view Finance.');
}

$pdo = db();

$invoiceStats = ['issued_count' => 0, 'issued_total' => 0.0, 'paid_count' => 0, 'paid_total' => 0.0];
if ($canViewInvoices) {
    $row = $pdo->query("SELECT COUNT(*) AS c, COALESCE(SUM(total_amount),0) AS t FROM partner_invoices WHERE status = 'issued'")->fetch();
    $invoiceStats['issued_count'] = (int) $row['c'];
    $invoiceStats['issued_total'] = (float) $row['t'];
    $row = $pdo->query("SELECT COUNT(*) AS c, COALESCE(SUM(total_amount),0) AS t FROM partner_invoices WHERE status = 'paid' AND MONTH(paid_at) = MONTH(CURDATE()) AND YEAR(paid_at) = YEAR(CURDATE())")->fetch();
    $invoiceStats['paid_count'] = (int) $row['c'];
    $invoiceStats['paid_total'] = (float) $row['t'];
}

$forexStats = ['payment_pending' => 0, 'payment_received' => 0];
if ($canViewForex) {
    $forexStats['payment_pending'] = (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'payment_pending'")->fetchColumn();
    $forexStats['payment_received'] = (int) $pdo->query("SELECT COUNT(*) FROM forex_requests WHERE deleted_at IS NULL AND status = 'payment_received'")->fetchColumn();
}

admin_header_start('Finance', 'finance');
?>
<p style="color:var(--text-muted);max-width:70ch;margin-bottom:var(--space-5)">Money-in-motion across B2B partner invoices and forex payment stages. Each figure links to the real page that manages it — nothing here is a separate ledger.</p>

<?php if ($canViewInvoices): ?>
<h2 class="country-directory__subheading">B2B Partner Invoices</h2>
<div class="admin-stat-grid">
    <div class="admin-stat-card"><div class="admin-stat-card__value">₹<?= number_format($invoiceStats['issued_total'], 0) ?></div><div class="admin-stat-card__label">Outstanding (<?= $invoiceStats['issued_count'] ?> issued)</div></div>
    <div class="admin-stat-card"><div class="admin-stat-card__value">₹<?= number_format($invoiceStats['paid_total'], 0) ?></div><div class="admin-stat-card__label">Collected This Month (<?= $invoiceStats['paid_count'] ?> invoices)</div></div>
</div>
<p><a href="/admin/partner-invoices/" class="btn btn-outline btn-sm">Manage Partner Invoices &rarr;</a></p>
<?php endif; ?>

<?php if ($canViewForex): ?>
<h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Forex Payments</h2>
<div class="admin-stat-grid">
    <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $forexStats['payment_pending'] ?></div><div class="admin-stat-card__label">Awaiting Payment</div></div>
    <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $forexStats['payment_received'] ?></div><div class="admin-stat-card__label">Payment Received, Pre-Compliance</div></div>
</div>
<p><a href="/admin/forex-requests/?view=all" class="btn btn-outline btn-sm">Manage Forex Requests &rarr;</a></p>
<?php endif; ?>

<?php if ($canViewInvoices): ?>
<p style="margin-top:var(--space-6);color:var(--text-muted);font-size:var(--font-size-sm)">Wallet balances and commission ledgers are on each partner's own profile — open a partner from <a href="/admin/partners/">B2B Partners</a> to view theirs.</p>
<?php endif; ?>
<?php
admin_header_end();
