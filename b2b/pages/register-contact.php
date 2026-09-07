<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 2: Authorized Contact + Email/
 * Mobile OTP verification. This is where the real b2b_partners and
 * b2b_partner_users rows get created (combining this step's form
 * with Step 1's session data), same "step 2 creates the account"
 * shape as partner/pages/register-contact.php — but this step also
 * gates on OTP verification of both channels before it will proceed,
 * per explicit requirement that submission cannot happen without it.
 */

if (is_b2b_partner_logged_in()) {
    redirect('/b2b/dashboard/');
}

$step1 = $_SESSION['b2b_enrollment']['step1'] ?? null;
if ($step1 === null) {
    redirect('/b2b/register/');
}

$old = $_SESSION['b2b_enrollment']['step2'] ?? [
    'full_name' => '', 'designation' => '', 'mobile_country_code' => '+91', 'mobile_number' => '',
    'whatsapp_number' => '', 'email' => '', 'alternate_email' => '', 'alternate_contact' => '',
    'preferred_communication' => 'email',
];
$errors = [];
$otpStage = isset($_SESSION['b2b_enrollment']['step2_otp_sent']) && $_SESSION['b2b_enrollment']['step2_otp_sent'] === true;
$mobileCodeForDisplay = $_SESSION['b2b_enrollment']['step2_mobile_code_display'] ?? null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $action = $_POST['action'] ?? 'send_otp';

    if ($action === 'send_otp') {
        foreach (array_keys($old) as $key) {
            $old[$key] = trim((string) ($_POST[$key] ?? $old[$key]));
        }
        $password = (string) ($_POST['password'] ?? '');
        $passwordConfirm = (string) ($_POST['password_confirm'] ?? '');
        $mobileFull = $old['mobile_country_code'] . $old['mobile_number'];

        if ($old['full_name'] === '') {
            $errors[] = 'Enter the authorized contact person\'s name.';
        }
        if (!array_key_exists($old['designation'], B2B_DESIGNATIONS)) {
            $errors[] = 'Select a designation.';
        }
        if (!is_valid_email($old['email'])) {
            $errors[] = 'Enter a valid email address.';
        }
        if (!is_valid_mobile($mobileFull)) {
            $errors[] = 'Enter a valid mobile number.';
        }
        if (strlen($password) < 8) {
            $errors[] = 'Password must be at least 8 characters.';
        }
        if ($password !== $passwordConfirm) {
            $errors[] = 'Passwords do not match.';
        }

        if (!$errors) {
            $existsStmt = db()->prepare('SELECT id FROM b2b_partner_users WHERE email = :email AND deleted_at IS NULL');
            $existsStmt->execute(['email' => $old['email']]);
            if ($existsStmt->fetch()) {
                $errors[] = 'An account already exists with this email. Please sign in instead.';
            }
        }

        if (!$errors) {
            $_SESSION['b2b_enrollment']['step2'] = $old;
            $_SESSION['b2b_enrollment']['step2_password_hash'] = hash_password($password);

            $emailCode = b2b_issue_otp('email', $old['email']);
            b2b_deliver_email_otp($old['email'], $emailCode);

            $mobileCode = b2b_issue_otp('mobile', $mobileFull);
            // No SMS/WhatsApp gateway is configured in this project yet
            // (the spec itself calls this "integration-ready", not a
            // hard requirement) — shown on screen rather than claiming
            // a text was sent that never arrives. Also logged so support
            // staff can find it if asked.
            mail_log('[B2B OTP] mobile ' . $mobileFull . ' verification code (no SMS gateway configured): ' . $mobileCode);
            $_SESSION['b2b_enrollment']['step2_mobile_code_display'] = $mobileCode;
            $_SESSION['b2b_enrollment']['step2_otp_sent'] = true;

            redirect('/b2b/register-contact/');
        }
    } elseif ($action === 'verify_otp') {
        $emailCode = trim((string) ($_POST['email_otp'] ?? ''));
        $mobileCode = trim((string) ($_POST['mobile_otp'] ?? ''));
        $mobileFull = $old['mobile_country_code'] . $old['mobile_number'];

        $emailOk = b2b_verify_otp('email', $old['email'], $emailCode);
        $mobileOk = b2b_verify_otp('mobile', $mobileFull, $mobileCode);

        if (!$emailOk) {
            $errors[] = 'The email verification code is incorrect or expired.';
        }
        if (!$mobileOk) {
            $errors[] = 'The mobile verification code is incorrect or expired.';
        }

        if (!$errors) {
            $pdo = db();
            $pdo->beginTransaction();
            try {
                $partnerRef = b2b_generate_partner_reference();
                $pdo->prepare(
                    'INSERT INTO b2b_partners (partner_reference_no, legal_business_name, trade_name, business_type, registration_type,
                        company_registration_number, gstin, pan, iata_number, tids_number, udyam_number, other_membership,
                        year_established, website, business_email, business_phone, whatsapp_number,
                        office_address, city, state, country, pincode, employee_count, primary_business_activity, status, ip_address)
                     VALUES (:ref, :legal_name, :trade_name, :business_type, :registration_type,
                        :company_reg, :gstin, :pan, :iata, :tids, :udyam, :other_membership,
                        :year, :website, :email, :phone, :whatsapp,
                        :address, :city, :state, :country, :pincode, :employees, :activity, "draft", :ip)'
                )->execute([
                    'ref' => $partnerRef,
                    'legal_name' => $step1['legal_business_name'],
                    'trade_name' => $step1['trade_name'] !== '' ? $step1['trade_name'] : null,
                    'business_type' => $step1['business_type'],
                    'registration_type' => $step1['registration_type'] !== '' ? $step1['registration_type'] : null,
                    'company_reg' => $step1['company_registration_number'] !== '' ? $step1['company_registration_number'] : null,
                    'gstin' => $step1['gstin'] !== '' ? $step1['gstin'] : null,
                    'pan' => $step1['pan'] !== '' ? $step1['pan'] : null,
                    'iata' => $step1['iata_number'] !== '' ? $step1['iata_number'] : null,
                    'tids' => $step1['tids_number'] !== '' ? $step1['tids_number'] : null,
                    'udyam' => $step1['udyam_number'] !== '' ? $step1['udyam_number'] : null,
                    'other_membership' => $step1['other_membership'] !== '' ? $step1['other_membership'] : null,
                    'year' => $step1['year_established'] !== '' ? (int) $step1['year_established'] : null,
                    'website' => $step1['website'] !== '' ? $step1['website'] : null,
                    'email' => $step1['business_email'],
                    'phone' => $step1['business_phone'],
                    'whatsapp' => $step1['whatsapp_number'] !== '' ? $step1['whatsapp_number'] : null,
                    'address' => $step1['office_address'],
                    'city' => $step1['city'],
                    'state' => $step1['state'],
                    'country' => $step1['country'],
                    'pincode' => $step1['pincode'],
                    'employees' => $step1['employee_count'] !== '' ? $step1['employee_count'] : null,
                    'activity' => $step1['primary_business_activity'] !== '' ? $step1['primary_business_activity'] : null,
                    'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                ]);
                $partnerId = (int) $pdo->lastInsertId();

                $pdo->prepare(
                    'INSERT INTO b2b_partner_users (b2b_partner_id, full_name, designation, email, password_hash, mobile_country_code, mobile_number, whatsapp_number, alternate_email, alternate_contact, preferred_communication, role, email_verified_at, mobile_verified_at)
                     VALUES (:partner_id, :name, :designation, :email, :hash, :cc, :mobile, :whatsapp, :alt_email, :alt_contact, :pref, "partner_admin", NOW(), NOW())'
                )->execute([
                    'partner_id' => $partnerId,
                    'name' => $old['full_name'],
                    'designation' => $old['designation'],
                    'email' => $old['email'],
                    'hash' => $_SESSION['b2b_enrollment']['step2_password_hash'],
                    'cc' => $old['mobile_country_code'],
                    'mobile' => $old['mobile_number'],
                    'whatsapp' => $old['whatsapp_number'] !== '' ? $old['whatsapp_number'] : null,
                    'alt_email' => $old['alternate_email'] !== '' ? $old['alternate_email'] : null,
                    'alt_contact' => $old['alternate_contact'] !== '' ? $old['alternate_contact'] : null,
                    'pref' => $old['preferred_communication'],
                ]);
                $userId = (int) $pdo->lastInsertId();

                $pdo->commit();
            } catch (Throwable $e) {
                $pdo->rollBack();
                if (APP_DEBUG) {
                    error_log('[b2b register-contact] failed: ' . $e->getMessage());
                }
                $errors[] = 'Something went wrong creating your account. Please try again.';
            }

            if (!$errors) {
                unset($_SESSION['b2b_enrollment']['step2_password_hash'], $_SESSION['b2b_enrollment']['step2_otp_sent'], $_SESSION['b2b_enrollment']['step2_mobile_code_display']);
                log_in_b2b_partner_user($userId);
                redirect('/b2b/register-documents/');
            }
        }
        $otpStage = true;
    } elseif ($action === 'edit') {
        unset($_SESSION['b2b_enrollment']['step2_otp_sent'], $_SESSION['b2b_enrollment']['step2_mobile_code_display']);
        redirect('/b2b/register-contact/');
    }
}

$pageTitle = 'Become a B2B Travel Partner - Step 2 - Visagiri';
$canonicalUrl = APP_URL . '/b2b/register-contact/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(2); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <?php if (!$otpStage): ?>
        <form method="post" action="/b2b/register-contact/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="send_otp">
            <h2 style="margin-top:0">Authorized Contact Person</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="full_name">Contact Person Name</label>
                    <input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($old['full_name']) ?>" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label" for="designation">Designation</label>
                    <select class="form-select" id="designation" name="designation" required>
                        <option value="">Select…</option>
                        <?php foreach (B2B_DESIGNATIONS as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $old['designation'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
                    <span class="form-hint">This is also your login — we'll send a verification code here.</span>
                </div>
                <div class="form-group" style="display:flex;gap:var(--space-2)">
                    <div style="width:90px">
                        <label class="form-label" for="mobile_country_code">Code</label>
                        <input class="form-input" type="text" id="mobile_country_code" name="mobile_country_code" value="<?= e($old['mobile_country_code']) ?>">
                    </div>
                    <div style="flex:1">
                        <label class="form-label" for="mobile_number">Mobile Number</label>
                        <input class="form-input" type="tel" id="mobile_number" name="mobile_number" value="<?= e($old['mobile_number']) ?>" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="whatsapp_number">WhatsApp Number</label>
                    <input class="form-input" type="tel" id="whatsapp_number" name="whatsapp_number" value="<?= e($old['whatsapp_number']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="preferred_communication">Preferred Communication Method</label>
                    <select class="form-select" id="preferred_communication" name="preferred_communication">
                        <option value="email"<?= $old['preferred_communication'] === 'email' ? ' selected' : '' ?>>Email</option>
                        <option value="mobile"<?= $old['preferred_communication'] === 'mobile' ? ' selected' : '' ?>>Mobile</option>
                        <option value="whatsapp"<?= $old['preferred_communication'] === 'whatsapp' ? ' selected' : '' ?>>WhatsApp</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="alternate_email">Alternate Email</label>
                    <input class="form-input" type="email" id="alternate_email" name="alternate_email" value="<?= e($old['alternate_email']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="alternate_contact">Alternate Contact Number</label>
                    <input class="form-input" type="tel" id="alternate_contact" name="alternate_contact" value="<?= e($old['alternate_contact']) ?>">
                </div>
            </div>

            <h2>Create Your Login</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input class="form-input" type="password" id="password" name="password" required>
                    <span class="form-hint">At least 8 characters.</span>
                </div>
                <div class="form-group">
                    <label class="form-label" for="password_confirm">Confirm Password</label>
                    <input class="form-input" type="password" id="password_confirm" name="password_confirm" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Send Verification Codes &rarr;</button>
        </form>
        <?php else: ?>
        <form method="post" action="/b2b/register-contact/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="verify_otp">
            <h2 style="margin-top:0">Verify Your Email &amp; Mobile</h2>
            <p style="color:var(--text-muted)">We sent a 6-digit code to <strong><?= e($old['email']) ?></strong>.</p>
            <div class="form-group">
                <label class="form-label" for="email_otp">Email Verification Code</label>
                <input class="form-input" type="text" id="email_otp" name="email_otp" maxlength="6" pattern="[0-9]{6}" required autofocus>
            </div>

            <?php if ($mobileCodeForDisplay !== null): ?>
            <div class="alert alert-info">SMS delivery isn't connected yet, so here's your mobile verification code directly: <strong><?= e($mobileCodeForDisplay) ?></strong></div>
            <?php endif; ?>
            <div class="form-group">
                <label class="form-label" for="mobile_otp">Mobile Verification Code</label>
                <input class="form-input" type="text" id="mobile_otp" name="mobile_otp" maxlength="6" pattern="[0-9]{6}" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Verify &amp; Create Account</button>
        </form>
        <form method="post" action="/b2b/register-contact/" style="margin-top:var(--space-3);text-align:center">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="edit">
            <button type="submit" class="btn btn-outline btn-sm">Edit Details / Resend Codes</button>
        </form>
        <?php endif; ?>

        <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already a partner? <a href="/b2b/login/">Sign in</a></p>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
