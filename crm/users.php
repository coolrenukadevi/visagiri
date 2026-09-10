<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/auth.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
if (!in_array($user['role_slug'], ['super_admin', 'admin'], true)) {
    header('Location: ' . url('crm/dashboard.php'));
    exit;
}

$pdo = db();
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && csrf_verify($_POST['csrf_token'] ?? null)) {
    $name = trim($_POST['name'] ?? '');
    $email = strtolower(trim($_POST['email'] ?? ''));
    $roleId = (int) ($_POST['role_id'] ?? 0);
    $password = (string) ($_POST['password'] ?? '');

    if ($name === '' || !filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($password) < 8 || !$roleId) {
        $errors[] = 'Fill in a valid name, email, role and an 8+ character password.';
    } else {
        try {
            $pdo->prepare('INSERT INTO users (role_id, name, email, password_hash, status) VALUES (?, ?, ?, ?, ?)')
                ->execute([$roleId, $name, $email, password_hash($password, PASSWORD_BCRYPT), 'active']);
            crm_audit_log('create_user', 'user', (int) $pdo->lastInsertId());
        } catch (PDOException $e) {
            $errors[] = 'A user with that email already exists.';
        }
    }
}

if (isset($_GET['toggle']) && ctype_digit($_GET['toggle'])) {
    $targetId = (int) $_GET['toggle'];
    $current = $pdo->prepare('SELECT status FROM users WHERE id = ?');
    $current->execute([$targetId]);
    if ($status = $current->fetchColumn()) {
        $newStatus = $status === 'active' ? 'inactive' : 'active';
        $pdo->prepare('UPDATE users SET status = ? WHERE id = ?')->execute([$newStatus, $targetId]);
        crm_audit_log('toggle_user_status', 'user', $targetId, ['status' => $newStatus]);
    }
    header('Location: ' . url('crm/users.php'));
    exit;
}

$roles = $pdo->query('SELECT id, slug, name FROM roles ORDER BY name')->fetchAll();
$users = $pdo->query('SELECT u.id, u.name, u.email, u.status, u.created_at, r.name AS role_name FROM users u JOIN roles r ON r.id = u.role_id ORDER BY u.name')->fetchAll();

$pageTitle = 'Team & Roles';
$crmActive = 'users';
require __DIR__ . '/includes/layout-top.php';
?>

<div class="grid-2" style="align-items:start;grid-template-columns:1.6fr 1fr">
    <div class="crm-panel">
        <h3>Team Members</h3>
        <div style="overflow-x:auto">
            <table class="data-table">
                <thead><tr><th>Name</th><th>Email</th><th>Role</th><th>Status</th><th>Joined</th><th></th></tr></thead>
                <tbody>
                    <?php foreach ($users as $u): ?>
                    <tr>
                        <td style="font-weight:600;color:var(--navy-900)"><?= e($u['name']) ?></td>
                        <td><?= e($u['email']) ?></td>
                        <td><?= e($u['role_name']) ?></td>
                        <td><span class="status-badge status-<?= $u['status'] === 'active' ? 'Converted' : 'Lost' ?>"><?= e(ucfirst($u['status'])) ?></span></td>
                        <td><?= e(date('d M Y', strtotime($u['created_at']))) ?></td>
                        <td><a href="<?= url('crm/users.php?toggle=' . (int) $u['id']) ?>" class="btn btn-ghost" style="padding:6px 12px;font-size:12px" onclick="return confirm('Change status for <?= e($u['name']) ?>?')"><?= $u['status'] === 'active' ? 'Deactivate' : 'Activate' ?></a></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>

    <div class="crm-panel">
        <h3>Add Team Member</h3>
        <?php foreach ($errors as $err): ?><div class="alert alert-error"><?= e($err) ?></div><?php endforeach; ?>
        <form method="post" action="<?= url('crm/users.php') ?>">
            <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
            <div class="form-row"><label>Full name</label><input class="form-control" type="text" name="name" required></div>
            <div class="form-row"><label>Work email</label><input class="form-control" type="email" name="email" required></div>
            <div class="form-row">
                <label>Role</label>
                <select class="form-control" name="role_id" required>
                    <?php foreach ($roles as $r): ?>
                    <option value="<?= (int) $r['id'] ?>"><?= e($r['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-row"><label>Temporary password</label><input class="form-control" type="text" name="password" placeholder="At least 8 characters" required></div>
            <button type="submit" class="btn btn-primary btn-block">Create Account</button>
        </form>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
