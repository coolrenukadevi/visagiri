<?php
declare(strict_types=1);

require_permission('hrms.candidates.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$scoped = current_admin_hrms_scoped_to_assigned();
$hrUsers = $pdo->query(
    "SELECT au.id, au.full_name FROM admin_users au
     JOIN roles r ON r.id = au.role_id
     WHERE r.slug IN ('hr-admin', 'hr-executive', 'super-admin') AND au.status = 'active'
     ORDER BY au.full_name"
)->fetchAll();

/** Loads one application + candidate, enforcing scoped access. Aborts (redirect/403) if not found or not permitted. */
function hrms_load_application_or_die(int $id, bool $scoped): array
{
    $stmt = db()->prepare(
        'SELECT a.*, c.full_name, c.email, c.mobile, c.whatsapp_number, c.date_of_birth, c.gender,
                c.address, c.city, c.state, c.pincode,
                v.job_title, v.slug AS vacancy_slug, v.job_reference_no, d.name AS department_name,
                assignee.full_name AS assigned_hr_name
         FROM hr_applications a
         JOIN hr_candidates c ON c.id = a.candidate_id
         JOIN hr_vacancies v ON v.id = a.vacancy_id
         LEFT JOIN hr_departments d ON d.id = v.department_id
         LEFT JOIN admin_users assignee ON assignee.id = a.assigned_hr
         WHERE a.id = :id AND a.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $application = $stmt->fetch();
    if (!$application) {
        flash_set('hrms_error', 'Candidate application not found.');
        redirect('/hrms/candidates/');
    }
    if ($scoped && (int) ($application['assigned_hr'] ?? 0) !== current_admin_id()) {
        http_response_code(403);
        exit('This candidate is not assigned to you.');
    }
    return $application;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('hrms.candidates.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    if ($id) {
        hrms_load_application_or_die($id, $scoped); // enforces scoping before any mutation too
    }

    if ($postAction === 'update_status' && $id) {
        $before = $pdo->prepare('SELECT status FROM hr_applications WHERE id = :id');
        $before->execute(['id' => $id]);
        $prevStatus = $before->fetchColumn();
        $newStatus = $_POST['status'] ?? '';
        if (array_key_exists($newStatus, hrms_status_labels())) {
            $pdo->prepare('UPDATE hr_applications SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $id]);
            hrms_record_status_change($id, (string) $prevStatus, $newStatus, trim((string) ($_POST['remarks'] ?? '')) ?: null);
            flash_set('hrms_notice', 'Status updated.');
        }
        redirect('/hrms/candidates/?id=' . $id);
    }

    if ($postAction === 'assign' && $id) {
        $newAssignee = (int) ($_POST['assigned_hr'] ?? 0) ?: null;
        $pdo->prepare('UPDATE hr_applications SET assigned_hr = :assigned WHERE id = :id')->execute(['assigned' => $newAssignee, 'id' => $id]);
        log_action('assignment', 'hr_applications', $id, null, (string) $newAssignee);
        flash_set('hrms_notice', 'Candidate reassigned.');
        redirect('/hrms/candidates/?id=' . $id);
    }

    if ($postAction === 'add_note' && $id) {
        $note = trim((string) ($_POST['note'] ?? ''));
        if ($note !== '') {
            $pdo->prepare('INSERT INTO hr_notes (application_id, admin_user_id, note) VALUES (:app_id, :admin_id, :note)')
                ->execute(['app_id' => $id, 'admin_id' => current_admin_id(), 'note' => $note]);
            log_action('note_added', 'hr_applications', $id);
            flash_set('hrms_notice', 'Note added.');
        }
        redirect('/hrms/candidates/?id=' . $id . '&tab=communication');
    }

    if ($postAction === 'schedule_interview' && $id) {
        $pdo->prepare(
            'INSERT INTO hr_interviews (application_id, round_name, scheduled_at, mode, location_or_link, interviewer, created_by)
             VALUES (:app_id, :round, :scheduled_at, :mode, :location, :interviewer, :created_by)'
        )->execute([
            'app_id' => $id,
            'round' => trim((string) ($_POST['round_name'] ?? '')) ?: 'Interview',
            'scheduled_at' => ($_POST['scheduled_at'] ?? '') !== '' ? $_POST['scheduled_at'] : null,
            'mode' => in_array($_POST['mode'] ?? '', ['phone', 'video', 'in_person'], true) ? $_POST['mode'] : 'video',
            'location' => trim((string) ($_POST['location_or_link'] ?? '')) ?: null,
            'interviewer' => (int) ($_POST['interviewer'] ?? 0) ?: null,
            'created_by' => current_admin_id(),
        ]);
        $interviewId = (int) $pdo->lastInsertId();
        log_action('interview_scheduled', 'hr_applications', $id, null, (string) $interviewId);
        if ($_POST['status'] ?? '' === '1') {
            hrms_record_status_change($id, null, 'interview_scheduled', 'Interview scheduled.');
            $pdo->prepare('UPDATE hr_applications SET status = "interview_scheduled" WHERE id = :id')->execute(['id' => $id]);
        }
        flash_set('hrms_notice', 'Interview scheduled.');
        redirect('/hrms/candidates/?id=' . $id . '&tab=interview');
    }

    if ($postAction === 'interview_feedback') {
        $interviewId = (int) ($_POST['interview_id'] ?? 0);
        if ($interviewId) {
            $pdo->prepare(
                'INSERT INTO hr_interview_feedback (interview_id, given_by, rating, recommendation, feedback_text)
                 VALUES (:interview_id, :given_by, :rating, :recommendation, :feedback)'
            )->execute([
                'interview_id' => $interviewId,
                'given_by' => current_admin_id(),
                'rating' => ($_POST['rating'] ?? '') !== '' ? (int) $_POST['rating'] : null,
                'recommendation' => in_array($_POST['recommendation'] ?? '', ['select', 'reject', 'hold'], true) ? $_POST['recommendation'] : null,
                'feedback' => trim((string) ($_POST['feedback_text'] ?? '')) ?: null,
            ]);
            $pdo->prepare("UPDATE hr_interviews SET status = 'completed' WHERE id = :id")->execute(['id' => $interviewId]);
            log_action('interview_feedback', 'hr_applications', $id);
            flash_set('hrms_notice', 'Interview feedback recorded.');
        }
        redirect('/hrms/candidates/?id=' . $id . '&tab=interview');
    }

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE hr_applications SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'hr_applications', $id);
        flash_set('hrms_notice', 'Application removed (soft delete).');
        redirect('/hrms/candidates/');
    }
}

// ---------------------------------------------------------------
// Profile view
// ---------------------------------------------------------------
if ($id) {
    $app = hrms_load_application_or_die($id, $scoped);
    $tab = in_array($_GET['tab'] ?? '', ['overview', 'resume', 'documents', 'education', 'experience', 'interview', 'communication', 'activity'], true) ? $_GET['tab'] : 'overview';

    $answersStmt = $pdo->prepare(
        'SELECT q.question_label, ca.answer_text FROM hr_candidate_answers ca
         JOIN hr_application_questions q ON q.id = ca.question_id WHERE ca.application_id = :id'
    );
    $answersStmt->execute(['id' => $id]);
    $answers = $answersStmt->fetchAll();

    $documentsStmt = $pdo->prepare('SELECT * FROM hr_documents WHERE application_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documentsStmt->execute(['id' => $id]);
    $documents = $documentsStmt->fetchAll();
    $cv = null;
    foreach ($documents as $doc) {
        if ($doc['document_type'] === 'cv') {
            $cv = $doc;
            break;
        }
    }

    $educationStmt = $pdo->prepare('SELECT * FROM hr_education WHERE application_id = :id LIMIT 1');
    $educationStmt->execute(['id' => $id]);
    $education = $educationStmt->fetch();

    $employmentStmt = $pdo->prepare('SELECT * FROM hr_employment_history WHERE application_id = :id LIMIT 1');
    $employmentStmt->execute(['id' => $id]);
    $employment = $employmentStmt->fetch();

    $interviewsStmt = $pdo->prepare(
        'SELECT i.*, u.full_name AS interviewer_name FROM hr_interviews i
         LEFT JOIN admin_users u ON u.id = i.interviewer
         WHERE i.application_id = :id ORDER BY i.scheduled_at DESC'
    );
    $interviewsStmt->execute(['id' => $id]);
    $interviews = $interviewsStmt->fetchAll();
    $feedbackByInterview = [];
    foreach ($interviews as $iv) {
        $fbStmt = $pdo->prepare('SELECT f.*, u.full_name AS given_by_name FROM hr_interview_feedback f LEFT JOIN admin_users u ON u.id = f.given_by WHERE interview_id = :id ORDER BY f.created_at DESC');
        $fbStmt->execute(['id' => $iv['id']]);
        $feedbackByInterview[$iv['id']] = $fbStmt->fetchAll();
    }

    $notesStmt = $pdo->prepare('SELECT n.*, u.full_name AS author_name FROM hr_notes n LEFT JOIN admin_users u ON u.id = n.admin_user_id WHERE application_id = :id ORDER BY n.created_at DESC');
    $notesStmt->execute(['id' => $id]);
    $notes = $notesStmt->fetchAll();

    $historyStmt = $pdo->prepare('SELECT h.*, u.full_name AS changed_by_name FROM hr_status_history h LEFT JOIN admin_users u ON u.id = h.changed_by WHERE application_id = :id ORDER BY h.created_at DESC');
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    $auditStmt = $pdo->prepare("SELECT al.*, u.full_name AS admin_name FROM audit_logs al LEFT JOIN admin_users u ON u.id = al.admin_user_id WHERE al.module = 'hr_applications' AND al.record_id = :id ORDER BY al.created_at DESC");
    $auditStmt->execute(['id' => $id]);
    $auditEntries = $auditStmt->fetchAll();

    if ($app['is_possible_duplicate']) {
        $dupStmt = $pdo->prepare('SELECT application_reference_no FROM hr_applications WHERE id = :id');
        $dupStmt->execute(['id' => $app['duplicate_of_application_id']]);
        $duplicateRef = $dupStmt->fetchColumn();
    }

    hrms_header_start($app['full_name'], 'candidates');
    ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="admin-toolbar" style="margin-bottom:0;align-items:flex-start">
            <div>
                <h2 style="margin:0 0 var(--space-1)"><?= e($app['full_name']) ?></h2>
                <p style="margin:0;color:var(--text-muted)">
                    Applied for <strong><?= e($app['job_title']) ?></strong> (<?= e($app['job_reference_no']) ?>) — <?= e($app['department_name'] ?? 'No department') ?>
                </p>
                <p style="margin:var(--space-1) 0 0"><strong>App. ID:</strong> <?= e($app['application_reference_no']) ?> &middot; <strong>Applied:</strong> <?= e(date('d M Y', strtotime((string) $app['created_at']))) ?> &middot; <strong>Source:</strong> <?= e(ucwords(str_replace('_', ' ', $app['source']))) ?></p>
                <?php if ($app['is_possible_duplicate']): ?>
                <p style="margin-top:var(--space-2)"><span class="badge badge-warning">Possible Duplicate</span> — candidate has a prior application <?= e($duplicateRef ?? '') ?></p>
                <?php endif; ?>
            </div>
            <div style="text-align:right">
                <span class="badge badge-info" style="font-size:var(--font-size-sm)"><?= e(hrms_status_labels()[$app['status']] ?? $app['status']) ?></span>
                <p style="margin-top:var(--space-2);color:var(--text-muted)">Assigned: <?= e($app['assigned_hr_name'] ?? 'Unassigned') ?></p>
            </div>
        </div>
    </div>

    <div class="admin-form-grid" style="margin-bottom:var(--space-5)">
        <div class="card">
            <div class="card-title">Update Status</div>
            <form method="post" action="/hrms/candidates/">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="update_status">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <div class="form-group">
                    <select class="form-select" name="status">
                        <?php foreach (hrms_status_labels() as $val => $label): ?>
                        <option value="<?= $val ?>"<?= $app['status'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><input class="form-input" type="text" name="remarks" placeholder="Remarks (optional)"></div>
                <button type="submit" class="btn btn-primary btn-sm">Update</button>
            </form>
        </div>
        <div class="card">
            <div class="card-title">Assign HR</div>
            <form method="post" action="/hrms/candidates/">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="assign">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <div class="form-group">
                    <select class="form-select" name="assigned_hr">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($hrUsers as $hr): ?>
                        <option value="<?= (int) $hr['id'] ?>"<?= (int) $app['assigned_hr'] === (int) $hr['id'] ? ' selected' : '' ?>><?= e($hr['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">Reassign</button>
            </form>
        </div>
    </div>

    <nav class="hrms-tabs">
        <?php foreach (['overview' => 'Overview', 'resume' => 'Resume', 'documents' => 'Documents', 'education' => 'Education', 'experience' => 'Experience', 'interview' => 'Interview', 'communication' => 'Communication', 'activity' => 'Activity Log'] as $key => $label): ?>
        <a href="/hrms/candidates/?id=<?= (int) $id ?>&tab=<?= $key ?>" class="<?= $tab === $key ? 'is-active' : '' ?>"><?= $label ?></a>
        <?php endforeach; ?>
    </nav>

    <?php if ($tab === 'overview'): ?>
    <div class="admin-form-grid">
        <div class="card">
            <div class="card-title">Personal Information</div>
            <p><strong>Email:</strong> <?= e($app['email']) ?></p>
            <p><strong>Mobile:</strong> <?= e($app['mobile']) ?></p>
            <p><strong>WhatsApp:</strong> <?= e($app['whatsapp_number'] ?? '—') ?></p>
            <p><strong>DOB:</strong> <?= $app['date_of_birth'] ? e(date('d M Y', strtotime((string) $app['date_of_birth']))) : '—' ?></p>
            <p><strong>Gender:</strong> <?= e(ucfirst((string) ($app['gender'] ?? '—'))) ?></p>
            <p><strong>Address:</strong> <?= e(trim(($app['address'] ?? '') . ' ' . ($app['city'] ?? '') . ' ' . ($app['state'] ?? '') . ' ' . ($app['pincode'] ?? '')) ?: '—') ?></p>
        </div>
        <div class="card">
            <div class="card-title">Professional Information</div>
            <p><strong>Current Company:</strong> <?= e($app['current_company'] ?? '—') ?></p>
            <p><strong>Designation:</strong> <?= e($app['current_designation'] ?? '—') ?></p>
            <p><strong>Total Experience:</strong> <?= e($app['total_experience'] ?? '—') ?></p>
            <p><strong>Relevant Experience:</strong> <?= e($app['relevant_experience'] ?? '—') ?></p>
            <p><strong>Current Salary:</strong> <?= e($app['current_salary'] ?? '—') ?></p>
            <p><strong>Expected Salary:</strong> <?= e($app['expected_salary'] ?? '—') ?></p>
            <p><strong>Notice Period:</strong> <?= e($app['notice_period'] ?? '—') ?></p>
            <p><strong>Employment Status:</strong> <?= e(ucfirst(str_replace('_', ' ', (string) ($app['employment_status'] ?? '—')))) ?></p>
            <p><strong>Willing to Relocate:</strong> <?= $app['willing_to_relocate'] === null ? '—' : ((int) $app['willing_to_relocate'] === 1 ? 'Yes' : 'No') ?></p>
        </div>
        <div class="card">
            <div class="card-title">Skills</div>
            <p><strong>Primary:</strong> <?= e($app['primary_skills'] ?? '—') ?></p>
            <p><strong>Secondary:</strong> <?= e($app['secondary_skills'] ?? '—') ?></p>
            <p><strong>Computer:</strong> <?= e($app['computer_skills'] ?? '—') ?></p>
            <p><strong>Languages:</strong> <?= e($app['language_skills'] ?? '—') ?></p>
        </div>
        <?php if ($answers): ?>
        <div class="card">
            <div class="card-title">Role-Specific Answers</div>
            <?php foreach ($answers as $a): ?>
            <p><strong><?= e($a['question_label']) ?>:</strong> <?= e($a['answer_text']) ?></p>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
        <div class="card">
            <div class="card-title">Declaration &amp; Consent</div>
            <p>Accurate info confirmed: <?= (int) $app['consent_accurate_info'] === 1 ? 'Yes' : 'No' ?></p>
            <p>Data use authorized: <?= (int) $app['consent_data_use'] === 1 ? 'Yes' : 'No' ?></p>
            <p>Privacy terms agreed: <?= (int) $app['consent_privacy_terms'] === 1 ? 'Yes' : 'No' ?></p>
            <p>Understood no guarantee: <?= (int) $app['consent_no_guarantee'] === 1 ? 'Yes' : 'No' ?></p>
            <p><strong>Timestamp:</strong> <?= $app['consent_given_at'] ? e(date('d M Y H:i', strtotime((string) $app['consent_given_at']))) : '—' ?></p>
        </div>
    </div>

    <?php elseif ($tab === 'resume'): ?>
    <div class="card">
        <div class="card-title">CV / Resume</div>
        <?php if ($cv): ?>
        <p><?= e($cv['original_filename']) ?> (<?= e(number_format($cv['file_size'] / 1024, 1)) ?> KB)</p>
        <a href="/hrms/document-download/?id=<?= (int) $cv['id'] ?>" class="btn btn-primary btn-sm">Download CV</a>
        <?php else: ?>
        <p class="empty-state">No CV on file.</p>
        <?php endif; ?>
    </div>

    <?php elseif ($tab === 'documents'): ?>
    <table class="admin-table">
        <thead><tr><th>Type</th><th>File</th><th>Uploaded</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><?= e(ucwords(str_replace('_', ' ', $doc['document_type']))) ?></td>
            <td><?= e($doc['original_filename']) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
            <td class="actions"><a href="/hrms/document-download/?id=<?= (int) $doc['id'] ?>" class="btn btn-outline btn-sm">Download</a></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$documents): ?><tr><td colspan="4"><p class="empty-state">No documents uploaded.</p></td></tr><?php endif; ?>
        </tbody>
    </table>

    <?php elseif ($tab === 'education'): ?>
    <div class="card">
        <div class="card-title">Education</div>
        <?php if ($education): ?>
        <p><strong>Highest Qualification:</strong> <?= e($education['highest_qualification'] ?? '—') ?></p>
        <p><strong>Course/Degree:</strong> <?= e($education['course_degree'] ?? '—') ?></p>
        <p><strong>Institution:</strong> <?= e($education['institution'] ?? '—') ?></p>
        <p><strong>Passing Year:</strong> <?= e((string) ($education['passing_year'] ?? '—')) ?></p>
        <p><strong>Additional Certifications:</strong> <?= e($education['additional_certifications'] ?? '—') ?></p>
        <?php else: ?>
        <p class="empty-state">No education details on file.</p>
        <?php endif; ?>
    </div>

    <?php elseif ($tab === 'experience'): ?>
    <div class="card">
        <div class="card-title">Employment History</div>
        <?php if ($employment): ?>
        <p><strong>Company:</strong> <?= e($employment['company_name'] ?? '—') ?></p>
        <p><strong>Designation:</strong> <?= e($employment['designation'] ?? '—') ?></p>
        <p><strong>Duration:</strong> <?= e($employment['duration'] ?? '—') ?></p>
        <?php else: ?>
        <p class="empty-state">No employment history on file.</p>
        <?php endif; ?>
    </div>

    <?php elseif ($tab === 'interview'): ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Schedule Interview</div>
        <form method="post" action="/hrms/candidates/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="schedule_interview">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label">Round Name</label><input class="form-input" type="text" name="round_name" placeholder="e.g. HR Round, Technical Round" value="Interview"></div>
                <div class="form-group"><label class="form-label">Date &amp; Time</label><input class="form-input" type="datetime-local" name="scheduled_at"></div>
                <div class="form-group">
                    <label class="form-label">Mode</label>
                    <select class="form-select" name="mode">
                        <option value="video">Video Call</option>
                        <option value="phone">Phone</option>
                        <option value="in_person">In Person</option>
                    </select>
                </div>
                <div class="form-group"><label class="form-label">Location / Link</label><input class="form-input" type="text" name="location_or_link"></div>
                <div class="form-group">
                    <label class="form-label">Interviewer</label>
                    <select class="form-select" name="interviewer">
                        <option value="">— Not assigned —</option>
                        <?php foreach ($hrUsers as $hr): ?>
                        <option value="<?= (int) $hr['id'] ?>"><?= e($hr['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group" style="align-self:end"><label style="display:flex;gap:var(--space-2);align-items:center"><input type="checkbox" name="status" value="1" checked> Move status to "Interview Scheduled"</label></div>
            </div>
            <button type="submit" class="btn btn-primary">Schedule</button>
        </form>
    </div>

    <?php foreach ($interviews as $iv): ?>
    <div class="card" style="margin-bottom:var(--space-4)">
        <div class="admin-toolbar" style="margin-bottom:var(--space-3)">
            <div><strong><?= e($iv['round_name']) ?></strong> — <span class="badge badge-info"><?= e(ucfirst($iv['status'])) ?></span></div>
            <div><?= $iv['scheduled_at'] ? e(date('d M Y H:i', strtotime((string) $iv['scheduled_at']))) : 'Not scheduled' ?></div>
        </div>
        <p><strong>Mode:</strong> <?= e(ucfirst(str_replace('_', ' ', $iv['mode']))) ?> &middot; <strong>Interviewer:</strong> <?= e($iv['interviewer_name'] ?? '—') ?><?= $iv['location_or_link'] ? ' &middot; ' . e($iv['location_or_link']) : '' ?></p>

        <?php foreach ($feedbackByInterview[$iv['id']] as $fb): ?>
        <div class="alert alert-info">
            <strong><?= e($fb['given_by_name'] ?? 'HR') ?></strong> — Rating: <?= $fb['rating'] ? str_repeat('★', (int) $fb['rating']) . str_repeat('☆', 5 - (int) $fb['rating']) : '—' ?>
            <?= $fb['recommendation'] ? ' — ' . e(ucfirst($fb['recommendation'])) : '' ?>
            <?php if ($fb['feedback_text']): ?><p style="margin-top:var(--space-1)"><?= e($fb['feedback_text']) ?></p><?php endif; ?>
        </div>
        <?php endforeach; ?>

        <form method="post" action="/hrms/candidates/" style="margin-top:var(--space-3)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="interview_feedback">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <input type="hidden" name="interview_id" value="<?= (int) $iv['id'] ?>">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label">Rating</label>
                    <select class="form-select" name="rating">
                        <option value="">—</option>
                        <?php for ($r = 1; $r <= 5; $r++): ?>
                        <option value="<?= $r ?>"><?= $r ?> / 5</option>
                        <?php endfor; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Recommendation</label>
                    <select class="form-select" name="recommendation">
                        <option value="">—</option>
                        <option value="select">Select</option>
                        <option value="hold">Hold</option>
                        <option value="reject">Reject</option>
                    </select>
                </div>
            </div>
            <div class="form-group"><textarea class="form-input" name="feedback_text" rows="2" placeholder="Feedback notes"></textarea></div>
            <button type="submit" class="btn btn-outline btn-sm">Add Feedback</button>
        </form>
    </div>
    <?php endforeach; ?>
    <?php if (!$interviews): ?><p class="empty-state">No interviews scheduled yet.</p><?php endif; ?>

    <?php elseif ($tab === 'communication'): ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Add Note</div>
        <form method="post" action="/hrms/candidates/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="add_note">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="form-group"><textarea class="form-input" name="note" rows="3" required></textarea></div>
            <button type="submit" class="btn btn-primary btn-sm">Add Note</button>
        </form>
    </div>
    <ul class="hrms-timeline">
        <?php foreach ($notes as $n): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $n['created_at']))) ?> — <?= e($n['author_name'] ?? 'HR') ?></time><?= e($n['note']) ?></li>
        <?php endforeach; ?>
        <?php if (!$notes): ?><li class="empty-state">No notes yet.</li><?php endif; ?>
    </ul>
    <p style="margin-top:var(--space-4);color:var(--text-muted);font-size:var(--font-size-sm)">Automated candidate email notifications (application received, interview invite, selection/rejection) go live once real SMTP credentials are configured — see AUDIT.md.</p>

    <?php elseif ($tab === 'activity'): ?>
    <ul class="hrms-timeline">
        <?php foreach ($history as $h): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></time>Status changed from <strong><?= e($h['from_status'] ?? 'none') ?></strong> to <strong><?= e($h['to_status']) ?></strong> by <?= e($h['changed_by_name'] ?? 'System') ?><?= $h['remarks'] ? ' — ' . e($h['remarks']) : '' ?></li>
        <?php endforeach; ?>
        <?php foreach ($auditEntries as $a): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $a['created_at']))) ?></time><?= e(ucwords(str_replace('_', ' ', $a['action']))) ?> by <?= e($a['admin_name'] ?? 'System') ?></li>
        <?php endforeach; ?>
        <?php if (!$history && !$auditEntries): ?><li class="empty-state">No activity recorded yet.</li><?php endif; ?>
    </ul>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/hrms/candidates/">&larr; Back to all candidates</a></p>
    <?php
    hrms_header_end();
    exit;
}

