<?php
declare(strict_types=1);

/**
 * Document upload/download/delete — Phase 12. Files never live under
 * public/ (UPLOADS_PATH is a sibling directory, and uploads/.htaccess
 * denies direct access even under Apache misconfiguration) — every
 * download goes through download_owned_document() so ownership is
 * checked on every single read, not just at upload time. Stored
 * filenames are random hex, never the original name or anything
 * derived from user input, so there's nothing to path-traverse with.
 */

const DOCUMENT_MAX_BYTES = 5 * 1024 * 1024;

/** Server-verified (via finfo, never the client-supplied $_FILES type) MIME allowlist. */
const DOCUMENT_ALLOWED_MIME = [
    'application/pdf' => 'pdf',
    'image/jpeg' => 'jpg',
    'image/png' => 'png',
];

/** Statuses the applicant is still allowed to upload/replace/remove a file for. */
const DOCUMENT_EDITABLE_STATUSES = ['required', 'uploaded', 'rejected'];

function document_upload_dir(int $applicationId): string
{
    return UPLOADS_PATH . "/documents/$applicationId";
}

/**
 * Strips control characters (including CR/LF) from a client-supplied
 * upload filename before it's stored. PHP's header() already refuses
 * to emit a header value containing a raw newline, so this isn't
 * exploitable as HTTP response splitting today — but the
 * Content-Disposition filename in document-download.php is built
 * directly from this value, and that shouldn't depend on one
 * runtime's defense being the only thing standing between user input
 * and a response header.
 */
function sanitize_uploaded_filename(string $filename): string
{
    $filename = preg_replace('/[\x00-\x1F\x7F]/', '', $filename) ?? '';
    return mb_substr(trim($filename), 0, 255);
}

/**
 * Fetches one application_documents row, but ONLY if it belongs to an
 * application owned by $userId — every handler below calls this first
 * so a guessed/incremented ID can never touch another customer's file.
 */
function fetch_owned_application_document(PDO $pdo, int $documentRowId, int $userId): ?array
{
    $stmt = $pdo->prepare(
        'SELECT ad.*, d.name AS document_name, a.id AS application_id, a.application_number, a.user_id
         FROM application_documents ad
         JOIN documents d ON d.id = ad.document_id
         JOIN applications a ON a.id = ad.application_id
         WHERE ad.id = :id AND a.user_id = :user_id AND ad.deleted_at IS NULL AND a.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $documentRowId, 'user_id' => $userId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/** Admin/staff variant — no per-customer ownership constraint, access is gated by require_role() at the router level instead. */
function fetch_application_document(PDO $pdo, int $documentRowId): ?array
{
    $stmt = $pdo->prepare(
        'SELECT ad.*, d.name AS document_name, a.id AS application_id, a.application_number, a.user_id
         FROM application_documents ad
         JOIN documents d ON d.id = ad.document_id
         JOIN applications a ON a.id = ad.application_id
         WHERE ad.id = :id AND ad.deleted_at IS NULL AND a.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $documentRowId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/** Consultant variant — only documents on applications assigned to $consultantId. */
function fetch_application_document_for_consultant(PDO $pdo, int $documentRowId, int $consultantId): ?array
{
    $stmt = $pdo->prepare(
        'SELECT ad.*, d.name AS document_name, a.id AS application_id, a.application_number, a.user_id
         FROM application_documents ad
         JOIN documents d ON d.id = ad.document_id
         JOIN applications a ON a.id = ad.application_id
         WHERE ad.id = :id AND a.assigned_consultant_id = :consultant_id AND ad.deleted_at IS NULL AND a.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $documentRowId, 'consultant_id' => $consultantId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/** Shared by the admin and consultant approve handlers — caller is responsible for the access check. */
function mark_document_approved(PDO $pdo, int $documentId, int $reviewerId): void
{
    $pdo->prepare(
        'UPDATE application_documents
         SET status = "approved", reviewer_comment = NULL, reviewed_by = :reviewed_by, reviewed_at = NOW()
         WHERE id = :id'
    )->execute(['reviewed_by' => $reviewerId, 'id' => $documentId]);
}

/** Shared by the admin and consultant reject handlers — caller is responsible for the access check. */
function mark_document_rejected(PDO $pdo, int $documentId, int $reviewerId, string $comment): void
{
    $pdo->prepare(
        'UPDATE application_documents
         SET status = "rejected", reviewer_comment = :comment, reviewed_by = :reviewed_by, reviewed_at = NOW()
         WHERE id = :id'
    )->execute(['comment' => $comment, 'reviewed_by' => $reviewerId, 'id' => $documentId]);
}

/** Renders one document row with the upload/download/remove actions appropriate to its status. */
function render_document_row(array $doc, bool $showApplicationContext = false): void
{
    $badgeClass = match ($doc['status']) {
        'approved' => 'success',
        'rejected' => 'danger',
        'under_review' => 'warning',
        default => 'neutral',
    };
    ?>
    <div class="document-row">
        <div class="document-row__top">
            <div>
                <span class="list-row__title"><?= e($doc['document_name']) ?></span>
                <?php if ($showApplicationContext): ?>
                <div class="list-row__meta"><?= e($doc['application_number']) ?></div>
                <?php endif; ?>
            </div>
            <span class="badge badge-<?= $badgeClass ?>"><?= e(str_replace('_', ' ', $doc['status'])) ?></span>
        </div>

        <?php if (!empty($doc['reviewer_comment'])): ?>
        <p class="form-hint"><strong>Reviewer note:</strong> <?= e($doc['reviewer_comment']) ?></p>
        <?php endif; ?>

        <?php if ($doc['stored_filename']): ?>
        <p class="document-row__file">
            <?= e($doc['original_filename']) ?>
            &middot; <a href="/dashboard/documents/<?= (int) $doc['id'] ?>/download/">Download</a>
            <?php if (!empty($doc['uploaded_at'])): ?> &middot; Uploaded <?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?><?php endif; ?>
        </p>
        <?php endif; ?>

        <?php if (in_array($doc['status'], DOCUMENT_EDITABLE_STATUSES, true)): ?>
        <form method="post" action="/dashboard/documents/<?= (int) $doc['id'] ?>/upload/" enctype="multipart/form-data" class="document-row__upload">
            <?= csrf_field() ?>
            <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required>
            <button type="submit" class="btn btn-sm btn-primary"><?= $doc['stored_filename'] ? 'Replace' : 'Upload' ?></button>
        </form>
        <?php if ($doc['stored_filename']): ?>
        <form method="post" action="/dashboard/documents/<?= (int) $doc['id'] ?>/delete/" data-confirm="Remove this uploaded file?">
            <?= csrf_field() ?>
            <button type="submit" class="btn btn-sm btn-outline">Remove</button>
        </form>
        <?php endif; ?>
        <p class="form-hint">PDF, JPG, or PNG &middot; up to 5&nbsp;MB.</p>
        <?php endif; ?>
    </div>
    <?php
}
