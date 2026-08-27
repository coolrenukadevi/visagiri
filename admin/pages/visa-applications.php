<?php
declare(strict_types=1);

require_permission('visa.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$scopedToAssigned = current_admin_scoped_to_assigned();
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();
$statuses = ['draft', 'documents_pending', 'submitted', 'under_review', 'approved', 'rejected', 'completed', 'cancelled'];

function assert_application_access(array $application, bool $scoped): void
{
    if ($scoped && (int) $application['assigned_user'] !== current_admin_id()) {
        http_response_code(403);
        exit('This application is not assigned to you.');
    }
}

// --- POST actions ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('visa.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create') {
        $customerId = (int) ($_POST['customer_id'] ?? 0);
        $countryId = (int) ($_POST['country_id'] ?? 0);
        $visaTypeId = (int) ($_POST['visa_type_id'] ?? 0);
        if ($customerId && $countryId && $visaTypeId) {
            $ref = generate_reference_number('VISA', 'visa_applications', 'application_reference_no');
            $pdo->prepare(
                'INSERT INTO visa_applications (application_reference_no, customer_id, country_id, visa_type_id, assigned_user, travel_date)
                 VALUES (:ref, :customer_id, :country_id, :visa_type_id, :assigned, :travel_date)'
            )->execute([
                'ref' => $ref,
                'customer_id' => $customerId,
                'country_id' => $countryId,
                'visa_type_id' => $visaTypeId,
                'assigned' => (int) ($_POST['assigned_user'] ?? 0) ?: null,
                'travel_date' => ($_POST['travel_date'] ?? '') !== '' ? $_POST['travel_date'] : null,
            ]);
            $newId = (int) $pdo->lastInsertId();
            $pdo->prepare('INSERT INTO visa_application_history (visa_application_id, old_status, new_status, changed_by) VALUES (:id, NULL, "draft", :admin)')
                ->execute(['id' => $newId, 'admin' => current_admin_id()]);
            log_action('create', 'visa_applications', $newId, null, $ref);
            flash_set('admin_notice', "Application $ref created.");
            redirect('/admin/visa-applications/?action=view&id=' . $newId);
        }
        flash_set('admin_error', 'Customer, country, and visa type are required.');
        redirect('/admin/visa-applications/?action=create');
    }

    if ($postAction === 'update_status' && $id) {
        $stmt = $pdo->prepare('SELECT status, assigned_user FROM visa_applications WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $prev = $stmt->fetch();
        $newStatus = $_POST['status'] ?? '';
        if ($prev && in_array($newStatus, $GLOBALS['statuses'], true)) {
            $pdo->prepare('UPDATE visa_applications SET status = :status, priority = :priority, assigned_user = :assigned, travel_date = :travel_date WHERE id = :id')
                ->execute([
                    'status' => $newStatus,
                    'priority' => in_array($_POST['priority'] ?? '', ['low', 'normal', 'high', 'urgent'], true) ? $_POST['priority'] : 'normal',
                    'assigned' => (int) ($_POST['assigned_user'] ?? 0) ?: null,
                    'travel_date' => ($_POST['travel_date'] ?? '') !== '' ? $_POST['travel_date'] : null,
                    'id' => $id,
                ]);
            if ($prev['status'] !== $newStatus) {
                $pdo->prepare('INSERT INTO visa_application_history (visa_application_id, old_status, new_status, changed_by) VALUES (:id, :old, :new, :admin)')
                    ->execute(['id' => $id, 'old' => $prev['status'], 'new' => $newStatus, 'admin' => current_admin_id()]);
                log_action('status_change', 'visa_applications', $id, $prev['status'], $newStatus);
            }
            $newAssigned = (int) ($_POST['assigned_user'] ?? 0) ?: null;
            if ((int) ($prev['assigned_user'] ?? 0) !== ($newAssigned ?? 0)) {
                log_action('assignment', 'visa_applications', $id, (string) $prev['assigned_user'], (string) $newAssigned);
            }
            flash_set('admin_notice', 'Application updated.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'add_applicant' && $id) {
        $fullName = trim((string) ($_POST['full_name'] ?? ''));
        $passport = trim((string) ($_POST['passport_number'] ?? ''));
        if ($fullName !== '') {
            $pdo->prepare(
                'INSERT INTO visa_applicants (visa_application_id, full_name, relationship_to_primary, date_of_birth, passport_number_encrypted, passport_number_hash)
                 VALUES (:id, :name, :relationship, :dob, :passport_enc, :passport_hash)'
            )->execute([
                'id' => $id,
                'name' => $fullName,
                'relationship' => trim((string) ($_POST['relationship_to_primary'] ?? '')) ?: null,
                'dob' => ($_POST['date_of_birth'] ?? '') !== '' ? $_POST['date_of_birth'] : null,
                'passport_enc' => $passport !== '' ? encrypt_value($passport) : null,
                'passport_hash' => $passport !== '' ? searchable_hash($passport) : null,
            ]);
            log_action('update', 'visa_applications', $id, null, "Applicant added: $fullName");
            flash_set('admin_notice', 'Applicant added.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'add_note' && $id) {
        $note = trim((string) ($_POST['note'] ?? ''));
        if ($note !== '') {
            $visibleToCustomer = !empty($_POST['visible_to_customer']) ? 1 : 0;
            $pdo->prepare('INSERT INTO visa_application_notes (visa_application_id, admin_user_id, note, visible_to_customer) VALUES (:id, :admin, :note, :visible)')
                ->execute(['id' => $id, 'admin' => current_admin_id(), 'note' => $note, 'visible' => $visibleToCustomer]);
            log_action('update', 'visa_applications', $id, null, 'Note added');
            if ($visibleToCustomer) {
                $appStmt = $pdo->prepare('SELECT customer_id, application_reference_no FROM visa_applications WHERE id = :id');
                $appStmt->execute(['id' => $id]);
                $app = $appStmt->fetch();
                if ($app) {
                    $pdo->prepare('INSERT INTO customer_notifications (customer_id, type, title, body, link) VALUES (:cid, "message", :title, :body, :link)')
                        ->execute([
                            'cid' => $app['customer_id'],
                            'title' => 'New message on ' . $app['application_reference_no'],
                            'body' => mb_substr($note, 0, 200),
                            'link' => '/dashboard/messages/?application_id=' . $id,
                        ]);
                }
            }
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'add_appointment' && $id) {
        $type = trim((string) ($_POST['appointment_type'] ?? ''));
        $scheduledAt = trim((string) ($_POST['scheduled_at'] ?? ''));
        if ($type !== '' && $scheduledAt !== '') {
            $appStmt = $pdo->prepare('SELECT customer_id FROM visa_applications WHERE id = :id');
            $appStmt->execute(['id' => $id]);
            $customerId = (int) $appStmt->fetchColumn();
            $pdo->prepare(
                'INSERT INTO customer_appointments (customer_id, visa_application_id, appointment_type, location, scheduled_at, notes, created_by)
                 VALUES (:cid, :id, :type, :location, :scheduled_at, :notes, :admin)'
            )->execute([
                'cid' => $customerId,
                'id' => $id,
                'type' => $type,
                'location' => trim((string) ($_POST['location'] ?? '')) ?: null,
                'scheduled_at' => $scheduledAt,
                'notes' => trim((string) ($_POST['appointment_notes'] ?? '')) ?: null,
                'admin' => current_admin_id(),
            ]);
            $newApptId = (int) $pdo->lastInsertId();
            log_action('create', 'customer_appointments', $newApptId, null, $type);
            $refStmt = $pdo->prepare('SELECT application_reference_no FROM visa_applications WHERE id = :id');
            $refStmt->execute(['id' => $id]);
            $pdo->prepare('INSERT INTO customer_notifications (customer_id, type, title, body, link) VALUES (:cid, "appointment", :title, :body, :link)')
                ->execute([
                    'cid' => $customerId,
                    'title' => 'Appointment scheduled: ' . $type,
                    'body' => 'Scheduled for ' . date('d M Y, g:i A', strtotime($scheduledAt)),
                    'link' => '/dashboard/appointments/',
                ]);
            flash_set('admin_notice', 'Appointment scheduled.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'set_commission' && $id) {
        $appStmt = $pdo->prepare('SELECT cust.referred_by_partner_id FROM visa_applications va JOIN customers cust ON cust.id = va.customer_id WHERE va.id = :id');
        $appStmt->execute(['id' => $id]);
        $partnerId = $appStmt->fetchColumn();
        if ($partnerId) {
            $amount = ($_POST['commission_amount'] ?? '') !== '' ? (float) $_POST['commission_amount'] : null;
            $status = in_array($_POST['commission_status'] ?? '', ['pending', 'approved', 'paid'], true) ? $_POST['commission_status'] : 'pending';
            $pdo->prepare(
                'INSERT INTO partner_commissions (partner_id, visa_application_id, amount_due, status, set_by, paid_at)
                 VALUES (:partner_id, :app_id, :amount, :status, :admin, :paid_at)
                 ON DUPLICATE KEY UPDATE amount_due = VALUES(amount_due), status = VALUES(status), set_by = VALUES(set_by), paid_at = VALUES(paid_at)'
            )->execute([
                'partner_id' => $partnerId,
                'app_id' => $id,
                'amount' => $amount,
                'status' => $status,
                'admin' => current_admin_id(),
                'paid_at' => $status === 'paid' ? date('Y-m-d H:i:s') : null,
            ]);
            log_action('update', 'partner_commissions', $id, null, 'Commission set: ' . ($amount ?? 'null') . ' (' . $status . ')');
            flash_set('admin_notice', 'Commission updated.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'add_quote' && $id) {
        $ref = generate_reference_number('QUOTE', 'visa_quotes', 'quote_reference_no');
        $pdo->prepare(
            'INSERT INTO visa_quotes (quote_reference_no, visa_application_id, government_fee, service_fee, currency, notes, status, created_by)
             VALUES (:ref, :id, :gov_fee, :service_fee, :currency, :notes, "sent", :admin)'
        )->execute([
            'ref' => $ref,
            'id' => $id,
            'gov_fee' => $_POST['government_fee'] !== '' ? (float) $_POST['government_fee'] : null,
            'service_fee' => $_POST['service_fee'] !== '' ? (float) $_POST['service_fee'] : null,
            'currency' => trim((string) ($_POST['currency'] ?? 'INR')) ?: 'INR',
            'notes' => trim((string) ($_POST['quote_notes'] ?? '')) ?: null,
            'admin' => current_admin_id(),
        ]);
        log_action('create', 'visa_quotes', (int) $pdo->lastInsertId(), null, $ref);
        flash_set('admin_notice', "Quote $ref recorded.");
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'add_payment' && $id) {
        $amount = (float) ($_POST['amount'] ?? 0);
        if ($amount > 0) {
            $pdo->prepare(
                'INSERT INTO visa_payments (visa_application_id, amount, currency, payment_method, payment_reference, status, recorded_by, paid_at)
                 VALUES (:id, :amount, :currency, :method, :reference, :status, :admin, :paid_at)'
            )->execute([
                'id' => $id,
                'amount' => $amount,
                'currency' => trim((string) ($_POST['currency'] ?? 'INR')) ?: 'INR',
                'method' => trim((string) ($_POST['payment_method'] ?? '')) ?: null,
                'reference' => trim((string) ($_POST['payment_reference'] ?? '')) ?: null,
                'status' => in_array($_POST['payment_status'] ?? '', ['pending', 'received', 'refunded'], true) ? $_POST['payment_status'] : 'received',
                'admin' => current_admin_id(),
                'paid_at' => date('Y-m-d H:i:s'),
            ]);
            log_action('payment_update', 'visa_payments', (int) $pdo->lastInsertId(), null, (string) $amount);
            flash_set('admin_notice', 'Payment recorded.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'upload_document' && $id) {
        $error = validate_document_upload($_FILES['document'] ?? []);
        if ($error) {
            flash_set('admin_error', $error);
        } else {
            $appStmt = $pdo->prepare('SELECT customer_id FROM visa_applications WHERE id = :id');
            $appStmt->execute(['id' => $id]);
            $customerId = (int) $appStmt->fetchColumn();
            $docId = store_document_upload(
                $_FILES['document'],
                trim((string) ($_POST['document_type'] ?? '')) ?: null,
                $customerId ?: null,
                $id,
                null,
                (int) current_admin_id()
            );
            log_action('document_upload', 'documents', $docId, null, $_FILES['document']['name'] ?? null);
            flash_set('admin_notice', 'Document uploaded.');
        }
        redirect('/admin/visa-applications/?action=view&id=' . $id);
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
        redirect('/admin/visa-applications/?action=view&id=' . $id);
    }

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE visa_applications SET deleted_at = NOW(), deleted_by = :admin WHERE id = :id')
            ->execute(['admin' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'visa_applications', $id);
        flash_set('admin_notice', 'Application removed (soft delete).');
        redirect('/admin/visa-applications/');
    }
}

// --- Create form ---
if ($action === 'create') {
    require_permission('visa.manage');
    $customers = $pdo->query('SELECT id, customer_reference_no, first_name, last_name FROM customers WHERE deleted_at IS NULL ORDER BY first_name')->fetchAll();
    $countries = countries_all();
    $visaTypesList = visa_types_all();

    admin_header_start('New Visa Application', 'visa-applications');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/visa-applications/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="create">
            <div class="form-group">
                <label class="form-label" for="customer_id">Customer</label>
                <select class="form-select" id="customer_id" name="customer_id" required>
                    <option value="">Select customer</option>
                    <?php foreach ($customers as $c): ?>
                    <option value="<?= (int) $c['id'] ?>"><?= e($c['customer_reference_no'] . ' — ' . $c['first_name'] . ' ' . ($c['last_name'] ?? '')) ?></option>
                    <?php endforeach; ?>
                </select>
                <small style="color:var(--text-muted)">No matching customer? <a href="/admin/customers/?action=create" target="_blank">Add one first</a>, then come back.</small>
            </div>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="country_id">Country</label>
                    <select class="form-select" id="country_id" name="country_id" required>
                        <option value="">Select country</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="visa_type_id">Visa Type</label>
                    <select class="form-select" id="visa_type_id" name="visa_type_id" required>
                        <option value="">Select visa type</option>
                        <?php foreach ($visaTypesList as $t): ?>
                        <option value="<?= (int) $t['id'] ?>"><?= e($t['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="assigned_user">Assigned To</label>
                    <select class="form-select" id="assigned_user" name="assigned_user">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="travel_date">Travel Date</label>
                    <input class="form-input" type="date" id="travel_date" name="travel_date">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Create Application</button>
            <a href="/admin/visa-applications/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// --- Detail view ---
if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT va.*, c.name AS country_name, v.name AS visa_type_name,
                cust.customer_reference_no, cust.first_name, cust.last_name, cust.email, cust.mobile,
                cust.referred_by_partner_id, p.company_name AS partner_company_name, p.partner_reference_no,
                e.full_name AS assigned_name
         FROM visa_applications va
         JOIN countries c ON c.id = va.country_id
         JOIN visa_types v ON v.id = va.visa_type_id
         JOIN customers cust ON cust.id = va.customer_id
         LEFT JOIN partners p ON p.id = cust.referred_by_partner_id
         LEFT JOIN admin_users e ON e.id = va.assigned_user
         WHERE va.id = :id AND va.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $application = $stmt->fetch();
    if (!$application) {
        flash_set('admin_error', 'Application not found.');
        redirect('/admin/visa-applications/');
    }
    assert_application_access($application, $scopedToAssigned);

    $applicants = $pdo->prepare('SELECT * FROM visa_applicants WHERE visa_application_id = :id ORDER BY id');
    $applicants->execute(['id' => $id]);

    $documents = $pdo->prepare('SELECT * FROM documents WHERE visa_application_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC');
    $documents->execute(['id' => $id]);

    $notes = $pdo->prepare(
        'SELECT n.*, a.full_name AS author FROM visa_application_notes n LEFT JOIN admin_users a ON a.id = n.admin_user_id
         WHERE n.visa_application_id = :id ORDER BY n.created_at DESC'
    );
    $notes->execute(['id' => $id]);

    $history = $pdo->prepare(
        'SELECT h.*, a.full_name AS changed_by_name FROM visa_application_history h LEFT JOIN admin_users a ON a.id = h.changed_by
         WHERE h.visa_application_id = :id ORDER BY h.changed_at DESC'
    );
    $history->execute(['id' => $id]);

    $quotes = $pdo->prepare('SELECT * FROM visa_quotes WHERE visa_application_id = :id ORDER BY created_at DESC');
    $quotes->execute(['id' => $id]);

    $payments = $pdo->prepare('SELECT * FROM visa_payments WHERE visa_application_id = :id ORDER BY created_at DESC');
    $payments->execute(['id' => $id]);

    $appointments = $pdo->prepare('SELECT * FROM customer_appointments WHERE visa_application_id = :id ORDER BY scheduled_at DESC');
    $appointments->execute(['id' => $id]);

    $commission = null;
    if ($application['referred_by_partner_id']) {
        $commissionStmt = $pdo->prepare('SELECT * FROM partner_commissions WHERE visa_application_id = :id');
        $commissionStmt->execute(['id' => $id]);
        $commission = $commissionStmt->fetch();
    }

    admin_header_start($application['application_reference_no'], 'visa-applications');
    ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <p><strong>Customer:</strong> <a href="/admin/customers/?action=view&id=<?= (int) $application['customer_id'] ?>"><?= e($application['customer_reference_no']) ?> — <?= e($application['first_name'] . ' ' . ($application['last_name'] ?? '')) ?></a></p>
        <?php if ($application['referred_by_partner_id']): ?>
        <p><strong>Referred By:</strong> <?= e($application['partner_company_name']) ?> (<?= e($application['partner_reference_no']) ?>)</p>
        <?php endif; ?>
        <p><strong>Country / Visa Type:</strong> <?= e($application['country_name']) ?> — <?= e($application['visa_type_name']) ?></p>
        <p><strong>Status:</strong> <span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $application['status']))) ?></span> &middot; <strong>Priority:</strong> <?= e(ucfirst($application['priority'])) ?></p>
        <p><strong>Assigned to:</strong> <?= e($application['assigned_name'] ?? 'Unassigned') ?></p>

        <?php if (has_permission('visa.manage')): ?>
        <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-4)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update_status">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach ($statuses as $s): ?>
                        <option value="<?= $s ?>"<?= $application['status'] === $s ? ' selected' : '' ?>><?= ucwords(str_replace('_', ' ', $s)) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="priority">Priority</label>
                    <select class="form-select" id="priority" name="priority">
                        <?php foreach (['low', 'normal', 'high', 'urgent'] as $p): ?>
                        <option value="<?= $p ?>"<?= $application['priority'] === $p ? ' selected' : '' ?>><?= ucfirst($p) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="assigned_user">Assigned To</label>
                    <select class="form-select" id="assigned_user" name="assigned_user">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) $application['assigned_user'] === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="travel_date">Travel Date</label>
                    <input class="form-input" type="date" id="travel_date" name="travel_date" value="<?= e((string) ($application['travel_date'] ?? '')) ?>">
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-sm">Update</button>
        </form>
        <form method="post" action="/admin/visa-applications/" style="margin-top:var(--space-3)" onsubmit="return confirm('Remove this application?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= $id ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Applicants</h2>
    <?php $rows = $applicants->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Name</th><th>Relationship</th><th>DOB</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['full_name']) ?></td><td><?= e($r['relationship_to_primary'] ?? '—') ?></td><td><?= e((string) ($r['date_of_birth'] ?? '—')) ?></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if (has_permission('visa.manage')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="add_applicant">
        <div class="admin-form-grid">
            <input class="form-input" type="text" name="full_name" placeholder="Full name" required>
            <input class="form-input" type="text" name="relationship_to_primary" placeholder="Relationship (e.g. Spouse)">
            <input class="form-input" type="date" name="date_of_birth">
            <input class="form-input" type="text" name="passport_number" placeholder="Passport number">
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Add Applicant</button>
    </form>
    <?php endif; ?>

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
                <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="verify_document"><input type="hidden" name="document_id" value="<?= (int) $r['id'] ?>"><input type="hidden" name="verify_status" value="verified"><button type="submit" class="btn btn-outline btn-sm">Verify</button></form>
                <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="verify_document"><input type="hidden" name="document_id" value="<?= (int) $r['id'] ?>"><input type="hidden" name="verify_status" value="rejected"><button type="submit" class="btn btn-outline btn-sm">Reject</button></form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if (has_permission('documents.upload')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" enctype="multipart/form-data" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="upload_document">
        <div class="admin-form-grid">
            <input class="form-input" type="text" name="document_type" placeholder="Document type (e.g. Passport copy)">
            <input class="form-input" type="file" name="document" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" required>
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Upload</button>
    </form>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Quotes</h2>
    <?php $rows = $quotes->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Reference</th><th>Government Fee</th><th>Service Fee</th><th>Status</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['quote_reference_no']) ?></td><td><?= $r['government_fee'] !== null ? e($r['currency'] . ' ' . number_format((float) $r['government_fee'], 2)) : '—' ?></td><td><?= $r['service_fee'] !== null ? e($r['currency'] . ' ' . number_format((float) $r['service_fee'], 2)) : '—' ?></td><td><span class="badge badge-info"><?= e($r['status']) ?></span></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if (has_permission('visa.manage')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="add_quote">
        <div class="admin-form-grid">
            <input class="form-input" type="number" step="0.01" name="government_fee" placeholder="Government fee">
            <input class="form-input" type="number" step="0.01" name="service_fee" placeholder="Service fee">
            <input class="form-input" type="text" name="currency" value="INR" placeholder="Currency">
            <input class="form-input" type="text" name="quote_notes" placeholder="Notes">
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Add Quote</button>
    </form>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Payments</h2>
    <?php $rows = $payments->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Amount</th><th>Method</th><th>Status</th><th>Date</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['currency'] . ' ' . number_format((float) $r['amount'], 2)) ?></td><td><?= e($r['payment_method'] ?? '—') ?></td><td><span class="badge badge-info"><?= e($r['status']) ?></span></td><td><?= e(date('d M Y', strtotime((string) $r['created_at']))) ?></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>
    <?php if (has_permission('visa.manage')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="add_payment">
        <div class="admin-form-grid">
            <input class="form-input" type="number" step="0.01" name="amount" placeholder="Amount" required>
            <input class="form-input" type="text" name="currency" value="INR" placeholder="Currency">
            <input class="form-input" type="text" name="payment_method" placeholder="Method (e.g. UPI, Bank transfer)">
            <input class="form-input" type="text" name="payment_reference" placeholder="Reference / transaction ID">
            <select class="form-select" name="payment_status">
                <option value="received">Received</option>
                <option value="pending">Pending</option>
                <option value="refunded">Refunded</option>
            </select>
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Record Payment</button>
    </form>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Notes</h2>
    <?php $rows = $notes->fetchAll(); if ($rows): foreach ($rows as $r): ?>
    <div class="card" style="margin-bottom:var(--space-3)">
        <p><?= nl2br(e($r['note'])) ?></p>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm)">
            <?= $r['customer_id'] ? 'Customer' : e($r['author'] ?? 'Unknown') ?> &middot; <?= e(date('d M Y H:i', strtotime((string) $r['created_at']))) ?>
            <?php if ($r['visible_to_customer']): ?> &middot; <span class="badge badge-info">Visible to customer</span><?php endif; ?>
        </p>
    </div>
    <?php endforeach; else: ?><p class="empty-state">No notes yet.</p><?php endif; ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>">
        <?= csrf_field() ?><input type="hidden" name="action" value="add_note">
        <textarea class="form-input" name="note" rows="2" placeholder="Add an internal note…" required></textarea>
        <label style="display:flex;align-items:center;gap:var(--space-2);margin-top:var(--space-2);font-size:var(--font-size-sm)">
            <input type="checkbox" name="visible_to_customer" value="1"> Send as a message the customer can see in their dashboard
        </label>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Add Note</button>
    </form>

    <h2 class="country-directory__subheading">Appointments</h2>
    <?php $rows = $appointments->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Type</th><th>When</th><th>Location</th><th>Status</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['appointment_type']) ?></td><td><?= e(date('d M Y, g:i A', strtotime((string) $r['scheduled_at']))) ?></td><td><?= e($r['location'] ?? '—') ?></td><td><span class="badge badge-info"><?= e($r['status']) ?></span></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php else: ?><p class="empty-state">No appointments scheduled yet.</p><?php endif; ?>
    <?php if (has_permission('visa.manage')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="add_appointment">
        <div class="admin-form-grid">
            <input class="form-input" type="text" name="appointment_type" placeholder="e.g. Biometric Appointment" required>
            <input class="form-input" type="datetime-local" name="scheduled_at" required>
            <input class="form-input" type="text" name="location" placeholder="Location">
            <input class="form-input" type="text" name="appointment_notes" placeholder="Notes (optional)">
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Schedule Appointment</button>
    </form>
    <?php endif; ?>

    <?php if ($application['referred_by_partner_id']): ?>
    <h2 class="country-directory__subheading">Partner Commission</h2>
    <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Referred by <?= e($application['partner_company_name']) ?>.</p>
    <?php if (has_permission('visa.manage')): ?>
    <form method="post" action="/admin/visa-applications/?action=view&id=<?= $id ?>" style="margin-top:var(--space-3)">
        <?= csrf_field() ?><input type="hidden" name="action" value="set_commission">
        <div class="admin-form-grid">
            <input class="form-input" type="number" step="0.01" name="commission_amount" placeholder="Commission amount" value="<?= e((string) ($commission['amount_due'] ?? '')) ?>">
            <select class="form-select" name="commission_status">
                <?php foreach (['pending', 'approved', 'paid'] as $s): ?>
                <option value="<?= $s ?>"<?= ($commission['status'] ?? 'pending') === $s ? ' selected' : '' ?>><?= ucfirst($s) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">Save Commission</button>
    </form>
    <?php endif; ?>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Status History</h2>
    <?php $rows = $history->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>From</th><th>To</th><th>By</th><th>When</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['old_status'] ?? '—') ?></td><td><?= e($r['new_status']) ?></td><td><?= e($r['changed_by_name'] ?? '—') ?></td><td><?= e(date('d M Y H:i', strtotime((string) $r['changed_at']))) ?></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/visa-applications/">&larr; Back to all applications</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$statusFilter = in_array($_GET['status'] ?? '', $statuses, true) ? $_GET['status'] : null;
$countryFilter = (int) ($_GET['country_id'] ?? 0) ?: null;
$assignedFilter = (int) ($_GET['assigned_user'] ?? 0) ?: null;

$where = ['va.deleted_at IS NULL'];
$params = [];
if ($statusFilter) {
    $where[] = 'va.status = :status';
    $params['status'] = $statusFilter;
}
if ($countryFilter) {
    $where[] = 'va.country_id = :country_id';
    $params['country_id'] = $countryFilter;
}
if ($assignedFilter) {
    $where[] = 'va.assigned_user = :assigned';
    $params['assigned'] = $assignedFilter;
}
if ($scopedToAssigned) {
    $where[] = 'va.assigned_user = :me';
    $params['me'] = current_admin_id();
}
$whereSql = implode(' AND ', $where);

$stmt = $pdo->prepare(
    "SELECT va.*, c.name AS country_name, v.name AS visa_type_name, cust.first_name, cust.last_name, e.full_name AS assigned_name
     FROM visa_applications va
     JOIN countries c ON c.id = va.country_id
     JOIN visa_types v ON v.id = va.visa_type_id
     JOIN customers cust ON cust.id = va.customer_id
     LEFT JOIN admin_users e ON e.id = va.assigned_user
     WHERE $whereSql ORDER BY va.created_at DESC LIMIT 100"
);
$stmt->execute($params);
$applications = $stmt->fetchAll();

admin_header_start('Visa Applications', 'visa-applications');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/visa-applications/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach ($statuses as $s): ?>
        <a href="/admin/visa-applications/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= ucwords(str_replace('_', ' ', $s)) ?></a>
        <?php endforeach; ?>
    </div>
    <?php if (has_permission('visa.manage')): ?>
    <a href="/admin/visa-applications/?action=create" class="btn btn-primary">+ New Application</a>
    <?php endif; ?>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Customer</th><th>Country</th><th>Visa Type</th><th>Assigned</th><th>Status</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($applications as $app): ?>
        <tr>
            <td><?= e($app['application_reference_no']) ?></td>
            <td><?= e($app['first_name'] . ' ' . ($app['last_name'] ?? '')) ?></td>
            <td><?= e($app['country_name']) ?></td>
            <td><?= e($app['visa_type_name']) ?></td>
            <td><?= e($app['assigned_name'] ?? '—') ?></td>
            <td><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $app['status']))) ?></span></td>
            <td class="actions"><a href="/admin/visa-applications/?action=view&id=<?= (int) $app['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$applications): ?>
        <tr><td colspan="7"><p class="empty-state">No applications yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
