<?php
declare(strict_types=1);

$customer = current_customer();
$applicationId = isset($_GET['application_id']) ? (int) $_GET['application_id'] : (isset($_POST['application_id']) ? (int) $_POST['application_id'] : null);

$appStmt = db()->prepare(
    "SELECT va.*, c.name AS country_name, vt.name AS visa_type_name FROM visa_applications va
     JOIN countries c ON c.id = va.country_id JOIN visa_types vt ON vt.id = va.visa_type_id
     WHERE va.id = :id AND va.customer_id = :customer_id AND va.deleted_at IS NULL"
);
$appStmt->execute(['id' => $applicationId, 'customer_id' => $customer['id']]);
$application = $appStmt->fetch();

if (!$application) {
    render_dashboard_start('documents', 'Upload Document');
    echo '<p class="empty-state">We couldn\'t find that application, or it doesn\'t belong to your account.</p>';
    render_dashboard_end();
    exit;
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $documentType = trim((string) ($_POST['document_type'] ?? ''));
    $file = $_FILES['document'] ?? null;

    if ($documentType === '') {
        $errors[] = 'Select a document type.';
    }
    if (!$file) {
        $errors[] = 'Choose a file to upload.';
    } else {
        $validationError = validate_document_upload($file);
        if ($validationError) {
            $errors[] = $validationError;
        }
    }

    if (!$errors) {
        store_customer_document_upload($file, $documentType, (int) $customer['id'], (int) $application['id']);
        flash_set('notice', 'Document uploaded — our team will review it shortly.');
        redirect('/dashboard/applications/?id=' . $application['id']);
    }
}

render_dashboard_start('documents', 'Upload Document');
?>
<p><a href="/dashboard/applications/?id=<?= (int) $application['id'] ?>">&larr; <?= e($application['visa_type_name']) ?> &mdash; <?= e($application['country_name']) ?></a></p>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>
<form method="post" action="/dashboard/document-upload/?application_id=<?= (int) $application['id'] ?>" enctype="multipart/form-data" class="card" style="padding:var(--space-6);max-width:480px">
    <?= csrf_field() ?>
    <input type="hidden" name="application_id" value="<?= (int) $application['id'] ?>">
    <div class="form-group">
        <label class="form-label" for="document_type">Document Type</label>
        <input class="form-input" type="text" id="document_type" name="document_type" placeholder="e.g. Passport copy, Bank statement" required autofocus>
    </div>
    <div class="form-group">
        <label class="form-label" for="document">File</label>
        <input class="form-input" type="file" id="document" name="document" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" required>
        <span class="form-hint">PDF, JPG, PNG, DOC, or DOCX — max 10MB.</span>
    </div>
    <button type="submit" class="btn btn-primary" style="width:100%">Upload</button>
</form>
<?php render_dashboard_end(); ?>
