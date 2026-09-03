<?php
require_once __DIR__ . '/includes/forex-db.php';
$pdo = forex_db();

$page_title = "Track Your Forex Request &ndash; Visa Agency";
$page_description = "Enter your Forex Reference Number and registered Mobile Number to securely check your foreign currency purchase request status.";

$prefillRef = trim($_GET['ref'] ?? '');
$request = null;
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

        $ref = strtoupper(trim($_POST['forex_ref'] ?? ''));
        $verifyInput = trim($_POST['verify_contact'] ?? '');
        $prefillRef = $ref;

        if ($ref === '' || $verifyInput === '') {
            $verifyError = 'Please fill in all fields to track your forex request.';
        } else {
            $stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE UPPER(forex_ref) = ? AND archived_at IS NULL');
            $stmt->execute([$ref]);
            $candidate = $stmt->fetch(PDO::FETCH_ASSOC);

            $verified = false;
            if ($candidate) {
                if (strpos($verifyInput, '@') !== false) {
                    $verified = $candidate['email'] && strtolower(trim((string) $candidate['email'])) === strtolower($verifyInput);
                } else {
                    $inputDigits = substr(preg_replace('/\D/', '', $verifyInput), -10);
                    $storedDigits = substr(preg_replace('/\D/', '', (string) $candidate['mobile']), -10);
                    $verified = $inputDigits !== '' && $inputDigits === $storedDigits;
                }
            }

            if ($verified) {
                $request = $candidate;
            } else {
                $verifyError = 'We could not verify the details provided. Please check your Forex Reference Number and registered mobile/email and try again.';
            }
        }
    }
}

if ($request) {
    $docStmt = $pdo->prepare("SELECT COUNT(*) AS total, SUM(CASE WHEN status = 'Verified' THEN 1 ELSE 0 END) AS verified
        FROM forex_documents WHERE forex_request_id = ? AND stored_filename IS NOT NULL
        AND id = (SELECT MAX(id) FROM forex_documents d2 WHERE d2.forex_request_id = forex_documents.forex_request_id AND d2.doc_type = forex_documents.doc_type)");
    $docStmt->execute([$request['id']]);
    $docStats = $docStmt->fetch(PDO::FETCH_ASSOC);

    $lastUpdateStmt = $pdo->prepare('SELECT * FROM forex_status_history WHERE forex_request_id = ? ORDER BY created_at DESC LIMIT 1');
    $lastUpdateStmt->execute([$request['id']]);
    $lastUpdate = $lastUpdateStmt->fetch(PDO::FETCH_ASSOC);

    $stages = forex_timeline_stages($request['status']);
    $labels = forex_timeline_labels();
    $isCancelled = in_array($request['status'], ['Cancelled', 'Rejected'], true);
}

include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Track Your Forex Request</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Track Forex Request</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <?php if (!$request): ?>
                <div class="track-form-wrap">
                    <div class="track-form-card">
                        <h2>Track Your Forex Request</h2>
                        <p class="track-sub">Enter your Forex Reference Number and verify your identity to securely view your request status.</p>

                        <?php if ($rateLimited): ?>
                        <div class="track-alert">Too many attempts. Please wait a few minutes and try again.</div>
                        <?php elseif ($verifyError): ?>
                        <div class="track-alert"><?php echo htmlspecialchars($verifyError); ?></div>
                        <?php endif; ?>

                        <form method="post" class="track-form" novalidate>
                            <div class="track-field">
                                <label for="tfRef">Forex Reference Number *</label>
                                <input type="text" id="tfRef" name="forex_ref" placeholder="VG-FX-2026-000001" value="<?php echo htmlspecialchars($prefillRef); ?>" required>
                            </div>
                            <div class="track-field">
                                <label for="tfContact">Mobile Number OR Email Address *</label>
                                <input type="text" id="tfContact" name="verify_contact" placeholder="Registered mobile number or email" required>
                            </div>
                            <button type="submit" class="theme-btn track-submit-btn">Track Request <i class="fa-solid fa-arrow-right"></i></button>
                        </form>
                        <p class="fx-login-hint">Have more than one Forex request? <a href="forex-login">Log in with your mobile number</a> to see them all together.</p>
                    </div>
                </div>

                <?php else: ?>
                <?php include __DIR__ . '/includes/forex-track-dashboard.php'; ?>
                    <div class="track-actions">
                        <a href="forex-track" class="theme-btn style-2">Track Another Request</a>
                        <a href="contact" class="theme-btn">Contact Our Team <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
