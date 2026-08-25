<?php
declare(strict_types=1);

require_permission('hrms.vacancies.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$departments = $pdo->query('SELECT id, name FROM hr_departments ORDER BY name')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'change_status' && $id) {
        $newStatus = $_POST['status'] ?? '';
        if (in_array($newStatus, ['draft', 'published', 'paused', 'closed'], true)) {
            $publishedAtSql = $newStatus === 'published' ? ', published_at = COALESCE(published_at, NOW())' : '';
            $pdo->prepare("UPDATE hr_vacancies SET status = :status$publishedAtSql WHERE id = :id")
                ->execute(['status' => $newStatus, 'id' => $id]);
            log_action('status_change', 'hr_vacancies', $id, null, $newStatus);
            flash_set('hrms_notice', 'Vacancy status updated.');
        }
        redirect('/hrms/vacancies/?action=edit&id=' . $id);
    }

    if ($postAction === 'add_question' && $id) {
        $label = trim((string) ($_POST['question_label'] ?? ''));
        $type = in_array($_POST['question_type'] ?? '', ['text', 'textarea', 'number', 'select', 'yesno'], true) ? $_POST['question_type'] : 'text';
        $options = null;
        if ($type === 'select') {
            $opts = array_values(array_filter(array_map('trim', explode(',', (string) ($_POST['options'] ?? '')))));
            $options = $opts ? json_encode($opts) : null;
        }
        if ($label !== '') {
            $sortOrder = (int) $pdo->query("SELECT COALESCE(MAX(sort_order), 0) + 1 FROM hr_application_questions WHERE vacancy_id = $id")->fetchColumn();
            $pdo->prepare('INSERT INTO hr_application_questions (vacancy_id, question_label, question_type, options, is_required, sort_order) VALUES (:vid, :label, :type, :options, :required, :sort)')
                ->execute(['vid' => $id, 'label' => $label, 'type' => $type, 'options' => $options, 'required' => isset($_POST['is_required']) ? 1 : 0, 'sort' => $sortOrder]);
            log_action('create', 'hr_application_questions', $id, null, $label);
        }
        redirect('/hrms/vacancies/?action=edit&id=' . $id);
    }

    if ($postAction === 'delete_question') {
        $qId = (int) ($_POST['question_id'] ?? 0);
        if ($qId) {
            $pdo->prepare('DELETE FROM hr_application_questions WHERE id = :id')->execute(['id' => $qId]);
        }
        redirect('/hrms/vacancies/?action=edit&id=' . $id);
    }

    if ($postAction === 'save') {
        $data = [
            'job_title' => trim((string) ($_POST['job_title'] ?? '')),
            'department_id' => (int) ($_POST['department_id'] ?? 0) ?: null,
            'location' => trim((string) ($_POST['location'] ?? '')) ?: null,
            'employment_type' => in_array($_POST['employment_type'] ?? '', ['full_time', 'part_time', 'contract', 'internship'], true) ? $_POST['employment_type'] : 'full_time',
            'experience_required' => trim((string) ($_POST['experience_required'] ?? '')) ?: null,
            'qualification' => trim((string) ($_POST['qualification'] ?? '')) ?: null,
            'salary_min' => ($_POST['salary_min'] ?? '') !== '' ? (float) $_POST['salary_min'] : null,
            'salary_max' => ($_POST['salary_max'] ?? '') !== '' ? (float) $_POST['salary_max'] : null,
            'job_description' => trim((string) ($_POST['job_description'] ?? '')),
            'responsibilities' => trim((string) ($_POST['responsibilities'] ?? '')) ?: null,
            'required_skills' => trim((string) ($_POST['required_skills'] ?? '')) ?: null,
            'benefits' => trim((string) ($_POST['benefits'] ?? '')) ?: null,
            'application_closing_date' => ($_POST['application_closing_date'] ?? '') !== '' ? $_POST['application_closing_date'] : null,
        ];

        $newDepartment = trim((string) ($_POST['new_department'] ?? ''));
        if ($newDepartment !== '') {
            $deptStmt = $pdo->prepare('INSERT INTO hr_departments (name) VALUES (:name) ON DUPLICATE KEY UPDATE name = name');
            $deptStmt->execute(['name' => $newDepartment]);
            $lookup = $pdo->prepare('SELECT id FROM hr_departments WHERE name = :name');
            $lookup->execute(['name' => $newDepartment]);
            $data['department_id'] = (int) $lookup->fetchColumn();
        }

        if ($data['job_title'] === '' || $data['job_description'] === '') {
            flash_set('hrms_error', 'Job title and job description are required.');
            redirect($id ? "/hrms/vacancies/?action=edit&id=$id" : '/hrms/vacancies/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $setClause = implode(', ', array_map(static fn($k) => "$k = :$k", array_diff(array_keys($data), ['id'])));
            $pdo->prepare("UPDATE hr_vacancies SET $setClause WHERE id = :id")->execute($data);
            log_action('update', 'hr_vacancies', $id);
            flash_set('hrms_notice', 'Vacancy updated.');
            redirect("/hrms/vacancies/?action=edit&id=$id");
        }

        $slugBase = slugify($data['job_title']);
        $slug = $slugBase;
        $suffix = 1;
        while (true) {
            $check = $pdo->prepare('SELECT COUNT(*) FROM hr_vacancies WHERE slug = :slug');
            $check->execute(['slug' => $slug]);
            if (!(int) $check->fetchColumn()) {
                break;
            }
            $slug = $slugBase . '-' . (++$suffix);
        }
        $data['slug'] = $slug;
        $data['job_reference_no'] = generate_reference_number('JOB', 'hr_vacancies', 'job_reference_no');
        $data['created_by'] = current_admin_id();

        $cols = implode(', ', array_keys($data));
        $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
        $pdo->prepare("INSERT INTO hr_vacancies ($cols) VALUES ($placeholders)")->execute($data);
        $newId = (int) $pdo->lastInsertId();
        log_action('create', 'hr_vacancies', $newId, null, $data['job_reference_no']);
        flash_set('hrms_notice', "Vacancy created ({$data['job_reference_no']}). Add dynamic application questions below, then publish when ready.");
        redirect("/hrms/vacancies/?action=edit&id=$newId");
    }
}

