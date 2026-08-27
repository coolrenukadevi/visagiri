<?php
ob_start();
$PP_PAGE_TITLE = 'Application Detail';
$PP_ACTIVE_NAV = 'applications';
require __DIR__ . '/includes/partner-layout-top.php';

$ref = trim($_GET['ref'] ?? '');

// Tenant isolation: the partner_id = ? clause is what stops Partner A from
// viewing Partner B's case by guessing/incrementing a reference in the URL —
// a non-matching row looks identical to a non-existent one (404 either way).
$stmt = $pdo->prepare('SELECT * FROM enquiries WHERE enquiry_ref = ? AND partner_id = ? AND archived_at IS NULL');
$stmt->execute([$ref, partner_id()]);
$enquiry = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$enquiry) {
    http_response_code(404);
    $PP_PAGE_TITLE = 'Not Found';
    ?>
    <div class="pp-card">Application not found.</div>
    <?php
    require __DIR__ . '/includes/partner-layout-bottom.php';
    exit;
}

$docStmt = $pdo->prepare('SELECT COUNT(*) AS total, SUM(CASE WHEN status = "Verified" THEN 1 ELSE 0 END) AS verified FROM enquiry_documents WHERE enquiry_id = ?');
$docStmt->execute([$enquiry['id']]);
$docStats = $docStmt->fetch(PDO::FETCH_ASSOC);

// Only status_updates is ever shown to a partner — its `message` column is
// deliberately written as customer-safe copy (see crm_log_status_change()
// callers). The `enquiry_notes` and `activities` tables carry unredacted
// internal detail and must never be queried on a partner-facing page.
$updatesStmt = $pdo->prepare('SELECT * FROM status_updates WHERE enquiry_id = ? ORDER BY created_at DESC');
$updatesStmt->execute([$enquiry['id']]);
$updates = $updatesStmt->fetchAll(PDO::FETCH_ASSOC);

$stages = crm_timeline_stages($enquiry['status']);
$labels = crm_timeline_labels();
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title"><?php echo htmlspecialchars($enquiry['full_name']); ?></h1>
        <p class="pp-page-subtitle"><?php echo htmlspecialchars($enquiry['enquiry_ref']); ?> &middot; <span class="pp-status-badge <?php echo crm_status_class($enquiry['status']); ?>"><?php echo htmlspecialchars($enquiry['status']); ?></span></p>
    </div>
    <a href="b2b-applications.php" class="pp-filter-btn is-ghost">&larr; Back to Applications</a>
</div>

<div class="pp-card">
    <h3>Application Overview</h3>
    <div class="pp-panel-grid">
        <div class="pp-panel-item"><label>Destination</label><div class="val"><?php echo htmlspecialchars($enquiry['destination_country']); ?></div></div>
        <div class="pp-panel-item"><label>Visa Type</label><div class="val"><?php echo htmlspecialchars($enquiry['visa_type']); ?></div></div>
        <div class="pp-panel-item"><label>Category</label><div class="val"><?php echo htmlspecialchars($enquiry['visa_category']); ?></div></div>
        <div class="pp-panel-item"><label>Travellers</label><div class="val"><?php echo (int) $enquiry['travellers']; ?></div></div>
        <div class="pp-panel-item"><label>Travel Date</label><div class="val"><?php echo htmlspecialchars(substr((string) $enquiry['travel_date'], 0, 10)); ?></div></div>
        <div class="pp-panel-item"><label>Submitted</label><div class="val"><?php echo htmlspecialchars(substr($enquiry['created_at'], 0, 10)); ?></div></div>
        <div class="pp-panel-item"><label>Traveller Email</label><div class="val"><?php echo htmlspecialchars($enquiry['email']); ?></div></div>
        <div class="pp-panel-item"><label>Traveller Mobile</label><div class="val"><?php echo htmlspecialchars($enquiry['mobile']); ?></div></div>
    </div>
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

<div class="pp-card">
    <h3>Status Updates</h3>
    <?php if ($updates): ?>
    <div class="pp-updates-list">
        <?php foreach ($updates as $u): ?>
        <div class="pp-update-item">
            <div class="pp-update-status"><?php echo htmlspecialchars($u['new_status']); ?></div>
            <?php if ($u['message']): ?><div class="pp-update-message"><?php echo htmlspecialchars($u['message']); ?></div><?php endif; ?>
            <div class="pp-update-meta"><?php echo htmlspecialchars(substr($u['created_at'], 0, 16)); ?></div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php else: ?>
    <p class="pp-empty-note">No updates yet.</p>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
