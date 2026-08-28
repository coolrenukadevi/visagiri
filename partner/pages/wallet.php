<?php
declare(strict_types=1);

/**
 * Read-only view of a partner's wallet ledger and invoices — both are
 * entirely staff-driven (Phase 6 admin CRM), a partner never posts a
 * transaction or creates an invoice themselves here.
 */

$partner = current_partner();
$pdo = db();

$walletStmt = $pdo->prepare('SELECT * FROM partner_wallet_transactions WHERE partner_id = :id ORDER BY created_at DESC');
$walletStmt->execute(['id' => $partner['id']]);
$walletTransactions = $walletStmt->fetchAll();
$walletBalance = 0.0;
foreach ($walletTransactions as $wt) {
    $walletBalance += $wt['type'] === 'credit' ? (float) $wt['amount'] : -(float) $wt['amount'];
}

$invoicesStmt = $pdo->prepare("SELECT * FROM partner_invoices WHERE partner_id = :id ORDER BY created_at DESC");
$invoicesStmt->execute(['id' => $partner['id']]);
$invoices = $invoicesStmt->fetchAll();

render_partner_start('wallet', 'Wallet');
?>
<div class="stats-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:var(--space-4);margin-bottom:var(--space-6)">
    <div class="card"><div class="card-title" style="font-size:var(--font-size-2xl)">₹<?= number_format($walletBalance, 2) ?></div><p>Wallet Balance</p></div>
</div>

<h2 class="country-directory__subheading">Transactions</h2>
<?php if (!$walletTransactions): ?>
<p class="empty-state">No wallet transactions yet — these appear once your commissions are approved or a manual entry is recorded.</p>
<?php else: ?>
<div class="table-wrap" style="margin-bottom:var(--space-6)">
    <table class="admin-table">
        <thead><tr><th>Type</th><th>Amount</th><th>Reason</th><th>When</th></tr></thead>
        <tbody>
        <?php foreach ($walletTransactions as $wt): ?>
        <tr>
            <td><span class="badge <?= $wt['type'] === 'credit' ? 'badge-success' : 'badge-danger' ?>"><?= e(ucfirst($wt['type'])) ?></span></td>
            <td><?= e(number_format((float) $wt['amount'], 2)) ?></td>
            <td><?= e($wt['reason']) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $wt['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>

<h2 class="country-directory__subheading">Invoices</h2>
<?php if (!$invoices): ?>
<p class="empty-state">No invoices issued yet.</p>
<?php else: ?>
<div class="table-wrap">
    <table class="admin-table">
        <thead><tr><th>Reference</th><th>Period</th><th>Amount</th><th>Status</th></tr></thead>
        <tbody>
        <?php foreach ($invoices as $inv): ?>
        <tr>
            <td><?= e($inv['invoice_reference_no']) ?></td>
            <td><?= $inv['period_start'] ? e(date('d M Y', strtotime((string) $inv['period_start']))) . ' – ' . e(date('d M Y', strtotime((string) $inv['period_end']))) : '—' ?></td>
            <td><?= e(number_format((float) $inv['total_amount'], 2)) ?></td>
            <td><span class="badge <?= $inv['status'] === 'paid' ? 'badge-success' : ($inv['status'] === 'issued' ? 'badge-info' : 'badge-neutral') ?>"><?= e(ucfirst($inv['status'])) ?></span></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>
<?php render_partner_end(); ?>
