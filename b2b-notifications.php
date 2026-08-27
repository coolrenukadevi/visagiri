<?php
/**
 * Partner-portal notification bell AJAX endpoint — mirrors
 * admin/notifications.php's list/mark_read shape, but reads the dedicated
 * b2b_partner_notifications table (see includes/b2b-db.php) scoped to the
 * logged-in partner, never the shared staff `notifications` table.
 */
require_once __DIR__ . '/includes/partner-auth.php';
partner_require_login();
header('Content-Type: application/json');

$pdo = b2b_db();
$pid = partner_id();
$action = $_GET['action'] ?? '';

function b2b_time_ago(string $iso): string
{
    $diff = time() - strtotime($iso);
    if ($diff < 60) return 'just now';
    if ($diff < 3600) return floor($diff / 60) . 'm ago';
    if ($diff < 86400) return floor($diff / 3600) . 'h ago';
    return floor($diff / 86400) . 'd ago';
}

if ($action === 'mark_read') {
    $stmt = $pdo->prepare('UPDATE b2b_partner_notifications SET is_read = 1 WHERE partner_id = ?');
    $stmt->execute([$pid]);
    echo json_encode(['success' => true]);
    exit;
}

$stmt = $pdo->prepare('SELECT * FROM b2b_partner_notifications WHERE partner_id = ? ORDER BY created_at DESC LIMIT 20');
$stmt->execute([$pid]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$notifications = array_map(function ($r) {
    return [
        'message' => htmlspecialchars($r['message']),
        'is_read' => (bool) $r['is_read'],
        'time_ago' => b2b_time_ago($r['created_at']),
    ];
}, $rows);

echo json_encode(['notifications' => $notifications]);
