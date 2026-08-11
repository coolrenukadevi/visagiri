<?php
declare(strict_types=1);

$pdo = db();
$statusFilter = $_GET['status'] ?? '';
$validStatuses = array_keys(application_status_stages());

$sql = "SELECT a.*, u.full_name, u.email, c.name AS country_name, c.iso2, vt.name AS visa_type_name
        FROM applications a
        JOIN users u ON u.id = a.user_id
        JOIN countries c ON c.id = a.country_id
        JOIN visa_types vt ON vt.id = a.visa_type_id
        WHERE a.deleted_at IS NULL";
$params = [];
if (in_array($statusFilter, $validStatuses, true)) {
    $sql .= ' AND a.status = :status';
    $params['status'] = $statusFilter;
}
$sql .= ' ORDER BY a.created_at DESC';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$applications = $stmt->fetchAll();

render_admin_start('applications', 'All Applications');
?>
<div class="button-group" style="margin-bottom:var(--space-6);flex-wrap:wrap">
    <a href="/admin/applications/" class="btn btn-sm <?= $statusFilter === '' ? 'btn-primary' : 'btn-outline' ?>">All</a>
    <?php foreach (application_status_stages() as $key => $label): ?>
    <a href="/admin/applications/?status=<?= e($key) ?>" class="btn btn-sm <?= $statusFilter === $key ? 'btn-primary' : 'btn-outline' ?>"><?= e($label) ?></a>
    <?php endforeach; ?>
</div>

<?php if ($applications): ?>
<?php foreach ($applications as $app): ?>
<a href="/admin/applications/<?= (int) $app['id'] ?>/" class="card application-card">
    <div class="application-card__top">
        <div>
            <span class="application-card__id"><?= e($app['application_number']) ?></span>
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
            <div class="list-row__meta"><?= e($app['full_name']) ?> &middot; <?= e($app['email']) ?></div>
        </div>
        <span class="badge badge-info"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
    </div>
    <div class="application-card__meta">
        <span>Applied: <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></span>
        <span>Progress: <?= (int) $app['progress_percent'] ?>%</span>
    </div>
</a>
<?php endforeach; ?>
<?php else: ?>
<p class="empty-state">No applications match this filter.</p>
<?php endif; ?>
<?php render_admin_end(); ?>
