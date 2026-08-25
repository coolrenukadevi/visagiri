<?php
declare(strict_types=1);

require_permission('general_enquiries.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();
$statuses = ['new', 'in_progress', 'resolved', 'closed'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('general_enquiries.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'update' && $id) {
        $before = $pdo->prepare('SELECT status, assigned_user FROM general_enquiries WHERE id = :id');
        $before->execute(['id' => $id]);
        $prev = $before->fetch();

        $status = $_POST['status'] ?? '';
        $assignedUser = (int) ($_POST['assigned_user'] ?? 0) ?: null;
        if (in_array($status, $statuses, true)) {
            $pdo->prepare('UPDATE general_enquiries SET status = :status, priority = :priority, assigned_user = :assigned WHERE id = :id')
                ->execute([
                    'status' => $status,
                    'priority' => in_array($_POST['priority'] ?? '', ['low', 'normal', 'high', 'urgent'], true) ? $_POST['priority'] : 'normal',
                    'assigned' => $assignedUser,
                    'id' => $id,
                ]);
            if ($prev && $prev['status'] !== $status) {
                log_action('status_change', 'general_enquiries', $id, $prev['status'], $status);
            }
            if ($prev && (int) ($prev['assigned_user'] ?? 0) !== ($assignedUser ?? 0)) {
                log_action('assignment', 'general_enquiries', $id, (string) $prev['assigned_user'], (string) $assignedUser);
            }
            flash_set('admin_notice', 'Enquiry updated.');
        }
        redirect('/admin/general-enquiries/?id=' . $id);
    }

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE general_enquiries SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'general_enquiries', $id);
        flash_set('admin_notice', 'Enquiry removed (soft delete).');
        redirect('/admin/general-enquiries/');
    }

    if ($postAction === 'upload_document' && $id) {
        require_permission('documents.upload');
        $error = validate_document_upload($_FILES['document'] ?? []);
        if ($error) {
            flash_set('admin_error', $error);
        } else {
            $docId = store_document_upload(
                $_FILES['document'],
                trim((string) ($_POST['document_type'] ?? '')) ?: null,
                null,
                null,
                $id,
                (int) current_admin_id()
            );
            log_action('document_upload', 'documents', $docId, null, $_FILES['document']['name'] ?? null);
            flash_set('admin_notice', 'Document uploaded.');
        }
        redirect('/admin/general-enquiries/?id=' . $id);
    }

    if ($postAction === 'verify_document') {
        require_permission('documents.verify');
        $docId = (int) ($_POST['document_id'] ?? 0);
        $verifyStatus = $_POST['verify_status'] ?? '';
        if ($docId && in_array($verifyStatus, ['verified', 'rejected'], true)) {
            $pdo->prepare('UPDATE documents SET verification_status = :status, verified_by = :admin, verified_at = NOW() WHERE id = :id')
                ->execute(['status' => $verifyStatus, 'admin' => current_admin_id(), 'id' => $docId]);
            log_action('document_verification', 'documents', $docId, null, $verifyStatus);
            flash_set('admin_notice', 'Document ' . $verifyStatus . '.');
        }
        redirect('/admin/general-enquiries/?id=' . $id);
    }
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT ge.*, cust.customer_reference_no FROM general_enquiries ge
         LEFT JOIN customers cust ON cust.id = ge.customer_id
         WHERE ge.id = :id AND ge.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/general-enquiries/');
    }

    $documents = $pdo->prepare('SELECT * FROM documents WHERE general_enquiry_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documents->execute(['id' => $id]);

    admin_header_start('Enquiry ' . $enquiry['enquiry_reference_no'], 'general-enquiries');
    ?>
    <div class="admin-form-card">
        <p><strong>Reference:</strong> <?= e($enquiry['enquiry_reference_no']) ?></p>
        <p><strong>Service:</strong> <?= e(ucwords(str_replace('-', ' ', $enquiry['service_type']))) ?></p>
        <p><strong>Name:</strong> <?= e($enquiry['name']) ?></p>
        <p><strong>Email:</strong> <?= e($enquiry['email']) ?> &middot; <strong>Phone:</strong> <?= e($enquiry['phone'] ?? 'Not provided') ?></p>
        <?php if ($enquiry['subject']): ?><p><strong>Subject:</strong> <?= e($enquiry['subject']) ?></p><?php endif; ?>
        <p><strong>Description:</strong><br><?= nl2br(e($enquiry['description'])) ?></p>
        <p><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $enquiry['created_at']))) ?></p>

        <?php if (has_permission('general_enquiries.manage')): ?>
        <form method="post" action="/admin/general-enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach ($statuses as $s): ?>
                        <option value="<?= $s ?>"<?= $enquiry['status'] === $s ? ' selected' : '' ?>><?= ucwords(str_replace('_', ' ', $s)) ?></option>
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
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <form method="post" action="/admin/general-enquiries/" style="margin-top:var(--space-3)" onsubmit="return confirm('Remove this enquiry?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= $id ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Documents</h2>
    <?php $rows = $documents->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>File</th><th>Type</th><th>Verification</th><th></th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr>
            <td><?= e($r['original_filename']) ?></td>
            <td><?= e($r['document_type'] ?? '—') ?></td>
            <td><span class="badge <?= $r['verification_status'] === 'verified' ? 'badge-success' : ($r['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($r['verification_status']) ?></span></td>
            <td class="actions">
                <a href="/admin/document-download/?id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Download</a>
                <?php if (has_permission('documents.verify') && $r['verification_status'] === 'pending'): ?>
                <form method="post" action="/admin/general-enquiries/?id=<?= $id ?>" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="verify_document"><input type="hidden" name="document_id" value="<?= (int) $r['id'] ?>"><input type="hidden" name="verify_status" value="verified"><button type="submit" class="btn btn-outline btn-sm">Verify</button></form>
                <form method="post" action="/admin/general-enquiries/?id=<?= $id ?>" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="verify_document"><input type="hidden" name="document_id" value="<?= (int) $r['id'] ?>"><input type="hidden" name="verify_status" value="rejected"><button type="submit" class="btn btn-outline btn-sm">Reject</button></form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if (has_permission('documents.upload')): ?>
    <form method="post" action="/admin/general-enquiries/?id=<?= $id ?>" enctype="multipart/form-data" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="upload_document">
        <div class="admin-form-grid">
            <input class="form-input" type="text" name="document_type" placeholder="Document type">
            <input class="form-input" type="file" name="document" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" required>
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Upload</button>
    </form>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/general-enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = in_array($_GET['status'] ?? '', $statuses, true) ? $_GET['status'] : null;
