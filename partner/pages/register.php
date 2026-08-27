<?php
declare(strict_types=1);

/**
 * Enrollment wizard step 1 — Business Info. Purely session-held: no
 * partners row exists yet, so nothing here can be a duplicate-check
 * false negative against a record this same visitor is about to
 * create. Step 2 (contact/password) is where the real account gets
 * created, combining this step's session data with its own form.
 */

if (is_partner_logged_in()) {
    $partner = current_partner();
    redirect(partner_enrollment_next_route($partner, current_partner_business_profile()));
}

$old = $_SESSION['partner_enrollment']['step1'] ?? [
    'company_name' => '', 'business_type' => '', 'year_established' => '', 'website' => '',
    'gstin' => '', 'pan' => '', 'iata_registered' => '0', 'iata_number' => '', 'tafi_number' => '',
    'other_association' => '', 'registered_address' => '', 'city' => '', 'state' => '', 'country' => '', 'pincode' => '',
];
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $old['company_name'] = trim((string) ($_POST['company_name'] ?? ''));
    $old['business_type'] = trim((string) ($_POST['business_type'] ?? ''));
    $old['year_established'] = trim((string) ($_POST['year_established'] ?? ''));
    $old['website'] = trim((string) ($_POST['website'] ?? ''));
    $old['gstin'] = strtoupper(trim((string) ($_POST['gstin'] ?? '')));
    $old['pan'] = strtoupper(trim((string) ($_POST['pan'] ?? '')));
    $old['iata_registered'] = ($_POST['iata_registered'] ?? '0') === '1' ? '1' : '0';
    $old['iata_number'] = trim((string) ($_POST['iata_number'] ?? ''));
    $old['tafi_number'] = trim((string) ($_POST['tafi_number'] ?? ''));
    $old['other_association'] = trim((string) ($_POST['other_association'] ?? ''));
    $old['registered_address'] = trim((string) ($_POST['registered_address'] ?? ''));
    $old['city'] = trim((string) ($_POST['city'] ?? ''));
    $old['state'] = trim((string) ($_POST['state'] ?? ''));
    $old['country'] = trim((string) ($_POST['country'] ?? ''));
    $old['pincode'] = trim((string) ($_POST['pincode'] ?? ''));

    if ($old['company_name'] === '') {
        $errors[] = 'Enter your agency or company name.';
    }
    if (!array_key_exists($old['business_type'], PARTNER_BUSINESS_TYPES)) {
        $errors[] = 'Select a business type.';
    }
    if ($old['year_established'] !== '' && (!ctype_digit($old['year_established']) || (int) $old['year_established'] < 1900 || (int) $old['year_established'] > (int) date('Y'))) {
        $errors[] = 'Enter a valid year established.';
    }
    if ($old['gstin'] !== '' && !preg_match('/^[0-9A-Z]{15}$/', $old['gstin'])) {
        $errors[] = 'GST number should be 15 characters.';
    }
    if ($old['pan'] !== '' && !preg_match('/^[0-9A-Z]{10}$/', $old['pan'])) {
        $errors[] = 'PAN should be 10 characters.';
    }
    if ($old['iata_registered'] === '1' && $old['iata_number'] === '') {
        $errors[] = 'Enter your IATA number, or select "No" if you are not IATA registered.';
    }

    if (!$errors) {
        $duplicate = find_partner_duplicate(
            companyName: $old['company_name'],
            gstin: $old['gstin'] !== '' ? $old['gstin'] : null,
            pan: $old['pan'] !== '' ? $old['pan'] : null,
            iataNumber: $old['iata_number'] !== '' ? $old['iata_number'] : null
        );
        if ($duplicate !== null) {
            $errors[] = $duplicate;
        }
    }

    if (!$errors) {
        $_SESSION['partner_enrollment']['step1'] = $old;
        redirect('/partner/register-contact/');
    }
}

