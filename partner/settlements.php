<?php
/** Partner: settlements + commission tracking. */
$page_meta = ['title' => 'Settlements | Paynancial Partner Portal', 'heading' => 'Settlements & Commission'];

$pdo = db();
$stmt = $pdo->prepare('SELECT id FROM partners WHERE user_id = :uid');
$stmt->execute(['uid' => $auth_user['id']]);
$partnerId = (int) ($stmt->fetchColumn() ?: 0);

$settlements = $pdo->prepare(
    'SELECT settlement_ref, period_start, period_end, gross_amount, fee_amount, net_amount, status, settled_at
     FROM settlements WHERE partner_id = :pid ORDER BY period_end DESC LIMIT 50'
);
$settlements->execute(['pid' => $partnerId]);
$settlementRows = $settlements->fetchAll();

$commissions = $pdo->prepare(
    'SELECT amount, rate_applied, status, created_at FROM commissions WHERE partner_id = :pid ORDER BY created_at DESC LIMIT 50'
);
$commissions->execute(['pid' => $partnerId]);
$commissionRows = $commissions->fetchAll();
?>
<div class="panel">
  <div class="panel-head"><h2>Settlements</h2></div>
  <div class="data-table-wrap">
    <table class="data-table">
      <thead><tr><th>Reference</th><th>Period</th><th>Gross</th><th>Fee</th><th>Net</th><th>Status</th></tr></thead>
      <tbody>
        <?php if (empty($settlementRows)): ?>
          <tr><td colspan="6"><div class="empty-state">No settlements recorded yet.</div></td></tr>
        <?php else: foreach ($settlementRows as $row): ?>
          <tr>
            <td><?= e($row['settlement_ref']) ?></td>
            <td><?= e($row['period_start']) ?> – <?= e($row['period_end']) ?></td>
            <td><?= e(format_amount((float) $row['gross_amount'])) ?></td>
            <td><?= e(format_amount((float) $row['fee_amount'])) ?></td>
            <td><?= e(format_amount((float) $row['net_amount'])) ?></td>
            <td><span class="badge <?= $row['status'] === 'settled' ? 'success' : 'pending' ?>"><?= e(ucfirst($row['status'])) ?></span></td>
          </tr>
        <?php endforeach; endif; ?>
      </tbody>
    </table>
  </div>
</div>

<div class="panel">
  <div class="panel-head"><h2>Commission History</h2></div>
  <div class="data-table-wrap">
    <table class="data-table">
      <thead><tr><th>Amount</th><th>Rate</th><th>Status</th><th>Date</th></tr></thead>
      <tbody>
        <?php if (empty($commissionRows)): ?>
          <tr><td colspan="4"><div class="empty-state">No commission activity yet.</div></td></tr>
        <?php else: foreach ($commissionRows as $row): ?>
          <tr>
            <td><?= e(format_amount((float) $row['amount'])) ?></td>
            <td><?= e($row['rate_applied']) ?>%</td>
            <td><span class="badge <?= $row['status'] === 'paid' ? 'success' : 'info' ?>"><?= e(ucfirst($row['status'])) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $row['created_at']))) ?></td>
          </tr>
        <?php endforeach; endif; ?>
      </tbody>
    </table>
  </div>
</div>
