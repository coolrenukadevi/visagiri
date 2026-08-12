<?php
declare(strict_types=1);

/**
 * Application wizard, step 3: review and submit. This is where the
 * real application row, its initial status history entry, and its
 * document checklist rows are actually created — nothing before this
 * point touches the database.
 */

require_login();

if (empty($_SESSION['apply_wizard']['applicant_passport_number'])) {
    redirect('/apply/details/');
}

$wizard = $_SESSION['apply_wizard'];
$user = current_user();
$pdo = db();

$requiredDocuments = $pdo->query(
    'SELECT id, name FROM documents WHERE is_required_default = 1 ORDER BY name'
)->fetchAll();

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    try {
        $pdo->beginTransaction();

        $applicationNumber = generate_application_number($pdo);

        $insert = $pdo->prepare(
            'INSERT INTO applications
                (application_number, user_id, country_id, visa_type_id, status, progress_percent,
                 applicant_passport_number, applicant_dob, applicant_nationality)
             VALUES (:number, :user_id, :country_id, :visa_type_id, "created", 10,
                     :passport_number, :dob, :nationality)'
        );
        $insert->execute([
            'number' => $applicationNumber,
            'user_id' => $user['id'],
            'country_id' => $wizard['country_id'],
            'visa_type_id' => $wizard['visa_type_id'],
            'passport_number' => $wizard['applicant_passport_number'],
            'dob' => $wizard['applicant_dob'],
            'nationality' => $wizard['applicant_nationality'],
        ]);
        $applicationId = (int) $pdo->lastInsertId();

        $pdo->prepare(
            'INSERT INTO application_status_history (application_id, status, comment, changed_by)
             VALUES (:id, "created", "Application submitted online.", :user_id)'
        )->execute(['id' => $applicationId, 'user_id' => $user['id']]);

        $docInsert = $pdo->prepare(
            'INSERT INTO application_documents (application_id, document_id, status) VALUES (:app_id, :doc_id, "required")'
        );
        foreach ($requiredDocuments as $doc) {
            $docInsert->execute(['app_id' => $applicationId, 'doc_id' => $doc['id']]);
        }

        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        $errors[] = 'Something went wrong submitting your application. Please try again.';
    }

    if (!$errors) {
        unset($_SESSION['apply_wizard']);
        flash_set('notice', "Application $applicationNumber submitted successfully.");
        redirect("/dashboard/applications/$applicationId/");
    }
}

$pageTitle = 'Review & Submit - Application';
$pageDescription = 'Review and submit your Visagiri visa application.';
$canonicalUrl = APP_URL . '/apply/review/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card" style="max-width:600px">
        <?php require __DIR__ . '/../includes/apply-steps.php'; renderApplyStepper(3); ?>
        <h1>Review &amp; submit</h1>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="apply-review__row">
            <span class="apply-review__label">Destination</span>
            <span class="apply-review__value"><?= flag_emoji($wizard['country_iso2']) ?> <?= e($wizard['country_name']) ?></span>
        </div>
        <div class="apply-review__row">
            <span class="apply-review__label">Visa type</span>
            <span class="apply-review__value"><?= e($wizard['visa_type_name']) ?></span>
        </div>
        <div class="apply-review__row">
            <span class="apply-review__label">Applicant</span>
            <span class="apply-review__value"><?= e($user['full_name']) ?></span>
        </div>
        <div class="apply-review__row">
            <span class="apply-review__label">Passport number</span>
            <span class="apply-review__value"><?= e($wizard['applicant_passport_number']) ?></span>
        </div>
        <div class="apply-review__row">
            <span class="apply-review__label">Date of birth</span>
            <span class="apply-review__value"><?= e(date('d M Y', strtotime((string) $wizard['applicant_dob']))) ?></span>
        </div>
        <div class="apply-review__row">
            <span class="apply-review__label">Nationality</span>
            <span class="apply-review__value"><?= e($wizard['applicant_nationality']) ?></span>
        </div>

        <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Documents you'll need to upload</h2>
        <?php foreach ($requiredDocuments as $doc): ?>
        <div class="checklist-item">
            <span class="checklist-item__icon">&#10003;</span>
            <span><?= e($doc['name']) ?></span>
        </div>
        <?php endforeach; ?>
        <p class="form-hint" style="margin-top:var(--space-3)">You'll be able to upload these from your dashboard after submitting. Your consultant may request additional documents once your requirements are confirmed.</p>

        <div class="alert alert-info" style="margin-top:var(--space-6)">
            Service fees, government fees, and any appointment/biometrics scheduling will be confirmed by your assigned consultant based on your specific requirements — nothing is charged automatically. Payment options will appear here once confirmed.
        </div>

        <form method="post" action="/apply/review/" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <div class="button-group">
                <a href="/apply/details/" class="btn btn-outline">Back</a>
                <button type="submit" class="btn btn-gold">Submit Application</button>
            </div>
        </form>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
