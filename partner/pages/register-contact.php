<?php
declare(strict_types=1);

/**
 * Enrollment wizard step 2 — Contact & Login. This is where the real
 * `partners` row (plus its 1:1 `partner_business_profiles` row, using
 * step 1's session data) actually gets created — everything before
 * this point was session-only. Auto-logs in immediately after, same
 * as the original single-step register.php always did, and kicks off
 * email verification (client spec §3: "Do not activate the partner
 * account until verification is completed" — enforced by
 * admin/pages/partners.php refusing to Approve an unverified partner,
 * not by blocking the rest of this wizard).
 */

if (is_partner_logged_in()) {
    $partner = current_partner();
    redirect(partner_enrollment_next_route($partner, current_partner_business_profile()));
}

$step1 = $_SESSION['partner_enrollment']['step1'] ?? null;
if ($step1 === null) {
    redirect('/partner/register/');
}

$old = ['contact_name' => '', 'designation' => '', 'email' => '', 'mobile' => '', 'whatsapp_number' => '', 'alternate_mobile' => ''];
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('partner-register:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 3600)) {
        $errors[] = 'Too many attempts. Please try again later.';
    }

    $old['contact_name'] = trim((string) ($_POST['contact_name'] ?? ''));
    $old['designation'] = trim((string) ($_POST['designation'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $old['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $old['whatsapp_number'] = trim((string) ($_POST['whatsapp_number'] ?? ''));
    $old['alternate_mobile'] = trim((string) ($_POST['alternate_mobile'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if ($old['contact_name'] === '') {
        $errors[] = 'Enter a contact person\'s name.';
    }
    if (!is_valid_email($old['email'])) {
        $errors[] = 'Enter a valid email address.';
    }
    if ($old['mobile'] === '') {
        $errors[] = 'Enter a mobile number.';
    }
    if (mb_strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    }
    if ($password !== $confirmPassword) {
        $errors[] = 'Passwords do not match.';
    }

    if (!$errors) {
        $duplicate = find_partner_duplicate(email: $old['email'], mobile: $old['mobile']);
        if ($duplicate !== null) {
            $errors[] = $duplicate;
        }
    }

    if (!$errors) {
        $pdo = db();
        $reference = generate_reference_number('PTR', 'partners', 'partner_reference_no');

        $insert = $pdo->prepare(
            'INSERT INTO partners (partner_reference_no, company_name, contact_name, designation, email, mobile, whatsapp_number, alternate_mobile, password_hash, status)
             VALUES (:reference, :company_name, :contact_name, :designation, :email, :mobile, :whatsapp, :alt_mobile, :hash, "pending")'
        );
        $insert->execute([
            'reference' => $reference,
            'company_name' => $step1['company_name'],
            'contact_name' => $old['contact_name'],
            'designation' => $old['designation'] !== '' ? $old['designation'] : null,
            'email' => $old['email'],
            'mobile' => $old['mobile'],
            'whatsapp' => $old['whatsapp_number'] !== '' ? $old['whatsapp_number'] : null,
            'alt_mobile' => $old['alternate_mobile'] !== '' ? $old['alternate_mobile'] : null,
            'hash' => hash_password($password),
        ]);
        $partnerId = (int) $pdo->lastInsertId();

        $profileInsert = $pdo->prepare(
            'INSERT INTO partner_business_profiles
                (partner_id, business_type, year_established, website, gstin, pan, iata_registered, iata_number, tafi_number, other_association, registered_address, city, state, country, pincode)
             VALUES
                (:partner_id, :business_type, :year, :website, :gstin, :pan, :iata_registered, :iata_number, :tafi, :other_association, :address, :city, :state, :country, :pincode)'
        );
        $profileInsert->execute([
            'partner_id' => $partnerId,
            'business_type' => $step1['business_type'],
            'year' => $step1['year_established'] !== '' ? (int) $step1['year_established'] : null,
            'website' => $step1['website'] !== '' ? $step1['website'] : null,
            'gstin' => $step1['gstin'] !== '' ? $step1['gstin'] : null,
            'pan' => $step1['pan'] !== '' ? $step1['pan'] : null,
            'iata_registered' => $step1['iata_registered'] === '1' ? 1 : 0,
            'iata_number' => $step1['iata_number'] !== '' ? $step1['iata_number'] : null,
            'tafi' => $step1['tafi_number'] !== '' ? $step1['tafi_number'] : null,
            'other_association' => $step1['other_association'] !== '' ? $step1['other_association'] : null,
            'address' => $step1['registered_address'] !== '' ? $step1['registered_address'] : null,
            'city' => $step1['city'] !== '' ? $step1['city'] : null,
            'state' => $step1['state'] !== '' ? $step1['state'] : null,
            'country' => $step1['country'] !== '' ? $step1['country'] : null,
            'pincode' => $step1['pincode'] !== '' ? $step1['pincode'] : null,
        ]);

        unset($_SESSION['partner_enrollment']);
        log_in_partner($partnerId);

        $verifyToken = create_partner_email_verification_token($partnerId);
        $verifyLink = APP_URL . '/partner/verify-email/?token=' . $verifyToken;
        $sent = send_mail(
            $old['email'],
            'Verify your email — Visagiri B2B Partner Program',
            '<p>Hi ' . e($old['contact_name']) . ',</p>'
            . '<p>Please confirm your email address to continue your Visagiri B2B partner application:</p>'
            . '<p><a href="' . e($verifyLink) . '">' . e($verifyLink) . '</a></p>'
            . '<p>This link expires in 1 hour. If you did not request this, you can ignore this email.</p>',
            $old['contact_name']
        );
        if (!$sent && APP_DEBUG) {
            flash_set('partner_dev_verify_link', $verifyLink);
        }
        flash_set('notice', $sent ? 'Check your email to verify your address, then continue below.' : 'Account created — continue below.');

        redirect('/partner/register-profile/');
    }
}

$pageTitle = 'Become a B2B Partner - Step 2 - Visagiri';
$canonicalUrl = APP_URL . '/partner/register-contact/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:480px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php render_partner_enrollment_steps(2); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register-contact/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Primary Contact Details</h2>
            <div class="form-group">
                <label class="form-label" for="contact_name">Contact Person Name</label>
                <input class="form-input" type="text" id="contact_name" name="contact_name" value="<?= e($old['contact_name']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="designation">Designation</label>
                <input class="form-input" type="text" id="designation" name="designation" value="<?= e($old['designation']) ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Official Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
                <span class="form-hint">This is also your login — a verification link will be sent here.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="mobile">Mobile Number</label>
                <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($old['mobile']) ?>" required>
            </div>
            <div class="form-group" style="display:flex;gap:var(--space-4)">
                <div style="flex:1">
                    <label class="form-label" for="whatsapp_number">WhatsApp Number</label>
                    <input class="form-input" type="tel" id="whatsapp_number" name="whatsapp_number" value="<?= e($old['whatsapp_number']) ?>">
                </div>
                <div style="flex:1">
                    <label class="form-label" for="alternate_mobile">Alternate Mobile</label>
                    <input class="form-input" type="tel" id="alternate_mobile" name="alternate_mobile" value="<?= e($old['alternate_mobile']) ?>">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required autocomplete="new-password">
                <span class="form-hint">At least 8 characters.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="confirm_password">Confirm Password</label>
                <input class="form-input" type="password" id="confirm_password" name="confirm_password" required autocomplete="new-password">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Continue &rarr;</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already a partner? <a href="/partner/login/">Sign in</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
