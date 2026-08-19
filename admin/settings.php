<?php
$ADMIN_PAGE_TITLE = 'Settings';
$ADMIN_ACTIVE_NAV = 'settings';
$ADMIN_BREADCRUMB = ['CRM', 'Settings'];
require __DIR__ . '/includes/layout-top.php';

$message = '';
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current = (string) ($_POST['current_password'] ?? '');
    $new = (string) ($_POST['new_password'] ?? '');
    $confirm = (string) ($_POST['confirm_password'] ?? '');

    $stmt = $pdo->prepare('SELECT password_hash FROM users WHERE id = ?');
    $stmt->execute([admin_user_id()]);
    $hash = $stmt->fetchColumn();

    if (!$hash || !password_verify($current, $hash)) {
        $error = 'Current password is incorrect.';
    } elseif (strlen($new) < 8) {
        $error = 'New password must be at least 8 characters.';
    } elseif ($new !== $confirm) {
        $error = 'New password and confirmation do not match.';
    } else {
        $pdo->prepare('UPDATE users SET password_hash = ? WHERE id = ?')->execute([password_hash($new, PASSWORD_DEFAULT), admin_user_id()]);
        $message = 'Password updated successfully.';
    }
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Settings</h1>
        <p class="crm-page-subtitle">Manage your account.</p>
    </div>
</div>

<div class="crm-card" style="max-width:440px;">
    <h3>Change Password</h3>
    <?php if ($message): ?><div style="background:var(--c-green-bg);color:var(--c-green);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($message); ?></div><?php endif; ?>
    <?php if ($error): ?><div style="background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>
    <form method="post">
        <div class="crm-form-field" style="margin-bottom:14px;"><label>Current Password</label><input type="password" name="current_password" required></div>
        <div class="crm-form-field" style="margin-bottom:14px;"><label>New Password</label><input type="password" name="new_password" minlength="8" required></div>
        <div class="crm-form-field" style="margin-bottom:14px;"><label>Confirm New Password</label><input type="password" name="confirm_password" minlength="8" required></div>
        <button type="submit" class="crm-btn crm-btn-primary">Update Password</button>
    </form>
</div>

<div class="crm-card" style="max-width:440px;">
    <h3>Account</h3>
    <div class="crm-panel-item" style="margin-bottom:10px;"><label>Name</label><div class="val"><?php echo htmlspecialchars(admin_name()); ?></div></div>
    <div class="crm-panel-item"><label>Role</label><div class="val"><?php echo htmlspecialchars(admin_role()); ?></div></div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
