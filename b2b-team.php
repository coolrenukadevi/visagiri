<?php
ob_start();
$PP_PAGE_TITLE = 'Team Management';
$PP_ACTIVE_NAV = 'team';
require __DIR__ . '/includes/partner-layout-top.php';
partner_require_permission('manage_users');

$pid = partner_id();
$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    b2b_csrf_require_or_403();
    $action = $_POST['action'] ?? '';

    if ($action === 'add_member') {
        $name = trim($_POST['name'] ?? '');
        $designation = trim($_POST['designation'] ?? '');
        $email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
        $mobile = preg_replace('/\D/', '', $_POST['mobile'] ?? '');
        $role = trim($_POST['role'] ?? '');
        $username = trim($_POST['username'] ?? '');
        $password = (string) ($_POST['password'] ?? '');
        $permissions = array_values(array_intersect((array) ($_POST['permissions'] ?? []), array_keys(B2B_PARTNER_PERMISSIONS)));

        $validRoles = array_diff(B2B_PARTNER_USER_ROLES, ['Owner']);
        if ($name === '' || !$email || !preg_match('/^[6-9]\d{9}$/', $mobile) || !in_array($role, $validRoles, true)) {
            $actionError = 'Please provide a valid name, email, 10-digit mobile number and role.';
        } elseif ($username === '' || strlen($username) < 4) {
            $actionError = 'Username must be at least 4 characters.';
        } elseif (strlen($password) < 8) {
            $actionError = 'Password must be at least 8 characters.';
        } else {
            $dupStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_partner_users WHERE username = ? OR email = ?');
            $dupStmt->execute([$username, $email]);
            if ((int) $dupStmt->fetchColumn() > 0) {
                $actionError = 'That username or email is already in use.';
            } else {
                $now = gmdate('c');
                $pdo->prepare('INSERT INTO b2b_partner_users (partner_id, name, designation, email, username, password_hash, mobile, whatsapp, role, permissions, is_primary, status, email_verified_at, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?, ?)')
                    ->execute([
                        $pid, $name, $designation ?: null, $email, $username, password_hash($password, PASSWORD_DEFAULT),
                        '+91' . $mobile, '+91' . $mobile, $role, json_encode($permissions), 'Active', $now, $now,
                    ]);
                $newUserId = (int) $pdo->lastInsertId();
                b2b_log_audit($pdo, 'partner', $pid, partner_name(), 'Partner (' . partner_role() . ')', 'Added team member', '', "$name ($role) — $username");
                b2b_notify($pdo, null, 'b2b_team_member_added', partner_company() . " added a team member: $name ($role).", $pid);
                $actionMessage = "$name added to your team. Share their username ($username) and password with them directly.";
            }
        }
    } elseif ($action === 'update_member') {
        $userId = (int) ($_POST['user_id'] ?? 0);
        $role = trim($_POST['role'] ?? '');
        $status = trim($_POST['status'] ?? '');
        $permissions = array_values(array_intersect((array) ($_POST['permissions'] ?? []), array_keys(B2B_PARTNER_PERMISSIONS)));

        $memberStmt = $pdo->prepare('SELECT * FROM b2b_partner_users WHERE id = ? AND partner_id = ?');
        $memberStmt->execute([$userId, $pid]);
        $member = $memberStmt->fetch(PDO::FETCH_ASSOC);

        $validRoles = array_diff(B2B_PARTNER_USER_ROLES, ['Owner']);
        if (!$member || $member['is_primary']) {
            $actionError = 'That team member could not be updated.';
        } elseif (!in_array($role, $validRoles, true) || !in_array($status, B2B_PARTNER_USER_STATUSES, true)) {
            $actionError = 'Please provide a valid role and status.';
        } else {
            $pdo->prepare('UPDATE b2b_partner_users SET role = ?, status = ?, permissions = ? WHERE id = ?')
                ->execute([$role, $status, json_encode($permissions), $userId]);
            b2b_log_audit($pdo, 'partner', $pid, partner_name(), 'Partner (' . partner_role() . ')', 'Updated team member', $member['role'], "{$member['name']} — $role, $status");
            $actionMessage = "{$member['name']}'s access updated.";
        }
    }
}

