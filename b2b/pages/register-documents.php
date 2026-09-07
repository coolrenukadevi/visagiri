<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 3: KYC / Business Documents.
 * Nothing here is hard-required (matches the reasoning in the
 * existing partner/pages/register-documents.php: verification is a
 * later admin step, not a gate on completing signup) — an
 * under-documented account can still register and be asked for more
 * later via the "documents_required" status.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();

$existingStmt = db()->prepare('SELECT * FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
$existingStmt->execute(['id' => $partner['id']]);
$existingByType = [];
foreach ($existingStmt->fetchAll() as $row) {
    if (!isset($existingByType[$row['document_type']])) {
        $existingByType[$row['document_type']] = $row;
    }
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $uploaded = $_FILES['documents'] ?? null;
    if (is_array($uploaded)) {
        foreach (array_keys(B2B_DOCUMENT_TYPES) as $type) {
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
                $errors[] = B2B_DOCUMENT_TYPES[$type] . ': ' . $validationError;
                continue;
            }

            if (isset($existingByType[$type])) {
                db()->prepare('UPDATE b2b_partner_documents SET deleted_at = NOW() WHERE id = :id')
                    ->execute(['id' => $existingByType[$type]['id']]);
            }
            store_b2b_partner_document($file, $type, (int) $partner['id'], (int) $user['id']);
        }
    }

    if (!$errors) {
        redirect('/b2b/register-services/');
    }

    $existingStmt->execute(['id' => $partner['id']]);
    $existingByType = [];
    foreach ($existingStmt->fetchAll() as $row) {
        if (!isset($existingByType[$row['document_type']])) {
            $existingByType[$row['document_type']] = $row;
        }
    }
}

$pageTitle = 'Become a B2B Travel Partner - Step 3 - Visagiri';
$canonicalUrl = APP_URL . '/b2b/register-documents/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(3); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/b2b/register-documents/" enctype="multipart/form-data" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Business / KYC Documents</h2>
            <p style="color:var(--text-muted);font-size:var(--font-size-sm)">PDF, JPG, JPEG or PNG — max 10MB per file. You can add or replace documents later from your dashboard.</p>

            <table class="admin-table" style="margin-top:var(--space-4)">
                <thead><tr><th>Document</th><th>Status</th><th></th></tr></thead>
                <tbody>
                <?php foreach (B2B_DOCUMENT_TYPES as $type => $label): ?>
                <tr>
                    <td><label for="doc_<?= e($type) ?>"><?= e($label) ?></label></td>
                    <td>
                        <?php if (isset($existingByType[$type])): ?>
                        <span class="badge badge-success"><?= e(ucwords(str_replace('_', ' ', $existingByType[$type]['verification_status']))) ?></span>
                        <?php else: ?>
                        <span class="badge badge-neutral">Not Uploaded</span>
                        <?php endif; ?>
                    </td>
                    <td><input type="file" id="doc_<?= e($type) ?>" name="documents[<?= e($type) ?>]" accept=".pdf,.jpg,.jpeg,.png"></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-5)">Continue &rarr;</button>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
