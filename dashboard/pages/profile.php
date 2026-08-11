<?php
declare(strict_types=1);

$user = current_user();
$pdo = db();
$errors = [];
$passwordErrors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $action = $_POST['action'] ?? '';

    if ($action === 'update_profile') {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $mobile = trim((string) ($_POST['mobile'] ?? ''));

        if ($fullName === '' || mb_strlen($fullName) > 150) {
            $errors[] = 'Enter your full name.';
        }
        if (!is_valid_mobile($mobile)) {
            $errors[] = 'Enter a valid mobile number.';
        }

        if (!$errors) {
            $pdo->prepare('UPDATE users SET full_name = :full_name, mobile = :mobile WHERE id = :id')
                ->execute(['full_name' => $fullName, 'mobile' => $mobile, 'id' => $user['id']]);
            flash_set('notice', 'Profile updated.');
            redirect('/dashboard/profile/');
        }
    } elseif ($action === 'change_password') {
        $currentPassword = (string) ($_POST['current_password'] ?? '');
        $newPassword = (string) ($_POST['new_password'] ?? '');
        $confirmPassword = (string) ($_POST['confirm_new_password'] ?? '');

        $stmt = $pdo->prepare('SELECT password_hash FROM users WHERE id = :id');
        $stmt->execute(['id' => $user['id']]);
        $hash = $stmt->fetchColumn();

        if (!verify_password($currentPassword, (string) $hash)) {
            $passwordErrors[] = 'Current password is incorrect.';
        } elseif (mb_strlen($newPassword) < 8) {
            $passwordErrors[] = 'New password must be at least 8 characters.';
        } elseif ($newPassword !== $confirmPassword) {
            $passwordErrors[] = 'New passwords do not match.';
        } else {
            $pdo->prepare('UPDATE users SET password_hash = :hash WHERE id = :id')
                ->execute(['hash' => hash_password($newPassword), 'id' => $user['id']]);
            flash_set('notice', 'Password changed successfully.');
            redirect('/dashboard/profile/');
        }
    }
}

// Re-fetch in case of a just-submitted (but failed) profile update, so the form reflects the DB, not stale $user.
$stmt = $pdo->prepare('SELECT full_name, email, mobile FROM users WHERE id = :id');
$stmt->execute(['id' => $user['id']]);
$profile = $stmt->fetch();

render_dashboard_start('profile', 'Profile');
?>
<div class="card" style="max-width:520px;margin-bottom:var(--space-6)">
    <div class="card-title">Account details</div>
    <?php foreach ($errors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>
    <form method="post" action="/dashboard/profile/">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="update_profile">
        <div class="form-group">
            <label class="form-label" for="full_name">Full name</label>
            <input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($_POST['full_name'] ?? $profile['full_name']) ?>" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="email">Email</label>
            <input class="form-input" type="email" id="email" value="<?= e($profile['email']) ?>" disabled>
            <span class="form-hint">Contact support to change your email.</span>
        </div>
        <div class="form-group">
            <label class="form-label" for="mobile">Mobile number</label>
            <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($_POST['mobile'] ?? $profile['mobile']) ?>" required>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</div>

<div class="card" style="max-width:520px">
    <div class="card-title">Change password</div>
    <?php foreach ($passwordErrors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>
    <form method="post" action="/dashboard/profile/">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="change_password">
        <div class="form-group">
            <label class="form-label" for="current_password">Current password</label>
            <input class="form-input" type="password" id="current_password" name="current_password" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="new_password">New password</label>
            <input class="form-input" type="password" id="new_password" name="new_password" minlength="8" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="confirm_new_password">Confirm new password</label>
            <input class="form-input" type="password" id="confirm_new_password" name="confirm_new_password" minlength="8" required>
        </div>
        <button type="submit" class="btn btn-outline">Change Password</button>
    </form>
</div>
<?php render_dashboard_end(); ?>
