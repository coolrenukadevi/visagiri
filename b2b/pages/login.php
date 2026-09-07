<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal login. Timing-safe against a
 * non-existent email using the same DUMMY_PASSWORD_HASH constant the
 * admin/customer/partner logins already use, so "no such account"
 * and "wrong password" can't be told apart by response time.
 */

if (is_b2b_partner_logged_in()) {
    redirect('/b2b/dashboard/');
}

$errors = [];
$email = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $email = trim((string) ($_POST['email'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');

    if (!rate_limit_check('b2b-login:' . $email . ':' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many login attempts. Please wait a few minutes and try again.';
    } elseif ($email === '' || $password === '') {
        $errors[] = 'Enter your email and password.';
    } else {
        $stmt = db()->prepare('SELECT * FROM b2b_partner_users WHERE email = :email AND deleted_at IS NULL AND status = "active"');
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch();

        $hashToCheck = $user['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $passwordOk = verify_password($password, $hashToCheck);

        if ($user && $passwordOk) {
            log_in_b2b_partner_user((int) $user['id']);
            $redirectTo = $_SESSION['b2b_redirect_after_login'] ?? '/b2b/dashboard/';
            unset($_SESSION['b2b_redirect_after_login']);
            redirect($redirectTo);
        }

        $errors[] = 'Incorrect email or password.';
    }
}

$pageTitle = 'B2B Partner Login - Visagiri';
$canonicalUrl = APP_URL . '/b2b/login/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:440px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Partner Login</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/b2b/login/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($email) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Sign In</button>
        </form>
        <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">Not a partner yet? <a href="/b2b-partner/">Become a Travel Partner</a></p>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
