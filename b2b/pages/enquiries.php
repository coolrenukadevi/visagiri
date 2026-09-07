<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Visa Enquiries list + detail, scoped to
 * the logged-in partner organisation (b2b_partner_id). Mirrors the old
 * partner system's partner/pages/applications.php list+detail-in-one-
 * file pattern (query-string ?action=view&id=).
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();
$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

$enquiryStatusBadgeMap = [
    'new' => 'info', 'in_progress' => 'warning', 'documents_pending' => 'warning',
    'submitted' => 'info', 'payment_pending' => 'warning', 'completed' => 'success',
    'rejected' => 'danger', 'cancelled' => 'neutral',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $id) {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    $ownerStmt = $pdo->prepare('SELECT status FROM b2b_visa_enquiries WHERE id = :id AND b2b_partner_id = :partner_id AND deleted_at IS NULL');
    $ownerStmt->execute(['id' => $id, 'partner_id' => $partner['id']]);
    $currentStatus = $ownerStmt->fetchColumn();

    if ($currentStatus === false) {
        flash_set('b2b_error', 'Enquiry not found.');
        redirect('/b2b/enquiries/');
    }

    if ($postAction === 'upload_document') {
        $documentType = $_POST['document_type'] ?? '';
        if (!array_key_exists($documentType, B2B_ENQUIRY_DOCUMENT_TYPES) || empty($_FILES['document']['name'])) {
            flash_set('b2b_error', 'Select a document type and choose a file.');
        } else {
            $validationError = validate_document_upload($_FILES['document']);
            if ($validationError !== null) {
                flash_set('b2b_error', $validationError);
            } else {
                store_b2b_enquiry_document($_FILES['document'], $documentType, $id, $user['id']);
                flash_set('b2b_notice', 'Document uploaded.');
            }
        }
        redirect('/b2b/enquiries/?action=view&id=' . $id);
    }

    if ($postAction === 'cancel' && current_b2b_partner_can_manage_enquiries() && in_array($currentStatus, ['new', 'in_progress', 'documents_pending'], true)) {
        b2b_change_enquiry_status($id, 'cancelled', null, $user['id'], 'Cancelled by partner.');
        flash_set('b2b_notice', 'Enquiry cancelled.');
        redirect('/b2b/enquiries/?action=view&id=' . $id);
    }

    if (($postAction === 'accept_quotation' || $postAction === 'reject_quotation') && current_b2b_partner_can_view_billing() && !empty($_POST['quotation_id'])) {
        $quotationId = (int) $_POST['quotation_id'];
        $newStatus = $postAction === 'accept_quotation' ? 'accepted' : 'rejected';
        $pdo->prepare(
            "UPDATE b2b_enquiry_quotations SET status = :status, responded_at = NOW() WHERE id = :id AND b2b_visa_enquiry_id = :enquiry_id AND status = 'sent'"
        )->execute(['status' => $newStatus, 'id' => $quotationId, 'enquiry_id' => $id]);
        flash_set('b2b_notice', 'Quotation ' . ($newStatus === 'accepted' ? 'accepted' : 'declined') . '.');
        redirect('/b2b/enquiries/?action=view&id=' . $id);
    }

    if ($postAction === 'post_message') {
        $messageBody = trim((string) ($_POST['message'] ?? ''));
        if ($messageBody === '') {
            flash_set('b2b_error', 'Enter a message.');
        } else {
            $pdo->prepare('INSERT INTO b2b_enquiry_messages (b2b_visa_enquiry_id, sender_partner_user_id, message) VALUES (:id, :user, :message)')
                ->execute(['id' => $id, 'user' => $user['id'], 'message' => $messageBody]);
            flash_set('b2b_notice', 'Message sent.');
        }
        redirect('/b2b/enquiries/?action=view&id=' . $id);
    }

    redirect('/b2b/enquiries/?action=view&id=' . $id);
}

