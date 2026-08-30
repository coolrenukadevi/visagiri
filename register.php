<?php
/**
 * /register — new customer registration: a 3-step wizard (personal, passport,
 * account+consent) followed by OTP verification.
 *
 * This is a SEPARATE identity system from the existing Google/Facebook/X
 * sign-in at /login — see lib-php/customer_auth.php for why. All server-side
 * validation happens here regardless of what the client-side stepper shows;
 * the wizard is a UX convenience, not the security boundary.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';

header('Cache-Control: no-store, private');
auth_session_start();

if (customer_current()) {
    header('Location: ' . url('/account'), true, 302);
    exit;
}

$countries = json_decode((string) file_get_contents(ROOT_PATH . '/data/all-countries.json'), true) ?: [];
$genders   = ['Female', 'Male', 'Other', 'Prefer not to say'];

/** Which wizard step each field belongs to, so a server-side error can jump
 *  straight to the right step instead of always landing on step 1. */
const REGISTER_FIELD_STEP = [
    'full_name' => 1, 'dob' => 1, 'gender' => 1, 'nationality' => 1, 'mobile' => 1,
    'whatsapp' => 1, 'email' => 1, 'address_line' => 1, 'city' => 1, 'state' => 1,
    'country' => 1, 'pin_code' => 1,
    'passport_number' => 2, 'passport_issue_date' => 2, 'passport_expiry_date' => 2,
    'passport_issuing_country' => 2, 'passport_place_of_issue' => 2,
    'password' => 3, 'password_confirm' => 3,
    'consent_privacy' => 3, 'consent_terms' => 3, 'consent_docs' => 3,
];

function register_validate(array $post, array $countries): array
{
    $errors = [];
    $clean = [];
    $str = static fn($k) => trim((string) ($post[$k] ?? ''));

    foreach (['full_name' => 'Full name', 'nationality' => 'Nationality', 'mobile' => 'Mobile number',
              'whatsapp' => 'WhatsApp number', 'email' => 'Email address', 'address_line' => 'Address',
              'city' => 'City', 'state' => 'State', 'country' => 'Country', 'pin_code' => 'PIN code',
              'passport_number' => 'Passport number', 'passport_issuing_country' => 'Passport issuing country',
              'passport_place_of_issue' => 'Place of issue'] as $k => $label) {
        $v = $str($k);
        if ($v === '') $errors[$k] = "$label is required.";
        $clean[$k] = $v;
    }

    $gender = $str('gender');
    if ($gender === '') $errors['gender'] = 'Gender is required.';
    $clean['gender'] = $gender;

    if (!in_array($clean['country'] ?? '', $countries, true)) $errors['country'] = 'Choose a country from the list.';
    if (!in_array($clean['passport_issuing_country'] ?? '', $countries, true)) $errors['passport_issuing_country'] = 'Choose a country from the list.';

    $dob = $str('dob');
    $clean['dob'] = $dob;
    $dobDate = DateTime::createFromFormat('Y-m-d', $dob);
    if (!$dobDate || $dobDate->format('Y-m-d') !== $dob) $errors['dob'] = 'Enter a valid date.';
    elseif ($dobDate > new DateTime()) $errors['dob'] = 'Date of birth cannot be in the future.';

    foreach (['mobile', 'whatsapp'] as $k) {
        if ($clean[$k] !== '' && !preg_match('/^\+?[0-9 ]{7,15}$/', $clean[$k])) {
            $errors[$k] = 'Enter a valid phone number.';
        }
    }

    if ($clean['email'] !== '' && !filter_var($clean['email'], FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Enter a valid email address.';
    }

    $issue = $str('passport_issue_date');
    $expiry = $str('passport_expiry_date');
    $clean['passport_issue_date'] = $issue;
    $clean['passport_expiry_date'] = $expiry;
    $issueDate = DateTime::createFromFormat('Y-m-d', $issue);
    $expiryDate = DateTime::createFromFormat('Y-m-d', $expiry);
    if (!$issueDate || $issueDate->format('Y-m-d') !== $issue) $errors['passport_issue_date'] = 'Enter a valid date.';
    if (!$expiryDate || $expiryDate->format('Y-m-d') !== $expiry) $errors['passport_expiry_date'] = 'Enter a valid date.';
    if ($issueDate && $expiryDate && $issueDate->format('Y-m-d') === $issue && $expiryDate->format('Y-m-d') === $expiry && $expiryDate <= $issueDate) {
        $errors['passport_expiry_date'] = 'Expiry date must be after the issue date.';
    }

    $password = (string) ($post['password'] ?? '');
    $confirm = (string) ($post['password_confirm'] ?? '');
    if (strlen($password) < 8) $errors['password'] = 'Password must be at least 8 characters.';
    if ($password !== '' && $password !== $confirm) $errors['password_confirm'] = 'Passwords do not match.';
    $clean['password'] = $password;

    foreach (['consent_privacy', 'consent_terms', 'consent_docs'] as $k) {
        if (empty($post[$k])) $errors[$k] = 'Required to continue.';
    }
    $clean['comms_consent'] = !empty($post['consent_comms']);

    return [$clean, $errors];
}

$errors = [];
$old = [];
$formCsrf = auth_csrf_token();

// ---- Resend code ----
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'resend') {
    $pendingId = $_SESSION['pending_registration_customer_id'] ?? null;
    if ($pendingId && auth_csrf_valid($_POST['csrf'] ?? null) && customer_otp_resend_wait((int) $pendingId) <= 0) {
        $_SESSION['dev_otp_code'] = customer_otp_issue((int) $pendingId);
    }
    header('Location: ' . url('/register'), true, 302);
    exit;
}

