<?php
declare(strict_types=1);

if (is_partner_logged_in()) {
    redirect('/partner/dashboard/');
}

$errors = [];
$identifier = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $identifier = trim((string) ($_POST['identifier'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $remember = !empty($_POST['remember']);

    if (!rate_limit_check('partner-login:' . $identifier . ':' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many login attempts. Please wait a few minutes and try again.';
    } elseif ($identifier === '' || $password === '') {
        $errors[] = 'Enter your email and password.';
    } else {
        $stmt = db()->prepare('SELECT * FROM partners WHERE email = :email AND deleted_at IS NULL');
        $stmt->execute(['email' => $identifier]);
        $partner = $stmt->fetch();

        $hashToCheck = $partner['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $passwordOk = verify_password($password, $hashToCheck);

        if ($partner && $passwordOk) {
            log_in_partner((int) $partner['id']);
            if ($remember) {
                remember_partner((int) $partner['id']);
            }

            // An incomplete enrollment always goes back into the
            // wizard, ignoring any stored post-login redirect — that
            // redirect was most likely set trying to reach the
            // dashboard before finishing registration.
            if ($partner['enrollment_completed_at'] === null) {
                unset($_SESSION['partner_redirect_after_login']);
                redirect(partner_enrollment_next_route($partner, current_partner_business_profile()));
            }

            $redirectTo = $_SESSION['partner_redirect_after_login'] ?? '/partner/dashboard/';
            unset($_SESSION['partner_redirect_after_login']);
            redirect($redirectTo);
        }

        // Not the primary (owner) login — try a team-member identity.
        // Only 'active' team members can sign in: 'invited' hasn't
        // accepted yet (no password set), 'suspended' is blocked.
        // Deliberately no "remember me" for team-member logins — the
        // remember-cookie mechanism only stores a partner_id, and
        // resuming it would silently log the browser back in as the
        // owner, losing the team member's own role; simplest correct
        // fix is to just not offer it here rather than build a
        // parallel remember-token system for a secondary identity.
        $teamStmt = db()->prepare("SELECT * FROM partner_team_members WHERE email = :email AND status = 'active'");
        $teamStmt->execute(['email' => $identifier]);
        $teamMember = $teamStmt->fetch();
        $teamHashToCheck = $teamMember['password_hash'] ?? DUMMY_PASSWORD_HASH;
        $teamPasswordOk = verify_password($password, $teamHashToCheck);

        if ($teamMember && $teamPasswordOk) {
            log_in_partner((int) $teamMember['partner_id'], (int) $teamMember['id']);
            $redirectTo = $_SESSION['partner_redirect_after_login'] ?? '/partner/dashboard/';
            unset($_SESSION['partner_redirect_after_login']);
            redirect($redirectTo);
        }

        $errors[] = 'Invalid email or password.';
    }
}

$pageTitle = 'Partner Login - Visagiri';
$pageDescription = 'Sign in to the Visagiri partner referral portal.';
$canonicalUrl = APP_URL . '/partner/login/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:420px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Partner Sign In</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/login/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="identifier">Email</label>
                <input class="form-input" type="email" id="identifier" name="identifier" value="<?= e($identifier) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required autocomplete="current-password">
            </div>
            <div class="form-group" style="display:flex;align-items:center;justify-content:space-between">
                <label style="display:flex;align-items:center;gap:var(--space-2);font-size:var(--font-size-sm)">
                    <input type="checkbox" name="remember" value="1"> Remember me
                </label>
                <a href="/partner/forgot-password/" style="font-size:var(--font-size-sm)">Forgot password?</a>
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Sign In</button>
            <p style="margin-top:var(--space-4);text-align:center;font-size:var(--font-size-sm)">New partner? <a href="/partner/register/">Register here</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
