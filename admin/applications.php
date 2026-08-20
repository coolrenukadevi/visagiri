<?php
$ADMIN_PAGE_TITLE = 'Visa Applications';
$ADMIN_ACTIVE_NAV = 'applications';
$ADMIN_BREADCRUMB = ['CRM', 'Visa Applications'];
require __DIR__ . '/includes/layout-top.php';

$decisionFilter = trim($_GET['decision'] ?? '');
$paymentFilter = trim($_GET['payment_status'] ?? '');
$scopeSql = admin_can_view_all() ? '' : ' AND assigned_to = :me';
$scopeParams = admin_can_view_all() ? [] : ['me' => admin_name()];

$sql = "SELECT * FROM enquiries WHERE archived_at IS NULL
    AND (status IN ('Application Preparation','Application Submitted','Under Embassy Processing','Additional Documents Required','Decision Received','Visa Approved','Visa Refused','Passport Ready','Completed') OR application_number IS NOT NULL AND application_number != '')
    $scopeSql";
$params = $scopeParams;
if ($decisionFilter !== '') {
    $sql .= " AND COALESCE(decision, 'Pending') = :decision";
    $params['decision'] = $decisionFilter;
}
$sql .= ' ORDER BY COALESCE(appointment_date, travel_date) ASC';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$applications = $stmt->fetchAll(PDO::FETCH_ASSOC);

$counts = ['Pending' => 0, 'Approved' => 0, 'Rejected' => 0];
$unpaidCount = 0;
foreach ($applications as $a) {
    $counts[$a['decision'] ?: 'Pending']++;
    if (crm_payment_status($a)['label'] !== 'Paid') { $unpaidCount++; }
}

if ($paymentFilter !== '') {
    $applications = array_values(array_filter($applications, fn($a) => crm_payment_status($a)['label'] === $paymentFilter));
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Visa Applications</h1>
        <p class="crm-page-subtitle">Every enquiry that has progressed into application processing, with appointment, submission and decision tracking.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(4,1fr);">
    <a href="applications.php?decision=Pending" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-amber);"><?php echo $counts['Pending']; ?></div><div class="crm-kpi-label">Decision Pending</div></a>
    <a href="applications.php?decision=Approved" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $counts['Approved']; ?></div><div class="crm-kpi-label">Approved</div></a>
    <a href="applications.php?decision=Rejected" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-red);"><?php echo $counts['Rejected']; ?></div><div class="crm-kpi-label">Rejected</div></a>
    <a href="applications.php?payment_status=Payment%20Pending" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-red);"><?php echo $unpaidCount; ?></div><div class="crm-kpi-label">Not Fully Paid</div></a>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <a href="applications.php" class="crm-btn crm-btn-sm <?php echo $paymentFilter === '' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">All Payments</a>
    <?php foreach (CRM_PAYMENT_STATUSES as $ps): ?>
    <a href="applications.php?payment_status=<?php echo urlencode($ps); ?>" class="crm-btn crm-btn-sm <?php echo $paymentFilter === $ps ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo $ps; ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <?php if (empty($applications)): ?>
    <div class="crm-empty">No enquiries match these filters.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Enquiry</th><th>Customer</th><th>Country</th><th>Application #</th><th>Appointment</th><th>Submitted</th><th>Decision Date</th><th>Status</th><th>Payment</th><th>Decision</th></tr></thead>
        <tbody>
        <?php foreach ($applications as $a): $decision = $a['decision'] ?: 'Pending'; $appPayment = crm_payment_status($a); ?>
        <tr>
            <td><a href="enquiry.php?ref=<?php echo urlencode($a['enquiry_ref']); ?>"><?php echo htmlspecialchars($a['enquiry_ref']); ?></a></td>
            <td class="crm-cell-name"><?php echo htmlspecialchars($a['full_name']); ?></td>
            <td><?php echo htmlspecialchars($a['destination_country']); ?></td>
            <td><?php echo htmlspecialchars($a['application_number'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($a['appointment_date'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($a['submission_date'] ?: '—'); ?></td>
            <td><?php echo htmlspecialchars($a['decision_date'] ?: '—'); ?></td>
            <td><span class="crm-status-badge <?php echo crm_status_class($a['status']); ?>"><?php echo htmlspecialchars($a['status']); ?></span></td>
            <td><span class="crm-payment-badge <?php echo $appPayment['class']; ?>"><?php echo htmlspecialchars($appPayment['label']); ?></span></td>
            <td><span class="crm-doc-status doc-<?php echo strtolower($decision === 'Pending' ? 'uploaded' : ($decision === 'Approved' ? 'verified' : 'rejected')); ?>"><?php echo $decision; ?></span></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
