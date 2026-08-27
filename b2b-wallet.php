<?php
ob_start();
$PP_PAGE_TITLE = 'Wallet & Credit';
$PP_ACTIVE_NAV = 'wallet';
require __DIR__ . '/includes/partner-layout-top.php';
partner_require_permission('view_payments');

$pid = partner_id();
$stmt = $pdo->prepare('SELECT * FROM b2b_wallet_transactions WHERE partner_id = ? ORDER BY created_at DESC LIMIT 200');
$stmt->execute([$pid]);
$transactions = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Wallet &amp; Credit</h1>
        <p class="pp-page-subtitle">Your available wallet balance and approved credit limit.</p>
    </div>
</div>

<div class="pp-kpi-grid" style="grid-template-columns:repeat(2,1fr);">
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format((float) $ppPartner['wallet_balance'], 2); ?></div><div class="pp-kpi-label">Wallet Balance</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format((float) $ppPartner['credit_limit'], 2); ?></div><div class="pp-kpi-label">Approved Credit Limit</div></div>
</div>

<div class="pp-card">
    <h3>Transaction History</h3>
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Reference</th><th>Type</th><th>Amount</th><th>Balance After</th><th>Reason</th><th>Date</th></tr></thead>
        <tbody>
        <?php foreach ($transactions as $t): ?>
        <tr>
            <td class="pp-cell-name"><?php echo htmlspecialchars($t['transaction_ref']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($t['type']); ?></td>
            <td>&#8377;<?php echo number_format((float) $t['amount'], 2); ?></td>
            <td class="pp-cell-sub">&#8377;<?php echo number_format((float) $t['balance_after'], 2); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($t['reason'] ?: '—'); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars(substr($t['created_at'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$transactions): ?>
        <tr><td colspan="6" class="pp-empty">No wallet activity yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
