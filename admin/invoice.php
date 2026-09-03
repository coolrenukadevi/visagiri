<?php
require_once __DIR__ . '/includes/admin-auth.php';
admin_require_login();
require_once __DIR__ . '/../includes/site-contact.php';

$pdo = enquiry_db();
$paymentId = (int) ($_GET['payment_id'] ?? 0);
$stmt = $pdo->prepare('SELECT p.*, e.* , p.id AS payment_id FROM payments p JOIN enquiries e ON e.id = p.enquiry_id WHERE p.id = ?');
$stmt->execute([$paymentId]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$row) {
    http_response_code(404);
    echo 'Payment not found.';
    exit;
}
if (!admin_can_view_all() && $row['assigned_to'] !== admin_name()) {
    http_response_code(403);
    echo 'You do not have access to this invoice.';
    exit;
}

$invoiceNumber = 'INV-' . str_pad((string) $row['payment_id'], 6, '0', STR_PAD_LEFT);
$quoted = (float) ($row['quoted_amount'] ?? 0);
$discount = (float) ($row['discount_amount'] ?? 0);
$paidToDate = (float) ($row['paid_amount'] ?? 0);
$balance = max(0, $quoted - $discount - $paidToDate);
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="robots" content="noindex, nofollow">
<title>Invoice <?php echo htmlspecialchars($invoiceNumber); ?></title>
<style>
    body { font-family: Arial, sans-serif; color: #101828; max-width: 720px; margin: 40px auto; padding: 0 20px; }
    .inv-header { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 3px solid #0B4DB6; padding-bottom: 20px; margin-bottom: 24px; }
    .inv-header h1 { font-size: 20px; margin: 0 0 4px; color: #062B5C; }
    .inv-header .meta { font-size: 12.5px; color: #55607A; }
    .inv-number { text-align: right; font-size: 13px; }
    .inv-number b { font-size: 16px; display: block; }
    .inv-cols { display: flex; justify-content: space-between; margin-bottom: 26px; gap: 20px; }
    .inv-col h4 { font-size: 11px; text-transform: uppercase; letter-spacing: 0.04em; color: #94A0BD; margin: 0 0 6px; }
    .inv-col div { font-size: 13.5px; line-height: 1.6; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
    th, td { text-align: left; padding: 10px 8px; border-bottom: 1px solid #E4E7EC; font-size: 13px; }
    th { color: #94A0BD; text-transform: uppercase; font-size: 10.5px; letter-spacing: 0.03em; }
    .amt { text-align: right; }
    .inv-totals { width: 320px; margin-left: auto; }
    .inv-totals div { display: flex; justify-content: space-between; padding: 6px 8px; font-size: 13.5px; }
    .inv-totals .grand { font-weight: 700; font-size: 15px; border-top: 2px solid #101828; margin-top: 6px; padding-top: 10px; }
    .inv-footer { margin-top: 40px; font-size: 11.5px; color: #94A0BD; text-align: center; }
    .print-btn { margin-bottom: 20px; }
    .print-btn button { padding: 10px 20px; border-radius: 8px; border: none; background: #0B4DB6; color: #fff; font-size: 13px; cursor: pointer; }
    @media print { .print-btn { display: none; } body { margin: 0; } }
</style>
</head>
<body>
<div class="print-btn"><button onclick="window.print()">Print / Save as PDF</button></div>

<div class="inv-header">
    <div>
        <h1>VisaAgency.in</h1>
        <div class="meta"><?php echo htmlspecialchars($site_address); ?><br><?php echo htmlspecialchars($site_phone_display); ?> &middot; <?php echo htmlspecialchars($site_email); ?></div>
    </div>
    <div class="inv-number">
        <b><?php echo htmlspecialchars($invoiceNumber); ?></b>
        Date: <?php echo htmlspecialchars(substr($row['payment_date'], 0, 10)); ?><br>
        Enquiry: <?php echo htmlspecialchars($row['enquiry_ref']); ?>
    </div>
</div>

<div class="inv-cols">
    <div class="inv-col">
        <h4>Billed To</h4>
        <div>
            <strong><?php echo htmlspecialchars($row['full_name']); ?></strong><br>
            <?php echo htmlspecialchars($row['email']); ?><br>
            <?php echo htmlspecialchars($row['mobile']); ?>
        </div>
    </div>
    <div class="inv-col">
        <h4>Service</h4>
        <div>
            <?php echo htmlspecialchars($row['destination_country']); ?> &mdash; <?php echo htmlspecialchars($row['visa_type']); ?><br>
            Travel Date: <?php echo htmlspecialchars($row['travel_date']); ?>
        </div>
    </div>
</div>

<table>
    <thead><tr><th>Description</th><th class="amt">Amount</th></tr></thead>
    <tbody>
        <tr><td><?php echo htmlspecialchars($row['visa_type']); ?> visa consultancy &amp; application support</td><td class="amt">₹<?php echo number_format($quoted, 2); ?></td></tr>
        <?php if ($discount > 0): ?>
        <tr><td>Discount</td><td class="amt">&minus;₹<?php echo number_format($discount, 2); ?></td></tr>
        <?php endif; ?>
        <tr><td>This payment (<?php echo htmlspecialchars($row['payment_method'] ?: 'Payment'); ?><?php echo $row['reference_number'] ? ', Ref: ' . htmlspecialchars($row['reference_number']) : ''; ?>)</td><td class="amt">₹<?php echo number_format((float) $row['amount'], 2); ?></td></tr>
    </tbody>
</table>

<div class="inv-totals">
    <div><span>Quoted Amount</span><span>₹<?php echo number_format($quoted, 2); ?></span></div>
    <div><span>Discount</span><span>&minus;₹<?php echo number_format($discount, 2); ?></span></div>
    <div><span>Total Paid to Date</span><span>₹<?php echo number_format($paidToDate, 2); ?></span></div>
    <div class="grand"><span>Balance Due</span><span>₹<?php echo number_format($balance, 2); ?></span></div>
</div>

<div class="inv-footer">
    Visa decisions are solely at the discretion of the relevant embassy, consulate, or immigration authority.<br>
    VisaAgency.in provides consultancy and application support only and does not guarantee approval.
</div>
</body>
</html>
