<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

crm_require_login();
$user = crm_current_user();
$pdo = db();
$scopedTypes = crm_visible_service_types($user['role_slug']);

$scopeSql = '';
$scopeParams = [];
if ($scopedTypes) {
    $scopeSql = ' AND e.service_type IN (' . implode(',', array_fill(0, count($scopedTypes), '?')) . ')';
    $scopeParams = $scopedTypes;
}

function fetch_followups(PDO $pdo, string $dateCondition, string $scopeSql, array $scopeParams): array
{
    $stmt = $pdo->prepare(
        "SELECT f.id, f.follow_up_date, f.notes, e.id AS enquiry_id, e.reference_no, e.service_type, c.name AS customer_name
         FROM followups f JOIN enquiries e ON e.id = f.enquiry_id JOIN customers c ON c.id = e.customer_id
         WHERE f.status = 'Pending' $dateCondition $scopeSql ORDER BY f.follow_up_date ASC"
    );
    $stmt->execute($scopeParams);
    return $stmt->fetchAll();
}

$overdue = fetch_followups($pdo, "AND f.follow_up_date < date('now')", $scopeSql, $scopeParams);
$today = fetch_followups($pdo, "AND f.follow_up_date = date('now')", $scopeSql, $scopeParams);
$upcoming = fetch_followups($pdo, "AND f.follow_up_date > date('now')", $scopeSql, $scopeParams);

$pageTitle = 'Follow-ups';
$crmActive = 'followups';
require __DIR__ . '/includes/layout-top.php';

function render_followup_group(string $title, array $items, string $tone): void
{
    ?>
    <div class="crm-panel">
        <h3 style="color:<?= e($tone) ?>"><?= e($title) ?> (<?= count($items) ?>)</h3>
        <div style="display:flex;flex-direction:column;gap:10px">
            <?php foreach ($items as $f): ?>
            <a href="<?= url('crm/enquiry.php?id=' . $f['enquiry_id']) ?>" style="display:flex;justify-content:space-between;align-items:center;padding:12px 14px;border:1px solid var(--border);border-radius:10px;color:inherit">
                <div>
                    <strong style="font-size:13.5px;color:var(--navy-900)"><?= e($f['customer_name']) ?></strong>
                    <span style="font-size:12.5px;color:var(--muted);margin-left:8px;text-transform:capitalize"><?= e($f['service_type']) ?> &middot; <?= e($f['reference_no']) ?></span>
                    <?php if ($f['notes']): ?><p style="margin:4px 0 0;font-size:13px;color:var(--muted)"><?= e($f['notes']) ?></p><?php endif; ?>
                </div>
                <span style="font-size:12.5px;color:var(--muted-soft);white-space:nowrap"><?= e(date('d M Y', strtotime($f['follow_up_date']))) ?></span>
            </a>
            <?php endforeach; ?>
            <?php if (!$items): ?><p style="color:var(--muted);font-size:13.5px">Nothing here.</p><?php endif; ?>
        </div>
    </div>
    <?php
}

render_followup_group('Overdue', $overdue, '#b3261e');
render_followup_group("Today's Follow-ups", $today, '#946200');
render_followup_group('Upcoming', $upcoming, 'var(--navy-900)');

require __DIR__ . '/includes/layout-bottom.php';
