<?php
$ADMIN_PAGE_TITLE = 'Team Management';
$ADMIN_ACTIVE_NAV = 'team';
$ADMIN_BREADCRUMB = ['CRM', 'Team Management'];
require __DIR__ . '/includes/layout-top.php';

if (!admin_can_manage_users()) {
    http_response_code(403);
    echo '<div class="crm-card">Only Super Admin can manage team members.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'add_user') {
        $name = trim($_POST['name'] ?? '');
        $username = trim($_POST['username'] ?? '');
        $password = (string) ($_POST['password'] ?? '');
        $role = trim($_POST['role'] ?? '');
        if ($name === '' || $username === '' || strlen($password) < 8 || !in_array($role, CRM_ROLES, true)) {
            $error = 'Please fill in every field. Passwords must be at least 8 characters.';
        } else {
            $exists = $pdo->prepare('SELECT COUNT(*) FROM users WHERE username = ?');
            $exists->execute([$username]);
            if ((int) $exists->fetchColumn() > 0) {
                $error = 'That username is already taken.';
            } else {
                $pdo->prepare('INSERT INTO users (name, username, password_hash, role, created_at) VALUES (?, ?, ?, ?, ?)')
                    ->execute([$name, $username, password_hash($password, PASSWORD_DEFAULT), $role, gmdate('c')]);
                header('Location: team.php');
                exit;
            }
        }
    } elseif ($action === 'delete_user') {
        $id = (int) ($_POST['id'] ?? 0);
        if ($id !== admin_user_id()) {
            $pdo->prepare('DELETE FROM users WHERE id = ?')->execute([$id]);
        }
        header('Location: team.php');
        exit;
    }
}

$users = $pdo->query('SELECT id, name, username, role, created_at FROM users ORDER BY created_at ASC')->fetchAll(PDO::FETCH_ASSOC);
$loadStmt = $pdo->prepare("SELECT COUNT(*) FROM enquiries WHERE assigned_to = ? AND archived_at IS NULL AND status NOT IN ('Visa Approved','Visa Refused','Passport Ready','Completed','Cancelled')");
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Team Management</h1>
        <p class="crm-page-subtitle">Manage CRM users and their roles. Visible to Super Admin only.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenAddUser"><i class="fa-solid fa-user-plus"></i> Add Team Member</button>
    </div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Name</th><th>Username</th><th>Role</th><th>Active Enquiries</th><th>Joined</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($users as $u): $loadStmt->execute([$u['name']]); $load = (int) $loadStmt->fetchColumn(); ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($u['name']); ?></td>
            <td><?php echo htmlspecialchars($u['username']); ?></td>
            <td><span class="crm-status-badge status-new-enquiry"><?php echo htmlspecialchars($u['role']); ?></span></td>
            <td><?php echo $load; ?></td>
            <td class="crm-cell-sub"><?php echo substr($u['created_at'], 0, 10); ?></td>
            <td>
                <?php if ((int) $u['id'] !== admin_user_id()): ?>
                <form method="post" data-confirm="Remove <?php echo htmlspecialchars($u['name']); ?> from the team?">
                    <input type="hidden" name="action" value="delete_user">
                    <input type="hidden" name="id" value="<?php echo (int) $u['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-trash" style="color:var(--c-red);"></i></button>
                </form>
                <?php else: ?><span class="crm-cell-sub">You</span><?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmAddUserDrawer">
    <div class="crm-drawer" style="max-width:440px;">
        <div class="crm-drawer-header"><h2>Add Team Member</h2><button type="button" class="crm-drawer-close" id="crmAddUserClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post">
                <input type="hidden" name="action" value="add_user">
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Full Name</label><input type="text" name="name" required></div>
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Username</label><input type="text" name="username" required></div>
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Password</label><input type="password" name="password" minlength="8" required></div>
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Role</label>
                    <select name="role"><?php foreach (CRM_ROLES as $r): ?><option><?php echo $r; ?></option><?php endforeach; ?></select>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Add Team Member</button>
            </form>
        </div>
    </div>
</div>
<script>
document.getElementById('crmOpenAddUser').addEventListener('click', function () {
    var d = document.getElementById('crmAddUserDrawer');
    d.hidden = false;
    requestAnimationFrame(function () { d.classList.add('is-open', 'is-visible'); });
});
document.getElementById('crmAddUserClose').addEventListener('click', function () {
    var d = document.getElementById('crmAddUserDrawer');
    d.classList.remove('is-visible');
    setTimeout(function () { d.classList.remove('is-open'); }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
