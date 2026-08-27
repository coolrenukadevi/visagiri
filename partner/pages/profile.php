<?php
declare(strict_types=1);

$partner = current_partner();
$errors = [];
$passwordErrors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['form'] ?? '') === 'profile') {
    csrf_require();
    $companyName = trim((string) ($_POST['company_name'] ?? ''));
    $contactName = trim((string) ($_POST['contact_name'] ?? ''));
    $mobile = trim((string) ($_POST['mobile'] ?? ''));

    if ($companyName === '' || $contactName === '') {
        $errors[] = 'Company name and contact name are required.';
    } else {
        db()->prepare('UPDATE partners SET company_name = :company_name, contact_name = :contact_name, mobile = :mobile WHERE id = :id')
            ->execute([
                'company_name' => $companyName,
                'contact_name' => $contactName,
                'mobile' => $mobile !== '' ? $mobile : null,
                'id' => $partner['id'],
            ]);
        flash_set('notice', 'Profile updated.');
        redirect('/partner/profile/');
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['form'] ?? '') === 'password') {
    csrf_require();
    $current = (string) ($_POST['current_password'] ?? '');
    $new = (string) ($_POST['new_password'] ?? '');
    $confirm = (string) ($_POST['confirm_password'] ?? '');

    if (!verify_password($current, $partner['password_hash'] ?? DUMMY_PASSWORD_HASH)) {
        $passwordErrors[] = 'Current password is incorrect.';
    } elseif (mb_strlen($new) < 8) {
        $passwordErrors[] = 'New password must be at least 8 characters.';
    } elseif ($new !== $confirm) {
        $passwordErrors[] = 'New passwords do not match.';
    } else {
        db()->prepare('UPDATE partners SET password_hash = :hash WHERE id = :id')
            ->execute(['hash' => hash_password($new), 'id' => $partner['id']]);
        flash_set('notice', 'Password changed.');
        redirect('/partner/profile/');
    }
}

render_partner_start('profile', 'Profile');
?>
<h2 class="country-directory__subheading">Your Details</h2>
<?php foreach ($errors as $error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endforeach; ?>
<form method="post" action="/partner/profile/" class="card" style="padding:var(--space-6);max-width:480px;margin-bottom:var(--space-8)">
    <?= csrf_field() ?>
    <input type="hidden" name="form" value="profile">
    <div class="form-group">
        <label class="form-label" for="company_name">Company / Business Name</label>
        <input class="form-input" type="text" id="company_name" name="company_name" value="<?= e($partner['company_name']) ?>" required>
    </div>
    <div class="form-group">
        <label class="form-label" for="contact_name">Contact Person</label>
        <input class="form-input" type="text" id="contact_name" name="contact_name" value="<?= e($partner['contact_name']) ?>" required>
    </div>
    <div class="form-group">
        <label class="form-label">Email</label>
        <input class="form-input" type="email" value="<?= e($partner['email']) ?>" disabled>
        <span class="form-hint">Contact us to change your email address.</span>
    </div>
    <div class="form-group">
        <label class="form-label" for="mobile">Mobile Number</label>
        <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($partner['mobile'] ?? '') ?>">
    </div>
    <button type="submit" class="btn btn-primary">Save Changes</button>
</form>

<h2 class="country-directory__subheading">Change Password</h2>
<?php foreach ($passwordErrors as $error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endforeach; ?>
<form method="post" action="/partner/profile/" class="card" style="padding:var(--space-6);max-width:480px">
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
<?php render_partner_end(); ?>
