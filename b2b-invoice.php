<?php
ob_start();
$PP_PAGE_TITLE = 'Invoice Detail';
$PP_ACTIVE_NAV = 'invoices';
require __DIR__ . '/includes/partner-layout-top.php';
partner_require_permission('view_invoices');

$invoiceId = (int) ($_GET['id'] ?? 0);
$pid = partner_id();

// Tenant isolation: an invoice belonging to another partner looks
// identical to a non-existent one.
$stmt = $pdo->prepare('SELECT * FROM b2b_invoices WHERE id = ? AND partner_id = ?');
$stmt->execute([$invoiceId, $pid]);
$invoice = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$invoice) {
    http_response_code(404);
    ?>
    <div class="pp-card">Invoice not found.</div>
    <?php
    require __DIR__ . '/includes/partner-layout-bottom.php';
    exit;
}

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'pay_from_wallet' && partner_has_permission('view_payments')) {
    $paidStmt = $pdo->prepare('SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments WHERE invoice_id = ?');
    $paidStmt->execute([$invoiceId]);
    $paidToDate = (float) $paidStmt->fetchColumn();
    $balanceDue = max(0, (float) $invoice['total'] - $paidToDate);

    $walletStmt = $pdo->prepare('SELECT wallet_balance FROM b2b_partners WHERE id = ?');
    $walletStmt->execute([$pid]);
    $walletBalance = (float) $walletStmt->fetchColumn();

    if ($balanceDue <= 0) {
        $actionError = 'This invoice has no outstanding balance.';
    } elseif ($walletBalance <= 0) {
        $actionError = 'Your wallet has no available balance.';
    } else {
        $payAmount = round(min($walletBalance, $balanceDue), 2);
        b2b_wallet_record($pdo, $pid, 'Payment Applied', $payAmount, "Applied to invoice {$invoice['invoice_number']}", partner_name());
        $now = gmdate('c');
        $pdo->prepare('INSERT INTO b2b_invoice_payments (invoice_id, amount, method, remarks, recorded_by, payment_date, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)')
            ->execute([$invoiceId, $payAmount, 'Wallet Credit', 'Applied by partner from wallet balance', partner_name(), gmdate('Y-m-d'), $now]);
        $newStatus = b2b_invoice_recalc_status($pdo, $invoiceId);
        b2b_log_audit($pdo, 'invoice', $invoiceId, partner_name(), 'Partner (' . partner_role() . ')', 'Applied wallet credit to invoice', '', '₹' . number_format($payAmount, 2) . " ($newStatus)");
        b2b_notify($pdo, null, 'b2b_invoice_wallet_payment', "{$invoice['invoice_number']}: ₹" . number_format($payAmount, 2) . ' applied from wallet by ' . partner_company() . '.', $pid);
        $invoice['status'] = $newStatus;
        $actionMessage = 'Applied ₹' . number_format($payAmount, 2) . " from your wallet. Invoice is now $newStatus.";
    }
}

$paidStmt = $pdo->prepare('SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments WHERE invoice_id = ?');
$paidStmt->execute([$invoiceId]);
$paidToDate = (float) $paidStmt->fetchColumn();
$balanceDue = max(0, (float) $invoice['total'] - $paidToDate);

$paymentsStmt = $pdo->prepare('SELECT * FROM b2b_invoice_payments WHERE invoice_id = ? ORDER BY created_at DESC');
$paymentsStmt->execute([$invoiceId]);
$payments = $paymentsStmt->fetchAll(PDO::FETCH_ASSOC);

$walletBalance = (float) $ppPartner['wallet_balance'];
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title"><?php echo htmlspecialchars($invoice['invoice_number']); ?></h1>
        <p class="pp-page-subtitle"><span class="pp-status-badge <?php echo b2b_invoice_status_class($invoice['status']); ?>"><?php echo htmlspecialchars($invoice['status']); ?></span></p>
    </div>
    <a href="b2b-invoices.php" class="pp-filter-btn is-ghost">&larr; Back to Invoices</a>
</div>

<?php if ($actionMessage): ?><div class="b2b-form-error" style="background:#E7F6EC;color:#16A34A;"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="b2b-form-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="pp-card">
    <h3>Amount Breakdown</h3>
    <div class="pp-panel-grid">
        <div class="pp-panel-item"><label>Taxable Amount</label><div class="val">&#8377;<?php echo number_format((float) $invoice['taxable_amount'], 2); ?></div></div>
        <div class="pp-panel-item"><label>GST</label><div class="val">&#8377;<?php echo number_format((float) $invoice['gst'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Discount</label><div class="val">-&#8377;<?php echo number_format((float) $invoice['discount'], 2); ?></div></div>
        <div class="pp-panel-item"><label>Due Date</label><div class="val"><?php echo $invoice['due_date'] ? htmlspecialchars(substr($invoice['due_date'], 0, 10)) : '—'; ?></div></div>
    </div>
    <div class="pp-quote-total">Total: &#8377;<?php echo number_format((float) $invoice['total'], 2); ?></div>
    <div class="pp-panel-grid" style="margin-top:14px;">
        <div class="pp-panel-item"><label>Paid to Date</label><div class="val">&#8377;<?php echo number_format($paidToDate, 2); ?></div></div>
        <div class="pp-panel-item"><label>Balance Due</label><div class="val"><?php echo $balanceDue > 0 ? '&#8377;' . number_format($balanceDue, 2) : 'Fully Paid'; ?></div></div>
    </div>
    <a href="b2b-invoice-pdf.php?id=<?php echo (int) $invoice['id']; ?>" target="_blank" class="pp-filter-btn is-ghost" style="margin-top:14px;display:inline-flex;"><i class="fa-solid fa-file-pdf"></i>&nbsp; Download PDF</a>

    <?php if ($balanceDue > 0 && $walletBalance > 0): ?>
    <form method="post" style="margin-top:16px;">
        <input type="hidden" name="action" value="pay_from_wallet">
        <button type="submit" class="b2b-submit-btn" style="width:auto;padding:12px 26px;">Pay &#8377;<?php echo number_format(min($walletBalance, $balanceDue), 2); ?> from Wallet Balance</button>
    </form>
    <?php endif; ?>
</div>

<div class="pp-card">
    <h3>Payment History</h3>
    <div class="pp-table-wrap">
    <table class="pp-table">
        <thead><tr><th>Amount</th><th>Method</th><th>Date</th></tr></thead>
        <tbody>
        <?php foreach ($payments as $p): ?>
        <tr>
            <td>&#8377;<?php echo number_format((float) $p['amount'], 2); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars($p['method'] ?: '—'); ?></td>
            <td class="pp-cell-sub"><?php echo htmlspecialchars(substr((string) $p['payment_date'], 0, 10)); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$payments): ?>
        <tr><td colspan="3" class="pp-empty">No payments recorded yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
