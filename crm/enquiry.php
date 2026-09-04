<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/auth.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
$pdo = db();

$id = (int) ($_GET['id'] ?? 0);
$stmt = $pdo->prepare(
    'SELECT e.*, c.name AS customer_name, c.email AS customer_email, c.mobile AS customer_mobile, c.nationality, c.passport_number, c.source AS customer_source
     FROM enquiries e JOIN customers c ON c.id = e.customer_id WHERE e.id = ?'
);
$stmt->execute([$id]);
$enquiry = $stmt->fetch();

$scopedTypes = crm_visible_service_types($user['role_slug']);
if (!$enquiry || ($scopedTypes && !in_array($enquiry['service_type'], $scopedTypes, true))) {
    http_response_code(404);
    $pageTitle = 'Not found';
    require __DIR__ . '/includes/layout-top.php';
    echo '<div class="crm-panel"><p>Enquiry not found, or you do not have access to it.</p></div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$detailTables = [
    'visa' => 'visa_enquiries', 'hotel' => 'hotel_enquiries', 'flight' => 'flight_enquiries',
    'tour' => 'tour_enquiries', 'insurance' => 'insurance_enquiries', 'forex' => 'forex_enquiries', 'general' => 'general_enquiries',
];
$detailTable = $detailTables[$enquiry['service_type']] ?? null;
$detail = [];
if ($detailTable) {
    $ds = $pdo->prepare("SELECT * FROM $detailTable WHERE enquiry_id = ?");
    $ds->execute([$id]);
    $detail = $ds->fetch() ?: [];
}

$flash = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && csrf_verify($_POST['csrf_token'] ?? null)) {
    $action = $_POST['action'] ?? '';

    if ($action === 'update_status') {
        $pdo->prepare('UPDATE enquiries SET status = ?, priority = ?, assigned_to = ?, updated_by = ?, updated_at = datetime(\'now\') WHERE id = ?')
            ->execute([$_POST['status'], $_POST['priority'], $_POST['assigned_to'] ?: null, $user['name'], $id]);

        if ($enquiry['service_type'] === 'visa' && isset($_POST['application_status'])) {
            $pdo->prepare('UPDATE visa_enquiries SET application_status = ?, payment_status = ? WHERE enquiry_id = ?')
                ->execute([$_POST['application_status'], $_POST['payment_status'] ?? 'Pending', $id]);
        }

        crm_audit_log('update_status', 'enquiry', $id, ['status' => $_POST['status']]);
        $flash = 'Enquiry updated.';
    } elseif ($action === 'add_note' && trim($_POST['note'] ?? '') !== '') {
        $stamp = '[' . date('d M Y H:i') . ' — ' . $user['name'] . '] ' . trim($_POST['note']);
        $newNotes = trim(($enquiry['notes'] ?? '') . "\n" . $stamp);
        $pdo->prepare('UPDATE enquiries SET notes = ? WHERE id = ?')->execute([$newNotes, $id]);
        crm_audit_log('add_note', 'enquiry', $id);
        $flash = 'Note added.';
    } elseif ($action === 'add_followup' && !empty($_POST['follow_up_date'])) {
        $pdo->prepare('INSERT INTO followups (enquiry_id, follow_up_date, notes, status, assigned_to) VALUES (?, ?, ?, ?, ?)')
            ->execute([$id, $_POST['follow_up_date'], trim($_POST['followup_notes'] ?? ''), 'Pending', $user['id']]);
        crm_audit_log('add_followup', 'enquiry', $id);
        $flash = 'Follow-up scheduled.';
    } elseif ($action === 'complete_followup' && !empty($_POST['followup_id'])) {
        $pdo->prepare('UPDATE followups SET status = ? WHERE id = ? AND enquiry_id = ?')->execute(['Done', $_POST['followup_id'], $id]);
        crm_audit_log('complete_followup', 'followup', (int) $_POST['followup_id']);
        $flash = 'Follow-up marked done.';
    }

    // Re-fetch after mutation.
    $stmt->execute([$id]);
    $enquiry = $stmt->fetch();
    if ($detailTable) {
        $ds->execute([$id]);
        $detail = $ds->fetch() ?: [];
    }
}

$usersStmt = $pdo->query('SELECT id, name, role_id FROM users WHERE status = "active" ORDER BY name');
$allUsers = $usersStmt->fetchAll();

