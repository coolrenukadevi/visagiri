<?php
declare(strict_types=1);

/**
 * Roles & Permissions management. Super Admin (the only role holding
 * users.manage — same gate admin/pages/users.php already uses) can
 * create new roles and edit exactly which permissions any OTHER role
 * carries, which is what actually controls which module tiles/pages
 * a user assigned to that role can reach (has_permission() /
 * require_permission(), includes/rbac.php). The super-admin role
 * itself is never editable here — its whole purpose is to be the one
 * role guaranteed full access, so there's no screen that could ever
 * accidentally lock every admin out of the system.
 */

require_permission('users.manage');

const ROLE_PERMISSION_GROUP_LABELS = [
    'audit' => 'Audit',
    'b2b_travel_partners' => 'B2B Travel Partner Portal',
    'content' => 'Content / CMS',
    'customers' => 'Customers',
    'documents' => 'Documents',
    'enquiries' => 'Enquiries (Visa + Apostille)',
    'forex' => 'Forex',
    'general_enquiries' => 'General & Attestation Enquiries',
    'grievances' => 'Grievances',
    'hrms' => 'HRMS',
    'partners' => 'Referral Partners',
    'recycle_bin' => 'Recycle Bin',
    'settings' => 'Settings',
    'users' => 'Users & Roles',
    'visa' => 'Visa Operations (Legacy)',
];

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

$SUPER_ADMIN_SLUG = 'super-admin';
$superAdminRoleId = (int) $pdo->query("SELECT id FROM roles WHERE slug = '$SUPER_ADMIN_SLUG'")->fetchColumn();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create_role') {
        $name = trim((string) ($_POST['name'] ?? ''));
        $description = trim((string) ($_POST['description'] ?? '')) ?: null;

        if ($name === '') {
            flash_set('admin_error', 'Enter a role name.');
            redirect('/admin/roles/?action=create');
        }
        $slug = slugify($name);
        if ($slug === '') {
            flash_set('admin_error', 'That name produces an empty slug — use at least one letter or number.');
            redirect('/admin/roles/?action=create');
        }

        try {
            $pdo->prepare('INSERT INTO roles (name, slug, description) VALUES (:name, :slug, :description)')
                ->execute(['name' => $name, 'slug' => $slug, 'description' => $description]);
        } catch (PDOException $e) {
            if ($e->getCode() === '23000') {
                flash_set('admin_error', 'A role with that name (or the same slug) already exists.');
                redirect('/admin/roles/?action=create');
            }
            throw $e;
        }
        $newRoleId = (int) $pdo->lastInsertId();
        log_action('create', 'roles', $newRoleId, null, $name);
        flash_set('admin_notice', 'Role created. Now choose which modules it can access.');
        redirect('/admin/roles/?action=edit&id=' . $newRoleId);
    }

    if ($postAction === 'save_permissions' && $id) {
        if ($id === $superAdminRoleId) {
            flash_set('admin_error', 'Super Admin always has every permission — it cannot be edited.');
            redirect('/admin/roles/');
        }
        $roleExistsStmt = $pdo->prepare('SELECT id FROM roles WHERE id = :id');
        $roleExistsStmt->execute(['id' => $id]);
        if (!$roleExistsStmt->fetchColumn()) {
            flash_set('admin_error', 'Role not found.');
            redirect('/admin/roles/');
        }

        $checkedPermissionIds = array_map('intval', (array) ($_POST['permission_ids'] ?? []));
        $allPermissionIds = array_map('intval', $pdo->query('SELECT id FROM permissions')->fetchAll(PDO::FETCH_COLUMN));
        $checkedPermissionIds = array_values(array_intersect($checkedPermissionIds, $allPermissionIds));

        $pdo->beginTransaction();
        $pdo->prepare('DELETE FROM role_permissions WHERE role_id = :role_id')->execute(['role_id' => $id]);
        if ($checkedPermissionIds) {
            $insertStmt = $pdo->prepare('INSERT INTO role_permissions (role_id, permission_id) VALUES (:role_id, :permission_id)');
            foreach ($checkedPermissionIds as $permissionId) {
                $insertStmt->execute(['role_id' => $id, 'permission_id' => $permissionId]);
            }
        }
        $pdo->commit();

        log_action('update_permissions', 'roles', $id, null, count($checkedPermissionIds) . ' permissions');
        flash_set('admin_notice', 'Permissions updated. Anyone signed in with this role will see the change on their next request.');
        redirect('/admin/roles/?action=edit&id=' . $id);
    }

    redirect('/admin/roles/');
}