if (($_GET['action'] ?? '') === 'view' && $id) {
    $stmt = $pdo->prepare(
        "SELECT e.*, c.name AS country_name, m.full_name AS assigned_admin_name
         FROM b2b_visa_enquiries e
         JOIN countries c ON c.id = e.destination_country_id
         LEFT JOIN admin_users m ON m.id = e.assigned_admin_id
         WHERE e.id = :id AND e.b2b_partner_id = :partner_id AND e.deleted_at IS NULL"
    );
    $stmt->execute(['id' => $id, 'partner_id' => $partner['id']]);
    $enquiry = $stmt->fetch();

    if (!$enquiry) {
        flash_set('b2b_error', 'Enquiry not found.');
        redirect('/b2b/enquiries/');
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

    // Draft quotations are an internal admin working state — a partner
    // only ever sees one once it's been sent (or later accepted/rejected).
    $quotationsStmt = $pdo->prepare("SELECT * FROM b2b_enquiry_quotations WHERE b2b_visa_enquiry_id = :id AND status != 'draft' ORDER BY created_at DESC");
    $quotationsStmt->execute(['id' => $id]);
    $quotations = $quotationsStmt->fetchAll();

    $invoicesStmt = $pdo->prepare('SELECT * FROM b2b_enquiry_invoices WHERE b2b_visa_enquiry_id = :id ORDER BY created_at DESC');
    $invoicesStmt->execute(['id' => $id]);
    $invoices = $invoicesStmt->fetchAll();

    $messagesStmt = $pdo->prepare(
        'SELECT m.*, a.full_name AS admin_name, u.full_name AS partner_user_name FROM b2b_enquiry_messages m
         LEFT JOIN admin_users a ON a.id = m.sender_admin_id
         LEFT JOIN b2b_partner_users u ON u.id = m.sender_partner_user_id
         WHERE m.b2b_visa_enquiry_id = :id ORDER BY m.created_at ASC'
    );
    $messagesStmt->execute(['id' => $id]);
    $messages = $messagesStmt->fetchAll();

    render_b2b_partner_start('enquiries', $enquiry['enquiry_reference_no']);
    ?>
            <div class="admin-form-card" style="margin-bottom:var(--space-6)">
                <p><strong>Status:</strong> <?= status_badge((string) $enquiry['status'], $enquiryStatusBadgeMap) ?></p>
                <p><strong>Destination:</strong> <?= e($enquiry['country_name']) ?> &middot; <strong>Visa Type:</strong> <?= e(B2B_VISA_SERVICES[$enquiry['visa_type']] ?? $enquiry['visa_type']) ?></p>
                <p><strong>Purpose:</strong> <?= e($enquiry['purpose_of_travel'] ?? '—') ?> &middot; <strong>Intended Travel Date:</strong> <?= $enquiry['intended_travel_date'] ? e(date('d M Y', strtotime((string) $enquiry['intended_travel_date']))) : '—' ?></p>
                <p><strong>Applicants:</strong> <?= (int) $enquiry['number_of_applicants'] ?> &middot; <strong>Relationship Manager:</strong> <?= e($enquiry['assigned_admin_name'] ?? 'Not yet assigned') ?></p>
                <?php if ($enquiry['special_requirements']): ?><p><strong>Notes:</strong> <?= e($enquiry['special_requirements']) ?></p><?php endif; ?>
                <?php if (current_b2b_partner_can_manage_enquiries() && in_array($enquiry['status'], ['new', 'in_progress', 'documents_pending'], true)): ?>
                <form method="post" action="/b2b/enquiries/" style="margin-top:var(--space-3)">
                    <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="cancel">
                    <button type="submit" class="btn btn-outline btn-sm">Cancel Enquiry</button>
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

            <h2 class="country-directory__subheading">Documents</h2>
            <?php if ($documents): ?>
            <table class="admin-table" style="margin-bottom:var(--space-4)"><thead><tr><th>Type</th><th>File</th><th>Status</th><th>Remarks</th></tr></thead><tbody>
                <?php foreach ($documents as $doc): ?>
                <tr>
                    <td><?= e(B2B_ENQUIRY_DOCUMENT_TYPES[$doc['document_type']] ?? $doc['document_type']) ?></td>
                    <td><?= e($doc['original_filename']) ?></td>
                    <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
                    <td><?= e($doc['verification_remarks'] ?? '—') ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody></table>
            <?php else: ?>
            <p class="empty-state">No documents uploaded yet.</p>
            <?php endif; ?>
            <form method="post" action="/b2b/enquiries/" enctype="multipart/form-data" style="display:flex;gap:var(--space-2);align-items:center;flex-wrap:wrap;margin-bottom:var(--space-6)">
                <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="upload_document">
                <select name="document_type" class="form-select" required>
                    <option value="">Document type…</option>
                    <?php foreach (B2B_ENQUIRY_DOCUMENT_TYPES as $key => $label): ?>
                    <option value="<?= e($key) ?>"><?= e($label) ?></option>
                    <?php endforeach; ?>
                </select>
                <input type="file" name="document" required>
                <button type="submit" class="btn btn-outline btn-sm">Upload</button>
            </form>

            <h2 class="country-directory__subheading">Quotations</h2>
            <?php if (!$quotations): ?>
            <p class="empty-state">No quotations received yet.</p>
            <?php else: ?>
            <table class="admin-table" style="margin-bottom:var(--space-4)"><thead><tr><th>Reference</th><th>Total</th><th>Status</th><th></th></tr></thead><tbody>
                <?php foreach ($quotations as $q): ?>
                <tr>
                    <td><?= e($q['quotation_reference_no']) ?></td>
                    <td><strong><?= e($q['currency']) ?> <?= e(number_format((float) $q['total_amount'], 2)) ?></strong> <span style="color:var(--text-muted);font-size:var(--font-size-sm)">(Govt. <?= e(number_format((float) $q['government_fee'], 2)) ?> + Service <?= e(number_format((float) $q['service_fee'], 2)) ?><?= $q['other_charges'] > 0 ? ' + Other ' . e(number_format((float) $q['other_charges'], 2)) : '' ?>)</span></td>
                    <td><span class="badge <?= $q['status'] === 'accepted' ? 'badge-success' : ($q['status'] === 'rejected' ? 'badge-danger' : 'badge-info') ?>"><?= e(B2B_QUOTATION_STATUS_LABELS[$q['status']]) ?></span></td>
                    <td>
                        <?php if ($q['status'] === 'sent' && current_b2b_partner_can_view_billing()): ?>
                        <form method="post" action="/b2b/enquiries/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="accept_quotation"><input type="hidden" name="quotation_id" value="<?= (int) $q['id'] ?>"><button type="submit" class="btn btn-primary btn-sm">Accept</button></form>
                        <form method="post" action="/b2b/enquiries/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="reject_quotation"><input type="hidden" name="quotation_id" value="<?= (int) $q['id'] ?>"><button type="submit" class="btn btn-outline btn-sm">Decline</button></form>
                        <?php elseif ($q['status'] === 'sent'): ?>
                        <span style="color:var(--text-muted);font-size:var(--font-size-sm)">Only account admin/finance can respond</span>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody></table>
            <?php endif; ?>

            <h2 class="country-directory__subheading">Invoices</h2>
            <?php if (!$invoices): ?>
            <p class="empty-state">No invoices issued yet.</p>
            <?php else: ?>
            <table class="admin-table"><thead><tr><th>Reference</th><th>Amount</th><th>Status</th></tr></thead><tbody>
                <?php foreach ($invoices as $inv): ?>
                <tr>
                    <td><?= e($inv['invoice_reference_no']) ?></td>
                    <td><?= e($inv['currency']) ?> <?= e(number_format((float) $inv['amount'], 2)) ?></td>
                    <td><span class="badge <?= $inv['status'] === 'paid' ? 'badge-success' : ($inv['status'] === 'cancelled' ? 'badge-neutral' : 'badge-warning') ?>"><?= e(B2B_INVOICE_STATUS_LABELS[$inv['status']]) ?></span></td>
                </tr>
                <?php if ($inv['status'] === 'issued'): ?>
                <tr><td colspan="3"><p class="empty-state" style="text-align:left">Online payment isn't connected yet — our finance team will reach out to arrange payment for this invoice.</p></td></tr>
                <?php endif; ?>
                <?php endforeach; ?>
            </tbody></table>
            <?php endif; ?>

            <h2 class="country-directory__subheading">Status History</h2>
            <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>Note</th><th>By</th><th>When</th></tr></thead><tbody>
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

            <h2 class="country-directory__subheading">Messages</h2>
            <div class="admin-form-card" style="margin-bottom:var(--space-4);max-height:360px;overflow-y:auto">
                <?php if (!$messages): ?>
                <p class="empty-state">No messages yet. Send one below and our team will reply here.</p>
                <?php else: ?>
                <?php foreach ($messages as $m): ?>
                <p style="margin-bottom:var(--space-3)"><strong><?= $m['sender_admin_id'] ? e($m['admin_name'] ?? 'Visagiri Team') : e($m['partner_user_name'] ?? 'You') ?>:</strong> <?= nl2br(e($m['message'])) ?><br><span style="color:var(--text-muted);font-size:var(--font-size-sm)"><?= e(date('d M Y H:i', strtotime((string) $m['created_at']))) ?></span></p>
                <?php endforeach; ?>
                <?php endif; ?>
            </div>
            <form method="post" action="/b2b/enquiries/" style="margin-bottom:var(--space-6)">
                <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="post_message">
                <textarea class="form-textarea" name="message" rows="2" placeholder="Type a message…" required style="width:100%;max-width:520px"></textarea>
                <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Send</button>
            </form>

            <p style="margin-top:var(--space-6)"><a href="/b2b/enquiries/">&larr; Back to all enquiries</a></p>
<?php
    render_b2b_partner_end();
    exit;
}

// --- List ---
$statusFilter = array_key_exists($_GET['status'] ?? '', B2B_ENQUIRY_STATUS_LABELS) ? $_GET['status'] : null;
$where = 'e.b2b_partner_id = :partner_id AND e.deleted_at IS NULL';
$params = ['partner_id' => $partner['id']];
if ($statusFilter) {
    $where .= ' AND e.status = :status';
    $params['status'] = $statusFilter;
}
$listStmt = $pdo->prepare(
    "SELECT e.*, c.name AS country_name FROM b2b_visa_enquiries e
     JOIN countries c ON c.id = e.destination_country_id
     WHERE $where ORDER BY e.created_at DESC"
);
$listStmt->execute($params);
$enquiries = $listStmt->fetchAll();

render_b2b_partner_start('enquiries', 'Visa Enquiries');
?>
        <div class="admin-toolbar">
            <form method="get" action="/b2b/enquiries/">
                <select class="form-select" name="status" onchange="this.form.submit()">
                    <option value="">All statuses</option>
                    <?php foreach (B2B_ENQUIRY_STATUS_LABELS as $key => $label): ?>
                    <option value="<?= e($key) ?>"<?= $statusFilter === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </form>
            <?php if (current_b2b_partner_can_manage_enquiries()): ?>
            <a href="/b2b/enquiry-create/" class="btn btn-primary">+ New Enquiry</a>
            <?php endif; ?>
        </div>
        <table class="admin-table">
            <thead><tr><th>Reference</th><th>Destination</th><th>Visa Type</th><th>Applicants</th><th>Status</th><th>Created</th></tr></thead>
            <tbody>
            <?php foreach ($enquiries as $e): ?>
                <tr>
                    <td><a href="/b2b/enquiries/?action=view&id=<?= (int) $e['id'] ?>"><?= e($e['enquiry_reference_no']) ?></a></td>
                    <td><?= e($e['country_name']) ?></td>
                    <td><?= e(B2B_VISA_SERVICES[$e['visa_type']] ?? $e['visa_type']) ?></td>
                    <td><?= (int) $e['number_of_applicants'] ?></td>
                    <td><?= status_badge((string) $e['status'], $enquiryStatusBadgeMap) ?></td>
                    <td><?= e(date('d M Y', strtotime((string) $e['created_at']))) ?></td>
                </tr>
            <?php endforeach; ?>
            <?php if (!$enquiries): ?>
                <tr><td colspan="6"><p class="empty-state">No visa enquiries yet.<?= current_b2b_partner_can_manage_enquiries() ? ' <a href="/b2b/enquiry-create/">Create your first enquiry &rarr;</a>' : '' ?></p></td></tr>
            <?php endif; ?>
            </tbody>
        </table>
<?php render_b2b_partner_end(); ?>