$teamStmt = $pdo->prepare('SELECT * FROM b2b_partner_users WHERE partner_id = ? ORDER BY is_primary DESC, created_at ASC');
$teamStmt->execute([$pid]);
$team = $teamStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Team Management</h1>
        <p class="pp-page-subtitle">Add team members and control exactly what each can see and do in the Partner Portal.</p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="b2b-form-error" style="background:#E7F6EC;color:#16A34A;"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="b2b-form-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="pp-card">
    <h3>Add Team Member</h3>
    <form method="post" class="pp-panel-grid">
        <input type="hidden" name="action" value="add_member">
        <div class="pp-panel-item"><label>Full Name</label><input type="text" name="name" required style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item"><label>Designation</label><input type="text" name="designation" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item"><label>Email</label><input type="email" name="email" required style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item"><label>Mobile</label><input type="text" name="mobile" required maxlength="10" placeholder="10-digit mobile" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item">
            <label>Role</label>
            <select name="role" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;">
                <?php foreach (array_diff(B2B_PARTNER_USER_ROLES, ['Owner']) as $r): ?><option value="<?php echo htmlspecialchars($r); ?>"><?php echo htmlspecialchars($r); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="pp-panel-item"><label>Username</label><input type="text" name="username" required minlength="4" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item"><label>Password</label><input type="password" name="password" required minlength="8" style="width:100%;border:1px solid var(--border);border-radius:8px;padding:8px 10px;"></div>
        <div class="pp-panel-item full">
            <label>Permissions</label>
            <div class="pp-perm-grid">
                <?php foreach (B2B_PARTNER_PERMISSIONS as $key => $label): ?>
                <label class="pp-perm-check"><input type="checkbox" name="permissions[]" value="<?php echo htmlspecialchars($key); ?>"> <?php echo htmlspecialchars($label); ?></label>
                <?php endforeach; ?>
            </div>
        </div>
        <div class="pp-panel-item full"><button type="submit" class="b2b-submit-btn" style="width:auto;padding:12px 26px;">Add Team Member</button></div>
    </form>
</div>

<div class="pp-card">
    <h3>Your Team</h3>
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Name</th><th>Role</th><th>Username</th><th>Status</th><th>Permissions</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($team as $m): $memberPerms = json_decode($m['permissions'] ?? '[]', true) ?: []; ?>
        <tr>
            <td class="pp-cell-name"><?php echo htmlspecialchars($m['name']); ?><?php if ($m['is_primary']): ?> <span class="pp-status-badge status-visa-approved">Owner</span><?php endif; ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($m['role']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($m['username']); ?></td>
            <td><span class="pp-status-badge <?php echo $m['status'] === 'Active' ? 'status-visa-approved' : 'status-cancelled'; ?>"><?php echo htmlspecialchars($m['status']); ?></span></td>
            <td class="pp-cell-sub"><?php echo $m['is_primary'] ? 'All (Owner)' : ($memberPerms ? htmlspecialchars(implode(', ', array_map(fn($k) => B2B_PARTNER_PERMISSIONS[$k] ?? $k, $memberPerms))) : 'None'); ?></td>
            <td>
                <?php if (!$m['is_primary']): ?>
                <details>
                    <summary style="cursor:pointer;font-size:12px;color:var(--theme);">Edit</summary>
                    <form method="post" style="margin-top:10px;display:flex;flex-direction:column;gap:8px;min-width:220px;">
                        <input type="hidden" name="action" value="update_member">
                        <input type="hidden" name="user_id" value="<?php echo (int) $m['id']; ?>">
                        <select name="role" style="border:1px solid var(--border);border-radius:6px;padding:6px 8px;font-size:12px;">
                            <?php foreach (array_diff(B2B_PARTNER_USER_ROLES, ['Owner']) as $r): ?><option value="<?php echo htmlspecialchars($r); ?>" <?php echo $m['role'] === $r ? 'selected' : ''; ?>><?php echo htmlspecialchars($r); ?></option><?php endforeach; ?>
                        </select>
                        <select name="status" style="border:1px solid var(--border);border-radius:6px;padding:6px 8px;font-size:12px;">
                            <?php foreach (B2B_PARTNER_USER_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $m['status'] === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
                        </select>
                        <div class="pp-perm-grid" style="grid-template-columns:1fr;">
                            <?php foreach (B2B_PARTNER_PERMISSIONS as $key => $label): ?>
                            <label class="pp-perm-check" style="font-size:11.5px;"><input type="checkbox" name="permissions[]" value="<?php echo htmlspecialchars($key); ?>" <?php echo in_array($key, $memberPerms, true) ? 'checked' : ''; ?>> <?php echo htmlspecialchars($label); ?></label>
                            <?php endforeach; ?>
                        </div>
                        <button type="submit" class="pp-filter-btn is-ghost" style="width:auto;">Save Changes</button>
                    </form>
                </details>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
