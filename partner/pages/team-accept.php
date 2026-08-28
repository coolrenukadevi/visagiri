<?php
declare(strict_types=1);

$token = (string) ($_GET['token'] ?? $_POST['token'] ?? '');
$member = $token !== '' ? verify_partner_team_invite_token($token) : null;

if (!$member) {
    $pageTitle = 'Invite Link Invalid - Visagiri';
    $noindex = true;
    require __DIR__ . '/../../includes/header.php';
    ?>
    <section class="section" style="padding-top:var(--space-8)">
        <div class="container" style="max-width:480px">
            <div class="card" style="padding:var(--space-6)">
                <h1>Invite Link Invalid</h1>
                <p>This invitation link is invalid or has expired. Ask the partner account owner to send a new invitation.</p>
                <a href="/partner/login/" class="btn btn-primary">Go to Sign In</a>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../../includes/footer.php';
    exit;
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $password = (string) ($_POST['password'] ?? '');
    $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

    if (strlen($password) < 8) {
        $errors[] = 'Password must be at least 8 characters.';
    } elseif ($password !== $confirmPassword) {
        $errors[] = 'Passwords do not match.';
    } else {
        accept_partner_team_invite((int) $member['id'], $password);
        log_in_partner((int) $member['partner_id'], (int) $member['id']);
        flash_set('notice', 'Welcome to the team!');
        redirect('/partner/dashboard/');
    }
}

$pageTitle = 'Accept Invitation - Visagiri';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:420px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Set Your Password</h1>
            <p>You've been invited as a <?= e($member['role']) ?>. Create a password to activate your account, <?= e($member['full_name']) ?>.</p>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/team-accept/?token=<?= e($token) ?>" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <input type="hidden" name="token" value="<?= e($token) ?>">
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="password" id="password" name="password" required autocomplete="new-password">
            </div>
            <div class="form-group">
                <label class="form-label" for="confirm_password">Confirm Password</label>
                <input class="form-input" type="password" id="confirm_password" name="confirm_password" required autocomplete="new-password">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Activate Account</button>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
