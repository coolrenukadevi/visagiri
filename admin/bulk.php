<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
header('Content-Type: application/json');

$body = json_decode(file_get_contents('php://input'), true) ?: [];
$action = $body['action'] ?? '';
$value = $body['value'] ?? '';
$ids = array_filter(array_map('intval', $body['ids'] ?? []));

if (empty($ids) || !in_array($action, ['status', 'priority', 'assign', 'archive'], true)) {
    echo json_encode(['success' => false, 'message' => 'Nothing to update.']);
    exit;
}

$pdo = enquiry_db();
$placeholders = implode(',', array_fill(0, count($ids), '?'));

if ($action === 'status') {
    if (!in_array($value, CRM_STATUSES, true)) { echo json_encode(['success' => false, 'message' => 'Invalid status.']); exit; }
    $stmt = $pdo->prepare("UPDATE enquiries SET status = ?, updated_at = ? WHERE id IN ($placeholders)");
    $stmt->execute(array_merge([$value, gmdate('c')], $ids));
    $note = "status changed to $value (bulk update)";
} elseif ($action === 'priority') {
    if (!in_array($value, CRM_PRIORITIES, true)) { echo json_encode(['success' => false, 'message' => 'Invalid priority.']); exit; }
    $stmt = $pdo->prepare("UPDATE enquiries SET priority = ?, updated_at = ? WHERE id IN ($placeholders)");
    $stmt->execute(array_merge([$value, gmdate('c')], $ids));
    $note = "priority changed to $value (bulk update)";
} elseif ($action === 'assign') {
    $stmt = $pdo->prepare("UPDATE enquiries SET assigned_to = ?, updated_at = ? WHERE id IN ($placeholders)");
    $stmt->execute(array_merge([$value, gmdate('c')], $ids));
    $note = "reassigned to $value (bulk update)";
} elseif ($action === 'archive') {
    $stmt = $pdo->prepare("UPDATE enquiries SET archived_at = ?, updated_at = ? WHERE id IN ($placeholders)");
    $stmt->execute(array_merge([gmdate('c'), gmdate('c')], $ids));
    $note = 'archived (bulk update)';
}

foreach ($ids as $id) {
    crm_log_activity($pdo, $id, admin_name(), $note);
}

echo json_encode(['success' => true, 'message' => count($ids) . ' enquiries updated.']);
