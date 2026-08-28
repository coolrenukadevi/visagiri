<?php
ob_start();
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
    b2b_csrf_require_or_403();
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
    } elseif ($action === 'assign_tier' && b2b_can_manage_tiers_pricing()) {
        $tierName = trim($_POST['tier'] ?? '');
        $applyCreditLimit = !empty($_POST['apply_credit_limit']);
        if ($tierName !== '' && !in_array($tierName, B2B_TIER_NAMES, true)) {
            $actionError = 'Invalid tier.';
        } else {
            $fields = ['tier' => $tierName ?: null, 'updated_at' => gmdate('c')];
            if ($applyCreditLimit && $tierName !== '') {
                $tierStmt = $pdo->prepare('SELECT default_credit_limit FROM b2b_tiers WHERE name = ?');
                $tierStmt->execute([$tierName]);
                $defaultLimit = $tierStmt->fetchColumn();
                if ($defaultLimit !== false) {
                    $fields['credit_limit'] = (float) $defaultLimit;
                }
            }
            $setSql = implode(', ', array_map(fn($k) => "$k = :$k", array_keys($fields)));
            $pdo->prepare("UPDATE b2b_partners SET $setSql WHERE id = :id")->execute($fields + ['id' => $partnerId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Assigned tier', $partner['tier'] ?? '', $tierName ?: 'Unassigned');
            $partner = array_merge($partner, $fields);
            $actionMessage = $tierName !== '' ? "Tier set to $tierName." : 'Tier unassigned.';
        }
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
    } elseif ($action === 'generate_invoice' && b2b_can_manage_finance()) {
        $quotationId = (int) ($_POST['quotation_id'] ?? 0);
        $qStmt = $pdo->prepare("SELECT * FROM b2b_quotations WHERE id = ? AND partner_id = ? AND status = 'Accepted'");
        $qStmt->execute([$quotationId, $partnerId]);
        $quotation = $qStmt->fetch(PDO::FETCH_ASSOC);
        if (!$quotation) {
            $actionError = 'Only an accepted quotation can be invoiced.';
        } else {
            $existingStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_invoices WHERE quotation_id = ?');
            $existingStmt->execute([$quotationId]);
            if ((int) $existingStmt->fetchColumn() > 0) {
                $actionError = 'This quotation has already been invoiced.';
            } else {
                $taxableAmount = round((float) $quotation['total'] - (float) $quotation['gst'], 2);
                $invoiceNumber = b2b_generate_ref($pdo, b2b_setting($pdo, 'invoice_number_prefix', 'B2B-INV'));
                $dueDays = (int) b2b_setting($pdo, 'invoice_due_days', '15');
                $now = gmdate('c');

                $pdo->prepare('INSERT INTO b2b_invoices (
                    invoice_number, partner_id, quotation_id, enquiry_id, taxable_amount, gst, discount, total, status, due_date, created_by, created_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')->execute([
                    $invoiceNumber, $partnerId, $quotationId, $quotation['enquiry_id'],
                    $taxableAmount, $quotation['gst'], $quotation['discount'], $quotation['total'],
                    'Issued', gmdate('c', strtotime("+$dueDays days")), admin_name(), $now,
                ]);
                $invoiceId = (int) $pdo->lastInsertId();

                b2b_log_audit($pdo, 'invoice', $invoiceId, admin_name(), admin_role(), 'Generated invoice from quotation', $quotation['quotation_ref'], "$invoiceNumber — ₹{$quotation['total']}");
                b2b_notify($pdo, null, 'b2b_invoice_issued', "Invoice $invoiceNumber issued to {$partner['company_name']}: ₹" . number_format((float) $quotation['total'], 2) . '.', $partnerId);
                b2b_notify_partner(
                    $pdo, $partner, "New Invoice — $invoiceNumber",
                    "Dear {$partner['contact_name']},\n\nAn invoice has been issued against your accepted quotation {$quotation['quotation_ref']}.\n\nInvoice Number: $invoiceNumber\nTotal: ₹" . number_format((float) $quotation['total'], 2) . "\nDue Date: " . date('d M Y', strtotime("+$dueDays days")) . "\n\nPlease log in to your Partner Portal to view the full breakdown.\n\nRegards,\nVisaAgency.in B2B Partner Team"
                );
                $actionMessage = "Invoice $invoiceNumber generated.";
            }
        }
    } elseif ($action === 'record_payment' && b2b_can_manage_finance()) {
        $invoiceId = (int) ($_POST['invoice_id'] ?? 0);
        $amount = filter_var($_POST['amount'] ?? '', FILTER_VALIDATE_FLOAT);
        $method = trim($_POST['method'] ?? '');
        $invStmt = $pdo->prepare('SELECT * FROM b2b_invoices WHERE id = ? AND partner_id = ?');
        $invStmt->execute([$invoiceId, $partnerId]);
        $invoice = $invStmt->fetch(PDO::FETCH_ASSOC);

        if (!$invoice || $amount === false || $amount <= 0 || !in_array($method, CRM_PAYMENT_METHODS, true)) {
            $actionError = 'Please provide a valid invoice, amount and payment method.';
        } else {
            $now = gmdate('c');
            $pdo->prepare('INSERT INTO b2b_invoice_payments (invoice_id, amount, method, transaction_id, reference, remarks, recorded_by, payment_date, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
                ->execute([
                    $invoiceId, $amount, $method,
                    trim($_POST['transaction_id'] ?? '') ?: null,
                    trim($_POST['reference'] ?? '') ?: null,
                    trim($_POST['remarks'] ?? '') ?: null,
                    admin_name(), trim($_POST['payment_date'] ?? '') ?: gmdate('Y-m-d'), $now,
                ]);
            $newStatus = b2b_invoice_recalc_status($pdo, $invoiceId);
            b2b_log_audit($pdo, 'invoice', $invoiceId, admin_name(), admin_role(), 'Recorded payment', '', "$method: ₹" . number_format($amount, 2) . " ($newStatus)");
            b2b_notify_partner(
                $pdo, $partner, "Payment Received — {$invoice['invoice_number']}",
                "Dear {$partner['contact_name']},\n\nWe have recorded a payment of ₹" . number_format($amount, 2) . " against invoice {$invoice['invoice_number']}.\n\nCurrent Status: $newStatus\n\nRegards,\nVisaAgency.in B2B Partner Team"
            );
            $actionMessage = 'Payment of ₹' . number_format($amount, 2) . " recorded. Invoice is now $newStatus.";
        }
    } elseif ($action === 'wallet_transaction' && b2b_can_manage_finance()) {
        $type = trim($_POST['type'] ?? '');
        $amount = filter_var($_POST['amount'] ?? '', FILTER_VALIDATE_FLOAT);
        $reason = trim($_POST['reason'] ?? '');
        if (!in_array($type, ['Credit Added', 'Debit', 'Adjustment'], true) || $amount === false || $amount <= 0 || $reason === '') {
            $actionError = 'Please provide a valid transaction type, amount and reason.';
        } else {
            $newBalance = b2b_wallet_record($pdo, $partnerId, $type, $amount, $reason, admin_name());
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), "Wallet: $type", '', '₹' . number_format($amount, 2) . " — $reason (balance now ₹" . number_format($newBalance, 2) . ')');
            $partner['wallet_balance'] = $newBalance;
            $actionMessage = "Wallet updated. New balance: ₹" . number_format($newBalance, 2) . '.';
        }
    } elseif ($action === 'update_credit_limit' && b2b_can_manage_finance()) {
        $creditLimit = filter_var($_POST['credit_limit'] ?? '', FILTER_VALIDATE_FLOAT);
        if ($creditLimit === false || $creditLimit < 0) {
            $actionError = 'Please provide a valid credit limit.';
        } else {
            $pdo->prepare('UPDATE b2b_partners SET credit_limit = ?, updated_at = ? WHERE id = ?')->execute([$creditLimit, gmdate('c'), $partnerId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Updated credit limit', $partner['credit_limit'] ?? '0', (string) $creditLimit);
            $partner['credit_limit'] = $creditLimit;
            $actionMessage = 'Credit limit updated to ₹' . number_format($creditLimit, 2) . '.';
        }
    } elseif ($action === 'send_message' && b2b_can_communicate()) {
        $body = trim($_POST['body'] ?? '');
        if ($body === '') {
            $actionError = 'Message cannot be empty.';
        } else {
            $pdo->prepare('INSERT INTO b2b_messages (partner_id, sender_type, sender_id, sender_name, subject, body, is_read, created_at) VALUES (?, ?, ?, ?, ?, ?, 0, ?)')
                ->execute([$partnerId, 'Staff', admin_user_id(), admin_name(), 'Message from your Relationship Manager', $body, gmdate('c')]);
            b2b_notify_partner($pdo, $partner, 'New Message from VisaAgency.in B2B Team', "Dear {$partner['contact_name']},\n\nYou have a new message from your Relationship Manager:\n\n\"$body\"\n\nPlease log in to your Partner Portal to reply.\n\nRegards,\nVisaAgency.in B2B Partner Team");
            $actionMessage = 'Message sent to the partner.';
        }
    } elseif ($action === 'upload_document' && b2b_can_verify_documents()) {
        // Staff-side fallback for when a partner can't complete their own
        // upload (e.g. a hosting firewall blocking the upload endpoint) —
        // shares the exact same validation as the partner-facing uploader
        // via b2b_save_uploaded_document(), and auto-verifies since staff
        // are attesting to a document they've already reviewed themselves
        // (over email, etc.) rather than re-queuing it for their own review.
        $docType = trim($_POST['doc_type'] ?? '');
        $result = b2b_save_uploaded_document($pdo, $partner, $docType, $_FILES['file'] ?? [], admin_name(), admin_role(), true);
        if (!$result['success']) {
            $actionError = $result['message'];
        } else {
            $actionMessage = "Document \"{$result['filename']}\" added and marked Verified.";
        }
    } elseif ($action === 'archive_partner' && b2b_can_manage_enrollment()) {
        $now = gmdate('c');
        $pdo->prepare('UPDATE b2b_partners SET archived_at = ?, archived_by = ? WHERE id = ?')->execute([$now, admin_name(), $partnerId]);
        b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Moved partner to Recycle Bin', '', '');
        $partner['archived_at'] = $now;
        $partner['archived_by'] = admin_name();
        $actionMessage = 'Partner moved to the Recycle Bin. It no longer appears in the Partners list.';
    } elseif ($action === 'restore_partner' && b2b_can_manage_enrollment()) {
        $pdo->prepare('UPDATE b2b_partners SET archived_at = NULL, archived_by = NULL WHERE id = ?')->execute([$partnerId]);
        b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Restored partner from Recycle Bin', '', '');
        $partner['archived_at'] = null;
        $partner['archived_by'] = null;
        $actionMessage = 'Partner restored.';
    } elseif ($action === 'delete_document' && b2b_can_verify_documents()) {
        $docId = (int) ($_POST['document_id'] ?? 0);
        $dStmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE id = ? AND partner_id = ? AND deleted_at IS NULL');
        $dStmt->execute([$docId, $partnerId]);
        $doc = $dStmt->fetch(PDO::FETCH_ASSOC);
        if (!$doc) {
            $actionError = 'Document not found.';
        } else {
            $pdo->prepare('UPDATE b2b_partner_documents SET deleted_at = ?, deleted_by = ? WHERE id = ?')->execute([gmdate('c'), admin_name(), $docId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Moved document to Recycle Bin', $doc['doc_type'], $doc['original_filename']);
            $actionMessage = "Document \"{$doc['original_filename']}\" moved to the Recycle Bin.";
        }
    } elseif ($action === 'restore_document' && b2b_can_verify_documents()) {
        $docId = (int) ($_POST['document_id'] ?? 0);
        $dStmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE id = ? AND partner_id = ? AND deleted_at IS NOT NULL');
        $dStmt->execute([$docId, $partnerId]);
        $doc = $dStmt->fetch(PDO::FETCH_ASSOC);
        if (!$doc) {
            $actionError = 'Document not found in the Recycle Bin.';
        } else {
            $pdo->prepare('UPDATE b2b_partner_documents SET deleted_at = NULL, deleted_by = NULL WHERE id = ?')->execute([$docId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Restored document from Recycle Bin', '', $doc['original_filename']);
            $actionMessage = "Document \"{$doc['original_filename']}\" restored.";
        }
    } elseif ($action === 'edit_company_name' && b2b_can_manage_enrollment()) {
        $newName = trim($_POST['new_value'] ?? '');
        if ($newName === '') {
            $actionError = 'Company name cannot be empty.';
        } else {
            $old = $partner['company_name'];
            $pdo->prepare('UPDATE b2b_partners SET company_name = ?, updated_at = ? WHERE id = ?')->execute([$newName, gmdate('c'), $partnerId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Corrected company name (direct edit)', $old, $newName);
            $partner['company_name'] = $newName;
            $actionMessage = 'Company name updated.';
        }
    } elseif ($action === 'edit_contact_name' && b2b_can_manage_enrollment()) {
        $newName = trim($_POST['new_value'] ?? '');
        if ($newName === '') {
            $actionError = 'Contact name cannot be empty.';
        } else {
            $old = $partner['contact_name'];
            $pdo->prepare('UPDATE b2b_partners SET contact_name = ?, updated_at = ? WHERE id = ?')->execute([$newName, gmdate('c'), $partnerId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Corrected contact name (direct edit)', $old, $newName);
            $partner['contact_name'] = $newName;
            $actionMessage = 'Contact name updated.';
        }
    } elseif ($action === 'edit_document_name' && b2b_can_verify_documents()) {
        $docId = (int) ($_POST['document_id'] ?? 0);
        $newName = trim($_POST['new_value'] ?? '');
        $dStmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE id = ? AND partner_id = ? AND deleted_at IS NULL');
        $dStmt->execute([$docId, $partnerId]);
        $doc = $dStmt->fetch(PDO::FETCH_ASSOC);
        if (!$doc || $newName === '') {
            $actionError = 'Please provide a valid document and new name.';
        } else {
            $pdo->prepare('UPDATE b2b_partner_documents SET original_filename = ? WHERE id = ?')->execute([$newName, $docId]);
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), 'Corrected document name (direct edit)', $doc['original_filename'], $newName);
            $actionMessage = 'Document name updated.';
        }
    } elseif ($action === 'review_correction' && b2b_can_manage_enrollment()) {
        $requestId = (int) ($_POST['request_id'] ?? 0);
        $decision = trim($_POST['decision'] ?? '');
        $reviewNote = trim($_POST['review_note'] ?? '');
        $rStmt = $pdo->prepare("SELECT * FROM b2b_correction_requests WHERE id = ? AND partner_id = ? AND status = 'Pending'");
        $rStmt->execute([$requestId, $partnerId]);
        $request = $rStmt->fetch(PDO::FETCH_ASSOC);
        if (!$request || !in_array($decision, ['Approved', 'Rejected'], true)) {
            $actionError = 'That correction request could not be reviewed.';
        } else {
            $pdo->prepare('UPDATE b2b_correction_requests SET status = ?, reviewed_by = ?, reviewed_at = ?, review_note = ? WHERE id = ?')
                ->execute([$decision, admin_name(), gmdate('c'), $reviewNote ?: null, $requestId]);
            if ($decision === 'Approved') {
                b2b_apply_correction($pdo, $request);
            }
            $fieldLabel = B2B_CORRECTION_FIELD_TYPES[$request['field_type']] ?? $request['field_type'];
            b2b_log_audit($pdo, 'partner', $partnerId, admin_name(), admin_role(), "Correction request $decision", "$fieldLabel: {$request['old_value']}", "{$request['new_value']}" . ($reviewNote ? " ($reviewNote)" : ''));
            b2b_notify_partner(
                $pdo, $partner, "Correction Request $decision — $fieldLabel",
                "Dear {$partner['contact_name']},\n\nYour request to change $fieldLabel from \"{$request['old_value']}\" to \"{$request['new_value']}\" has been $decision." . ($reviewNote ? "\n\nNote from our team: $reviewNote" : '') . "\n\nRegards,\nVisaAgency.in B2B Partner Team"
            );
            $actionMessage = "Correction request $decision.";
        }
    }
}

$docsStmt = $pdo->prepare("SELECT * FROM b2b_partner_documents d WHERE partner_id = ? AND deleted_at IS NULL AND id = (
    SELECT MAX(id) FROM b2b_partner_documents WHERE partner_id = ? AND doc_type = d.doc_type AND deleted_at IS NULL
) ORDER BY doc_type");
$docsStmt->execute([$partnerId, $partnerId]);
$documents = [];
foreach ($docsStmt->fetchAll(PDO::FETCH_ASSOC) as $d) { $documents[$d['doc_type']] = $d; }

$managers = $pdo->query("SELECT id, name, role FROM users WHERE role IN ('Super Admin','B2B Admin','B2B Relationship Manager') ORDER BY name")->fetchAll(PDO::FETCH_ASSOC);
$tiersList = $pdo->query("SELECT * FROM b2b_tiers WHERE is_active = 1 ORDER BY default_credit_limit ASC")->fetchAll(PDO::FETCH_ASSOC);
$auditStmt = $pdo->prepare("SELECT * FROM b2b_audit_logs WHERE entity_type = 'partner' AND entity_id = ? ORDER BY id DESC LIMIT 50");
$auditStmt->execute([$partnerId]);
$auditLog = $auditStmt->fetchAll(PDO::FETCH_ASSOC);

$correctionsStmt = $pdo->prepare('SELECT * FROM b2b_correction_requests WHERE partner_id = ? ORDER BY requested_at DESC');
$correctionsStmt->execute([$partnerId]);
$correctionRequests = $correctionsStmt->fetchAll(PDO::FETCH_ASSOC);

$deletedDocsStmt = $pdo->prepare("SELECT * FROM b2b_partner_documents WHERE partner_id = ? AND deleted_at IS NOT NULL ORDER BY deleted_at DESC");
$deletedDocsStmt->execute([$partnerId]);
$deletedDocuments = $deletedDocsStmt->fetchAll(PDO::FETCH_ASSOC);

$visaCasesStmt = $pdo->prepare('SELECT * FROM enquiries WHERE partner_id = ? AND archived_at IS NULL ORDER BY created_at DESC');
$visaCasesStmt->execute([$partnerId]);
$visaCases = $visaCasesStmt->fetchAll(PDO::FETCH_ASSOC);
$visaCaseCount = count($visaCases);

$quotationsStmt = $pdo->prepare('SELECT * FROM b2b_quotations WHERE partner_id = ? ORDER BY created_at DESC');
$quotationsStmt->execute([$partnerId]);
$quotations = $quotationsStmt->fetchAll(PDO::FETCH_ASSOC);

$invoicesStmt = $pdo->prepare('SELECT * FROM b2b_invoices WHERE partner_id = ? ORDER BY created_at DESC');
$invoicesStmt->execute([$partnerId]);
$invoices = $invoicesStmt->fetchAll(PDO::FETCH_ASSOC);

$invoiceableQuotationsStmt = $pdo->prepare("SELECT q.* FROM b2b_quotations q
    WHERE q.partner_id = ? AND q.status = 'Accepted' AND NOT EXISTS (SELECT 1 FROM b2b_invoices i WHERE i.quotation_id = q.id)
    ORDER BY q.created_at DESC");
$invoiceableQuotationsStmt->execute([$partnerId]);
$invoiceableQuotations = $invoiceableQuotationsStmt->fetchAll(PDO::FETCH_ASSOC);

$paymentsStmt = $pdo->prepare('SELECT ip.*, i.invoice_number FROM b2b_invoice_payments ip
    JOIN b2b_invoices i ON i.id = ip.invoice_id WHERE i.partner_id = ? ORDER BY ip.created_at DESC');
$paymentsStmt->execute([$partnerId]);
$invoicePayments = $paymentsStmt->fetchAll(PDO::FETCH_ASSOC);

$walletStmt = $pdo->prepare('SELECT * FROM b2b_wallet_transactions WHERE partner_id = ? ORDER BY created_at DESC LIMIT 100');
$walletStmt->execute([$partnerId]);
$walletTransactions = $walletStmt->fetchAll(PDO::FETCH_ASSOC);

$messagesStmt = $pdo->prepare('SELECT * FROM b2b_messages WHERE partner_id = ? ORDER BY created_at ASC');
$messagesStmt->execute([$partnerId]);
$partnerMessages = $messagesStmt->fetchAll(PDO::FETCH_ASSOC);
// A staff member viewing this thread has, by definition, just seen the
// partner's unread messages — mark them read the same way opening a chat
// thread would. Never touches the partner's own is_read flag on their side.
$pdo->prepare("UPDATE b2b_messages SET is_read = 1 WHERE partner_id = ? AND sender_type = 'Partner' AND is_read = 0")->execute([$partnerId]);

$servicesOffered = json_decode($partner['services_offered'] ?? '[]', true) ?: [];
$visaSpecialization = json_decode($partner['visa_specialization'] ?? '[]', true) ?: [];

$tab = $_GET['tab'] ?? 'overview';
$tabs = [
    'overview' => 'Overview', 'company' => 'Company Information', 'documents' => 'Documents',
    'applications' => 'Visa Applications', 'quotations' => 'Quotations', 'invoices' => 'Invoices',
    'payments' => 'Payments', 'communications' => 'Communications', 'corrections' => 'Corrections', 'activities' => 'Activities',
];
$builtTabs = ['overview', 'company', 'documents', 'applications', 'quotations', 'invoices', 'payments', 'communications', 'corrections', 'activities'];
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title"><?php echo htmlspecialchars($partner['company_name']); ?></h1>
        <p class="crm-page-subtitle"><?php echo htmlspecialchars($partner['application_ref']); ?> &middot; <span class="crm-status-badge <?php echo b2b_status_class($partner['status']); ?>"><?php echo htmlspecialchars($partner['status']); ?></span><?php if (!empty($partner['archived_at'])): ?> &middot; <span class="crm-status-badge status-cancelled"><i class="fa-solid fa-trash-can"></i> In Recycle Bin</span><?php endif; ?></p>
    </div>
    <?php if (b2b_can_manage_enrollment()): ?>
    <div>
        <?php if (!empty($partner['archived_at'])): ?>
        <form method="post" onsubmit="return confirm('Restore this partner? It will reappear in the Partners list.');">
            <input type="hidden" name="action" value="restore_partner">
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm"><i class="fa-solid fa-trash-arrow-up"></i> Restore Partner</button>
        </form>
        <?php else: ?>
        <form method="post" onsubmit="return confirm('Move this partner to the Recycle Bin? It will no longer appear in the Partners list until restored.');">
            <input type="hidden" name="action" value="archive_partner">
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-trash-can"></i> Move to Recycle Bin</button>
        </form>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</div>

<?php if ($actionMessage): ?><div class="crm-alert crm-alert-success"><i class="fa-solid fa-circle-check"></i> <?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="crm-alert crm-alert-error"><i class="fa-solid fa-circle-exclamation"></i> <?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<?php if (b2b_can_manage_enrollment() && !$partner['archived_at']): ?>
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
<script>
document.addEventListener('click', function (e) {
    var a = e.target.closest('.crm-inline-edit-toggle');
    if (!a) { return; }
    e.preventDefault();
    var target = document.getElementById(a.dataset.target);
    if (!target) { return; }
    target.hidden = !target.hidden;
    target.style.display = target.hidden ? 'none' : 'flex';
    if (!target.hidden) { target.querySelector('input[type=text]').focus(); }
});
</script>

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
            <div class="crm-panel-item">
                <label>Company <?php if (b2b_can_manage_enrollment()): ?><a href="#" class="crm-inline-edit-toggle" data-target="editCompanyName" style="font-weight:400;font-size:11px;">(fix typo)</a><?php endif; ?></label>
                <div class="val"><?php echo htmlspecialchars($partner['company_name']); ?></div>
                <?php if (b2b_can_manage_enrollment()): ?>
                <form method="post" id="editCompanyName" class="crm-inline-edit-form" hidden style="margin-top:6px;gap:6px;">
                    <input type="hidden" name="action" value="edit_company_name">
                    <input type="text" name="new_value" value="<?php echo htmlspecialchars($partner['company_name']); ?>" required style="flex:1;border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;font-size:12.5px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Save</button>
                </form>
                <?php endif; ?>
            </div>
            <div class="crm-panel-item">
                <label>Contact Person <?php if (b2b_can_manage_enrollment()): ?><a href="#" class="crm-inline-edit-toggle" data-target="editContactName" style="font-weight:400;font-size:11px;">(fix typo)</a><?php endif; ?></label>
                <div class="val"><?php echo htmlspecialchars($partner['contact_name']); ?> (<?php echo htmlspecialchars($partner['contact_designation'] ?: '—'); ?>)</div>
                <?php if (b2b_can_manage_enrollment()): ?>
                <form method="post" id="editContactName" class="crm-inline-edit-form" hidden style="margin-top:6px;gap:6px;">
                    <input type="hidden" name="action" value="edit_contact_name">
                    <input type="text" name="new_value" value="<?php echo htmlspecialchars($partner['contact_name']); ?>" required style="flex:1;border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;font-size:12.5px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Save</button>
                </form>
                <?php endif; ?>
            </div>
            <div class="crm-panel-item"><label>Email</label><div class="val"><?php echo htmlspecialchars($partner['contact_email']); ?></div></div>
            <div class="crm-panel-item"><label>Mobile</label><div class="val"><?php echo htmlspecialchars($partner['contact_mobile']); ?></div></div>
            <div class="crm-panel-item"><label>Registration Date</label><div class="val"><?php echo htmlspecialchars(substr($partner['created_at'], 0, 10)); ?></div></div>
            <div class="crm-panel-item"><label>Status</label><div class="val"><span class="crm-status-badge <?php echo b2b_status_class($partner['status']); ?>"><?php echo htmlspecialchars($partner['status']); ?></span></div></div>
            <div class="crm-panel-item"><label>Tier</label><div class="val"><?php echo htmlspecialchars($partner['tier'] ?: 'Not yet assigned'); ?></div></div>
            <div class="crm-panel-item"><label>Credit Limit</label><div class="val">₹<?php echo number_format((float) $partner['credit_limit'], 2); ?></div></div>
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

        <?php if (b2b_can_manage_tiers_pricing()): ?>
        <form method="post" style="margin-top:14px;display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
            <input type="hidden" name="action" value="assign_tier">
            <label style="font-size:13px;font-weight:600;color:var(--c-heading);">Tier</label>
            <select name="tier" style="border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <option value="">Unassigned</option>
                <?php foreach ($tiersList as $t): ?>
                <option value="<?php echo htmlspecialchars($t['name']); ?>" <?php echo $partner['tier'] === $t['name'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($t['name']); ?> (₹<?php echo number_format((float) $t['default_credit_limit'], 0); ?> limit, <?php echo (float) $t['default_discount_percent']; ?>% discount)</option>
                <?php endforeach; ?>
            </select>
            <label style="font-size:12px;color:var(--c-muted);display:flex;align-items:center;gap:5px;"><input type="checkbox" name="apply_credit_limit" value="1"> Apply tier's default credit limit</label>
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
                <?php if (b2b_can_verify_documents()): ?>
                <div style="display:flex;gap:10px;margin-top:8px;">
                    <a href="#" class="crm-inline-edit-toggle" data-target="editDocName<?php echo (int) $doc['id']; ?>" style="font-size:11px;">Rename</a>
                    <form method="post" onsubmit="return confirm('Move this document to the Recycle Bin?');">
                        <input type="hidden" name="action" value="delete_document">
                        <input type="hidden" name="document_id" value="<?php echo (int) $doc['id']; ?>">
                        <button type="submit" style="background:none;border:none;padding:0;font-size:11px;color:var(--c-red);cursor:pointer;text-decoration:underline;">Delete</button>
                    </form>
                </div>
                <form method="post" id="editDocName<?php echo (int) $doc['id']; ?>" class="crm-inline-edit-form" hidden style="margin-top:6px;gap:6px;">
                    <input type="hidden" name="action" value="edit_document_name">
                    <input type="hidden" name="document_id" value="<?php echo (int) $doc['id']; ?>">
                    <input type="text" name="new_value" value="<?php echo htmlspecialchars($doc['original_filename']); ?>" required style="flex:1;border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;font-size:12px;">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Save</button>
                </form>
                <?php endif; ?>
                <?php else: ?>
                <div class="crm-cell-sub">Not uploaded yet.</div>
                <?php endif; ?>
            </div>
            <?php endforeach; ?>
        </div>

        <?php if ($deletedDocuments && b2b_can_verify_documents()): ?>
        <details style="margin-top:16px;">
            <summary style="cursor:pointer;font-size:12.5px;font-weight:600;color:var(--c-muted);"><i class="fa-solid fa-trash-can"></i> Recently deleted documents (<?php echo count($deletedDocuments); ?>)</summary>
            <div class="crm-table-wrap" style="margin-top:10px;">
            <table class="crm-table">
                <thead><tr><th>Type</th><th>Filename</th><th>Deleted By</th><th>Deleted</th><th></th></tr></thead>
                <tbody>
                <?php foreach ($deletedDocuments as $dd): ?>
                <tr>
                    <td class="crm-cell-sub"><?php echo htmlspecialchars(B2B_DOC_TYPES[$dd['doc_type']] ?? $dd['doc_type']); ?></td>
                    <td><?php echo htmlspecialchars($dd['original_filename']); ?></td>
                    <td class="crm-cell-sub"><?php echo htmlspecialchars($dd['deleted_by'] ?: '—'); ?></td>
                    <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $dd['deleted_at'], 0, 10)); ?></td>
                    <td>
                        <form method="post"><input type="hidden" name="action" value="restore_document"><input type="hidden" name="document_id" value="<?php echo (int) $dd['id']; ?>"><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Restore</button></form>
                    </td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
            </div>
        </details>
        <?php endif; ?>

        <?php if (b2b_can_verify_documents()): ?>
        <details style="margin-top:16px;">
            <summary style="cursor:pointer;font-size:12.5px;font-weight:600;color:var(--c-blue);">+ Manually add a document on the partner's behalf</summary>
            <p class="crm-cell-sub" style="margin:10px 0;">Use this if the partner can't complete their own upload (e.g. a hosting-side block on their end). A document added here is marked <strong>Verified</strong> immediately, under your name — only use it for a document you've actually reviewed.</p>
            <form method="post" enctype="multipart/form-data" class="crm-panel-grid">
                <input type="hidden" name="action" value="upload_document">
                <div class="crm-panel-item">
                    <label>Document Type</label>
                    <select name="doc_type" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                        <?php foreach (B2B_DOC_TYPES as $docKey => $docLabel):
                            if ($docKey === 'IATA' && !$partner['iata_registered']) { continue; }
                        ?>
                        <option value="<?php echo htmlspecialchars($docKey); ?>"><?php echo htmlspecialchars($docLabel); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="crm-panel-item"><label>File</label><input type="file" name="file" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:6px 10px;"></div>
                <div class="crm-panel-item full"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Add &amp; Mark Verified</button></div>
            </form>
        </details>
        <?php endif; ?>
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
                    <select name="service_category" id="crmQuoteServiceCategory" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                        <option value="">Select service</option>
                        <?php foreach (B2B_SERVICES_OFFERED as $svc): ?><option value="<?php echo htmlspecialchars($svc); ?>"><?php echo htmlspecialchars($svc); ?></option><?php endforeach; ?>
                    </select>
                    <span id="crmQuotePriceHint" class="crm-cell-sub" style="display:block;margin-top:4px;"></span>
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
                <div class="crm-panel-item"><label>Visa Fee (₹)</label><input type="number" name="visa_fee" id="crmQuoteVisaFee" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
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
    <script>
    (function () {
        var categorySelect = document.getElementById('crmQuoteServiceCategory');
        var visaFeeInput = document.getElementById('crmQuoteVisaFee');
        var hint = document.getElementById('crmQuotePriceHint');
        if (!categorySelect) { return; }
        categorySelect.addEventListener('change', function () {
            hint.textContent = '';
            if (!categorySelect.value) { return; }
            fetch('b2b-pricing-lookup.php?partner_id=<?php echo $partnerId; ?>&service_category=' + encodeURIComponent(categorySelect.value))
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    if (data.found) {
                        visaFeeInput.value = data.partner_price.toFixed(2);
                        hint.textContent = 'Suggested from this partner\'s pricing rule: ₹' + data.partner_price.toFixed(2) + ' — pre-filled into Visa Fee, adjust as needed.';
                    } else {
                        hint.textContent = 'No pricing rule found for this service/tier — enter fees manually.';
                    }
                })
                .catch(function () { hint.textContent = ''; });
        });
    })();
    </script>
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

<?php elseif ($tab === 'invoices'): ?>
    <?php if ($invoiceableQuotations && b2b_can_manage_finance()): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Generate Invoice from Accepted Quotation</h3>
        <?php foreach ($invoiceableQuotations as $iq): ?>
        <form method="post" style="display:flex;gap:10px;align-items:center;margin-bottom:8px;">
            <input type="hidden" name="action" value="generate_invoice">
            <input type="hidden" name="quotation_id" value="<?php echo (int) $iq['id']; ?>">
            <span class="crm-cell-sub" style="flex:1;"><?php echo htmlspecialchars($iq['quotation_ref']); ?> — <?php echo htmlspecialchars($iq['service_category']); ?> — ₹<?php echo number_format((float) $iq['total'], 2); ?></span>
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Generate Invoice</button>
        </form>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <div class="crm-card" style="padding:0;">
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Invoice #</th><th>Total</th><th>Due Date</th><th>Status</th><th>Created</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($invoices as $inv): ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars($inv['invoice_number']); ?></td>
                <td>₹<?php echo number_format((float) $inv['total'], 2); ?></td>
                <td class="crm-cell-sub"><?php echo $inv['due_date'] ? htmlspecialchars(substr($inv['due_date'], 0, 10)) : '—'; ?></td>
                <td><span class="crm-status-badge <?php echo b2b_invoice_status_class($inv['status']); ?>"><?php echo htmlspecialchars($inv['status']); ?></span></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($inv['created_at'], 0, 10)); ?></td>
                <td><a href="b2b-invoice-pdf.php?id=<?php echo (int) $inv['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i></a></td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$invoices): ?>
            <tr><td colspan="6" class="crm-empty">No invoices generated yet.</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
    </div>

<?php elseif ($tab === 'payments'): ?>
    <div class="crm-kpi-grid" style="grid-template-columns:repeat(2,1fr); margin-bottom:16px;">
        <div class="crm-kpi"><div class="crm-kpi-value">₹<?php echo number_format((float) $partner['wallet_balance'], 2); ?></div><div class="crm-kpi-label">Wallet Balance</div></div>
        <div class="crm-kpi"><div class="crm-kpi-value">₹<?php echo number_format((float) $partner['credit_limit'], 2); ?></div><div class="crm-kpi-label">Credit Limit</div></div>
    </div>

    <?php if (b2b_can_manage_finance()): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Record Payment Against an Invoice</h3>
        <?php if ($invoices): ?>
        <form method="post" class="crm-panel-grid">
            <input type="hidden" name="action" value="record_payment">
            <div class="crm-panel-item">
                <label>Invoice</label>
                <select name="invoice_id" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                    <?php foreach ($invoices as $inv): ?><option value="<?php echo (int) $inv['id']; ?>"><?php echo htmlspecialchars($inv['invoice_number'] . ' — ₹' . number_format((float) $inv['total'], 2) . ' (' . $inv['status'] . ')'); ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="crm-panel-item"><label>Amount (₹)</label><input type="number" name="amount" step="0.01" min="0.01" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item">
                <label>Method</label>
                <select name="method" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                    <?php foreach (CRM_PAYMENT_METHODS as $m): ?><option value="<?php echo htmlspecialchars($m); ?>"><?php echo htmlspecialchars($m); ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="crm-panel-item"><label>Transaction ID</label><input type="text" name="transaction_id" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item"><label>Payment Date</label><input type="date" name="payment_date" value="<?php echo gmdate('Y-m-d'); ?>" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item full"><label>Remarks</label><input type="text" name="remarks" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item full"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Record Payment</button></div>
        </form>
        <?php else: ?>
        <p class="crm-empty">Generate an invoice first before recording a payment.</p>
        <?php endif; ?>
    </div>

    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Wallet &amp; Credit</h3>
        <form method="post" style="display:flex;gap:10px;align-items:flex-end;margin-bottom:16px;flex-wrap:wrap;">
            <input type="hidden" name="action" value="wallet_transaction">
            <div><label style="display:block;font-size:11px;color:var(--c-muted);margin-bottom:3px;">Type</label>
                <select name="type" style="border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                    <option value="Credit Added">Credit Added</option>
                    <option value="Debit">Debit</option>
                    <option value="Adjustment">Adjustment</option>
                </select>
            </div>
            <div><label style="display:block;font-size:11px;color:var(--c-muted);margin-bottom:3px;">Amount (₹)</label><input type="number" name="amount" step="0.01" min="0.01" required style="border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;width:130px;"></div>
            <div style="flex:1;min-width:180px;"><label style="display:block;font-size:11px;color:var(--c-muted);margin-bottom:3px;">Reason</label><input type="text" name="reason" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Apply</button>
        </form>
        <form method="post" style="display:flex;gap:10px;align-items:flex-end;">
            <input type="hidden" name="action" value="update_credit_limit">
            <div><label style="display:block;font-size:11px;color:var(--c-muted);margin-bottom:3px;">Credit Limit (₹)</label><input type="number" name="credit_limit" step="0.01" min="0" value="<?php echo (float) $partner['credit_limit']; ?>" style="border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;width:160px;"></div>
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Update Limit</button>
        </form>
    </div>
    <?php endif; ?>

    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Invoice Payments</h3>
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Invoice</th><th>Amount</th><th>Method</th><th>Date</th><th>Recorded By</th></tr></thead>
            <tbody>
            <?php foreach ($invoicePayments as $p): ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars($p['invoice_number']); ?></td>
                <td>₹<?php echo number_format((float) $p['amount'], 2); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($p['method'] ?: '—'); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $p['payment_date'], 0, 10)); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($p['recorded_by'] ?: '—'); ?></td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$invoicePayments): ?>
            <tr><td colspan="5" class="crm-empty">No payments recorded yet.</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
    </div>

    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Wallet Ledger</h3>
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Reference</th><th>Type</th><th>Amount</th><th>Balance After</th><th>Reason</th><th>Date</th></tr></thead>
            <tbody>
            <?php foreach ($walletTransactions as $w): ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars($w['transaction_ref']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($w['type']); ?></td>
                <td>₹<?php echo number_format((float) $w['amount'], 2); ?></td>
                <td class="crm-cell-sub">₹<?php echo number_format((float) $w['balance_after'], 2); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($w['reason'] ?: '—'); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($w['created_at'], 0, 10)); ?></td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$walletTransactions): ?>
            <tr><td colspan="6" class="crm-empty">No wallet activity yet.</td></tr>
            <?php endif; ?>
            </tbody>
        </table>
        </div>
    </div>

<?php elseif ($tab === 'communications'): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Messages with <?php echo htmlspecialchars($partner['company_name']); ?></h3>
        <div class="crm-chat-thread">
            <?php foreach ($partnerMessages as $m): ?>
            <div class="crm-chat-bubble <?php echo $m['sender_type'] === 'Staff' ? 'is-staff' : 'is-partner'; ?>">
                <div class="crm-chat-meta"><?php echo htmlspecialchars($m['sender_name']); ?> &middot; <?php echo htmlspecialchars(substr($m['created_at'], 0, 16)); ?></div>
                <div class="crm-chat-body"><?php echo nl2br(htmlspecialchars($m['body'])); ?></div>
            </div>
            <?php endforeach; ?>
            <?php if (!$partnerMessages): ?><p class="crm-empty">No messages yet.</p><?php endif; ?>
        </div>
        <?php if (b2b_can_communicate()): ?>
        <form method="post" class="crm-chat-form">
            <input type="hidden" name="action" value="send_message">
            <textarea name="body" rows="3" placeholder="Write a message to this partner..." required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:9px 12px;font-family:inherit;font-size:13px;"></textarea>
            <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm" style="margin-top:8px;">Send Message</button>
        </form>
        <?php endif; ?>
    </div>

<?php elseif ($tab === 'corrections'): ?>
    <div class="crm-card">
        <h3 style="margin:0 0 6px;font-size:14px;">Correction Requests</h3>
        <p class="crm-cell-sub" style="margin:0 0 14px;">When the partner reports a typo in their company name, contact name, or a document's label, they submit a request here for your review — nothing changes until you approve it. You can also use the "fix typo" links on the Overview and Documents tabs to edit these fields directly yourself, with no approval step.</p>
        <div class="crm-table-wrap">
        <table class="crm-table">
            <thead><tr><th>Field</th><th>Current → Requested</th><th>Reason</th><th>Requested By</th><th>Status</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($correctionRequests as $cr): ?>
            <tr>
                <td class="crm-cell-name"><?php echo htmlspecialchars(B2B_CORRECTION_FIELD_TYPES[$cr['field_type']] ?? $cr['field_type']); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($cr['old_value']); ?> &rarr; <strong><?php echo htmlspecialchars($cr['new_value']); ?></strong></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($cr['reason'] ?: '—'); ?></td>
                <td class="crm-cell-sub"><?php echo htmlspecialchars($cr['requested_by']); ?> &middot; <?php echo htmlspecialchars(substr($cr['requested_at'], 0, 10)); ?></td>
                <td>
                    <span class="crm-status-badge <?php echo $cr['status'] === 'Approved' ? 'status-visa-approved' : ($cr['status'] === 'Rejected' ? 'status-cancelled' : 'status-documents-pending'); ?>"><?php echo htmlspecialchars($cr['status']); ?></span>
                    <?php if ($cr['review_note']): ?><div class="crm-cell-sub">Note: <?php echo htmlspecialchars($cr['review_note']); ?></div><?php endif; ?>
                    <?php if ($cr['reviewed_by']): ?><div class="crm-cell-sub">by <?php echo htmlspecialchars($cr['reviewed_by']); ?> &middot; <?php echo htmlspecialchars(substr((string) $cr['reviewed_at'], 0, 10)); ?></div><?php endif; ?>
                </td>
                <td>
                    <?php if ($cr['status'] === 'Pending' && b2b_can_manage_enrollment()): ?>
                    <details>
                        <summary style="cursor:pointer;font-size:12px;color:var(--c-blue);">Review</summary>
                        <form method="post" style="margin-top:8px;display:flex;flex-direction:column;gap:6px;min-width:180px;">
                            <input type="hidden" name="action" value="review_correction">
                            <input type="hidden" name="request_id" value="<?php echo (int) $cr['id']; ?>">
                            <input type="text" name="review_note" placeholder="Note (optional)..." style="border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;font-size:12px;">
                            <div style="display:flex;gap:6px;">
                                <button type="submit" name="decision" value="Approved" class="crm-btn crm-btn-primary crm-btn-sm">Approve</button>
                                <button type="submit" name="decision" value="Rejected" class="crm-btn crm-btn-ghost crm-btn-sm">Reject</button>
                            </div>
                        </form>
                    </details>
                    <?php endif; ?>
                </td>
            </tr>
            <?php endforeach; ?>
            <?php if (!$correctionRequests): ?>
            <tr><td colspan="6" class="crm-empty">No correction requests from this partner yet.</td></tr>
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
