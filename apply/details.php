<?php
declare(strict_types=1);

/** Application wizard, step 2: applicant details. */

require_login();

if (empty($_SESSION['apply_wizard']['country_id']) || empty($_SESSION['apply_wizard']['visa_type_id'])) {
    redirect('/apply/');
}

$wizard = $_SESSION['apply_wizard'];
$user = current_user();
$pdo = db();
$countries = $pdo->query('SELECT name FROM countries WHERE is_active = 1 ORDER BY name')->fetchAll();

$errors = [];
$old = [
    'passport_number' => $wizard['applicant_passport_number'] ?? '',
    'dob' => $wizard['applicant_dob'] ?? '',
    'nationality' => $wizard['applicant_nationality'] ?? '',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $old['passport_number'] = strtoupper(trim((string) ($_POST['passport_number'] ?? '')));
    $old['dob'] = trim((string) ($_POST['dob'] ?? ''));
    $old['nationality'] = trim((string) ($_POST['nationality'] ?? ''));

    if (!preg_match('/^[A-Z0-9]{5,20}$/', $old['passport_number'])) {
        $errors[] = 'Enter a valid passport number.';
    }

    $dobTimestamp = strtotime($old['dob']);
    if (!$dobTimestamp || $dobTimestamp > time() || $dobTimestamp < strtotime('-120 years')) {
        $errors[] = 'Enter a valid date of birth.';
    }

    if ($old['nationality'] === '') {
        $errors[] = 'Select your nationality.';
    }

    if (!$errors) {
        $_SESSION['apply_wizard']['applicant_passport_number'] = $old['passport_number'];
        $_SESSION['apply_wizard']['applicant_dob'] = $old['dob'];
        $_SESSION['apply_wizard']['applicant_nationality'] = $old['nationality'];
        redirect('/apply/review/');
    }
}

$pageTitle = 'Applicant Details - Application';
$pageDescription = 'Enter your applicant details for your Visagiri visa application.';
$canonicalUrl = APP_URL . '/apply/details/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card" style="max-width:560px">
        <?php require __DIR__ . '/../includes/apply-steps.php'; renderApplyStepper(2); ?>
        <h1>Applicant details</h1>
        <p class="auth-card__subtitle"><?= flag_emoji($wizard['country_iso2']) ?> <?= e($wizard['visa_type_name']) ?> for <?= e($wizard['country_name']) ?></p>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/apply/details/">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="applicant_name">Full name (from your account)</label>
                <input class="form-input" type="text" id="applicant_name" value="<?= e($user['full_name']) ?>" disabled>
            </div>
            <div class="form-group">
                <label class="form-label" for="passport_number">Passport number</label>
                <input class="form-input" type="text" id="passport_number" name="passport_number" value="<?= e($old['passport_number']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="dob">Date of birth</label>
                <input class="form-input" type="date" id="dob" name="dob" value="<?= e($old['dob']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="nationality">Nationality</label>
                <select class="form-select" id="nationality" name="nationality" required>
                    <option value="">Select nationality</option>
                    <?php foreach ($countries as $c): ?>
                    <option value="<?= e($c['name']) ?>" <?= $old['nationality'] === $c['name'] ? 'selected' : '' ?>><?= e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="button-group">
                <a href="/apply/" class="btn btn-outline">Back</a>
                <button type="submit" class="btn btn-primary">Continue</button>
            </div>
        </form>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
