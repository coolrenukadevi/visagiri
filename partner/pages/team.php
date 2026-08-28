<?php
declare(strict_types=1);

/**
 * Team/sub-users — additional logins scoped to this same partner
 * account (includes/partner-auth.php's login already checks both
 * partners and partner_team_members). Only the owner (the primary
 * partners-table login, not a team_members row) can invite, remove,
 * or change a member's status — a manager or viewer can see the
 * roster but not touch it.
 */

$partner = current_partner();
$pdo = db();

if (!is_partner_active()) {
    redirect('/partner/dashboard/');
}

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    if (!current_partner_can_manage_team()) {
        http_response_code(403);
        exit('Only the account owner can manage the team.');
    }
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'invite') {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $email = trim((string) ($_POST['email'] ?? ''));
        $role = in_array($_POST['role'] ?? '', ['manager', 'viewer'], true) ? $_POST['role'] : 'viewer';

        if ($fullName === '') {
            $errors[] = 'Enter the team member\'s name.';
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Enter a valid email address.';
        }
        if (!$errors) {
            $existsStmt = $pdo->prepare('SELECT COUNT(*) FROM partner_team_members WHERE email = :email');
            $existsStmt->execute(['email' => $email]);
            if ((int) $existsStmt->fetchColumn() > 0 || strcasecmp($email, (string) $partner['email']) === 0) {
                $errors[] = 'That email is already part of a partner team.';
            }
        }

        if (!$errors) {
            $token = create_partner_team_invite((int) $partner['id'], $fullName, $email, $role, (int) $partner['id']);
            $inviteLink = APP_URL . '/partner/team-accept/?token=' . $token;
            $sent = send_mail(
                $email,
                'You\'ve been invited to ' . $partner['company_name'] . '\'s Visagiri partner team',
                '<p>Hi ' . e($fullName) . ',</p>'
                . '<p>' . e($partner['company_name']) . ' has invited you to join their Visagiri B2B partner account as a ' . e($role) . '.</p>'
                . '<p><a href="' . e($inviteLink) . '">' . e($inviteLink) . '</a></p>'
                . '<p>This invite link expires in 7 days.</p>',
                $fullName
            );
            if (!$sent && APP_DEBUG) {
                flash_set('partner_dev_invite_link', $inviteLink);
            }
            flash_set('notice', $sent ? "Invitation sent to $email." : "Invitation created for $email.");
            redirect('/partner/team/');
        }
    }

    if ($postAction === 'remove') {
        $memberId = (int) ($_POST['member_id'] ?? 0);
        $pdo->prepare('DELETE FROM partner_team_members WHERE id = :id AND partner_id = :partner_id')
            ->execute(['id' => $memberId, 'partner_id' => $partner['id']]);
        flash_set('notice', 'Team member removed.');
        redirect('/partner/team/');
    }

    if ($postAction === 'toggle_suspend') {
        $memberId = (int) ($_POST['member_id'] ?? 0);
        $memberStmt = $pdo->prepare('SELECT status FROM partner_team_members WHERE id = :id AND partner_id = :partner_id');
        $memberStmt->execute(['id' => $memberId, 'partner_id' => $partner['id']]);
        $currentStatus = $memberStmt->fetchColumn();
        if ($currentStatus === 'active' || $currentStatus === 'suspended') {
            $newStatus = $currentStatus === 'active' ? 'suspended' : 'active';
            $pdo->prepare('UPDATE partner_team_members SET status = :status WHERE id = :id')
                ->execute(['status' => $newStatus, 'id' => $memberId]);
            flash_set('notice', 'Team member ' . $newStatus . '.');
        }
        redirect('/partner/team/');
    }
}

$members = $pdo->prepare('SELECT * FROM partner_team_members WHERE partner_id = :id ORDER BY created_at ASC');
$members->execute(['id' => $partner['id']]);
$members = $members->fetchAll();

render_partner_start('team', 'Team');
?>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>
<?php $devLink = flash_get('partner_dev_invite_link'); if ($devLink): ?>
<div class="alert alert-warning">
    <strong>Development mode only</strong> (no email service is connected yet):<br>
    <a href="<?= e($devLink) ?>"><?= e($devLink) ?></a>
</div>
<?php endif; ?>

<table class="admin-table" style="margin-bottom:var(--space-6)">
    <thead><tr><th>Name</th><th>Email</th><th>Role</th><th>Status</th><th></th></tr></thead>
    <tbody>
        <tr>
            <td><?= e($partner['contact_name']) ?></td>
            <td><?= e($partner['email']) ?></td>
            <td>Owner</td>
            <td><span class="badge badge-success">Active</span></td>
            <td></td>
        </tr>
        <?php foreach ($members as $m): ?>
        <tr>
            <td><?= e($m['full_name']) ?></td>
            <td><?= e($m['email']) ?></td>
            <td><?= e(ucfirst($m['role'])) ?></td>
            <td><span class="badge <?= $m['status'] === 'active' ? 'badge-success' : ($m['status'] === 'suspended' ? 'badge-danger' : 'badge-warning') ?>"><?= e(ucfirst($m['status'])) ?></span></td>
            <td class="actions">
                <?php if (current_partner_can_manage_team()): ?>
                <?php if ($m['status'] !== 'invited'): ?>
                <form method="post" action="/partner/team/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle_suspend"><input type="hidden" name="member_id" value="<?= (int) $m['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm"><?= $m['status'] === 'active' ? 'Suspend' : 'Reactivate' ?></button>
                </form>
                <?php endif; ?>
                <form method="post" action="/partner/team/" style="display:inline" onsubmit="return confirm('Remove this team member? They will no longer be able to sign in.');"><?= csrf_field() ?><input type="hidden" name="action" value="remove"><input type="hidden" name="member_id" value="<?= (int) $m['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Remove</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php if (current_partner_can_manage_team()): ?>
<div class="admin-form-card" style="max-width:520px">
    <h2 class="country-directory__subheading" style="margin-top:0">Invite a Team Member</h2>
    <form method="post" action="/partner/team/">
        <?= csrf_field() ?><input type="hidden" name="action" value="invite">
        <div class="form-group">
            <label class="form-label" for="full_name">Name</label>
            <input class="form-input" type="text" id="full_name" name="full_name" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="email">Email</label>
            <input class="form-input" type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label class="form-label" for="role">Role</label>
            <select class="form-select" id="role" name="role">
                <option value="viewer">Viewer — can view applications and wallet, cannot make changes</option>
                <option value="manager">Manager — can also create applications</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Send Invitation</button>
    </form>
</div>
<?php else: ?>
<p style="color:var(--text-muted)">Only the account owner can invite or remove team members.</p>
<?php endif; ?>
<?php render_partner_end(); ?>
