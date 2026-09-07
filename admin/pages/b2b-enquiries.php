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
            $enquiryRefStmt = $pdo->prepare('SELECT b2b_partner_id, enquiry_reference_no FROM b2b_visa_enquiries WHERE id = :id');
            $enquiryRefStmt->execute(['id' => $targetId]);
            if ($enquiryRow = $enquiryRefStmt->fetch()) {
                notify_b2b_partner((int) $enquiryRow['b2b_partner_id'], 'enquiry_document_' . $verifyStatus, 'Document ' . $verifyStatus . ' on ' . $enquiryRow['enquiry_reference_no'], $docRemarks, '/b2b/enquiries/?action=view&id=' . $targetId);
            }
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

    if ($postAction === 'create_quotation' && $targetId) {
        $govFee = (float) ($_POST['government_fee'] ?? 0);
        $serviceFee = (float) ($_POST['service_fee'] ?? 0);
        $otherCharges = (float) ($_POST['other_charges'] ?? 0);
        $notes = trim((string) ($_POST['notes'] ?? '')) ?: null;
        $total = $govFee + $serviceFee + $otherCharges;
        if ($total <= 0) {
            flash_set('admin_error', 'Quotation total must be greater than zero.');
        } else {
            $reference = b2b_generate_quotation_reference();
            $pdo->prepare(
                'INSERT INTO b2b_enquiry_quotations (quotation_reference_no, b2b_visa_enquiry_id, government_fee, service_fee, other_charges, total_amount, notes, created_by)
                 VALUES (:ref, :enquiry_id, :gov, :service, :other, :total, :notes, :admin)'
            )->execute([
                'ref' => $reference, 'enquiry_id' => $targetId, 'gov' => $govFee, 'service' => $serviceFee,
                'other' => $otherCharges, 'total' => $total, 'notes' => $notes, 'admin' => current_admin_id(),
            ]);
            log_action('b2b_quotation_create', 'b2b_enquiry_quotations', (int) $pdo->lastInsertId(), null, (string) $total);
            flash_set('admin_notice', 'Quotation ' . $reference . ' created as draft.');
        }
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'send_quotation' && $targetId) {
        $quotationId = (int) ($_POST['quotation_id'] ?? 0);
        $pdo->prepare("UPDATE b2b_enquiry_quotations SET status = 'sent', sent_at = NOW() WHERE id = :id AND b2b_visa_enquiry_id = :enquiry_id AND status = 'draft'")
            ->execute(['id' => $quotationId, 'enquiry_id' => $targetId]);
        log_action('b2b_quotation_send', 'b2b_enquiry_quotations', $quotationId, 'draft', 'sent');
        $quoteRefStmt = $pdo->prepare(
            'SELECT e.b2b_partner_id, e.enquiry_reference_no, q.quotation_reference_no, q.total_amount, q.currency
             FROM b2b_enquiry_quotations q JOIN b2b_visa_enquiries e ON e.id = q.b2b_visa_enquiry_id WHERE q.id = :id'
        );
        $quoteRefStmt->execute(['id' => $quotationId]);
        if ($quoteRow = $quoteRefStmt->fetch()) {
            notify_b2b_partner(
                (int) $quoteRow['b2b_partner_id'], 'quotation_sent',
                'New quotation for ' . $quoteRow['enquiry_reference_no'],
                'Quotation ' . $quoteRow['quotation_reference_no'] . ': ' . $quoteRow['currency'] . ' ' . number_format((float) $quoteRow['total_amount'], 2),
                '/b2b/enquiries/?action=view&id=' . $targetId
            );
        }
        flash_set('admin_notice', 'Quotation sent to partner.');
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'create_invoice' && $targetId) {
        $quotationId = ($_POST['quotation_id'] ?? '') !== '' ? (int) $_POST['quotation_id'] : null;
        $amount = (float) ($_POST['amount'] ?? 0);
        $invoiceNotes = trim((string) ($_POST['notes'] ?? '')) ?: null;
        if ($amount <= 0) {
            flash_set('admin_error', 'Invoice amount must be greater than zero.');
        } else {
            $partnerIdStmt = $pdo->prepare('SELECT b2b_partner_id FROM b2b_visa_enquiries WHERE id = :id');
            $partnerIdStmt->execute(['id' => $targetId]);
            $enquiryPartnerId = (int) $partnerIdStmt->fetchColumn();

            $reference = b2b_generate_invoice_reference();
            $pdo->prepare(
                'INSERT INTO b2b_enquiry_invoices (invoice_reference_no, b2b_visa_enquiry_id, b2b_partner_id, quotation_id, amount, notes, created_by, issued_at)
                 VALUES (:ref, :enquiry_id, :partner_id, :quotation_id, :amount, :notes, :admin, NOW())'
            )->execute([
                'ref' => $reference, 'enquiry_id' => $targetId, 'partner_id' => $enquiryPartnerId, 'quotation_id' => $quotationId,
                'amount' => $amount, 'notes' => $invoiceNotes, 'admin' => current_admin_id(),
            ]);
            log_action('b2b_invoice_create', 'b2b_enquiry_invoices', (int) $pdo->lastInsertId(), null, (string) $amount);
            b2b_change_enquiry_status($targetId, 'payment_pending', current_admin_id(), null, 'Invoice ' . $reference . ' issued.');
            flash_set('admin_notice', 'Invoice ' . $reference . ' issued.');
        }
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'mark_invoice_paid' && $targetId) {
        $invoiceId = (int) ($_POST['invoice_id'] ?? 0);
        $paymentMethod = trim((string) ($_POST['payment_method'] ?? ''));
        $paymentReference = trim((string) ($_POST['payment_reference'] ?? '')) ?: null;
        if ($paymentMethod === '') {
            flash_set('admin_error', 'Payment method is required to record payment.');
        } else {
            $pdo->prepare(
                "UPDATE b2b_enquiry_invoices SET status = 'paid', payment_method = :method, payment_reference = :ref, paid_at = NOW()
                 WHERE id = :id AND b2b_visa_enquiry_id = :enquiry_id AND status = 'issued'"
            )->execute(['method' => $paymentMethod, 'ref' => $paymentReference, 'id' => $invoiceId, 'enquiry_id' => $targetId]);
            log_action('b2b_invoice_paid', 'b2b_enquiry_invoices', $invoiceId, 'issued', 'paid');
            $invRefStmt = $pdo->prepare(
                'SELECT e.b2b_partner_id, e.enquiry_reference_no, i.invoice_reference_no FROM b2b_enquiry_invoices i
                 JOIN b2b_visa_enquiries e ON e.id = i.b2b_visa_enquiry_id WHERE i.id = :id'
            );
            $invRefStmt->execute(['id' => $invoiceId]);
            if ($invRow = $invRefStmt->fetch()) {
                notify_b2b_partner((int) $invRow['b2b_partner_id'], 'invoice_paid', 'Payment received for ' . $invRow['invoice_reference_no'], null, '/b2b/enquiries/?action=view&id=' . $targetId);
            }
            flash_set('admin_notice', 'Payment recorded.');
        }
        redirect('/admin/b2b-enquiries/?action=view&id=' . $targetId);
    }

    if ($postAction === 'post_message' && $targetId) {
        $messageBody = trim((string) ($_POST['message'] ?? ''));
        if ($messageBody === '') {
            flash_set('admin_error', 'Enter a message.');
        } else {
            $pdo->prepare('INSERT INTO b2b_enquiry_messages (b2b_visa_enquiry_id, sender_admin_id, message) VALUES (:id, :admin, :message)')
                ->execute(['id' => $targetId, 'admin' => current_admin_id(), 'message' => $messageBody]);
            $enquiryRefStmt = $pdo->prepare('SELECT b2b_partner_id, enquiry_reference_no FROM b2b_visa_enquiries WHERE id = :id');
            $enquiryRefStmt->execute(['id' => $targetId]);
            if ($enquiryRow = $enquiryRefStmt->fetch()) {
                notify_b2b_partner((int) $enquiryRow['b2b_partner_id'], 'enquiry_message', 'New message on ' . $enquiryRow['enquiry_reference_no'], mb_substr($messageBody, 0, 200), '/b2b/enquiries/?action=view&id=' . $targetId);
            }
            flash_set('admin_notice', 'Message sent.');
        }
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

    $quotationsStmt = $pdo->prepare('SELECT * FROM b2b_enquiry_quotations WHERE b2b_visa_enquiry_id = :id ORDER BY created_at DESC');
    $quotationsStmt->execute(['id' => $id]);
    $quotations = $quotationsStmt->fetchAll();
    $acceptedQuotations = array_filter($quotations, static fn($q) => $q['status'] === 'accepted');

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

    <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Quotations</h2>
    <?php if (!$quotations): ?>
    <p class="empty-state">No quotations created yet.</p>
    <?php else: ?>
    <table class="admin-table" style="margin-bottom:var(--space-4)"><thead><tr><th>Reference</th><th>Govt. Fee</th><th>Service Fee</th><th>Other</th><th>Total</th><th>Status</th><th></th></tr></thead><tbody>
        <?php foreach ($quotations as $q): ?>
        <tr>
            <td><?= e($q['quotation_reference_no']) ?></td>
            <td><?= e(number_format((float) $q['government_fee'], 2)) ?></td>
            <td><?= e(number_format((float) $q['service_fee'], 2)) ?></td>
            <td><?= e(number_format((float) $q['other_charges'], 2)) ?></td>
            <td><strong><?= e($q['currency']) ?> <?= e(number_format((float) $q['total_amount'], 2)) ?></strong></td>
            <td><span class="badge <?= $q['status'] === 'accepted' ? 'badge-success' : ($q['status'] === 'rejected' ? 'badge-danger' : ($q['status'] === 'sent' ? 'badge-info' : 'badge-neutral')) ?>"><?= e(B2B_QUOTATION_STATUS_LABELS[$q['status']]) ?></span></td>
            <td>
                <?php if ($canManage && $q['status'] === 'draft'): ?>
                <form method="post" action="/admin/b2b-enquiries/" style="display:inline">
                    <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="send_quotation"><input type="hidden" name="quotation_id" value="<?= (int) $q['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Send to Partner</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if ($canManage): ?>
    <form method="post" action="/admin/b2b-enquiries/" style="display:flex;gap:var(--space-2);flex-wrap:wrap;align-items:flex-end;margin-bottom:var(--space-6)">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="create_quotation">
        <div class="form-group" style="margin:0"><label class="form-label">Govt. Fee</label><input class="form-input" type="number" step="0.01" name="government_fee" style="width:110px"></div>
        <div class="form-group" style="margin:0"><label class="form-label">Service Fee</label><input class="form-input" type="number" step="0.01" name="service_fee" style="width:110px"></div>
        <div class="form-group" style="margin:0"><label class="form-label">Other Charges</label><input class="form-input" type="number" step="0.01" name="other_charges" style="width:110px"></div>
        <div class="form-group" style="margin:0"><label class="form-label">Notes</label><input class="form-input" type="text" name="notes" style="width:220px"></div>
        <button type="submit" class="btn btn-outline btn-sm">+ Create Quotation</button>
    </form>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Invoices</h2>
    <?php if (!$invoices): ?>
    <p class="empty-state">No invoices issued yet.</p>
    <?php else: ?>
    <table class="admin-table" style="margin-bottom:var(--space-4)"><thead><tr><th>Reference</th><th>Amount</th><th>Status</th><th>Payment</th><th>Issued</th><th></th></tr></thead><tbody>
        <?php foreach ($invoices as $inv): ?>
        <tr>
            <td><?= e($inv['invoice_reference_no']) ?></td>
            <td><?= e($inv['currency']) ?> <?= e(number_format((float) $inv['amount'], 2)) ?></td>
            <td><span class="badge <?= $inv['status'] === 'paid' ? 'badge-success' : ($inv['status'] === 'cancelled' ? 'badge-neutral' : 'badge-warning') ?>"><?= e(B2B_INVOICE_STATUS_LABELS[$inv['status']]) ?></span></td>
            <td><?= $inv['payment_method'] ? e($inv['payment_method']) . ($inv['payment_reference'] ? ' (' . e($inv['payment_reference']) . ')' : '') : '—' ?></td>
            <td><?= $inv['issued_at'] ? e(date('d M Y', strtotime((string) $inv['issued_at']))) : '—' ?></td>
            <td>
                <?php if ($canManage && $inv['status'] === 'issued'): ?>
                <form method="post" action="/admin/b2b-enquiries/" style="display:inline-flex;gap:var(--space-1);align-items:center">
                    <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="mark_invoice_paid"><input type="hidden" name="invoice_id" value="<?= (int) $inv['id'] ?>">
                    <input type="text" name="payment_method" placeholder="Method (e.g. Bank Transfer)" style="width:150px" required>
                    <input type="text" name="payment_reference" placeholder="Reference / UTR" style="width:140px">
                    <button type="submit" class="btn btn-outline btn-sm">Mark Paid</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if ($canManage): ?>
    <form method="post" action="/admin/b2b-enquiries/" style="display:flex;gap:var(--space-2);flex-wrap:wrap;align-items:flex-end;margin-bottom:var(--space-6)">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="create_invoice">
        <?php if ($acceptedQuotations): ?>
        <div class="form-group" style="margin:0">
            <label class="form-label">From Quotation</label>
            <select name="quotation_id" class="form-select" style="width:180px">
                <option value="">— Manual amount —</option>
                <?php foreach ($acceptedQuotations as $q): ?>
                <option value="<?= (int) $q['id'] ?>" data-amount="<?= e((string) $q['total_amount']) ?>"><?= e($q['quotation_reference_no']) ?> (<?= e(number_format((float) $q['total_amount'], 2)) ?>)</option>
                <?php endforeach; ?>
            </select>
        </div>
        <?php endif; ?>
        <div class="form-group" style="margin:0"><label class="form-label">Amount</label><input class="form-input" type="number" step="0.01" name="amount" style="width:120px" required></div>
        <div class="form-group" style="margin:0"><label class="form-label">Notes</label><input class="form-input" type="text" name="notes" style="width:220px"></div>
        <button type="submit" class="btn btn-outline btn-sm">+ Issue Invoice</button>
    </form>
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

    <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Messages</h2>
    <div class="admin-form-card" style="margin-bottom:var(--space-4);max-height:360px;overflow-y:auto">
        <?php if (!$messages): ?>
        <p class="empty-state">No messages yet.</p>
        <?php else: ?>
        <?php foreach ($messages as $m): ?>
        <p style="margin-bottom:var(--space-3)"><strong><?= $m['sender_admin_id'] ? e($m['admin_name'] ?? 'Admin') : e($m['partner_user_name'] ?? 'Partner') ?>:</strong> <?= nl2br(e($m['message'])) ?><br><span style="color:var(--text-muted);font-size:var(--font-size-sm)"><?= e(date('d M Y H:i', strtotime((string) $m['created_at']))) ?></span></p>
        <?php endforeach; ?>
        <?php endif; ?>
    </div>
    <?php if ($canManage): ?>
    <form method="post" action="/admin/b2b-enquiries/" style="margin-bottom:var(--space-6)">
        <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="post_message">
        <textarea class="form-textarea" name="message" rows="2" placeholder="Reply to partner…" required style="width:100%;max-width:520px"></textarea>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Send</button>
    </form>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/b2b-enquiries/">&larr; Back to all enquiries</a> &middot; <a href="/admin/audit-log/?module=b2b_visa_enquiries">View in Audit Log</a></p>
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
