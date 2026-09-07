<?php
declare(strict_types=1);

/**
 * Admin CRM for the unified Visa + Apostille enquiry system
 * (includes/enquiry.php, pages/enquire.php). Mirrors the existing
 * visa-enquiries.php / general-enquiries.php pattern (list + detail,
 * status/priority/assignment update, scoped-to-assigned for visa
 * consultants) plus the document review workflow every enquiry now
 * carries with it.
 */

require_permission('enquiries.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$scopedToAssigned = current_admin_scoped_to_assigned();
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();
$statuses = enquiry_internal_statuses();
$statusBadgeMap = ['new_enquiry' => 'info', 'under_review' => 'warning', 'documents_pending' => 'warning', 'documents_verified' => 'info', 'processing' => 'info', 'additional_info_required' => 'warning', 'application_submitted' => 'success', 'completed' => 'success', 'closed' => 'neutral'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('enquiries.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $postId = (int) ($_POST['id'] ?? 0);

    if ($postAction === 'update' && $postId) {
        $before = $pdo->prepare('SELECT status, priority, assigned_user FROM enquiries WHERE id = :id AND deleted_at IS NULL');
        $before->execute(['id' => $postId]);
        $prev = $before->fetch();

        if ($prev) {
            $newStatus = $_POST['status'] ?? '';
            $newPriority = in_array($_POST['priority'] ?? '', ['low', 'normal', 'high', 'urgent'], true) ? $_POST['priority'] : 'normal';
            $assignedUser = (int) ($_POST['assigned_user'] ?? 0) ?: null;
            $remarks = trim((string) ($_POST['status_remarks'] ?? '')) ?: null;

            if (array_key_exists($newStatus, $statuses)) {
                change_enquiry_status($postId, $newStatus, current_admin_id(), $remarks);
            }
            $pdo->prepare('UPDATE enquiries SET priority = :priority, assigned_user = :assigned WHERE id = :id')
                ->execute(['priority' => $newPriority, 'assigned' => $assignedUser, 'id' => $postId]);

            if ($prev['priority'] !== $newPriority) {
                log_action('update', 'enquiries', $postId, $prev['priority'], $newPriority);
            }
            if ((int) ($prev['assigned_user'] ?? 0) !== ($assignedUser ?? 0)) {
                log_action('assignment', 'enquiries', $postId, (string) $prev['assigned_user'], (string) $assignedUser);
            }
            flash_set('admin_notice', 'Enquiry updated.');
        }
        redirect('/admin/enquiries/?id=' . $postId);
    }

    if ($postAction === 'review_document' && $postId) {
        require_permission('documents.verify');
        $docId = (int) ($_POST['document_id'] ?? 0);
        $reviewStatus = $_POST['review_status'] ?? '';
        $reviewRemarks = trim((string) ($_POST['review_remarks'] ?? '')) ?: null;

        if ($docId && in_array($reviewStatus, ['uploaded', 'under_review', 'verified', 'rejected', 'copy_required'], true)) {
            $pdo->prepare(
                'UPDATE enquiry_documents SET review_status = :status, review_remarks = :remarks, reviewed_by = :by, reviewed_at = NOW()
                 WHERE id = :doc_id AND enquiry_id = :enquiry_id'
            )->execute([
                'status' => $reviewStatus,
                'remarks' => $reviewRemarks,
                'by' => current_admin_id(),
                'doc_id' => $docId,
                'enquiry_id' => $postId,
            ]);
            log_action('document_review', 'enquiry_documents', $docId, null, $reviewStatus);
            flash_set('admin_notice', 'Document review status updated.');
        }
        redirect('/admin/enquiries/?id=' . $postId);
    }

    if ($postAction === 'delete' && $postId) {
        $pdo->prepare('UPDATE enquiries SET deleted_at = NOW(), deleted_by = :by WHERE id = :id')
            ->execute(['by' => current_admin_id(), 'id' => $postId]);
        log_action('delete', 'enquiries', $postId);
        flash_set('admin_notice', 'Enquiry moved to Recycle Bin.');
        redirect('/admin/enquiries/');
    }
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT e.*, dc.name AS destination_country_name, vt.name AS visa_type_name, ac.name AS apostille_country_name,
                cust.customer_reference_no, emp.full_name AS assigned_name
         FROM enquiries e
         LEFT JOIN countries dc ON dc.id = e.destination_country_id
         LEFT JOIN visa_types vt ON vt.id = e.visa_type_id
         LEFT JOIN countries ac ON ac.id = e.apostille_destination_country_id
         LEFT JOIN customers cust ON cust.id = e.customer_id
         LEFT JOIN admin_users emp ON emp.id = e.assigned_user
         WHERE e.id = :id AND e.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/enquiries/');
    }
    if ($scopedToAssigned && (int) $enquiry['assigned_user'] !== current_admin_id()) {
        http_response_code(403);
        exit('This enquiry is not assigned to you.');
    }

    $passportPlain = $enquiry['passport_number_encrypted'] !== null ? decrypt_value($enquiry['passport_number_encrypted']) : null;
    $documents = fetch_enquiry_documents((int) $enquiry['id']);
    $historyStmt = $pdo->prepare(
        'SELECT h.*, a.full_name FROM enquiry_status_history h LEFT JOIN admin_users a ON a.id = h.changed_by
         WHERE h.enquiry_id = :id ORDER BY h.created_at ASC'
    );
    $historyStmt->execute(['id' => $enquiry['id']]);
    $history = $historyStmt->fetchAll();

    $docStatusBadgeMap = ['uploaded' => 'neutral', 'under_review' => 'warning', 'verified' => 'success', 'rejected' => 'danger', 'copy_required' => 'warning'];

    admin_header_start('Enquiry ' . $enquiry['enquiry_number'], 'enquiries');
    ?>
    <div class="admin-form-card">
        <p><strong>Enquiry No.:</strong> <?= e($enquiry['enquiry_number']) ?> &nbsp; <strong>Tracking No.:</strong> <?= e($enquiry['tracking_token']) ?></p>
        <p><strong>Service:</strong> <?= $enquiry['service_category'] === 'visa' ? 'Visa Enquiry' : 'Apostille / Document Legalisation' ?> &nbsp; <?= status_badge($enquiry['status'], $statusBadgeMap) ?></p>
        <?php if ($enquiry['customer_reference_no']): ?>
        <p><strong>Customer:</strong> <a href="/admin/customers/?action=view&id=<?= (int) $enquiry['customer_id'] ?>"><?= e($enquiry['customer_reference_no']) ?></a></p>
        <?php endif; ?>

        <h3 style="margin-top:var(--space-5)">Customer Details</h3>
        <p><strong>Name:</strong> <?= e($enquiry['name']) ?></p>
        <p><strong>Mobile:</strong> <?= e($enquiry['mobile_country_code'] . ' ' . $enquiry['mobile_number']) ?></p>
        <p><strong>Email:</strong> <?= e($enquiry['email']) ?></p>
        <p><strong>City / State:</strong> <?= e($enquiry['current_city'] . ', ' . $enquiry['current_state']) ?></p>

        <?php if ($enquiry['service_category'] === 'visa'): ?>
        <h3 style="margin-top:var(--space-5)">Visa Details</h3>
        <p><strong>Destination Country:</strong> <?= e($enquiry['destination_country_name'] ?? 'Not specified') ?></p>
        <p><strong>Visa Type:</strong> <?= e($enquiry['visa_type_name'] ?? 'Not specified') ?></p>
        <p><strong>Passport Number:</strong> <?= e($passportPlain ?? 'Not provided') ?></p>
        <p><strong>Passport Issued From:</strong> <?= e($enquiry['passport_issued_from'] ?? '—') ?></p>
        <p><strong>Date of Journey:</strong> <?= $enquiry['journey_date'] ? e(date('d M Y', strtotime((string) $enquiry['journey_date']))) : '—' ?></p>
        <p><strong>Number of Pax:</strong> <?= (int) $enquiry['pax_count'] ?></p>
        <?php else: ?>
        <h3 style="margin-top:var(--space-5)">Apostille Details</h3>
        <p><strong>Service:</strong> <?= e(APOSTILLE_SERVICE_TYPES[$enquiry['apostille_service_type']] ?? $enquiry['apostille_service_type'] ?? '—') ?></p>
        <p><strong>Document Type:</strong> <?= e(APOSTILLE_DOCUMENT_TYPES[$enquiry['apostille_document_type']] ?? $enquiry['apostille_document_type'] ?? '—') ?></p>
        <p><strong>Number of Documents:</strong> <?= (int) ($enquiry['apostille_document_count'] ?? 0) ?></p>
        <p><strong>Destination Country:</strong> <?= e($enquiry['apostille_country_name'] ?? 'Not applicable') ?></p>
        <p><strong>Purpose:</strong> <?= e($enquiry['apostille_purpose'] ?? '—') ?></p>
        <?php endif; ?>

        <?php if ($enquiry['remarks']): ?>
        <h3 style="margin-top:var(--space-5)">Customer Remarks</h3>
        <p><?= nl2br(e($enquiry['remarks'])) ?></p>
        <?php endif; ?>

        <p style="margin-top:var(--space-5)"><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $enquiry['created_at']))) ?>
        &nbsp; <strong>Email Confirmation:</strong> <?= status_badge($enquiry['email_status'], ['sent' => 'success', 'failed' => 'danger', 'pending' => 'neutral']) ?>
        <?php if ($enquiry['pdf_path']): ?>
        &nbsp; <a href="/enquire/pdf/?ref=<?= e(urlencode($enquiry['enquiry_number'])) ?>&amp;token=<?= e(urlencode($enquiry['tracking_token'])) ?>" target="_blank" rel="noopener">Download PDF</a>
        <?php endif; ?>
        </p>

        <?php if (has_permission('enquiries.manage')): ?>
        <form method="post" action="/admin/enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<?= (int) $enquiry['id'] ?>">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach ($statuses as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $enquiry['status'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="priority">Priority</label>
                    <select class="form-select" id="priority" name="priority">
                        <?php foreach (['low', 'normal', 'high', 'urgent'] as $p): ?>
                        <option value="<?= $p ?>"<?= $enquiry['priority'] === $p ? ' selected' : '' ?>><?= ucfirst($p) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="assigned_user">Assigned To</label>
                    <select class="form-select" id="assigned_user" name="assigned_user">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) $enquiry['assigned_user'] === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="status_remarks">Internal Note (optional)</label>
                <input class="form-input" type="text" id="status_remarks" name="status_remarks" placeholder="Visible only to staff, recorded in status history">
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <?php endif; ?>

        <?php if ($history): ?>
        <h3 style="margin-top:var(--space-5)">Status History</h3>
        <ul class="hrms-timeline">
            <?php foreach ($history as $h): ?>
            <li><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?> — <?= e(enquiry_internal_statuses()[$h['new_status']] ?? $h['new_status']) ?><?= $h['full_name'] ? ' by ' . e($h['full_name']) : '' ?><?= $h['remarks'] ? ': ' . e($h['remarks']) : '' ?></li>
            <?php endforeach; ?>
        </ul>
        <?php endif; ?>
    </div>

    <div class="admin-form-card" style="margin-top:var(--space-5)">
        <h3>Submitted Documents</h3>
        <?php if ($documents): ?>
        <table class="admin-table">
            <thead><tr><th>Document</th><th>File</th><th>Status</th><th>Reviewed</th><?php if (has_permission('documents.verify')): ?><th></th><?php endif; ?></tr></thead>
            <tbody>
            <?php foreach ($documents as $doc): ?>
            <tr>
                <td><?= e(ENQUIRY_DOCUMENT_CATEGORIES[$doc['document_category']] ?? $doc['document_category']) ?></td>
                <td><a href="/admin/enquiry-document-download/?id=<?= (int) $doc['id'] ?>"><?= e($doc['original_filename']) ?></a></td>
                <td><?= status_badge($doc['review_status'], $docStatusBadgeMap) ?><?= $doc['review_remarks'] ? '<br><small>' . e($doc['review_remarks']) . '</small>' : '' ?></td>
                <td><?= $doc['reviewed_at'] ? e(date('d M Y', strtotime((string) $doc['reviewed_at']))) : '—' ?></td>
                <?php if (has_permission('documents.verify')): ?>
                <td class="actions">
                    <form method="post" action="/admin/enquiries/?id=<?= (int) $enquiry['id'] ?>" style="display:flex;gap:var(--space-2);align-items:center">
                        <?= csrf_field() ?>
                        <input type="hidden" name="action" value="review_document">
                        <input type="hidden" name="id" value="<?= (int) $enquiry['id'] ?>">
                        <input type="hidden" name="document_id" value="<?= (int) $doc['id'] ?>">
                        <select class="form-select" name="review_status" style="width:auto">
                            <?php foreach (['uploaded' => 'Uploaded', 'under_review' => 'Under Review', 'verified' => 'Verified', 'rejected' => 'Rejected', 'copy_required' => 'Better Copy Required'] as $sk => $sl): ?>
                            <option value="<?= $sk ?>"<?= $doc['review_status'] === $sk ? ' selected' : '' ?>><?= e($sl) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <input class="form-input" type="text" name="review_remarks" placeholder="Remarks (optional)" style="width:160px">
                        <button type="submit" class="btn btn-outline btn-sm">Save</button>
                    </form>
                </td>
                <?php endif; ?>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <?php else: ?>
        <p class="empty-state">No documents were attached to this enquiry.</p>
        <?php endif; ?>
    </div>

    <?php if (has_permission('enquiries.manage')): ?>
    <form method="post" action="/admin/enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)" data-confirm="Move this enquiry to the Recycle Bin?">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" value="<?= (int) $enquiry['id'] ?>">
        <button type="submit" class="btn btn-outline btn-sm">Move to Recycle Bin</button>
    </form>
    <?php endif; ?>

    <p style="margin-top:var(--space-4)"><a href="/admin/enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = array_key_exists($_GET['status'] ?? '', $statuses) ? $_GET['status'] : null;
$categoryFilter = in_array($_GET['category'] ?? '', ['visa', 'apostille'], true) ? $_GET['category'] : null;
$search = trim((string) ($_GET['q'] ?? ''));

$where = ['e.deleted_at IS NULL'];
$params = [];
if ($statusFilter) {
    $where[] = 'e.status = :status';
    $params['status'] = $statusFilter;
}
if ($categoryFilter) {
    $where[] = 'e.service_category = :category';
    $params['category'] = $categoryFilter;
}
if ($scopedToAssigned) {
    $where[] = 'e.assigned_user = :me';
    $params['me'] = current_admin_id();
}
if ($search !== '') {
    $where[] = '(e.enquiry_number LIKE :q1 OR e.tracking_token LIKE :q2 OR e.name LIKE :q3 OR e.email LIKE :q4 OR e.mobile_number LIKE :q5 OR e.passport_number_hash = :phash)';
    $like = '%' . $search . '%';
    $params['q1'] = $like;
    $params['q2'] = $like;
    $params['q3'] = $like;
    $params['q4'] = $like;
    $params['q5'] = $like;
    $params['phash'] = searchable_hash(normalize_passport_number($search) ?? $search);
}
$whereSql = 'WHERE ' . implode(' AND ', $where);

$sql = "SELECT e.*, dc.name AS destination_country_name FROM enquiries e LEFT JOIN countries dc ON dc.id = e.destination_country_id $whereSql ORDER BY e.created_at DESC LIMIT 100";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

admin_header_start('Enquiries', 'enquiries');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/enquiries/" style="margin-bottom:var(--space-4)">
        <input class="form-input" type="text" name="q" value="<?= e($search) ?>" placeholder="Search name, email, mobile, enquiry/tracking no., passport no.">
        <button type="submit" class="btn btn-outline btn-sm">Search</button>
    </form>
    <div class="button-group">
        <a href="/admin/enquiries/" class="btn btn-sm <?= !$categoryFilter ? 'btn-primary' : 'btn-outline' ?>">All Services</a>
        <a href="/admin/enquiries/?category=visa" class="btn btn-sm <?= $categoryFilter === 'visa' ? 'btn-primary' : 'btn-outline' ?>">Visa</a>
        <a href="/admin/enquiries/?category=apostille" class="btn btn-sm <?= $categoryFilter === 'apostille' ? 'btn-primary' : 'btn-outline' ?>">Apostille</a>
    </div>
    <div class="button-group" style="margin-top:var(--space-2)">
        <a href="/admin/enquiries/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All Statuses</a>
        <?php foreach ($statuses as $sk => $sl): ?>
        <a href="/admin/enquiries/?status=<?= e($sk) ?>" class="btn btn-sm <?= $statusFilter === $sk ? 'btn-primary' : 'btn-outline' ?>"><?= e($sl) ?></a>
        <?php endforeach; ?>
    </div>
</div>
<?php if ($enquiries): ?>
<table class="admin-table">
    <thead><tr><th>Enquiry No.</th><th>Name</th><th>Service</th><th>Destination</th><th>Priority</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $enq): ?>
        <tr>
            <td><?= e($enq['enquiry_number']) ?></td>
            <td><?= e($enq['name']) ?></td>
            <td><?= $enq['service_category'] === 'visa' ? 'Visa' : 'Apostille' ?></td>
            <td><?= e($enq['destination_country_name'] ?? '—') ?></td>
            <td><span class="badge badge-neutral"><?= e(ucfirst($enq['priority'])) ?></span></td>
            <td><?= status_badge($enq['status'], $statusBadgeMap) ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
            <td class="actions"><a href="/admin/enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No enquiries found.</p>
<?php endif; ?>
<?php
admin_header_end();
