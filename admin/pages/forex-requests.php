<?php
declare(strict_types=1);

require_permission('forex.requests.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$scoped = current_admin_forex_scoped_to_assigned();
$employees = $pdo->query(
    "SELECT au.id, au.full_name FROM admin_users au
     JOIN roles r ON r.id = au.role_id
     WHERE r.slug IN ('forex-manager', 'forex-executive', 'visa-consultant', 'super-admin') AND au.status = 'active'
     ORDER BY au.full_name"
)->fetchAll();

/** Loads one request + customer, enforcing scoped access. */
function forex_load_request_or_die(int $id, bool $scoped): array
{
    $stmt = db()->prepare(
        'SELECT fr.*, c.first_name, c.last_name, c.email, c.mobile, c.date_of_birth, c.address, c.city, c.state, c.pincode,
                c.nationality, c.passport_number_encrypted, c.passport_issue_date, c.passport_expiry_date, c.pan_number_encrypted,
                assignee.full_name AS assigned_name
         FROM forex_requests fr
         JOIN customers c ON c.id = fr.customer_id
         LEFT JOIN admin_users assignee ON assignee.id = fr.assigned_employee
         WHERE fr.id = :id AND fr.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $request = $stmt->fetch();
    if (!$request) {
        flash_set('admin_error', 'Forex request not found.');
        redirect('/admin/forex-requests/');
    }
    if ($scoped && (int) ($request['assigned_employee'] ?? 0) !== current_admin_id()) {
        http_response_code(403);
        exit('This forex request is not assigned to you.');
    }
    return $request;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create') {
        require_permission('forex.requests.manage');
        $existingCustomerId = (int) ($_POST['existing_customer_id'] ?? 0);

        if ($existingCustomerId) {
            $customerId = $existingCustomerId;
        } else {
            $panPlain = trim((string) ($_POST['pan_number'] ?? ''));
            $passportPlain = trim((string) ($_POST['passport_number'] ?? ''));
            $data = [
                'first_name' => trim((string) ($_POST['first_name'] ?? '')),
                'last_name' => trim((string) ($_POST['last_name'] ?? '')) ?: null,
                'date_of_birth' => ($_POST['date_of_birth'] ?? '') !== '' ? $_POST['date_of_birth'] : null,
                'nationality' => trim((string) ($_POST['nationality'] ?? '')) ?: null,
                'passport_number_encrypted' => $passportPlain !== '' ? encrypt_value($passportPlain) : null,
                'passport_number_hash' => $passportPlain !== '' ? searchable_hash($passportPlain) : null,
                'passport_issue_date' => ($_POST['passport_issue_date'] ?? '') !== '' ? $_POST['passport_issue_date'] : null,
                'passport_expiry_date' => ($_POST['passport_expiry_date'] ?? '') !== '' ? $_POST['passport_expiry_date'] : null,
                'pan_number_encrypted' => $panPlain !== '' ? encrypt_value($panPlain) : null,
                'pan_number_hash' => $panPlain !== '' ? searchable_hash($panPlain) : null,
                'email' => trim((string) ($_POST['email'] ?? '')) ?: null,
                'mobile' => trim((string) ($_POST['mobile'] ?? '')) ?: null,
                'address' => trim((string) ($_POST['address'] ?? '')) ?: null,
                'city' => trim((string) ($_POST['city'] ?? '')) ?: null,
                'state' => trim((string) ($_POST['state'] ?? '')) ?: null,
                'pincode' => trim((string) ($_POST['pincode'] ?? '')) ?: null,
                'customer_source' => 'Forex Request',
                'status' => 'active',
            ];
            if ($data['first_name'] === '') {
                flash_set('admin_error', 'Customer full name is required.');
                redirect('/admin/forex-requests/?action=create');
            }
            $data['customer_reference_no'] = generate_reference_number('CUST', 'customers', 'customer_reference_no');
            $cols = implode(', ', array_keys($data));
            $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
            $pdo->prepare("INSERT INTO customers ($cols) VALUES ($placeholders)")->execute($data);
            $customerId = (int) $pdo->lastInsertId();
            log_action('create', 'customers', $customerId, null, 'Auto-created from forex request');
        }

        $country = trim((string) ($_POST['country_of_visit'] ?? ''));
        $currency = strtoupper(trim((string) ($_POST['currency_code'] ?? '')));
        $amount = (float) ($_POST['amount_required'] ?? 0);
        if ($country === '' || $currency === '' || $amount <= 0) {
            flash_set('admin_error', 'Country of visit, currency, and amount required are mandatory.');
            redirect('/admin/forex-requests/?action=create');
        }

        for ($attempt = 0; $attempt < 2; $attempt++) {
            $ref = generate_reference_number('FX', 'forex_requests', 'forex_reference_no');
            try {
                $stmt = $pdo->prepare(
                    'INSERT INTO forex_requests (
                        forex_reference_no, customer_id, country_of_visit, cities_to_visit, purpose_of_travel,
                        departure_date, return_date, duration_of_stay, airline, flight_number, hotel_name, hotel_location,
                        traveller_type, visa_status, currency_code, amount_required, approx_inr_requirement,
                        preferred_collection_date, preferred_collection_location, delivery_method,
                        assigned_employee, created_by
                    ) VALUES (
                        :ref, :customer_id, :country, :cities, :purpose,
                        :departure, :return_date, :duration, :airline, :flight, :hotel_name, :hotel_location,
                        :traveller_type, :visa_status, :currency, :amount, :approx_inr,
                        :collection_date, :collection_location, :delivery_method,
                        :assigned, :created_by
                    )'
                );
                $stmt->execute([
                    'ref' => $ref, 'customer_id' => $customerId, 'country' => $country,
                    'cities' => trim((string) ($_POST['cities_to_visit'] ?? '')) ?: null,
                    'purpose' => in_array($_POST['purpose_of_travel'] ?? '', ['tourism', 'business', 'medical', 'education', 'employment', 'conference', 'family_visit', 'pilgrimage', 'sports', 'other'], true) ? $_POST['purpose_of_travel'] : 'tourism',
                    'departure' => ($_POST['departure_date'] ?? '') !== '' ? $_POST['departure_date'] : null,
                    'return_date' => ($_POST['return_date'] ?? '') !== '' ? $_POST['return_date'] : null,
                    'duration' => trim((string) ($_POST['duration_of_stay'] ?? '')) ?: null,
                    'airline' => trim((string) ($_POST['airline'] ?? '')) ?: null,
                    'flight' => trim((string) ($_POST['flight_number'] ?? '')) ?: null,
                    'hotel_name' => trim((string) ($_POST['hotel_name'] ?? '')) ?: null,
                    'hotel_location' => trim((string) ($_POST['hotel_location'] ?? '')) ?: null,
                    'traveller_type' => in_array($_POST['traveller_type'] ?? '', ['individual', 'family', 'corporate', 'student', 'other'], true) ? $_POST['traveller_type'] : 'individual',
                    'visa_status' => in_array($_POST['visa_status'] ?? '', ['visa_available', 'visa_not_available', 'visa_on_arrival', 'visa_free', 'evisa', 'in_process', 'other'], true) ? $_POST['visa_status'] : 'visa_available',
                    'currency' => $currency, 'amount' => $amount,
                    'approx_inr' => ($_POST['approx_inr_requirement'] ?? '') !== '' ? (float) $_POST['approx_inr_requirement'] : null,
                    'collection_date' => ($_POST['preferred_collection_date'] ?? '') !== '' ? $_POST['preferred_collection_date'] : null,
                    'collection_location' => trim((string) ($_POST['preferred_collection_location'] ?? '')) ?: null,
                    'delivery_method' => in_array($_POST['delivery_method'] ?? '', ['branch_pickup', 'home_delivery', 'courier', 'other'], true) ? $_POST['delivery_method'] : 'branch_pickup',
                    'assigned' => (int) ($_POST['assigned_employee'] ?? 0) ?: current_admin_id(),
                    'created_by' => current_admin_id(),
                ]);
                break;
            } catch (PDOException $e) {
                if ($e->getCode() === '23000' && $attempt === 0) {
                    continue;
                }
                throw $e;
            }
        }
        $newId = (int) $pdo->lastInsertId();
        forex_record_status_change($newId, null, 'new_request', 'Forex request created.');
        log_action('create', 'forex_requests', $newId, null, $ref);
        flash_set('admin_notice', "Forex request created ({$ref}).");
        redirect("/admin/forex-requests/?action=view&id=$newId");
    }

    // Every other POST action requires an existing, accessible request.
    if ($id) {
        forex_load_request_or_die($id, $scoped);
    }

    if ($postAction === 'update_status') {
        require_permission('forex.requests.manage');
        $before = $pdo->prepare('SELECT status FROM forex_requests WHERE id = :id');
        $before->execute(['id' => $id]);
        $prevStatus = $before->fetchColumn();
        $newStatus = $_POST['status'] ?? '';
        if (array_key_exists($newStatus, forex_status_labels())) {
            $pdo->prepare('UPDATE forex_requests SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $id]);
            forex_record_status_change($id, (string) $prevStatus, $newStatus, trim((string) ($_POST['remarks'] ?? '')) ?: null);
            flash_set('admin_notice', 'Status updated.');
        }
        redirect('/admin/forex-requests/?action=view&id=' . $id);
    }

    if ($postAction === 'assign') {
        require_permission('forex.requests.manage');
        $newAssignee = (int) ($_POST['assigned_employee'] ?? 0) ?: null;
        $pdo->prepare('UPDATE forex_requests SET assigned_employee = :assigned WHERE id = :id')->execute(['assigned' => $newAssignee, 'id' => $id]);
        log_action('assignment', 'forex_requests', $id, null, (string) $newAssignee);
        flash_set('admin_notice', 'Request reassigned.');
        redirect('/admin/forex-requests/?action=view&id=' . $id);
    }

    if ($postAction === 'upload_document') {
        require_permission('forex.documents.upload');
        $docType = $_POST['document_type'] ?? '';
        if (!array_key_exists($docType, FOREX_DOCUMENT_TYPE_LABELS)) {
            flash_set('admin_error', 'Invalid document type.');
            redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=documents');
        }
        $error = validate_document_upload($_FILES['document'] ?? []);
        if ($error) {
            flash_set('admin_error', $error);
        } else {
            $refStmt = $pdo->prepare('SELECT forex_reference_no FROM forex_requests WHERE id = :id');
            $refStmt->execute(['id' => $id]);
            $ref = (string) $refStmt->fetchColumn();
            $docId = store_forex_document_upload($_FILES['document'], $docType, $id, $ref, (int) current_admin_id());
            log_action('document_upload', 'forex_documents', $docId, null, $docType);

            if ($docType === 'declaration') {
                $pdo->prepare(
                    'INSERT INTO forex_declarations (forex_request_id, document_id, customer_name, destination_country, declaration_date)
                     VALUES (:req_id, :doc_id, :name, :country, :date)'
                )->execute([
                    'req_id' => $id, 'doc_id' => $docId,
                    'name' => trim((string) ($_POST['declaration_customer_name'] ?? '')),
                    'country' => trim((string) ($_POST['declaration_country'] ?? '')),
                    'date' => ($_POST['declaration_date'] ?? '') !== '' ? $_POST['declaration_date'] : date('Y-m-d'),
                ]);
            }
            flash_set('admin_notice', FOREX_DOCUMENT_TYPE_LABELS[$docType] . ' uploaded.');
        }
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=documents');
    }

    if ($postAction === 'verify_document') {
        require_permission('forex.documents.verify');
        $docId = (int) ($_POST['document_id'] ?? 0);
        $verifyStatus = $_POST['verify_status'] ?? '';
        if ($docId && in_array($verifyStatus, ['verified', 'rejected', 'not_applicable'], true)) {
            $remarks = trim((string) ($_POST['verification_remarks'] ?? ''));
            $rejectionReason = $verifyStatus === 'rejected' ? trim((string) ($_POST['rejection_reason'] ?? '')) : null;
            $pdo->prepare(
                'UPDATE forex_documents SET verification_status = :status, verification_remarks = :remarks,
                 rejection_reason = :reason, verified_by = :admin, verified_at = NOW() WHERE id = :id'
            )->execute(['status' => $verifyStatus, 'remarks' => $remarks ?: null, 'reason' => $rejectionReason, 'admin' => current_admin_id(), 'id' => $docId]);

            $docTypeStmt = $pdo->prepare('SELECT document_type FROM forex_documents WHERE id = :id');
            $docTypeStmt->execute(['id' => $docId]);
            $docType = $docTypeStmt->fetchColumn();
            if ($docType === 'declaration' && $verifyStatus === 'verified') {
                $pdo->prepare('UPDATE forex_declarations SET verified_by = :admin, verified_at = NOW() WHERE document_id = :doc_id')
                    ->execute(['admin' => current_admin_id(), 'doc_id' => $docId]);
            }
            log_action('document_verification', 'forex_documents', $docId, null, $verifyStatus);
            flash_set('admin_notice', 'Document ' . $verifyStatus . '.' . ($verifyStatus === 'rejected' ? ' Customer notification: document rejected — please upload a corrected document.' : ''));
        }
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=documents');
    }

    if ($postAction === 'create_quotation') {
        require_permission('forex.quotations.create');
        $currencyAmount = (float) ($_POST['currency_amount'] ?? 0);
        $rate = (float) ($_POST['exchange_rate'] ?? 0);
        $serviceCharge = (float) ($_POST['service_charge'] ?? 0);
        $commission = (float) ($_POST['commission_markup'] ?? 0);
        $gst = (float) ($_POST['gst_amount'] ?? 0);
        $otherCharges = (float) ($_POST['other_charges'] ?? 0);
        $baseAmount = round($currencyAmount * $rate, 2);
        $totalAmount = round($baseAmount + $serviceCharge + $commission + $gst + $otherCharges, 2);

        if ($currencyAmount <= 0 || $rate <= 0) {
            flash_set('admin_error', 'Currency amount and exchange rate must be greater than zero.');
            redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=quotation');
        }

        $pdo->prepare("UPDATE forex_quotations SET status = 'superseded' WHERE forex_request_id = :id AND status IN ('draft', 'sent')")
            ->execute(['id' => $id]);

        $currencyStmt = $pdo->prepare('SELECT currency_code FROM forex_requests WHERE id = :id');
        $currencyStmt->execute(['id' => $id]);
        $stmt = $pdo->prepare(
            'INSERT INTO forex_quotations (
                forex_request_id, currency_code, currency_amount, exchange_rate, rate_type,
                base_inr_amount, service_charge, commission_markup, gst_amount, other_charges,
                total_inr_amount, payment_terms, quotation_expiry, status, created_by
            ) VALUES (
                :req_id, :currency, :amount, :rate, :rate_type,
                :base, :service, :commission, :gst, :other,
                :total, :terms, :expiry, :status, :created_by
            )'
        );
        $stmt->execute([
            'req_id' => $id, 'currency' => $currencyStmt->fetchColumn(), 'amount' => $currencyAmount, 'rate' => $rate,
            'status' => 'sent',
            'rate_type' => in_array($_POST['rate_type'] ?? '', ['indicative', 'quoted', 'locked'], true) ? $_POST['rate_type'] : 'indicative',
            'base' => $baseAmount, 'service' => $serviceCharge, 'commission' => $commission, 'gst' => $gst, 'other' => $otherCharges,
            'total' => $totalAmount, 'terms' => trim((string) ($_POST['payment_terms'] ?? '')) ?: null,
            'expiry' => ($_POST['quotation_expiry'] ?? '') !== '' ? $_POST['quotation_expiry'] : null,
            'created_by' => current_admin_id(),
        ]);
        $quotationId = (int) $pdo->lastInsertId();
        log_action('create', 'forex_quotations', $quotationId, null, "INR $totalAmount");
        forex_record_status_change($id, null, 'quotation_sent', 'Quotation prepared.');
        $pdo->prepare("UPDATE forex_requests SET status = 'quotation_sent' WHERE id = :id")->execute(['id' => $id]);
        flash_set('admin_notice', 'Quotation created — rate and charges are locked to this quotation permanently.');
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=quotation');
    }

    if ($postAction === 'approve_quotation') {
        require_permission('forex.quotations.approve');
        $quotationId = (int) ($_POST['quotation_id'] ?? 0);
        $decision = $_POST['decision'] ?? '';
        if ($quotationId && in_array($decision, ['approved', 'rejected'], true)) {
            $pdo->prepare(
                'INSERT INTO forex_approvals (forex_request_id, quotation_id, approver_id, action, remarks, ip_address)
                 VALUES (:req_id, :quotation_id, :approver, :action, :remarks, :ip)'
            )->execute([
                'req_id' => $id, 'quotation_id' => $quotationId, 'approver' => current_admin_id(),
                'action' => $decision, 'remarks' => trim((string) ($_POST['remarks'] ?? '')) ?: null,
                'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
            ]);
            if ($decision === 'approved') {
                $pdo->prepare("UPDATE forex_quotations SET status = 'accepted' WHERE id = :id")->execute(['id' => $quotationId]);
                forex_record_status_change($id, null, 'approved_for_processing', 'Quotation approved.');
                $pdo->prepare("UPDATE forex_requests SET status = 'approved_for_processing' WHERE id = :id")->execute(['id' => $id]);
            }
            log_action($decision === 'approved' ? 'quotation_approved' : 'quotation_rejected', 'forex_requests', $id);
            flash_set('admin_notice', 'Quotation ' . $decision . '.');
        }
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=quotation');
    }

    if ($postAction === 'save_payment') {
        require_permission('forex.payments.manage');
        $pdo->prepare(
            'INSERT INTO forex_payments (forex_request_id, status, payment_method, transaction_id, amount_paid, payment_date, payment_reference, remarks, recorded_by)
             VALUES (:req_id, :status, :method, :txn, :amount, :date, :reference, :remarks, :recorded_by)'
        )->execute([
            'req_id' => $id,
            'status' => in_array($_POST['status'] ?? '', ['pending', 'partially_paid', 'paid', 'refunded', 'cancelled'], true) ? $_POST['status'] : 'pending',
            'method' => trim((string) ($_POST['payment_method'] ?? '')) ?: null,
            'txn' => trim((string) ($_POST['transaction_id'] ?? '')) ?: null,
            'amount' => ($_POST['amount_paid'] ?? '') !== '' ? (float) $_POST['amount_paid'] : null,
            'date' => ($_POST['payment_date'] ?? '') !== '' ? $_POST['payment_date'] : null,
            'reference' => trim((string) ($_POST['payment_reference'] ?? '')) ?: null,
            'remarks' => trim((string) ($_POST['remarks'] ?? '')) ?: null,
            'recorded_by' => current_admin_id(),
        ]);
        log_action('payment_update', 'forex_payments', $id, null, $_POST['status'] ?? '');
        if (($_POST['status'] ?? '') === 'paid') {
            forex_record_status_change($id, null, 'payment_received', 'Payment recorded as received in full.');
            $pdo->prepare("UPDATE forex_requests SET status = 'payment_received' WHERE id = :id")->execute(['id' => $id]);
        }
        flash_set('admin_notice', 'Payment status updated.');
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=payment');
    }

    if ($postAction === 'mark_delivered') {
        require_permission('forex.delivery.manage');
        $blockers = forex_delivery_blockers($id);
        $overrideRequested = isset($_POST['override']) && $_POST['override'] === '1';

        if ($blockers && !$overrideRequested) {
            flash_set('admin_error', 'Delivery blocked. Mandatory compliance requirements have not been completed: ' . implode(' ', $blockers));
            redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=delivery');
        }

        if ($blockers && $overrideRequested) {
            require_permission('forex.delivery.override');
            $overrideReason = trim((string) ($_POST['override_reason'] ?? ''));
            if ($overrideReason === '') {
                flash_set('admin_error', 'An override reason is required and is permanently recorded.');
                redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=delivery');
            }
            $pdo->prepare(
                'INSERT INTO forex_approvals (forex_request_id, approver_id, action, previous_value, remarks, ip_address)
                 VALUES (:req_id, :approver, :action, :previous, :remarks, :ip)'
            )->execute([
                'req_id' => $id, 'approver' => current_admin_id(), 'action' => 'delivery_override',
                'previous' => implode(' | ', $blockers), 'remarks' => $overrideReason,
                'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
            ]);
            log_action('delivery_override', 'forex_requests', $id, implode(' | ', $blockers), $overrideReason);
        }

        $amountStmt = $pdo->prepare('SELECT currency_code, amount_required FROM forex_requests WHERE id = :id');
        $amountStmt->execute(['id' => $id]);
        $reqRow = $amountStmt->fetch();

        $pdo->prepare(
            'INSERT INTO forex_deliveries (forex_request_id, delivered_at, delivered_by, received_by, currency_code, amount_delivered, customer_acknowledged, delivery_remarks)
             VALUES (:req_id, NOW(), :delivered_by, :received_by, :currency, :amount, :acknowledged, :remarks)'
        )->execute([
            'req_id' => $id, 'delivered_by' => current_admin_id(),
            'received_by' => trim((string) ($_POST['received_by'] ?? '')) ?: 'Customer',
            'currency' => $reqRow['currency_code'], 'amount' => $reqRow['amount_required'],
            'acknowledged' => isset($_POST['customer_acknowledged']) ? 1 : 0,
            'remarks' => trim((string) ($_POST['delivery_remarks'] ?? '')) ?: null,
        ]);
        forex_record_status_change($id, null, 'delivered', $overrideRequested ? 'Delivered via authorized compliance override.' : 'Delivered — all compliance checks passed.');
        $pdo->prepare("UPDATE forex_requests SET status = 'delivered' WHERE id = :id")->execute(['id' => $id]);
        log_action('delivery_completed', 'forex_requests', $id);
        flash_set('admin_notice', 'Forex marked as delivered.');
        redirect('/admin/forex-requests/?action=view&id=' . $id . '&tab=delivery');
    }

    if ($postAction === 'delete') {
        require_permission('forex.requests.manage');
        $statusStmt = $pdo->prepare('SELECT status FROM forex_requests WHERE id = :id');
        $statusStmt->execute(['id' => $id]);
        if ($statusStmt->fetchColumn() === 'delivered') {
            flash_set('admin_error', 'Completed (delivered) forex transactions cannot be deleted.');
            redirect('/admin/forex-requests/?action=view&id=' . $id);
        }
        $pdo->prepare('UPDATE forex_requests SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'forex_requests', $id);
        flash_set('admin_notice', 'Forex request removed (soft delete).');
        redirect('/admin/forex-requests/');
    }
}

// ---------------------------------------------------------------
// Create form
// ---------------------------------------------------------------
if ($action === 'create') {
    require_permission('forex.requests.manage');
    admin_header_start('New Forex Request', 'forex');
    ?>
    <div class="admin-form-card" style="max-width:900px">
        <form method="post" action="/admin/forex-requests/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="create">

            <div class="card" style="margin-bottom:var(--space-6)">
                <div class="card-title">Customer</div>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Search an existing customer by name, email, mobile, or passport number — or leave blank to create a new one below.</p>
                <div class="form-group"><label class="form-label" for="existing_customer_id">Existing Customer ID (leave 0 to create new)</label><input class="form-input" type="number" id="existing_customer_id" name="existing_customer_id" value="0" min="0"></div>
                <p style="font-size:var(--font-size-sm)"><a href="/admin/customers/" target="_blank" rel="noopener">Search customers in a new tab &rarr;</a> (copy the ID into the field above)</p>
                <div class="admin-form-grid">
                    <div class="form-group"><label class="form-label" for="first_name">Full Name</label><input class="form-input" type="text" id="first_name" name="first_name"></div>
                    <div class="form-group"><label class="form-label" for="last_name">Last Name</label><input class="form-input" type="text" id="last_name" name="last_name"></div>
                    <div class="form-group"><label class="form-label" for="date_of_birth">Date of Birth</label><input class="form-input" type="date" id="date_of_birth" name="date_of_birth"></div>
                    <div class="form-group"><label class="form-label" for="mobile">Mobile Number</label><input class="form-input" type="text" id="mobile" name="mobile"></div>
                    <div class="form-group"><label class="form-label" for="email">Email Address</label><input class="form-input" type="email" id="email" name="email"></div>
                    <div class="form-group"><label class="form-label" for="nationality">Nationality</label><input class="form-input" type="text" id="nationality" name="nationality"></div>
                    <div class="form-group"><label class="form-label" for="pan_number">PAN Number</label><input class="form-input" type="text" id="pan_number" name="pan_number" autocomplete="off"></div>
                    <div class="form-group"><label class="form-label" for="passport_number">Passport Number</label><input class="form-input" type="text" id="passport_number" name="passport_number" autocomplete="off"></div>
                    <div class="form-group"><label class="form-label" for="passport_issue_date">Passport Issue Date</label><input class="form-input" type="date" id="passport_issue_date" name="passport_issue_date"></div>
                    <div class="form-group"><label class="form-label" for="passport_expiry_date">Passport Expiry Date</label><input class="form-input" type="date" id="passport_expiry_date" name="passport_expiry_date"></div>
                    <div class="form-group"><label class="form-label" for="city">City</label><input class="form-input" type="text" id="city" name="city"></div>
                    <div class="form-group"><label class="form-label" for="state">State</label><input class="form-input" type="text" id="state" name="state"></div>
                    <div class="form-group"><label class="form-label" for="pincode">PIN Code</label><input class="form-input" type="text" id="pincode" name="pincode"></div>
                </div>
                <div class="form-group"><label class="form-label" for="address">Address</label><textarea class="form-input" id="address" name="address" rows="2"></textarea></div>
            </div>

            <div class="card" style="margin-bottom:var(--space-6)">
                <div class="card-title">Travel Details</div>
                <div class="admin-form-grid">
                    <div class="form-group"><label class="form-label" for="country_of_visit">Country of Visit *</label><input class="form-input" type="text" id="country_of_visit" name="country_of_visit" required></div>
                    <div class="form-group"><label class="form-label" for="cities_to_visit">City/Cities to Visit</label><input class="form-input" type="text" id="cities_to_visit" name="cities_to_visit"></div>
                    <div class="form-group">
                        <label class="form-label" for="purpose_of_travel">Purpose of Travel</label>
                        <select class="form-select" id="purpose_of_travel" name="purpose_of_travel">
                            <?php foreach (['tourism' => 'Tourism', 'business' => 'Business', 'medical' => 'Medical', 'education' => 'Education', 'employment' => 'Employment', 'conference' => 'Conference', 'family_visit' => 'Family Visit', 'pilgrimage' => 'Pilgrimage', 'sports' => 'Sports', 'other' => 'Other'] as $val => $label): ?>
                            <option value="<?= $val ?>"><?= $label ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="traveller_type">Traveller Type</label>
                        <select class="form-select" id="traveller_type" name="traveller_type">
                            <?php foreach (['individual' => 'Individual', 'family' => 'Family', 'corporate' => 'Corporate', 'student' => 'Student', 'other' => 'Other'] as $val => $label): ?>
                            <option value="<?= $val ?>"><?= $label ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group"><label class="form-label" for="departure_date">Departure Date</label><input class="form-input" type="date" id="departure_date" name="departure_date"></div>
                    <div class="form-group"><label class="form-label" for="return_date">Return Date</label><input class="form-input" type="date" id="return_date" name="return_date"></div>
                    <div class="form-group"><label class="form-label" for="duration_of_stay">Duration of Stay</label><input class="form-input" type="text" id="duration_of_stay" name="duration_of_stay"></div>
                    <div class="form-group"><label class="form-label" for="airline">Airline</label><input class="form-input" type="text" id="airline" name="airline"></div>
                    <div class="form-group"><label class="form-label" for="flight_number">Flight Number</label><input class="form-input" type="text" id="flight_number" name="flight_number"></div>
                    <div class="form-group"><label class="form-label" for="hotel_name">Hotel Name</label><input class="form-input" type="text" id="hotel_name" name="hotel_name"></div>
                    <div class="form-group"><label class="form-label" for="hotel_location">Hotel Location</label><input class="form-input" type="text" id="hotel_location" name="hotel_location"></div>
                </div>
            </div>

            <div class="card" style="margin-bottom:var(--space-6)">
                <div class="card-title">Visa Status</div>
                <div class="form-group">
                    <select class="form-select" name="visa_status">
                        <option value="visa_available">Visa Available</option>
                        <option value="visa_not_available">Visa Not Available</option>
                        <option value="visa_on_arrival">Visa on Arrival</option>
                        <option value="visa_free">Visa-Free / No Visa Required</option>
                        <option value="evisa">eVisa</option>
                        <option value="in_process">Visa Application in Process</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <p style="color:var(--warning);font-size:var(--font-size-sm)">Forex delivery cannot be completed until the required visa documentation is verified, unless the destination is confirmed as Visa on Arrival / Visa-Free / otherwise eligible under applicable rules.</p>
            </div>

            <div class="card" style="margin-bottom:var(--space-6)">
                <div class="card-title">Forex Requirement</div>
                <div class="admin-form-grid">
                    <div class="form-group">
                        <label class="form-label" for="currency_code">Currency Required *</label>
                        <select class="form-select" id="currency_code" name="currency_code" required>
                            <?php foreach (FOREX_CURRENCY_OPTIONS as $code => $name): ?>
                            <option value="<?= $code ?>"><?= $code ?> — <?= e($name) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group"><label class="form-label" for="amount_required">Amount Required *</label><input class="form-input" type="number" step="0.01" id="amount_required" name="amount_required" required></div>
                    <div class="form-group"><label class="form-label" for="approx_inr_requirement">Approximate INR Requirement</label><input class="form-input" type="number" step="0.01" id="approx_inr_requirement" name="approx_inr_requirement"></div>
                    <div class="form-group"><label class="form-label" for="preferred_collection_date">Preferred Delivery/Collection Date</label><input class="form-input" type="date" id="preferred_collection_date" name="preferred_collection_date"></div>
                    <div class="form-group"><label class="form-label" for="preferred_collection_location">Preferred Collection Location</label><input class="form-input" type="text" id="preferred_collection_location" name="preferred_collection_location"></div>
                    <div class="form-group">
                        <label class="form-label" for="delivery_method">Delivery Method</label>
                        <select class="form-select" id="delivery_method" name="delivery_method">
                            <option value="branch_pickup">Branch Pickup</option>
                            <option value="home_delivery">Home Delivery</option>
                            <option value="courier">Courier</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="assigned_employee">Assign To</label>
                        <select class="form-select" id="assigned_employee" name="assigned_employee">
                            <option value="">— Me —</option>
                            <?php foreach ($employees as $emp): ?>
                            <option value="<?= (int) $emp['id'] ?>"><?= e($emp['full_name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary">Create Forex Request</button>
            <a href="/admin/forex-requests/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// ---------------------------------------------------------------
// Detail view
// ---------------------------------------------------------------
if ($action === 'view' && $id) {
    $request = forex_load_request_or_die($id, $scoped);
    $tab = in_array($_GET['tab'] ?? '', ['overview', 'documents', 'quotation', 'compliance', 'payment', 'delivery', 'activity'], true) ? $_GET['tab'] : 'overview';

    $completion = forex_document_completion($id);
    $blockers = forex_delivery_blockers($id);

    $docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = :id AND is_current = 1 ORDER BY document_type');
    $docsStmt->execute(['id' => $id]);
    $documents = $docsStmt->fetchAll();

    $historyDocsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = :id AND is_current = 0 ORDER BY uploaded_at DESC');
    $historyDocsStmt->execute(['id' => $id]);
    $documentHistory = $historyDocsStmt->fetchAll();

    $declStmt = $pdo->prepare('SELECT d.*, doc.verification_status AS doc_status FROM forex_declarations d LEFT JOIN forex_documents doc ON doc.id = d.document_id WHERE d.forex_request_id = :id ORDER BY d.id DESC LIMIT 1');
    $declStmt->execute(['id' => $id]);
    $declaration = $declStmt->fetch();

    $quotationsStmt = $pdo->prepare('SELECT q.*, u.full_name AS created_by_name FROM forex_quotations q LEFT JOIN admin_users u ON u.id = q.created_by WHERE forex_request_id = :id ORDER BY q.id DESC');
    $quotationsStmt->execute(['id' => $id]);
    $quotations = $quotationsStmt->fetchAll();
    $currentQuotation = $quotations[0] ?? null;

    $approvalsStmt = $pdo->prepare('SELECT a.*, u.full_name AS approver_name FROM forex_approvals a LEFT JOIN admin_users u ON u.id = a.approver_id WHERE forex_request_id = :id ORDER BY a.id DESC');
    $approvalsStmt->execute(['id' => $id]);
    $approvals = $approvalsStmt->fetchAll();

    $paymentsStmt = $pdo->prepare('SELECT p.*, u.full_name AS recorded_by_name FROM forex_payments p LEFT JOIN admin_users u ON u.id = p.recorded_by WHERE forex_request_id = :id ORDER BY p.id DESC');
    $paymentsStmt->execute(['id' => $id]);
    $payments = $paymentsStmt->fetchAll();
    $latestPayment = $payments[0] ?? null;

    $deliveryStmt = $pdo->prepare('SELECT d.*, u.full_name AS delivered_by_name FROM forex_deliveries d LEFT JOIN admin_users u ON u.id = d.delivered_by WHERE forex_request_id = :id ORDER BY d.id DESC LIMIT 1');
    $deliveryStmt->execute(['id' => $id]);
    $delivery = $deliveryStmt->fetch();

    $historyStmt = $pdo->prepare('SELECT h.*, u.full_name AS changed_by_name FROM forex_status_history h LEFT JOIN admin_users u ON u.id = h.changed_by WHERE forex_request_id = :id ORDER BY h.created_at DESC');
    $historyStmt->execute(['id' => $id]);
    $statusHistory = $historyStmt->fetchAll();

    $auditStmt = $pdo->prepare("SELECT al.*, u.full_name AS admin_name FROM audit_logs al LEFT JOIN admin_users u ON u.id = al.admin_user_id WHERE al.module IN ('forex_requests','forex_documents','forex_quotations','forex_payments') AND (al.record_id = :id OR al.module != 'forex_requests') ORDER BY al.created_at DESC LIMIT 100");
    // Refine: only entries actually tied to this request's own id when module=forex_requests; other modules logged with their own record ids aren't filterable here without a join, so we scope to forex_requests module only for accuracy.
    $auditStmt = $pdo->prepare("SELECT al.*, u.full_name AS admin_name FROM audit_logs al LEFT JOIN admin_users u ON u.id = al.admin_user_id WHERE al.module = 'forex_requests' AND al.record_id = :id ORDER BY al.created_at DESC");
    $auditStmt->execute(['id' => $id]);
    $auditEntries = $auditStmt->fetchAll();

    admin_header_start($request['forex_reference_no'], 'forex');
    ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="admin-toolbar" style="margin-bottom:0;align-items:flex-start">
            <div>
                <h2 style="margin:0 0 var(--space-1)">Forex Request: <?= e($request['forex_reference_no']) ?></h2>
                <p style="margin:0;color:var(--text-muted)"><?= e(trim($request['first_name'] . ' ' . ($request['last_name'] ?? ''))) ?> &middot; <?= e($request['email'] ?? $request['mobile'] ?? '') ?></p>
                <p style="margin:var(--space-1) 0 0"><strong><?= e($request['currency_code']) ?> <?= e(number_format((float) $request['amount_required'], 2)) ?></strong> for <?= e($request['country_of_visit']) ?></p>
            </div>
            <div style="text-align:right">
                <span class="badge badge-info" style="font-size:var(--font-size-sm)"><?= e(forex_status_labels()[$request['status']] ?? $request['status']) ?></span>
                <p style="margin-top:var(--space-2);color:var(--text-muted)">Assigned: <?= e($request['assigned_name'] ?? 'Unassigned') ?></p>
            </div>
        </div>
    </div>

    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Document Completion: <?= $completion['verified'] ?>/<?= $completion['total'] ?></div>
        <?php foreach ($completion['items'] as $item): ?>
        <p style="margin:var(--space-1) 0">
            <?= $item['status'] === 'verified' ? '✓' : ($item['status'] === 'rejected' ? '✗' : '⚠') ?>
            <?= e($item['label']) ?> —
            <span class="badge <?= $item['status'] === 'verified' ? 'badge-success' : ($item['status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e(ucwords(str_replace('_', ' ', $item['status']))) ?></span>
        </p>
        <?php endforeach; ?>
        <?php if ($blockers): ?>
        <div class="alert alert-danger" style="margin-top:var(--space-3)">
            <strong>Delivery blocked. Mandatory compliance requirements have not been completed:</strong>
            <ul style="margin:var(--space-2) 0 0 var(--space-5)">
                <?php foreach ($blockers as $b): ?><li><?= e($b) ?></li><?php endforeach; ?>
            </ul>
        </div>
        <?php else: ?>
        <div class="alert alert-success" style="margin-top:var(--space-3)">All mandatory compliance requirements are complete. Ready for delivery.</div>
        <?php endif; ?>
    </div>

    <div class="admin-form-grid" style="margin-bottom:var(--space-5)">
        <div class="card">
            <div class="card-title">Update Status</div>
            <form method="post" action="/admin/forex-requests/">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="update_status">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <div class="form-group">
                    <select class="form-select" name="status">
                        <?php foreach (forex_status_labels() as $val => $label): ?>
                        <option value="<?= $val ?>"<?= $request['status'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><input class="form-input" type="text" name="remarks" placeholder="Remarks (optional)"></div>
                <button type="submit" class="btn btn-primary btn-sm">Update</button>
            </form>
        </div>
        <div class="card">
            <div class="card-title">Assign Employee</div>
            <form method="post" action="/admin/forex-requests/">
                <?= csrf_field() ?>
                <input type="hidden" name="action" value="assign">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <div class="form-group">
                    <select class="form-select" name="assigned_employee">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) $request['assigned_employee'] === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">Reassign</button>
            </form>
        </div>
    </div>

    <nav class="hrms-tabs">
        <?php foreach (['overview' => 'Overview', 'documents' => 'Documents', 'quotation' => 'Quotation', 'compliance' => 'Compliance / Declaration', 'payment' => 'Payment', 'delivery' => 'Delivery', 'activity' => 'Activity Log'] as $key => $label): ?>
        <a href="/admin/forex-requests/?action=view&id=<?= (int) $id ?>&tab=<?= $key ?>" class="<?= $tab === $key ? 'is-active' : '' ?>"><?= $label ?></a>
        <?php endforeach; ?>
    </nav>

    <?php if ($tab === 'overview'): ?>
    <div class="admin-form-grid">
        <div class="card">
            <div class="card-title">Customer</div>
            <p><strong>Name:</strong> <?= e(trim($request['first_name'] . ' ' . ($request['last_name'] ?? ''))) ?></p>
            <p><strong>DOB:</strong> <?= $request['date_of_birth'] ? e(date('d M Y', strtotime((string) $request['date_of_birth']))) : '—' ?></p>
            <p><strong>Mobile:</strong> <?= e($request['mobile'] ?? '—') ?> &middot; <strong>Email:</strong> <?= e($request['email'] ?? '—') ?></p>
            <p><strong>Nationality:</strong> <?= e($request['nationality'] ?? '—') ?></p>
            <p><strong>Passport:</strong> <?= e(decrypt_value($request['passport_number_encrypted']) ?? 'Not on file') ?></p>
            <p><strong>PAN:</strong> <?= e(decrypt_value($request['pan_number_encrypted']) ?? 'Not on file') ?></p>
            <p><strong>Address:</strong> <?= e(trim(($request['address'] ?? '') . ' ' . ($request['city'] ?? '') . ' ' . ($request['state'] ?? '') . ' ' . ($request['pincode'] ?? '')) ?: '—') ?></p>
        </div>
        <div class="card">
            <div class="card-title">Travel Details</div>
            <p><strong>Country:</strong> <?= e($request['country_of_visit']) ?> &middot; <strong>Cities:</strong> <?= e($request['cities_to_visit'] ?? '—') ?></p>
            <p><strong>Purpose:</strong> <?= e(ucwords(str_replace('_', ' ', $request['purpose_of_travel']))) ?> &middot; <strong>Traveller Type:</strong> <?= e(ucfirst($request['traveller_type'])) ?></p>
            <p><strong>Departure:</strong> <?= $request['departure_date'] ? e(date('d M Y', strtotime((string) $request['departure_date']))) : '—' ?> &middot; <strong>Return:</strong> <?= $request['return_date'] ? e(date('d M Y', strtotime((string) $request['return_date']))) : '—' ?></p>
            <p><strong>Airline/Flight:</strong> <?= e($request['airline'] ?? '—') ?> <?= e($request['flight_number'] ?? '') ?></p>
            <p><strong>Hotel:</strong> <?= e($request['hotel_name'] ?? '—') ?> <?= e($request['hotel_location'] ?? '') ?></p>
        </div>
        <div class="card">
            <div class="card-title">Visa Status</div>
            <p><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $request['visa_status']))) ?></span></p>
        </div>
        <div class="card">
            <div class="card-title">Forex Requirement</div>
            <p><strong>Currency:</strong> <?= e($request['currency_code']) ?> <?= e(number_format((float) $request['amount_required'], 2)) ?></p>
            <p><strong>Approx. INR:</strong> <?= $request['approx_inr_requirement'] ? '₹' . e(number_format((float) $request['approx_inr_requirement'], 2)) : '—' ?></p>
            <p><strong>Collection Date:</strong> <?= $request['preferred_collection_date'] ? e(date('d M Y', strtotime((string) $request['preferred_collection_date']))) : '—' ?></p>
            <p><strong>Delivery Method:</strong> <?= e(ucwords(str_replace('_', ' ', $request['delivery_method']))) ?></p>
        </div>
    </div>

    <?php elseif ($tab === 'documents'): ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Upload Document</div>
        <form method="post" action="/admin/forex-requests/" enctype="multipart/form-data">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="upload_document">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label">Document Type</label>
                    <select class="form-select" name="document_type" id="fx_doc_type" onchange="document.getElementById('fx_decl_fields').style.display=this.value==='declaration'?'block':'none'">
                        <?php foreach (FOREX_DOCUMENT_TYPE_LABELS as $val => $label): ?>
                        <option value="<?= $val ?>"><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><label class="form-label">File</label><input class="form-input" type="file" name="document" required></div>
            </div>
            <div id="fx_decl_fields" style="display:none">
                <div class="admin-form-grid">
                    <div class="form-group"><label class="form-label">Declaration: Customer Name</label><input class="form-input" type="text" name="declaration_customer_name" value="<?= e(trim($request['first_name'] . ' ' . ($request['last_name'] ?? ''))) ?>"></div>
                    <div class="form-group"><label class="form-label">Declaration: Destination Country</label><input class="form-input" type="text" name="declaration_country" value="<?= e($request['country_of_visit']) ?>"></div>
                    <div class="form-group"><label class="form-label">Declaration Date (as signed)</label><input class="form-input" type="date" name="declaration_date"></div>
                </div>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Upload the customer's hand-signed declaration. A typed name is not treated as equivalent to a handwritten signature.</p>
            </div>
            <button type="submit" class="btn btn-primary btn-sm">Upload</button>
        </form>
    </div>

    <table class="admin-table" style="margin-bottom:var(--space-5)">
        <thead><tr><th>Type</th><th>File</th><th>Status</th><th>Remarks</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($documents as $doc): ?>
        <tr>
            <td><?= e(FOREX_DOCUMENT_TYPE_LABELS[$doc['document_type']] ?? $doc['document_type']) ?></td>
            <td><a href="/admin/forex-document-download/?id=<?= (int) $doc['id'] ?>"><?= e($doc['original_filename']) ?></a></td>
            <td><span class="badge <?= $doc['verification_status'] === 'verified' ? 'badge-success' : ($doc['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e(ucwords(str_replace('_', ' ', $doc['verification_status']))) ?></span></td>
            <td><?= e($doc['verification_remarks'] ?? $doc['rejection_reason'] ?? '—') ?></td>
            <td class="actions">
                <?php if (has_permission('forex.documents.verify')): ?>
                <form method="post" action="/admin/forex-requests/" style="display:inline-flex;gap:var(--space-1)">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="verify_document">
                    <input type="hidden" name="id" value="<?= (int) $id ?>">
                    <input type="hidden" name="document_id" value="<?= (int) $doc['id'] ?>">
                    <input type="text" name="verification_remarks" placeholder="Remarks" style="width:120px">
                    <button type="submit" name="verify_status" value="verified" class="btn btn-outline btn-sm">Verify</button>
                    <button type="submit" name="verify_status" value="rejected" class="btn btn-outline btn-sm">Reject</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$documents): ?><tr><td colspan="5"><p class="empty-state">No documents uploaded yet.</p></td></tr><?php endif; ?>
        </tbody>
    </table>

    <?php if ($documentHistory): ?>
    <div class="card">
        <div class="card-title">Superseded Document History</div>
        <?php foreach ($documentHistory as $doc): ?>
        <p style="font-size:var(--font-size-sm);color:var(--text-muted)"><?= e(FOREX_DOCUMENT_TYPE_LABELS[$doc['document_type']] ?? $doc['document_type']) ?> — <?= e($doc['original_filename']) ?> (replaced <?= e(date('d M Y', strtotime((string) $doc['deleted_at']))) ?>)</p>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>

    <?php elseif ($tab === 'quotation'): ?>
    <?php if (has_permission('forex.quotations.create')): ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">New Quotation</div>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Every quotation permanently snapshots the rate and charges used — a later change to the master rate table never alters this record.</p>
        <form method="post" action="/admin/forex-requests/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="create_quotation">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label">Currency Amount (<?= e($request['currency_code']) ?>)</label><input class="form-input" type="number" step="0.01" name="currency_amount" value="<?= e((string) $request['amount_required']) ?>" required></div>
                <div class="form-group"><label class="form-label">Exchange Rate (₹ per unit)</label><input class="form-input" type="number" step="0.0001" name="exchange_rate" required></div>
                <div class="form-group">
                    <label class="form-label">Rate Type</label>
                    <select class="form-select" name="rate_type">
                        <option value="indicative">Indicative</option>
                        <option value="quoted">Quoted</option>
                        <option value="locked">Locked / Confirmed</option>
                    </select>
                </div>
                <div class="form-group"><label class="form-label">Service Charge (₹)</label><input class="form-input" type="number" step="0.01" name="service_charge" value="0"></div>
                <div class="form-group"><label class="form-label">Commission/Markup (₹)</label><input class="form-input" type="number" step="0.01" name="commission_markup" value="0"></div>
                <div class="form-group"><label class="form-label">GST (₹)</label><input class="form-input" type="number" step="0.01" name="gst_amount" value="0"></div>
                <div class="form-group"><label class="form-label">Other Charges (₹)</label><input class="form-input" type="number" step="0.01" name="other_charges" value="0"></div>
                <div class="form-group"><label class="form-label">Quotation Expiry</label><input class="form-input" type="datetime-local" name="quotation_expiry"></div>
            </div>
            <div class="form-group"><label class="form-label">Payment Terms</label><textarea class="form-input" name="payment_terms" rows="2"></textarea></div>
            <button type="submit" class="btn btn-primary">Create Quotation</button>
        </form>
    </div>
    <?php endif; ?>

    <?php foreach ($quotations as $q): ?>
    <div class="card" style="margin-bottom:var(--space-4)">
        <div class="admin-toolbar" style="margin-bottom:var(--space-3)">
            <strong>Quotation #<?= (int) $q['id'] ?></strong>
            <span class="badge <?= $q['status'] === 'accepted' ? 'badge-success' : ($q['status'] === 'superseded' ? 'badge-neutral' : 'badge-info') ?>"><?= e(ucfirst($q['status'])) ?></span>
        </div>
        <p><strong>Currency:</strong> <?= e($q['currency_code']) ?> <?= e(number_format((float) $q['currency_amount'], 2)) ?> &middot; <strong>Rate:</strong> ₹<?= e(number_format((float) $q['exchange_rate'], 4)) ?> (<?= e(ucfirst($q['rate_type'])) ?>)</p>
        <p><strong>Base Amount:</strong> ₹<?= e(number_format((float) $q['base_inr_amount'], 2)) ?> &middot; <strong>Service:</strong> ₹<?= e(number_format((float) $q['service_charge'], 2)) ?> &middot; <strong>Commission:</strong> ₹<?= e(number_format((float) $q['commission_markup'], 2)) ?> &middot; <strong>GST:</strong> ₹<?= e(number_format((float) $q['gst_amount'], 2)) ?> &middot; <strong>Other:</strong> ₹<?= e(number_format((float) $q['other_charges'], 2)) ?></p>
        <p><strong>Total Payable: ₹<?= e(number_format((float) $q['total_inr_amount'], 2)) ?></strong></p>
        <p><strong>Valid Until:</strong> <?= $q['quotation_expiry'] ? e(date('d/m/Y H:i', strtotime((string) $q['quotation_expiry']))) : '—' ?> &middot; Created by <?= e($q['created_by_name'] ?? 'System') ?> on <?= e(date('d M Y H:i', strtotime((string) $q['created_at']))) ?></p>
        <?php if ($q['status'] === 'sent' && has_permission('forex.quotations.approve')): ?>
        <form method="post" action="/admin/forex-requests/" style="margin-top:var(--space-3)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="approve_quotation">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <input type="hidden" name="quotation_id" value="<?= (int) $q['id'] ?>">
            <input type="text" name="remarks" placeholder="Approval remarks" style="width:200px">
            <button type="submit" name="decision" value="approved" class="btn btn-primary btn-sm">Approve</button>
            <button type="submit" name="decision" value="rejected" class="btn btn-outline btn-sm">Reject</button>
        </form>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
    <?php if (!$quotations): ?><p class="empty-state">No quotation created yet.</p><?php endif; ?>

    <?php elseif ($tab === 'compliance'): ?>
    <div class="card">
        <div class="card-title">Visa-on-Arrival / Visa-Free Declaration</div>
        <?php if ($declaration): ?>
        <p><strong>Customer Name (on declaration):</strong> <?= e($declaration['customer_name']) ?></p>
        <p><strong>Destination:</strong> <?= e($declaration['destination_country']) ?></p>
        <p><strong>Declaration Date:</strong> <?= e(date('d M Y', strtotime((string) $declaration['declaration_date']))) ?></p>
        <p><strong>Uploaded:</strong> <?= e(date('d M Y H:i', strtotime((string) $declaration['uploaded_at']))) ?></p>
        <p><strong>Document Status:</strong> <span class="badge <?= $declaration['doc_status'] === 'verified' ? 'badge-success' : 'badge-warning' ?>"><?= e(ucfirst((string) $declaration['doc_status'])) ?></span></p>
        <p><strong>Verified:</strong> <?= $declaration['verified_at'] ? e(date('d M Y H:i', strtotime((string) $declaration['verified_at']))) : 'Not yet verified' ?></p>
        <?php else: ?>
        <p class="empty-state">No declaration on file. Upload one from the Documents tab (document type: Visa-on-Arrival/Visa-Free Declaration) if applicable to this request's visa status.</p>
        <?php endif; ?>
    </div>

    <?php elseif ($tab === 'payment'): ?>
    <?php if (has_permission('forex.payments.manage')): ?>
    <div class="card" style="margin-bottom:var(--space-5)">
        <div class="card-title">Record Payment</div>
        <form method="post" action="/admin/forex-requests/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save_payment">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select class="form-select" name="status">
                        <option value="pending">Pending</option>
                        <option value="partially_paid">Partially Paid</option>
                        <option value="paid">Paid</option>
                        <option value="refunded">Refunded</option>
                        <option value="cancelled">Cancelled</option>
                    </select>
                </div>
                <div class="form-group"><label class="form-label">Payment Method</label><input class="form-input" type="text" name="payment_method"></div>
                <div class="form-group"><label class="form-label">Transaction ID</label><input class="form-input" type="text" name="transaction_id"></div>
                <div class="form-group"><label class="form-label">Amount Paid</label><input class="form-input" type="number" step="0.01" name="amount_paid"></div>
                <div class="form-group"><label class="form-label">Payment Date</label><input class="form-input" type="date" name="payment_date"></div>
                <div class="form-group"><label class="form-label">Payment Reference</label><input class="form-input" type="text" name="payment_reference"></div>
            </div>
            <div class="form-group"><label class="form-label">Remarks</label><textarea class="form-input" name="remarks" rows="2"></textarea></div>
            <button type="submit" class="btn btn-primary btn-sm">Save Payment</button>
        </form>
    </div>
    <?php endif; ?>
    <table class="admin-table">
        <thead><tr><th>Status</th><th>Method</th><th>Amount</th><th>Date</th><th>Reference</th><th>Recorded By</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
        <tr>
            <td><span class="badge <?= $p['status'] === 'paid' ? 'badge-success' : 'badge-warning' ?>"><?= e(ucwords(str_replace('_', ' ', $p['status']))) ?></span></td>
            <td><?= e($p['payment_method'] ?? '—') ?></td>
            <td><?= $p['amount_paid'] ? '₹' . e(number_format((float) $p['amount_paid'], 2)) : '—' ?></td>
            <td><?= $p['payment_date'] ? e(date('d M Y', strtotime((string) $p['payment_date']))) : '—' ?></td>
            <td><?= e($p['payment_reference'] ?? '—') ?></td>
            <td><?= e($p['recorded_by_name'] ?? '—') ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$payments): ?><tr><td colspan="6"><p class="empty-state">No payment recorded yet.</p></td></tr><?php endif; ?>
        </tbody>
    </table>

    <?php elseif ($tab === 'delivery'): ?>
    <?php if ($delivery): ?>
    <div class="card">
        <div class="card-title">Delivery Record</div>
        <p><strong>Delivered:</strong> <?= e(date('d M Y H:i', strtotime((string) $delivery['delivered_at']))) ?> by <?= e($delivery['delivered_by_name'] ?? '—') ?></p>
        <p><strong>Received By:</strong> <?= e($delivery['received_by']) ?></p>
        <p><strong>Amount:</strong> <?= e($delivery['currency_code']) ?> <?= e(number_format((float) $delivery['amount_delivered'], 2)) ?></p>
        <p><strong>Customer Acknowledged:</strong> <?= (int) $delivery['customer_acknowledged'] === 1 ? 'Yes' : 'No' ?></p>
        <?php if ($delivery['delivery_remarks']): ?><p><strong>Remarks:</strong> <?= e($delivery['delivery_remarks']) ?></p><?php endif; ?>
    </div>
    <?php elseif (has_permission('forex.delivery.manage')): ?>
    <div class="card">
        <div class="card-title">Mark as Delivered</div>
        <?php if ($blockers): ?>
        <div class="alert alert-danger">
            <strong>Delivery blocked. Mandatory compliance requirements have not been completed:</strong>
            <ul style="margin:var(--space-2) 0 0 var(--space-5)"><?php foreach ($blockers as $b): ?><li><?= e($b) ?></li><?php endforeach; ?></ul>
        </div>
        <?php endif; ?>
        <form method="post" action="/admin/forex-requests/" onsubmit="return confirm('Confirm this forex delivery? This action is recorded permanently.');">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="mark_delivered">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label">Received By</label><input class="form-input" type="text" name="received_by" value="<?= e(trim($request['first_name'] . ' ' . ($request['last_name'] ?? ''))) ?>"></div>
                <div class="form-group" style="align-self:end"><label style="display:flex;gap:var(--space-2);align-items:center"><input type="checkbox" name="customer_acknowledged" value="1"> Customer acknowledgement recorded</label></div>
            </div>
            <div class="form-group"><label class="form-label">Delivery Remarks</label><textarea class="form-input" name="delivery_remarks" rows="2"></textarea></div>
            <?php if ($blockers && has_permission('forex.delivery.override')): ?>
            <div class="alert alert-warning">
                <label style="display:flex;gap:var(--space-2);align-items:center"><input type="checkbox" name="override" value="1" id="fx_override_cb" onchange="document.getElementById('fx_override_reason').style.display=this.checked?'block':'none'"> Override compliance block (requires a permanent, audited reason)</label>
                <div id="fx_override_reason" style="display:none;margin-top:var(--space-2)">
                    <textarea class="form-input" name="override_reason" rows="2" placeholder="Reason for override — permanently recorded"></textarea>
                </div>
            </div>
            <?php endif; ?>
            <button type="submit" class="btn btn-primary" <?= $blockers && !has_permission('forex.delivery.override') ? 'disabled' : '' ?>>Mark as Delivered</button>
        </form>
    </div>
    <?php else: ?>
    <p class="empty-state">You do not have permission to mark this request as delivered.</p>
    <?php endif; ?>

    <?php elseif ($tab === 'activity'): ?>
    <ul class="hrms-timeline">
        <?php foreach ($statusHistory as $h): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $h['created_at']))) ?></time>Status changed from <strong><?= e($h['from_status'] ?? 'none') ?></strong> to <strong><?= e($h['to_status']) ?></strong> by <?= e($h['changed_by_name'] ?? 'System') ?><?= $h['remarks'] ? ' — ' . e($h['remarks']) : '' ?></li>
        <?php endforeach; ?>
        <?php foreach ($auditEntries as $a): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $a['created_at']))) ?></time><?= e(ucwords(str_replace('_', ' ', $a['action']))) ?> by <?= e($a['admin_name'] ?? 'System') ?><?= $a['new_value'] ? ' — ' . e($a['new_value']) : '' ?></li>
        <?php endforeach; ?>
        <?php foreach ($approvals as $ap): ?>
        <li><time><?= e(date('d M Y H:i', strtotime((string) $ap['created_at']))) ?></time><?= e(ucwords(str_replace('_', ' ', $ap['action']))) ?> by <?= e($ap['approver_name'] ?? 'System') ?><?= $ap['remarks'] ? ' — ' . e($ap['remarks']) : '' ?></li>
        <?php endforeach; ?>
        <?php if (!$statusHistory && !$auditEntries && !$approvals): ?><li class="empty-state">No activity recorded yet.</li><?php endif; ?>
    </ul>
    <?php endif; ?>

    <?php if (has_permission('forex.requests.manage') && $request['status'] !== 'delivered'): ?>
    <form method="post" action="/admin/forex-requests/" style="margin-top:var(--space-6)" onsubmit="return confirm('Remove this forex request? This is a soft delete.');">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" value="<?= (int) $id ?>">
        <button type="submit" class="btn btn-outline btn-sm">Remove Request</button>
    </form>
    <?php endif; ?>

    <p style="margin-top:var(--space-4)"><a href="/admin/forex-requests/">&larr; Back to all forex requests</a></p>
    <?php
    admin_header_end();
    exit;
}

