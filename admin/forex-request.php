<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Forex Request';
$ADMIN_ACTIVE_NAV = 'forex-all';
require __DIR__ . '/includes/layout-top.php';

$ref = trim($_GET['ref'] ?? '');
$stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE forex_ref = ?');
$stmt->execute([$ref]);
$request = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$request) {
    http_response_code(404);
    echo '<div class="crm-card">Forex request not found.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}
$requestId = (int) $request['id'];
$ADMIN_BREADCRUMB = ['CRM', 'Forex', $request['forex_ref']];

$statusMessage = '';
$quotationError = '';
$paymentError = '';
$deliveryError = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'change_status' && forex_can_verify_documents()) {
        $newStatus = trim($_POST['status'] ?? '');
        if (in_array($newStatus, FOREX_STATUSES, true) && $newStatus !== $request['status']) {
            $pdo->prepare('UPDATE forex_requests SET status = ?, updated_at = ? WHERE id = ?')
                ->execute([$newStatus, gmdate('c'), $requestId]);
            forex_log_status_change($pdo, $requestId, $request['status'], $newStatus, admin_name(), trim($_POST['message'] ?? ''));
            forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Changed status', $request['status'], $newStatus);
            $request['status'] = $newStatus;

            if ($newStatus === 'Awaiting Documents') {
                forex_notify_customer(
                    $pdo, $request, "Documents Required — {$request['forex_ref']}",
                    "Dear {$request['full_name']},\n\nYour forex request {$request['forex_ref']} is awaiting document submission. Please upload the pending documents so we can proceed.\n\nTrack your request: https://visaagency.in/forex-track\n\nRegards,\nVisaAgency.in"
                );
            } elseif ($newStatus === 'Ready for Delivery') {
                forex_notify_customer(
                    $pdo, $request, "Your Forex is Ready for Delivery — {$request['forex_ref']}",
                    "Dear {$request['full_name']},\n\nYour foreign currency ({$request['currency_code']} {$request['amount_required']}) is ready for delivery/collection under reference {$request['forex_ref']}. Our team will contact you shortly to arrange delivery.\n\nRegards,\nVisaAgency.in"
                );
            }
        }
    } elseif ($action === 'create_quotation' && forex_can_prepare_quotation()) {
        $currencyCode = strtoupper(trim($_POST['currency_code'] ?? ''));
        $currencyAmount = filter_var($_POST['currency_amount'] ?? '', FILTER_VALIDATE_FLOAT);
        $exchangeRate = filter_var($_POST['exchange_rate'] ?? '', FILTER_VALIDATE_FLOAT);
        $rateType = trim($_POST['rate_type'] ?? '');
        $serviceCharge = filter_var($_POST['service_charge'] ?? '0', FILTER_VALIDATE_FLOAT) ?: 0;
        $markup = filter_var($_POST['markup'] ?? '0', FILTER_VALIDATE_FLOAT) ?: 0;
        $gst = filter_var($_POST['gst'] ?? '0', FILTER_VALIDATE_FLOAT) ?: 0;
        $otherCharges = filter_var($_POST['other_charges'] ?? '0', FILTER_VALIDATE_FLOAT) ?: 0;

        if ($currencyCode === '' || $currencyAmount === false || $currencyAmount <= 0 || $exchangeRate === false || $exchangeRate <= 0 || !in_array($rateType, FOREX_RATE_TYPES, true)) {
            $quotationError = 'Please provide a valid currency, amount, exchange rate and rate type.';
        } else {
            $baseInr = round($currencyAmount * $exchangeRate, 2);
            $totalInr = round($baseInr + $serviceCharge + $markup + $gst + $otherCharges, 2);
            $threshold = (float) forex_setting($pdo, 'approval_threshold_inr', '200000');
            $needsApproval = $totalInr > $threshold;

            $insQ = $pdo->prepare("INSERT INTO forex_quotations (
                forex_request_id, currency_code, currency_amount, exchange_rate, rate_type, base_inr,
                service_charge, markup, gst, other_charges, total_inr, payment_terms, valid_until, status, created_by, created_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $insQ->execute([
                $requestId, $currencyCode, $currencyAmount, $exchangeRate, $rateType, $baseInr,
                $serviceCharge, $markup, $gst, $otherCharges, $totalInr,
                trim($_POST['payment_terms'] ?? '') ?: null,
                trim($_POST['valid_until'] ?? '') ?: null,
                $needsApproval ? 'Draft' : 'Sent',
                admin_name(), gmdate('c'),
            ]);
            $quotationId = (int) $pdo->lastInsertId();

            forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Created quotation', '', "$currencyCode $currencyAmount @ $exchangeRate = ₹$totalInr" . ($needsApproval ? ' (requires approval)' : ''));

            if ($needsApproval) {
                $pdo->prepare('UPDATE forex_requests SET status = ?, updated_at = ? WHERE id = ?')->execute(['Quotation Preparing', gmdate('c'), $requestId]);
                forex_notify($pdo, null, 'forex_quotation_approval', "Quotation on {$request['forex_ref']} (₹" . number_format($totalInr, 2) . ') exceeds the approval threshold and needs sign-off.', $requestId);
            } else {
                $pdo->prepare('UPDATE forex_requests SET status = ?, updated_at = ? WHERE id = ?')->execute(['Quotation Sent', gmdate('c'), $requestId]);
                forex_notify($pdo, null, 'forex_quotation_ready', "Forex quotation ready on {$request['forex_ref']}: $currencyCode $currencyAmount for ₹" . number_format($totalInr, 2) . '.', $requestId);
                forex_notify_customer(
                    $pdo, $request, "Your Forex Quotation is Ready — {$request['forex_ref']}",
                    "Dear {$request['full_name']},\n\nYour forex quotation is ready:\n$currencyCode " . number_format($currencyAmount, 2) . " for Rs. " . number_format($totalInr, 2) . "\n\nReference: {$request['forex_ref']}\n\nOur team will share the detailed quotation with you shortly. Track your request at https://visaagency.in/forex-track\n\nRegards,\nVisaAgency.in"
                );
            }
            forex_log_status_change($pdo, $requestId, $request['status'], $needsApproval ? 'Quotation Preparing' : 'Quotation Sent', admin_name(), 'Quotation created.');
            header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '#quotations');
            exit;
        }
    } elseif ($action === 'record_payment' && forex_can_manage_payments()) {
        $amount = filter_var($_POST['amount'] ?? '', FILTER_VALIDATE_FLOAT);
        $status = trim($_POST['status'] ?? '');
        if ($amount === false || $amount <= 0 || !in_array($status, FOREX_PAYMENT_STATUSES, true)) {
            $paymentError = 'Please provide a valid amount and status.';
        } else {
            $pdo->prepare('INSERT INTO forex_payments (forex_request_id, status, method, transaction_id, amount, payment_date, reference, remarks, recorded_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
                ->execute([
                    $requestId, $status,
                    in_array($_POST['method'] ?? '', FOREX_PAYMENT_METHODS, true) ? $_POST['method'] : null,
                    trim($_POST['transaction_id'] ?? '') ?: null,
                    $amount,
                    trim($_POST['payment_date'] ?? '') ?: gmdate('Y-m-d'),
                    trim($_POST['reference'] ?? '') ?: null,
                    trim($_POST['remarks'] ?? '') ?: null,
                    admin_name(), gmdate('c'),
                ]);
            forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Recorded payment', '', "$status: Rs. " . number_format($amount, 2));
            if ($status === 'Paid') {
                $pdo->prepare("UPDATE forex_requests SET status = 'Payment Received', updated_at = ? WHERE id = ?")->execute([gmdate('c'), $requestId]);
                forex_log_status_change($pdo, $requestId, $request['status'], 'Payment Received', admin_name(), 'Payment recorded.');
                forex_notify($pdo, null, 'forex_payment_received', "Payment received on {$request['forex_ref']}: Rs. " . number_format($amount, 2) . '.', $requestId);
                forex_notify_customer(
                    $pdo, $request, "Payment Received — {$request['forex_ref']}",
                    "Dear {$request['full_name']},\n\nWe have received your payment of Rs. " . number_format($amount, 2) . " for forex request {$request['forex_ref']}. We are now processing your request.\n\nRegards,\nVisaAgency.in"
                );
            }
            header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '#payments');
            exit;
        }
    } elseif ($action === 'mark_delivered') {
        $blockers = forex_delivery_blockers($pdo, $request);
        $isOverride = !empty($_POST['override']) && forex_can_override_compliance();

        if ($blockers && !$isOverride) {
            $deliveryError = $blockers;
        } elseif ($blockers && $isOverride && trim($_POST['override_reason'] ?? '') === '') {
            $deliveryError = ['An override reason is required.'];
        } elseif (!forex_can_manage_delivery()) {
            $deliveryError = ['You do not have permission to mark this request as delivered.'];
        } else {
            $denomValues = $_POST['denom_value'] ?? [];
            $denomQtys = $_POST['denom_qty'] ?? [];
            $totalAmount = filter_var($_POST['total_amount'] ?? '', FILTER_VALIDATE_FLOAT);
            $denomTotal = 0.0;
            $denomRows = [];
            foreach ($denomValues as $i => $dv) {
                $val = filter_var($dv, FILTER_VALIDATE_FLOAT);
                $qty = filter_var($denomQtys[$i] ?? '', FILTER_VALIDATE_INT);
                if ($val !== false && $val > 0 && $qty !== false && $qty > 0) {
                    $denomTotal += $val * $qty;
                    $denomRows[] = [$val, $qty];
                }
            }

            if ($totalAmount === false || $totalAmount <= 0) {
                $deliveryError = ['Please provide the total currency amount delivered.'];
            } elseif ($denomRows && abs($denomTotal - $totalAmount) > 0.01) {
                $deliveryError = ["Denomination total ({$request['currency_code']} " . number_format($denomTotal, 2) . ") does not match the delivered amount ({$request['currency_code']} " . number_format($totalAmount, 2) . '). Please correct before completing delivery.'];
            } else {
                $now = gmdate('c');
                $pdo->prepare('INSERT INTO forex_deliveries (forex_request_id, delivered_by, received_by, delivery_date, delivery_time, currency_code, total_amount, customer_ack, remarks, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
                    ->execute([
                        $requestId, admin_name(), trim($_POST['received_by'] ?? '') ?: $request['full_name'],
                        trim($_POST['delivery_date'] ?? '') ?: gmdate('Y-m-d'), trim($_POST['delivery_time'] ?? '') ?: gmdate('H:i'),
                        $request['currency_code'], $totalAmount, !empty($_POST['customer_ack']) ? 1 : 0,
                        trim($_POST['delivery_remarks'] ?? '') ?: null, $now,
                    ]);
                $deliveryId = (int) $pdo->lastInsertId();
                $denomStmt = $pdo->prepare('INSERT INTO forex_denominations (delivery_id, denomination_value, quantity) VALUES (?, ?, ?)');
                foreach ($denomRows as $row) {
                    $denomStmt->execute([$deliveryId, $row[0], $row[1]]);
                }

                $pdo->prepare("UPDATE forex_requests SET status = 'Delivered', updated_at = ? WHERE id = ?")->execute([$now, $requestId]);
                forex_log_status_change($pdo, $requestId, $request['status'], 'Delivered', admin_name(), 'Forex delivered to customer.');

                if ($blockers && $isOverride) {
                    $pdo->prepare('INSERT INTO forex_approvals (forex_request_id, action, approver, previous_value, new_value, remarks, ip_address, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
                        ->execute([$requestId, 'Delivery Compliance Override', admin_name(), implode(' | ', $blockers), 'Delivered', trim($_POST['override_reason']), $_SERVER['REMOTE_ADDR'] ?? null, $now]);
                    forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Overrode delivery compliance block', implode(' | ', $blockers), trim($_POST['override_reason']));
                } else {
                    forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Marked delivered', '', "{$request['currency_code']} " . number_format($totalAmount, 2));
                }
                forex_notify($pdo, null, 'forex_delivered', "Forex delivered on {$request['forex_ref']}: {$request['currency_code']} " . number_format($totalAmount, 2) . '.', $requestId);
                forex_notify_customer(
                    $pdo, $request, "Forex Delivered — {$request['forex_ref']}",
                    "Dear {$request['full_name']},\n\nYour foreign currency purchase is complete. {$request['currency_code']} " . number_format($totalAmount, 2) . " has been delivered under reference {$request['forex_ref']}.\n\nThank you for choosing VisaAgency.in.\n\nRegards,\nVisaAgency.in"
                );

                header('Location: forex-request.php?ref=' . urlencode($request['forex_ref']) . '&delivered=1#delivery');
                exit;
            }
        }
    }
}

$docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = ? ORDER BY doc_type, id DESC');
$docsStmt->execute([$requestId]);
$allDocRows = $docsStmt->fetchAll(PDO::FETCH_ASSOC);
$documents = [];
foreach ($allDocRows as $d) {
    if (!isset($documents[$d['doc_type']])) {
        $documents[$d['doc_type']] = $d; // first hit per type = highest id = current version
    }
}
$totalDocs = count($documents);
$verifiedDocs = count(array_filter($documents, function ($d) { return $d['status'] === 'Verified'; }));

$paymentsStmt = $pdo->prepare('SELECT * FROM forex_payments WHERE forex_request_id = ? ORDER BY id DESC');
$paymentsStmt->execute([$requestId]);
$payments = $paymentsStmt->fetchAll(PDO::FETCH_ASSOC);
$totalPaid = array_sum(array_map(function ($p) { return $p['status'] === 'Paid' ? (float) $p['amount'] : 0; }, $payments));

$deliveryStmt = $pdo->prepare('SELECT * FROM forex_deliveries WHERE forex_request_id = ?');
$deliveryStmt->execute([$requestId]);
$delivery = $deliveryStmt->fetch(PDO::FETCH_ASSOC);
if ($delivery) {
    $denomStmt = $pdo->prepare('SELECT * FROM forex_denominations WHERE delivery_id = ? ORDER BY denomination_value DESC');
    $denomStmt->execute([$delivery['id']]);
    $denominations = $denomStmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    $denominations = [];
}
$blockers = $delivery ? [] : forex_delivery_blockers($pdo, $request);

$quotStmt = $pdo->prepare('SELECT * FROM forex_quotations WHERE forex_request_id = ? ORDER BY id DESC');
$quotStmt->execute([$requestId]);
$quotations = $quotStmt->fetchAll(PDO::FETCH_ASSOC);
$currentRateStmt = $pdo->prepare('SELECT sell_rate FROM forex_rates WHERE currency_code = ? AND effective_until IS NULL');
$currentRateStmt->execute([$request['currency_code']]);
$suggestedRate = $currentRateStmt->fetchColumn();
$approvalThreshold = (float) forex_setting($pdo, 'approval_threshold_inr', '200000');
$defaultServiceCharge = (float) forex_setting($pdo, 'default_service_charge', '0');
$defaultMarkup = (float) forex_setting($pdo, 'default_markup', '0');
$defaultGstPercent = (float) forex_setting($pdo, 'default_gst_percent', '0');
$suggestedBaseInr = ($suggestedRate ? (float) $suggestedRate : 0) * (float) $request['amount_required'];
$defaultGstAmount = round($suggestedBaseInr * $defaultGstPercent / 100, 2);
$quotationValidityHours = (int) forex_setting($pdo, 'quotation_validity_hours', '24');
$defaultValidUntil = gmdate('Y-m-d\TH:i', strtotime("+{$quotationValidityHours} hours"));

$declStmt = $pdo->prepare('SELECT * FROM forex_declarations WHERE forex_request_id = ? ORDER BY id DESC LIMIT 1');
$declStmt->execute([$requestId]);
$declaration = $declStmt->fetch(PDO::FETCH_ASSOC);

$historyStmt = $pdo->prepare('SELECT * FROM forex_status_history WHERE forex_request_id = ? ORDER BY id DESC');
$historyStmt->execute([$requestId]);
$history = $historyStmt->fetchAll(PDO::FETCH_ASSOC);

$auditStmt = $pdo->prepare('SELECT * FROM forex_audit_logs WHERE forex_request_id = ? ORDER BY id DESC LIMIT 20');
$auditStmt->execute([$requestId]);
$auditLog = $auditStmt->fetchAll(PDO::FETCH_ASSOC);

function fx_fmt($v) { $v = trim((string) $v); return $v === '' ? '<span style="color:var(--c-muted);">—</span>' : htmlspecialchars($v); }
?>
<a href="forex-requests.php" style="font-size:12.5px;color:var(--c-text);display:inline-block;margin-bottom:14px;">&larr; Back to all forex requests</a>

<div class="crm-detail-header">
    <div class="ref"><?php echo htmlspecialchars($request['forex_ref']); ?></div>
    <h1><?php echo htmlspecialchars($request['full_name']); ?></h1>
    <div class="sub"><?php echo htmlspecialchars($request['country_visit']); ?> &middot; <?php echo htmlspecialchars($request['currency_code']); ?> <?php echo number_format((float) $request['amount_required'], 2); ?></div>
    <div class="crm-detail-badges">
        <span class="crm-status-badge <?php echo forex_status_class($request['status']); ?>" style="background:rgba(255,255,255,0.15);color:#fff;"><?php echo htmlspecialchars($request['status']); ?></span>
        <span class="crm-status-badge" style="background:rgba(255,255,255,0.15);color:#fff;"><?php echo htmlspecialchars($request['visa_status']); ?></span>
        <?php if ($request['assigned_to']): ?><span class="crm-status-badge" style="background:rgba(255,255,255,0.15);color:#fff;">Assigned: <?php echo htmlspecialchars($request['assigned_to']); ?></span><?php endif; ?>
    </div>
    <div class="crm-quick-actions">
        <a class="crm-btn" href="tel:<?php echo htmlspecialchars($request['mobile']); ?>"><i class="fa-solid fa-phone"></i> Call</a>
        <a class="crm-btn" href="https://wa.me/<?php echo preg_replace('/\D/', '', $request['mobile']); ?>" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
        <?php if ($request['email']): ?><a class="crm-btn" href="mailto:<?php echo htmlspecialchars($request['email']); ?>"><i class="fa-solid fa-envelope"></i> Email</a><?php endif; ?>
        <a class="crm-btn" href="#status"><i class="fa-solid fa-pen"></i> Change Status</a>
        <a class="crm-btn" href="#documents"><i class="fa-solid fa-upload"></i> Documents</a>
        <a class="crm-btn" href="#quotations"><i class="fa-solid fa-file-invoice-dollar"></i> Quotations</a>
        <a class="crm-btn" href="#payments"><i class="fa-solid fa-money-bill-wave"></i> Payments</a>
        <a class="crm-btn" href="#delivery"><i class="fa-solid fa-hand-holding-dollar"></i> Delivery</a>
    </div>
</div>

<div class="crm-card">
    <h3>Document Completion: <?php echo $verifiedDocs; ?>/<?php echo $totalDocs; ?></h3>
    <div class="forex-progress-bar" style="max-width:100%;margin-bottom:16px;"><div class="forex-progress-bar-fill" style="width:<?php echo $totalDocs ? round(($verifiedDocs / $totalDocs) * 100) : 0; ?>%;"></div></div>
    <div class="forex-doc-checklist" id="documents">
        <?php foreach ($documents as $docType => $d):
            $statusClass = forex_doc_status_class($d['status']);
            $icon = $d['status'] === 'Verified' ? 'circle-check' : ($d['status'] === 'Rejected' ? 'circle-xmark' : ($d['status'] === 'Not Uploaded' ? 'circle' : 'clock'));
        ?>
        <div class="forex-doc-row <?php echo $statusClass; ?>">
            <div class="forex-doc-row-label"><i class="fa-solid fa-<?php echo $icon; ?> forex-doc-row-icon"></i> <?php echo htmlspecialchars(FOREX_DOC_TYPES[$docType]); ?></div>
            <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
                <span class="crm-status-badge forex-doc-status <?php echo $statusClass; ?>"><?php echo htmlspecialchars($d['status']); ?></span>
                <?php if ($d['stored_filename']): ?><a href="forex-document.php?id=<?php echo (int) $d['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i></a><?php endif; ?>
                <?php if ($docType !== 'Declaration'): ?>
                <form method="post" action="forex-document-upload.php" enctype="multipart/form-data" style="display:flex;gap:6px;align-items:center;">
                    <input type="hidden" name="forex_request_id" value="<?php echo $requestId; ?>">
                    <input type="hidden" name="doc_type" value="<?php echo htmlspecialchars($docType); ?>">
                    <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required style="font-size:11.5px;max-width:150px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><?php echo $d['stored_filename'] ? 'Replace' : 'Upload'; ?></button>
                </form>
                <?php endif; ?>
                <?php if (in_array($d['status'], ['Uploaded', 'Under Verification'], true) && forex_can_verify_documents()): ?>
                <form method="post" action="forex-documents.php" style="display:flex;gap:4px;align-items:center;">
                    <input type="hidden" name="action" value="verify">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                    <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
                    <input type="text" name="remarks" placeholder="Remarks..." style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:120px;">
                    <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Verify</button>
                </form>
                <form method="post" action="forex-documents.php" style="display:flex;gap:4px;align-items:center;">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" name="doc_id" value="<?php echo (int) $d['id']; ?>">
                    <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
                    <input type="text" name="reason" placeholder="Reason..." required style="font-size:11.5px;padding:5px 8px;border:1px solid var(--c-border);border-radius:6px;width:120px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Reject</button>
                </form>
                <?php endif; ?>
            </div>
        </div>
        <?php if ($d['rejection_reason']): ?><p style="font-size:11.5px;color:var(--c-red);margin:-4px 0 0;">Rejected: <?php echo htmlspecialchars($d['rejection_reason']); ?></p><?php endif; ?>
        <?php if ($d['verification_remarks']): ?><p style="font-size:11.5px;color:var(--c-green);margin:-4px 0 0;">Remarks: <?php echo htmlspecialchars($d['verification_remarks']); ?></p><?php endif; ?>
        <?php endforeach; ?>
        <?php if (!$documents): ?><div class="crm-empty">No document checklist yet.</div><?php endif; ?>
    </div>
    <p class="visa-info-note" style="font-size:12px;color:var(--c-muted);">PDF, JPG or PNG, max 5MB. Documents are only marked complete once staff verify them (Phase 4).</p>
</div>

<?php if ($declaration): ?>
<div class="crm-card" id="declaration">
    <h3><i class="fa-solid fa-file-signature"></i> Visa on Arrival / Visa-Free Declaration</h3>
    <div class="compliance-note" style="margin-bottom:14px;">
        Visa Not Applicable — Customer Declaration Required. The customer must read, hand-sign and upload this declaration. A typed name does not satisfy this requirement.
    </div>
    <div class="crm-panel-grid" style="margin-bottom:16px;">
        <div class="crm-panel-item"><label>Customer Name</label><div class="val"><?php echo fx_fmt($declaration['customer_name']); ?></div></div>
        <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fx_fmt($declaration['passport_number']); ?></div></div>
        <div class="crm-panel-item"><label>Destination</label><div class="val"><?php echo fx_fmt($declaration['destination_country']); ?></div></div>
        <div class="crm-panel-item"><label>Declaration Date</label><div class="val"><?php echo fx_fmt($declaration['declaration_date']); ?></div></div>
        <div class="crm-panel-item"><label>Signed Copy</label><div class="val"><?php echo $declaration['stored_filename'] ? '<span style="color:var(--c-green);">Uploaded</span>' : '<span style="color:var(--c-red);">Not yet uploaded</span>'; ?></div></div>
        <div class="crm-panel-item"><label>Verified</label><div class="val"><?php echo $declaration['verified_at'] ? fx_fmt($declaration['verified_by'] . ' — ' . substr($declaration['verified_at'], 0, 10)) : '<span style="color:var(--c-amber);">Pending</span>'; ?></div></div>
    </div>
    <div style="display:flex;gap:10px;flex-wrap:wrap;">
        <a href="forex-declaration-print.php?ref=<?php echo urlencode($request['forex_ref']); ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-print"></i> Print / Download for Signature</a>
        <?php if (isset($documents['Declaration']) && $documents['Declaration']['stored_filename']): ?>
        <a href="forex-document.php?id=<?php echo (int) $documents['Declaration']['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i> Download Signed Copy</a>
        <?php endif; ?>
    </div>
    <form method="post" action="forex-document-upload.php" enctype="multipart/form-data" style="display:flex;gap:10px;align-items:center;margin-top:14px;">
        <input type="hidden" name="forex_request_id" value="<?php echo $requestId; ?>">
        <input type="hidden" name="doc_type" value="Declaration">
        <input type="file" name="document" accept=".pdf,.jpg,.jpeg,.png" required>
        <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Upload Signed Declaration</button>
    </form>
</div>
<?php endif; ?>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Customer Information</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Full Name</label><div class="val"><?php echo fx_fmt($request['full_name']); ?></div></div>
            <div class="crm-panel-item"><label>Date of Birth</label><div class="val"><?php echo fx_fmt($request['date_of_birth']); ?></div></div>
            <div class="crm-panel-item"><label>Mobile</label><div class="val"><?php echo fx_fmt($request['mobile']); ?></div></div>
            <div class="crm-panel-item"><label>Email</label><div class="val"><?php echo fx_fmt($request['email']); ?></div></div>
            <div class="crm-panel-item"><label>Address</label><div class="val"><?php echo fx_fmt($request['address']); ?></div></div>
            <div class="crm-panel-item"><label>City</label><div class="val"><?php echo fx_fmt($request['city']); ?></div></div>
            <div class="crm-panel-item"><label>State</label><div class="val"><?php echo fx_fmt($request['state']); ?></div></div>
            <div class="crm-panel-item"><label>PIN Code</label><div class="val"><?php echo fx_fmt($request['pin_code']); ?></div></div>
            <div class="crm-panel-item"><label>Nationality</label><div class="val"><?php echo fx_fmt($request['nationality']); ?></div></div>
            <div class="crm-panel-item"><label>PAN Number</label><div class="val"><?php echo fx_fmt($request['pan_number']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Number</label><div class="val"><?php echo fx_fmt($request['passport_number']); ?></div></div>
            <div class="crm-panel-item"><label>Passport Expiry</label><div class="val"><?php echo fx_fmt($request['passport_expiry']); ?></div></div>
        </div>
    </div>
    <div class="crm-card">
        <h3>Travel Details</h3>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Country of Visit</label><div class="val"><?php echo fx_fmt($request['country_visit']); ?></div></div>
            <div class="crm-panel-item"><label>Cities to Visit</label><div class="val"><?php echo fx_fmt($request['cities_visit']); ?></div></div>
            <div class="crm-panel-item"><label>Purpose</label><div class="val"><?php echo fx_fmt($request['purpose']); ?></div></div>
            <div class="crm-panel-item"><label>Traveller Type</label><div class="val"><?php echo fx_fmt($request['traveller_type']); ?></div></div>
            <div class="crm-panel-item"><label>Departure Date</label><div class="val"><?php echo fx_fmt($request['departure_date']); ?></div></div>
            <div class="crm-panel-item"><label>Return Date</label><div class="val"><?php echo fx_fmt($request['return_date']); ?></div></div>
            <div class="crm-panel-item"><label>Duration</label><div class="val"><?php echo fx_fmt($request['duration_of_stay']); ?></div></div>
            <div class="crm-panel-item"><label>Airline</label><div class="val"><?php echo fx_fmt($request['airline']); ?></div></div>
            <div class="crm-panel-item"><label>Flight Number</label><div class="val"><?php echo fx_fmt($request['flight_number']); ?></div></div>
            <div class="crm-panel-item"><label>Hotel</label><div class="val"><?php echo fx_fmt($request['hotel_name']); ?></div></div>
        </div>
    </div>
</div>

<div class="crm-card">
    <h3>Forex Requirement</h3>
    <div class="crm-panel-grid">
        <div class="crm-panel-item"><label>Currency</label><div class="val"><?php echo fx_fmt($request['currency_code']); ?></div></div>
        <div class="crm-panel-item"><label>Amount Required</label><div class="val"><?php echo fx_fmt(number_format((float) $request['amount_required'], 2)); ?></div></div>
        <div class="crm-panel-item"><label>Approx. INR</label><div class="val"><?php echo $request['approx_inr'] ? fx_fmt('₹' . number_format((float) $request['approx_inr'], 2)) : fx_fmt(''); ?></div></div>
        <div class="crm-panel-item"><label>Preferred Date</label><div class="val"><?php echo fx_fmt($request['preferred_delivery_date']); ?></div></div>
        <div class="crm-panel-item"><label>Collection Location</label><div class="val"><?php echo fx_fmt($request['collection_location']); ?></div></div>
        <div class="crm-panel-item"><label>Delivery Method</label><div class="val"><?php echo fx_fmt($request['delivery_method']); ?></div></div>
    </div>
</div>

<div class="crm-card" id="quotations">
    <div class="crm-page-header" style="margin:0 0 16px;padding:0;">
        <h3 style="margin:0;">Quotations</h3>
        <?php if (forex_can_prepare_quotation()): ?>
        <button type="button" class="crm-btn crm-btn-primary crm-btn-sm" id="crmOpenQuotationDrawer"><i class="fa-solid fa-plus"></i> Create Quotation</button>
        <?php endif; ?>
    </div>
    <?php if ($quotationError): ?><div style="background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($quotationError); ?></div><?php endif; ?>
    <?php if (!$quotations): ?>
    <div class="crm-empty">No quotations yet.</div>
    <?php else: foreach ($quotations as $q): ?>
    <div style="border:1px solid var(--c-border);border-radius:10px;padding:16px;margin-bottom:12px;">
        <div style="display:flex;justify-content:space-between;flex-wrap:wrap;gap:10px;margin-bottom:10px;">
            <div>
                <strong><?php echo htmlspecialchars($q['currency_code']); ?> <?php echo number_format((float) $q['currency_amount'], 2); ?></strong>
                <span class="crm-status-badge" style="background:var(--c-blue-dim);color:var(--c-blue);margin-left:8px;"><?php echo htmlspecialchars($q['rate_type']); ?></span>
                <span class="crm-status-badge" style="background:var(--c-bg);color:var(--c-text);margin-left:4px;"><?php echo htmlspecialchars($q['status']); ?></span>
            </div>
            <div style="font-size:12px;color:var(--c-muted);"><?php echo htmlspecialchars(substr($q['created_at'], 0, 16)); ?> by <?php echo htmlspecialchars($q['created_by']); ?></div>
        </div>
        <div style="display:flex;gap:8px;margin-bottom:12px;">
            <a href="forex-quotation-pdf.php?id=<?php echo (int) $q['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i> Download PDF</a>
            <a href="https://wa.me/<?php echo preg_replace('/\D/', '', $request['mobile']); ?>?text=<?php echo rawurlencode("Dear {$request['full_name']}, your Forex Quotation ({$request['forex_ref']}) is ready:\n{$q['currency_code']} " . number_format((float) $q['currency_amount'], 2) . " for Rs. " . number_format((float) $q['total_inr'], 2) . "\nWe're sending the detailed PDF quotation on this chat now. For queries, call +91 78448 19819."); ?>" target="_blank" rel="noopener" class="crm-btn crm-btn-ghost crm-btn-sm" title="Opens WhatsApp with a pre-filled message — download the PDF above first and attach it manually in the chat, since WhatsApp links can't attach files automatically"><i class="fa-brands fa-whatsapp"></i> Send via WhatsApp</a>
            <?php if ($request['email']): ?><a href="mailto:<?php echo htmlspecialchars($request['email']); ?>?subject=<?php echo rawurlencode('Your Forex Quotation - ' . $request['forex_ref']); ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-envelope"></i> Email</a><?php endif; ?>
        </div>
        <div class="crm-panel-grid">
            <div class="crm-panel-item"><label>Exchange Rate</label><div class="val">₹<?php echo number_format((float) $q['exchange_rate'], 4); ?></div></div>
            <div class="crm-panel-item"><label>Base Amount</label><div class="val">₹<?php echo number_format((float) $q['base_inr'], 2); ?></div></div>
            <div class="crm-panel-item"><label>Service Charge</label><div class="val">₹<?php echo number_format((float) $q['service_charge'], 2); ?></div></div>
            <div class="crm-panel-item"><label>Markup</label><div class="val">₹<?php echo number_format((float) $q['markup'], 2); ?></div></div>
            <div class="crm-panel-item"><label>GST</label><div class="val">₹<?php echo number_format((float) $q['gst'], 2); ?></div></div>
            <div class="crm-panel-item"><label>Other Charges</label><div class="val">₹<?php echo number_format((float) $q['other_charges'], 2); ?></div></div>
            <div class="crm-panel-item"><label>Total Payable</label><div class="val" style="font-weight:700;">₹<?php echo number_format((float) $q['total_inr'], 2); ?></div></div>
            <div class="crm-panel-item"><label>Valid Until</label><div class="val"><?php echo fx_fmt($q['valid_until']); ?></div></div>
        </div>
        <?php if ($q['status'] === 'Draft' && (float) $q['total_inr'] > $approvalThreshold): ?>
        <div class="compliance-note" style="margin-top:10px;background:var(--c-amber-bg);color:var(--c-amber);">This quotation exceeds the ₹<?php echo number_format($approvalThreshold, 0); ?> approval threshold and needs sign-off before it can be sent to the customer.</div>
        <?php if (forex_can_approve_quotation()): ?>
        <form method="post" action="forex-quotations.php" style="display:flex;gap:8px;align-items:center;margin-top:10px;">
            <input type="hidden" name="action" value="approve">
            <input type="hidden" name="quotation_id" value="<?php echo (int) $q['id']; ?>">
            <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
            <input type="text" name="remarks" placeholder="Approval remarks..." style="font-size:12px;padding:6px 10px;border:1px solid var(--c-border);border-radius:6px;flex:1;max-width:260px;">
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Approve &amp; Send</button>
        </form>
        <?php endif; ?>
        <?php elseif ($q['status'] === 'Sent'): ?>
        <form method="post" action="forex-quotations.php" style="margin-top:10px;">
            <input type="hidden" name="action" value="mark_accepted">
            <input type="hidden" name="quotation_id" value="<?php echo (int) $q['id']; ?>">
            <input type="hidden" name="return_url" value="forex-request.php?ref=<?php echo urlencode($request['forex_ref']); ?>">
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Mark Customer Accepted</button>
        </form>
        <?php endif; ?>
    </div>
    <?php endforeach; endif; ?>
</div>

<div class="crm-drawer-overlay" id="crmQuotationDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2>Create Quotation</h2><button type="button" class="crm-drawer-close" id="crmQuotationDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmQuotationForm">
                <input type="hidden" name="action" value="create_quotation">
                <div class="crm-form-section">
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Currency *</label><input type="text" name="currency_code" id="qCurrency" value="<?php echo htmlspecialchars($request['currency_code']); ?>" required></div>
                        <div class="crm-form-field"><label>Currency Amount *</label><input type="number" step="0.01" name="currency_amount" id="qAmount" value="<?php echo htmlspecialchars($request['amount_required']); ?>" required></div>
                        <div class="crm-form-field"><label>Exchange Rate *</label><input type="number" step="0.0001" name="exchange_rate" id="qRate" value="<?php echo $suggestedRate ? htmlspecialchars($suggestedRate) : ''; ?>" required></div>
                        <div class="crm-form-field"><label>Rate Type *</label>
                            <select name="rate_type" id="qRateType" required>
                                <?php foreach (FOREX_RATE_TYPES as $rt): ?><option value="<?php echo htmlspecialchars($rt); ?>"><?php echo htmlspecialchars($rt); ?></option><?php endforeach; ?>
                            </select>
                        </div>
                        <div class="crm-form-field"><label>Service Charge (₹)</label><input type="number" step="0.01" name="service_charge" id="qService" value="<?php echo htmlspecialchars((string) $defaultServiceCharge); ?>"></div>
                        <div class="crm-form-field"><label>Commission / Markup (₹)</label><input type="number" step="0.01" name="markup" id="qMarkup" value="<?php echo htmlspecialchars((string) $defaultMarkup); ?>"></div>
                        <div class="crm-form-field"><label>GST (₹)</label><input type="number" step="0.01" name="gst" id="qGst" value="<?php echo htmlspecialchars((string) $defaultGstAmount); ?>" title="Pre-filled from the default GST % setting (<?php echo htmlspecialchars((string) $defaultGstPercent); ?>%) against the suggested base amount. Adjust if the final rate/amount changes."></div>
                        <div class="crm-form-field"><label>Other Charges (₹)</label><input type="number" step="0.01" name="other_charges" id="qOther" value="0"></div>
                        <div class="crm-form-field"><label>Valid Until</label><input type="datetime-local" name="valid_until" id="qValidUntil" value="<?php echo htmlspecialchars($defaultValidUntil); ?>" title="Defaults to <?php echo $quotationValidityHours; ?> hours from now per the Quotation Validity setting."></div>
                        <div class="crm-form-field crm-form-field-full"><label>Payment Terms</label><input type="text" name="payment_terms" id="qPaymentTerms"></div>
                    </div>
                </div>
                <div class="compliance-note" style="margin-bottom:16px;">
                    Base Amount: <strong id="qBaseDisplay">₹0.00</strong> &middot; Total Payable: <strong id="qTotalDisplay">₹0.00</strong>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Create Quotation</button>
            </form>
        </div>
    </div>
</div>

<script>
(function () {
    var drawer = document.getElementById('crmQuotationDrawer');
    var openBtn = document.getElementById('crmOpenQuotationDrawer');
    if (openBtn) {
        openBtn.addEventListener('click', function () {
            drawer.hidden = false;
            requestAnimationFrame(function () { drawer.classList.add('is-open', 'is-visible'); });
        });
    }
    document.getElementById('crmQuotationDrawerClose').addEventListener('click', function () {
        drawer.classList.remove('is-visible');
        setTimeout(function () { drawer.classList.remove('is-open'); drawer.hidden = true; }, 250);
    });
    function recalc() {
        var amount = parseFloat(document.getElementById('qAmount').value) || 0;
        var rate = parseFloat(document.getElementById('qRate').value) || 0;
        var base = amount * rate;
        var total = base
            + (parseFloat(document.getElementById('qService').value) || 0)
            + (parseFloat(document.getElementById('qMarkup').value) || 0)
            + (parseFloat(document.getElementById('qGst').value) || 0)
            + (parseFloat(document.getElementById('qOther').value) || 0);
        document.getElementById('qBaseDisplay').textContent = '₹' + base.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        document.getElementById('qTotalDisplay').textContent = '₹' + total.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }
    ['qAmount', 'qRate', 'qService', 'qMarkup', 'qGst', 'qOther'].forEach(function (id) {
        document.getElementById(id).addEventListener('input', recalc);
    });
    recalc();
})();
</script>

<div class="crm-card" id="payments">
    <div class="crm-page-header" style="margin:0 0 16px;padding:0;">
        <h3 style="margin:0;">Payments</h3>
        <?php if (forex_can_manage_payments()): ?>
        <button type="button" class="crm-btn crm-btn-primary crm-btn-sm" id="crmOpenPaymentDrawer"><i class="fa-solid fa-plus"></i> Record Payment</button>
        <?php endif; ?>
    </div>
    <?php if ($paymentError): ?><div style="background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($paymentError); ?></div><?php endif; ?>
    <p style="font-size:13px;color:var(--c-text);margin-bottom:14px;">Total confirmed paid: <strong>₹<?php echo number_format($totalPaid, 2); ?></strong></p>
    <?php if (!$payments): ?>
    <div class="crm-empty">No payments recorded yet.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Status</th><th>Method</th><th>Amount</th><th>Date</th><th>Reference</th><th>Recorded By</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
        <tr>
            <td><span class="crm-payment-badge" style="background:<?php echo $p['status'] === 'Paid' ? 'var(--c-green-bg)' : 'var(--c-amber-bg)'; ?>;color:<?php echo $p['status'] === 'Paid' ? 'var(--c-green)' : 'var(--c-amber)'; ?>;"><?php echo htmlspecialchars($p['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['method'] ?: '—'); ?></td>
            <td>₹<?php echo number_format((float) $p['amount'], 2); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['payment_date']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['reference'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['recorded_by']); ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<div class="crm-drawer-overlay" id="crmPaymentDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2>Record Payment</h2><button type="button" class="crm-drawer-close" id="crmPaymentDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post">
                <input type="hidden" name="action" value="record_payment">
                <div class="crm-form-grid" style="margin-bottom:16px;">
                    <div class="crm-form-field"><label>Status *</label>
                        <select name="status" required>
                            <?php foreach (FOREX_PAYMENT_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>"><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Method</label>
                        <select name="method">
                            <option value="">Select</option>
                            <?php foreach (FOREX_PAYMENT_METHODS as $m): ?><option value="<?php echo htmlspecialchars($m); ?>"><?php echo htmlspecialchars($m); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Amount (₹) *</label><input type="number" step="0.01" name="amount" required></div>
                    <div class="crm-form-field"><label>Payment Date</label><input type="date" name="payment_date" value="<?php echo date('Y-m-d'); ?>"></div>
                    <div class="crm-form-field"><label>Transaction ID</label><input type="text" name="transaction_id"></div>
                    <div class="crm-form-field"><label>Reference</label><input type="text" name="reference"></div>
                    <div class="crm-form-field crm-form-field-full"><label>Remarks</label><input type="text" name="remarks"></div>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Save Payment</button>
            </form>
        </div>
    </div>
</div>
<script>
(function () {
    var d = document.getElementById('crmPaymentDrawer');
    var btn = document.getElementById('crmOpenPaymentDrawer');
    if (btn) { btn.addEventListener('click', function () { d.hidden = false; requestAnimationFrame(function () { d.classList.add('is-open', 'is-visible'); }); }); }
    document.getElementById('crmPaymentDrawerClose').addEventListener('click', function () {
        d.classList.remove('is-visible');
        setTimeout(function () { d.classList.remove('is-open'); d.hidden = true; }, 250);
    });
})();
</script>

<div class="crm-card" id="delivery">
    <h3>Delivery</h3>
    <?php if ($delivery): ?>
    <div class="compliance-note" style="background:var(--c-green-bg);color:var(--c-green);margin-bottom:14px;"><i class="fa-solid fa-circle-check"></i> Delivered on <?php echo htmlspecialchars($delivery['delivery_date']); ?> at <?php echo htmlspecialchars($delivery['delivery_time']); ?> by <?php echo htmlspecialchars($delivery['delivered_by']); ?>.</div>
    <div class="crm-panel-grid" style="margin-bottom:14px;">
        <div class="crm-panel-item"><label>Received By</label><div class="val"><?php echo fx_fmt($delivery['received_by']); ?></div></div>
        <div class="crm-panel-item"><label>Amount</label><div class="val"><?php echo htmlspecialchars($delivery['currency_code']); ?> <?php echo number_format((float) $delivery['total_amount'], 2); ?></div></div>
        <div class="crm-panel-item"><label>Customer Acknowledgement</label><div class="val"><?php echo $delivery['customer_ack'] ? 'Confirmed' : 'Not confirmed'; ?></div></div>
        <div class="crm-panel-item"><label>Remarks</label><div class="val"><?php echo fx_fmt($delivery['remarks']); ?></div></div>
    </div>
    <?php if ($denominations): ?>
    <table class="crm-table" style="max-width:400px;">
        <thead><tr><th>Denomination</th><th>Qty</th><th>Subtotal</th></tr></thead>
        <tbody>
        <?php foreach ($denominations as $dn): ?>
        <tr><td><?php echo htmlspecialchars($delivery['currency_code']); ?> <?php echo number_format((float) $dn['denomination_value'], 2); ?></td><td><?php echo (int) $dn['quantity']; ?></td><td><?php echo number_format((float) $dn['denomination_value'] * (int) $dn['quantity'], 2); ?></td></tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    <?php endif; ?>
    <a href="forex-delivery-receipt.php?ref=<?php echo urlencode($request['forex_ref']); ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm" style="margin-top:14px;"><i class="fa-solid fa-file-pdf"></i> Download Delivery Receipt</a>
    <?php else: ?>
        <?php if ($blockers): ?>
        <div class="compliance-note" style="background:var(--c-red-bg);color:var(--c-red);margin-bottom:14px;">
            <strong>Delivery blocked. Mandatory compliance requirements have not been completed.</strong>
            <ul style="margin:8px 0 0;padding-left:20px;">
                <?php foreach ($blockers as $b): ?><li><?php echo htmlspecialchars($b); ?></li><?php endforeach; ?>
            </ul>
        </div>
        <?php else: ?>
        <div class="compliance-note" style="background:var(--c-green-bg);color:var(--c-green);margin-bottom:14px;"><i class="fa-solid fa-circle-check"></i> All mandatory compliance requirements are satisfied. Ready for delivery.</div>
        <?php endif; ?>

        <?php if ($deliveryError): ?>
        <div style="background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;">
            <?php foreach ($deliveryError as $e): ?><div><?php echo htmlspecialchars($e); ?></div><?php endforeach; ?>
        </div>
        <?php endif; ?>

        <?php if (!$blockers && forex_can_manage_delivery()): ?>
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenDeliveryDrawer"><i class="fa-solid fa-hand-holding-dollar"></i> Mark as Delivered</button>
        <?php elseif ($blockers && forex_can_override_compliance()): ?>
        <button type="button" class="crm-btn crm-btn-ghost" id="crmOpenDeliveryDrawer" style="color:var(--c-red);"><i class="fa-solid fa-triangle-exclamation"></i> Override &amp; Deliver Anyway</button>
        <?php endif; ?>
    <?php endif; ?>
</div>

<?php if (!$delivery): ?>
<div class="crm-drawer-overlay" id="crmDeliveryDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2><?php echo $blockers ? 'Override & Deliver' : 'Mark as Delivered'; ?></h2><button type="button" class="crm-drawer-close" id="crmDeliveryDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmDeliveryForm">
                <input type="hidden" name="action" value="mark_delivered">
                <?php if ($blockers): ?>
                <input type="hidden" name="override" value="1">
                <div class="crm-form-field crm-form-field-full" style="margin-bottom:16px;">
                    <label>Override Reason * (required, permanently recorded)</label>
                    <textarea name="override_reason" rows="3" required></textarea>
                </div>
                <?php endif; ?>
                <div class="crm-form-grid" style="margin-bottom:16px;">
                    <div class="crm-form-field"><label>Received By</label><input type="text" name="received_by" value="<?php echo htmlspecialchars($request['full_name']); ?>"></div>
                    <div class="crm-form-field"><label>Delivery Date</label><input type="date" name="delivery_date" value="<?php echo date('Y-m-d'); ?>"></div>
                    <div class="crm-form-field"><label>Delivery Time</label><input type="time" name="delivery_time" value="<?php echo date('H:i'); ?>"></div>
                    <div class="crm-form-field"><label>Total Amount Delivered (<?php echo htmlspecialchars($request['currency_code']); ?>) *</label><input type="number" step="0.01" name="total_amount" id="delTotalAmount" value="<?php echo htmlspecialchars($request['amount_required']); ?>" required></div>
                </div>
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-money-bill-wave"></i> Denomination Breakdown</h4>
                    <p style="font-size:12px;color:var(--c-muted);margin-bottom:10px;">Total denominations must match the amount delivered above.</p>
                    <div id="denomRows"></div>
                    <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" id="addDenomRow"><i class="fa-solid fa-plus"></i> Add Denomination</button>
                    <p style="font-size:12.5px;margin-top:10px;">Denomination Total: <strong id="denomTotalDisplay"><?php echo htmlspecialchars($request['currency_code']); ?> 0.00</strong></p>
                </div>
                <div class="crm-form-field" style="margin-bottom:16px;">
                    <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="customer_ack" style="width:auto;"> Customer has acknowledged receipt</label>
                </div>
                <div class="crm-form-field crm-form-field-full" style="margin-bottom:16px;"><label>Delivery Remarks</label><input type="text" name="delivery_remarks"></div>
                <button type="submit" class="crm-btn crm-btn-primary">Complete Delivery</button>
            </form>
        </div>
    </div>
</div>
<script>
(function () {
    var d = document.getElementById('crmDeliveryDrawer');
    var btn = document.getElementById('crmOpenDeliveryDrawer');
    if (btn) { btn.addEventListener('click', function () { d.hidden = false; requestAnimationFrame(function () { d.classList.add('is-open', 'is-visible'); }); }); }
    document.getElementById('crmDeliveryDrawerClose').addEventListener('click', function () {
        d.classList.remove('is-visible');
        setTimeout(function () { d.classList.remove('is-open'); d.hidden = true; }, 250);
    });
    var rowsEl = document.getElementById('denomRows');
    var currency = <?php echo json_encode($request['currency_code']); ?>;
    function recalcDenom() {
        var total = 0;
        rowsEl.querySelectorAll('.denom-row').forEach(function (row) {
            var v = parseFloat(row.querySelector('[name="denom_value[]"]').value) || 0;
            var q = parseInt(row.querySelector('[name="denom_qty[]"]').value, 10) || 0;
            total += v * q;
        });
        document.getElementById('denomTotalDisplay').textContent = currency + ' ' + total.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    }
    function addDenomRow() {
        var row = document.createElement('div');
        row.className = 'denom-row';
        row.style.cssText = 'display:flex;gap:8px;margin-bottom:8px;align-items:center;';
        row.innerHTML = '<input type="number" step="0.01" name="denom_value[]" placeholder="' + currency + ' value" style="flex:1;padding:6px 10px;border:1px solid var(--c-border);border-radius:6px;">' +
            '<span>&times;</span>' +
            '<input type="number" name="denom_qty[]" placeholder="Qty" style="width:90px;padding:6px 10px;border:1px solid var(--c-border);border-radius:6px;">' +
            '<button type="button" class="crm-btn crm-btn-ghost crm-btn-sm remove-denom">&times;</button>';
        row.querySelectorAll('input').forEach(function (inp) { inp.addEventListener('input', recalcDenom); });
        row.querySelector('.remove-denom').addEventListener('click', function () { row.remove(); recalcDenom(); });
        rowsEl.appendChild(row);
    }
    document.getElementById('addDenomRow').addEventListener('click', addDenomRow);
    addDenomRow();
})();
</script>
<?php endif; ?>

<div class="crm-card" id="status">
    <h3>Change Status</h3>
    <?php if (forex_can_verify_documents()): ?>
    <form method="post" style="display:flex;gap:10px;flex-wrap:wrap;align-items:flex-end;">
        <input type="hidden" name="action" value="change_status">
        <div class="crm-form-field" style="margin:0;min-width:220px;">
            <label>New Status</label>
            <select name="status">
                <?php foreach (FOREX_STATUSES as $s): ?><option value="<?php echo htmlspecialchars($s); ?>" <?php echo $s === $request['status'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($s); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-form-field" style="margin:0;flex:1;min-width:220px;">
            <label>Note (optional)</label>
            <input type="text" name="message" placeholder="Reason for the change...">
        </div>
        <button type="submit" class="crm-btn crm-btn-primary">Update Status</button>
    </form>
    <?php else: ?>
    <p class="crm-empty">You don't have permission to change this request's status.</p>
    <?php endif; ?>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Status History</h3>
        <div class="crm-timeline">
            <?php foreach ($history as $h): ?>
            <div class="crm-timeline-item">
                <div class="crm-timeline-dot"></div>
                <div class="crm-timeline-action"><?php echo htmlspecialchars($h['previous_status'] ? $h['previous_status'] . ' → ' . $h['new_status'] : $h['new_status']); ?></div>
                <?php if ($h['message']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($h['message']); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo htmlspecialchars($h['changed_by']); ?> &middot; <?php echo htmlspecialchars(substr($h['created_at'], 0, 16)); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$history): ?><div class="crm-empty">No status changes yet.</div><?php endif; ?>
        </div>
    </div>
    <div class="crm-card">
        <h3>Audit Log</h3>
        <div class="crm-timeline">
            <?php foreach ($auditLog as $a): ?>
            <div class="crm-timeline-item">
                <div class="crm-timeline-dot"></div>
                <div class="crm-timeline-action"><?php echo htmlspecialchars($a['action']); ?></div>
                <?php if ($a['new_value']): ?><div class="crm-timeline-notes"><?php echo htmlspecialchars($a['new_value']); ?></div><?php endif; ?>
                <div class="crm-timeline-meta"><?php echo htmlspecialchars($a['user_name']); ?> &middot; <?php echo htmlspecialchars(substr($a['created_at'], 0, 16)); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$auditLog): ?><div class="crm-empty">No audit entries yet.</div><?php endif; ?>
        </div>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
