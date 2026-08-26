<?php
declare(strict_types=1);

$customer = current_customer();

$stmt = db()->prepare(
    "SELECT vp.*, va.application_reference_no, c.name AS country_name, vt.name AS visa_type_name
     FROM visa_payments vp
     JOIN visa_applications va ON va.id = vp.visa_application_id
     JOIN countries c ON c.id = va.country_id
     JOIN visa_types vt ON vt.id = va.visa_type_id
     WHERE va.customer_id = :id AND va.deleted_at IS NULL
     ORDER BY vp.created_at DESC"
);
$stmt->execute(['id' => $customer['id']]);
$payments = $stmt->fetchAll();

render_dashboard_start('payments', 'Payments');
?>
<?php if (!$payments): ?>
<p class="empty-state">No payments recorded yet.</p>
<?php else: ?>
<div class="table-wrap">
    <table class="admin-table">
        <thead><tr><th>Application</th><th>Amount</th><th>Method</th><th>Status</th><th>Date</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
        <tr>
            <td><a href="/dashboard/applications/?id=<?= (int) $p['visa_application_id'] ?>"><?= e($p['visa_type_name']) ?> — <?= e($p['country_name']) ?></a></td>
            <td><?= e($p['currency']) ?> <?= number_format((float) $p['amount'], 2) ?></td>
            <td><?= e($p['payment_method'] ?? '—') ?></td>
            <td><span class="badge <?= $p['status'] === 'received' ? 'badge-success' : ($p['status'] === 'refunded' ? 'badge-danger' : 'badge-warning') ?>"><?= e($p['status']) ?></span></td>
            <td><?= $p['paid_at'] ? e(date('d M Y', strtotime((string) $p['paid_at']))) : e(date('d M Y', strtotime((string) $p['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>
<?php endif; ?>
<?php render_dashboard_end(); ?>
