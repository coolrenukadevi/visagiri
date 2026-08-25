<?php
declare(strict_types=1);

/**
 * HRMS recruitment module helpers — candidate/application creation
 * with duplicate detection, and secure CV/document storage. Reuses
 * generate_reference_number() (includes/reference-numbers.php) and
 * validate_document_upload()'s MIME-sniffing rules (includes/documents.php)
 * rather than duplicating that logic; only storage location and the
 * destination table differ from the visa CRM's document handling,
 * since HR documents are confidential candidate data with their own
 * access-audit requirement (hr_document_access_log).
 */

const HR_DOCUMENTS_STORAGE_DIR = __DIR__ . '/../storage/hrms-documents';

/**
 * Same session as /admin/ (single admin_users table), but its own
 * redirect target — visiting /hrms/ while logged out (or via a link
 * shared internally) always lands on /hrms/login/, never a bare
 * dashboard, per the spec's explicit "no open HRMS URL" requirement.
 */
function require_hrms_login(): void
{
    if (!is_admin_logged_in()) {
        $_SESSION['hrms_redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/hrms/';
        redirect('/hrms/login/');
    }
}

/**
 * Finds an existing candidate by email or mobile, or creates a new
 * one. Returns [candidateId, isPossibleDuplicate, duplicateOfApplicationId].
 * A match on email/mobile is never silently merged into a fresh,
 * indistinguishable record — the caller flags the new application so
 * HR can review it, per "flag it for HR rather than silently creating
 * duplicate records."
 */
function hrms_find_or_create_candidate(array $data): array
{
    $pdo = db();

    $stmt = $pdo->prepare('SELECT id FROM hr_candidates WHERE email = :email OR mobile = :mobile ORDER BY id DESC LIMIT 1');
    $stmt->execute(['email' => $data['email'], 'mobile' => $data['mobile']]);
    $existingId = $stmt->fetchColumn();

    if ($existingId) {
        $candidateId = (int) $existingId;
        // Keep the candidate's contact/profile fields fresh on every
        // new application, without touching identity (id) or history.
        $pdo->prepare(
            'UPDATE hr_candidates SET full_name = :name, date_of_birth = :dob, gender = :gender,
             mobile = :mobile, whatsapp_number = :whatsapp, email = :email, address = :address,
             city = :city, state = :state, pincode = :pincode WHERE id = :id'
        )->execute([
            'name' => $data['full_name'], 'dob' => $data['date_of_birth'], 'gender' => $data['gender'],
            'mobile' => $data['mobile'], 'whatsapp' => $data['whatsapp_number'], 'email' => $data['email'],
            'address' => $data['address'], 'city' => $data['city'], 'state' => $data['state'],
            'pincode' => $data['pincode'], 'id' => $candidateId,
        ]);

        $prevAppStmt = $pdo->prepare('SELECT id FROM hr_applications WHERE candidate_id = :id AND deleted_at IS NULL ORDER BY id DESC LIMIT 1');
        $prevAppStmt->execute(['id' => $candidateId]);
        $previousApplicationId = $prevAppStmt->fetchColumn();

        return [$candidateId, $previousApplicationId !== false, $previousApplicationId !== false ? (int) $previousApplicationId : null];
    }

    $stmt = $pdo->prepare(
        'INSERT INTO hr_candidates (full_name, date_of_birth, gender, mobile, whatsapp_number, email, address, city, state, pincode)
         VALUES (:name, :dob, :gender, :mobile, :whatsapp, :email, :address, :city, :state, :pincode)'
    );
    $stmt->execute([
        'name' => $data['full_name'], 'dob' => $data['date_of_birth'], 'gender' => $data['gender'],
        'mobile' => $data['mobile'], 'whatsapp' => $data['whatsapp_number'], 'email' => $data['email'],
        'address' => $data['address'], 'city' => $data['city'], 'state' => $data['state'], 'pincode' => $data['pincode'],
    ]);

    return [(int) $pdo->lastInsertId(), false, null];
}

/**
 * Stores an already-validated upload (via validate_document_upload()
 * from includes/documents.php — same MIME-sniffing rules apply) into
 * HR's own private storage directory and hr_documents table.
 */
function store_hrms_document_upload(array $file, string $documentType, int $applicationId): int
{
    if (!is_dir(HR_DOCUMENTS_STORAGE_DIR)) {
        mkdir(HR_DOCUMENTS_STORAGE_DIR, 0755, true);
    }

    $originalName = (string) $file['name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $storedFilename = bin2hex(random_bytes(24)) . '.' . $extension;
    $destination = HR_DOCUMENTS_STORAGE_DIR . '/' . $storedFilename;

    if (!move_uploaded_file($file['tmp_name'], $destination)) {
        throw new RuntimeException('Failed to store uploaded file.');
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimeType = finfo_file($finfo, $destination) ?: 'application/octet-stream';
    finfo_close($finfo);

    $stmt = db()->prepare(
        'INSERT INTO hr_documents (application_id, document_type, original_filename, stored_filename, storage_path, mime_type, file_size)
         VALUES (:application_id, :doc_type, :original_name, :stored_name, :storage_path, :mime, :size)'
    );
    $stmt->execute([
        'application_id' => $applicationId,
        'doc_type' => $documentType,
        'original_name' => basename($originalName),
        'stored_name' => $storedFilename,
        'storage_path' => 'storage/hrms-documents/' . $storedFilename,
        'mime' => $mimeType,
        'size' => $file['size'],
    ]);

    return (int) db()->lastInsertId();
}

/** Section 14's per-document access log — who viewed/downloaded which CV, when. */
function log_hrms_document_access(int $documentId, string $action = 'download', ?int $adminUserId = null): void
{
    db()->prepare(
        'INSERT INTO hr_document_access_log (document_id, admin_user_id, action, ip_address)
         VALUES (:document_id, :admin_id, :action, :ip)'
    )->execute([
        'document_id' => $documentId,
        'admin_id' => $adminUserId ?? current_admin_id(),
        'action' => $action,
        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
    ]);
}

/** Records a pipeline stage change: hr_status_history row + the shared audit log. */
function hrms_record_status_change(int $applicationId, ?string $fromStatus, string $toStatus, ?string $remarks = null): void
{
    db()->prepare(
        'INSERT INTO hr_status_history (application_id, from_status, to_status, changed_by, remarks)
         VALUES (:application_id, :from_status, :to_status, :changed_by, :remarks)'
    )->execute([
        'application_id' => $applicationId,
        'from_status' => $fromStatus,
        'to_status' => $toStatus,
        'changed_by' => current_admin_id(),
        'remarks' => $remarks,
    ]);
    log_action('status_change', 'hr_applications', $applicationId, $fromStatus, $toStatus);
}

/** Human-readable labels for the pipeline's status enum, used by both the Kanban board and list views. */
function hrms_status_labels(): array
{
    return [
        'new' => 'New Application',
        'screening' => 'Screening',
        'shortlisted' => 'Shortlisted',
        'interview_scheduled' => 'Interview Scheduled',
        'interviewed' => 'Interviewed',
        'final_selection' => 'Final Selection',
        'offer_released' => 'Offer Released',
        'joined' => 'Joined',
        'rejected' => 'Rejected',
        'on_hold' => 'On Hold',
        'withdrawn' => 'Withdrawn',
    ];
}

/** The main forward pipeline, in order — used by the Kanban board. Rejected/On Hold/Withdrawn are reachable from any stage but not part of this ordered flow. */
function hrms_pipeline_stages(): array
{
    return ['new', 'screening', 'shortlisted', 'interview_scheduled', 'interviewed', 'final_selection', 'offer_released', 'joined'];
}

/**
 * Published vacancies still open for applications — hides a vacancy
 * whose closing date has passed even if HR forgot to move its status
 * to "closed", since accepting an application past a stated deadline
 * would be misleading to the candidate.
 */
function hrms_published_vacancies(): array
{
    return db()->query(
        "SELECT v.*, d.name AS department_name FROM hr_vacancies v
         LEFT JOIN hr_departments d ON d.id = v.department_id
         WHERE v.status = 'published' AND (v.application_closing_date IS NULL OR v.application_closing_date >= CURDATE())
         ORDER BY v.published_at DESC"
    )->fetchAll();
}

function hrms_published_vacancy_by_slug(string $slug): ?array
{
    $stmt = db()->prepare(
        "SELECT v.*, d.name AS department_name FROM hr_vacancies v
         LEFT JOIN hr_departments d ON d.id = v.department_id
         WHERE v.slug = :slug AND v.status = 'published'"
    );
    $stmt->execute(['slug' => $slug]);
    $vacancy = $stmt->fetch();
    return $vacancy ?: null;
}

function hrms_vacancy_questions(int $vacancyId): array
{
    $stmt = db()->prepare('SELECT * FROM hr_application_questions WHERE vacancy_id = :id ORDER BY sort_order, id');
    $stmt->execute(['id' => $vacancyId]);
    return $stmt->fetchAll();
}