$followupsStmt = $pdo->prepare('SELECT f.*, u.name AS assigned_name FROM followups f LEFT JOIN users u ON u.id = f.assigned_to WHERE enquiry_id = ? ORDER BY follow_up_date DESC');
$followupsStmt->execute([$id]);
$followups = $followupsStmt->fetchAll();

$visaStatuses = ['New', 'Contacted', 'Documents Pending', 'Documents Received', 'Application Prepared', 'Appointment Pending', 'Submitted', 'Under Processing', 'Approved', 'Rejected', 'Closed'];

$pageTitle = $enquiry['reference_no'];
$crmActive = 'enquiries';
require __DIR__ . '/includes/layout-top.php';
?>

<?php if ($flash): ?><div class="alert alert-success"><?= e($flash) ?></div><?php endif; ?>

<div class="grid-2" style="align-items:start;grid-template-columns:1.6fr 1fr">
    <div>
        <div class="crm-panel">
            <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px">
                <div>
                    <span class="eyebrow" style="text-transform:capitalize"><?= e($enquiry['service_type']) ?> Enquiry</span>
                    <h2 style="margin-top:8px"><?= e($enquiry['customer_name']) ?></h2>
                </div>
                <span class="status-badge status-<?= e(str_replace(' ', '-', $enquiry['status'])) ?>" style="font-size:13px"><?= e($enquiry['status']) ?></span>
            </div>
            <div class="grid-3" style="gap:14px">
                <div><p style="font-size:12px;color:var(--muted);margin:0">Email</p><p style="margin:4px 0 0;font-weight:600"><?= e($enquiry['customer_email'] ?: '—') ?></p></div>
                <div><p style="font-size:12px;color:var(--muted);margin:0">Mobile</p><p style="margin:4px 0 0;font-weight:600"><?= e($enquiry['customer_mobile'] ?: '—') ?></p></div>
                <div><p style="font-size:12px;color:var(--muted);margin:0">Source</p><p style="margin:4px 0 0;font-weight:600"><?= e($enquiry['source']) ?></p></div>
                <div><p style="font-size:12px;color:var(--muted);margin:0">Destination</p><p style="margin:4px 0 0;font-weight:600"><?= e($enquiry['destination'] ?: '—') ?></p></div>
                <div><p style="font-size:12px;color:var(--muted);margin:0">Travel Date</p><p style="margin:4px 0 0;font-weight:600"><?= e($enquiry['travel_date'] ?: '—') ?></p></div>
                <div><p style="font-size:12px;color:var(--muted);margin:0">Created</p><p style="margin:4px 0 0;font-weight:600"><?= e(date('d M Y, H:i', strtotime($enquiry['created_at']))) ?></p></div>
            </div>
        </div>

        <?php if ($detail): ?>
        <div class="crm-panel">
            <h3>Service Details</h3>
            <div class="grid-3" style="gap:14px">
                <?php foreach ($detail as $key => $val): if ($key === 'enquiry_id' || $val === null || $val === '') continue; ?>
                <div><p style="font-size:12px;color:var(--muted);margin:0;text-transform:capitalize"><?= e(str_replace('_', ' ', $key)) ?></p><p style="margin:4px 0 0;font-weight:600"><?= e((string) $val) ?></p></div>
                <?php endforeach; ?>
            </div>
        </div>
        <?php endif; ?>

        <div class="crm-panel">
            <h3>Notes</h3>
            <pre style="white-space:pre-wrap;font-family:inherit;font-size:13.5px;color:var(--navy-800);background:var(--bg);padding:14px;border-radius:10px;margin-bottom:14px;min-height:40px"><?= e($enquiry['notes'] ?: 'No notes yet.') ?></pre>
            <form method="post" action="<?= url('crm/enquiry.php?id=' . $id) ?>">
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <input type="hidden" name="action" value="add_note">
                <textarea class="form-control" name="note" rows="2" placeholder="Add an internal note..." required></textarea>
                <button type="submit" class="btn btn-primary" style="margin-top:10px;padding:9px 18px;font-size:13.5px">Add Note</button>
            </form>
        </div>

        <div class="crm-panel">
            <h3>Follow-ups</h3>
            <div style="display:flex;flex-direction:column;gap:10px;margin-bottom:16px">
                <?php foreach ($followups as $f): ?>
                <div style="display:flex;justify-content:space-between;align-items:center;padding:10px 14px;border:1px solid var(--border);border-radius:10px">
                    <div>
                        <strong style="font-size:13.5px"><?= e(date('d M Y', strtotime($f['follow_up_date']))) ?></strong>
                        <span style="font-size:13px;color:var(--muted);margin-left:8px"><?= e($f['notes'] ?: 'No notes') ?></span>
                    </div>
                    <?php if ($f['status'] === 'Pending'): ?>
                    <form method="post" action="<?= url('crm/enquiry.php?id=' . $id) ?>">
                        <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                        <input type="hidden" name="action" value="complete_followup">
                        <input type="hidden" name="followup_id" value="<?= (int) $f['id'] ?>">
                        <button type="submit" class="btn btn-ghost" style="padding:6px 12px;font-size:12px">Mark done</button>
                    </form>
                    <?php else: ?>
                    <span class="status-badge status-Converted">Done</span>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
                <?php if (!$followups): ?><p style="color:var(--muted);font-size:13.5px">No follow-ups scheduled.</p><?php endif; ?>
            </div>
            <form method="post" action="<?= url('crm/enquiry.php?id=' . $id) ?>" style="display:flex;gap:10px;flex-wrap:wrap;align-items:flex-end">
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <input type="hidden" name="action" value="add_followup">
                <div><label style="font-size:12px;color:var(--muted);display:block;margin-bottom:4px">Date</label><input class="form-control" type="date" name="follow_up_date" required></div>
                <div style="flex:1"><label style="font-size:12px;color:var(--muted);display:block;margin-bottom:4px">Notes</label><input class="form-control" type="text" name="followup_notes" placeholder="What's next?"></div>
                <button type="submit" class="btn btn-primary" style="padding:11px 18px;font-size:13.5px">Schedule</button>
            </form>
        </div>
    </div>

    <div>
        <div class="crm-panel">
            <h3>Update Status</h3>
            <form method="post" action="<?= url('crm/enquiry.php?id=' . $id) ?>">
                <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                <input type="hidden" name="action" value="update_status">

                <div class="form-row">
                    <label>Pipeline Status</label>
                    <select class="form-control" name="status">
                        <?php foreach (['New', 'Contacted', 'In Progress', 'Converted', 'Lost'] as $s): ?>
                        <option value="<?= e($s) ?>" <?= $enquiry['status'] === $s ? 'selected' : '' ?>><?= e($s) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <?php if ($enquiry['service_type'] === 'visa' && $detail): ?>
                <div class="form-row">
                    <label>Visa Application Status</label>
                    <select class="form-control" name="application_status">
                        <?php foreach ($visaStatuses as $s): ?>
                        <option value="<?= e($s) ?>" <?= ($detail['application_status'] ?? 'New') === $s ? 'selected' : '' ?>><?= e($s) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-row">
                    <label>Payment Status</label>
                    <select class="form-control" name="payment_status">
                        <?php foreach (['Pending', 'Partial', 'Paid'] as $s): ?>
                        <option value="<?= e($s) ?>" <?= ($detail['payment_status'] ?? 'Pending') === $s ? 'selected' : '' ?>><?= e($s) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <?php endif; ?>

                <div class="form-row">
                    <label>Priority</label>
                    <select class="form-control" name="priority">
                        <?php foreach (['High', 'Normal', 'Low'] as $p): ?>
                        <option value="<?= e($p) ?>" <?= $enquiry['priority'] === $p ? 'selected' : '' ?>><?= e($p) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="form-row">
                    <label>Assigned To</label>
                    <select class="form-control" name="assigned_to">
                        <option value="">Unassigned</option>
                        <?php foreach ($allUsers as $u): ?>
                        <option value="<?= (int) $u['id'] ?>" <?= (int) $enquiry['assigned_to'] === (int) $u['id'] ? 'selected' : '' ?>><?= e($u['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary btn-block">Save Changes</button>
            </form>
        </div>

        <div class="crm-panel">
            <h3>Reference</h3>
            <p style="font-family:var(--font-head);font-size:18px;font-weight:700;color:var(--navy-900);margin:0"><?= e($enquiry['reference_no']) ?></p>
            <p style="font-size:12.5px;color:var(--muted-soft);margin-top:6px">Last updated <?= e(date('d M Y, H:i', strtotime($enquiry['updated_at']))) ?><?= $enquiry['updated_by'] ? ' by ' . e($enquiry['updated_by']) : '' ?></p>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
