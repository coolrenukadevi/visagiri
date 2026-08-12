<?php
declare(strict_types=1);

$pdo = db();
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $status = $_POST['status'] ?? '';
    if ($id && in_array($status, ['new', 'contacted', 'in_progress', 'closed'], true)) {
        $pdo->prepare('UPDATE enquiries SET status = :status WHERE id = :id')->execute(['status' => $status, 'id' => $id]);
        flash_set('admin_notice', 'Enquiry status updated.');
    }
    redirect('/admin/enquiries/?id=' . $id);
}

if ($id) {
    $stmt = $pdo->prepare(
        'SELECT e.*, c.name AS country_name, v.name AS visa_type_name FROM enquiries e
         LEFT JOIN countries c ON c.id = e.country_id LEFT JOIN visa_types v ON v.id = e.visa_type_id
         WHERE e.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $enquiry = $stmt->fetch();
    if (!$enquiry) {
        flash_set('admin_error', 'Enquiry not found.');
        redirect('/admin/enquiries/');
    }

    admin_header_start('Enquiry ' . $enquiry['reference_number'], 'enquiries');
    ?>
    <div class="admin-form-card">
        <p><strong>Reference:</strong> <?= e($enquiry['reference_number']) ?></p>
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

        <form method="post" action="/admin/enquiries/?id=<?= (int) $enquiry['id'] ?>" style="margin-top:var(--space-5)">
            <?= csrf_field() ?>
            <div class="form-group">
                <label class="form-label" for="status">Status</label>
                <select class="form-select" id="status" name="status">
                    <?php foreach (['new', 'contacted', 'in_progress', 'closed'] as $s): ?>
                    <option value="<?= $s ?>"<?= $enquiry['status'] === $s ? ' selected' : '' ?>><?= e(ucwords(str_replace('_', ' ', $s))) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update Status</button>
        </form>
    </div>
    <p style="margin-top:var(--space-4)"><a href="/admin/enquiries/">&larr; Back to all enquiries</a></p>
    <?php
    admin_header_end();
    exit;
}

$statusFilter = in_array($_GET['status'] ?? '', ['new', 'contacted', 'in_progress', 'closed'], true) ? $_GET['status'] : null;
$sql = 'SELECT e.*, c.name AS country_name FROM enquiries e LEFT JOIN countries c ON c.id = e.country_id';
$params = [];
if ($statusFilter) {
    $sql .= ' WHERE e.status = :status';
    $params['status'] = $statusFilter;
}
$sql .= ' ORDER BY e.created_at DESC LIMIT 100';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$enquiries = $stmt->fetchAll();

admin_header_start('Enquiries', 'enquiries');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <a href="/admin/enquiries/" class="btn btn-sm <?= !$statusFilter ? 'btn-primary' : 'btn-outline' ?>">All</a>
        <?php foreach (['new', 'contacted', 'in_progress', 'closed'] as $s): ?>
        <a href="/admin/enquiries/?status=<?= $s ?>" class="btn btn-sm <?= $statusFilter === $s ? 'btn-primary' : 'btn-outline' ?>"><?= e(ucwords(str_replace('_', ' ', $s))) ?></a>
        <?php endforeach; ?>
    </div>
</div>
<?php if ($enquiries): ?>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Name</th><th>Country</th><th>Status</th><th>Received</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($enquiries as $enq): ?>
        <tr>
            <td><?= e($enq['reference_number']) ?></td>
            <td><?= e($enq['name']) ?></td>
            <td><?= e($enq['country_name'] ?? '—') ?></td>
            <td><span class="badge badge-info"><?= e(ucwords(str_replace('_', ' ', $enq['status']))) ?></span></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $enq['created_at']))) ?></td>
            <td class="actions"><a href="/admin/enquiries/?id=<?= (int) $enq['id'] ?>" class="btn btn-outline btn-sm">View</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No enquiries yet.</p>
<?php endif; ?>
<?php
admin_header_end();
