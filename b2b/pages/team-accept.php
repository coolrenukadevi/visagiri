<?php
declare(strict_types=1);

/** B2B Travel Partner Portal — accept a team invite by setting a password. No login required. */

$token = trim((string) ($_GET['token'] ?? $_POST['token'] ?? ''));
$invitedUser = $token !== '' ? b2b_verify_invite_token($token) : null;
$invitingPartner = null;
if ($invitedUser) {
    $partnerStmt = db()->prepare('SELECT legal_business_name FROM b2b_partners WHERE id = :id');
    $partnerStmt->execute(['id' => $invitedUser['b2b_partner_id']]);
    $invitingPartner = $partnerStmt->fetch();
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $invitedUser) {
    csrf_require();
    $password = (string) ($_POST['password'] ?? '');
    $passwordConfirm = (string) ($_POST['password_confirm'] ?? '');

    if (strlen($password) < 10) {
        $errors[] = 'Password must be at least 10 characters.';
    } elseif ($password !== $passwordConfirm) {
        $errors[] = 'Passwords do not match.';
    }

    if (!$errors) {
        b2b_complete_invite((int) $invitedUser['id'], $password);
        log_in_b2b_partner_user((int) $invitedUser['id']);
        flash_set('b2b_notice', 'Welcome aboard — your account is ready.');
        redirect('/b2b/dashboard/');
    }
}

$pageTitle = 'Accept Invitation - Visagiri B2B Travel Partner Portal';
$canonicalUrl = APP_URL . '/b2b/team-accept/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:440px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Accept Invitation</h1>
        </div>
        <?php if (!$invitedUser): ?>
        <div class="alert alert-danger">This invite link is invalid or has expired. Ask your account admin to send a new one.</div>
        <?php else: ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <p>Set a password for <strong><?= e($invitedUser['email']) ?></strong> to join <strong><?= e($invitingPartner['legal_business_name'] ?? 'this') ?></strong>'s Visagiri B2B Travel Partner account.</p>
        <form method="post" action="/b2b/team-accept/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?><input type="hidden" name="token" value="<?= e($token) ?>">
            <div class="form-group">
                <label class="form-label" for="password">New Password</label>
                <input class="form-input" type="password" id="password" name="password" required minlength="10">
            </div>
            <div class="form-group">
                <label class="form-label" for="password_confirm">Confirm Password</label>
                <input class="form-input" type="password" id="password_confirm" name="password_confirm" required minlength="10">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Set Password &amp; Sign In</button>
        </form>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