if ($action === 'create' || $action === 'edit') {
    $vacancy = array_fill_keys([
        'job_title', 'department_id', 'location', 'employment_type', 'experience_required', 'qualification',
        'salary_min', 'salary_max', 'job_description', 'responsibilities', 'required_skills', 'benefits',
        'application_closing_date', 'status', 'job_reference_no', 'slug',
    ], '');
    $vacancy['employment_type'] = 'full_time';
    $vacancy['status'] = 'draft';
    $questions = [];

    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM hr_vacancies WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('hrms_error', 'Vacancy not found.');
            redirect('/hrms/vacancies/');
        }
        $vacancy = $found;
        $questions = hrms_vacancy_questions($id);
    }

    hrms_header_start($action === 'edit' ? 'Edit Vacancy' : 'Create Vacancy', 'vacancies');
    ?>
    <?php if ($action === 'edit'): ?>
    <div class="card" style="margin-bottom:var(--space-6)">
        <div class="admin-toolbar" style="margin-bottom:0">
            <div>
                <strong>Ref:</strong> <?= e($vacancy['job_reference_no']) ?>
                &nbsp; <span class="badge badge-<?= $vacancy['status'] === 'published' ? 'success' : ($vacancy['status'] === 'closed' ? 'neutral' : 'warning') ?>"><?= e(ucfirst($vacancy['status'])) ?></span>
                <?php if ($vacancy['status'] === 'published'): ?>
                &nbsp; <a href="/careers/<?= e($vacancy['slug']) ?>/" target="_blank" rel="noopener">View public page &rarr;</a>
                <?php endif; ?>
            </div>
            <form method="post" action="/hrms/vacancies/" style="display:flex;gap:var(--space-2)">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="change_status">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <select class="form-select" name="status" onchange="this.form.submit()">
                    <?php foreach (['draft' => 'Draft', 'published' => 'Published', 'paused' => 'Paused', 'closed' => 'Closed'] as $val => $label): ?>
                    <option value="<?= $val ?>"<?= $vacancy['status'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                    <?php endforeach; ?>
                </select>
            </form>
        </div>
    </div>
    <?php endif; ?>

    <div class="admin-form-card" style="max-width:900px">
        <form method="post" action="/hrms/vacancies/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label" for="job_title">Job Title *</label><input class="form-input" type="text" id="job_title" name="job_title" value="<?= e($vacancy['job_title']) ?>" required></div>
                <div class="form-group">
                    <label class="form-label" for="department_id">Department</label>
                    <select class="form-select" id="department_id" name="department_id">
                        <option value="">— None —</option>
                        <?php foreach ($departments as $d): ?>
                        <option value="<?= (int) $d['id'] ?>"<?= (int) $vacancy['department_id'] === (int) $d['id'] ? ' selected' : '' ?>><?= e($d['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><label class="form-label" for="new_department">Or Add New Department</label><input class="form-input" type="text" id="new_department" name="new_department" placeholder="Leave blank to use selection above"></div>
                <div class="form-group"><label class="form-label" for="location">Location</label><input class="form-input" type="text" id="location" name="location" value="<?= e($vacancy['location']) ?>"></div>
                <div class="form-group">
                    <label class="form-label" for="employment_type">Employment Type</label>
                    <select class="form-select" id="employment_type" name="employment_type">
                        <?php foreach (['full_time' => 'Full-Time', 'part_time' => 'Part-Time', 'contract' => 'Contract', 'internship' => 'Internship'] as $val => $label): ?>
                        <option value="<?= $val ?>"<?= $vacancy['employment_type'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><label class="form-label" for="experience_required">Experience Required</label><input class="form-input" type="text" id="experience_required" name="experience_required" value="<?= e($vacancy['experience_required']) ?>" placeholder="e.g. 2-4 years"></div>
                <div class="form-group"><label class="form-label" for="qualification">Qualification</label><input class="form-input" type="text" id="qualification" name="qualification" value="<?= e($vacancy['qualification']) ?>"></div>
                <div class="form-group"><label class="form-label" for="salary_min">Salary Min (monthly)</label><input class="form-input" type="number" id="salary_min" name="salary_min" value="<?= e((string) $vacancy['salary_min']) ?>"></div>
                <div class="form-group"><label class="form-label" for="salary_max">Salary Max (monthly)</label><input class="form-input" type="number" id="salary_max" name="salary_max" value="<?= e((string) $vacancy['salary_max']) ?>"></div>
                <div class="form-group"><label class="form-label" for="application_closing_date">Application Closing Date</label><input class="form-input" type="date" id="application_closing_date" name="application_closing_date" value="<?= e((string) $vacancy['application_closing_date']) ?>"></div>
            </div>
            <div class="form-group"><label class="form-label" for="job_description">Job Description *</label><textarea class="form-input" id="job_description" name="job_description" rows="4" required><?= e($vacancy['job_description']) ?></textarea></div>
            <div class="form-group"><label class="form-label" for="responsibilities">Responsibilities</label><textarea class="form-input" id="responsibilities" name="responsibilities" rows="4"><?= e($vacancy['responsibilities']) ?></textarea></div>
            <div class="form-group"><label class="form-label" for="required_skills">Required Skills</label><textarea class="form-input" id="required_skills" name="required_skills" rows="3"><?= e($vacancy['required_skills']) ?></textarea></div>
            <div class="form-group"><label class="form-label" for="benefits">Benefits (optional)</label><textarea class="form-input" id="benefits" name="benefits" rows="3"><?= e($vacancy['benefits']) ?></textarea></div>
            <button type="submit" class="btn btn-primary"><?= $action === 'edit' ? 'Save Changes' : 'Create Vacancy' ?></button>
            <a href="/hrms/vacancies/" class="btn btn-outline">Cancel</a>
        </form>
    </div>

    <?php if ($action === 'edit'): ?>
    <div class="admin-form-card" style="max-width:900px;margin-top:var(--space-6)">
        <div class="card-title">Application-Specific Questions</div>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Shown to candidates on the application form for this vacancy only — no code change needed to add or remove one.</p>
        <?php if ($questions): ?>
        <table class="admin-table" style="margin-bottom:var(--space-5)">
            <thead><tr><th>Question</th><th>Type</th><th>Required</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($questions as $q): ?>
            <tr>
                <td><?= e($q['question_label']) ?></td>
                <td><?= e(ucfirst($q['question_type'])) ?></td>
                <td><?= (int) $q['is_required'] === 1 ? 'Yes' : 'No' ?></td>
                <td class="actions">
                    <form method="post" action="/hrms/vacancies/" style="display:inline">
                        <?= csrf_field() ?>
                        <input type="hidden" name="action" value="delete_question">
                        <input type="hidden" name="id" value="<?= (int) $id ?>">
                        <input type="hidden" name="question_id" value="<?= (int) $q['id'] ?>">
                        <button type="submit" class="btn btn-outline btn-sm">Remove</button>
                    </form>
                </td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <?php endif; ?>
        <form method="post" action="/hrms/vacancies/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="add_question">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label" for="question_label">Question</label><input class="form-input" type="text" id="question_label" name="question_label" placeholder="e.g. Years of visa-processing experience"></div>
                <div class="form-group">
                    <label class="form-label" for="question_type">Answer Type</label>
                    <select class="form-select" id="question_type" name="question_type">
                        <option value="text">Short Text</option>
                        <option value="textarea">Long Text</option>
                        <option value="number">Number</option>
                        <option value="select">Dropdown</option>
                        <option value="yesno">Yes/No</option>
                    </select>
                </div>
                <div class="form-group"><label class="form-label" for="options">Dropdown Options (comma-separated, only for Dropdown type)</label><input class="form-input" type="text" id="options" name="options" placeholder="Option A, Option B, Option C"></div>
                <div class="form-group" style="align-self:end"><label style="display:flex;gap:var(--space-2);align-items:center"><input type="checkbox" name="is_required"> Required</label></div>
            </div>
            <button type="submit" class="btn btn-outline">+ Add Question</button>
        </form>
    </div>
    <?php endif; ?>
    <?php
    hrms_header_end();
    exit;
}

// --- List ---
$statusFilter = in_array($_GET['status'] ?? '', ['draft', 'published', 'paused', 'closed'], true) ? $_GET['status'] : null;
$where = [];
$params = [];
if ($statusFilter) {
    $where[] = 'v.status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$vacancies = $pdo->prepare(
    "SELECT v.*, d.name AS department_name, (SELECT COUNT(*) FROM hr_applications a WHERE a.vacancy_id = v.id AND a.deleted_at IS NULL) AS application_count
     FROM hr_vacancies v LEFT JOIN hr_departments d ON d.id = v.department_id
     $whereSql ORDER BY v.created_at DESC"
);
$vacancies->execute($params);
$vacancies = $vacancies->fetchAll();

hrms_header_start('Vacancies', 'vacancies');
?>
<div class="admin-toolbar">
    <form method="get" action="/hrms/vacancies/">
        <select class="form-select" name="status" onchange="this.form.submit()">
            <option value="">All statuses</option>
            <?php foreach (['draft' => 'Draft', 'published' => 'Published', 'paused' => 'Paused', 'closed' => 'Closed'] as $val => $label): ?>
            <option value="<?= $val ?>"<?= $statusFilter === $val ? ' selected' : '' ?>><?= $label ?></option>
            <?php endforeach; ?>
        </select>
    </form>
    <a href="/hrms/vacancies/?action=create" class="btn btn-primary">+ Create Vacancy</a>
</div>
<table class="admin-table">
    <thead><tr><th>Ref</th><th>Job Title</th><th>Department</th><th>Location</th><th>Status</th><th>Applications</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($vacancies as $v): ?>
        <tr>
            <td><?= e($v['job_reference_no']) ?></td>
            <td><?= e($v['job_title']) ?></td>
            <td><?= e($v['department_name'] ?? '—') ?></td>
            <td><?= e($v['location'] ?? '—') ?></td>
            <td><span class="badge badge-<?= $v['status'] === 'published' ? 'success' : ($v['status'] === 'closed' ? 'neutral' : 'warning') ?>"><?= e(ucfirst($v['status'])) ?></span></td>
            <td><?= (int) $v['application_count'] ?></td>
            <td class="actions"><a href="/hrms/vacancies/?action=edit&id=<?= (int) $v['id'] ?>" class="btn btn-outline btn-sm">Manage</a></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$vacancies): ?>
        <tr><td colspan="7"><p class="empty-state">No vacancies yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
hrms_header_end();
