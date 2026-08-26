<?php
declare(strict_types=1);

if (is_customer_logged_in()) {
    redirect('/dashboard/');
}

$errors = [];
$identifier = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $identifier = trim((string) ($_POST['identifier'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $remember = !empty($_POST['remember']);

    // Not login_rate_limited() — that helper hardcodes an 'admin-login:'
    // key prefix, which would be misleading for a customer attempt even
    // though it wouldn't actually collide with real admin rate limits.
    if (!rate_limit_check('customer-login:' . $identifier . ':' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many login attempts. Please wait a few minutes and try again.';
    } elseif ($identifier === '' || $password === '') {
        $errors[] = 'Enter your email/mobile and password.';
    } else {
        $stmt = db()->prepare(
            "SELECT * FROM customers WHERE (email = :identifier OR mobile = :identifier2) AND deleted_at IS NULL"
        );
        $stmt->execute(['identifier' => $identifier, 'identifier2' => $identifier]);
        $customer = $stmt->fetch();

        // Always run verify_password(), even with no matching row or a
        // NULL password_hash (a CRM lead who never registered), against
        // a dummy hash in that case — so "no account", "no password
        // set yet", and "wrong password" are all indistinguishable by
        // response time.
        $hashToCheck = $customer['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $passwordOk = verify_password($password, $hashToCheck);

        record_login_attempt('customer:' . $identifier, (bool) ($customer && $passwordOk));

        if ($customer && $customer['password_hash'] !== null && $passwordOk && $customer['status'] === 'active') {
            log_in_customer((int) $customer['id']);
            if ($remember) {
                remember_customer((int) $customer['id']);
            }
            $redirectTo = $_SESSION['customer_redirect_after_login'] ?? '/dashboard/';
            unset($_SESSION['customer_redirect_after_login']);
            redirect($redirectTo);
        }

        $errors[] = 'Invalid email/mobile or password.';
    }
}

$pageTitle = 'Sign In - Visagiri';
$pageDescription = 'Sign in to your Visagiri account to track your visa applications and manage your documents.';
$canonicalUrl = APP_URL . '/login/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:420px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">My Account</span>
            <h1>Sign In</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/login/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="identifier">Email or Mobile</label>
                <input class="form-input" type="text" id="identifier" name="identifier" value="<?= e($identifier) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required autocomplete="current-password">
            </div>
            <div class="form-group" style="display:flex;align-items:center;justify-content:space-between">
                <label style="display:flex;align-items:center;gap:var(--space-2);font-size:var(--font-size-sm)">
                    <input type="checkbox" name="remember" value="1"> Remember me
                </label>
                <a href="/forgot-password/" style="font-size:var(--font-size-sm)">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Sign In</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">New to Visagiri? <a href="/register/">Create an account</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
