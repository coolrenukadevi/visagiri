<?php
ob_start();
$ADMIN_PAGE_TITLE = 'B2B Quotations';
$ADMIN_ACTIVE_NAV = 'b2b-quotations';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Quotations'];
require __DIR__ . '/includes/layout-top.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $quotationId = (int) ($_POST['quotation_id'] ?? 0);

    if ($action === 'send_quotation' && b2b_can_approve_quotation() && $quotationId) {
        // Two separate fetches, deliberately not a `SELECT q.*, p.*` join —
        // b2b_quotations and b2b_partners both have `id`/`status` columns,
        // and PDO::FETCH_ASSOC silently collapses same-named columns to
        // whichever table was selected last, which would make
        // $quotation['status'] read the partner's status instead of the
        // quotation's.
        $qStmt = $pdo->prepare('SELECT * FROM b2b_quotations WHERE id = ?');
        $qStmt->execute([$quotationId]);
        $quotation = $qStmt->fetch(PDO::FETCH_ASSOC);
        if ($quotation && $quotation['status'] === 'Draft') {
            $partnerStmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ?');
            $partnerStmt->execute([$quotation['partner_id']]);
            $quotePartner = $partnerStmt->fetch(PDO::FETCH_ASSOC);

            $pdo->prepare("UPDATE b2b_quotations SET status = 'Sent' WHERE id = ?")->execute([$quotationId]);
            b2b_log_audit($pdo, 'quotation', $quotationId, admin_name(), admin_role(), 'Approved and sent quotation', 'Draft', 'Sent');
            if ($quotePartner) {
                b2b_notify_partner(
                    $pdo, $quotePartner, "New Quotation Ready — {$quotation['quotation_ref']}",
                    "Dear {$quotePartner['contact_name']},\n\nA new quotation is ready for your review.\n\nReference: {$quotation['quotation_ref']}\nService: {$quotation['service_category']}\nDestination: {$quotation['country']}\nTotal: ₹" . number_format((float) $quotation['total'], 2) . "\n\nPlease log in to your Partner Portal to accept, reject or request a revision.\n\nRegards,\nVisaAgency.in B2B Partner Team"
                );
            }
        }
    }
    header('Location: b2b-quotations.php' . (isset($_GET['status']) ? '?status=' . urlencode($_GET['status']) : ''));
    exit;
}

$statusFilter = trim($_GET['status'] ?? '');
$where = '1=1';
$params = [];
if ($statusFilter !== '' && in_array($statusFilter, B2B_QUOTATION_STATUSES, true)) {
    $where = 'q.status = :status';
    $params['status'] = $statusFilter;
}
$stmt = $pdo->prepare("SELECT q.*, p.application_ref, p.company_name FROM b2b_quotations q JOIN b2b_partners p ON p.id = q.partner_id WHERE $where ORDER BY q.created_at DESC LIMIT 300");
$stmt->execute($params);
$quotations = $stmt->fetchAll(PDO::FETCH_ASSOC);

$draftCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_quotations WHERE status = 'Draft'")->fetchColumn();
$sentCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_quotations WHERE status = 'Sent'")->fetchColumn();
$acceptedCount = (int) $pdo->query("SELECT COUNT(*) FROM b2b_quotations WHERE status = 'Accepted'")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">B2B Quotations</h1>
        <p class="crm-page-subtitle">Every quotation snapshots its own fee breakdown at creation — later changes never retroactively affect it.</p>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $draftCount; ?></div><div class="crm-kpi-label">Awaiting Approval</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $sentCount; ?></div><div class="crm-kpi-label">Sent</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $acceptedCount; ?></div><div class="crm-kpi-label">Accepted</div></div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <?php foreach (['' => 'All'] + array_combine(B2B_QUOTATION_STATUSES, B2B_QUOTATION_STATUSES) as $val => $label): ?>
    <a href="b2b-quotations.php<?php echo $val !== '' ? '?status=' . urlencode($val) : ''; ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $val ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo htmlspecialchars($label); ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Reference</th><th>Partner</th><th>Service</th><th>Destination</th><th>Total</th><th>Status</th><th>Created</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($quotations as $q): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($q['application_ref']); ?>&tab=quotations"><?php echo htmlspecialchars($q['quotation_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($q['company_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($q['service_category']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($q['country']); ?></td>
            <td>₹<?php echo number_format((float) $q['total'], 2); ?></td>
            <td><span class="crm-status-badge <?php echo b2b_quote_status_class($q['status']); ?>"><?php echo htmlspecialchars($q['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($q['created_at'], 0, 10)); ?></td>
            <td>
                <a href="b2b-quotation-pdf.php?id=<?php echo (int) $q['id']; ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-pdf"></i></a>
                <?php if ($q['status'] === 'Draft' && b2b_can_approve_quotation()): ?>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="send_quotation">
                    <input type="hidden" name="quotation_id" value="<?php echo (int) $q['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Approve</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$quotations): ?>
        <tr><td colspan="8" class="crm-empty">No quotations match this filter.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
