<?php
declare(strict_types=1);

$customer = current_customer();

$stmt = db()->prepare(
    "SELECT ca.*, va.application_reference_no FROM customer_appointments ca
     LEFT JOIN visa_applications va ON va.id = ca.visa_application_id
     WHERE ca.customer_id = :id
     ORDER BY ca.scheduled_at DESC"
);
$stmt->execute(['id' => $customer['id']]);
$appointments = $stmt->fetchAll();

render_dashboard_start('appointments', 'Appointments');
?>
<?php if (!$appointments): ?>
<p class="empty-state">No appointments scheduled yet. Your consultant will schedule biometric, embassy, or document-submission appointments here as your application progresses.</p>
<?php else: ?>
<?php foreach ($appointments as $appt): ?>
<div class="card" style="margin-bottom:var(--space-4)">
    <div class="application-card__top">
        <div>
            <div class="card-title"><?= e($appt['appointment_type']) ?></div>
            <p style="margin:var(--space-1) 0 0"><?= e(date('d M Y, g:i A', strtotime((string) $appt['scheduled_at']))) ?><?= $appt['location'] ? ' — ' . e($appt['location']) : '' ?></p>
        </div>
        <span class="badge <?= $appt['status'] === 'completed' ? 'badge-success' : ($appt['status'] === 'cancelled' ? 'badge-danger' : 'badge-info') ?>"><?= e($appt['status']) ?></span>
    </div>
    <?php if ($appt['application_reference_no']): ?><p style="margin-top:var(--space-3);font-size:var(--font-size-sm)"><a href="/dashboard/applications/?id=<?= (int) $appt['visa_application_id'] ?>">View related application: <?= e($appt['application_reference_no']) ?></a></p><?php endif; ?>
    <?php if ($appt['notes']): ?><p style="margin-top:var(--space-2);font-size:var(--font-size-sm);color:var(--text-muted)"><?= nl2br(e($appt['notes'])) ?></p><?php endif; ?>
</div>
<?php endforeach; ?>
<?php endif; ?>
<?php render_dashboard_end(); ?>
