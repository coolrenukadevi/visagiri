<?php
$PP_PAGE_TITLE = 'Dashboard';
$PP_ACTIVE_NAV = 'dashboard';
require __DIR__ . '/includes/partner-layout-top.php';

// Every query on every partner-portal page must be scoped to the logged-in
// partner's own id — this is the tenant-isolation pattern every later
// partner-facing page (applications, quotations, invoices, ...) follows.
$pid = partner_id();

$visaCaseStmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE partner_id = ?');
$visaCaseStmt->execute([$pid]);
$visaCaseCount = (int) $visaCaseStmt->fetchColumn();

$managerName = '';
if ($ppPartner['assigned_manager_id']) {
    $mstmt = $pdo->prepare('SELECT name FROM users WHERE id = ?');
    $mstmt->execute([$ppPartner['assigned_manager_id']]);
    $managerName = (string) $mstmt->fetchColumn();
}
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Welcome back, <?php echo htmlspecialchars(explode(' ', partner_name())[0]); ?></h1>
        <p class="pp-page-subtitle"><?php echo htmlspecialchars($ppPartner['company_name']); ?> &middot; <span class="pp-status-chip"><?php echo htmlspecialchars($ppPartner['status']); ?></span></p>
    </div>
</div>

<div class="pp-kpi-grid">
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-passport"></i></div>
        <div class="pp-kpi-value"><?php echo $visaCaseCount; ?></div>
        <div class="pp-kpi-label">Total Visa Cases</div>
    </div>
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-file-invoice-dollar"></i></div>
        <div class="pp-kpi-value">0</div>
        <div class="pp-kpi-label">Pending Quotations</div>
    </div>
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-file-invoice"></i></div>
        <div class="pp-kpi-value">0</div>
        <div class="pp-kpi-label">Outstanding Invoices</div>
    </div>
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-wallet"></i></div>
        <div class="pp-kpi-value">&#8377;<?php echo number_format((float) $ppPartner['wallet_balance'], 2); ?></div>
        <div class="pp-kpi-label">Wallet Balance</div>
    </div>
</div>

<div class="pp-grid-2">
    <div class="pp-card">
        <h3>Account Overview</h3>
        <div class="pp-panel-grid">
            <div class="pp-panel-item"><label>Partner ID</label><div class="val"><?php echo htmlspecialchars($ppPartner['application_ref']); ?></div></div>
            <div class="pp-panel-item"><label>Status</label><div class="val"><span class="pp-status-chip"><?php echo htmlspecialchars($ppPartner['status']); ?></span></div></div>
            <div class="pp-panel-item"><label>Tier</label><div class="val"><?php echo htmlspecialchars($ppPartner['tier'] ?: 'Not yet assigned'); ?></div></div>
            <div class="pp-panel-item"><label>Credit Limit</label><div class="val">&#8377;<?php echo number_format((float) $ppPartner['credit_limit'], 2); ?></div></div>
            <div class="pp-panel-item"><label>Relationship Manager</label><div class="val"><?php echo $managerName ? htmlspecialchars($managerName) : 'Not yet assigned'; ?></div></div>
            <div class="pp-panel-item"><label>Approved On</label><div class="val"><?php echo $ppPartner['approved_at'] ? htmlspecialchars(substr($ppPartner['approved_at'], 0, 10)) : '—'; ?></div></div>
        </div>
    </div>
    <div class="pp-card">
        <h3>Quick Actions</h3>
        <p class="pp-empty-note">Submitting new visa applications, quotations, invoices and team management are coming in the next phases of the B2B Partner Portal. Your Relationship Manager can assist with these in the meantime.</p>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