$serviceFilter = trim((string) ($_GET['service'] ?? ''));
$where = ['deleted_at IS NULL'];
$params = [];
if ($statusFilter) {
    $where[] = 'status = :status';
    $params['status'] = $statusFilter;
}
if ($serviceFilter !== '') {
    $where[] = 'service_type = :service';
    $params['service'] = $serviceFilter;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$stmt = $pdo->prepare("SELECT * FROM general_enquiries $whereSql ORDER BY created_at DESC LIMIT 100");
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

admin_header_start('General & Attestation Enquiries', 'general-enquiries');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/general-enquiries/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach ($statuses as $s): ?>
        <a href="/admin/general-enquiries/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= ucwords(str_replace('_', ' ', $s)) ?></a>
        <?php endforeach; ?>
    </div>
</div>
<?php if ($enquiries): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Service</th><th>Name</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $enq): ?>
        <tr>
            <td><?= e($enq['enquiry_reference_no']) ?></td>
            <td><?= e(ucwords(str_replace('-', ' ', $enq['service_type']))) ?></td>
            <td><?= e($enq['name']) ?></td>
            <td><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $enq['status']))) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
            <td class="actions"><a href="/admin/general-enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No enquiries yet.</p>
<?php endif; ?>
<?php
admin_header_end();
