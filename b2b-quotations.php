<?php
$PP_PAGE_TITLE = 'Quotations';
$PP_ACTIVE_NAV = 'quotations';
require __DIR__ . '/includes/partner-layout-top.php';

$pid = partner_id();

// Drafts are internal-only (not yet approved for release) and are
// deliberately excluded here — a partner should never see a quotation
// before staff has approved and sent it.
$stmt = $pdo->prepare("SELECT * FROM b2b_quotations WHERE partner_id = ? AND status != 'Draft' ORDER BY created_at DESC");
$stmt->execute([$pid]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$pendingCount = 0;
$acceptedCount = 0;
foreach ($rows as $r) {
    if ($r['status'] === 'Sent') { $pendingCount++; }
    if ($r['status'] === 'Accepted') { $acceptedCount++; }
}
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Quotations</h1>
        <p class="pp-page-subtitle">Fee quotations shared with you by our team.</p>
    </div>
</div>

<div class="pp-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo count($rows); ?></div><div class="pp-kpi-label">Total Quotations</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $pendingCount; ?></div><div class="pp-kpi-label">Awaiting Your Response</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $acceptedCount; ?></div><div class="pp-kpi-label">Accepted</div></div>
</div>

<div class="pp-card" style="padding:0;">
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Reference</th><th>Service</th><th>Destination</th><th>Total</th><th>Valid Until</th><th>Status</th></tr></thead>
        <tbody>
        <?php foreach ($rows as $r): ?>
        <tr>
            <td class="pp-cell-name"><a href="b2b-quotation.php?ref=<?php echo urlencode($r['quotation_ref']); ?>"><?php echo htmlspecialchars($r['quotation_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($r['service_category']); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($r['country']); ?> — <?php echo htmlspecialchars($r['visa_type']); ?></td>
            <td>&#8377;<?php echo number_format((float) $r['total'], 2); ?></td>
            <td class="pp-cell-sub"><?php echo $r['valid_until'] ? htmlspecialchars(substr($r['valid_until'], 0, 10)) : '—'; ?></td>
            <td><span class="pp-status-badge <?php echo b2b_quote_status_class($r['status']); ?>"><?php echo htmlspecialchars($r['status']); ?></span></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$rows): ?>
        <tr><td colspan="6" class="pp-empty">No quotations yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