// ---- Verify code ----
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'verify') {
    $pendingId = $_SESSION['pending_registration_customer_id'] ?? null;
    if (!$pendingId) {
        header('Location: ' . url('/register'), true, 302);
        exit;
    }
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $errors['otp'] = 'Your session expired — please try again.';
    } else {
        $result = customer_otp_verify((int) $pendingId, trim((string) ($_POST['otp'] ?? '')));
        if ($result === '') {
            customer_activate((int) $pendingId);
            customer_login((int) $pendingId);
            unset($_SESSION['pending_registration_customer_id'], $_SESSION['dev_otp_code']);
            header('Location: ' . url('/account') . '?welcome=1', true, 302);
            exit;
        }
        $errors['otp'] = $result;
    }
}

// ---- Submit registration ----
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? 'register') === 'register') {
    if (!empty($_POST['company_website'])) {
        header('Location: ' . url('/register'), true, 302); // honeypot tripped
        exit;
    }
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $errors['form'] = 'Your session expired — please refresh and try again.';
    } else {
        [$clean, $errors] = register_validate($_POST, $countries);
        $old = $_POST;
        if (!$errors) {
            $existing = customer_find_by_email($clean['email']);
            if ($existing && $existing['status'] === 'active') {
                $errors['email'] = 'An account already exists for that email — try signing in instead.';
            } elseif ($existing && $existing['status'] === 'pending_verification') {
                // Resume rather than block: they started before and never
                // finished the OTP step, so re-send instead of erroring.
                $_SESSION['pending_registration_customer_id'] = $existing['id'];
                $_SESSION['dev_otp_code'] = customer_otp_issue($existing['id']);
                header('Location: ' . url('/register'), true, 302);
                exit;
            } else {
                [$id, $err] = customer_register($clean);
                if ($id) {
                    $_SESSION['pending_registration_customer_id'] = $id;
                    $_SESSION['dev_otp_code'] = customer_otp_issue($id);
                    header('Location: ' . url('/register'), true, 302);
                    exit;
                }
                $errors['form'] = $err;
            }
        }
    }
}

$pendingId = $_SESSION['pending_registration_customer_id'] ?? null;
$stage = $pendingId ? 'otp' : 'form';
$devOtp = $_SESSION['dev_otp_code'] ?? null;
$pendingCustomer = $pendingId ? customer_find((int) $pendingId) : null;

$errorStep = 1;
foreach (array_keys($errors) as $f) {
    if (isset(REGISTER_FIELD_STEP[$f])) $errorStep = max($errorStep, REGISTER_FIELD_STEP[$f]);
}

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Create account']];
$page = [
    'title'       => 'Create Your Account | Convercession',
    'short_title' => 'Register',
    'description' => 'Register for a Convercession account to submit visa and forex enquiries, upload documents and track your applications.',
    'path'        => '/register',
    'noindex'     => true,
    'jsonld'      => [breadcrumb_schema($crumb)],
];

