<?php
declare(strict_types=1);

/**
 * Application wizard, step 1: destination + visa type. Requires
 * login (creating an application is tied to an account). Wizard
 * state lives in $_SESSION['apply_wizard'] until the final submit on
 * /apply/review/ — nothing is written to the applications table
 * until then, so an abandoned wizard never leaves a stray row.
 */

require_login();

$pdo = db();
$countries = $pdo->query('SELECT id, name, slug, iso2 FROM countries WHERE is_active = 1 ORDER BY name')->fetchAll();
$visaTypes = $pdo->query('SELECT id, name, slug FROM visa_types WHERE is_active = 1 ORDER BY sort_order')->fetchAll();

$errors = [];
$selectedCountrySlug = $_GET['country'] ?? ($_SESSION['apply_wizard']['country_slug'] ?? '');
$selectedTypeSlug = $_GET['type'] ?? ($_SESSION['apply_wizard']['visa_type_slug'] ?? '');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $countrySlug = (string) ($_POST['country'] ?? '');
    $typeSlug = (string) ($_POST['visa_type'] ?? '');

    $country = null;
    $visaType = null;
    foreach ($countries as $c) {
        if ($c['slug'] === $countrySlug) {
            $country = $c;
            break;
        }
    }
    foreach ($visaTypes as $t) {
        if ($t['slug'] === $typeSlug) {
            $visaType = $t;
            break;
        }
    }

    if (!$country) {
        $errors[] = 'Select a destination country.';
    }
    if (!$visaType) {
        $errors[] = 'Select a visa type.';
    }

    if (!$errors) {
        $_SESSION['apply_wizard'] = [
            'country_id' => $country['id'],
            'country_slug' => $country['slug'],
            'country_name' => $country['name'],
            'country_iso2' => $country['iso2'],
            'visa_type_id' => $visaType['id'],
            'visa_type_slug' => $visaType['slug'],
            'visa_type_name' => $visaType['name'],
        ];
        redirect('/apply/details/');
    }

    $selectedCountrySlug = $countrySlug;
    $selectedTypeSlug = $typeSlug;
}

$pageTitle = 'Start Your Visa Application';
$pageDescription = 'Start your visa application with Visagiri.';
$canonicalUrl = APP_URL . '/apply/';
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card" style="max-width:560px">
        <?php require __DIR__ . '/../includes/apply-steps.php'; renderApplyStepper(1); ?>
        <h1>Where are you travelling?</h1>
        <p class="auth-card__subtitle">Select your destination and visa type to begin.</p>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/apply/">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="country">Destination country</label>
                <select class="form-select" id="country" name="country" required>
                    <option value="">Select country</option>
                    <?php foreach ($countries as $c): ?>
                    <option value="<?= e($c['slug']) ?>" <?= $selectedCountrySlug === $c['slug'] ? 'selected' : '' ?>><?= e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="visa_type">Visa type</label>
                <select class="form-select" id="visa_type" name="visa_type" required>
                    <option value="">Select visa type</option>
                    <?php foreach ($visaTypes as $t): ?>
                    <option value="<?= e($t['slug']) ?>" <?= $selectedTypeSlug === $t['slug'] ? 'selected' : '' ?>><?= e($t['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Continue</button>
        </form>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
