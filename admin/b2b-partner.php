<?php
$ADMIN_PAGE_TITLE = 'Partner Profile';
$ADMIN_ACTIVE_NAV = 'b2b-partners';
require __DIR__ . '/includes/layout-top.php';

$ref = trim($_GET['ref'] ?? '');
$stmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE application_ref = ?');
$stmt->execute([$ref]);
$partner = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$partner) {
    http_response_code(404);
    echo '<div class="crm-card">Partner application not found.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}
$partnerId = (int) $partner['id'];
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', $partner['application_ref']];

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'change_status' && b2b_can_manage_enrollment()) {
        $newStatus = trim($_POST['status'] ?? '');
        $reason = trim($_POST['reason'] ?? '');
        $needsReason = in_array($newStatus, ['Rejected', 'Documents Required', 'Suspended', 'Deactivated'], true);

        if (!in_array($newStatus, B2B_PARTNER_STATUSES, true)) {
            $actionError = 'Invalid status.';
        } elseif ($needsReason && $reason === '') {
            $actionError = 'Please provide a reason for this action.';
        } else {
            $oldStatus = $partner['status'];
            $now = gmdate('c');
            $fields = ['status' => $newStatus, 'updated_at' => $now, 'status_note' => $reason ?: null];
            if ($newStatus === 'Rejected') { $fields['rejection_reason'] = $reason; }
            if ($newStatus === 'Approved') { $fields['approved_at'] = $now; $fields['approved_by'] = admin_name(); }

            $setSql = implode(', ', array_map(fn($k) => "$k = :$k", array_keys($fields)));
            $pdo->prepare("UPDATE b2b_partners SET $setSql WHERE id = :id")->execute($fields + ['id' => $partnerId]);
            $partner = array_merge($partner, $fields);

            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Changed status', $oldStatus, $newStatus . ($reason ? " ($reason)" : ''));
            b2b_notify($pdo, null, 'b2b_status_change', "{$partner['company_name']} ({$partner['application_ref']}) status changed to $newStatus.", $partnerId);

            $statusEmails = [
                'Under Review' => ['subj' => 'Your Application is Under Review', 'body' => "Your application {$partner['application_ref']} is now under review by our B2B team."],
                'Documents Required' => ['subj' => 'Additional Documents Required', 'body' => "We need more information to proceed with {$partner['application_ref']}:\n\n$reason"],
                'Verification' => ['subj' => 'Your Application is in Verification', 'body' => "Your application {$partner['application_ref']} has moved to the verification stage."],
                'Approved' => ['subj' => 'Welcome to the VisaAgency.in B2B Partner Programme!', 'body' => "Congratulations! Your application {$partner['application_ref']} has been approved.\n\nYou can now log in with the username you registered ({$partner['contact_email']}) and the password you set during registration."],
                'Rejected' => ['subj' => 'Update on Your Application', 'body' => "We're unable to move forward with application {$partner['application_ref']} at this time.\n\nReason: $reason"],
                'Suspended' => ['subj' => 'Your Partner Account Has Been Suspended', 'body' => "Your partner account ({$partner['application_ref']}) has been suspended.\n\nReason: $reason\n\nPlease contact your Relationship Manager."],
                'Deactivated' => ['subj' => 'Your Partner Account Has Been Deactivated', 'body' => "Your partner account ({$partner['application_ref']}) has been deactivated.\n\nReason: $reason"],
            ];
            if (isset($statusEmails[$newStatus])) {
                b2b_notify_partner($pdo, $partner, $statusEmails[$newStatus]['subj'] . " — {$partner['application_ref']}", "Dear {$partner['contact_name']},\n\n" . $statusEmails[$newStatus]['body'] . "\n\nRegards,\nVisaAgency.in B2B Partner Team");
            }
            $actionMessage = "Status changed to $newStatus.";
        }
    } elseif ($action === 'assign_manager' && b2b_can_assign_manager()) {
        $managerId = filter_var($_POST['manager_id'] ?? '', FILTER_VALIDATE_INT) ?: null;
        $pdo->prepare('UPDATE b2b_partners SET assigned_manager_id = ?, updated_at = ? WHERE id = ?')->execute([$managerId, gmdate('c'), $partnerId]);
        $mgrName = '';
        if ($managerId) {
            $mstmt = $pdo->prepare('SELECT name FROM users WHERE id = ?');
            $mstmt->execute([$managerId]);
            $mgrName = (string) $mstmt->fetchColumn();
        }
        b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Assigned Relationship Manager', $partner['assigned_manager_id'] ?? '', $mgrName ?: 'Unassigned');
        $partner['assigned_manager_id'] = $managerId;
        $actionMessage = 'Relationship Manager updated.';
    } elseif ($action === 'create_quotation' && b2b_can_manage_quotations()) {
        $serviceCategory = trim($_POST['service_category'] ?? '');
        $country = trim($_POST['country'] ?? '');
        $visaType = trim($_POST['visa_type'] ?? '');
        $applicantsCount = max(1, (int) ($_POST['applicants_count'] ?? 1));
        $enquiryId = filter_var($_POST['enquiry_id'] ?? '', FILTER_VALIDATE_INT) ?: null;

        $fees = [];
        foreach (['visa_fee', 'service_fee', 'embassy_fee', 'appointment_fee', 'courier_fee', 'other_charges', 'discount', 'gst'] as $f) {
            $fees[$f] = filter_var($_POST[$f] ?? '0', FILTER_VALIDATE_FLOAT) ?: 0;
        }

        if (!in_array($serviceCategory, B2B_SERVICES_OFFERED, true) || $country === '' || $visaType === '') {
            $actionError = 'Please provide a valid service category, country and visa type for the quotation.';
        } elseif ($enquiryId) {
            $eqStmt = $pdo->prepare('SELECT id FROM enquiries WHERE id = ? AND partner_id = ?');
            $eqStmt->execute([$enquiryId, $partnerId]);
            if (!$eqStmt->fetchColumn()) {
                $actionError = 'That application does not belong to this partner.';
                $enquiryId = null;
            }
        }

        if ($actionError === '') {
            $total = round($fees['visa_fee'] + $fees['service_fee'] + $fees['embassy_fee'] + $fees['appointment_fee'] + $fees['courier_fee'] + $fees['other_charges'] - $fees['discount'] + $fees['gst'], 2);
            $validityDays = (int) b2b_setting($pdo, 'quotation_validity_days', '15');
            $threshold = (float) b2b_setting($pdo, 'quotation_approval_threshold_inr', '100000');
            $needsApproval = $total > $threshold;
            $quoteRef = b2b_generate_ref($pdo, b2b_setting($pdo, 'quotation_ref_prefix', 'B2B-QT'));
            $now = gmdate('c');

            $insQ = $pdo->prepare('INSERT INTO b2b_quotations (
                quotation_ref, partner_id, enquiry_id, service_category, country, visa_type, applicants_count,
                visa_fee, service_fee, embassy_fee, appointment_fee, courier_fee, other_charges, discount, gst, total,
                valid_until, status, created_by, created_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
            $insQ->execute([
                $quoteRef, $partnerId, $enquiryId, $serviceCategory, $country, $visaType, $applicantsCount,
                $fees['visa_fee'], $fees['service_fee'], $fees['embassy_fee'], $fees['appointment_fee'], $fees['courier_fee'], $fees['other_charges'], $fees['discount'], $fees['gst'], $total,
                gmdate('c', strtotime("+$validityDays days")), $needsApproval ? 'Draft' : 'Sent', admin_name(), $now,
            ]);
            $quotationId = (int) $pdo->lastInsertId();

            b2b_log_audit($pdo, 'quotation', $quotationId, admin_name(), admin_role(), 'Created quotation', '', "$quoteRef — $serviceCategory — ₹$total" . ($needsApproval ? ' (requires approval)' : ''));

            if ($needsApproval) {
                b2b_notify($pdo, null, 'b2b_quotation_approval', "Quotation $quoteRef for {$partner['company_name']} (₹" . number_format($total, 2) . ') exceeds the approval threshold and needs sign-off.', $partnerId);
            } else {
                b2b_notify($pdo, null, 'b2b_quotation_sent', "Quotation $quoteRef sent to {$partner['company_name']}: ₹" . number_format($total, 2) . '.', $partnerId);
                b2b_notify_partner(
                    $pdo, $partner, "New Quotation Ready — $quoteRef",
                    "Dear {$partner['contact_name']},\n\nA new quotation is ready for your review.\n\nReference: $quoteRef\nService: $serviceCategory\nDestination: $country\nTotal: ₹" . number_format($total, 2) . "\n\nPlease log in to your Partner Portal to accept, reject or request a revision.\n\nRegards,\nVisaAgency.in B2B Partner Team"
                );
            }
            $actionMessage = "Quotation $quoteRef created" . ($needsApproval ? ' and is awaiting internal approval.' : ' and sent to the partner.');
        }
    } elseif ($action === 'send_quotation' && b2b_can_approve_quotation()) {
        $quotationId = (int) ($_POST['quotation_id'] ?? 0);
        $qStmt = $pdo->prepare('SELECT * FROM b2b_quotations WHERE id = ? AND partner_id = ?');
        $qStmt->execute([$quotationId, $partnerId]);
        $quotation = $qStmt->fetch(PDO::FETCH_ASSOC);
        if ($quotation && $quotation['status'] === 'Draft') {
            $pdo->prepare("UPDATE b2b_quotations SET status = 'Sent' WHERE id = ?")->execute([$quotationId]);
            b2b_log_audit($pdo, 'quotation', $quotationId, admin_name(), admin_role(), 'Approved and sent quotation', 'Draft', 'Sent');
            b2b_notify_partner(
                $pdo, $partner, "New Quotation Ready — {$quotation['quotation_ref']}",
                "Dear {$partner['contact_name']},\n\nA new quotation is ready for your review.\n\nReference: {$quotation['quotation_ref']}\nService: {$quotation['service_category']}\nDestination: {$quotation['country']}\nTotal: ₹" . number_format((float) $quotation['total'], 2) . "\n\nPlease log in to your Partner Portal to accept, reject or request a revision.\n\nRegards,\nVisaAgency.in B2B Partner Team"
            );
            $actionMessage = "Quotation {$quotation['quotation_ref']} approved and sent to the partner.";
        }
    }
}