$fieldError = static function (string $key) use ($errors): string {
    return isset($errors[$key]) ? '<span class="field-error">' . e($errors[$key]) . '</span>' : '';
};
$oldVal = static function (string $key) use ($old): string {
    return e((string) ($old[$key] ?? ''));
};
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container"><?= breadcrumbs($crumb) ?></div>
    <div class="container">
      <div class="auth-card auth-card-wide">

        <?php if ($stage === 'otp'): ?>
        <div class="auth-head">
          <h1>Verify your account</h1>
          <p>We've sent a 6-digit code for <strong><?= e($pendingCustomer['email'] ?? '') ?></strong>. Enter it below to activate your account.</p>
        </div>

        <p class="notice-inline">
          <strong>Development mode.</strong> No email/SMS provider is configured yet, so codes aren't actually delivered —
          your code is shown here so you can test the flow: <strong style="font-size:1.05em; letter-spacing:0.04em"><?= e($devOtp ?? '') ?></strong>
        </p>

        <?php if (isset($errors['otp'])): ?>
        <p class="auth-error" role="alert"><?= e($errors['otp']) ?></p>
        <?php endif; ?>

        <form method="post" action="<?= url('/register') ?>">
          <input type="hidden" name="csrf" value="<?= e($formCsrf) ?>">
          <input type="hidden" name="action" value="verify">
          <div class="field">
            <label for="otp">6-digit code</label>
            <input type="text" id="otp" name="otp" class="otp-input" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" autocomplete="one-time-code" autofocus required>
          </div>
          <div class="auth-form-row" style="margin-top:16px">
            <button type="submit" class="btn btn-primary">Verify &amp; activate account</button>
          </div>
        </form>

        <?php $wait = customer_otp_resend_wait((int) $pendingId); ?>
        <form method="post" action="<?= url('/register') ?>" style="margin-top:14px">
          <input type="hidden" name="csrf" value="<?= e($formCsrf) ?>">
          <input type="hidden" name="action" value="resend">
          <?php if ($wait > 0): ?>
          <p class="auth-note">You can request a new code in <?= (int) $wait ?>s.</p>
          <?php else: ?>
          <button type="submit" class="btn btn-ghost btn-sm">Resend code</button>
          <?php endif; ?>
        </form>

        <?php else: ?>
        <div class="auth-head">
          <h1>Create your Convercession account</h1>
          <p>Track visa and forex enquiries, upload documents once and reuse them, and pick up where you left off.</p>
        </div>

        <?php if (isset($errors['form'])): ?>
        <p class="auth-error" role="alert"><?= e($errors['form']) ?></p>
        <?php endif; ?>

        <div class="wizard-steps" data-current="<?= $errorStep ?>">
          <div class="wizard-step-dot" data-dot="1"><span class="dot-num">1</span><span class="dot-label">Personal</span></div>
          <div class="wizard-step-line"></div>
          <div class="wizard-step-dot" data-dot="2"><span class="dot-num">2</span><span class="dot-label">Passport</span></div>
          <div class="wizard-step-line"></div>
          <div class="wizard-step-dot" data-dot="3"><span class="dot-num">3</span><span class="dot-label">Account</span></div>
        </div>

        <form method="post" action="<?= url('/register') ?>" id="registerForm" novalidate>
          <input type="hidden" name="csrf" value="<?= e($formCsrf) ?>">
          <input type="hidden" name="action" value="register">
          <div class="honeypot-field" aria-hidden="true"><label>Company website<input type="text" name="company_website" tabindex="-1" autocomplete="off"></label></div>

          <fieldset class="enquiry-fieldset wizard-step" data-step="1">
            <legend>Personal information</legend>
            <div class="enquiry-grid">
              <div class="enquiry-field full"><label for="full_name">Full Name *</label><input type="text" id="full_name" name="full_name" value="<?= $oldVal('full_name') ?>" required><?= $fieldError('full_name') ?></div>
              <div class="enquiry-field"><label for="dob">Date of Birth *</label><input type="date" id="dob" name="dob" value="<?= $oldVal('dob') ?>" max="<?= date('Y-m-d') ?>" required><?= $fieldError('dob') ?></div>
              <div class="enquiry-field"><label for="gender">Gender *</label>
                <select id="gender" name="gender" required>
                  <option value="">Select&hellip;</option>
                  <?php foreach ($genders as $g): ?><option value="<?= e($g) ?>" <?= ($old['gender'] ?? '') === $g ? 'selected' : '' ?>><?= e($g) ?></option><?php endforeach; ?>
                </select><?= $fieldError('gender') ?>
              </div>
              <div class="enquiry-field"><label for="nationality">Nationality *</label>
                <select id="nationality" name="nationality" required>
                  <option value="">Select&hellip;</option>
                  <?php foreach ($countries as $c): ?><option value="<?= e($c) ?>" <?= ($old['nationality'] ?? '') === $c ? 'selected' : '' ?>><?= e($c) ?></option><?php endforeach; ?>
                </select><?= $fieldError('nationality') ?>
              </div>
              <div class="enquiry-field"><label for="mobile">Mobile Number *</label><input type="tel" id="mobile" name="mobile" value="<?= $oldVal('mobile') ?>" required><?= $fieldError('mobile') ?></div>
              <div class="enquiry-field"><label for="whatsapp">WhatsApp Number *</label><input type="tel" id="whatsapp" name="whatsapp" value="<?= $oldVal('whatsapp') ?>" required><?= $fieldError('whatsapp') ?></div>
              <div class="enquiry-field full"><label for="email">Email Address *</label><input type="email" id="email" name="email" value="<?= $oldVal('email') ?>" required><?= $fieldError('email') ?></div>
              <div class="enquiry-field full"><label for="address_line">Address *</label><input type="text" id="address_line" name="address_line" value="<?= $oldVal('address_line') ?>" required><?= $fieldError('address_line') ?></div>
              <div class="enquiry-field"><label for="city">City *</label><input type="text" id="city" name="city" value="<?= $oldVal('city') ?>" required><?= $fieldError('city') ?></div>
              <div class="enquiry-field"><label for="state">State *</label><input type="text" id="state" name="state" value="<?= $oldVal('state') ?>" required><?= $fieldError('state') ?></div>
              <div class="enquiry-field"><label for="country">Country *</label>
                <select id="country" name="country" required>
                  <option value="">Select&hellip;</option>
                  <?php foreach ($countries as $c): ?><option value="<?= e($c) ?>" <?= ($old['country'] ?? '') === $c ? 'selected' : '' ?>><?= e($c) ?></option><?php endforeach; ?>
                </select><?= $fieldError('country') ?>
              </div>
              <div class="enquiry-field"><label for="pin_code">PIN Code *</label><input type="text" id="pin_code" name="pin_code" value="<?= $oldVal('pin_code') ?>" required><?= $fieldError('pin_code') ?></div>
            </div>
            <div class="wizard-actions"><span></span><button type="button" class="btn btn-primary wizard-next">Continue to Passport &rarr;</button></div>
          </fieldset>

          <fieldset class="enquiry-fieldset wizard-step" data-step="2" hidden>
            <legend>Passport information</legend>
            <div class="enquiry-grid">
              <div class="enquiry-field full"><label for="passport_number">Passport Number *</label><input type="text" id="passport_number" name="passport_number" value="<?= $oldVal('passport_number') ?>" required><?= $fieldError('passport_number') ?></div>
              <div class="enquiry-field"><label for="passport_issue_date">Passport Issue Date *</label><input type="date" id="passport_issue_date" name="passport_issue_date" value="<?= $oldVal('passport_issue_date') ?>" max="<?= date('Y-m-d') ?>" required><?= $fieldError('passport_issue_date') ?></div>
              <div class="enquiry-field"><label for="passport_expiry_date">Passport Expiry Date *</label><input type="date" id="passport_expiry_date" name="passport_expiry_date" value="<?= $oldVal('passport_expiry_date') ?>" required><?= $fieldError('passport_expiry_date') ?></div>
              <div class="enquiry-field"><label for="passport_issuing_country">Passport Issuing Country *</label>
                <select id="passport_issuing_country" name="passport_issuing_country" required>
                  <option value="">Select&hellip;</option>
                  <?php foreach ($countries as $c): ?><option value="<?= e($c) ?>" <?= ($old['passport_issuing_country'] ?? '') === $c ? 'selected' : '' ?>><?= e($c) ?></option><?php endforeach; ?>
                </select><?= $fieldError('passport_issuing_country') ?>
              </div>
              <div class="enquiry-field"><label for="passport_place_of_issue">Place of Issue *</label><input type="text" id="passport_place_of_issue" name="passport_place_of_issue" value="<?= $oldVal('passport_place_of_issue') ?>" required><?= $fieldError('passport_place_of_issue') ?></div>
            </div>
            <div class="wizard-actions"><button type="button" class="btn btn-ghost wizard-back">&larr; Back</button><button type="button" class="btn btn-primary wizard-next">Continue to Account &rarr;</button></div>
          </fieldset>

          <fieldset class="enquiry-fieldset wizard-step" data-step="3" hidden>
            <legend>Account &amp; consent</legend>
            <div class="enquiry-grid">
              <div class="enquiry-field"><label for="password">Password *</label><input type="password" id="password" name="password" minlength="8" required><?= $fieldError('password') ?></div>
              <div class="enquiry-field"><label for="password_confirm">Confirm Password *</label><input type="password" id="password_confirm" name="password_confirm" minlength="8" required><?= $fieldError('password_confirm') ?></div>
            </div>
            <p class="auth-note" style="margin-top:0">Your Customer ID will be generated automatically once you verify your email.</p>

            <div class="consent-list">
              <label class="consent-row"><input type="checkbox" name="consent_privacy" value="1" <?= !empty($old['consent_privacy']) ? 'checked' : '' ?> required> I agree to the <a href="<?= url('/privacy-policy') ?>" target="_blank">Privacy Policy</a> *<?= $fieldError('consent_privacy') ?></label>
              <label class="consent-row"><input type="checkbox" name="consent_terms" value="1" <?= !empty($old['consent_terms']) ? 'checked' : '' ?> required> I agree to the <a href="<?= url('/terms') ?>" target="_blank">Terms &amp; Conditions</a> *<?= $fieldError('consent_terms') ?></label>
              <label class="consent-row"><input type="checkbox" name="consent_docs" value="1" <?= !empty($old['consent_docs']) ? 'checked' : '' ?> required> I consent to Convercession processing documents I submit, for the purpose of my enquiries *<?= $fieldError('consent_docs') ?></label>
              <label class="consent-row"><input type="checkbox" name="consent_comms" value="1" <?= !empty($old['consent_comms']) ? 'checked' : '' ?>> I'd like to receive updates about my enquiries and relevant offers (optional)</label>
            </div>

            <div class="wizard-actions"><button type="button" class="btn btn-ghost wizard-back">&larr; Back</button><button type="submit" class="btn btn-primary">Create account</button></div>
          </fieldset>
        </form>

        <p class="auth-note">Already have an account? <a href="<?= url('/customer-login') ?>">Sign in</a>.</p>
        <?php endif; ?>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
