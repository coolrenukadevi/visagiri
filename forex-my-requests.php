<?php
require_once __DIR__ . '/includes/forex-customer-auth.php';
forex_customer_require_login();

$pdo = forex_db();
$stmt = $pdo->prepare("SELECT * FROM forex_requests WHERE substr(mobile, -10) = ? AND archived_at IS NULL ORDER BY created_at DESC");
$stmt->execute([forex_customer_mobile()]);
$requests = $stmt->fetchAll(PDO::FETCH_ASSOC);

$page_title = "My Forex Requests &ndash; Visa Agency";
$page_description = "View the status, quotations and documents for every Forex request you've submitted.";
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">My Forex Requests</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>My Forex Requests</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="fx-portal-header">
                    <div>
                        <h2>Welcome back, <?php echo htmlspecialchars(forex_customer_name()); ?></h2>
                        <p class="track-sub">Everything you've submitted, in one place.</p>
                    </div>
                    <div class="fx-portal-header-actions">
                        <a href="forex-enquiry" class="theme-btn style-2">New Forex Enquiry</a>
                        <a href="forex-logout" class="fx-login-link-btn">Log Out</a>
                    </div>
                </div>

                <?php if (!$requests): ?>
                <div class="track-form-card fx-portal-empty">
                    <p>We couldn't find any Forex requests under this mobile number yet.</p>
                    <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <?php else: ?>
                <div class="fx-portal-grid">
                    <?php foreach ($requests as $r): ?>
                    <a href="forex-my-request?ref=<?php echo urlencode($r['forex_ref']); ?>" class="fx-portal-card">
                        <div class="fx-portal-card-top">
                            <span class="fx-portal-ref"><?php echo htmlspecialchars($r['forex_ref']); ?></span>
                            <span class="track-status-badge"><?php echo htmlspecialchars($r['status']); ?></span>
                        </div>
                        <div class="fx-portal-card-body">
                            <span class="fx-portal-service"><?php echo htmlspecialchars($r['service_type'] ?: 'Forex Request'); ?></span>
                            <span class="fx-portal-meta"><?php echo htmlspecialchars($r['currency_code']); ?> <?php echo number_format((float) $r['amount_required'], 2); ?> &middot; <?php echo htmlspecialchars($r['country_visit'] ?: '—'); ?></span>
                        </div>
                        <div class="fx-portal-card-footer">
                            <span>Submitted <?php echo htmlspecialchars(substr($r['created_at'], 0, 10)); ?></span>
                            <span class="fx-portal-card-arrow"><i class="fa-solid fa-arrow-right"></i></span>
                        </div>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
