<?php
declare(strict_types=1);

/** POST /admin/users/{id}/toggle-status/ — $id set by admin/index.php. Customers only. */

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/admin/users/');
}

csrf_require();

$pdo = db();
$stmt = $pdo->prepare(
    "SELECT u.id, u.status FROM users u JOIN roles r ON r.id = u.role_id
     WHERE u.id = :id AND r.name = 'customer' AND u.deleted_at IS NULL"
);
$stmt->execute(['id' => $id]);
$targetUser = $stmt->fetch();

if (!$targetUser) {
    render_not_found("We couldn't find that account.");
}

$newStatus = $targetUser['status'] === 'active' ? 'suspended' : 'active';
$pdo->prepare('UPDATE users SET status = :status WHERE id = :id')->execute(['status' => $newStatus, 'id' => $id]);

flash_set('notice', $newStatus === 'suspended' ? 'Account suspended.' : 'Account reactivated.');
redirect('/admin/users/');
