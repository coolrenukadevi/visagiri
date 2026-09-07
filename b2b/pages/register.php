<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 1: Business Information. Purely
 * session-held, same reasoning as partner/pages/register.php: no
 * b2b_partners row exists yet, so nothing here can collide with a
 * duplicate-check against a record this visitor is about to create.
 * Step 2 (Contact & Verification) creates the real account.
 */

if (is_b2b_partner_logged_in()) {
    redirect('/b2b/dashboard/');
}

$old = $_SESSION['b2b_enrollment']['step1'] ?? [
    'legal_business_name' => '', 'trade_name' => '', 'business_type' => '', 'registration_type' => '',
    'company_registration_number' => '', 'gstin' => '', 'pan' => '', 'cin_llp' => '', 'year_established' => '', 'website' => '',
    'business_email' => '', 'business_phone' => '', 'whatsapp_number' => '',
    'office_address' => '', 'city' => '', 'state' => '', 'country' => 'India', 'pincode' => '',
    'iata_number' => '', 'tids_number' => '', 'udyam_number' => '', 'other_membership' => '',
    'employee_count' => '', 'primary_business_activity' => '',
];
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    foreach (array_keys($old) as $key) {
        $old[$key] = trim((string) ($_POST[$key] ?? ''));
    }
    $old['gstin'] = strtoupper($old['gstin']);
    $old['pan'] = strtoupper($old['pan']);

    if ($old['legal_business_name'] === '') {
        $errors[] = 'Enter your legal business name.';
    }
    if (!array_key_exists($old['business_type'], B2B_BUSINESS_TYPES)) {
        $errors[] = 'Select a business type.';
    }
    if ($old['office_address'] === '' || $old['city'] === '' || $old['state'] === '' || $old['pincode'] === '') {
        $errors[] = 'Office address, city, state and PIN code are required.';
    }
    if (!is_valid_email($old['business_email'])) {
        $errors[] = 'Enter a valid business email address.';
    }
    if (!is_valid_mobile($old['business_phone'])) {
        $errors[] = 'Enter a valid business phone number with country code.';
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

    if (!$errors) {
        $_SESSION['b2b_enrollment']['step1'] = $old;
        redirect('/b2b/register-contact/');
    }
}

$pageTitle = 'Become a B2B Travel Partner - Step 1 - Visagiri';
$pageDescription = 'Register your travel business as a Visagiri B2B Travel Partner.';
$canonicalUrl = APP_URL . '/b2b/register/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(1); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/b2b/register/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Company Information</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="legal_business_name">Legal Business Name</label>
                    <input class="form-input" type="text" id="legal_business_name" name="legal_business_name" value="<?= e($old['legal_business_name']) ?>" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label" for="trade_name">Trade / Brand Name</label>
                    <input class="form-input" type="text" id="trade_name" name="trade_name" value="<?= e($old['trade_name']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="business_type">Business Type</label>
                    <select class="form-select" id="business_type" name="business_type" required>
                        <option value="">Select…</option>
                        <?php foreach (B2B_BUSINESS_TYPES as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $old['business_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="registration_type">Registration Type</label>
                    <input class="form-input" type="text" id="registration_type" name="registration_type" value="<?= e($old['registration_type']) ?>" placeholder="e.g. Proprietorship, Pvt Ltd, LLP">
                </div>
                <div class="form-group">
                    <label class="form-label" for="company_registration_number">Company Registration Number</label>
                    <input class="form-input" type="text" id="company_registration_number" name="company_registration_number" value="<?= e($old['company_registration_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="cin_llp">CIN / LLP Registration Number</label>
                    <input class="form-input" type="text" id="cin_llp" name="cin_llp" value="<?= e($old['cin_llp']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="gstin">GST Number</label>
                    <input class="form-input" type="text" id="gstin" name="gstin" value="<?= e($old['gstin']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="pan">PAN Number</label>
                    <input class="form-input" type="text" id="pan" name="pan" value="<?= e($old['pan']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="year_established">Year Established</label>
                    <input class="form-input" type="number" id="year_established" name="year_established" value="<?= e($old['year_established']) ?>" min="1900" max="<?= date('Y') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="website">Website</label>
                    <input class="form-input" type="text" id="website" name="website" value="<?= e($old['website']) ?>" placeholder="www.example.com">
                </div>
                <div class="form-group">
                    <label class="form-label" for="business_email">Business Email</label>
                    <input class="form-input" type="email" id="business_email" name="business_email" value="<?= e($old['business_email']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="business_phone">Business Phone</label>
                    <input class="form-input" type="tel" id="business_phone" name="business_phone" value="<?= e($old['business_phone']) ?>" placeholder="e.g. +91 98765 43210" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="whatsapp_number">WhatsApp Number</label>
                    <input class="form-input" type="tel" id="whatsapp_number" name="whatsapp_number" value="<?= e($old['whatsapp_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="iata_number">IATA Number</label>
                    <input class="form-input" type="text" id="iata_number" name="iata_number" value="<?= e($old['iata_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="tids_number">TIDS Number</label>
                    <input class="form-input" type="text" id="tids_number" name="tids_number" value="<?= e($old['tids_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="udyam_number">Udyam Registration Number</label>
                    <input class="form-input" type="text" id="udyam_number" name="udyam_number" value="<?= e($old['udyam_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="other_membership">Other Travel Industry Membership</label>
                    <input class="form-input" type="text" id="other_membership" name="other_membership" value="<?= e($old['other_membership']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="employee_count">Number of Employees</label>
                    <input class="form-input" type="text" id="employee_count" name="employee_count" value="<?= e($old['employee_count']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="primary_business_activity">Primary Business Activity</label>
                    <input class="form-input" type="text" id="primary_business_activity" name="primary_business_activity" value="<?= e($old['primary_business_activity']) ?>">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="office_address">Office Address</label>
                <textarea class="form-input" id="office_address" name="office_address" rows="2"><?= e($old['office_address']) ?></textarea>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4);flex-wrap:wrap">
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="city">City</label>
                    <input class="form-input" type="text" id="city" name="city" value="<?= e($old['city']) ?>" required>
                </div>
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="state">State</label>
                    <input class="form-input" type="text" id="state" name="state" value="<?= e($old['state']) ?>" required>
                </div>
                <div style="flex:1;min-width:140px">
                    <label class="form-label" for="country">Country</label>
                    <input class="form-input" type="text" id="country" name="country" value="<?= e($old['country']) ?>" required>
                </div>
                <div style="flex:1;min-width:120px">
                    <label class="form-label" for="pincode">PIN Code</label>
                    <input class="form-input" type="text" id="pincode" name="pincode" value="<?= e($old['pincode']) ?>" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Continue &rarr;</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already a partner? <a href="/b2b/login/">Sign in</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
