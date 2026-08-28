<?php
/** Partner dashboard overview. */
$page_meta = ['title' => 'Partner Dashboard | Paynancial', 'heading' => 'Dashboard'];

$pdo = db();
$stmt = $pdo->prepare('SELECT id, partner_code, kyc_status, commission_rate FROM partners WHERE user_id = :uid');
$stmt->execute(['uid' => $auth_user['id']]);
$partner = $stmt->fetch();
$partnerId = $partner['id'] ?? 0;

$txnStmt = $pdo->prepare(
    "SELECT COUNT(*) AS cnt, COALESCE(SUM(amount),0) AS total,
     SUM(CASE WHEN status='success' THEN 1 ELSE 0 END) AS success_cnt
     FROM transactions WHERE partner_id = :pid"
);
$txnStmt->execute(['pid' => $partnerId]);
$txn = $txnStmt->fetch();

$settleStmt = $pdo->prepare(
    "SELECT COALESCE(SUM(net_amount),0) AS pending FROM settlements WHERE partner_id = :pid AND status IN ('pending','processing')"
);
$settleStmt->execute(['pid' => $partnerId]);
$pendingSettlement = $settleStmt->fetchColumn();

$commStmt = $pdo->prepare("SELECT COALESCE(SUM(amount),0) FROM commissions WHERE partner_id = :pid AND status = 'accrued'");
$commStmt->execute(['pid' => $partnerId]);
$commission = $commStmt->fetchColumn();

$recentStmt = $pdo->prepare(
    'SELECT transaction_ref, amount, currency, status, created_at FROM transactions
     WHERE partner_id = :pid ORDER BY created_at DESC LIMIT 8'
);
$recentStmt->execute(['pid' => $partnerId]);
$recent = $recentStmt->fetchAll();
?>
<div class="stat-grid">
  <div class="stat-card"><span class="label">Total Transactions</span><strong class="value"><?= (int) $txn['cnt'] ?></strong></div>
  <div class="stat-card"><span class="label">Total Collection</span><strong class="value"><?= e(format_amount((float) $txn['total'])) ?></strong></div>
  <div class="stat-card"><span class="label">Successful Payments</span><strong class="value"><?= (int) $txn['success_cnt'] ?></strong></div>
  <div class="stat-card"><span class="label">Pending Settlement</span><strong class="value"><?= e(format_amount((float) $pendingSettlement)) ?></strong></div>
  <div class="stat-card"><span class="label">Partner Earnings (Commission)</span><strong class="value"><?= e(format_amount((float) $commission)) ?></strong></div>
  <div class="stat-card"><span class="label">KYC Status</span><strong class="value" style="font-size:1.1rem;text-transform:capitalize;"><?= e(str_replace('_', ' ', $partner['kyc_status'] ?? 'not started')) ?></strong></div>
</div>

<div class="panel">
  <div class="panel-head"><h2>Recent Transactions</h2><a href="/partner/transactions" class="btn btn-outline btn-sm">View All</a></div>
  <div class="data-table-wrap">
    <table class="data-table">
      <thead><tr><th>Reference</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead>
      <tbody>
        <?php if (empty($recent)): ?>
          <tr><td colspan="4"><div class="empty-state">No transactions yet.</div></td></tr>
        <?php else: foreach ($recent as $row): ?>
          <tr>
            <td><?= e($row['transaction_ref']) ?></td>
            <td><?= e(format_amount((float) $row['amount'], $row['currency'])) ?></td>
            <td><span class="badge <?= e($row['status'] === 'success' ? 'success' : ($row['status'] === 'failed' ? 'failed' : 'pending')) ?>"><?= e(ucfirst($row['status'])) ?></span></td>
            <td><?= e(date('d M Y, H:i', strtotime((string) $row['created_at']))) ?></td>
          </tr>
        <?php endforeach; endif; ?>
      </tbody>
    </table>
  </div>
</div>