$docsStmt = $pdo->prepare('SELECT * FROM b2b_partner_documents d WHERE partner_id = ? AND id = (
    SELECT MAX(id) FROM b2b_partner_documents WHERE partner_id = ? AND doc_type = d.doc_type
) ORDER BY doc_type');
$docsStmt->execute([$partnerId, $partnerId]);
$documents = [];
foreach ($docsStmt->fetchAll(PDO::FETCH_ASSOC) as $d) { $documents[$d['doc_type']] = $d; }

$managers = $pdo->query("SELECT id, name, role FROM users WHERE role IN ('Super Admin','B2B Admin','B2B Relationship Manager') ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);
$auditStmt = $pdo->prepare("SELECT * FROM b2b_audit_logs WHERE entity_type = 'partner' AND entity_id = ? ORDER BY id DESC LIMIT 50");
$auditStmt->execute([$partnerId]);
$auditLog = $auditStmt->fetchAll(PDO::FETCH_ASSOC);

$visaCasesStmt = $pdo->prepare('SELECT * FROM enquiries WHERE partner_id = ? AND archived_at IS NULL ORDER BY created_at DESC');
$visaCasesStmt->execute([$partnerId]);
$visaCases = $visaCasesStmt->fetchAll(PDO::FETCH_ASSOC);
$visaCaseCount = count($visaCases);

$quotationsStmt = $pdo->prepare('SELECT * FROM b2b_quotations WHERE partner_id = ? ORDER BY created_at DESC');
$quotationsStmt->execute([$partnerId]);
$quotations = $quotationsStmt->fetchAll(PDO::FETCH_ASSOC);

$servicesOffered = json_decode($partner['services_offered'] ?? '[]', true) ?: [];
$visaSpecialization = json_decode($partner['visa_specialization'] ?? '[]', true) ?: [];

$tab = $_GET['tab'] ?? 'overview';
$tabs = [
    'overview' => 'Overview', 'company' => 'Company Information', 'documents' => 'Documents',
    'applications' => 'Visa Applications', 'quotations' => 'Quotations', 'invoices' => 'Invoices',
    'payments' => 'Payments', 'communications' => 'Communications', 'activities' => 'Activities',
];
$builtTabs = ['overview', 'company', 'documents', 'applications', 'quotations', 'activities'];
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title"><?php echo htmlspecialchars($partner['company_name']); ?></h1>
        <p class="crm-page-subtitle"><?php echo htmlspecialchars($partner['application_ref']); ?> &middot; <span class="crm-status-badge <?php echo b2b_status_class($partner['status']); ?>"><?php echo htmlspecialchars($partner['status']); ?></span></p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="crm-alert crm-alert-success"><i class="fa-solid fa-circle-check"></i> <?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="crm-alert crm-alert-error"><i class="fa-solid fa-circle-exclamation"></i> <?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<?php if (b2b_can_manage_enrollment()): ?>
<div class="crm-card" style="margin-bottom:16px;">
    <h3 style="margin:0 0 12px;font-size:14px;">Application Actions</h3>
    <div style="display:flex;gap:10px;flex-wrap:wrap;align-items:flex-start;">
        <?php
        $actionButtons = [
            'Under Review' => ['label' => 'Mark Under Review', 'reason' => false],
            'Verification' => ['label' => 'Move to Verification', 'reason' => false],
            'Documents Required' => ['label' => 'Request Documents', 'reason' => true],
            'Approved' => ['label' => 'Approve', 'reason' => false],
            'Rejected' => ['label' => 'Reject', 'reason' => true],
            'Suspended' => ['label' => 'Suspend', 'reason' => true],
            'Deactivated' => ['label' => 'Deactivate', 'reason' => true],
        ];
        foreach ($actionButtons as $statusVal => $cfg):
            if ($statusVal === $partner['status']) { continue; }
        ?>
        <form method="post" class="b2b-admin-action-form" data-needs-reason="<?php echo $cfg['reason'] ? '1' : '0'; ?>">
            <input type="hidden" name="action" value="change_status">
            <input type="hidden" name="status" value="<?php echo htmlspecialchars($statusVal); ?>">
            <?php if ($cfg['reason']): ?>
            <input type="text" name="reason" placeholder="Reason (required)..." class="b2b-admin-reason-input" style="font-size:12px;padding:6px 10px;border:1px solid var(--c-border);border-radius:6px;width:180px;margin-right:6px;">
            <?php endif; ?>
            <button type="submit" class="crm-btn crm-btn-sm <?php echo $statusVal === 'Approved' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($cfg['label']); ?></button>
        </form>
        <?php endforeach; ?>
    </div>
</div>
<script>
document.querySelectorAll('.b2b-admin-action-form[data-needs-reason="1"]').forEach(function (f) {
    f.addEventListener('submit', function (e) {
        var input = f.querySelector('.b2b-admin-reason-input');
        if (input && !input.value.trim()) { e.preventDefault(); input.focus(); input.style.borderColor = '#C0392B'; }
    });
});
</script>
<?php endif; ?>

<div class="crm-tabs" style="margin-bottom:16px;">
    <?php foreach ($tabs as $key => $label): ?>
    <a href="?ref=<?php echo urlencode($ref); ?>&tab=<?php echo $key; ?>" class="crm-tab <?php echo $tab === $key ? 'active' : ''; ?> <?php echo !in_array($key, $builtTabs, true) ? 'is-soon' : ''; ?>">
        <?php echo htmlspecialchars($label); ?>
        <?php if (!in_array($key, $builtTabs, true)): ?><span class="crm-soon-pill">Soon</span><?php endif; ?>
    </a>
    <?php endforeach; ?>
</div>

<?php if ($tab === 'overview' || !in_array($tab, $builtTabs, true)): ?>
    <?php if (!in_array($tab, $builtTabs, true) && $tab !== 'overview'): ?>
    <div class="crm-card"><p class="crm-empty">This tab is coming in a later phase of the B2B Partner Portal build.</p></div>
    <?php else: ?>
    <div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr); margin-bottom:16px;">
        <div class="crm-kpi"><div class="crm-kpi-value"><?php echo htmlspecialchars($partner['application_ref']); ?></div><div class="crm-kpi-label">Partner ID</div></div>
        <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $visaCaseCount; ?></div><div class="crm-kpi-label">Total Visa Cases</div></div>
        <div class="crm-kpi"><div class="crm-kpi-value">₹0</div><div class="crm-kpi-label">Total Revenue</div></div>
        <div class="crm-kpi"><div class="crm-kpi-value">₹0</div><div class="crm-kpi-label">Outstanding Balance</div></div>
    </div>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Overview</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Company</label><div class="val"><?php echo htmlspecialchars($partner['company_name']); ?></div></div>
            <div class="crm-panel-item"><label>Contact Person</label><div class="val"><?php echo htmlspecialchars($partner['contact_name']); ?> (<?php echo htmlspecialchars($partner['contact_designation'] ?: '—'); ?>)</div></div>
            <div class="crm-panel-item"><label>Email</label><div class="val"><?php echo htmlspecialchars($partner['contact_email']); ?></div></div>
            <div class="crm-panel-item"><label>Mobile</label><div class="val"><?php echo htmlspecialchars($partner['contact_mobile']); ?></div></div>
            <div class="crm-panel-item"><label>Registration Date</label><div class="val"><?php echo htmlspecialchars(substr($partner['created_at'], 0, 10)); ?></div></div>
            <div class="crm-panel-item"><label>Status</label><div class="val"><span class="crm-status-badge <?php echo b2b_status_class($partner['status']); ?>"><?php echo htmlspecialchars($partner['status']); ?></span></div></div>
        </div>

        <?php if (b2b_can_assign_manager()): ?>
        <form method="post" style="margin-top:20px;display:flex;gap:10px;align-items:center;">
            <input type="hidden" name="action" value="assign_manager">
            <label style="font-size:13px;font-weight:600;color:var(--c-heading);">Relationship Manager</label>
            <select name="manager_id" style="border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <option value="">Unassigned</option>
                <?php foreach ($managers as $m): ?>
                <option value="<?php echo (int) $m['id']; ?>" <?php echo (int) $partner['assigned_manager_id'] === (int) $m['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($m['name']); ?> (<?php echo htmlspecialchars($m['role']); ?>)</option>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Save</button>
        </form>
        <?php endif; ?>
        <?php if ($partner['status_note']): ?>
        <p style="margin-top:16px;font-size:12.5px;color:var(--c-muted);"><strong>Last note:</strong> <?php echo htmlspecialchars($partner['status_note']); ?></p>
        <?php endif; ?>
    </div>
    <?php endif; ?>

<?php elseif ($tab === 'company'): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Company Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Business Type</label><div class="val"><?php echo htmlspecialchars($partner['business_type'] ?: '—'); ?></div></div>
            <div class="crm-panel-item"><label>Year Established</label><div class="val"><?php echo htmlspecialchars($partner['year_established'] ?: '—'); ?></div></div>
            <div class="crm-panel-item"><label>Website</label><div class="val"><?php echo $partner['website'] ? '<a href="' . htmlspecialchars($partner['website']) . '" target="_blank" rel="noopener">' . htmlspecialchars($partner['website']) . '</a>' : '—'; ?></div></div>
            <div class="crm-panel-item"><label>GST Number</label><div class="val"><?php echo htmlspecialchars($partner['gst_number'] ?: '—'); ?></div></div>
            <div class="crm-panel-item"><label>PAN Number</label><div class="val"><?php echo htmlspecialchars($partner['pan_number'] ?: '—'); ?></div></div>
            <div class="crm-panel-item"><label>IATA Registered</label><div class="val"><?php echo $partner['iata_registered'] ? 'Yes — ' . htmlspecialchars($partner['iata_number'] ?: '—') : 'No'; ?></div></div>
            <div class="crm-panel-item"><label>TAFI Number</label><div class="val"><?php echo htmlspecialchars($partner['tafi_number'] ?: '—'); ?></div></div>
            <div class="crm-panel-item"><label>Other Association</label><div class="val"><?php echo htmlspecialchars($partner['other_association'] ?: '—'); ?></div></div>
            <div class="crm-panel-item full"><label>Office Address</label><div class="val"><?php echo htmlspecialchars($partner['address'] . ', ' . $partner['city'] . ', ' . $partner['state'] . ' ' . $partner['pin_code'] . ', ' . $partner['country']); ?></div></div>
            <div class="crm-panel-item full"><label>Services Offered</label><div class="val"><?php echo $servicesOffered ? htmlspecialchars(implode(', ', $servicesOffered)) : '—'; ?></div></div>
            <div class="crm-panel-item full"><label>Visa Specialization</label><div class="val"><?php echo $visaSpecialization ? htmlspecialchars(implode(', ', $visaSpecialization)) : '—'; ?></div></div>
            <div class="crm-panel-item"><label>Monthly Visa Volume</label><div class="val"><?php echo htmlspecialchars($partner['monthly_visa_volume'] ?: '—'); ?></div></div>
        </div>
    </div>

<?php elseif ($tab === 'documents'): ?>
    <div class="crm-card">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
            <h3 style="margin:0;font-size:14px;">Documents</h3>
            <?php if (b2b_can_verify_documents()): ?><a href="b2b-documents.php" class="crm-btn crm-btn-ghost crm-btn-sm">Go to Verification Queue</a><?php endif; ?>
        </div>
        <div class="crm-doc-grid">
            <?php foreach (B2B_DOC_TYPES as $docKey => $docLabel):
                if ($docKey === 'IATA' && !$partner['iata_registered']) { continue; }
                $doc = $documents[$docKey] ?? null;
            ?>
            <div class="crm-doc-box">
                <div class="crm-doc-box-head"><strong><?php echo htmlspecialchars($docLabel); ?></strong>
                    <span class="crm-status-badge <?php echo $doc ? b2b_doc_status_class($doc['status']) : 'b2b-doc-pending'; ?>"><?php echo $doc ? htmlspecialchars($doc['status']) : 'Not Uploaded'; ?></span>
                </div>
                <?php if ($doc && $doc['stored_filename']): ?>
                <a href="b2b-document.php?id=<?php echo (int) $doc['id']; ?>" class="crm-cell-sub"><i class="fa-solid fa-download"></i> <?php echo htmlspecialchars($doc['original_filename']); ?></a>
                <div class="crm-cell-sub">Uploaded <?php echo htmlspecialchars(substr($doc['uploaded_at'], 0, 10)); ?></div>
                <?php if ($doc['rejection_reason']): ?><div class="crm-cell-sub" style="color:var(--c-red);">Rejected: <?php echo htmlspecialchars($doc['rejection_reason']); ?></div><?php endif; ?>
                <?php if ($doc['verification_remarks']): ?><div class="crm-cell-sub" style="color:var(--c-green);">Remarks: <?php echo htmlspecialchars($doc['verification_remarks']); ?></div><?php endif; ?>
                <?php if ($doc['verified_by']): ?><div class="crm-cell-sub">Verified by <?php echo htmlspecialchars($doc['verified_by']); ?> &middot; <?php echo htmlspecialchars(substr($doc['verified_at'], 0, 10)); ?></div><?php endif; ?>
                <?php else: ?>
                <div class="crm-cell-sub">Not uploaded yet.</div>
                <?php endif; ?>
            </div>
            <?php endforeach; ?>
        </div>
    </div>

<?php elseif ($tab === 'applications'): ?>
    <div class="crm-card" style="padding:0;">
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Reference</th><th>Traveller</th><th>Destination</th><th>Visa Type</th><th>Travel Date</th><th>Status</th><th>Submitted</th></tr></thead>
            <tbody>
            <?php foreach ($visaCases as $vc): ?>
            <tr>
                <td class="crm-cell-name"><a href="enquiry.php?ref=<?php echo urlencode($vc['enquiry_ref']); ?>"><?php echo htmlspecialchars($vc['enquiry_ref']); ?></a></td>
                <td><?php echo htmlspecialchars($vc['full_name']); ?></td>
                <td><?php echo htmlspecialchars($vc['destination_country']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($vc['visa_type']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $vc['travel_date'], 0, 10)); ?></td>
                <td><span class="crm-status-badge <?php echo crm_status_class($vc['status']); ?>"><?php echo htmlspecialchars($vc['status']); ?></span></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($vc['created_at'], 0, 10)); ?></td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$visaCases): ?>
            <tr><td colspan="7" class="crm-empty">This partner has not submitted any visa applications yet.</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
    </div>

