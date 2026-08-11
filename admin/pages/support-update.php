<?php
declare(strict_types=1);

/** POST /admin/support/{id}/ — $id set by admin/index.php. */

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/admin/support/');
}

csrf_require();

$pdo = db();
$stmt = $pdo->prepare('SELECT id FROM support_tickets WHERE id = :id');
$stmt->execute(['id' => $id]);
if (!$stmt->fetch()) {
    render_not_found("We couldn't find that support ticket.");
}

$validStatuses = ['open', 'in_progress', 'resolved', 'closed'];
$status = (string) ($_POST['status'] ?? '');
$assignedTo = $_POST['assigned_to'] !== '' ? (int) $_POST['assigned_to'] : null;

if (!in_array($status, $validStatuses, true)) {
    flash_set('notice', 'Select a valid status.');
    redirect('/admin/support/');
}

if ($assignedTo !== null) {
    $check = $pdo->prepare(
        "SELECT u.id FROM users u JOIN roles r ON r.id = u.role_id
         WHERE u.id = :id AND r.name IN ('super_admin', 'admin', 'support', 'consultant') AND u.deleted_at IS NULL"
    );
    $check->execute(['id' => $assignedTo]);
    if (!$check->fetch()) {
        flash_set('notice', 'Select a valid staff member.');
        redirect('/admin/support/');
    }
}

$pdo->prepare('UPDATE support_tickets SET status = :status, assigned_to = :assigned_to WHERE id = :id')
    ->execute(['status' => $status, 'assigned_to' => $assignedTo, 'id' => $id]);

flash_set('notice', 'Ticket updated.');
redirect('/admin/support/');
