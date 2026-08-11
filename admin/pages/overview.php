<?php
declare(strict_types=1);

$pdo = db();

$totalUsers = (int) $pdo->query(
    "SELECT COUNT(*) FROM users u JOIN roles r ON r.id = u.role_id WHERE r.name = 'customer' AND u.deleted_at IS NULL"
)->fetchColumn();

$totalApplications = (int) $pdo->query('SELECT COUNT(*) FROM applications WHERE deleted_at IS NULL')->fetchColumn();

$activeApplications = (int) $pdo->query(
    "SELECT COUNT(*) FROM applications WHERE status != 'completed' AND deleted_at IS NULL"
)->fetchColumn();

$documentsPendingReview = (int) $pdo->query(
    "SELECT COUNT(*) FROM application_documents WHERE status IN ('uploaded', 'under_review') AND deleted_at IS NULL"
)->fetchColumn();

$openTickets = (int) $pdo->query(
    "SELECT COUNT(*) FROM support_tickets WHERE status IN ('open', 'in_progress')"
)->fetchColumn();

$recentApplications = $pdo->query(
    "SELECT a.*, u.full_name, u.email, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN users u ON u.id = a.user_id
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.deleted_at IS NULL
     ORDER BY a.created_at DESC LIMIT 5"
)->fetchAll();

render_admin_start('overview', 'Admin Overview');
?>
<div class="stat-grid">
    <div class="stat-tile">
        <div class="stat-tile__label">Total Customers</div>
        <div class="stat-tile__value"><?= $totalUsers ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Total Applications</div>
        <div class="stat-tile__value"><?= $totalApplications ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Active Applications</div>
        <div class="stat-tile__value"><?= $activeApplications ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Documents Pending Review</div>
        <div class="stat-tile__value"><?= $documentsPendingReview ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Open Support Tickets</div>
        <div class="stat-tile__value"><?= $openTickets ?></div>
    </div>
</div>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Recent Applications</h2>
<?php if ($recentApplications): ?>
<?php foreach ($recentApplications as $app): ?>
<a href="/admin/applications/<?= (int) $app['id'] ?>/" class="card application-card">
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
<p><a href="/admin/applications/">View all applications &rarr;</a></p>
<?php else: ?>
<p class="empty-state">No applications yet.</p>
<?php endif; ?>
<?php render_admin_end(); ?>
