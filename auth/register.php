<?php
declare(strict_types=1);

/**
 * Registration — Phase 9. CSRF-protected, rate-limited, validated
 * server-side, passwords hashed with password_hash() (never stored
 * plaintext), prepared statements throughout.
 */

if (is_logged_in()) {
    redirect('/dashboard/');
}

$errors = [];
$old = ['full_name' => '', 'email' => '', 'mobile' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (!rate_limit_check('register:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 3600)) {
        $errors[] = 'Too many attempts. Please try again later.';
    }

    $old['full_name'] = trim((string) ($_POST['full_name'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $old['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if ($old['full_name'] === '' || mb_strlen($old['full_name']) > 150) {
        $errors[] = 'Enter your full name.';
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
        $stmt = $pdo->prepare('SELECT id FROM users WHERE email = :email');
        $stmt->execute(['email' => $old['email']]);
        if ($stmt->fetch()) {
            $errors[] = 'An account with this email already exists.';
        }
    }

    if (!$errors) {
        try {
            $pdo = db();
            $roleStmt = $pdo->prepare("SELECT id FROM roles WHERE name = 'customer'");
            $roleStmt->execute();
            $role = $roleStmt->fetch();

            $insert = $pdo->prepare(
                'INSERT INTO users (role_id, full_name, email, mobile, password_hash, status)
                 VALUES (:role_id, :full_name, :email, :mobile, :password_hash, "active")'
            );
            $insert->execute([
                'role_id' => $role['id'],
                'full_name' => $old['full_name'],
                'email' => $old['email'],
                'mobile' => $old['mobile'],
                'password_hash' => hash_password($password),
            ]);

            log_in_user((int) $pdo->lastInsertId());
            flash_set('notice', 'Welcome to Visagiri! Your account has been created.');
            redirect('/dashboard/');
        } catch (PDOException $e) {
            $errors[] = 'An account with this email already exists.';
        }
    }
}

$pageTitle = 'Create Account';
$pageDescription = 'Create a Visagiri account to start and manage your visa application online.';
$canonicalUrl = APP_URL . '/register/';
$noindex = true;
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card">
        <h1>Create your account</h1>
        <p class="auth-card__subtitle">Manage your visa application online.</p>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/register/" novalidate>
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="full_name">Full name</label>
                <input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($old['full_name']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="mobile">Mobile number</label>
                <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($old['mobile']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" minlength="8" required>
                <span class="form-hint">At least 8 characters.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="confirm_password">Confirm password</label>
                <input class="form-input" type="password" id="confirm_password" name="confirm_password" minlength="8" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Create Account</button>
        </form>

        <p class="auth-card__footer">Already have an account? <a href="/login/">Login</a></p>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
