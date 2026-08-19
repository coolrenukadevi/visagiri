<?php
$ADMIN_PAGE_TITLE = 'Countries';
$ADMIN_ACTIVE_NAV = 'countries';
$ADMIN_BREADCRUMB = ['CRM', 'Countries'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/countries-data.php';

$counts = [];
$stmt = $pdo->query("SELECT destination_country, COUNT(*) AS c FROM enquiries WHERE archived_at IS NULL GROUP BY destination_country");
foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
    $counts[$row['destination_country']] = (int) $row['c'];
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Countries</h1>
        <p class="crm-page-subtitle">Every destination country we serve, with live enquiry counts.</p>
    </div>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Country</th><th>Region</th><th>Visa Types Offered</th><th>Enquiries</th></tr></thead>
        <tbody>
        <?php foreach ($VISA_AGENCY_COUNTRIES as $c): $n = $counts[$c['name']] ?? 0; ?>
        <tr>
            <td class="crm-cell-name"><?php echo $c['flag']; ?> <?php echo htmlspecialchars($c['name']); ?></td>
            <td><?php echo htmlspecialchars($c['region']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(implode(', ', $c['types'])); ?></td>
            <td><?php echo $n > 0 ? '<a href="enquiries.php?country=' . urlencode($c['name']) . '">' . $n . '</a>' : '<span class="crm-cell-sub">0</span>'; ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
