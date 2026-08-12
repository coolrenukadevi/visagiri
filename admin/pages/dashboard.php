<?php
declare(strict_types=1);

$pdo = db();
$stats = [
    'Countries' => (int) $pdo->query('SELECT COUNT(*) FROM countries WHERE is_active = 1')->fetchColumn(),
    'Visa Types' => (int) $pdo->query('SELECT COUNT(*) FROM visa_types WHERE is_active = 1')->fetchColumn(),
    'New Enquiries' => (int) $pdo->query("SELECT COUNT(*) FROM enquiries WHERE status = 'new'")->fetchColumn(),
    'Unread Contact Messages' => (int) $pdo->query("SELECT COUNT(*) FROM contact_messages WHERE status = 'unread'")->fetchColumn(),
    'Published Visa Requirements' => (int) $pdo->query('SELECT COUNT(*) FROM visa_requirements')->fetchColumn(),
    'Embassy/Consulate/VAC Entries' => (int) $pdo->query(
        'SELECT (SELECT COUNT(*) FROM embassies) + (SELECT COUNT(*) FROM consulates) + (SELECT COUNT(*) FROM visa_application_centres)'
    )->fetchColumn(),
];

$recentEnquiries = $pdo->query(
    "SELECT e.reference_number, e.name, e.email, e.status, e.created_at, c.name AS country_name
     FROM enquiries e LEFT JOIN countries c ON c.id = e.country_id
     ORDER BY e.created_at DESC LIMIT 5"
)->fetchAll();

admin_header_start('Dashboard', 'dashboard');
?>
<div class="admin-stat-grid">
    <?php foreach ($stats as $label => $value): ?>
    <div class="admin-stat-card">
        <div class="admin-stat-card__value"><?= $value ?></div>
        <div class="admin-stat-card__label"><?= e($label) ?></div>
    </div>
    <?php endforeach; ?>
</div>

<h2 class="country-directory__subheading">Recent Enquiries</h2>
<?php if ($recentEnquiries): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Name</th><th>Country</th><th>Status</th><th>Received</th></tr></thead>
    <tbody>
    <?php foreach ($recentEnquiries as $enq): ?>
        <tr>
            <td><?= e($enq['reference_number']) ?></td>
            <td><?= e($enq['name']) ?></td>
            <td><?= e($enq['country_name'] ?? '—') ?></td>
            <td><span class="badge badge-info"><?= e($enq['status']) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<p style="margin-top:var(--space-4)"><a href="/admin/enquiries/">View all enquiries &rarr;</a></p>
<?php else: ?>
<p class="empty-state">No enquiries yet.</p>
<?php endif; ?>
<?php
admin_header_end();