// ---------------------------------------------------------------
// List view
// ---------------------------------------------------------------
$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = array_key_exists($_GET['status'] ?? '', hrms_status_labels()) ? $_GET['status'] : null;
$vacancyFilter = (int) ($_GET['vacancy'] ?? 0) ?: null;
$assignedFilter = (int) ($_GET['assigned'] ?? 0) ?: null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['a.deleted_at IS NULL'];
$params = [];
if ($scoped) {
    $where[] = 'a.assigned_hr = :current_admin';
    $params['current_admin'] = current_admin_id();
}
if ($search !== '') {
    // PDO with real (non-emulated) prepared statements does not
    // support the same named placeholder appearing more than once in
    // a query — each occurrence needs its own key bound to the same
    // value.
    $where[] = '(c.full_name LIKE :search1 OR c.email LIKE :search2 OR c.mobile LIKE :search3 OR a.application_reference_no LIKE :search4)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = $searchTerm;
}
if ($statusFilter) {
    $where[] = 'a.status = :status';
    $params['status'] = $statusFilter;
}
if ($vacancyFilter) {
    $where[] = 'a.vacancy_id = :vacancy';
    $params['vacancy'] = $vacancyFilter;
}
if ($assignedFilter) {
    $where[] = 'a.assigned_hr = :assigned';
    $params['assigned'] = $assignedFilter;
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM hr_applications a JOIN hr_candidates c ON c.id = a.candidate_id WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT a.*, c.full_name, c.email, c.mobile, v.job_title, d.name AS department_name, assignee.full_name AS assigned_hr_name
     FROM hr_applications a
     JOIN hr_candidates c ON c.id = a.candidate_id
     JOIN hr_vacancies v ON v.id = a.vacancy_id
     LEFT JOIN hr_departments d ON d.id = v.department_id
     LEFT JOIN admin_users assignee ON assignee.id = a.assigned_hr
     WHERE $whereSql ORDER BY a.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$applications = $stmt->fetchAll();

$vacancyOptions = $pdo->query('SELECT id, job_title FROM hr_vacancies ORDER BY job_title')->fetchAll();

hrms_header_start('Candidates', 'candidates');
?>
<div class="admin-toolbar">
    <form method="get" action="/hrms/candidates/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Name, email, mobile, application ID…">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <?php foreach (hrms_status_labels() as $val => $label): ?>
            <option value="<?= $val ?>"<?= $statusFilter === $val ? ' selected' : '' ?>><?= $label ?></option>
            <?php endforeach; ?>
        </select>
        <select class="form-select" name="vacancy">
            <option value="">All jobs</option>
            <?php foreach ($vacancyOptions as $v): ?>
            <option value="<?= (int) $v['id'] ?>"<?= $vacancyFilter === (int) $v['id'] ? ' selected' : '' ?>><?= e($v['job_title']) ?></option>
            <?php endforeach; ?>
        </select>
        <?php if (!$scoped): ?>
        <select class="form-select" name="assigned">
            <option value="">All HR</option>
            <?php foreach ($hrUsers as $hr): ?>
            <option value="<?= (int) $hr['id'] ?>"<?= $assignedFilter === (int) $hr['id'] ? ' selected' : '' ?>><?= e($hr['full_name']) ?></option>
            <?php endforeach; ?>
        </select>
        <?php endif; ?>
        <button type="submit" class="btn btn-outline">Filter</button>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>App. ID</th><th>Candidate</th><th>Job</th><th>Department</th><th>Status</th><th>Assigned HR</th><th>Applied</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($applications as $a): ?>
        <tr>
            <td><?= e($a['application_reference_no']) ?><?= (int) $a['is_possible_duplicate'] === 1 ? ' <span class="badge badge-warning">Dup?</span>' : '' ?></td>
            <td><?= e($a['full_name']) ?></td>
            <td><?= e($a['job_title']) ?></td>
            <td><?= e($a['department_name'] ?? '—') ?></td>
            <td><span class="badge badge-info"><?= e(hrms_status_labels()[$a['status']] ?? $a['status']) ?></span></td>
            <td><?= e($a['assigned_hr_name'] ?? '—') ?></td>
            <td><?= e(date('d M Y', strtotime((string) $a['created_at']))) ?></td>
            <td class="actions"><a href="/hrms/candidates/?id=<?= (int) $a['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$applications): ?>
        <tr><td colspan="8"><p class="empty-state">No candidates yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/hrms/candidates/?page=<?= $p ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
hrms_header_end();
