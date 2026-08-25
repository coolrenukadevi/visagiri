<?php
declare(strict_types=1);

/**
 * Admin user + role management. Only ever suspends/activates an
 * account (status column) — never a hard delete, consistent with the
 * soft-delete-only rule used for every other CRM record. Assigning a
 * role changes what require_permission() lets the account do
 * everywhere else in the admin panel.
 */

require_permission('users.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$roles = $pdo->query('SELECT id, name FROM roles ORDER BY name')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'toggle_status' && $id) {
        if ($id === current_admin_id()) {
            flash_set('admin_error', 'You cannot suspend your own account.');
            redirect('/admin/users/');
        }
        $current = $pdo->prepare('SELECT status FROM admin_users WHERE id = :id');
        $current->execute(['id' => $id]);
        $prevStatus = $current->fetchColumn();
        $newStatus = $prevStatus === 'active' ? 'suspended' : 'active';
        $pdo->prepare('UPDATE admin_users SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $id]);
        log_action('status_change', 'admin_users', $id, (string) $prevStatus, $newStatus);
        flash_set('admin_notice', 'User ' . ($newStatus === 'active' ? 'activated' : 'suspended') . '.');
        redirect('/admin/users/');
    }

    if ($postAction === 'save') {
        $username = trim((string) ($_POST['username'] ?? ''));
        $email = trim((string) ($_POST['email'] ?? ''));
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $roleId = (int) ($_POST['role_id'] ?? 0) ?: null;
        $password = (string) ($_POST['password'] ?? '');

        if ($username === '' || $fullName === '' || !is_valid_email($email)) {
            flash_set('admin_error', 'Username, full name, and a valid email are required.');
            redirect($id ? "/admin/users/?action=edit&id=$id" : '/admin/users/?action=create');
        }
        if (!$id && $password === '') {
            flash_set('admin_error', 'A password is required for a new user.');
            redirect('/admin/users/?action=create');
        }
        if ($password !== '' && strlen($password) < 10) {
            flash_set('admin_error', 'Password must be at least 10 characters.');
            redirect($id ? "/admin/users/?action=edit&id=$id" : '/admin/users/?action=create');
        }

        if ($id) {
            if ($password !== '') {
                $pdo->prepare('UPDATE admin_users SET username = :username, email = :email, full_name = :full_name, role_id = :role_id, password_hash = :password_hash WHERE id = :id')
                    ->execute([
                        'username' => $username, 'email' => $email, 'full_name' => $fullName,
                        'role_id' => $roleId, 'password_hash' => hash_password($password), 'id' => $id,
                    ]);
                log_action('password_reset', 'admin_users', $id);
            } else {
                $pdo->prepare('UPDATE admin_users SET username = :username, email = :email, full_name = :full_name, role_id = :role_id WHERE id = :id')
                    ->execute(['username' => $username, 'email' => $email, 'full_name' => $fullName, 'role_id' => $roleId, 'id' => $id]);
            }
            log_action('update', 'admin_users', $id);
            flash_set('admin_notice', 'User updated.');
        } else {
            $stmt = $pdo->prepare(
                'INSERT INTO admin_users (username, email, full_name, role_id, password_hash, status) VALUES (:username, :email, :full_name, :role_id, :password_hash, :status)'
            );
            try {
                $stmt->execute([
                    'username' => $username, 'email' => $email, 'full_name' => $fullName,
                    'role_id' => $roleId, 'password_hash' => hash_password($password), 'status' => 'active',
                ]);
            } catch (PDOException $e) {
                if ($e->getCode() === '23000') {
                    flash_set('admin_error', 'That username or email is already in use.');
                    redirect('/admin/users/?action=create');
                }
                throw $e;
            }
            $id = (int) $pdo->lastInsertId();
            log_action('create', 'admin_users', $id, null, $username);
            flash_set('admin_notice', 'User created.');
        }
        redirect('/admin/users/');
    }
}

if ($action === 'create' || $action === 'edit') {
    $user = ['username' => '', 'email' => '', 'full_name' => '', 'role_id' => null];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM admin_users WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'User not found.');
            redirect('/admin/users/');
        }
        $user = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit User' : 'Add User', 'users');
    ?>
    <div class="admin-form-card" style="max-width:600px">
        <form method="post" action="/admin/users/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="form-group"><label class="form-label" for="full_name">Full Name</label><input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($user['full_name']) ?>" required></div>
            <div class="form-group"><label class="form-label" for="username">Username</label><input class="form-input" type="text" id="username" name="username" value="<?= e($user['username']) ?>" required></div>
            <div class="form-group"><label class="form-label" for="email">Email</label><input class="form-input" type="email" id="email" name="email" value="<?= e($user['email']) ?>" required></div>
            <div class="form-group">
                <label class="form-label" for="role_id">Role</label>
                <select class="form-select" id="role_id" name="role_id">
                    <option value="">— No role (no admin permissions) —</option>
                    <?php foreach ($roles as $r): ?>
                    <option value="<?= (int) $r['id'] ?>"<?= (int) ($user['role_id'] ?? 0) === (int) $r['id'] ? ' selected' : '' ?>><?= e($r['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="password"><?= $action === 'edit' ? 'Reset Password (optional)' : 'Password' ?></label>
                <input class="form-input" type="password" id="password" name="password" autocomplete="new-password" placeholder="At least 10 characters" <?= $action === 'edit' ? '' : 'required' ?>>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/users/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$users = $pdo->query(
    'SELECT u.*, r.name AS role_name FROM admin_users u LEFT JOIN roles r ON r.id = u.role_id ORDER BY u.full_name'
)->fetchAll();

admin_header_start('Users & Roles', 'users');
?>
<div class="admin-toolbar">
    <a href="/admin/users/?action=create" class="btn btn-primary">+ Add User</a>
</div>
<table class="admin-table">
    <thead><tr><th>Name</th><th>Username</th><th>Email</th><th>Role</th><th>Status</th><th>Last Login</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($users as $u): ?>
        <tr>
            <td><?= e($u['full_name']) ?></td>
            <td><?= e($u['username']) ?></td>
            <td><?= e($u['email']) ?></td>
            <td><?= e($u['role_name'] ?? '— None —') ?></td>
            <td><span class="badge <?= $u['status'] === 'active' ? 'badge-success' : 'badge-neutral' ?>"><?= e(ucfirst($u['status'])) ?></span></td>
            <td><?= $u['last_login_at'] ? e(date('d M Y H:i', strtotime((string) $u['last_login_at']))) : '—' ?></td>
            <td class="actions">
                <a href="/admin/users/?action=edit&id=<?= (int) $u['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <?php if ((int) $u['id'] !== current_admin_id()): ?>
                <form method="post" action="/admin/users/" style="display:inline">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="toggle_status">
                    <input type="hidden" name="id" value="<?= (int) $u['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm"><?= $u['status'] === 'active' ? 'Suspend' : 'Activate' ?></button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php
admin_header_end();
