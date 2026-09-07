<?php
declare(strict_types=1);

/**
 * Admin B2B Travel Partner Portal management + verification center.
 * Deliberately separate from admin/pages/partners.php (the old
 * referral-partner CRM) — this manages b2b_partners, the standalone
 * portal built alongside it. Same list/detail + status-transition
 * pattern as partners.php (mandatory-reason gate on negative actions,
 * business-rule re-check server-side before approve), adapted to the
 * b2b_* schema and b2b_change_status() helper.
 */

require_permission('b2b_travel_partners.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

$b2bStatusBadgeMap = [
    'draft' => 'neutral', 'submitted' => 'info', 'under_review' => 'warning', 'documents_required' => 'warning',
    'verification_pending' => 'warning', 'approved' => 'success', 'active' => 'success', 'suspended' => 'danger',
    'rejected' => 'danger', 'blacklisted' => 'danger', 'closed' => 'neutral',
];
$b2bAllStatuses = array_keys(B2B_STATUS_LABELS);

$admins = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

// --- Handle POST ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('b2b_travel_partners.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $targetId = (int) ($_POST['id'] ?? 0);

    $reasonRequiredActions = ['reject', 'documents_required', 'suspend', 'blacklist', 'close'];
    $remarks = trim((string) ($_POST['remarks'] ?? '')) ?: null;
    if (in_array($postAction, $reasonRequiredActions, true) && $remarks === null) {
        flash_set('admin_error', 'A reason is required for this action.');
        redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
    }

    $statusActions = [
        'start_review' => ['under_review', 'Your application is now under review', 'Our B2B onboarding team has started reviewing your application.'],
        'documents_required' => ['documents_required', 'Additional documents required', 'Our team needs more information before approving your application: ' . (string) $remarks],
        'reject' => ['rejected', 'Your application was not approved', 'Reason: ' . (string) $remarks],
        'suspend' => ['suspended', 'Your partner account has been suspended', 'Reason: ' . (string) $remarks],
        'reactivate' => ['active', 'Your partner account has been reactivated', 'Your account access has been restored.'],
        'blacklist' => ['blacklisted', 'Your partner account has been blacklisted', 'Reason: ' . (string) $remarks],
        'close' => ['closed', 'Your partner account has been closed', $remarks ?? 'Contact B2B support if you have questions.'],
    ];

    if ($postAction === 'approve' && $targetId) {
        // Client spec principle carried over from the old partner
        // system: never trust a hidden button as the real business-rule
        // boundary. Re-checked here, not just hidden client-side — every
        // uploaded KYC document must be resolved (verified, none still
        // pending review or rejected) and at least one must exist.
        $docsStmt = $pdo->prepare("SELECT verification_status FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL");
        $docsStmt->execute(['id' => $targetId]);
        $docStatuses = $docsStmt->fetchAll(PDO::FETCH_COLUMN);
        $unresolved = array_filter($docStatuses, static fn($s) => $s !== 'verified');

        if (count($docStatuses) === 0) {
            flash_set('admin_error', 'This partner has not uploaded any KYC documents yet — cannot approve.');
            redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
        }
        if (count($unresolved) > 0) {
            flash_set('admin_error', 'All uploaded documents must be verified before approving this partner.');
            redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
        }

        $pdo->prepare("UPDATE b2b_partners SET approved_at = NOW(), rejection_reason = NULL WHERE id = :id")->execute(['id' => $targetId]);
        b2b_change_status($targetId, 'active', current_admin_id(), $remarks);
        log_action('approve', 'b2b_partners', $targetId, null, 'active');

        $emailStmt = $pdo->prepare("SELECT email FROM b2b_partner_users WHERE b2b_partner_id = :id AND role = 'partner_admin' ORDER BY id ASC LIMIT 1");
        $emailStmt->execute(['id' => $targetId]);
        if ($email = $emailStmt->fetchColumn()) {
            send_mail((string) $email, 'Your Visagiri B2B Partner account is approved', '<p>Congratulations — your Visagiri B2B Travel Partner account is now active. You can sign in and start submitting visa enquiries.</p>', null);
        }
        flash_set('admin_notice', 'Partner approved and activated.');
        redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
    }

    if (isset($statusActions[$postAction]) && $targetId) {
        [$newStatus, $subject, $body] = $statusActions[$postAction];
        if ($newStatus === 'rejected') {
            $pdo->prepare('UPDATE b2b_partners SET rejection_reason = :reason WHERE id = :id')->execute(['reason' => $remarks, 'id' => $targetId]);
        }
        b2b_change_status($targetId, $newStatus, current_admin_id(), $remarks);
        log_action($postAction, 'b2b_partners', $targetId, null, $newStatus);

        $emailStmt = $pdo->prepare("SELECT email FROM b2b_partner_users WHERE b2b_partner_id = :id AND role = 'partner_admin' ORDER BY id ASC LIMIT 1");
        $emailStmt->execute(['id' => $targetId]);
        if ($email = $emailStmt->fetchColumn()) {
            send_mail((string) $email, $subject, '<p>' . nl2br(e($body)) . '</p>', null);
        }
        flash_set('admin_notice', 'Status updated.');
        redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
    }

    if ($postAction === 'verify_document' && $targetId) {
        $docId = (int) ($_POST['document_id'] ?? 0);
        $verifyStatus = $_POST['verify_status'] ?? '';
        if ($docId && in_array($verifyStatus, ['verified', 'rejected'], true)) {
            $docRemarks = trim((string) ($_POST['verification_remarks'] ?? '')) ?: null;
            $pdo->prepare(
                'UPDATE b2b_partner_documents SET verification_status = :status, verification_remarks = :remarks, reviewed_by = :admin, reviewed_at = NOW()
                 WHERE id = :id AND b2b_partner_id = :partner_id'
            )->execute(['status' => $verifyStatus, 'remarks' => $docRemarks, 'admin' => current_admin_id(), 'id' => $docId, 'partner_id' => $targetId]);
            log_action('b2b_document_verification', 'b2b_partner_documents', $docId, null, $verifyStatus);
            flash_set('admin_notice', 'Document ' . $verifyStatus . '.');
        }
        redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
    }

    if ($postAction === 'assign_manager' && $targetId) {
        $newManagerId = ($_POST['assigned_admin_id'] ?? '') !== '' ? (int) $_POST['assigned_admin_id'] : null;
        $pdo->prepare('UPDATE b2b_partners SET assigned_relationship_manager = :manager WHERE id = :id')
            ->execute(['manager' => $newManagerId, 'id' => $targetId]);
        log_action('assign_manager', 'b2b_partners', $targetId, null, $newManagerId !== null ? (string) $newManagerId : 'unassigned');
        flash_set('admin_notice', 'Relationship Manager updated.');
        redirect('/admin/b2b-partners/?action=view&id=' . $targetId);
    }

    redirect('/admin/b2b-partners/');
}

