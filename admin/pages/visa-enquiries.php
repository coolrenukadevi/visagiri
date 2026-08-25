<?php
declare(strict_types=1);

require_permission('visa.view');

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$scopedToAssigned = current_admin_scoped_to_assigned();
$employees = $pdo->query('SELECT id, full_name FROM admin_users WHERE status = "active" ORDER BY full_name')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('visa.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'update' && $id) {
        $status = $_POST['status'] ?? '';
        $priority = $_POST['priority'] ?? '';
        $assignedUser = (int) ($_POST['assigned_user'] ?? 0) ?: null;

        if (in_array($status, ['new', 'contacted', 'in_progress', 'closed'], true)) {
            $before = $pdo->prepare('SELECT status, assigned_user FROM visa_enquiries WHERE id = :id');
            $before->execute(['id' => $id]);
            $prev = $before->fetch();

            $pdo->prepare(
                'UPDATE visa_enquiries SET status = :status, priority = :priority, assigned_user = :assigned WHERE id = :id'
            )->execute([
                'status' => $status,
                'priority' => in_array($priority, ['low', 'normal', 'high', 'urgent'], true) ? $priority : 'normal',
                'assigned' => $assignedUser,
                'id' => $id,
            ]);

            if ($prev && $prev['status'] !== $status) {
                log_action('status_change', 'visa_enquiries', $id, $prev['status'], $status);
            }
            if ($prev && (int) ($prev['assigned_user'] ?? 0) !== ($assignedUser ?? 0)) {
                log_action('assignment', 'visa_enquiries', $id, (string) $prev['assigned_user'], (string) $assignedUser);
            }
            flash_set('admin_notice', 'Enquiry updated.');
        }
        redirect('/admin/visa-enquiries/?id=' . $id);
    }

    if ($postAction === 'convert' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM visa_enquiries WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $enquiry = $stmt->fetch();

        if ($enquiry && $enquiry['country_id'] && $enquiry['visa_type_id']) {
            $customerId = (int) $enquiry['customer_id'];
            if (!$customerId) {
                $nameParts = explode(' ', trim($enquiry['name']), 2);
                $customerRef = generate_reference_number('CUST', 'customers', 'customer_reference_no');
                $pdo->prepare(
                    'INSERT INTO customers (customer_reference_no, first_name, last_name, email, mobile, customer_source, assigned_employee)
                     VALUES (:ref, :first, :last, :email, :mobile, :source, :assigned)'
                )->execute([
                    'ref' => $customerRef,
                    'first' => $nameParts[0],
                    'last' => $nameParts[1] ?? null,
                    'email' => $enquiry['email'],
                    'mobile' => $enquiry['mobile'],
                    'source' => 'Website visa enquiry',
                    'assigned' => $enquiry['assigned_user'],
                ]);
                $customerId = (int) $pdo->lastInsertId();
                $pdo->prepare('UPDATE visa_enquiries SET customer_id = :cid WHERE id = :id')->execute(['cid' => $customerId, 'id' => $id]);
                log_action('create', 'customers', $customerId, null, "Auto-created from visa enquiry {$enquiry['reference_number']}");
            }

            $appRef = generate_reference_number('VISA', 'visa_applications', 'application_reference_no');
            $pdo->prepare(
                'INSERT INTO visa_applications (application_reference_no, visa_enquiry_id, customer_id, country_id, visa_type_id, assigned_user, travel_date)
                 VALUES (:ref, :enquiry_id, :customer_id, :country_id, :visa_type_id, :assigned, :travel_date)'
            )->execute([
                'ref' => $appRef,
                'enquiry_id' => $id,
                'customer_id' => $customerId,
                'country_id' => $enquiry['country_id'],
                'visa_type_id' => $enquiry['visa_type_id'],
                'assigned' => $enquiry['assigned_user'],
                'travel_date' => $enquiry['travel_date'],
            ]);
            $applicationId = (int) $pdo->lastInsertId();
            $pdo->prepare('INSERT INTO visa_application_history (visa_application_id, old_status, new_status, changed_by) VALUES (:id, NULL, "draft", :admin)')
                ->execute(['id' => $applicationId, 'admin' => current_admin_id()]);
            log_action('create', 'visa_applications', $applicationId, null, $appRef);

            flash_set('admin_notice', "Converted to application $appRef.");
            redirect('/admin/visa-applications/?action=view&id=' . $applicationId);
        }

        flash_set('admin_error', 'Cannot convert — this enquiry has no destination country or visa type on file.');
        redirect('/admin/visa-enquiries/?id=' . $id);
    }
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT e.*, c.name AS country_name, v.name AS visa_type_name, cust.customer_reference_no
         FROM visa_enquiries e
         LEFT JOIN countries c ON c.id = e.country_id LEFT JOIN visa_types v ON v.id = e.visa_type_id
         LEFT JOIN customers cust ON cust.id = e.customer_id
         WHERE e.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/visa-enquiries/');
    }
    if ($scopedToAssigned && (int) $enquiry['assigned_user'] !== current_admin_id()) {
        http_response_code(403);
        exit('This enquiry is not assigned to you.');
    }

    admin_header_start('Enquiry ' . $enquiry['reference_number'], 'visa-enquiries');
    ?>
    <div class="admin-form-card">
        <p><strong>Reference:</strong> <?= e($enquiry['reference_number']) ?></p>
        <?php if ($enquiry['customer_reference_no']): ?>
        <p><strong>Customer:</strong> <a href="/admin/customers/?action=view&id=<?= (int) $enquiry['customer_id'] ?>"><?= e($enquiry['customer_reference_no']) ?></a></p>
        <?php endif; ?>
        <p><strong>Name:</strong> <?= e($enquiry['name']) ?></p>
        <p><strong>Mobile:</strong> <?= e($enquiry['mobile']) ?></p>
        <p><strong>Email:</strong> <?= e($enquiry['email']) ?></p>
        <p><strong>Country:</strong> <?= e($enquiry['country_name'] ?? 'Not specified') ?></p>
        <p><strong>Visa Type:</strong> <?= e($enquiry['visa_type_name'] ?? 'Not specified') ?></p>
        <p><strong>Purpose of Travel:</strong> <?= e($enquiry['purpose_of_travel'] ?? 'Not specified') ?></p>
        <p><strong>Travel Date:</strong> <?= $enquiry['travel_date'] ? e(date('d M Y', strtotime((string) $enquiry['travel_date']))) : 'Not specified' ?></p>
        <p><strong>Travellers:</strong> <?= (int) $enquiry['travellers_count'] ?></p>
        <p><strong>Message:</strong><br><?= nl2br(e($enquiry['message'] ?? '')) ?></p>
        <p><strong>Received:</strong> <?= e(date('d M Y H:i', strtotime((string) $enquiry['created_at']))) ?></p>

        <form method="post" action="/admin/visa-enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <?php foreach (['new', 'contacted', 'in_progress', 'closed'] as $s): ?>
                        <option value="<?= $s ?>"<?= $enquiry['status'] === $s ? ' selected' : '' ?>><?= e(ucwords(str_replace('_', ' ', $s))) ?></option>
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

        <?php if (!$enquiry['customer_reference_no']): ?>
        <form method="post" action="/admin/visa-enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-4)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="convert">
            <button type="submit" class="btn btn-gold">Convert to Application</button>
        </form>
        <?php else: ?>
        <form method="post" action="/admin/visa-enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-4)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="convert">
            <button type="submit" class="btn btn-gold">Create Another Application for This Customer</button>
        </form>
        <?php endif; ?>
    </div>
    <p style="margin-top:var(--space-4)"><a href="/admin/visa-enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = in_array($_GET['status'] ?? '', ['new', 'contacted', 'in_progress', 'closed'], true) ? $_GET['status'] : null;
