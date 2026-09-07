<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal dashboard. Phase B4/B6: real KPI cards
 * over b2b_visa_enquiries (built together since the KPI cards have
 * nothing real to count until the enquiry entity exists) plus
 * quick-action links into the enquiry flow. Quotations, invoices,
 * messaging and support tickets are still later phases (B7-B8) and
 * stay unlinked until they exist — an honest dashboard beats
 * quick-action buttons pointing at pages that don't exist.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();

$docStmt = db()->prepare('SELECT COUNT(*) FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL');
$docStmt->execute(['id' => $partner['id']]);
$documentCount = (int) $docStmt->fetchColumn();

$verifiedDocStmt = db()->prepare("SELECT COUNT(*) FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL AND verification_status = 'verified'");
$verifiedDocStmt->execute(['id' => $partner['id']]);
$verifiedDocCount = (int) $verifiedDocStmt->fetchColumn();

$enquiryCountsStmt = db()->prepare('SELECT status, COUNT(*) AS c FROM b2b_visa_enquiries WHERE b2b_partner_id = :id AND deleted_at IS NULL GROUP BY status');
$enquiryCountsStmt->execute(['id' => $partner['id']]);
$enquiryCountsRaw = $enquiryCountsStmt->fetchAll(PDO::FETCH_KEY_PAIR);
$enquiryCounts = array_merge(array_fill_keys(array_keys(B2B_ENQUIRY_STATUS_LABELS), 0), $enquiryCountsRaw);
$totalEnquiries = array_sum($enquiryCounts);

$statusBadgeMap = [
    'draft' => 'neutral', 'submitted' => 'info', 'under_review' => 'warning', 'documents_required' => 'warning',
    'verification_pending' => 'warning', 'approved' => 'success', 'active' => 'success', 'suspended' => 'danger',
    'rejected' => 'danger', 'blacklisted' => 'danger', 'closed' => 'neutral',
];

$pageTitle = 'Partner Dashboard - Visagiri B2B Travel Partner Portal';
$canonicalUrl = APP_URL . '/b2b/dashboard/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
$flashNotice = flash_get('b2b_notice');
$flashError = flash_get('b2b_error');
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:960px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Welcome, <?= e($partner['legal_business_name']) ?></h1>
            <p>Partner ID: <strong><?= e($partner['partner_reference_no']) ?></strong> &nbsp; <?= status_badge($partner['status'], $statusBadgeMap) ?></p>
        </div>

        <?php if ($flashNotice): ?><div class="alert alert-success"><?= e($flashNotice) ?></div><?php endif; ?>
        <?php if ($flashError): ?><div class="alert alert-danger"><?= e($flashError) ?></div><?php endif; ?>

        <?php if ($partner['status'] === 'draft'): ?>
        <div class="alert alert-warning">Your application isn't submitted yet. <a href="/b2b/register-declaration/">Finish registration &rarr;</a></div>
        <?php elseif (in_array($partner['status'], ['submitted', 'under_review', 'verification_pending'], true)): ?>
        <div class="alert alert-info">Your application is under review. Our B2B onboarding team will contact you if anything further is needed.</div>
        <?php elseif ($partner['status'] === 'documents_required'): ?>
        <div class="alert alert-warning">Additional documents are required before your account can be approved. <a href="/b2b/register-documents/">Upload documents &rarr;</a></div>
        <?php elseif (in_array($partner['status'], ['suspended', 'rejected', 'blacklisted', 'closed'], true)): ?>
        <div class="alert alert-danger">Your account is currently <?= e(strtolower(B2B_STATUS_LABELS[$partner['status']] ?? $partner['status'])) ?>.<?= $partner['rejection_reason'] ? ' Reason: ' . e($partner['rejection_reason']) : '' ?> Contact B2B support if you have questions.</div>
        <?php elseif ($partner['status'] === 'active'): ?>
        <div class="alert alert-success">Your partner account is active.</div>
        <?php endif; ?>

        <?php if ($partner['status'] === 'active'): ?>
        <h2 class="country-directory__subheading">Visa Enquiries</h2>
        <div class="admin-stat-grid">
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $totalEnquiries ?></div><div class="admin-stat-card__label">Total Enquiries</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['new'] ?></div><div class="admin-stat-card__label">New</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['in_progress'] ?></div><div class="admin-stat-card__label">In Progress</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['documents_pending'] ?></div><div class="admin-stat-card__label">Documents Pending</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['submitted'] ?></div><div class="admin-stat-card__label">Submitted</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['payment_pending'] ?></div><div class="admin-stat-card__label">Payment Pending</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['completed'] ?></div><div class="admin-stat-card__label">Completed</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $enquiryCounts['rejected'] ?></div><div class="admin-stat-card__label">Rejected</div></div>
        </div>
        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;margin-top:var(--space-4);margin-bottom:var(--space-5)">
            <a href="/b2b/enquiry-create/" class="btn btn-primary">+ New Visa Enquiry</a>
            <a href="/b2b/enquiries/" class="btn btn-outline">View All Enquiries</a>
        </div>
        <?php endif; ?>

        <h2 class="country-directory__subheading">Documents</h2>
        <div class="admin-stat-grid" style="margin-bottom:var(--space-5)">
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $documentCount ?></div><div class="admin-stat-card__label">Documents Uploaded</div></div>
            <div class="admin-stat-card"><div class="admin-stat-card__value"><?= $verifiedDocCount ?></div><div class="admin-stat-card__label">Documents Verified</div></div>
        </div>

        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap">
            <a href="/b2b/register-documents/" class="btn btn-outline">Manage KYC Documents</a>
            <form method="post" action="/b2b/logout/" style="display:contents"><?= csrf_field() ?><button type="submit" class="btn btn-outline">Logout</button></form>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
