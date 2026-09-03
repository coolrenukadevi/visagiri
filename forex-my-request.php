<?php
require_once __DIR__ . '/includes/forex-customer-auth.php';
forex_customer_require_login();

$pdo = forex_db();
$ref = strtoupper(trim($_GET['ref'] ?? ''));

$stmt = $pdo->prepare("SELECT * FROM forex_requests WHERE UPPER(forex_ref) = ? AND substr(mobile, -10) = ? AND archived_at IS NULL");
$stmt->execute([$ref, forex_customer_mobile()]);
$request = $stmt->fetch(PDO::FETCH_ASSOC);

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

$page_title = ($request ? htmlspecialchars($request['forex_ref']) . ' &ndash; ' : '') . "My Forex Requests &ndash; Visa Agency";
$page_description = "Status, timeline and documents for your Forex request.";
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Forex Request</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex-my-requests">My Forex Requests</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo $request ? htmlspecialchars($request['forex_ref']) : 'Not Found'; ?></li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <?php if (!$request): ?>
                <div class="track-form-card fx-portal-empty">
                    <p>We couldn't find that Forex request under your account, or it's no longer available.</p>
                    <a href="forex-my-requests" class="theme-btn">Back to My Requests <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <?php else: ?>
                <?php include __DIR__ . '/includes/forex-track-dashboard.php'; ?>
                    <div class="track-actions">
                        <a href="forex-my-requests" class="theme-btn style-2">Back to My Requests</a>
                        <?php if ($request['upload_token']): ?>
                        <a href="forex-documents?ref=<?php echo urlencode($request['forex_ref']); ?>&token=<?php echo urlencode($request['upload_token']); ?>" class="theme-btn">Manage Documents <i class="fa-solid fa-arrow-right"></i></a>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endif; ?>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