if ($action === 'create') {
    admin_header_start('New Role', 'roles');
    admin_subnav('system', 'roles');
    ?>
    <div class="admin-form-card" style="max-width:560px">
        <form method="post" action="/admin/roles/">
            <?= csrf_field() ?><input type="hidden" name="action" value="create_role">
            <div class="form-group"><label class="form-label" for="name">Role Name</label><input class="form-input" type="text" id="name" name="name" placeholder="e.g. Sales Executive" required></div>
            <div class="form-group"><label class="form-label" for="description">Description (optional)</label><input class="form-input" type="text" id="description" name="description" placeholder="What this role is for"></div>
            <p style="color:var(--text-muted);font-size:var(--font-size-sm)">You'll choose which modules this role can access on the next screen — a new role starts with no permissions at all.</p>
            <button type="submit" class="btn btn-primary">Create Role</button>
            <a href="/admin/roles/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

if ($action === 'edit' && $id) {
    $roleStmt = $pdo->prepare('SELECT * FROM roles WHERE id = :id');
    $roleStmt->execute(['id' => $id]);
    $role = $roleStmt->fetch();
    if (!$role) {
        flash_set('admin_error', 'Role not found.');
        redirect('/admin/roles/');
    }
    if ($id === $superAdminRoleId) {
        flash_set('admin_error', 'Super Admin always has every permission — it cannot be edited.');
        redirect('/admin/roles/');
    }

    $allPermissions = $pdo->query('SELECT id, permission_key, description FROM permissions ORDER BY permission_key')->fetchAll();
    $grantedStmt = $pdo->prepare('SELECT permission_id FROM role_permissions WHERE role_id = :role_id');
    $grantedStmt->execute(['role_id' => $id]);
    $grantedIds = array_map('intval', $grantedStmt->fetchAll(PDO::FETCH_COLUMN));

    $groups = [];
    foreach ($allPermissions as $p) {
        $groupKey = explode('.', $p['permission_key'])[0];
        $groups[$groupKey][] = $p;
    }
    ksort($groups);

    $userCountStmt = $pdo->prepare('SELECT COUNT(*) FROM admin_users WHERE role_id = :role_id');
    $userCountStmt->execute(['role_id' => $id]);
    $userCount = (int) $userCountStmt->fetchColumn();

    admin_header_start('Permissions — ' . $role['name'], 'roles');
    admin_subnav('system', 'roles');
    ?>
    <p style="color:var(--text-muted)"><?= $role['description'] ? e($role['description']) . ' — ' : '' ?><?= $userCount ?> user<?= $userCount === 1 ? '' : 's' ?> currently on this role.</p>
    <form method="post" action="/admin/roles/">
        <?= csrf_field() ?><input type="hidden" name="action" value="save_permissions"><input type="hidden" name="id" value="<?= $id ?>">
        <?php foreach ($groups as $groupKey => $permissions): ?>
        <div class="admin-form-card" style="margin-bottom:var(--space-4)">
            <h2 class="country-directory__subheading" style="margin-top:0">
                <label style="font-weight:normal;font-size:var(--font-size-sm);float:right"><input type="checkbox" data-role-permission-group-toggle="<?= e($groupKey) ?>"> Select all</label>
                <?= e(ROLE_PERMISSION_GROUP_LABELS[$groupKey] ?? ucfirst(str_replace('_', ' ', $groupKey))) ?>
            </h2>
            <?php foreach ($permissions as $p): ?>
            <label style="display:block;margin-bottom:var(--space-2)">
                <input type="checkbox" name="permission_ids[]" value="<?= (int) $p['id'] ?>" data-role-permission-group="<?= e($groupKey) ?>"<?= in_array((int) $p['id'], $grantedIds, true) ? ' checked' : '' ?>>
                <strong><?= e($p['permission_key']) ?></strong><?= $p['description'] ? ' — ' . e($p['description']) : '' ?>
            </label>
            <?php endforeach; ?>
        </div>
        <?php endforeach; ?>
        <button type="submit" class="btn btn-primary">Save Permissions</button>
        <a href="/admin/roles/" class="btn btn-outline">Cancel</a>
    </form>
    <script src="<?= e(asset_url('/assets/js/admin-role-permissions.js')) ?>"></script>
    <?php
    admin_header_end();
    exit;
}

$roles = $pdo->query(
    'SELECT r.*, (SELECT COUNT(*) FROM admin_users u WHERE u.role_id = r.id) AS user_count,
            (SELECT COUNT(*) FROM role_permissions rp WHERE rp.role_id = r.id) AS permission_count
     FROM roles r ORDER BY (r.id = ' . (int) $superAdminRoleId . ') DESC, r.name'
)->fetchAll();
$totalPermissionCount = (int) $pdo->query('SELECT COUNT(*) FROM permissions')->fetchColumn();

admin_header_start('Roles &amp; Permissions', 'roles');
admin_subnav('system', 'roles');
?>
<div class="admin-toolbar">
    <a href="/admin/roles/?action=create" class="btn btn-primary">+ New Role</a>
</div>
<table class="admin-table">
    <thead><tr><th>Role</th><th>Description</th><th>Users</th><th>Permissions</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($roles as $r): ?>
        <tr>
            <td><?= e($r['name']) ?><?= (int) $r['id'] === $superAdminRoleId ? ' <span class="badge badge-success">Full Access</span>' : '' ?></td>
            <td><?= e($r['description'] ?? '—') ?></td>
            <td><?= (int) $r['user_count'] ?></td>
            <td><?= (int) $r['id'] === $superAdminRoleId ? 'All (' . $totalPermissionCount . ')' : (int) $r['permission_count'] . ' / ' . $totalPermissionCount ?></td>
            <td class="actions">
                <?php if ((int) $r['id'] === $superAdminRoleId): ?>
                <span style="color:var(--text-muted);font-size:var(--font-size-sm)">Protected — not editable</span>
                <?php else: ?>
                <a href="/admin/roles/?action=edit&id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Edit Permissions</a>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php
admin_header_end();