// --- Detail view ---
if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        "SELECT p.*, m.full_name AS manager_name
         FROM b2b_partners p
         LEFT JOIN admin_users m ON m.id = p.assigned_relationship_manager
         WHERE p.id = :id AND p.deleted_at IS NULL"
    );
    $stmt->execute(['id' => $id]);
    $partner = $stmt->fetch();
    if (!$partner) {
        flash_set('admin_error', 'B2B partner not found.');
        redirect('/admin/b2b-partners/');
    }

    $usersStmt = $pdo->prepare('SELECT * FROM b2b_partner_users WHERE b2b_partner_id = :id AND deleted_at IS NULL ORDER BY id ASC');
    $usersStmt->execute(['id' => $id]);
    $partnerUsers = $usersStmt->fetchAll();

    $documentsStmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documentsStmt->execute(['id' => $id]);
    $partnerDocuments = $documentsStmt->fetchAll();

    $servicesStmt = $pdo->prepare('SELECT service_key FROM b2b_partner_services WHERE b2b_partner_id = :id');
    $servicesStmt->execute(['id' => $id]);
    $partnerServices = $servicesStmt->fetchAll(PDO::FETCH_COLUMN);

    $countriesStmt = $pdo->prepare(
        'SELECT c.name FROM b2b_partner_countries pc JOIN countries c ON c.id = pc.country_id WHERE pc.b2b_partner_id = :id ORDER BY c.name'
    );
    $countriesStmt->execute(['id' => $id]);
    $partnerCountries = $countriesStmt->fetchAll(PDO::FETCH_COLUMN);

    $enquiriesStmt = $pdo->prepare(
        'SELECT e.id, e.enquiry_reference_no, e.status, e.created_at, c.name AS country_name
         FROM b2b_visa_enquiries e JOIN countries c ON c.id = e.destination_country_id
         WHERE e.b2b_partner_id = :id AND e.deleted_at IS NULL ORDER BY e.created_at DESC LIMIT 10'
    );
    $enquiriesStmt->execute(['id' => $id]);
    $partnerEnquiries = $enquiriesStmt->fetchAll();
    $enquiryStatusBadgeMap = [
        'new' => 'info', 'in_progress' => 'warning', 'documents_pending' => 'warning',
        'submitted' => 'info', 'payment_pending' => 'warning', 'completed' => 'success',
        'rejected' => 'danger', 'cancelled' => 'neutral',
    ];

    $canViewBilling = has_permission('b2b_travel_partners.billing.view');
    $billing = null;
    if ($canViewBilling) {
        $billingStmt = $pdo->prepare('SELECT * FROM b2b_partner_billing WHERE b2b_partner_id = :id');
        $billingStmt->execute(['id' => $id]);
        $billing = $billingStmt->fetch() ?: null;
    }

    $historyStmt = $pdo->prepare(
        'SELECT h.*, a.full_name AS changed_by_name FROM b2b_status_history h
         LEFT JOIN admin_users a ON a.id = h.changed_by
         WHERE h.b2b_partner_id = :id ORDER BY h.created_at DESC'
    );
    $historyStmt->execute(['id' => $id]);
    $history = $historyStmt->fetchAll();

    $canManage = has_permission('b2b_travel_partners.manage');
    $docStatuses = array_column($partnerDocuments, 'verification_status');
    $canApprove = count($docStatuses) > 0 && count(array_filter($docStatuses, static fn($s) => $s !== 'verified')) === 0;

    admin_header_start($partner['legal_business_name'], 'b2b-partners');
    ?>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Partner ID:</strong> <?= e($partner['partner_reference_no']) ?></p>
        <p><strong>Trade Name:</strong> <?= e($partner['trade_name'] ?? '—') ?> &middot; <strong>Business Type:</strong> <?= e(B2B_BUSINESS_TYPES[$partner['business_type']] ?? $partner['business_type']) ?></p>
        <p><strong>Email:</strong> <?= e($partner['business_email']) ?> &middot; <strong>Phone:</strong> <?= e($partner['business_phone']) ?></p>
        <p><strong>Address:</strong> <?= e($partner['office_address']) ?>, <?= e($partner['city']) ?>, <?= e($partner['state']) ?>, <?= e($partner['country']) ?> <?= e($partner['pincode']) ?></p>
        <p><strong>GSTIN:</strong> <?= e($partner['gstin'] ?? '—') ?> &middot; <strong>PAN:</strong> <?= e($partner['pan'] ?? '—') ?> &middot; <strong>IATA:</strong> <?= e($partner['iata_number'] ?? '—') ?> &middot; <strong>TIDS:</strong> <?= e($partner['tids_number'] ?? '—') ?> &middot; <strong>Udyam:</strong> <?= e($partner['udyam_number'] ?? '—') ?></p>
        <p><strong>Status:</strong> <?= status_badge((string) $partner['status'], $b2bStatusBadgeMap) ?><?= $partner['rejection_reason'] ? ' — ' . e($partner['rejection_reason']) : '' ?></p>
        <p><strong>Submitted:</strong> <?= $partner['submitted_at'] ? e(date('d M Y', strtotime((string) $partner['submitted_at']))) : 'Not yet submitted' ?><?php if ($partner['approved_at']): ?> &middot; <strong>Approved:</strong> <?= e(date('d M Y', strtotime((string) $partner['approved_at']))) ?><?php endif; ?></p>
        <p><strong>Relationship Manager:</strong> <?= e($partner['manager_name'] ?? 'Unassigned') ?></p>

        <?php if ($canManage): ?>
        <form method="post" action="/admin/b2b-partners/" style="margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
            <div class="form-group">
                <label class="form-label" for="remarks">Reason / Remarks <span style="color:var(--text-muted);font-weight:normal">(required for Reject, Request Documents, Suspend, Blacklist, Close)</span></label>
                <textarea class="form-textarea" id="remarks" name="remarks" rows="2" style="width:100%;max-width:520px"></textarea>
            </div>
            <div style="display:flex;gap:var(--space-2);flex-wrap:wrap;margin-top:var(--space-2)">
                <?php if ($partner['status'] === 'submitted'): ?>
                    <button type="submit" name="action" value="start_review" class="btn btn-outline btn-sm">Start Review</button>
                <?php endif; ?>
                <?php if (in_array($partner['status'], ['submitted', 'under_review', 'documents_required', 'verification_pending'], true)): ?>
                    <?php if ($canApprove): ?>
                    <button type="submit" name="action" value="approve" class="btn btn-primary btn-sm">Approve &amp; Activate</button>
                    <?php else: ?>
                    <button type="button" class="btn btn-primary btn-sm" disabled title="All KYC documents must be verified first">Approve &amp; Activate</button>
                    <?php endif; ?>
                    <button type="submit" name="action" value="documents_required" class="btn btn-outline btn-sm">Request Documents</button>
                    <button type="submit" name="action" value="reject" class="btn btn-outline btn-sm">Reject</button>
                <?php elseif ($partner['status'] === 'active'): ?>
                    <button type="submit" name="action" value="suspend" class="btn btn-outline btn-sm">Suspend</button>
                    <button type="submit" name="action" value="blacklist" class="btn btn-outline btn-sm">Blacklist</button>
                    <button type="submit" name="action" value="close" class="btn btn-outline btn-sm">Close</button>
                <?php elseif ($partner['status'] === 'suspended'): ?>
                    <button type="submit" name="action" value="reactivate" class="btn btn-outline btn-sm">Reactivate</button>
                    <button type="submit" name="action" value="blacklist" class="btn btn-outline btn-sm">Blacklist</button>
                    <button type="submit" name="action" value="close" class="btn btn-outline btn-sm">Close</button>
                <?php else: ?>
                    <p style="color:var(--text-muted);font-size:var(--font-size-sm)">This status is terminal — no further actions available.</p>
                <?php endif; ?>
            </div>
        </form>
        <form method="post" action="/admin/b2b-partners/" style="display:flex;gap:var(--space-2);align-items:center;margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="assign_manager">
            <select name="assigned_admin_id" class="form-select">
                <option value="">Unassigned</option>
                <?php foreach ($admins as $a): ?>
                <option value="<?= (int) $a['id'] ?>"<?= (int) $a['id'] === (int) ($partner['assigned_relationship_manager'] ?? 0) ? ' selected' : '' ?>><?= e($a['full_name']) ?></option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn btn-outline btn-sm">Set Manager</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Contacts / Users (<?= count($partnerUsers) ?>)</h2>
    <table class="admin-table" style="margin-bottom:var(--space-6)"><thead><tr><th>Name</th><th>Role</th><th>Email</th><th>Mobile</th><th>Verified</th></tr></thead><tbody>
        <?php foreach ($partnerUsers as $u): ?>
        <tr>
            <td><?= e($u['full_name']) ?> (<?= e(B2B_DESIGNATIONS[$u['designation']] ?? $u['designation']) ?>)</td>
            <td><?= e(B2B_ROLES[$u['role']] ?? $u['role']) ?></td>
            <td><?= e($u['email']) ?></td>
            <td><?= e($u['mobile_country_code'] . ' ' . $u['mobile_number']) ?></td>
            <td><?= $u['email_verified_at'] && $u['mobile_verified_at'] ? '<span class="badge badge-success">Yes</span>' : '<span class="badge badge-warning">Partial</span>' ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>

    <h2 class="country-directory__subheading">Visa Enquiries <a href="/admin/b2b-enquiries/?q=<?= urlencode($partner['legal_business_name']) ?>" class="btn btn-outline btn-sm" style="font-weight:normal;text-transform:none">View All</a></h2>
    <?php if (!$partnerEnquiries): ?>
    <p class="empty-state">No visa enquiries submitted yet.</p>
    <?php else: ?>
    <table class="admin-table" style="margin-bottom:var(--space-6)"><thead><tr><th>Reference</th><th>Destination</th><th>Status</th><th>Created</th></tr></thead><tbody>
        <?php foreach ($partnerEnquiries as $e): ?>
        <tr>
            <td><a href="/admin/b2b-enquiries/?action=view&id=<?= (int) $e['id'] ?>"><?= e($e['enquiry_reference_no']) ?></a></td>
            <td><?= e($e['country_name']) ?></td>
            <td><?= status_badge((string) $e['status'], $enquiryStatusBadgeMap) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $e['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Services &amp; Countries</h2>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Visa Services:</strong> <?= $partnerServices ? e(implode(', ', array_map(static fn($k) => B2B_VISA_SERVICES[$k] ?? $k, $partnerServices))) : '—' ?></p>
        <p><strong>Preferred Destination Countries:</strong> <?= $partnerCountries ? e(implode(', ', $partnerCountries)) : '—' ?></p>
        <p><strong>Monthly Visa Volume:</strong> <?= e($partner['monthly_visa_volume'] ?? '—') ?></p>
    </div>

    <h2 class="country-directory__subheading">KYC Documents (<?= count($partnerDocuments) ?>)</h2>
    <?php if (!$partnerDocuments): ?>
    <p class="empty-state">No documents uploaded yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>Type</th><th>File</th><th>Verification</th><th>Remarks</th><th>Uploaded</th><th></th></tr></thead><tbody>
        <?php foreach ($partnerDocuments as $doc): ?>
        <tr>
            <td><?= e(B2B_DOCUMENT_TYPES[$doc['document_type']] ?? $doc['document_type']) ?></td>
            <td><?= e($doc['original_filename']) ?></td>
            <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($doc['verification_status']) ?></span></td>
            <td><?= e($doc['verification_remarks'] ?? '—') ?></td>
            <td><?= e(date('d M Y', strtotime((string) $doc['uploaded_at']))) ?></td>
            <td class="actions">
                <a href="/admin/b2b-partner-document-download/?id=<?= (int) $doc['id'] ?>" class="btn btn-outline btn-sm">Download</a>
                <?php if ($canManage && $doc['verification_status'] !== 'verified'): ?>
                <form method="post" action="/admin/b2b-partners/" style="display:inline-flex;gap:var(--space-1);align-items:center">
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

    <?php if ($canViewBilling): ?>
    <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Billing / Banking Details</h2>
    <?php if (!$billing): ?>
    <p class="empty-state">Not submitted (billing is optional at signup).</p>
    <?php else: ?>
    <div class="admin-form-card" style="max-width:900px">
        <p><strong>Billing Name:</strong> <?= e($billing['billing_name'] ?? '—') ?> &middot; <strong>GSTIN:</strong> <?= e($billing['gstin'] ?? '—') ?> &middot; <strong>PAN:</strong> <?= e($billing['pan'] ?? '—') ?></p>
        <p><strong>Bank:</strong> <?= e(decrypt_value($billing['bank_name_encrypted']) ?? '—') ?> &middot; <strong>Account Holder:</strong> <?= e(decrypt_value($billing['account_holder_encrypted']) ?? '—') ?></p>
        <p><strong>Account Number:</strong> <?= e(decrypt_value($billing['account_number_encrypted']) ?? '—') ?> &middot; <strong>IFSC:</strong> <?= e(decrypt_value($billing['ifsc_encrypted']) ?? '—') ?></p>
        <p><strong>Preferred Currency:</strong> <?= e($billing['preferred_currency']) ?> &middot; <strong>Payment Terms:</strong> <?= e($billing['payment_terms'] ?? '—') ?></p>
    </div>
    <?php endif; ?>
    <?php endif; ?>

    <h2 class="country-directory__subheading" style="margin-top:var(--space-6)">Status History</h2>
    <?php if (!$history): ?>
    <p class="empty-state">No status changes recorded yet.</p>
    <?php else: ?>
    <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>Reason</th><th>Changed By</th><th>When</th></tr></thead><tbody>
        <?php foreach ($history as $h): ?>
        <tr>
            <td><?= e($h['old_status'] !== null ? (B2B_STATUS_LABELS[$h['old_status']] ?? $h['old_status']) : '—') ?></td>
            <td><?= e(B2B_STATUS_LABELS[$h['new_status']] ?? $h['new_status']) ?></td>
            <td><?= e($h['reason'] ?? '—') ?></td>
            <td><?= e($h['changed_by_name'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/b2b-partners/">&larr; Back to all B2B partners</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = in_array($_GET['status'] ?? '', $b2bAllStatuses, true) ? $_GET['status'] : null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['p.deleted_at IS NULL'];
$params = [];
if ($search !== '') {
    $where[] = '(p.legal_business_name LIKE :search1 OR p.business_email LIKE :search2 OR p.partner_reference_no LIKE :search3 OR p.business_phone LIKE :search4 OR p.city LIKE :search5)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = $params['search5'] = $searchTerm;
}
if ($statusFilter) {
    $where[] = 'p.status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_partners p WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT p.*, m.full_name AS manager_name,
            (SELECT COUNT(*) FROM b2b_partner_documents d WHERE d.b2b_partner_id = p.id AND d.deleted_at IS NULL) AS document_count,
            (SELECT full_name FROM b2b_partner_users u WHERE u.b2b_partner_id = p.id AND u.role = 'partner_admin' ORDER BY u.id ASC LIMIT 1) AS contact_name
     FROM b2b_partners p
     LEFT JOIN admin_users m ON m.id = p.assigned_relationship_manager
     WHERE $whereSql ORDER BY (p.status IN ('submitted', 'under_review')) DESC, p.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$partners = $stmt->fetchAll();

$pendingCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partners WHERE status IN ('submitted', 'under_review') AND deleted_at IS NULL")->fetchColumn();

admin_header_start('B2B Travel Partners', 'b2b-partners');
?>
<?php if ($pendingCount > 0): ?>
<div class="alert alert-warning"><?= $pendingCount ?> B2B partner application<?= $pendingCount === 1 ? '' : 's' ?> awaiting review.</div>
<?php endif; ?>
<div class="admin-toolbar">
    <form method="get" action="/admin/b2b-partners/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search business, email, reference, phone, city…">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <?php foreach ($b2bAllStatuses as $s): ?>
            <option value="<?= $s ?>"<?= $statusFilter === $s ? ' selected' : '' ?>><?= e(B2B_STATUS_LABELS[$s]) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
</div>
<table class="admin-table">
    <thead><tr><th>Business</th><th>Contact</th><th>City</th><th>Reference</th><th>Documents</th><th>Manager</th><th>Status</th><th>Registered</th></tr></thead>
    <tbody>
    <?php foreach ($partners as $p): ?>
        <tr>
            <td><a href="/admin/b2b-partners/?action=view&id=<?= (int) $p['id'] ?>"><?= e($p['legal_business_name']) ?></a></td>
            <td><?= e($p['contact_name'] ?? '—') ?></td>
            <td><?= e($p['city']) ?></td>
            <td><?= e($p['partner_reference_no']) ?></td>
            <td><?= (int) $p['document_count'] ?></td>
            <td><?= e($p['manager_name'] ?? '—') ?></td>
            <td><?= status_badge((string) $p['status'], $b2bStatusBadgeMap) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $p['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$partners): ?>
        <tr><td colspan="8"><p class="empty-state">No B2B partners found.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/b2b-partners/?page=<?= $p ?><?= $search !== '' ? '&q=' . urlencode($search) : '' ?><?= $statusFilter ? '&status=' . urlencode($statusFilter) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
