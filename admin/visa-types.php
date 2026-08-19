<?php
$ADMIN_PAGE_TITLE = 'Visa Types';
$ADMIN_ACTIVE_NAV = 'visa-types';
$ADMIN_BREADCRUMB = ['CRM', 'Visa Types'];
require __DIR__ . '/includes/layout-top.php';

$counts = [];
$stmt = $pdo->query("SELECT visa_category, COUNT(*) AS c FROM enquiries WHERE archived_at IS NULL GROUP BY visa_category");
foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
    $counts[$row['visa_category']] = (int) $row['c'];
}
$total = array_sum($counts) ?: 1;
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Visa Types</h1>
        <p class="crm-page-subtitle">Enquiry volume by visa category.</p>
    </div>
</div>

<div class="crm-card">
    <?php foreach (CRM_VISA_CATEGORIES as $cat): $c = $counts[$cat] ?? 0; ?>
    <a href="enquiries.php?visa_category=<?php echo urlencode($cat); ?>" style="display:flex;align-items:center;gap:10px;margin-bottom:12px;color:inherit;">
        <span style="width:170px;flex-shrink:0;font-size:13px;"><?php echo htmlspecialchars($cat); ?></span>
        <div style="flex:1;background:var(--c-bg);border-radius:20px;height:10px;overflow:hidden;">
            <div style="height:100%;border-radius:20px;width:<?php echo round(($c / $total) * 100); ?>%;background:var(--c-blue);"></div>
        </div>
        <span style="width:30px;text-align:right;font-weight:700;font-size:13px;"><?php echo $c; ?></span>
    </a>
    <?php endforeach; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
