<?php
declare(strict_types=1);

/**
 * Login — Phase 9. Rate-limited per identifier+IP, CSRF-protected,
 * generic error message on failure (never reveals whether the email
 * exists), session ID regenerated on success.
 */

if (is_logged_in()) {
    redirect('/dashboard/');
}

$errors = [];
$old = ['identifier' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $old['identifier'] = trim((string) ($_POST['identifier'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $remember = !empty($_POST['remember']);

    if (login_rate_limited($old['identifier'])) {
        $errors[] = 'Too many login attempts. Please wait a few minutes and try again.';
    } elseif ($old['identifier'] === '' || $password === '') {
        $errors[] = 'Enter your email/mobile and password.';
    } else {
        $pdo = db();
        $stmt = $pdo->prepare(
            'SELECT id, password_hash, status FROM users
             WHERE (email = :identifier OR mobile = :identifier2) AND deleted_at IS NULL'
        );
        $stmt->execute(['identifier' => $old['identifier'], 'identifier2' => $old['identifier']]);
        $user = $stmt->fetch();

        if (!$user || !verify_password($password, $user['password_hash'])) {
            $errors[] = 'Invalid email/mobile or password.';
        } elseif ($user['status'] !== 'active') {
            $errors[] = 'This account is suspended. Contact support for help.';
        } else {
            log_in_user((int) $user['id'], $remember);

            $update = $pdo->prepare('UPDATE users SET last_login_at = NOW() WHERE id = :id');
            $update->execute(['id' => $user['id']]);

            $redirectTo = $_SESSION['redirect_after_login'] ?? '/dashboard/';
            unset($_SESSION['redirect_after_login']);
            redirect($redirectTo);
        }
    }
}

$pageTitle = 'Login';
$pageDescription = 'Log in to your Visagiri account to manage your visa applications.';
$canonicalUrl = APP_URL . '/login/';
require __DIR__ . '/../includes/header.php';
?>
<div class="auth-wrap">
    <div class="auth-card card">
        <h1>Login</h1>
        <p class="auth-card__subtitle">Manage your visa application online.</p>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/login/" novalidate>
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="identifier">Email or mobile number</label>
                <input class="form-input" type="text" id="identifier" name="identifier" value="<?= e($old['identifier']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required>
            </div>
            <div class="auth-card__row">
                <label class="auth-card__checkbox">
                    <input type="checkbox" name="remember" value="1"> Remember me
                </label>
                <a href="/forgot-password/">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Login</button>
        </form>

        <p class="auth-card__footer">Don't have an account? <a href="/register/">Create one</a></p>
    </div>
</div>
<?php require __DIR__ . '/../includes/footer.php'; ?>
