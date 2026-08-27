<?php
declare(strict_types=1);

if (is_partner_logged_in()) {
    redirect('/partner/dashboard/');
}

$errors = [];
$old = ['company_name' => '', 'contact_name' => '', 'email' => '', 'mobile' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('partner-register:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 3600)) {
        $errors[] = 'Too many attempts. Please try again later.';
    }

    $old['company_name'] = trim((string) ($_POST['company_name'] ?? ''));
    $old['contact_name'] = trim((string) ($_POST['contact_name'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $old['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if ($old['company_name'] === '') {
        $errors[] = 'Enter your company or business name.';
    }
    if ($old['contact_name'] === '') {
        $errors[] = 'Enter a contact person\'s name.';
    }
    if (!is_valid_email($old['email'])) {
        $errors[] = 'Enter a valid email address.';
    }
    if (mb_strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    }
    if ($password !== $confirmPassword) {
        $errors[] = 'Passwords do not match.';
    }

    if (!$errors) {
        $existingStmt = db()->prepare('SELECT id FROM partners WHERE email = :email AND deleted_at IS NULL');
        $existingStmt->execute(['email' => $old['email']]);
        if ($existingStmt->fetch()) {
            $errors[] = 'An account with this email already exists. Please log in instead.';
        } else {
            $reference = generate_reference_number('PTR', 'partners', 'partner_reference_no');
            $insert = db()->prepare(
                'INSERT INTO partners (partner_reference_no, company_name, contact_name, email, mobile, password_hash, status)
                 VALUES (:reference, :company_name, :contact_name, :email, :mobile, :hash, "pending")'
            );
            $insert->execute([
                'reference' => $reference,
                'company_name' => $old['company_name'],
                'contact_name' => $old['contact_name'],
                'email' => $old['email'],
                'mobile' => $old['mobile'] !== '' ? $old['mobile'] : null,
                'hash' => hash_password($password),
            ]);
            log_in_partner((int) db()->lastInsertId());
            flash_set('notice', 'Thanks for registering! Your account is pending review — our team will approve it shortly.');
            redirect('/partner/dashboard/');
        }
    }
}

$pageTitle = 'Become a Partner - Visagiri';
$pageDescription = 'Register as a Visagiri referral partner and track your referred customers and commission.';
$canonicalUrl = APP_URL . '/partner/register/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:480px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="company_name">Company / Business Name</label>
                <input class="form-input" type="text" id="company_name" name="company_name" value="<?= e($old['company_name']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="contact_name">Contact Person</label>
                <input class="form-input" type="text" id="contact_name" name="contact_name" value="<?= e($old['contact_name']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="mobile">Mobile Number</label>
                <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($old['mobile']) ?>">
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
            <button type="submit" class="btn btn-primary" style="width:100%">Register</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already a partner? <a href="/partner/login/">Sign in</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
