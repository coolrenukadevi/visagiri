<?php
declare(strict_types=1);

$consultant = current_user();
$pdo = db();

$stmt = $pdo->prepare("SELECT COUNT(*) FROM applications WHERE assigned_consultant_id = :id AND deleted_at IS NULL");
$stmt->execute(['id' => $consultant['id']]);
$totalAssigned = (int) $stmt->fetchColumn();

$stmt = $pdo->prepare(
    "SELECT COUNT(*) FROM applications WHERE assigned_consultant_id = :id AND status != 'completed' AND deleted_at IS NULL"
);
$stmt->execute(['id' => $consultant['id']]);
$activeAssigned = (int) $stmt->fetchColumn();

$stmt = $pdo->prepare(
    "SELECT COUNT(*) FROM application_documents ad
     JOIN applications a ON a.id = ad.application_id
     WHERE a.assigned_consultant_id = :id AND ad.status IN ('uploaded', 'under_review')
           AND ad.deleted_at IS NULL AND a.deleted_at IS NULL"
);
$stmt->execute(['id' => $consultant['id']]);
$documentsPendingReview = (int) $stmt->fetchColumn();

$stmt = $pdo->prepare(
    "SELECT a.*, u.full_name, u.email, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN users u ON u.id = a.user_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.assigned_consultant_id = :id AND a.deleted_at IS NULL
     ORDER BY a.created_at DESC LIMIT 5"
);
$stmt->execute(['id' => $consultant['id']]);
$recentApplications = $stmt->fetchAll();

render_consultant_start('overview', 'Welcome back, ' . $consultant['full_name']);
?>
<div class="stat-grid">
    <div class="stat-tile">
        <div class="stat-tile__label">Assigned Applications</div>
        <div class="stat-tile__value"><?= $totalAssigned ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Active Applications</div>
        <div class="stat-tile__value"><?= $activeAssigned ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Documents Pending My Review</div>
        <div class="stat-tile__value"><?= $documentsPendingReview ?></div>
    </div>
</div>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Recent Applications</h2>
<?php if ($recentApplications): ?>
<?php foreach ($recentApplications as $app): ?>
<a href="/consultant/applications/<?= (int) $app['id'] ?>/" class="card application-card">
    <div class="application-card__top">
        <div>
            <span class="application-card__id"><?= e($app['application_number']) ?></span>
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
            <div class="list-row__meta"><?= e($app['full_name']) ?> &middot; <?= e($app['email']) ?></div>
        </div>
        <span class="badge badge-info"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
    </div>
</a>
<?php endforeach; ?>
<p><a href="/consultant/applications/">View all my applications &rarr;</a></p>
<?php else: ?>
<p class="empty-state">No applications assigned to you yet.</p>
<?php endif; ?>
<?php render_consultant_end(); ?>