<?php elseif ($tab === 'quotations'): ?>
    <?php if (b2b_can_manage_quotations()): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">New Quotation</h3>
        <form method="post">
            <input type="hidden" name="action" value="create_quotation">
            <div class="crm-panel-grid">
                <div class="crm-panel-item">
                    <label>Service Category</label>
                    <select name="service_category" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                        <option value="">Select service</option>
                        <?php foreach (B2B_SERVICES_OFFERED as $svc): ?><option value="<?php echo htmlspecialchars($svc); ?>"><?php echo htmlspecialchars($svc); ?></option><?php endforeach; ?>
                    </select>
                </div>
                <div class="crm-panel-item">
                    <label>Link to Application (optional)</label>
                    <select name="enquiry_id" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                        <option value="">— Not linked —</option>
                        <?php foreach ($visaCases as $vc): ?><option value="<?php echo (int) $vc['id']; ?>"><?php echo htmlspecialchars($vc['enquiry_ref'] . ' — ' . $vc['full_name']); ?></option><?php endforeach; ?>
                    </select>
                </div>
                <div class="crm-panel-item"><label>Destination Country</label><input type="text" name="country" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Visa Type</label><input type="text" name="visa_type" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Applicants</label><input type="number" name="applicants_count" value="1" min="1" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Visa Fee (₹)</label><input type="number" name="visa_fee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Service Fee (₹)</label><input type="number" name="service_fee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Embassy Fee (₹)</label><input type="number" name="embassy_fee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Appointment Fee (₹)</label><input type="number" name="appointment_fee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Courier Fee (₹)</label><input type="number" name="courier_fee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Other Charges (₹)</label><input type="number" name="other_charges" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>Discount (₹)</label><input type="number" name="discount" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
                <div class="crm-panel-item"><label>GST (₹)</label><input type="number" name="gst" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            </div>
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm" style="margin-top:16px;">Create Quotation</button>
        </form>
    </div>
    <?php endif; ?>

    <div class="crm-card" style="padding:0;">
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Reference</th><th>Service</th><th>Destination</th><th>Total</th><th>Valid Until</th><th>Status</th><th>Created</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($quotations as $q): ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars($q['quotation_ref']); ?></td>
                <td><?php echo htmlspecialchars($q['service_category']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($q['country']); ?> — <?php echo htmlspecialchars($q['visa_type']); ?></td>
                <td>₹<?php echo number_format((float) $q['total'], 2); ?></td>
                <td class="crm-cell-sub"><?php echo $q['valid_until'] ? htmlspecialchars(substr($q['valid_until'], 0, 10)) : '—'; ?></td>
                <td><span class="crm-status-badge <?php echo b2b_quote_status_class($q['status']); ?>"><?php echo htmlspecialchars($q['status']); ?></span></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($q['created_at'], 0, 10)); ?></td>
                <td style="display:flex;gap:6px;">
                    <a href="b2b-quotation-pdf.php?id=<?php echo (int) $q['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i></a>
                    <?php if ($q['status'] === 'Draft' && b2b_can_approve_quotation()): ?>
                    <form method="post"><input type="hidden" name="action" value="send_quotation"><input type="hidden" name="quotation_id" value="<?php echo (int) $q['id']; ?>"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Approve &amp; Send</button></form>
                    <?php endif; ?>
                </td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$quotations): ?>
            <tr><td colspan="8" class="crm-empty">No quotations created yet.</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
    </div>

<?php elseif ($tab === 'activities'): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Activity &amp; Audit Timeline</h3>
        <div class="crm-timeline">
            <?php foreach ($auditLog as $log): ?>
            <div class="crm-timeline-item">
                <div class="crm-timeline-dot"></div>
                <div class="crm-timeline-action"><?php echo htmlspecialchars($log['action']); ?></div>
                <?php if ($log['new_value']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($log['new_value']); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo htmlspecialchars($log['user_name']); ?> (<?php echo htmlspecialchars($log['role']); ?>) &middot; <?php echo htmlspecialchars(substr($log['created_at'], 0, 16)); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$auditLog): ?><p class="crm-empty">No activity recorded yet.</p><?php endif; ?>
        </div>
    </div>
<?php endif; ?>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
