<?php
declare(strict_types=1);

$user = current_user();
$stmt = db()->prepare(
    "SELECT p.*, a.application_number, a.id AS application_id, c.name AS country_name, vt.name AS visa_type_name
     FROM payments p
     JOIN applications a ON a.id = p.application_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE p.user_id = :id
     ORDER BY p.created_at DESC"
);
$stmt->execute(['id' => $user['id']]);
$payments = $stmt->fetchAll();

render_dashboard_start('payments', 'Payments');
?>
<?php if ($payments): ?>
<?php foreach ($payments as $payment): ?>
<a href="/dashboard/applications/<?= (int) $payment['application_id'] ?>/" class="list-row">
    <span>
        <span class="list-row__title"><?= e(format_money((float) $payment['amount'], $payment['currency'])) ?> &mdash; <?= e(ucfirst(str_replace('_', ' ', $payment['purpose']))) ?></span><br>
        <span class="list-row__meta"><?= e($payment['application_number']) ?> &middot; <?= e($payment['visa_type_name']) ?> &mdash; <?= e($payment['country_name']) ?></span>
    </span>
    <span class="badge badge-<?= match ($payment['status']) { 'paid' => 'success', 'failed' => 'danger', 'refunded' => 'neutral', default => 'warning' } ?>"><?= e($payment['status']) ?></span>
</a>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No payments recorded yet.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
