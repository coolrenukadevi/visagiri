<?php
declare(strict_types=1);

/**
 * Enrollment wizard step 4 — Document Upload. Requires login. No
 * document type is hard-required except the IATA certificate, and
 * only when the partner said "Yes" to IATA registered in step 1
 * (client spec §2's own conditional wording) — everything else here
 * is genuinely optional at registration time; document *verification*
 * is Phase 3, not this phase.
 */

$partner = current_partner();
$profile = current_partner_business_profile();

$existingStmt = db()->prepare('SELECT * FROM partner_documents WHERE partner_id = :id AND deleted_at IS NULL');
$existingStmt->execute(['id' => $partner['id']]);
$existingByType = [];
foreach ($existingStmt->fetchAll() as $row) {
    $existingByType[$row['document_type']] = $row;
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $uploaded = $_FILES['documents'] ?? null;
    if (is_array($uploaded)) {
        foreach (array_keys(PARTNER_DOCUMENT_TYPES) as $type) {
            $hasFile = ($uploaded['error'][$type] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
            if (!$hasFile) {
                continue;
            }
            $file = [
                'name' => $uploaded['name'][$type],
                'type' => $uploaded['type'][$type],
                'tmp_name' => $uploaded['tmp_name'][$type],
                'error' => $uploaded['error'][$type],
                'size' => $uploaded['size'][$type],
            ];
            $validationError = validate_document_upload($file);
            if ($validationError !== null) {
                $errors[] = PARTNER_DOCUMENT_TYPES[$type] . ': ' . $validationError;
                continue;
            }

            if (isset($existingByType[$type])) {
                db()->prepare('UPDATE partner_documents SET deleted_at = NOW() WHERE id = :id')
                    ->execute(['id' => $existingByType[$type]['id']]);
            }
            store_partner_document_upload($file, $type, (int) $partner['id']);
        }
    }

    if (!$errors) {
        // Re-fetch — a document uploaded in this same request needs to
        // count toward the IATA requirement check below.
        $recheckStmt = db()->prepare("SELECT id FROM partner_documents WHERE partner_id = :id AND document_type = 'iata_certificate' AND deleted_at IS NULL");
        $recheckStmt->execute(['id' => $partner['id']]);
        $hasIataCert = (bool) $recheckStmt->fetchColumn();

        if ($profile && (int) $profile['iata_registered'] === 1 && !$hasIataCert) {
            $errors[] = 'Upload your IATA certificate to continue, or go back and change your IATA registration answer.';
        }
    }

    if (!$errors) {
        redirect('/partner/register-terms/');
    }

    // Re-fetch for re-render after a validation error.
    $existingStmt->execute(['id' => $partner['id']]);
    $existingByType = [];
    foreach ($existingStmt->fetchAll() as $row) {
        $existingByType[$row['document_type']] = $row;
    }
}

$pageTitle = 'Become a B2B Partner - Step 4 - Visagiri';
$canonicalUrl = APP_URL . '/partner/register-documents/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php render_partner_enrollment_steps(4); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register-documents/" enctype="multipart/form-data" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Document Upload</h2>
            <p style="color:var(--text-muted);font-size:var(--font-size-sm)">PDF, JPG, JPEG, PNG, DOC or DOCX — max 10MB per file. Everything here is optional except the IATA certificate, if you said you're IATA registered.</p>

            <?php foreach (PARTNER_DOCUMENT_TYPES as $type => $label): ?>
            <div class="enrollment-document-row">
                <div class="enrollment-document-row__meta">
                    <strong><?= e($label) ?></strong><?= ($type === 'iata_certificate' && $profile && (int) $profile['iata_registered'] === 1) ? ' <span class="badge badge-warning">Required</span>' : '' ?>
                    <?php if (isset($existingByType[$type])): ?>
                    <div class="enrollment-document-row__filename">Uploaded: <?= e($existingByType[$type]['original_filename']) ?></div>
                    <?php endif; ?>
                </div>
                <input type="file" name="documents[<?= e($type) ?>]" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx">
            </div>
            <?php endforeach; ?>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Continue &rarr;</button>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
