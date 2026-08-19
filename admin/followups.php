<?php
$ADMIN_PAGE_TITLE = 'Follow-ups';
$ADMIN_ACTIVE_NAV = 'followups';
$ADMIN_BREADCRUMB = ['CRM', 'Follow-ups'];
require __DIR__ . '/includes/layout-top.php';

$filter = trim($_GET['state'] ?? '');
$scopeSql = admin_can_view_all() ? '' : ' AND e.assigned_to = :me';
$scopeParams = admin_can_view_all() ? [] : ['me' => admin_name()];

$sql = "SELECT f.*, e.enquiry_ref, e.full_name, e.destination_country, e.status AS enquiry_status
    FROM follow_ups f JOIN enquiries e ON e.id = f.enquiry_id
    WHERE e.archived_at IS NULL $scopeSql ORDER BY f.follow_up_date ASC, f.id ASC";
$stmt = $pdo->prepare($sql);
$stmt->execute($scopeParams);
$all = $stmt->fetchAll(PDO::FETCH_ASSOC);

$counts = ['Overdue' => 0, 'Due Today' => 0, 'Upcoming' => 0, 'Completed' => 0];
$rows = [];
foreach ($all as $fu) {
    $state = crm_followup_state($fu['follow_up_date'], $fu['completed_at']);
    $counts[$state]++;
    if ($filter === '' || $filter === $state) { $rows[] = array_merge($fu, ['state' => $state]); }
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Follow-ups</h1>
        <p class="crm-page-subtitle">Every scheduled follow-up across your enquiries, in one place.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr);">
    <a href="followups.php?state=Overdue" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-red);"><?php echo $counts['Overdue']; ?></div><div class="crm-kpi-label">Overdue</div></a>
    <a href="followups.php?state=Due Today" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-amber);"><?php echo $counts['Due Today']; ?></div><div class="crm-kpi-label">Due Today</div></a>
    <a href="followups.php?state=Upcoming" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-blue);"><?php echo $counts['Upcoming']; ?></div><div class="crm-kpi-label">Upcoming</div></a>
    <a href="followups.php?state=Completed" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $counts['Completed']; ?></div><div class="crm-kpi-label">Completed</div></a>
</div>

<div class="crm-card" style="padding:0;">
    <?php if (empty($rows)): ?>
    <div class="crm-empty">No follow-ups<?php echo $filter ? ' in "' . htmlspecialchars($filter) . '"' : ''; ?>.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Date</th><th>Time</th><th>Type</th><th>Customer</th><th>Enquiry</th><th>Notes</th><th>State</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($rows as $fu): ?>
        <tr>
            <td><?php echo htmlspecialchars($fu['follow_up_date']); ?></td>
            <td><?php echo htmlspecialchars($fu['follow_up_time'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($fu['type']); ?></td>
            <td class="crm-cell-name"><?php echo htmlspecialchars($fu['full_name']); ?></td>
            <td><a href="enquiry.php?ref=<?php echo urlencode($fu['enquiry_ref']); ?>#followup"><?php echo htmlspecialchars($fu['enquiry_ref']); ?></a></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($fu['notes'] ?: '—'); ?></td>
            <td><span class="crm-fu-state state-<?php echo strtolower(str_replace(' ', '-', $fu['state'])); ?>"><?php echo $fu['state']; ?></span></td>
            <td>
                <?php if ($fu['state'] !== 'Completed'): ?>
                <form method="post" action="enquiry.php?ref=<?php echo urlencode($fu['enquiry_ref']); ?>">
                    <input type="hidden" name="action" value="complete_followup">
                    <input type="hidden" name="followup_id" value="<?php echo (int) $fu['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Mark Done</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
