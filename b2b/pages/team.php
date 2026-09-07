<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Team management (Phase B9). Only
 * partner_admin can invite/remove/suspend (current_b2b_partner_can_manage_team());
 * every other role sees a read-only roster. A row with reset_token_hash
 * still set has never accepted its invite yet — shown as "Invited"
 * even though the underlying status column reads "active", since the
 * account has no usable password until the invite link is used.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();
$pdo = db();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    if (!current_b2b_partner_can_manage_team()) {
        http_response_code(403);
        exit('Only the account admin can manage the team.');
    }
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'invite') {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $email = trim((string) ($_POST['email'] ?? ''));
        $mobile = trim((string) ($_POST['mobile_number'] ?? ''));
        $designation = array_key_exists($_POST['designation'] ?? '', B2B_DESIGNATIONS) ? $_POST['designation'] : 'other';
        $role = in_array($_POST['role'] ?? '', ['partner_manager', 'partner_agent', 'partner_finance'], true) ? $_POST['role'] : 'partner_agent';

        $errors = [];
        if ($fullName === '') {
            $errors[] = 'Enter the team member\'s name.';
        }
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Enter a valid email address.';
        }
        if ($mobile === '') {
            $errors[] = 'Enter a mobile number.';
        }
        if (!$errors) {
            $existsStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_partner_users WHERE email = :email');
            $existsStmt->execute(['email' => $email]);
            if ((int) $existsStmt->fetchColumn() > 0) {
                $errors[] = 'That email is already registered to a B2B partner account.';
            }
        }

        if ($errors) {
            flash_set('b2b_error', implode(' ', $errors));
            redirect('/b2b/team/');
        }

        $token = b2b_create_user_invite((int) $partner['id'], $fullName, $designation, $email, $mobile, $role, (int) $user['id']);
        $inviteLink = APP_URL . '/b2b/team-accept/?token=' . $token;
        $sent = send_mail(
            $email,
            'You\'ve been invited to ' . $partner['legal_business_name'] . '\'s Visagiri B2B Travel Partner account',
            '<p>Hi ' . e($fullName) . ',</p><p>' . e($partner['legal_business_name']) . ' has invited you to join their Visagiri B2B Travel Partner Portal account as ' . e(B2B_ROLES[$role]) . '.</p><p><a href="' . e($inviteLink) . '">' . e($inviteLink) . '</a></p><p>This invite link expires in 7 days.</p>',
            $fullName
        );
        if (!$sent && APP_DEBUG) {
            flash_set('b2b_dev_invite_link', $inviteLink);
        }
        flash_set('b2b_notice', $sent ? "Invitation sent to $email." : "Invitation created for $email.");
        redirect('/b2b/team/');
    }

    if ($postAction === 'remove') {
        $memberId = (int) ($_POST['member_id'] ?? 0);
        if ($memberId === (int) $user['id']) {
            flash_set('b2b_error', 'You cannot remove your own account.');
            redirect('/b2b/team/');
        }
        $pdo->prepare('UPDATE b2b_partner_users SET deleted_at = NOW() WHERE id = :id AND b2b_partner_id = :partner_id')
            ->execute(['id' => $memberId, 'partner_id' => $partner['id']]);
        flash_set('b2b_notice', 'Team member removed.');
        redirect('/b2b/team/');
    }

    if ($postAction === 'toggle_suspend') {
        $memberId = (int) ($_POST['member_id'] ?? 0);
        if ($memberId === (int) $user['id']) {
            flash_set('b2b_error', 'You cannot suspend your own account.');
            redirect('/b2b/team/');
        }
        $memberStmt = $pdo->prepare('SELECT status FROM b2b_partner_users WHERE id = :id AND b2b_partner_id = :partner_id');
        $memberStmt->execute(['id' => $memberId, 'partner_id' => $partner['id']]);
        $currentStatus = $memberStmt->fetchColumn();
        if ($currentStatus === 'active' || $currentStatus === 'suspended') {
            $newStatus = $currentStatus === 'active' ? 'suspended' : 'active';
            $pdo->prepare('UPDATE b2b_partner_users SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $memberId]);
            flash_set('b2b_notice', 'Team member ' . $newStatus . '.');
        }
        redirect('/b2b/team/');
    }

    redirect('/b2b/team/');
}

