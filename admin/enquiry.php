<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
require_once __DIR__ . '/../includes/countries-data.php';

$pdo = enquiry_db();
$ref = trim($_GET['ref'] ?? '');

$stmt = $pdo->prepare('SELECT * FROM enquiries WHERE enquiry_ref = ?');
$stmt->execute([$ref]);
$enquiry = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$enquiry) {
    http_response_code(404);
    echo 'Enquiry not found.';
    exit;
}
if (!admin_can_view_all() && $enquiry['assigned_to'] !== admin_name()) {
    http_response_code(403);
    echo 'You do not have access to this enquiry.';
    exit;
}

if (isset($_GET['archive'])) {
    $pdo->prepare('UPDATE enquiries SET archived_at = ? WHERE id = ?')->execute([gmdate('c'), $enquiry['id']]);
    crm_log_activity($pdo, $enquiry['id'], admin_name(), 'archived this enquiry');
    header('Location: enquiries.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'update_status') {
        $newStatus = trim($_POST['status'] ?? $enquiry['status']);
        $newPriority = trim($_POST['priority'] ?? $enquiry['priority']);
        $newAssigned = trim($_POST['assigned_to'] ?? '');
        $newConsultant = trim($_POST['visa_consultant'] ?? '');

        if ($newStatus !== $enquiry['status'] && in_array($newStatus, CRM_STATUSES, true)) {
            crm_log_activity($pdo, $enquiry['id'], admin_name(), "changed status from \"{$enquiry['status']}\" to \"$newStatus\"");
        }
        if ($newPriority !== $enquiry['priority']) {
            crm_log_activity($pdo, $enquiry['id'], admin_name(), "changed priority from \"{$enquiry['priority']}\" to \"$newPriority\"");
        }
        if ($newAssigned !== ($enquiry['assigned_to'] ?? '')) {
            crm_log_activity($pdo, $enquiry['id'], admin_name(), $newAssigned !== '' ? "reassigned to $newAssigned" : 'unassigned');
            if ($newAssigned !== '') {
                $u = $pdo->prepare('SELECT id FROM users WHERE name = ?');
                $u->execute([$newAssigned]);
                $uid = $u->fetchColumn();
                if ($uid) crm_notify($pdo, (int) $uid, 'assignment', "Enquiry {$enquiry['enquiry_ref']} assigned to you.", $enquiry['id']);
            }
        }

        $upd = $pdo->prepare('UPDATE enquiries SET status = ?, priority = ?, assigned_to = ?, visa_consultant = ?, updated_at = ? WHERE id = ?');
        $upd->execute([$newStatus, $newPriority, $newAssigned, $newConsultant, gmdate('c'), $enquiry['id']]);

    } elseif ($action === 'add_note' && trim($_POST['note'] ?? '') !== '') {
        $note = trim($_POST['note']);
        $pdo->prepare('INSERT INTO enquiry_notes (enquiry_id, note, created_by, created_at) VALUES (?, ?, ?, ?)')
            ->execute([$enquiry['id'], $note, admin_name(), gmdate('c')]);
        crm_log_activity($pdo, $enquiry['id'], admin_name(), 'added a note', $note);

    } elseif ($action === 'add_followup') {
        $fuDate = trim($_POST['follow_up_date'] ?? '');
        if ($fuDate !== '') {
            $pdo->prepare('INSERT INTO follow_ups (enquiry_id, follow_up_date, follow_up_time, type, reminder, assigned_to, notes, created_by, created_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')->execute([
                $enquiry['id'], $fuDate, trim($_POST['follow_up_time'] ?? ''), trim($_POST['type'] ?? 'Call'),
                isset($_POST['reminder']) ? 1 : 0, trim($_POST['fu_assigned_to'] ?? ''), trim($_POST['fu_notes'] ?? ''),
                admin_name(), gmdate('c'),
            ]);
            $pdo->prepare('UPDATE enquiries SET follow_up_date = ?, updated_at = ? WHERE id = ?')->execute([$fuDate, gmdate('c'), $enquiry['id']]);
            crm_log_activity($pdo, $enquiry['id'], admin_name(), "scheduled a follow-up for $fuDate");
        }

    } elseif ($action === 'complete_followup') {
        $fuId = (int) ($_POST['followup_id'] ?? 0);
        $pdo->prepare('UPDATE follow_ups SET completed_at = ? WHERE id = ? AND enquiry_id = ?')->execute([gmdate('c'), $fuId, $enquiry['id']]);
        crm_log_activity($pdo, $enquiry['id'], admin_name(), 'completed a follow-up');

    } elseif ($action === 'verify_document') {
        $docId = (int) ($_POST['doc_id'] ?? 0);
        $decision = trim($_POST['decision'] ?? '');
        if (in_array($decision, ['Verified', 'Rejected'], true)) {
            $pdo->prepare('UPDATE enquiry_documents SET status = ?, verified_by = ?, verified_at = ? WHERE id = ? AND enquiry_id = ?')
                ->execute([$decision, admin_name(), gmdate('c'), $docId, $enquiry['id']]);
            $docRow = $pdo->prepare('SELECT category FROM enquiry_documents WHERE id = ?');
            $docRow->execute([$docId]);
            $cat = $docRow->fetchColumn();
            crm_log_activity($pdo, $enquiry['id'], admin_name(), strtolower($decision) . " document: $cat");
        }

    } elseif ($action === 'upload_document') {
        $category = trim($_POST['category'] ?? 'Other Documents');
        if (!empty($_FILES['document']['name']) && $_FILES['document']['error'] === UPLOAD_ERR_OK) {
            $allowedExt = ['pdf', 'jpg', 'jpeg', 'png'];
            $allowedMime = ['application/pdf', 'image/jpeg', 'image/png'];
            $name = $_FILES['document']['name'];
            $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
            $finfo = new finfo(FILEINFO_MIME_TYPE);
            $mime = $finfo->file($_FILES['document']['tmp_name']) ?: '';
            if (in_array($ext, $allowedExt, true) && in_array($mime, $allowedMime, true) && $_FILES['document']['size'] <= 5 * 1024 * 1024) {
                $targetDir = __DIR__ . '/../uploads/enquiries/' . $enquiry['enquiry_ref'];
                if (!is_dir($targetDir)) mkdir($targetDir, 0770, true);
                $stored = bin2hex(random_bytes(10)) . '.' . $ext;
                if (move_uploaded_file($_FILES['document']['tmp_name'], $targetDir . '/' . $stored)) {
                    $pdo->prepare('INSERT INTO enquiry_documents (enquiry_id, category, original_filename, stored_filename, file_type, file_size, status, uploaded_at)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?)')->execute([$enquiry['id'], $category, $name, $stored, $mime, $_FILES['document']['size'], 'Uploaded', gmdate('c')]);
                    crm_log_activity($pdo, $enquiry['id'], admin_name(), "uploaded document: $category ($name)");
                }
            }
        }

    } elseif ($action === 'update_financial') {
        $quoted = $_POST['quoted_amount'] !== '' ? (float) $_POST['quoted_amount'] : null;
        $discount = $_POST['discount_amount'] !== '' ? (float) $_POST['discount_amount'] : null;
        $pdo->prepare('UPDATE enquiries SET quoted_amount = ?, discount_amount = ?, updated_at = ? WHERE id = ?')
            ->execute([$quoted, $discount, gmdate('c'), $enquiry['id']]);
        crm_log_activity($pdo, $enquiry['id'], admin_name(), 'updated quoted amount / discount');

    } elseif ($action === 'add_payment') {
        $amount = (float) ($_POST['amount'] ?? 0);
        $method = trim($_POST['payment_method'] ?? '');
        $reference = trim($_POST['reference_number'] ?? '');
        $payDate = trim($_POST['payment_date'] ?? gmdate('Y-m-d'));
        $notes = trim($_POST['payment_notes'] ?? '');
        if ($amount > 0) {
            $pdo->prepare('INSERT INTO payments (enquiry_id, amount, payment_method, reference_number, payment_date, notes, recorded_by, created_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)')->execute([$enquiry['id'], $amount, $method, $reference, $payDate, $notes, admin_name(), gmdate('c')]);
            $newPaid = (float) ($enquiry['paid_amount'] ?? 0) + $amount;
            $pdo->prepare('UPDATE enquiries SET paid_amount = ?, updated_at = ? WHERE id = ?')->execute([$newPaid, gmdate('c'), $enquiry['id']]);
            crm_log_activity($pdo, $enquiry['id'], admin_name(), 'recorded a payment', "₹" . number_format($amount, 2) . ($method ? " via $method" : ''));
            crm_notify($pdo, null, 'payment', "Payment of ₹" . number_format($amount, 2) . " recorded for {$enquiry['enquiry_ref']}.", $enquiry['id']);
        }

    } elseif ($action === 'update_application') {
        $decision = trim($_POST['decision'] ?? 'Pending');
        if (!in_array($decision, CRM_DECISIONS, true)) $decision = 'Pending';
        $newStatus = $enquiry['status'];
        if ($decision === 'Approved') $newStatus = 'Visa Approved';
        elseif ($decision === 'Rejected') $newStatus = 'Visa Rejected';

        $pdo->prepare('UPDATE enquiries SET application_number = ?, appointment_date = ?, submission_date = ?, decision_date = ?, decision = ?, status = ?, updated_at = ? WHERE id = ?')
            ->execute([
                trim($_POST['application_number'] ?? ''), trim($_POST['appointment_date'] ?? '') ?: null,
                trim($_POST['submission_date'] ?? '') ?: null, trim($_POST['decision_date'] ?? '') ?: null,
                $decision, $newStatus, gmdate('c'), $enquiry['id'],
            ]);
        crm_log_activity($pdo, $enquiry['id'], admin_name(), 'updated application tracking details');
        if ($decision !== ($enquiry['decision'] ?: 'Pending') && $decision !== 'Pending') {
            crm_log_activity($pdo, $enquiry['id'], admin_name(), "recorded visa decision: $decision");
            crm_notify($pdo, null, 'decision', "Visa decision for {$enquiry['enquiry_ref']}: $decision.", $enquiry['id']);
        }
    }

    header('Location: enquiry.php?ref=' . urlencode($ref) . (isset($_POST['redirect_hash']) ? '#' . $_POST['redirect_hash'] : ''));
    exit;
}

