<?php
require_once __DIR__ . '/includes/enquiry-db.php';
$pdo = enquiry_db();

$page_title = "Track Your Visa Application &ndash; Visa Agency";
$page_description = "Enter your Tracking Code, Passport Number and registered Mobile Number or Email Address to securely check your visa application status.";

$prefillCode = trim($_GET['code'] ?? '');
$enquiry = null;
$verifyError = '';
$rateLimited = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ip = $_SERVER['REMOTE_ADDR'] ?? '';
    $rateStmt = $pdo->prepare('SELECT COUNT(*) FROM tracking_attempts WHERE ip_address = ? AND created_at > ?');
    $rateStmt->execute([$ip, gmdate('c', time() - 900)]);
    if ((int) $rateStmt->fetchColumn() >= 10) {
        $rateLimited = true;
    } else {
        $pdo->prepare('INSERT INTO tracking_attempts (ip_address, created_at) VALUES (?, ?)')->execute([$ip, gmdate('c')]);

        $trackingCode = strtoupper(trim($_POST['tracking_code'] ?? ''));
        $passportInput = strtoupper(trim($_POST['passport_number'] ?? ''));
        $verifyInput = trim($_POST['verify_contact'] ?? '');
        $prefillCode = $trackingCode;

        if ($trackingCode === '' || $passportInput === '' || $verifyInput === '') {
            $verifyError = 'Please fill in all fields to track your application.';
        } else {
            $stmt = $pdo->prepare('SELECT * FROM enquiries WHERE UPPER(tracking_code) = ? AND archived_at IS NULL');
            $stmt->execute([$trackingCode]);
            $candidate = $stmt->fetch(PDO::FETCH_ASSOC);

            $verified = false;
            if ($candidate && strtoupper(trim((string) $candidate['passport_number'])) === $passportInput) {
                if (strpos($verifyInput, '@') !== false) {
                    $verified = strtolower(trim((string) $candidate['email'])) === strtolower($verifyInput);
                } else {
                    $inputDigits = substr(preg_replace('/\D/', '', $verifyInput), -10);
                    $storedDigits = substr(preg_replace('/\D/', '', (string) $candidate['mobile']), -10);
                    $verified = $inputDigits !== '' && $inputDigits === $storedDigits;
                }
            }

            if ($verified) {
                $enquiry = $candidate;
            } else {
                $verifyError = 'We could not verify the details provided. Please check your Tracking Code and verification details and try again.';
            }
        }
    }
}

if ($enquiry) {
    $docStmt = $pdo->prepare('SELECT COUNT(*) AS total, SUM(CASE WHEN status = "Verified" THEN 1 ELSE 0 END) AS verified FROM enquiry_documents WHERE enquiry_id = ?');
    $docStmt->execute([$enquiry['id']]);
    $docStats = $docStmt->fetch(PDO::FETCH_ASSOC);

    $lastUpdateStmt = $pdo->prepare('SELECT * FROM status_updates WHERE enquiry_id = ? ORDER BY created_at DESC LIMIT 1');
    $lastUpdateStmt->execute([$enquiry['id']]);
    $lastUpdate = $lastUpdateStmt->fetch(PDO::FETCH_ASSOC);

    $stages = crm_timeline_stages($enquiry['status']);
    $labels = crm_timeline_labels();
    $isCancelled = $enquiry['status'] === 'Cancelled';
    $paymentStatus = crm_payment_status($enquiry);
}