<script>
(() => {
  const form = document.getElementById("registerForm");
  if (!form) return;
  const steps = [...form.querySelectorAll(".wizard-step")];
  const dots = [...document.querySelectorAll(".wizard-step-dot")];
  let current = parseInt(document.querySelector(".wizard-steps")?.dataset.current || "1", 10);

  function show(n) {
    current = n;
    steps.forEach((s) => { s.hidden = parseInt(s.dataset.step, 10) !== n; });
    dots.forEach((d) => {
      const dn = parseInt(d.dataset.dot, 10);
      d.classList.toggle("is-done", dn < n);
      d.classList.toggle("is-current", dn === n);
    });
    form.querySelector(`.wizard-step[data-step="${n}"]`)?.scrollIntoView({ block: "nearest" });
  }
  function stepValid(n) {
    const fs = form.querySelector(`.wizard-step[data-step="${n}"]`);
    for (const f of fs.querySelectorAll("input, select, textarea")) {
      if (!f.reportValidity()) return false;
    }
    return true;
  }
  form.querySelectorAll(".wizard-next").forEach((btn) => {
    btn.addEventListener("click", () => { if (stepValid(current)) show(current + 1); });
  });
  form.querySelectorAll(".wizard-back").forEach((btn) => {
    btn.addEventListener("click", () => show(current - 1));
  });
  show(current);
})();
</script>
</body>
</html>
