<?php
declare(strict_types=1);

/**
 * Admin management of B2B Travel Partner Portal visa enquiries
 * (b2b_visa_enquiries) — Phase B6. Same list+detail+status-transition
 * pattern as admin/pages/b2b-partners.php, reusing its permission
 * namespace (b2b_travel_partners.view/.manage) since enquiry
 * management is a sub-resource of B2B partner management.
 */

require_permission('b2b_travel_partners.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

$enquiryStatusBadgeMap = [
    'new' => 'info', 'in_progress' => 'warning', 'documents_pending' => 'warning',
    'submitted' => 'info', 'payment_pending' => 'warning', 'completed' => 'success',
    'rejected' => 'danger', 'cancelled' => 'neutral',
];
$enquiryAllStatuses = array_keys(B2B_ENQUIRY_STATUS_LABELS);
$admins = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('b2b_travel_partners.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $targetId = (int) ($_POST['id'] ?? 0);

    $reasonRequiredActions = ['documents_required', 'reject', 'cancel'];
    $remarks = trim((string) ($_POST['remarks'] ?? '')) ?: null;
    if (in_array($postAction, $reasonRequiredActions, true) && $remarks === null) {
        flash_set('admin_error', 'A reason is required for this action.');
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    $statusActions = [
        'start_review' => 'in_progress',
        'documents_required' => 'documents_pending',
        'submit' => 'submitted',
        'payment_pending' => 'payment_pending',
        'complete' => 'completed',
        'reject' => 'rejected',
        'cancel' => 'cancelled',
    ];

    if (isset($statusActions[$postAction]) && $targetId) {
        b2b_change_enquiry_status($targetId, $statusActions[$postAction], current_admin_id(), null, $remarks);
        log_action('b2b_enquiry_' . $postAction, 'b2b_visa_enquiries', $targetId, null, $statusActions[$postAction]);
        flash_set('admin_notice', 'Status updated.');
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'verify_document' && $targetId) {
        $docId = (int) ($_POST['document_id'] ?? 0);
        $verifyStatus = $_POST['verify_status'] ?? '';
        if ($docId && in_array($verifyStatus, ['verified', 'rejected'], true)) {
            $docRemarks = trim((string) ($_POST['verification_remarks'] ?? '')) ?: null;
            $pdo->prepare(
                'UPDATE b2b_enquiry_documents SET verification_status = :status, verification_remarks = :remarks, reviewed_by = :admin, reviewed_at = NOW()
                 WHERE id = :id AND b2b_visa_enquiry_id = :enquiry_id'
            )->execute(['status' => $verifyStatus, 'remarks' => $docRemarks, 'admin' => current_admin_id(), 'id' => $docId, 'enquiry_id' => $targetId]);
            log_action('b2b_enquiry_document_verification', 'b2b_enquiry_documents', $docId, null, $verifyStatus);
            flash_set('admin_notice', 'Document ' . $verifyStatus . '.');
        }
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'assign_manager' && $targetId) {
        $newManagerId = ($_POST['assigned_admin_id'] ?? '') !== '' ? (int) $_POST['assigned_admin_id'] : null;
        $pdo->prepare('UPDATE b2b_visa_enquiries SET assigned_admin_id = :manager WHERE id = :id')
            ->execute(['manager' => $newManagerId, 'id' => $targetId]);
        log_action('assign_manager', 'b2b_visa_enquiries', $targetId, null, $newManagerId !== null ? (string) $newManagerId : 'unassigned');
        flash_set('admin_notice', 'Relationship Manager updated.');
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    redirect('/admin/b2b-enquiries/');
}

if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        "SELECT e.*, c.name AS country_name, p.legal_business_name, p.partner_reference_no, m.full_name AS manager_name,
                u.full_name AS created_by_name, u.email AS created_by_email
         FROM b2b_visa_enquiries e
         JOIN countries c ON c.id = e.destination_country_id
         JOIN b2b_partners p ON p.id = e.b2b_partner_id
         JOIN b2b_partner_users u ON u.id = e.created_by_user_id
         LEFT JOIN admin_users m ON m.id = e.assigned_admin_id
         WHERE e.id = :id AND e.deleted_at IS NULL"
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/b2b-enquiries/');
    }

    $applicantsStmt = $pdo->prepare('SELECT * FROM b2b_enquiry_applicants WHERE b2b_visa_enquiry_id = :id ORDER BY id ASC');
    $applicantsStmt->execute(['id' => $id]);
    $applicants = $applicantsStmt->fetchAll();

    $documentsStmt = $pdo->prepare('SELECT * FROM b2b_enquiry_documents WHERE b2b_visa_enquiry_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documentsStmt->execute(['id' => $id]);
    $documents = $documentsStmt->fetchAll();

    $historyStmt = $pdo->prepare(
        'SELECT h.*, a.full_name AS admin_name, u.full_name AS partner_user_name FROM b2b_enquiry_status_history h
         LEFT JOIN admin_users a ON a.id = h.changed_by_admin
         LEFT JOIN b2b_partner_users u ON u.id = h.changed_by_partner_user
         WHERE h.b2b_visa_enquiry_id = :id ORDER BY h.created_at DESC'
    );
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    $canManage = has_permission('b2b_travel_partners.manage');

    admin_header_start($enquiry['enquiry_reference_no'], 'b2b-enquiries');
    ?>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Partner:</strong> <a href="/admin/b2b-partners/?action=view&id=<?= (int) $enquiry['b2b_partner_id'] ?>"><?= e($enquiry['legal_business_name']) ?></a> (<?= e($enquiry['partner_reference_no']) ?>)</p>
        <p><strong>Submitted By:</strong> <?= e($enquiry['created_by_name']) ?> &middot; <?= e($enquiry['created_by_email']) ?></p>
        <p><strong>Destination:</strong> <?= e($enquiry['country_name']) ?> &middot; <strong>Visa Type:</strong> <?= e(B2B_VISA_SERVICES[$enquiry['visa_type']] ?? $enquiry['visa_type']) ?></p>
        <p><strong>Purpose:</strong> <?= e($enquiry['purpose_of_travel'] ?? '—') ?> &middot; <strong>Intended Travel Date:</strong> <?= $enquiry['intended_travel_date'] ? e(date('d M Y', strtotime((string) $enquiry['intended_travel_date']))) : '—' ?></p>
        <p><strong>Status:</strong> <?= status_badge((string) $enquiry['status'], $enquiryStatusBadgeMap) ?> &middot; <strong>Applicants:</strong> <?= (int) $enquiry['number_of_applicants'] ?></p>
        <?php if ($enquiry['special_requirements']): ?><p><strong>Notes:</strong> <?= e($enquiry['special_requirements']) ?></p><?php endif; ?>

        <?php if ($canManage): ?>
        <form method="post" action="/admin/b2b-enquiries/" style="margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
            <div class="form-group">
                <label class="form-label" for="remarks">Reason / Remarks <span style="color:var(--text-muted);font-weight:normal">(required for Request Documents, Reject, Cancel)</span></label>
                <textarea class="form-textarea" id="remarks" name="remarks" rows="2" style="width:100%;max-width:520px"></textarea>
            </div>
            <div style="display:flex;gap:var(--space-2);flex-wrap:wrap;margin-top:var(--space-2)">
                <?php if ($enquiry['status'] === 'new'): ?>
                    <button type="submit" name="action" value="start_review" class="btn btn-outline btn-sm">Start Review</button>
                <?php endif; ?>
                <?php if (in_array($enquiry['status'], ['new', 'in_progress'], true)): ?>
                    <button type="submit" name="action" value="documents_required" class="btn btn-outline btn-sm">Request Documents</button>
                    <button type="submit" name="action" value="submit" class="btn btn-primary btn-sm">Mark Submitted to Embassy</button>
                    <button type="submit" name="action" value="reject" class="btn btn-outline btn-sm">Reject</button>
                <?php elseif ($enquiry['status'] === 'documents_pending'): ?>
                    <button type="submit" name="action" value="start_review" class="btn btn-outline btn-sm">Resume Review</button>
                <?php elseif ($enquiry['status'] === 'submitted'): ?>
                    <button type="submit" name="action" value="payment_pending" class="btn btn-outline btn-sm">Payment Pending</button>
                    <button type="submit" name="action" value="complete" class="btn btn-primary btn-sm">Mark Completed</button>
                    <button type="submit" name="action" value="reject" class="btn btn-outline btn-sm">Reject</button>
                <?php elseif ($enquiry['status'] === 'payment_pending'): ?>
                    <button type="submit" name="action" value="complete" class="btn btn-primary btn-sm">Mark Completed</button>
                <?php endif; ?>
                <?php if (!in_array($enquiry['status'], ['completed', 'rejected', 'cancelled'], true)): ?>
                    <button type="submit" name="action" value="cancel" class="btn btn-outline btn-sm">Cancel</button>
                <?php endif; ?>
            </div>
        </form>
        <form method="post" action="/admin/b2b-enquiries/" style="display:flex;gap:var(--space-2);align-items:center;margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="assign_manager">
            <select name="assigned_admin_id" class="form-select">
                <option value="">Unassigned</option>
                <?php foreach ($admins as $a): ?>
                <option value="<?= (int) $a['id'] ?>"<?= (int) $a['id'] === (int) ($enquiry['assigned_admin_id'] ?? 0) ? ' selected' : '' ?>><?= e($a['full_name']) ?></option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn btn-outline btn-sm">Set Manager</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Applicants</h2>
    <table class="admin-table" style="margin-bottom:var(--space-6)"><thead><tr><th>Name</th><th>DOB</th><th>Nationality</th><th>Relationship</th></tr></thead><tbody>
        <?php foreach ($applicants as $a): ?>
        <tr>
            <td><?= e($a['full_name']) ?></td>
            <td><?= $a['date_of_birth'] ? e(date('d M Y', strtotime((string) $a['date_of_birth']))) : '—' ?></td>
            <td><?= e($a['nationality'] ?? '—') ?></td>
            <td><?= e(B2B_APPLICANT_RELATIONSHIPS[$a['relationship_to_lead']] ?? '—') ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>

    <h2 class="country-directory__subheading">Documents (<?= count($documents) ?>)</h2>
    <?php if (!$documents): ?>
    <p class="empty-state">No documents uploaded yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>Type</th><th>File</th><th>Verification</th><th>Remarks</th><th>Uploaded</th><th></th></tr></thead><tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><?= e(B2B_ENQUIRY_DOCUMENT_TYPES[$doc['document_type']] ?? $doc['document_type']) ?></td>
            <td><?= e($doc['original_filename']) ?></td>
            <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
            <td><?= e($doc['verification_remarks'] ?? '—') ?></td>
            <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
            <td class="actions">
                <a href="/admin/b2b-enquiry-document-download/?id=<?= (int) $doc['id'] ?>" class="btn btn-outline btn-sm">Download</a>
                <?php if ($canManage && $doc['verification_status'] !== 'verified'): ?>
                <form method="post" action="/admin/b2b-enquiries/" style="display:inline-flex;gap:var(--space-1);align-items:center">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="verify_document">
                    <input type="hidden" name="id" value="<?= $id ?>">
                    <input type="hidden" name="document_id" value="<?= (int) $doc['id'] ?>">
                    <input type="text" name="verification_remarks" placeholder="Remarks" style="width:120px">
                    <button type="submit" name="verify_status" value="verified" class="btn btn-outline btn-sm">Verify</button>
                    <button type="submit" name="verify_status" value="rejected" class="btn btn-outline btn-sm">Reject</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Status History</h2>
    <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>Reason</th><th>Changed By</th><th>When</th></tr></thead><tbody>
        <?php foreach ($history as $h): ?>
        <tr>
            <td><?= e($h['old_status'] !== null ? (B2B_ENQUIRY_STATUS_LABELS[$h['old_status']] ?? $h['old_status']) : '—') ?></td>
            <td><?= e(B2B_ENQUIRY_STATUS_LABELS[$h['new_status']] ?? $h['new_status']) ?></td>
            <td><?= e($h['reason'] ?? '—') ?></td>
            <td><?= e($h['admin_name'] ?? $h['partner_user_name'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>

    <p style="margin-top:var(--space-6)"><a href="/admin/b2b-enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = in_array($_GET['status'] ?? '', $enquiryAllStatuses, true) ? $_GET['status'] : null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['e.deleted_at IS NULL'];
$params = [];
if ($search !== '') {
    $where[] = '(e.enquiry_reference_no LIKE :search1 OR p.legal_business_name LIKE :search2)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $searchTerm;
}
if ($statusFilter) {
    $where[] = 'e.status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_visa_enquiries e JOIN b2b_partners p ON p.id = e.b2b_partner_id WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT e.*, c.name AS country_name, p.legal_business_name, m.full_name AS manager_name
     FROM b2b_visa_enquiries e
     JOIN countries c ON c.id = e.destination_country_id
     JOIN b2b_partners p ON p.id = e.b2b_partner_id
     LEFT JOIN admin_users m ON m.id = e.assigned_admin_id
     WHERE $whereSql ORDER BY (e.status = 'new') DESC, e.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

$newCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_visa_enquiries WHERE status = 'new' AND deleted_at IS NULL")->fetchColumn();

admin_header_start('B2B Visa Enquiries', 'b2b-enquiries');
?>
<?php if ($newCount > 0): ?>
<div class="alert alert-warning"><?= $newCount ?> new visa enquir<?= $newCount === 1 ? 'y' : 'ies' ?> awaiting review.</div>
<?php endif; ?>
<div class="admin-toolbar">
    <form method="get" action="/admin/b2b-enquiries/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search reference or partner business name…">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <?php foreach ($enquiryAllStatuses as $s): ?>
            <option value="<?= $s ?>"<?= $statusFilter === $s ? ' selected' : '' ?>><?= e(B2B_ENQUIRY_STATUS_LABELS[$s]) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Partner</th><th>Destination</th><th>Visa Type</th><th>Manager</th><th>Status</th><th>Created</th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $e): ?>
        <tr>
            <td><a href="/admin/b2b-enquiries/?action=view&id=<?= (int) $e['id'] ?>"><?= e($e['enquiry_reference_no']) ?></a></td>
            <td><?= e($e['legal_business_name']) ?></td>
            <td><?= e($e['country_name']) ?></td>
            <td><?= e(B2B_VISA_SERVICES[$e['visa_type']] ?? $e['visa_type']) ?></td>
            <td><?= e($e['manager_name'] ?? '—') ?></td>
            <td><?= status_badge((string) $e['status'], $enquiryStatusBadgeMap) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $e['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$enquiries): ?>
        <tr><td colspan="7"><p class="empty-state">No B2B visa enquiries found.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/b2b-enquiries/?page=<?= $p ?><?= $search !== '' ? '&q=' . urlencode($search) : '' ?><?= $statusFilter ? '&status=' . urlencode($statusFilter) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