include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Track Your Visa Application</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Track Application</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <?php if (!$enquiry): ?>
                <div class="track-form-wrap">
                    <div class="track-form-card">
                        <h2>Track Your Visa Application</h2>
                        <p class="track-sub">Enter your Tracking Code and verify your identity to securely view your application status.</p>

                        <?php if ($rateLimited): ?>
                        <div class="track-alert">Too many attempts. Please wait a few minutes and try again.</div>
                        <?php elseif ($verifyError): ?>
                        <div class="track-alert"><?php echo htmlspecialchars($verifyError); ?></div>
                        <?php endif; ?>

                        <form method="post" class="track-form" novalidate>
                            <div class="track-field">
                                <label for="tfCode">Tracking Code *</label>
                                <input type="text" id="tfCode" name="tracking_code" placeholder="VISA-2026-8F4K29" value="<?php echo htmlspecialchars($prefillCode); ?>" required>
                            </div>
                            <div class="track-field">
                                <label for="tfPassport">Passport Number *</label>
                                <input type="text" id="tfPassport" name="passport_number" placeholder="e.g. N1234567" required style="text-transform:uppercase;">
                            </div>
                            <div class="track-field">
                                <label for="tfContact">Mobile Number OR Email Address *</label>
                                <input type="text" id="tfContact" name="verify_contact" placeholder="Registered mobile number or email" required>
                            </div>
                            <button type="submit" class="theme-btn track-submit-btn">Track Application <i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                    </div>
                </div>

                <?php else: ?>
                <div class="track-dashboard">
                    <div class="track-dash-header">
                        <span class="td-label">Tracking Code</span>
                        <span class="td-code"><?php echo htmlspecialchars($enquiry['tracking_code']); ?></span>
                    </div>

                    <?php if ($isCancelled): ?>
                    <div class="track-cancelled-banner"><i class="fa-solid fa-circle-info"></i> This application has been cancelled. Please contact our team if you have questions.</div>
                    <?php endif; ?>

                    <div class="track-overview-card">
                        <h3>Application Overview</h3>
                        <div class="track-overview-grid">
                            <div><label>Applicant Name</label><span><?php echo htmlspecialchars($enquiry['full_name']); ?></span></div>
                            <div><label>Passport Number</label><span><?php echo htmlspecialchars(crm_mask_passport($enquiry['passport_number'])); ?></span></div>
                            <div><label>Country</label><span><?php echo htmlspecialchars($enquiry['destination_country']); ?></span></div>
                            <div><label>Visa Type</label><span><?php echo htmlspecialchars($enquiry['visa_type']); ?></span></div>
                            <div><label>Application Date</label><span><?php echo htmlspecialchars(substr($enquiry['created_at'], 0, 10)); ?></span></div>
                            <div><label>Current Status</label><span class="track-status-badge"><?php echo htmlspecialchars($enquiry['status']); ?></span></div>
                            <div><label>Assigned Consultant</label><span><?php echo htmlspecialchars($enquiry['visa_consultant'] ?: $enquiry['assigned_to'] ?: 'Not yet assigned'); ?></span></div>
                            <div><label>Payment Status</label><span class="track-status-badge" style="color:<?php echo $paymentStatus['label'] === 'Paid' ? '#16A34A' : ($paymentStatus['label'] === 'Not Quoted' ? 'var(--theme-2)' : '#C0392B'); ?> !important;"><?php echo htmlspecialchars($paymentStatus['label']); ?></span></div>
                            <?php if ($paymentStatus['label'] !== 'Not Quoted' && $paymentStatus['label'] !== 'Paid'): ?>
                            <div><label>Balance Due</label><span>₹<?php echo number_format($paymentStatus['balance'], 2); ?></span></div>
                            <?php endif; ?>
                            <div><label>Last Updated</label><span><?php echo $lastUpdate ? htmlspecialchars(substr($lastUpdate['created_at'], 0, 16)) . ' UTC' : htmlspecialchars(substr($enquiry['created_at'], 0, 16)) . ' UTC'; ?></span></div>
                        </div>
                        <?php if ($lastUpdate && !empty($lastUpdate['message'])): ?>
                        <div class="track-latest-message"><i class="fa-solid fa-message"></i> <?php echo htmlspecialchars($lastUpdate['message']); ?></div>
                        <?php endif; ?>
                    </div>

                    <div class="track-timeline-card">
                        <h3>Application Timeline</h3>
                        <div class="track-timeline">
                            <?php foreach ($labels as $i => $label): $state = $stages[$i]; ?>
                            <div class="track-tl-step tl-<?php echo $state; ?>">
                                <div class="tl-dot">
                                    <?php if ($state === 'done'): ?><i class="fa-solid fa-check"></i>
                                    <?php elseif ($state === 'current'): ?><i class="fa-solid fa-spinner"></i>
                                    <?php elseif ($state === 'na'): ?><i class="fa-solid fa-minus"></i>
                                    <?php endif; ?>
                                </div>
                                <div class="tl-info">
                                    <span class="tl-label"><?php echo htmlspecialchars($label); ?></span>
                                    <span class="tl-state"><?php echo $state === 'done' ? 'Completed' : ($state === 'current' ? 'In Progress' : ($state === 'na' ? 'Not Applicable' : 'Pending')); ?></span>
                                </div>
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <div class="track-docs-card">
                        <h3>Documents</h3>
                        <p><?php echo (int) ($docStats['verified'] ?? 0); ?> of <?php echo (int) ($docStats['total'] ?? 0); ?> documents verified.</p>
                    </div>

                    <div class="track-actions">
                        <a href="track-application" class="theme-btn style-2">Track Another Application</a>
                        <a href="contact" class="theme-btn">Contact Our Team <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
