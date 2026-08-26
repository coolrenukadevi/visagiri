<?php
declare(strict_types=1);

$customer = current_customer();
$errors = [];
$passwordErrors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['form'] ?? '') === 'profile') {
    csrf_require();
    $firstName = trim((string) ($_POST['first_name'] ?? ''));
    $lastName = trim((string) ($_POST['last_name'] ?? ''));
    $mobile = trim((string) ($_POST['mobile'] ?? ''));
    $address = trim((string) ($_POST['address'] ?? ''));

    if ($firstName === '') {
        $errors[] = 'Enter your first name.';
    }
    if (!is_valid_mobile($mobile)) {
        $errors[] = 'Enter a valid mobile number.';
    }

    if (!$errors) {
        db()->prepare('UPDATE customers SET first_name = :first_name, last_name = :last_name, mobile = :mobile, address = :address WHERE id = :id')
            ->execute([
                'first_name' => $firstName,
                'last_name' => $lastName !== '' ? $lastName : null,
                'mobile' => $mobile,
                'address' => $address !== '' ? $address : null,
                'id' => $customer['id'],
            ]);
        flash_set('notice', 'Profile updated.');
        redirect('/dashboard/profile/');
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['form'] ?? '') === 'password') {
    csrf_require();
    $current = (string) ($_POST['current_password'] ?? '');
    $new = (string) ($_POST['new_password'] ?? '');
    $confirm = (string) ($_POST['confirm_password'] ?? '');

    if (!verify_password($current, $customer['password_hash'] ?? DUMMY_PASSWORD_HASH)) {
        $passwordErrors[] = 'Current password is incorrect.';
    } elseif (mb_strlen($new) < 8) {
        $passwordErrors[] = 'New password must be at least 8 characters.';
    } elseif ($new !== $confirm) {
        $passwordErrors[] = 'New passwords do not match.';
    } else {
        db()->prepare('UPDATE customers SET password_hash = :hash WHERE id = :id')
            ->execute(['hash' => hash_password($new), 'id' => $customer['id']]);
        flash_set('notice', 'Password changed.');
        redirect('/dashboard/profile/');
    }
}

render_dashboard_start('profile', 'Profile');
?>
<h2 class="country-directory__subheading">Your Details</h2>
<?php foreach ($errors as $error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endforeach; ?>
<form method="post" action="/dashboard/profile/" class="card" style="padding:var(--space-6);max-width:480px;margin-bottom:var(--space-8)">
    <?= csrf_field() ?>
    <input type="hidden" name="form" value="profile">
    <div class="form-group">
        <label class="form-label" for="first_name">First Name</label>
        <input class="form-input" type="text" id="first_name" name="first_name" value="<?= e($customer['first_name']) ?>" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="last_name">Last Name</label>
        <input class="form-input" type="text" id="last_name" name="last_name" value="<?= e($customer['last_name'] ?? '') ?>">
    </div>
    <div class="form-group">
        <label class="form-label">Email</label>
        <input class="form-input" type="email" value="<?= e($customer['email']) ?>" disabled>
        <span class="form-hint">Contact us to change your email address.</span>
    </div>
    <div class="form-group">
        <label class="form-label" for="mobile">Mobile Number</label>
        <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($customer['mobile'] ?? '') ?>" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="address">Address</label>
        <textarea class="form-input" id="address" name="address" rows="2"><?= e($customer['address'] ?? '') ?></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Save Changes</button>
</form>

<h2 class="country-directory__subheading">Change Password</h2>
<?php foreach ($passwordErrors as $error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endforeach; ?>
<form method="post" action="/dashboard/profile/" class="card" style="padding:var(--space-6);max-width:480px">
    <?= csrf_field() ?>
    <input type="hidden" name="form" value="password">
    <div class="form-group">
        <label class="form-label" for="current_password">Current Password</label>
        <input class="form-input" type="password" id="current_password" name="current_password" required autocomplete="current-password">
    </div>
    <div class="form-group">
        <label class="form-label" for="new_password">New Password</label>
        <input class="form-input" type="password" id="new_password" name="new_password" required autocomplete="new-password">
    </div>
    <div class="form-group">
        <label class="form-label" for="confirm_password">Confirm New Password</label>
        <input class="form-input" type="password" id="confirm_password" name="confirm_password" required autocomplete="new-password">
    </div>
    <button type="submit" class="btn btn-primary">Change Password</button>
</form>
<?php render_dashboard_end(); ?>
