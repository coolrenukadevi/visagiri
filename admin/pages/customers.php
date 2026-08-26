<?php
declare(strict_types=1);

require_permission('customers.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

// --- Handle POST (create, update, soft-delete) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('customers.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('UPDATE customers SET deleted_at = NOW(), deleted_by = :admin_id WHERE id = :id')
            ->execute(['admin_id' => current_admin_id(), 'id' => $id]);
        log_action('delete', 'customers', $id);
        flash_set('admin_notice', 'Customer removed (soft delete — recoverable by a Super Admin directly in the database if needed).');
        redirect('/admin/customers/');
    }

    if ($postAction === 'save') {
        $passportNumber = trim((string) ($_POST['passport_number'] ?? ''));
        $data = [
            'first_name' => trim((string) ($_POST['first_name'] ?? '')),
            'middle_name' => trim((string) ($_POST['middle_name'] ?? '')) ?: null,
            'last_name' => trim((string) ($_POST['last_name'] ?? '')) ?: null,
            'date_of_birth' => ($_POST['date_of_birth'] ?? '') !== '' ? $_POST['date_of_birth'] : null,
            'gender' => in_array($_POST['gender'] ?? '', ['male', 'female', 'other'], true) ? $_POST['gender'] : null,
            'nationality' => trim((string) ($_POST['nationality'] ?? '')) ?: null,
            'passport_number_encrypted' => $passportNumber !== '' ? encrypt_value($passportNumber) : null,
            'passport_number_hash' => $passportNumber !== '' ? searchable_hash($passportNumber) : null,
            'passport_issue_date' => ($_POST['passport_issue_date'] ?? '') !== '' ? $_POST['passport_issue_date'] : null,
            'passport_expiry_date' => ($_POST['passport_expiry_date'] ?? '') !== '' ? $_POST['passport_expiry_date'] : null,
            'email' => trim((string) ($_POST['email'] ?? '')) ?: null,
            'mobile' => trim((string) ($_POST['mobile'] ?? '')) ?: null,
            'alternate_mobile' => trim((string) ($_POST['alternate_mobile'] ?? '')) ?: null,
            'address' => trim((string) ($_POST['address'] ?? '')) ?: null,
            'city' => trim((string) ($_POST['city'] ?? '')) ?: null,
            'state' => trim((string) ($_POST['state'] ?? '')) ?: null,
            'country' => trim((string) ($_POST['country'] ?? '')) ?: null,
            'pincode' => trim((string) ($_POST['pincode'] ?? '')) ?: null,
            'preferred_contact_method' => in_array($_POST['preferred_contact_method'] ?? '', ['email', 'mobile', 'whatsapp'], true) ? $_POST['preferred_contact_method'] : null,
            'customer_source' => trim((string) ($_POST['customer_source'] ?? '')) ?: null,
            'assigned_employee' => (int) ($_POST['assigned_employee'] ?? 0) ?: null,
            'status' => in_array($_POST['status'] ?? '', ['active', 'inactive'], true) ? $_POST['status'] : 'active',
        ];

        if ($data['first_name'] === '') {
            flash_set('admin_error', 'First name is required.');
            redirect($id ? "/admin/customers/?action=edit&id=$id" : '/admin/customers/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $setClause = implode(', ', array_map(static fn($k) => "$k = :$k", array_diff(array_keys($data), ['id'])));
            $pdo->prepare("UPDATE customers SET $setClause WHERE id = :id")->execute($data);
            log_action('update', 'customers', $id);
            flash_set('admin_notice', 'Customer updated.');
        } else {
            $data['customer_reference_no'] = generate_reference_number('CUST', 'customers', 'customer_reference_no');
            $cols = implode(', ', array_keys($data));
            $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
            $pdo->prepare("INSERT INTO customers ($cols) VALUES ($placeholders)")->execute($data);
            $id = (int) $pdo->lastInsertId();
            log_action('create', 'customers', $id);
            flash_set('admin_notice', "Customer added ({$data['customer_reference_no']}).");
        }
        redirect('/admin/customers/');
    }
}

