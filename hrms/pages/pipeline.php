<?php
declare(strict_types=1);

/**
 * Kanban recruitment pipeline. Moving a card posts to the same
 * update_status handler as the candidate profile page
 * (hrms/pages/candidates.php) — one status-change code path, one
 * hr_status_history writer (hrms_record_status_change()), whether the
 * change comes from here or from the profile page.
 */

require_permission('hrms.candidates.view');

$pdo = db();
$scoped = current_admin_hrms_scoped_to_assigned();

$where = ['a.deleted_at IS NULL'];
$params = [];
if ($scoped) {
    $where[] = 'a.assigned_hr = :current_admin';
    $params['current_admin'] = current_admin_id();
}
$whereSql = implode(' AND ', $where);

$stmt = $pdo->prepare(
    "SELECT a.id, a.status, a.application_reference_no, c.full_name, v.job_title
     FROM hr_applications a
     JOIN hr_candidates c ON c.id = a.candidate_id
     JOIN hr_vacancies v ON v.id = a.vacancy_id
     WHERE $whereSql ORDER BY a.updated_at DESC"
);
$stmt->execute($params);
$byStatus = [];
foreach ($stmt->fetchAll() as $row) {
    $byStatus[$row['status']][] = $row;
}

$labels = hrms_status_labels();
$mainStages = hrms_pipeline_stages();
$sideStages = ['rejected', 'on_hold', 'withdrawn'];

hrms_header_start('Recruitment Pipeline', 'pipeline');
?>
<h2 class="country-directory__subheading">Main Pipeline</h2>
<div class="hrms-kanban">
    <?php foreach ($mainStages as $stage): ?>
    <div class="hrms-kanban__column">
        <div class="hrms-kanban__column-header"><?= e($labels[$stage]) ?> <span class="hrms-kanban__column-count"><?= count($byStatus[$stage] ?? []) ?></span></div>
        <div class="hrms-kanban__cards">
            <?php foreach ($byStatus[$stage] ?? [] as $card): ?>
            <div class="hrms-kanban__card">
                <div class="hrms-kanban__card-name"><a href="/hrms/candidates/?id=<?= (int) $card['id'] ?>"><?= e($card['full_name']) ?></a></div>
                <div class="hrms-kanban__card-meta"><?= e($card['job_title']) ?> &middot; <?= e($card['application_reference_no']) ?></div>
                <?php if (has_permission('hrms.candidates.manage')): ?>
                <form method="post" action="/hrms/candidates/">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="update_status">
                    <input type="hidden" name="id" value="<?= (int) $card['id'] ?>">
                    <select name="status" onchange="this.form.submit()">
                        <?php foreach ($labels as $val => $label): ?>
                        <option value="<?= $val ?>"<?= $stage === $val ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </form>
                <?php endif; ?>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endforeach; ?>
</div>

<h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Rejected / On Hold / Withdrawn</h2>
<div class="hrms-kanban">
    <?php foreach ($sideStages as $stage): ?>
    <div class="hrms-kanban__column">
        <div class="hrms-kanban__column-header"><?= e($labels[$stage]) ?> <span class="hrms-kanban__column-count"><?= count($byStatus[$stage] ?? []) ?></span></div>
        <div class="hrms-kanban__cards">
            <?php foreach ($byStatus[$stage] ?? [] as $card): ?>
            <div class="hrms-kanban__card">
                <div class="hrms-kanban__card-name"><a href="/hrms/candidates/?id=<?= (int) $card['id'] ?>"><?= e($card['full_name']) ?></a></div>
                <div class="hrms-kanban__card-meta"><?= e($card['job_title']) ?> &middot; <?= e($card['application_reference_no']) ?></div>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
    <?php endforeach; ?>
</div>
<?php
hrms_header_end();
