<?php
declare(strict_types=1);

$customer = current_customer();

$appsStmt = db()->prepare(
    "SELECT va.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM visa_applications va
     JOIN countries c ON c.id = va.country_id
     JOIN visa_types vt ON vt.id = va.visa_type_id
     WHERE va.customer_id = :id AND va.deleted_at IS NULL
     ORDER BY va.created_at DESC LIMIT 3"
);
$appsStmt->execute(['id' => $customer['id']]);
$recentApplications = $appsStmt->fetchAll();

$totalAppsStmt = db()->prepare('SELECT COUNT(*) FROM visa_applications WHERE customer_id = :id AND deleted_at IS NULL');
$totalAppsStmt->execute(['id' => $customer['id']]);
$totalApplications = (int) $totalAppsStmt->fetchColumn();

$upcomingStmt = db()->prepare(
    "SELECT * FROM customer_appointments WHERE customer_id = :id AND status = 'scheduled' AND scheduled_at >= NOW() ORDER BY scheduled_at ASC LIMIT 1"
);
$upcomingStmt->execute(['id' => $customer['id']]);
$nextAppointment = $upcomingStmt->fetch();

render_dashboard_start('overview', 'Welcome, ' . $customer['first_name']);
?>
<div class="stats-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:var(--space-4);margin-bottom:var(--space-6)">
    <div class="card"><div class="card-title" style="font-size:var(--font-size-2xl)"><?= $totalApplications ?></div><p>Total Applications</p></div>
    <div class="card">
        <div class="card-title" style="font-size:var(--font-size-lg)"><?= $nextAppointment ? e(date('d M Y, g:i A', strtotime((string) $nextAppointment['scheduled_at']))) : 'None scheduled' ?></div>
        <p>Next Appointment</p>
    </div>
    <div class="card"><div class="card-title" style="font-size:var(--font-size-lg)"><?= e($customer['customer_reference_no']) ?></div><p>Your Reference Number</p></div>
</div>

<h2 class="country-directory__subheading">Recent Applications</h2>
<?php if (!$recentApplications): ?>
<p class="empty-state">You don't have any visa applications yet. <a href="/enquire/">Submit an enquiry</a> to get started.</p>
<?php else: ?>
<?php foreach ($recentApplications as $app): ?>
<a href="/dashboard/applications/?id=<?= (int) $app['id'] ?>" class="card application-card">
    <div class="application-card__top">
        <div>
            <span class="application-card__id"><?= e($app['application_reference_no']) ?></span>
            <div class="card-title"><?= flag_emoji($app['iso2']) ?> <?= e($app['visa_type_name']) ?> &mdash; <?= e($app['country_name']) ?></div>
        </div>
        <span class="badge <?= application_status_badge_class($app['status']) ?>"><?= e(str_replace('_', ' ', $app['status'])) ?></span>
    </div>
    <?php if (!in_array($app['status'], ['rejected', 'cancelled'], true)): ?>
    <div class="application-card__meta">
        <span>Applied: <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?></span>
        <span>Progress: <?= application_progress_percent($app['status']) ?>%</span>
    </div>
    <div class="application-card__progress"><div class="application-card__progress-bar" style="width:<?= application_progress_percent($app['status']) ?>%"></div></div>
    <?php endif; ?>
</a>
<?php endforeach; ?>
<p><a href="/dashboard/applications/">View all applications &rarr;</a></p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
