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

$pendingQuoteStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_quotations WHERE partner_id = ? AND status = 'Sent'");
$pendingQuoteStmt->execute([$pid]);
$pendingQuoteCount = (int) $pendingQuoteStmt->fetchColumn();

$outstandingInvStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_invoices i WHERE i.partner_id = ? AND i.status IN ('Issued','Partially Paid','Overdue')");
$outstandingInvStmt->execute([$pid]);
$outstandingInvCount = (int) $outstandingInvStmt->fetchColumn();

$managerName = '';
if ($ppPartner['assigned_manager_id']) {
    $mstmt = $pdo->prepare('SELECT name FROM users WHERE id = ?');
    $mstmt->execute([$ppPartner['assigned_manager_id']]);
    $managerName = (string) $mstmt->fetchColumn();
}

$docExpiryPlaceholders = implode(',', array_fill(0, count(B2B_DOC_TYPES_WITH_EXPIRY), '?'));
$docExpiryStmt = $pdo->prepare("SELECT doc_type, expiry_date, status FROM b2b_partner_documents
    WHERE partner_id = ? AND doc_type IN ($docExpiryPlaceholders) AND expiry_date IS NOT NULL AND expiry_date != ''
    AND (status = 'Expired' OR (status = 'Verified' AND expiry_date <= ?)) ORDER BY expiry_date ASC");
$docExpiryStmt->execute(array_merge([$pid], B2B_DOC_TYPES_WITH_EXPIRY, [gmdate('Y-m-d', strtotime('+30 days'))]));
$expiringDocs = $docExpiryStmt->fetchAll(PDO::FETCH_ASSOC);

$announceStmt = $pdo->prepare("SELECT * FROM b2b_announcements
    WHERE (expires_at IS NULL OR expires_at > ?)
    AND (target_type = 'All'
        OR (target_type = 'Tier' AND target_value = ?)
        OR (target_type = 'Country' AND target_value = ?)
        OR (target_type = 'Partner' AND target_value = ?))
    ORDER BY published_at DESC");
$announceStmt->execute([gmdate('c'), (string) $ppPartner['tier'], (string) $ppPartner['country'], (string) $pid]);
$announcements = $announceStmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Welcome back, <?php echo htmlspecialchars(explode(' ', partner_name())[0]); ?></h1>
        <p class="pp-page-subtitle"><?php echo htmlspecialchars($ppPartner['company_name']); ?> &middot; <span class="pp-status-chip"><?php echo htmlspecialchars($ppPartner['status']); ?></span></p>
    </div>
</div>

<?php if ($announcements): ?>
<div class="pp-announce-list">
    <?php foreach ($announcements as $an): ?>
    <div class="pp-announce">
        <i class="fa-solid fa-bullhorn"></i>
        <div>
            <strong><?php echo htmlspecialchars($an['title']); ?></strong>
            <p><?php echo nl2br(htmlspecialchars($an['body'])); ?></p>
        </div>
    </div>
    <?php endforeach; ?>
</div>
<?php endif; ?>

<?php if ($expiringDocs): ?>
<div class="pp-doc-alert">
    <i class="fa-solid fa-triangle-exclamation"></i>
    <div>
        <strong>Document action needed</strong>
        <ul>
        <?php foreach ($expiringDocs as $ed): ?>
            <li><?php echo htmlspecialchars(B2B_DOC_TYPES[$ed['doc_type']] ?? $ed['doc_type']); ?> —
                <?php echo $ed['status'] === 'Expired' ? 'expired' : 'expires'; ?> on <?php echo htmlspecialchars(substr($ed['expiry_date'], 0, 10)); ?></li>
        <?php endforeach; ?>
        </ul>
        <p>Please contact your Relationship Manager to arrange a renewed copy.</p>
    </div>
</div>
<?php endif; ?>

<div class="pp-kpi-grid">
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-passport"></i></div>
        <div class="pp-kpi-value"><?php echo $visaCaseCount; ?></div>
        <div class="pp-kpi-label">Total Visa Cases</div>
    </div>
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-file-invoice-dollar"></i></div>
        <div class="pp-kpi-value"><?php echo $pendingQuoteCount; ?></div>
        <div class="pp-kpi-label">Pending Quotations</div>
    </div>
    <div class="pp-kpi">
        <div class="pp-kpi-icon"><i class="fa-solid fa-file-invoice"></i></div>
        <div class="pp-kpi-value"><?php echo $outstandingInvCount; ?></div>
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
        <?php if (partner_has_permission('create_application')): ?>
        <a href="b2b-new-application.php" class="b2b-submit-btn" style="text-decoration:none;margin-bottom:10px;">Submit New Visa Application</a>
        <?php endif; ?>
        <?php if (partner_has_permission('view_applications')): ?>
        <a href="b2b-applications.php" class="pp-filter-btn is-ghost" style="width:100%;justify-content:center;">View My Applications</a>
        <?php endif; ?>
        <?php if (!partner_has_permission('create_application') && !partner_has_permission('view_applications')): ?>
        <p class="pp-empty-note">Your account does not currently have access to visa applications. Contact your account Owner to request access.</p>
        <?php endif; ?>
        <a href="b2b-messages.php" class="pp-filter-btn is-ghost" style="width:100%;justify-content:center;margin-top:10px;">Messages</a>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