$members = $pdo->prepare('SELECT * FROM b2b_partner_users WHERE b2b_partner_id = :id AND deleted_at IS NULL ORDER BY id ASC');
$members->execute(['id' => $partner['id']]);
$members = $members->fetchAll();

render_b2b_partner_start('team', 'Team');
$devLink = flash_get('b2b_dev_invite_link');
?>
<?php if ($devLink): ?>
<div class="alert alert-warning">
    <strong>Development mode only</strong> (no email service is connected yet):<br>
    <a href="<?= e($devLink) ?>"><?= e($devLink) ?></a>
</div>
<?php endif; ?>

<table class="admin-table" style="margin-bottom:var(--space-6)">
    <thead><tr><th>Name</th><th>Email</th><th>Role</th><th>Status</th><th></th></tr></thead>
    <tbody>
        <?php foreach ($members as $m): ?>
        <tr>
            <td><?= e($m['full_name']) ?><?= (int) $m['id'] === (int) $user['id'] ? ' (You)' : '' ?></td>
            <td><?= e($m['email']) ?></td>
            <td><?= e(B2B_ROLES[$m['role']] ?? $m['role']) ?></td>
            <td><?= $m['reset_token_hash'] !== null ? '<span class="badge badge-warning">Invited</span>' : ($m['status'] === 'active' ? '<span class="badge badge-success">Active</span>' : '<span class="badge badge-danger">Suspended</span>') ?></td>
            <td class="actions">
                <?php if (current_b2b_partner_can_manage_team() && (int) $m['id'] !== (int) $user['id']): ?>
                <?php if ($m['reset_token_hash'] === null): ?>
                <form method="post" action="/b2b/team/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle_suspend"><input type="hidden" name="member_id" value="<?= (int) $m['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm"><?= $m['status'] === 'active' ? 'Suspend' : 'Reactivate' ?></button>
                </form>
                <?php endif; ?>
                <form method="post" action="/b2b/team/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="remove"><input type="hidden" name="member_id" value="<?= (int) $m['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Remove</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php if (current_b2b_partner_can_manage_team()): ?>
<div class="admin-form-card" style="max-width:520px">
    <h2 class="country-directory__subheading" style="margin-top:0">Invite a Team Member</h2>
    <form method="post" action="/b2b/team/">
        <?= csrf_field() ?><input type="hidden" name="action" value="invite">
        <div class="form-group"><label class="form-label" for="full_name">Name</label><input class="form-input" type="text" id="full_name" name="full_name" required></div>
        <div class="form-group"><label class="form-label" for="email">Email</label><input class="form-input" type="email" id="email" name="email" required></div>
        <div class="form-group"><label class="form-label" for="mobile_number">Mobile Number</label><input class="form-input" type="text" id="mobile_number" name="mobile_number" required></div>
        <div class="form-group">
            <label class="form-label" for="designation">Designation</label>
            <select class="form-select" id="designation" name="designation">
                <?php foreach (B2B_DESIGNATIONS as $key => $label): ?>
                <option value="<?= e($key) ?>"><?= e($label) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="form-group">
            <label class="form-label" for="role">Role</label>
            <select class="form-select" id="role" name="role">
                <option value="partner_manager">Partner Manager — manage enquiries and team visibility</option>
                <option value="partner_agent">Partner Agent — create and manage visa enquiries</option>
                <option value="partner_finance">Partner Finance — view billing, accept/decline quotations</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Send Invitation</button>
    </form>
</div>
<?php else: ?>
<p style="color:var(--text-muted)">Only the account admin can invite, suspend, or remove team members.</p>
<?php endif; ?>
<?php render_b2b_partner_end(); ?>
