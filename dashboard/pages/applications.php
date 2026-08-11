<?php
declare(strict_types=1);

$user = current_user();
$stmt = db()->prepare(
    "SELECT a.*, c.name AS country_name, c.iso2, vt.name AS visa_type_name
     FROM applications a
     JOIN countries c ON c.id = a.country_id
     JOIN visa_types vt ON vt.id = a.visa_type_id
     WHERE a.user_id = :id AND a.deleted_at IS NULL
     ORDER BY a.created_at DESC"
);
$stmt->execute(['id' => $user['id']]);
$applications = $stmt->fetchAll();

render_dashboard_start('applications', 'My Applications');
?>
<?php if ($applications): ?>
<?php foreach ($applications as $app): render_application_card($app); endforeach; ?>
<?php else: ?>
<p class="empty-state">You haven't started a visa application yet. <a href="/countries/">Explore destinations</a> to get started.</p>
<?php endif; ?>
<?php render_dashboard_end(); ?>