// --- Create/Edit form ---
if ($action === 'create' || $action === 'edit') {
    $customer = array_fill_keys([
        'first_name', 'middle_name', 'last_name', 'date_of_birth', 'gender', 'nationality',
        'passport_issue_date', 'passport_expiry_date', 'email', 'mobile', 'alternate_mobile',
        'address', 'city', 'state', 'country', 'pincode', 'preferred_contact_method',
        'customer_source', 'assigned_employee', 'status',
    ], '');
    $customer['status'] = 'active';
    $passportPlain = '';

    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM customers WHERE id = :id AND deleted_at IS NULL');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Customer not found.');
            redirect('/admin/customers/');
        }
        $customer = $found;
        $passportPlain = decrypt_value($found['passport_number_encrypted']) ?? '';
    }

    admin_header_start($action === 'edit' ? 'Edit Customer' : 'Add Customer', 'customers');
    ?>
    <div class="admin-form-card" style="max-width:900px">
        <form method="post" action="/admin/customers/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label" for="first_name">First Name</label><input class="form-input" type="text" id="first_name" name="first_name" value="<?= e($customer['first_name']) ?>" required></div>
                <div class="form-group"><label class="form-label" for="middle_name">Middle Name</label><input class="form-input" type="text" id="middle_name" name="middle_name" value="<?= e($customer['middle_name'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="last_name">Last Name</label><input class="form-input" type="text" id="last_name" name="last_name" value="<?= e($customer['last_name'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="date_of_birth">Date of Birth</label><input class="form-input" type="date" id="date_of_birth" name="date_of_birth" value="<?= e((string) ($customer['date_of_birth'] ?? '')) ?>"></div>
                <div class="form-group">
                    <label class="form-label" for="gender">Gender</label>
                    <select class="form-select" id="gender" name="gender">
                        <option value="">— Not specified —</option>
                        <?php foreach (['male' => 'Male', 'female' => 'Female', 'other' => 'Other'] as $val => $label): ?>
                        <option value="<?= $val ?>"<?= ($customer['gender'] ?? '') === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><label class="form-label" for="nationality">Nationality</label><input class="form-input" type="text" id="nationality" name="nationality" value="<?= e($customer['nationality'] ?? '') ?>"></div>
                <div class="form-group">
                    <label class="form-label" for="passport_number">Passport Number</label>
                    <input class="form-input" type="text" id="passport_number" name="passport_number" value="<?= e($passportPlain) ?>" autocomplete="off">
                    <small style="color:var(--text-muted)">Encrypted at rest — never stored in plain text.</small>
                </div>
                <div class="form-group"><label class="form-label" for="passport_issue_date">Passport Issue Date</label><input class="form-input" type="date" id="passport_issue_date" name="passport_issue_date" value="<?= e((string) ($customer['passport_issue_date'] ?? '')) ?>"></div>
                <div class="form-group"><label class="form-label" for="passport_expiry_date">Passport Expiry Date</label><input class="form-input" type="date" id="passport_expiry_date" name="passport_expiry_date" value="<?= e((string) ($customer['passport_expiry_date'] ?? '')) ?>"></div>
                <div class="form-group"><label class="form-label" for="email">Email</label><input class="form-input" type="email" id="email" name="email" value="<?= e($customer['email'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="mobile">Mobile</label><input class="form-input" type="text" id="mobile" name="mobile" value="<?= e($customer['mobile'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="alternate_mobile">Alternate Mobile</label><input class="form-input" type="text" id="alternate_mobile" name="alternate_mobile" value="<?= e($customer['alternate_mobile'] ?? '') ?>"></div>
                <div class="form-group">
                    <label class="form-label" for="preferred_contact_method">Preferred Contact Method</label>
                    <select class="form-select" id="preferred_contact_method" name="preferred_contact_method">
                        <option value="">— Not specified —</option>
                        <?php foreach (['email' => 'Email', 'mobile' => 'Mobile', 'whatsapp' => 'WhatsApp'] as $val => $label): ?>
                        <option value="<?= $val ?>"<?= ($customer['preferred_contact_method'] ?? '') === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group"><label class="form-label" for="city">City</label><input class="form-input" type="text" id="city" name="city" value="<?= e($customer['city'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="state">State</label><input class="form-input" type="text" id="state" name="state" value="<?= e($customer['state'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="country">Country</label><input class="form-input" type="text" id="country" name="country" value="<?= e($customer['country'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="pincode">Pincode</label><input class="form-input" type="text" id="pincode" name="pincode" value="<?= e($customer['pincode'] ?? '') ?>"></div>
                <div class="form-group"><label class="form-label" for="customer_source">Source</label><input class="form-input" type="text" id="customer_source" name="customer_source" value="<?= e($customer['customer_source'] ?? '') ?>" placeholder="e.g. Website, Referral, Walk-in"></div>
                <div class="form-group">
                    <label class="form-label" for="assigned_employee">Assigned Employee</label>
                    <select class="form-select" id="assigned_employee" name="assigned_employee">
                        <option value="">— Unassigned —</option>
                        <?php foreach ($employees as $emp): ?>
                        <option value="<?= (int) $emp['id'] ?>"<?= (int) ($customer['assigned_employee'] ?? 0) === (int) $emp['id'] ? ' selected' : '' ?>><?= e($emp['full_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="active"<?= $customer['status'] === 'active' ? ' selected' : '' ?>>Active</option>
                        <option value="inactive"<?= $customer['status'] === 'inactive' ? ' selected' : '' ?>>Inactive</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="address">Address</label>
                <textarea class="form-input" id="address" name="address" rows="2"><?= e($customer['address'] ?? '') ?></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/customers/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// --- Detail view ---
if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT c.*, e.full_name AS assigned_name FROM customers c
         LEFT JOIN admin_users e ON e.id = c.assigned_employee
         WHERE c.id = :id AND c.deleted_at IS NULL'
    );
    $stmt->execute(['id' => $id]);
    $customer = $stmt->fetch();
    if (!$customer) {
        flash_set('admin_error', 'Customer not found.');
        redirect('/admin/customers/');
    }

    $enquiries = $pdo->prepare(
        'SELECT reference_number, status, created_at FROM visa_enquiries WHERE customer_id = :id ORDER BY created_at DESC'
    );
    $enquiries->execute(['id' => $id]);

    $applications = $pdo->prepare(
        'SELECT va.*, c.name AS country_name, v.name AS visa_type_name FROM visa_applications va
         JOIN countries c ON c.id = va.country_id JOIN visa_types v ON v.id = va.visa_type_id
         WHERE va.customer_id = :id AND va.deleted_at IS NULL ORDER BY va.created_at DESC'
    );
    $applications->execute(['id' => $id]);

    $documents = $pdo->prepare(
        'SELECT * FROM documents WHERE customer_id = :id AND deleted_at IS NULL ORDER BY uploaded_at DESC'
    );
    $documents->execute(['id' => $id]);

    admin_header_start($customer['first_name'] . ' ' . ($customer['last_name'] ?? ''), 'customers');
    ?>
    <div class="admin-form-card" style="max-width:900px;margin-bottom:var(--space-6)">
        <p><strong>Reference:</strong> <?= e($customer['customer_reference_no']) ?></p>
        <p><strong>Name:</strong> <?= e(trim($customer['first_name'] . ' ' . ($customer['middle_name'] ?? '') . ' ' . ($customer['last_name'] ?? ''))) ?></p>
        <p><strong>Email:</strong> <?= e($customer['email'] ?? '—') ?> &middot; <strong>Mobile:</strong> <?= e($customer['mobile'] ?? '—') ?></p>
        <p><strong>Nationality:</strong> <?= e($customer['nationality'] ?? '—') ?></p>
        <p><strong>Passport:</strong> <?= e(decrypt_value($customer['passport_number_encrypted']) ?? 'Not on file') ?></p>
        <p><strong>Assigned to:</strong> <?= e($customer['assigned_name'] ?? 'Unassigned') ?> &middot; <strong>Status:</strong> <?= e(ucfirst($customer['status'])) ?></p>
        <a href="/admin/customers/?action=edit&id=<?= (int) $customer['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
    </div>

    <h2 class="country-directory__subheading">Visa Enquiries</h2>
    <?php $rows = $enquiries->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Reference</th><th>Status</th><th>Received</th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['reference_number']) ?></td><td><span class="badge badge-info"><?= e($r['status']) ?></span></td><td><?= e(date('d M Y', strtotime((string) $r['created_at']))) ?></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php else: ?><p class="empty-state">None yet.</p><?php endif; ?>

    <h2 class="country-directory__subheading">Visa Applications</h2>
    <?php $rows = $applications->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>Reference</th><th>Country</th><th>Visa Type</th><th>Status</th><th></th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['application_reference_no']) ?></td><td><?= e($r['country_name']) ?></td><td><?= e($r['visa_type_name']) ?></td><td><span class="badge badge-info"><?= e($r['status']) ?></span></td>
        <td class="actions"><a href="/admin/visa-applications/?action=view&id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">View</a></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php else: ?><p class="empty-state">None yet.</p><?php endif; ?>

    <h2 class="country-directory__subheading">Documents</h2>
    <?php $rows = $documents->fetchAll(); if ($rows): ?>
    <table class="admin-table"><thead><tr><th>File</th><th>Type</th><th>Verification</th><th>Uploaded</th><th></th></tr></thead><tbody>
        <?php foreach ($rows as $r): ?>
        <tr><td><?= e($r['original_filename']) ?></td><td><?= e($r['document_type'] ?? '—') ?></td><td><span class="badge <?= $r['verification_status'] === 'verified' ? 'badge-success' : ($r['verification_status'] === 'rejected' ? 'badge-danger' : 'badge-warning') ?>"><?= e($r['verification_status']) ?></span></td><td><?= e(date('d M Y', strtotime((string) $r['uploaded_at']))) ?></td>
        <td class="actions"><a href="/admin/document-download/?id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Download</a></td></tr>
        <?php endforeach; ?>
    </tbody></table>
    <?php else: ?><p class="empty-state">None yet.</p><?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/customers/">&larr; Back to all customers</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = in_array($_GET['status'] ?? '', ['active', 'inactive'], true) ? $_GET['status'] : null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 25;
$offset = ($page - 1) * $perPage;

$where = ['c.deleted_at IS NULL'];
$params = [];
if ($search !== '') {
    // PDO with real (non-emulated) prepared statements does not
    // support the same named placeholder appearing more than once in
    // a query — each occurrence needs its own key bound to the same
    // value.
    $where[] = '(c.first_name LIKE :search1 OR c.last_name LIKE :search2 OR c.email LIKE :search3 OR c.mobile LIKE :search4 OR c.customer_reference_no LIKE :search5 OR c.passport_number_hash = :passport_hash)';
    $searchTerm = "%$search%";
    $params['search1'] = $params['search2'] = $params['search3'] = $params['search4'] = $params['search5'] = $searchTerm;
    $params['passport_hash'] = searchable_hash($search);
}
if ($statusFilter) {
    $where[] = 'c.status = :status';
    $params['status'] = $statusFilter;
}
$whereSql = implode(' AND ', $where);

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM customers c WHERE $whereSql");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT c.*, e.full_name AS assigned_name FROM customers c
     LEFT JOIN admin_users e ON e.id = c.assigned_employee
     WHERE $whereSql ORDER BY c.created_at DESC LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$customers = $stmt->fetchAll();

admin_header_start('Customers', 'customers');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/customers/" style="display:flex;gap:var(--space-2);flex-wrap:wrap">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search name, email, mobile, reference, passport…">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <option value="active"<?= $statusFilter === 'active' ? ' selected' : '' ?>>Active</option>
            <option value="inactive"<?= $statusFilter === 'inactive' ? ' selected' : '' ?>>Inactive</option>
        </select>
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
    <?php if (has_permission('customers.manage')): ?>
    <a href="/admin/customers/?action=create" class="btn btn-primary">+ Add Customer</a>
    <?php endif; ?>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Name</th><th>Contact</th><th>Assigned</th><th>Status</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($customers as $c): ?>
        <tr>
            <td><?= e($c['customer_reference_no']) ?></td>
            <td><?= e(trim($c['first_name'] . ' ' . ($c['last_name'] ?? ''))) ?></td>
            <td><?= e($c['email'] ?? $c['mobile'] ?? '—') ?></td>
            <td><?= e($c['assigned_name'] ?? '—') ?></td>
            <td><span class="badge <?= $c['status'] === 'active' ? 'badge-success' : 'badge-neutral' ?>"><?= e(ucfirst($c['status'])) ?></span></td>
            <td class="actions">
                <a href="/admin/customers/?action=view&id=<?= (int) $c['id'] ?>" class="btn btn-outline btn-sm">View</a>
                <?php if (has_permission('customers.manage')): ?>
                <a href="/admin/customers/?action=edit&id=<?= (int) $c['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$customers): ?>
        <tr><td colspan="6"><p class="empty-state">No customers yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/customers/?page=<?= $p ?><?= $search !== '' ? '&q=' . urlencode($search) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
