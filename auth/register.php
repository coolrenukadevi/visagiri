<?php
declare(strict_types=1);

/**
 * Customer registration — reuses the existing `customers` CRM table
 * rather than creating a parallel identity store. Two real paths:
 *
 *  1. No customer row exists for this email/mobile yet -> a brand new
 *     row is created (customer_source = 'Website Registration'),
 *     exactly like an enquiry would, just with a password set too.
 *  2. A customer row already exists (created earlier via an enquiry
 *     or an application a consultant entered) but has no password yet
 *     -> registering CLAIMS that existing record by setting its
 *     password, rather than inserting a duplicate. This is the same
 *     duplicate-prevention discipline as the admin CMS edit-form fix
 *     earlier in this project (AUDIT.md) — a customer's existing
 *     enquiry/application history should be visible the moment they
 *     register, not orphaned under a second, empty record.
 */

if (is_customer_logged_in()) {
    redirect('/dashboard/');
}

$errors = [];
$old = ['first_name' => '', 'last_name' => '', 'email' => '', 'mobile' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('register:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 3600)) {
        $errors[] = 'Too many attempts. Please try again later.';
    }

    $old['first_name'] = trim((string) ($_POST['first_name'] ?? ''));
    $old['last_name'] = trim((string) ($_POST['last_name'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $old['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if ($old['first_name'] === '' || mb_strlen($old['first_name']) > 100) {
        $errors[] = 'Enter your first name.';
    }
    if (!is_valid_email($old['email'])) {
        $errors[] = 'Enter a valid email address.';
    }
    if (!is_valid_mobile($old['mobile'])) {
        $errors[] = 'Enter a valid mobile number.';
    }
    if (mb_strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    }
    if ($password !== $confirmPassword) {
        $errors[] = 'Passwords do not match.';
    }

    if (!$errors) {
        $pdo = db();
        $existingStmt = $pdo->prepare(
            "SELECT id, password_hash FROM customers WHERE email = :email AND deleted_at IS NULL"
        );
        $existingStmt->execute(['email' => $old['email']]);
        $existing = $existingStmt->fetch();

        if ($existing && $existing['password_hash'] !== null) {
            $errors[] = 'An account with this email already exists. Please log in instead.';
        } elseif ($existing) {
            // Claim the existing CRM record rather than duplicating it.
            $update = $pdo->prepare(
                'UPDATE customers SET password_hash = :hash, mobile = COALESCE(NULLIF(mobile, ""), :mobile) WHERE id = :id'
            );
            $update->execute([
                'hash' => hash_password($password),
                'mobile' => $old['mobile'],
                'id' => $existing['id'],
            ]);
            log_in_customer((int) $existing['id']);
            flash_set('notice', 'Welcome back! Your existing enquiries are now linked to your new account.');
            redirect('/dashboard/');
        } else {
            // A referral link (/register/?ref=VG-PTR-2026-000001) attributes the
            // new customer to that partner — only if the partner is real and
            // active, so a pending/suspended partner's link can't backdate
            // attribution once approved, and a typo'd ref never silently
            // attaches to the wrong partner.
            $referredByPartnerId = null;
            $ref = trim((string) ($_GET['ref'] ?? $_POST['ref'] ?? ''));
            if ($ref !== '') {
                $partnerStmt = $pdo->prepare("SELECT id FROM partners WHERE partner_reference_no = :ref AND status = 'active' AND deleted_at IS NULL");
                $partnerStmt->execute(['ref' => $ref]);
                $referredByPartnerId = $partnerStmt->fetchColumn() ?: null;
            }

            $reference = generate_reference_number('CUST', 'customers', 'customer_reference_no');
            $insert = $pdo->prepare(
                'INSERT INTO customers (customer_reference_no, first_name, last_name, email, mobile, password_hash, customer_source, referred_by_partner_id, status)
                 VALUES (:reference, :first_name, :last_name, :email, :mobile, :hash, "Website Registration", :referred_by, "active")'
            );
            $insert->execute([
                'reference' => $reference,
                'first_name' => $old['first_name'],
                'last_name' => $old['last_name'] !== '' ? $old['last_name'] : null,
                'email' => $old['email'],
                'mobile' => $old['mobile'],
                'hash' => hash_password($password),
                'referred_by' => $referredByPartnerId,
            ]);
            log_in_customer((int) $pdo->lastInsertId());
            flash_set('notice', 'Welcome to Visagiri! Your account has been created.');
            redirect('/dashboard/');
        }
    }
}

$pageTitle = 'Create Your Account - Visagiri';
$pageDescription = 'Register for a Visagiri account to track your visa applications, manage documents, and message your consultant.';
$canonicalUrl = APP_URL . '/register/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:480px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">My Account</span>
            <h1>Create Your Account</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/register/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <?php if (isset($_GET['ref'])): ?><input type="hidden" name="ref" value="<?= e($_GET['ref']) ?>"><?php endif; ?>
            <div class="form-group">
                <label class="form-label" for="first_name">First Name</label>
                <input class="form-input" type="text" id="first_name" name="first_name" value="<?= e($old['first_name']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="last_name">Last Name</label>
                <input class="form-input" type="text" id="last_name" name="last_name" value="<?= e($old['last_name']) ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="mobile">Mobile Number</label>
                <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($old['mobile']) ?>" placeholder="e.g. +91 98765 43210" required>
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
            <button type="submit" class="btn btn-primary" style="width:100%">Create Account</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Already have an account? <a href="/login/">Sign in</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