$pageTitle = 'Become a B2B Partner - Step 1 - Visagiri';
$pageDescription = 'Register as a Visagiri B2B visa partner — travel agencies, tour operators, visa consultants and corporate travel desks.';
$canonicalUrl = APP_URL . '/partner/register/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php render_partner_enrollment_steps(1); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Business Information</h2>
            <div class="form-group">
                <label class="form-label" for="company_name">Agency / Company Name</label>
                <input class="form-input" type="text" id="company_name" name="company_name" value="<?= e($old['company_name']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="business_type">Business Type</label>
                <select class="form-select" id="business_type" name="business_type" required>
                    <option value="">Select…</option>
                    <?php foreach (PARTNER_BUSINESS_TYPES as $key => $label): ?>
                    <option value="<?= e($key) ?>"<?= $old['business_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4)">
                <div style="flex:1">
                    <label class="form-label" for="year_established">Year Established</label>
                    <input class="form-input" type="number" id="year_established" name="year_established" value="<?= e($old['year_established']) ?>" min="1900" max="<?= date('Y') ?>">
                </div>
                <div style="flex:1">
                    <label class="form-label" for="website">Website</label>
                    <input class="form-input" type="text" id="website" name="website" value="<?= e($old['website']) ?>" placeholder="www.example.com">
                </div>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4)">
                <div style="flex:1">
                    <label class="form-label" for="gstin">GST Number</label>
                    <input class="form-input" type="text" id="gstin" name="gstin" value="<?= e($old['gstin']) ?>">
                </div>
                <div style="flex:1">
                    <label class="form-label" for="pan">PAN Number</label>
                    <input class="form-input" type="text" id="pan" name="pan" value="<?= e($old['pan']) ?>">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">IATA Registered?</label>
                <div style="display:flex;gap:var(--space-4)">
                    <label style="display:flex;align-items:center;gap:var(--space-2);font-weight:var(--font-weight-regular)"><input type="radio" name="iata_registered" value="1" data-iata-toggle<?= $old['iata_registered'] === '1' ? ' checked' : '' ?>> Yes</label>
                    <label style="display:flex;align-items:center;gap:var(--space-2);font-weight:var(--font-weight-regular)"><input type="radio" name="iata_registered" value="0" data-iata-toggle<?= $old['iata_registered'] !== '1' ? ' checked' : '' ?>> No</label>
                </div>
            </div>
            <div class="form-group" id="iata-number-group" style="<?= $old['iata_registered'] === '1' ? '' : 'display:none' ?>">
                <label class="form-label" for="iata_number">IATA Number</label>
                <input class="form-input" type="text" id="iata_number" name="iata_number" value="<?= e($old['iata_number']) ?>">
                <span class="form-hint">You'll be able to upload your IATA certificate in the Documents step.</span>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4)">
                <div style="flex:1">
                    <label class="form-label" for="tafi_number">TAFI Number</label>
                    <input class="form-input" type="text" id="tafi_number" name="tafi_number" value="<?= e($old['tafi_number']) ?>">
                </div>
                <div style="flex:1">
                    <label class="form-label" for="other_association">Other Travel Association Membership</label>
                    <input class="form-input" type="text" id="other_association" name="other_association" value="<?= e($old['other_association']) ?>">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="registered_address">Office Address</label>
                <textarea class="form-input" id="registered_address" name="registered_address" rows="2"><?= e($old['registered_address']) ?></textarea>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4);flex-wrap:wrap">
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="city">City</label>
                    <input class="form-input" type="text" id="city" name="city" value="<?= e($old['city']) ?>">
                </div>
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="state">State</label>
                    <input class="form-input" type="text" id="state" name="state" value="<?= e($old['state']) ?>">
                </div>
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="country">Country</label>
                    <input class="form-input" type="text" id="country" name="country" value="<?= e($old['country']) ?>">
                </div>
                <div style="flex:1;min-width:120px">
                    <label class="form-label" for="pincode">PIN Code</label>
                    <input class="form-input" type="text" id="pincode" name="pincode" value="<?= e($old['pincode']) ?>">
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Continue &rarr;</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already a partner? <a href="/partner/login/">Sign in</a></p>
        </form>
    </div>
</section>
<script src="<?= e(asset_url('/assets/js/partner-enrollment.js')) ?>"></script>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