// ---------------------------------------------------------------
// List view
// ---------------------------------------------------------------
$statusGroups = [
    'all' => null,
    'pending_documents' => ['awaiting_documents', 'documents_submitted', 'documents_under_verification'],
    'quotations' => ['quotation_preparing', 'quotation_sent', 'customer_accepted'],
    'approved' => ['approved_for_processing', 'forex_processing', 'ready_for_delivery'],
    'delivered' => ['delivered'],
    'cancelled' => ['cancelled', 'rejected'],
];
$view = array_key_exists($_GET['view'] ?? '', $statusGroups) ? $_GET['view'] : 'all';
$search = trim((string) ($_GET['q'] ?? ''));
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['fr.deleted_at IS NULL'];
$params = [];
if ($scoped) {
    $where[] = 'fr.assigned_employee = :current_admin';
    $params['current_admin'] = current_admin_id();
}
if ($statusGroups[$view] !== null) {
    $placeholders = [];
    foreach ($statusGroups[$view] as $i => $s) {
        $key = "status$i";
        $placeholders[] = ":$key";
        $params[$key] = $s;
    }
    $where[] = 'fr.status IN (' . implode(',', $placeholders) . ')';
}
if ($search !== '') {
    // PDO with real (non-emulated) prepared statements does not
    // support the same named placeholder appearing more than once in
    // a query — each occurrence needs its own key bound to the same
    // value.
    $where[] = '(fr.forex_reference_no LIKE :search1 OR c.first_name LIKE :search2 OR c.last_name LIKE :search3 OR c.email LIKE :search4 OR c.mobile LIKE :search5 OR fr.country_of_visit LIKE :search6)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = $params['search5'] = $params['search6'] = $searchTerm;
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests fr JOIN customers c ON c.id = fr.customer_id WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT fr.*, c.first_name, c.last_name, assignee.full_name AS assigned_name
     FROM forex_requests fr
     JOIN customers c ON c.id = fr.customer_id
     LEFT JOIN admin_users assignee ON assignee.id = fr.assigned_employee
     WHERE $whereSql ORDER BY fr.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$requests = $stmt->fetchAll();

$viewLabels = ['all' => 'All Requests', 'pending_documents' => 'Pending Documents', 'quotations' => 'Quotations', 'approved' => 'Approved Requests', 'delivered' => 'Delivered', 'cancelled' => 'Cancelled'];
admin_header_start('Forex — ' . $viewLabels[$view], 'forex');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/forex-requests/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input type="hidden" name="view" value="<?= e($view) ?>">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Reference, name, email, mobile, country…">
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
    <?php if (has_permission('forex.requests.manage')): ?>
    <a href="/admin/forex-requests/?action=create" class="btn btn-primary">+ New Forex Request</a>
    <?php endif; ?>
</div>
<div class="button-group" style="margin-bottom:var(--space-5)">
    <?php foreach ($viewLabels as $key => $label): ?>
    <a href="/admin/forex-requests/?view=<?= $key ?>" class="btn btn-sm <?= $view === $key ? 'btn-primary' : 'btn-outline' ?>"><?= $label ?></a>
    <?php endforeach; ?>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Customer</th><th>Currency</th><th>Amount</th><th>Country</th><th>Status</th><th>Assigned</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($requests as $r): ?>
        <tr>
            <td><?= e($r['forex_reference_no']) ?></td>
            <td><?= e(trim($r['first_name'] . ' ' . ($r['last_name'] ?? ''))) ?></td>
            <td><?= e($r['currency_code']) ?></td>
            <td><?= e(number_format((float) $r['amount_required'], 2)) ?></td>
            <td><?= e($r['country_of_visit']) ?></td>
            <td><span class="badge badge-info"><?= e(forex_status_labels()[$r['status']] ?? $r['status']) ?></span></td>
            <td><?= e($r['assigned_name'] ?? '—') ?></td>
            <td class="actions"><a href="/admin/forex-requests/?action=view&id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$requests): ?>
        <tr><td colspan="8"><p class="empty-state">No forex requests here yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/forex-requests/?view=<?= $view ?>&page=<?= $p ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