$stmt = $pdo->prepare('SELECT * FROM enquiries WHERE id = ?');
$stmt->execute([$enquiry['id']]);
$enquiry = $stmt->fetch(PDO::FETCH_ASSOC);

$docStmt = $pdo->prepare('SELECT * FROM enquiry_documents WHERE enquiry_id = ? ORDER BY uploaded_at DESC');
$docStmt->execute([$enquiry['id']]);
$documents = $docStmt->fetchAll(PDO::FETCH_ASSOC);
$docVerifiedCount = count(array_filter($documents, fn($d) => $d['status'] === 'Verified'));

$fuStmt = $pdo->prepare('SELECT * FROM follow_ups WHERE enquiry_id = ? ORDER BY follow_up_date ASC, id ASC');
$fuStmt->execute([$enquiry['id']]);
$followUps = $fuStmt->fetchAll(PDO::FETCH_ASSOC);

$actStmt = $pdo->prepare('SELECT * FROM activities WHERE enquiry_id = ? ORDER BY created_at DESC, id DESC LIMIT 60');
$actStmt->execute([$enquiry['id']]);
$activities = $actStmt->fetchAll(PDO::FETCH_ASSOC);

$crmUsers = $pdo->query('SELECT name, role FROM users ORDER BY name')->fetchAll(PDO::FETCH_ASSOC);

