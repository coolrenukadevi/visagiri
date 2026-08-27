<?php
ob_start();
$PP_PAGE_TITLE = 'Reports';
$PP_ACTIVE_NAV = 'reports';
require __DIR__ . '/includes/partner-layout-top.php';

$pid = partner_id();

function ppBarBlock(array $rows): void
{
    if (empty($rows)) { echo '<p class="pp-empty-note">No data yet.</p>'; return; }
    $max = 1;
    foreach ($rows as $r) { $max = max($max, (int) $r['c']); }
    foreach ($rows as $r) {
        $label = $r['k'] !== '' && $r['k'] !== null ? $r['k'] : 'Unspecified';
        echo '<div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">';
        echo '<span style="width:150px;flex-shrink:0;font-size:12.5px;color:var(--text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' . htmlspecialchars($label) . '</span>';
        echo '<div style="flex:1;background:var(--bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:' . round(((int) $r['c'] / $max) * 100) . '%;background:var(--theme);"></div></div>';
        echo '<span style="width:30px;text-align:right;font-size:12px;font-weight:700;">' . (int) $r['c'] . '</span>';
        echo '</div>';
    }
}

$stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE partner_id = ?');
$stmt->execute([$pid]);
$totalCases = (int) $stmt->fetchColumn();

$byStatusStmt = $pdo->prepare("SELECT status AS k, COUNT(*) AS c FROM enquiries WHERE partner_id = ? GROUP BY status ORDER BY c DESC");
$byStatusStmt->execute([$pid]);
$casesByStatus = $byStatusStmt->fetchAll(PDO::FETCH_ASSOC);

$quotesSentStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_quotations WHERE partner_id = ? AND status != 'Draft'");
$quotesSentStmt->execute([$pid]);
$quotesSent = (int) $quotesSentStmt->fetchColumn();

$quotesAcceptedStmt = $pdo->prepare("SELECT COUNT(*) FROM b2b_quotations WHERE partner_id = ? AND status = 'Accepted'");
$quotesAcceptedStmt->execute([$pid]);
$quotesAccepted = (int) $quotesAcceptedStmt->fetchColumn();
$conversionRate = $quotesSent > 0 ? round(($quotesAccepted / $quotesSent) * 100, 1) : 0;

$invoicesOutstandingStmt = $pdo->prepare("SELECT COUNT(*), COALESCE(SUM(total), 0) FROM b2b_invoices WHERE partner_id = ? AND status IN ('Issued','Partially Paid','Overdue')");
$invoicesOutstandingStmt->execute([$pid]);
[$invoicesOutstandingCount, $invoicesOutstandingTotal] = $invoicesOutstandingStmt->fetch(PDO::FETCH_NUM);

$invoicesPaidStmt = $pdo->prepare("SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments ip JOIN b2b_invoices i ON i.id = ip.invoice_id WHERE i.partner_id = ?");
$invoicesPaidStmt->execute([$pid]);
$totalPaid = (float) $invoicesPaidStmt->fetchColumn();

$monthlyStmt = $pdo->prepare("SELECT strftime('%Y-%m', created_at) AS k, COUNT(*) AS c FROM enquiries WHERE partner_id = ? GROUP BY k ORDER BY k DESC LIMIT 6");
$monthlyStmt->execute([$pid]);
$monthlyVolume = array_reverse($monthlyStmt->fetchAll(PDO::FETCH_ASSOC));
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">Reports</h1>
        <p class="pp-page-subtitle">Your account's visa case, quotation and invoice performance.</p>
    </div>
    <div>
        <a href="b2b-export-partner.php" class="pp-filter-btn is-ghost"><i class="fa-solid fa-download"></i> Export My Cases (CSV)</a>
    </div>
</div>

<div class="pp-kpi-grid">
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $totalCases; ?></div><div class="pp-kpi-label">Total Visa Cases</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value"><?php echo $conversionRate; ?>%</div><div class="pp-kpi-label">Quotation Conversion</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format((float) $invoicesOutstandingTotal, 2); ?></div><div class="pp-kpi-label">Outstanding (<?php echo (int) $invoicesOutstandingCount; ?>)</div></div>
    <div class="pp-kpi"><div class="pp-kpi-value">&#8377;<?php echo number_format($totalPaid, 2); ?></div><div class="pp-kpi-label">Total Paid</div></div>
</div>

<div class="pp-grid-2">
    <div class="pp-card">
        <h3>Visa Cases by Status</h3>
        <?php ppBarBlock($casesByStatus); ?>
    </div>
    <div class="pp-card">
        <h3>Case Volume — Last 6 Months</h3>
        <?php ppBarBlock($monthlyVolume); ?>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
