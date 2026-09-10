<?php
declare(strict_types=1);

/**
 * Self-service profile page for the logged-in admin — edit own
 * name/email, change own password. Every admin can reach this
 * regardless of role/permissions (it only ever touches their own
 * admin_users row, looked up by current_admin_id(), never an id from
 * the request), same as the customer/partner dashboards' own profile
 * pages already do.
 */

$pdo = db();
$admin = current_admin();
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $formType = $_POST['form'] ?? '';

    if ($formType === 'details') {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $email = trim((string) ($_POST['email'] ?? ''));

        if ($fullName === '' || mb_strlen($fullName) < 2) {
            $errors[] = 'Please enter your full name.';
        }
        if (!is_valid_email($email)) {
            $errors[] = 'Please enter a valid email address.';
        }
        if (!$errors) {
            $dupe = $pdo->prepare('SELECT id FROM admin_users WHERE email = :email AND id != :id');
            $dupe->execute(['email' => $email, 'id' => $admin['id']]);
            if ($dupe->fetchColumn()) {
                $errors[] = 'That email address is already in use by another account.';
            }
        }
        if (!$errors) {
            $pdo->prepare('UPDATE admin_users SET full_name = :full_name, email = :email WHERE id = :id')
                ->execute(['full_name' => $fullName, 'email' => $email, 'id' => $admin['id']]);
            log_action('update_profile', 'admin_users', $admin['id']);
            flash_set('admin_notice', 'Profile updated.');
            redirect('/admin/profile/');
        }
    } elseif ($formType === 'password') {
        $currentPassword = (string) ($_POST['current_password'] ?? '');
        $newPassword = (string) ($_POST['new_password'] ?? '');
        $confirmPassword = (string) ($_POST['confirm_password'] ?? '');

        $stmt = $pdo->prepare('SELECT password_hash FROM admin_users WHERE id = :id');
        $stmt->execute(['id' => $admin['id']]);
        $currentHash = (string) $stmt->fetchColumn();

        if (!verify_password($currentPassword, $currentHash)) {
            $errors[] = 'Current password is incorrect.';
        }
        if (strlen($newPassword) < 10) {
            $errors[] = 'New password must be at least 10 characters.';
        }
        if ($newPassword !== $confirmPassword) {
            $errors[] = 'New password and confirmation do not match.';
        }
        if (!$errors) {
            $pdo->prepare('UPDATE admin_users SET password_hash = :hash WHERE id = :id')
                ->execute(['hash' => hash_password($newPassword), 'id' => $admin['id']]);
            log_action('change_password', 'admin_users', $admin['id']);
            flash_set('admin_notice', 'Password changed.');
            redirect('/admin/profile/');
        }
    }

    $admin = current_admin();
}

admin_header_start('My Profile', 'profile');
?>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>

<div class="admin-profile-grid">
    <div class="admin-form-card">
        <h2 class="admin-panel__title">Profile Details</h2>
        <form method="post">
            <?= csrf_field() ?>
            <input type="hidden" name="form" value="details">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="full_name">Full Name</label>
                    <input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($admin['full_name'] ?? '') ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" value="<?= e($admin['email'] ?? '') ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input class="form-input" type="text" value="<?= e($admin['username'] ?? '') ?>" disabled>
                </div>
                <div class="form-group">
                    <label class="form-label">Role</label>
                    <input class="form-input" type="text" value="<?= e($admin['role_name'] ?? '') ?>" disabled>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form>
    </div>

    <div class="admin-form-card">
        <h2 class="admin-panel__title">Change Password</h2>
        <form method="post">
            <?= csrf_field() ?>
            <input type="hidden" name="form" value="password">
            <div class="admin-form-grid admin-form-grid--single">
                <div class="form-group">
                    <label class="form-label" for="current_password">Current Password</label>
                    <input class="form-input" type="password" id="current_password" name="current_password" required autocomplete="current-password">
                </div>
                <div class="form-group">
                    <label class="form-label" for="new_password">New Password</label>
                    <input class="form-input" type="password" id="new_password" name="new_password" required minlength="10" autocomplete="new-password">
                </div>
                <div class="form-group">
                    <label class="form-label" for="confirm_password">Confirm New Password</label>
                    <input class="form-input" type="password" id="confirm_password" name="confirm_password" required minlength="10" autocomplete="new-password">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Change Password</button>
        </form>
    </div>
</div>
<?php
admin_header_end();
