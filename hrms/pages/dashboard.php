<?php
declare(strict_types=1);

require_permission('hrms.dashboard.view');

$pdo = db();
$scoped = current_admin_hrms_scoped_to_assigned();
$scopeWhere = $scoped ? ' AND assigned_hr = ' . (int) current_admin_id() : '';

$stats = [
    'Total Vacancies' => (int) $pdo->query('SELECT COUNT(*) FROM hr_vacancies')->fetchColumn(),
    'Active Vacancies' => (int) $pdo->query("SELECT COUNT(*) FROM hr_vacancies WHERE status = 'published'")->fetchColumn(),
    'Total Applications' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL$scopeWhere")->fetchColumn(),
    'New Applications' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'new'$scopeWhere")->fetchColumn(),
    'Shortlisted' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'shortlisted'$scopeWhere")->fetchColumn(),
    'Interview Scheduled' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'interview_scheduled'$scopeWhere")->fetchColumn(),
    'Interview Completed' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'interviewed'$scopeWhere")->fetchColumn(),
    'Selected' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'final_selection'$scopeWhere")->fetchColumn(),
    'Rejected' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'rejected'$scopeWhere")->fetchColumn(),
    'On Hold' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'on_hold'$scopeWhere")->fetchColumn(),
    'Joined' => (int) $pdo->query("SELECT COUNT(*) FROM hr_applications WHERE deleted_at IS NULL AND status = 'joined'$scopeWhere")->fetchColumn(),
];
$statCardClass = [
    'Total Vacancies' => '', 'Active Vacancies' => 'hrms-stat-card--gold', 'Total Applications' => '',
    'New Applications' => '', 'Shortlisted' => '', 'Interview Scheduled' => '', 'Interview Completed' => '',
    'Selected' => 'hrms-stat-card--success', 'Rejected' => 'hrms-stat-card--danger', 'On Hold' => 'hrms-stat-card--warning', 'Joined' => 'hrms-stat-card--success',
];

$byJob = $pdo->query(
    "SELECT v.job_title AS label, COUNT(a.id) AS total FROM hr_applications a
     JOIN hr_vacancies v ON v.id = a.vacancy_id
     WHERE a.deleted_at IS NULL$scopeWhere
     GROUP BY v.id ORDER BY total DESC LIMIT 8"
)->fetchAll();

$byDepartment = $pdo->query(
    "SELECT COALESCE(d.name, 'Unassigned') AS label, COUNT(a.id) AS total FROM hr_applications a
     JOIN hr_vacancies v ON v.id = a.vacancy_id
     LEFT JOIN hr_departments d ON d.id = v.department_id
     WHERE a.deleted_at IS NULL$scopeWhere
     GROUP BY d.id ORDER BY total DESC"
)->fetchAll();

$bySource = $pdo->query(
    "SELECT source AS label, COUNT(*) AS total FROM hr_applications WHERE deleted_at IS NULL$scopeWhere GROUP BY source ORDER BY total DESC"
)->fetchAll();

$byStatus = $pdo->query(
    "SELECT status AS label, COUNT(*) AS total FROM hr_applications WHERE deleted_at IS NULL$scopeWhere GROUP BY status"
)->fetchAll(PDO::FETCH_KEY_PAIR);

$monthly = $pdo->query(
    "SELECT DATE_FORMAT(created_at, '%Y-%m') AS label, COUNT(*) AS total FROM hr_applications
     WHERE deleted_at IS NULL$scopeWhere AND created_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
     GROUP BY label ORDER BY label"
)->fetchAll();

/** Renders a simple horizontal CSS bar chart — no external chart library, consistent with the rest of this project. */
function hrms_bar_chart(array $rows, string $labelKey = 'label', string $valueKey = 'total'): void
{
    if (!$rows) {
        echo '<p class="empty-state">No data yet.</p>';
        return;
    }
    $max = max(array_column($rows, $valueKey)) ?: 1;
    foreach ($rows as $row) {
        $pct = round(((int) $row[$valueKey] / $max) * 100);
        echo '<div style="margin-bottom:var(--space-3)">';
        echo '<div style="display:flex;justify-content:space-between;font-size:var(--font-size-sm);margin-bottom:var(--space-1)"><span>' . e((string) $row[$labelKey]) . '</span><strong>' . (int) $row[$valueKey] . '</strong></div>';
        echo '<div style="background:var(--border);border-radius:var(--radius-full);height:8px;overflow:hidden"><div style="background:var(--visa-blue);height:100%;width:' . $pct . '%"></div></div>';
        echo '</div>';
    }
}

hrms_header_start('HRMS Dashboard', 'dashboard');
?>
<div class="hrms-stat-grid">
    <?php foreach ($stats as $label => $value): ?>
    <div class="hrms-stat-card <?= $statCardClass[$label] ?? '' ?>">
        <div class="hrms-stat-card__value"><?= $value ?></div>
        <div class="hrms-stat-card__label"><?= e($label) ?></div>
    </div>
    <?php endforeach; ?>
</div>

<div class="admin-form-grid">
    <div class="card">
        <div class="card-title">Applications by Job</div>
        <?php hrms_bar_chart($byJob); ?>
    </div>
    <div class="card">
        <div class="card-title">Applications by Department</div>
        <?php hrms_bar_chart($byDepartment); ?>
    </div>
    <div class="card">
        <div class="card-title">Applications by Source</div>
        <?php hrms_bar_chart(array_map(static fn($r) => ['label' => ucwords(str_replace('_', ' ', (string) $r['label'])), 'total' => $r['total']], $bySource)); ?>
    </div>
    <div class="card">
        <div class="card-title">Application Status</div>
        <?php
        $statusRows = [];
        foreach (hrms_status_labels() as $key => $label) {
            $statusRows[] = ['label' => $label, 'total' => (int) ($byStatus[$key] ?? 0)];
        }
        hrms_bar_chart($statusRows);
        ?>
    </div>
    <div class="card" style="grid-column:1 / -1">
        <div class="card-title">Monthly Recruitment Activity (last 6 months)</div>
        <?php hrms_bar_chart($monthly); ?>
    </div>
</div>
<?php
hrms_header_end();
