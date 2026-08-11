<?php
declare(strict_types=1);

$user = current_user();
$pdo = db();
$userId = $user['id'];

$activeApplications = $pdo->prepare(
    "SELECT COUNT(*) FROM applications WHERE user_id = :id AND status != 'completed' AND deleted_at IS NULL"
);
$activeApplications->execute(['id' => $userId]);

$pendingDocuments = $pdo->prepare(
    "SELECT COUNT(*) FROM application_documents ad
     JOIN applications a ON a.id = ad.application_id
     WHERE a.user_id = :id AND ad.status IN ('required', 'rejected') AND ad.deleted_at IS NULL"
);
$pendingDocuments->execute(['id' => $userId]);

$upcomingAppointments = $pdo->prepare(
    "SELECT COUNT(*) FROM appointments ap
     JOIN applications a ON a.id = ap.application_id
     WHERE a.user_id = :id AND ap.status = 'scheduled' AND ap.scheduled_at >= NOW()"
);
$upcomingAppointments->execute(['id' => $userId]);

$outstandingPayments = $pdo->prepare(
    "SELECT COUNT(*) FROM payments WHERE user_id = :id AND status = 'pending'"
);
$outstandingPayments->execute(['id' => $userId]);

$recentApplications = $pdo->prepare(
    "SELECT a.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.user_id = :id AND a.deleted_at IS NULL
     ORDER BY a.created_at DESC LIMIT 5"
);
$recentApplications->execute(['id' => $userId]);
$applications = $recentApplications->fetchAll();

render_dashboard_start('overview', 'Welcome back, ' . $user['full_name']);
?>
<div class="stat-grid">
    <div class="stat-tile">
        <div class="stat-tile__label">Active Applications</div>
        <div class="stat-tile__value"><?= (int) $activeApplications->fetchColumn() ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Pending Documents</div>
        <div class="stat-tile__value"><?= (int) $pendingDocuments->fetchColumn() ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Upcoming Appointments</div>
        <div class="stat-tile__value"><?= (int) $upcomingAppointments->fetchColumn() ?></div>
    </div>
    <div class="stat-tile">
        <div class="stat-tile__label">Outstanding Payments</div>
        <div class="stat-tile__value"><?= (int) $outstandingPayments->fetchColumn() ?></div>
    </div>
</div>

<div class="button-group" style="margin-bottom:var(--space-6)">
    <a href="/countries/" class="btn btn-gold">Start New Application</a>
    <a href="/dashboard/documents/" class="btn btn-outline">Upload Documents</a>
    <a href="/track-visa/" class="btn btn-outline">Track Application</a>
    <a href="/contact/" class="btn btn-outline">Contact Consultant</a>
</div>

<h2 class="country-directory__subheading">Recent Applications</h2>
<?php if ($applications): ?>
<?php foreach ($applications as $app): render_application_card($app); endforeach; ?>
<p><a href="/dashboard/applications/">View all applications &rarr;</a></p>
<?php else: ?>
<p class="empty-state">You haven't started a visa application yet. <a href="/countries/">Explore destinations</a> to get started.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
