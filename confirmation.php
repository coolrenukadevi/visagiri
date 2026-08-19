<?php
require_once __DIR__ . '/includes/enquiry-db.php';
require_once __DIR__ . '/includes/site-contact.php';
$pdo = enquiry_db();

$code = strtoupper(trim($_GET['code'] ?? ''));
$enquiry = null;
if ($code !== '') {
    $stmt = $pdo->prepare('SELECT * FROM enquiries WHERE UPPER(tracking_code) = ?');
    $stmt->execute([$code]);
    $enquiry = $stmt->fetch(PDO::FETCH_ASSOC);
}

if (!$enquiry) {
    http_response_code(404);
    echo 'Confirmation not found. Please check your Tracking Code link.';
    exit;
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="robots" content="noindex, nofollow">
<title>Enquiry Confirmation &ndash; <?php echo htmlspecialchars($enquiry['tracking_code']); ?></title>
<style>
    body { font-family: Arial, sans-serif; color: #1A1A1A; max-width: 680px; margin: 40px auto; padding: 0 20px; }
    .cf-header { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 3px solid #E4222A; padding-bottom: 20px; margin-bottom: 26px; }
    .cf-header h1 { font-size: 20px; margin: 0 0 4px; color: #163C99; }
    .cf-header .meta { font-size: 12.5px; color: #666; }
    .cf-code-box { background: linear-gradient(135deg, #163C99 0%, #0d2a70 100%); border-radius: 12px; padding: 18px 24px; margin-bottom: 26px; color: #fff; }
    .cf-code-box .lbl { font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; opacity: 0.8; }
    .cf-code-box .val { font-size: 22px; font-weight: 700; letter-spacing: 0.02em; }
    .cf-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px 24px; margin-bottom: 26px; }
    .cf-grid label { display: block; font-size: 10.5px; text-transform: uppercase; letter-spacing: 0.03em; color: #94A0BD; margin-bottom: 3px; }
    .cf-grid span { font-size: 14px; color: #1A1A1A; font-weight: 500; }
    .cf-note { background: #FBF0DE; color: #A9720F; font-size: 12.5px; border-radius: 8px; padding: 12px 16px; margin-bottom: 26px; }
    .cf-footer { margin-top: 40px; font-size: 11px; color: #94A0BD; text-align: center; line-height: 1.6; }
    .print-btn { margin-bottom: 20px; }
    .print-btn button { padding: 10px 20px; border-radius: 8px; border: none; background: #E4222A; color: #fff; font-size: 13px; cursor: pointer; }
    @media print { .print-btn { display: none; } body { margin: 0; } }
</style>
</head>
<body>
<div class="print-btn"><button onclick="window.print()">Print / Save as PDF</button></div>

<div class="cf-header">
    <div>
        <h1>VisaAgency.in</h1>
        <div class="meta"><?php echo htmlspecialchars($site_address); ?><br><?php echo htmlspecialchars($site_phone_display); ?> &middot; <?php echo htmlspecialchars($site_email); ?></div>
    </div>
    <div class="meta" style="text-align:right;">
        Submitted<br><?php echo htmlspecialchars(substr($enquiry['created_at'], 0, 16)); ?> UTC
    </div>
</div>

<div class="cf-code-box">
    <div class="lbl">Tracking Code</div>
    <div class="val"><?php echo htmlspecialchars($enquiry['tracking_code']); ?></div>
</div>

<div class="cf-grid">
    <div><label>Applicant Name</label><span><?php echo htmlspecialchars($enquiry['full_name']); ?></span></div>
    <div><label>Passport Number</label><span><?php echo htmlspecialchars(crm_mask_passport($enquiry['passport_number'])); ?></span></div>
    <div><label>Mobile Number</label><span><?php echo htmlspecialchars(crm_mask_mobile($enquiry['mobile'])); ?></span></div>
    <div><label>Email Address</label><span><?php echo htmlspecialchars(crm_mask_email($enquiry['email'])); ?></span></div>
    <div><label>Visa Country</label><span><?php echo htmlspecialchars($enquiry['destination_country']); ?></span></div>
    <div><label>Visa Type</label><span><?php echo htmlspecialchars($enquiry['visa_type']); ?></span></div>
</div>

<div class="cf-note">
    <strong>Please save your Tracking Code.</strong> You will need it, along with your passport number and registered mobile number or email address, to check your application status at
    <?php echo (($_SERVER['HTTPS'] ?? '') === 'on' ? 'https://' : 'http://') . ($_SERVER['HTTP_HOST'] ?? 'visaagency.in'); ?>/track-application.
</div>

<div class="cf-footer">
    Visa decisions are solely at the discretion of the relevant embassy, consulate, or immigration authority.<br>
    VisaAgency.in provides consultancy and application support only and does not guarantee approval.
</div>
</body>
</html>