$where = [];
$params = [];
if ($statusFilter) {
    $where[] = 'e.status = :status';
    $params['status'] = $statusFilter;
}
if ($scopedToAssigned) {
    $where[] = 'e.assigned_user = :me';
    $params['me'] = current_admin_id();
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$sql = "SELECT e.*, c.name AS country_name FROM visa_enquiries e LEFT JOIN countries c ON c.id = e.country_id $whereSql ORDER BY e.created_at DESC LIMIT 100";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

admin_header_start('Visa Enquiries', 'visa-enquiries');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/visa-enquiries/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach (['new', 'contacted', 'in_progress', 'closed'] as $s): ?>
        <a href="/admin/visa-enquiries/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= e(ucwords(str_replace('_', ' ', $s))) ?></a>
        <?php endforeach; ?>
    </div>
</div>
<?php if ($enquiries): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Name</th><th>Country</th><th>Priority</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $enq): ?>
        <tr>
            <td><?= e($enq['reference_number']) ?></td>
            <td><?= e($enq['name']) ?></td>
            <td><?= e($enq['country_name'] ?? '—') ?></td>
            <td><span class="badge badge-neutral"><?= e(ucfirst($enq['priority'])) ?></span></td>
            <td><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $enq['status']))) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
            <td class="actions"><a href="/admin/visa-enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No enquiries yet.</p>
<?php endif; ?>
<?php
admin_header_end();