$payStmt = $pdo->prepare('SELECT * FROM payments WHERE enquiry_id = ? ORDER BY payment_date DESC, id DESC');
$payStmt->execute([$enquiry['id']]);
$payments = $payStmt->fetchAll(PDO::FETCH_ASSOC);

$ADMIN_PAGE_TITLE = $enquiry['enquiry_ref'];
$ADMIN_ACTIVE_NAV = 'enquiries';
$ADMIN_BREADCRUMB = ['CRM', 'Enquiries', $enquiry['enquiry_ref']];
require __DIR__ . '/includes/layout-top.php';

function fmt($v) { return ($v !== null && $v !== '') ? htmlspecialchars((string) $v) : '&mdash;'; }
?>
<a href="enquiries.php" style="font-size:12.5px;color:var(--c-text);display:inline-block;margin-bottom:14px;">&larr; Back to all enquiries</a>

<div class="crm-detail-header">
    <div class="ref"><?php echo htmlspecialchars($enquiry['enquiry_ref']); ?></div>
    <h1><?php echo htmlspecialchars($enquiry['full_name']); ?></h1>
    <div class="sub"><?php echo htmlspecialchars($enquiry['destination_country']); ?> &middot; <?php echo htmlspecialchars($enquiry['visa_type']); ?></div>
    <div class="crm-detail-badges">
        <span class="crm-status-badge <?php echo crm_status_class($enquiry['status']); ?>"><?php echo htmlspecialchars($enquiry['status']); ?></span>
        <span class="crm-priority-badge priority-<?php echo strtolower($enquiry['priority']); ?>"><?php echo htmlspecialchars($enquiry['priority']); ?> Priority</span>
        <?php if ($enquiry['assigned_to']): ?><span class="crm-status-badge status-new" style="background:rgba(255,255,255,0.15);color:#fff;">Assigned: <?php echo htmlspecialchars($enquiry['assigned_to']); ?></span><?php endif; ?>
    </div>
    <div class="crm-quick-actions">
        <a class="crm-btn" href="tel:<?php echo htmlspecialchars($enquiry['mobile']); ?>"><i class="fa-solid fa-phone"></i> Call</a>
        <a class="crm-btn" href="https://wa.me/<?php echo preg_replace('/\D/', '', $enquiry['mobile']); ?>" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
        <a class="crm-btn" href="mailto:<?php echo htmlspecialchars($enquiry['email']); ?>"><i class="fa-solid fa-envelope"></i> Email</a>
        <a class="crm-btn" href="#followup"><i class="fa-solid fa-phone-volume"></i> Add Follow-up</a>
        <a class="crm-btn" href="#documents"><i class="fa-solid fa-upload"></i> Upload Document</a>
        <a class="crm-btn" href="#status"><i class="fa-solid fa-pen"></i> Change Status</a>
        <a class="crm-btn" href="#application"><i class="fa-solid fa-passport"></i> Create Application</a>
        <a class="crm-btn" href="#financial"><i class="fa-solid fa-money-bill-wave"></i> Add Payment</a>
        <a class="crm-btn" href="enquiry.php?ref=<?php echo urlencode($ref); ?>&archive=1" data-confirm="Archive this enquiry? It will be hidden from active lists."><i class="fa-solid fa-box-archive"></i> Archive</a>
    </div>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Customer Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Full Name</label><div class="val"><?php echo fmt($enquiry['full_name']); ?></div></div>
            <div class="crm-panel-item"><label>Email</label><div class="val"><?php echo fmt($enquiry['email']); ?></div></div>
            <div class="crm-panel-item"><label>Mobile</label><div class="val"><?php echo fmt($enquiry['mobile']); ?></div></div>
            <div class="crm-panel-item"><label>WhatsApp</label><div class="val"><?php echo fmt($enquiry['whatsapp_number']); ?></div></div>
            <div class="crm-panel-item"><label>Nationality</label><div class="val"><?php echo fmt($enquiry['nationality']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fmt($enquiry['passport_number']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Expiry</label><div class="val"><?php echo fmt($enquiry['passport_expiry']); ?></div></div>
            <div class="crm-panel-item"><label>Country of Residence</label><div class="val"><?php echo fmt($enquiry['country_residence']); ?></div></div>
        </div>
    </div>
    <div class="crm-card">
        <h3>Travel Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Destination</label><div class="val"><?php echo fmt($enquiry['destination_country']); ?></div></div>
            <div class="crm-panel-item"><label>Visa Category</label><div class="val"><?php echo fmt($enquiry['visa_category']); ?></div></div>
            <div class="crm-panel-item"><label>Visa Type</label><div class="val"><?php echo fmt($enquiry['visa_type']); ?></div></div>
            <div class="crm-panel-item"><label>Travel Date</label><div class="val"><?php echo fmt($enquiry['travel_date']); ?></div></div>
            <div class="crm-panel-item"><label>Stay Duration</label><div class="val"><?php echo fmt($enquiry['expected_stay_duration']); ?></div></div>
            <div class="crm-panel-item"><label>Travellers</label><div class="val"><?php echo fmt((string) $enquiry['travellers']); ?></div></div>
            <div class="crm-panel-item"><label>Purpose</label><div class="val"><?php echo fmt($enquiry['purpose']); ?></div></div>
            <div class="crm-panel-item"><label>Source Page</label><div class="val"><?php echo fmt($enquiry['source_url']); ?></div></div>
        </div>
    </div>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Lead Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Source</label><div class="val"><?php echo fmt($enquiry['source']); ?></div></div>
            <div class="crm-panel-item"><label>Campaign</label><div class="val"><?php echo fmt($enquiry['campaign']); ?></div></div>
            <div class="crm-panel-item"><label>Assigned To</label><div class="val"><?php echo fmt($enquiry['assigned_to']); ?></div></div>
            <div class="crm-panel-item"><label>Visa Consultant</label><div class="val"><?php echo fmt($enquiry['visa_consultant']); ?></div></div>
            <div class="crm-panel-item"><label>Conversion Probability</label><div class="val"><?php echo $enquiry['conversion_probability'] !== null ? $enquiry['conversion_probability'] . '%' : '&mdash;'; ?></div></div>
            <div class="crm-panel-item"><label>Created</label><div class="val"><?php echo fmt(substr($enquiry['created_at'], 0, 16)); ?> UTC</div></div>
        </div>
    </div>
    <div class="crm-card" id="financial">
        <h3>Financial Information</h3>
        <form method="post">
            <input type="hidden" name="action" value="update_financial">
            <div class="crm-panel-grid" style="margin-bottom:14px;">
                <div class="crm-form-field"><label>Quoted Amount (₹)</label><input type="number" name="quoted_amount" value="<?php echo htmlspecialchars((string) ($enquiry['quoted_amount'] ?? '')); ?>"></div>
                <div class="crm-form-field"><label>Discount (₹)</label><input type="number" name="discount_amount" value="<?php echo htmlspecialchars((string) ($enquiry['discount_amount'] ?? '')); ?>"></div>
                <div class="crm-panel-item"><label>Paid to Date</label><div class="val">₹<?php echo number_format((float) ($enquiry['paid_amount'] ?? 0), 2); ?></div></div>
                <div class="crm-panel-item"><label>Balance Due</label><div class="val">₹<?php echo number_format(max(0, (float) ($enquiry['quoted_amount'] ?? 0) - (float) ($enquiry['discount_amount'] ?? 0) - (float) ($enquiry['paid_amount'] ?? 0)), 2); ?></div></div>
            </div>
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Save Quoted / Discount</button>
        </form>

        <?php if (!empty($payments)): ?>
        <div style="margin-top:18px;">
            <?php foreach ($payments as $p): ?>
            <div class="crm-followup-item">
                <span class="fu-when" style="width:100px;">₹<?php echo number_format((float) $p['amount'], 2); ?></span>
                <span class="fu-notes"><?php echo htmlspecialchars($p['payment_date']); ?> &middot; <?php echo htmlspecialchars($p['payment_method'] ?: '—'); ?></span>
                <a href="invoice.php?payment_id=<?php echo (int) $p['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-invoice"></i> Invoice</a>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <form method="post" style="margin-top:14px;border-top:1px solid var(--c-border);padding-top:14px;">
            <input type="hidden" name="action" value="add_payment">
            <div class="crm-form-grid" style="margin-bottom:12px;">
                <div class="crm-form-field"><label>Amount (₹)</label><input type="number" name="amount" min="1" step="0.01" required></div>
                <div class="crm-form-field"><label>Payment Date</label><input type="date" name="payment_date" value="<?php echo gmdate('Y-m-d'); ?>" required></div>
                <div class="crm-form-field"><label>Method</label>
                    <select name="payment_method"><?php foreach (CRM_PAYMENT_METHODS as $m): ?><option><?php echo $m; ?></option><?php endforeach; ?></select>
                </div>
                <div class="crm-form-field"><label>Reference Number</label><input type="text" name="reference_number"></div>
                <div class="crm-form-field crm-form-field-full"><label>Notes</label><input type="text" name="payment_notes"></div>
            </div>
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm"><i class="fa-solid fa-plus"></i> Record Payment</button>
        </form>
    </div>
</div>

<div class="crm-card" id="application">
    <h3>Application Information</h3>
    <form method="post">
        <input type="hidden" name="action" value="update_application">
        <div class="crm-form-grid" style="margin-bottom:14px;">
            <div class="crm-form-field"><label>Application Number</label><input type="text" name="application_number" value="<?php echo htmlspecialchars($enquiry['application_number'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Appointment Date</label><input type="date" name="appointment_date" value="<?php echo htmlspecialchars($enquiry['appointment_date'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Submission Date</label><input type="date" name="submission_date" value="<?php echo htmlspecialchars($enquiry['submission_date'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Decision Date</label><input type="date" name="decision_date" value="<?php echo htmlspecialchars($enquiry['decision_date'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Decision</label>
                <select name="decision"><?php foreach (CRM_DECISIONS as $d): ?><option <?php echo ($enquiry['decision'] ?: 'Pending') === $d ? 'selected' : ''; ?>><?php echo $d; ?></option><?php endforeach; ?></select>
            </div>
        </div>
        <p style="font-size:11.5px;color:var(--c-muted);margin:-6px 0 14px;">Setting the decision to Approved or Rejected also updates the enquiry status and notifies the team.</p>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Save Application Details</button>
    </form>
</div>

<div class="crm-card" id="status">
    <h3>Status &amp; Assignment</h3>
    <form method="post">
        <input type="hidden" name="action" value="update_status">
        <div class="crm-form-grid" style="margin-bottom:14px;">
            <div class="crm-form-field"><label>Status</label>
                <select name="status"><?php foreach (CRM_STATUSES as $s): ?><option <?php echo $enquiry['status'] === $s ? 'selected' : ''; ?>><?php echo $s; ?></option><?php endforeach; ?></select>
            </div>
            <div class="crm-form-field"><label>Priority</label>
                <select name="priority"><?php foreach (CRM_PRIORITIES as $p): ?><option <?php echo $enquiry['priority'] === $p ? 'selected' : ''; ?>><?php echo $p; ?></option><?php endforeach; ?></select>
            </div>
            <div class="crm-form-field"><label>Assigned To</label>
                <select name="assigned_to"><option value="">Unassigned</option><?php foreach ($crmUsers as $u): ?><option <?php echo $enquiry['assigned_to'] === $u['name'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
            </div>
            <div class="crm-form-field"><label>Visa Consultant</label>
                <select name="visa_consultant"><option value="">Unassigned</option><?php foreach ($crmUsers as $u): ?><option <?php echo $enquiry['visa_consultant'] === $u['name'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
            </div>
        </div>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Save</button>
    </form>
</div>

<div class="crm-card" id="documents">
    <h3>Documents <span style="font-weight:400;color:var(--c-muted);font-size:12.5px;">(<?php echo $docVerifiedCount; ?>/<?php echo count($documents); ?> verified)</span></h3>
    <?php if (empty($documents)): ?>
    <div class="crm-empty">No documents uploaded yet.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>File</th><th>Category</th><th>Size</th><th>Status</th><th>Uploaded</th><th>Actions</th></tr></thead>
        <tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><a href="document.php?id=<?php echo (int) $doc['id']; ?>"><?php echo htmlspecialchars($doc['original_filename']); ?></a></td>
            <td><?php echo htmlspecialchars($doc['category']); ?></td>
            <td><?php echo round($doc['file_size'] / 1024); ?> KB</td>
            <td><span class="crm-doc-status doc-<?php echo strtolower($doc['status']); ?>"><?php echo htmlspecialchars($doc['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo substr($doc['uploaded_at'], 0, 10); ?></td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="verify_document">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $doc['id']; ?>">
                    <input type="hidden" name="decision" value="Verified">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" title="Verify"><i class="fa-solid fa-check" style="color:var(--c-green);"></i></button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="verify_document">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $doc['id']; ?>">
                    <input type="hidden" name="decision" value="Rejected">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" title="Reject"><i class="fa-solid fa-xmark" style="color:var(--c-red);"></i></button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>

    <form method="post" enctype="multipart/form-data" style="margin-top:16px;display:flex;gap:10px;flex-wrap:wrap;align-items:center;">
        <input type="hidden" name="action" value="upload_document">
        <select name="category" style="padding:8px 12px;border:1px solid var(--c-border);border-radius:8px;font-size:12.5px;">
            <?php foreach (CRM_DOC_CATEGORIES as $c): ?><option><?php echo $c; ?></option><?php endforeach; ?>
        </select>
        <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm"><i class="fa-solid fa-upload"></i> Upload</button>
    </form>
</div>

<div class="crm-card" id="followup">
    <h3>Follow-up Management</h3>
    <?php if (!empty($followUps)): ?>
    <?php foreach ($followUps as $fu): $state = crm_followup_state($fu['follow_up_date'], $fu['completed_at']); ?>
    <div class="crm-followup-item">
        <span class="fu-when"><?php echo htmlspecialchars($fu['follow_up_date']); ?> <?php echo htmlspecialchars($fu['follow_up_time']); ?></span>
        <span class="fu-type"><i class="fa-solid fa-<?php echo $fu['type'] === 'WhatsApp' ? 'brands fa-whatsapp' : ($fu['type'] === 'Call' ? 'phone' : ($fu['type'] === 'Email' ? 'envelope' : 'people-arrows')); ?>"></i> <?php echo htmlspecialchars($fu['type']); ?></span>
        <span class="fu-notes"><?php echo htmlspecialchars($fu['notes']); ?></span>
        <span class="crm-fu-state state-<?php echo strtolower(str_replace(' ', '-', $state)); ?>"><?php echo $state; ?></span>
        <?php if ($state !== 'Completed'): ?>
        <form method="post" style="display:inline;">
            <input type="hidden" name="action" value="complete_followup">
            <input type="hidden" name="followup_id" value="<?php echo (int) $fu['id']; ?>">
            <button type="submit" class="crm-followup-complete-btn" title="Mark completed"><i class="fa-solid fa-circle-check"></i></button>
        </form>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
    <?php else: ?>
    <div class="crm-empty">No follow-ups scheduled yet.</div>
    <?php endif; ?>

    <form method="post" style="margin-top:16px;">
        <input type="hidden" name="action" value="add_followup">
        <input type="hidden" name="redirect_hash" value="followup">
        <div class="crm-form-grid" style="margin-bottom:12px;">
            <div class="crm-form-field"><label>Follow-up Date</label><input type="date" name="follow_up_date" required></div>
            <div class="crm-form-field"><label>Follow-up Time</label><input type="time" name="follow_up_time"></div>
            <div class="crm-form-field"><label>Type</label>
                <select name="type"><?php foreach (CRM_FOLLOWUP_TYPES as $t): ?><option><?php echo $t; ?></option><?php endforeach; ?></select>
            </div>
            <div class="crm-form-field"><label>Assigned Employee</label>
                <select name="fu_assigned_to"><option value="">Unassigned</option><?php foreach ($crmUsers as $u): ?><option><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
            </div>
            <div class="crm-form-field crm-form-field-full"><label>Notes</label><input type="text" name="fu_notes"></div>
            <div class="crm-form-field"><label style="display:flex;align-items:center;gap:6px;font-weight:400;"><input type="checkbox" name="reminder" style="width:auto;"> Set reminder</label></div>
        </div>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Add Follow-up</button>
    </form>
</div>

<div class="crm-card">
    <h3>Activity Timeline</h3>
    <div class="crm-timeline">
        <?php foreach ($activities as $act): ?>
        <div class="crm-timeline-item">
            <div class="crm-timeline-dot"></div>
            <div class="crm-timeline-body">
                <div class="crm-timeline-action"><b><?php echo htmlspecialchars($act['user_name']); ?></b> <?php echo htmlspecialchars($act['action']); ?>.</div>
                <?php if (!empty($act['notes'])): ?><div class="crm-timeline-notes"><?php echo nl2br(htmlspecialchars($act['notes'])); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo date('d M Y — h:i A', strtotime($act['created_at'])); ?></div>
            </div>
        </div>
        <?php endforeach; ?>
        <?php if (empty($activities)): ?><div class="crm-empty">No activity recorded yet.</div><?php endif; ?>
    </div>
</div>

<div class="crm-card">
    <h3>Notes</h3>
    <?php
    $noteStmt = $pdo->prepare('SELECT * FROM enquiry_notes WHERE enquiry_id = ? ORDER BY created_at DESC');
    $noteStmt->execute([$enquiry['id']]);
    $notes = $noteStmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    <?php foreach ($notes as $note): ?>
    <div style="background:var(--c-bg);border-radius:8px;padding:10px 12px;font-size:13px;margin-bottom:8px;">
        <div style="color:var(--c-muted);font-size:11px;margin-bottom:4px;"><?php echo htmlspecialchars($note['created_by']); ?> &middot; <?php echo substr($note['created_at'], 0, 16); ?> UTC</div>
        <?php echo nl2br(htmlspecialchars($note['note'])); ?>
    </div>
    <?php endforeach; ?>
    <?php if (empty($notes)): ?><div class="crm-empty">No notes yet.</div><?php endif; ?>
    <form method="post" style="margin-top:12px;">
        <input type="hidden" name="action" value="add_note">
        <textarea name="note" rows="3" placeholder="Add a note about this enquiry..." required style="width:100%;padding:10px;border:1px solid var(--c-border);border-radius:8px;font-size:13px;margin-bottom:10px;"></textarea>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Add Note</button>
    </form>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
