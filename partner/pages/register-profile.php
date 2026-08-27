<?php
declare(strict_types=1);

/** Enrollment wizard step 3 — Business Profile (services, visa specialization, volume). Requires login — the account was created in step 2. */

$partner = current_partner();

$profile = current_partner_business_profile();
if ($profile === null) {
    // Shouldn't happen (step 2 always creates this row), but if it's
    // ever missing there's nothing to update here — send back to
    // step 1 rather than fatal-erroring on a null UPDATE target.
    redirect('/partner/register/');
}

$old = [
    'services_offered' => $profile['services_offered'] !== null ? explode(',', $profile['services_offered']) : [],
    'visa_specialization' => $profile['visa_specialization'] !== null ? explode(',', $profile['visa_specialization']) : [],
    'monthly_visa_volume' => $profile['monthly_visa_volume'] ?? '',
];
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $old['services_offered'] = partner_filter_allowed_values((array) ($_POST['services_offered'] ?? []), PARTNER_SERVICES_OFFERED);
    $old['visa_specialization'] = partner_filter_allowed_values((array) ($_POST['visa_specialization'] ?? []), PARTNER_VISA_SPECIALIZATION);
    $old['monthly_visa_volume'] = trim((string) ($_POST['monthly_visa_volume'] ?? ''));

    if (!$old['services_offered']) {
        $errors[] = 'Select at least one service you currently offer.';
    }
    if ($old['monthly_visa_volume'] !== '' && !in_array($old['monthly_visa_volume'], PARTNER_MONTHLY_VOLUME, true)) {
        $errors[] = 'Select a valid monthly visa volume.';
    }

    if (!$errors) {
        db()->prepare(
            'UPDATE partner_business_profiles SET services_offered = :services, visa_specialization = :visa, monthly_visa_volume = :volume WHERE partner_id = :id'
        )->execute([
            'services' => implode(',', $old['services_offered']),
            'visa' => $old['visa_specialization'] ? implode(',', $old['visa_specialization']) : null,
            'volume' => $old['monthly_visa_volume'] !== '' ? $old['monthly_visa_volume'] : null,
            'id' => $partner['id'],
        ]);
        redirect('/partner/register-documents/');
    }
}

$devVerifyLink = flash_get('partner_dev_verify_link');
$notice = flash_get('notice');

$pageTitle = 'Become a B2B Partner - Step 3 - Visagiri';
$canonicalUrl = APP_URL . '/partner/register-profile/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php render_partner_enrollment_steps(3); ?>
        <?php if ($notice): ?>
        <div class="alert alert-info"><?= e($notice) ?></div>
        <?php endif; ?>
        <?php if ($devVerifyLink): ?>
        <div class="alert alert-warning">
            <strong>Development mode only</strong> (no email service is connected yet):<br>
            <a href="<?= e($devVerifyLink) ?>"><?= e($devVerifyLink) ?></a>
        </div>
        <?php endif; ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register-profile/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Business Profile</h2>

            <div class="form-group">
                <label class="form-label">Services Currently Offered</label>
                <div class="enrollment-checkbox-grid">
                    <?php foreach (PARTNER_SERVICES_OFFERED as $key => $label): ?>
                    <label><input type="checkbox" name="services_offered[]" value="<?= e($key) ?>"<?= in_array($key, $old['services_offered'], true) ? ' checked' : '' ?>> <?= e($label) ?></label>
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Visa Specialization</label>
                <div class="enrollment-checkbox-grid">
                    <?php foreach (PARTNER_VISA_SPECIALIZATION as $key => $label): ?>
                    <label><input type="checkbox" name="visa_specialization[]" value="<?= e($key) ?>"<?= in_array($key, $old['visa_specialization'], true) ? ' checked' : '' ?>> <?= e($label) ?></label>
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="monthly_visa_volume">Approximate Monthly Visa Volume</label>
                <select class="form-select" id="monthly_visa_volume" name="monthly_visa_volume">
                    <option value="">Select…</option>
                    <?php foreach (PARTNER_MONTHLY_VOLUME as $option): ?>
                    <option value="<?= e($option) ?>"<?= $old['monthly_visa_volume'] === $option ? ' selected' : '' ?>><?= e($option) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Continue &rarr;</button>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
