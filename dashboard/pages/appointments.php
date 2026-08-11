<?php
declare(strict_types=1);

$user = current_user();
$stmt = db()->prepare(
    "SELECT ap.*, a.application_number, a.id AS application_id, c.name AS country_name, vt.name AS visa_type_name
     FROM appointments ap
     JOIN applications a ON a.id = ap.application_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.user_id = :id AND a.deleted_at IS NULL
     ORDER BY ap.scheduled_at ASC"
);
$stmt->execute(['id' => $user['id']]);
$appointments = $stmt->fetchAll();

render_dashboard_start('appointments', 'Appointments');
?>
<?php if ($appointments): ?>
<?php foreach ($appointments as $appt): ?>
<a href="/dashboard/applications/<?= (int) $appt['application_id'] ?>/" class="list-row">
    <span>
        <span class="list-row__title"><?= e(ucfirst(str_replace('_', ' ', $appt['type']))) ?></span><br>
        <span class="list-row__meta"><?= e($appt['application_number']) ?> &middot; <?= e($appt['visa_type_name']) ?> &mdash; <?= e($appt['country_name']) ?> &middot; <?= e(date('d M Y, g:i A', strtotime((string) $appt['scheduled_at']))) ?></span>
    </span>
    <span class="badge badge-<?= match ($appt['status']) { 'completed' => 'success', 'cancelled' => 'danger', 'rescheduled' => 'warning', default => 'info' } ?>"><?= e($appt['status']) ?></span>
</a>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No appointments scheduled yet.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
