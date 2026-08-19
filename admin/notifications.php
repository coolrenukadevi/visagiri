<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
header('Content-Type: application/json');

$pdo = enquiry_db();
$action = $_GET['action'] ?? '';

function crm_time_ago(string $iso): string
{
    $diff = time() - strtotime($iso);
    if ($diff < 60) return 'just now';
    if ($diff < 3600) return floor($diff / 60) . 'm ago';
    if ($diff < 86400) return floor($diff / 3600) . 'h ago';
    return floor($diff / 86400) . 'd ago';
}

if ($action === 'mark_read') {
    $stmt = $pdo->prepare('UPDATE notifications SET is_read = 1 WHERE user_id IS NULL OR user_id = ?');
    $stmt->execute([admin_user_id()]);
    echo json_encode(['success' => true]);
    exit;
}

$stmt = $pdo->prepare('SELECT n.*, e.enquiry_ref FROM notifications n
    LEFT JOIN enquiries e ON e.id = n.enquiry_id
    WHERE n.user_id IS NULL OR n.user_id = ?
    ORDER BY n.created_at DESC LIMIT 20');
$stmt->execute([admin_user_id()]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$notifications = array_map(function ($r) {
    return [
        'message' => htmlspecialchars($r['message']),
        'enquiry_ref' => $r['enquiry_ref'],
        'is_read' => (bool) $r['is_read'],
        'time_ago' => crm_time_ago($r['created_at']),
    ];
}, $rows);

echo json_encode(['notifications' => $notifications]);
