<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/enquiry-db.php';
admin_require_login();

if (!in_array(admin_role(), ['Super Admin', 'Admin', 'Sales Manager'], true)) {
    http_response_code(403);
    exit('You do not have permission to view enquiry analytics.');
}

$ADMIN_PAGE_TITLE = 'Get Assistance Analytics';
$ADMIN_ACTIVE_NAV = 'enquiry-analytics';
$ADMIN_BREADCRUMB = ['CRM', 'Get Assistance Analytics'];
require __DIR__ . '/includes/layout-top.php';

$range = trim($_GET['range'] ?? '30d');
$today = gmdate('Y-m-d');
switch ($range) {
    case '7d': $from = gmdate('Y-m-d', strtotime('-7 days')); break;
    case '90d': $from = gmdate('Y-m-d', strtotime('-90 days')); break;
    default: $range = '30d'; $from = gmdate('Y-m-d', strtotime('-30 days'));
}
$dateCond = 'date(created_at) >= :from';
$params = ['from' => $from];

function ea_count(PDO $pdo, string $eventType, string $dateCond, array $params): int
{
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM enquiry_analytics_events WHERE event_type = :et AND $dateCond");
    $stmt->execute(array_merge(['et' => $eventType], $params));
    return (int) $stmt->fetchColumn();
}

$clicks = ea_count($pdo, 'get_assistance_click', $dateCond, $params);
$started = ea_count($pdo, 'form_started', $dateCond, $params);
$completed = ea_count($pdo, 'form_completed', $dateCond, $params);
$abandoned = ea_count($pdo, 'form_abandoned', $dateCond, $params);
$whatsapp = ea_count($pdo, 'whatsapp_click', $dateCond, $params);
$call = ea_count($pdo, 'call_click', $dateCond, $params);
$email = ea_count($pdo, 'email_click', $dateCond, $params);
$conversionRate = $clicks > 0 ? round(($completed / $clicks) * 100, 1) : 0.0;

$byServiceStmt = $pdo->prepare("SELECT service AS k, COUNT(*) AS c FROM enquiry_analytics_events WHERE event_type = 'service_selected' AND service != '' AND $dateCond GROUP BY service ORDER BY c DESC");
$byServiceStmt->execute($params);
$byService = $byServiceStmt->fetchAll(PDO::FETCH_ASSOC);

$byPageStmt = $pdo->prepare("SELECT page_url AS k, COUNT(*) AS c FROM enquiry_analytics_events WHERE event_type = 'get_assistance_click' AND page_url != '' AND $dateCond GROUP BY page_url ORDER BY c DESC LIMIT 10");
$byPageStmt->execute($params);
$byPage = $byPageStmt->fetchAll(PDO::FETCH_ASSOC);

function eaBarBlock(array $rows): void
{
    if (empty($rows)) { echo '<div class="crm-empty">No data in this range.</div>'; return; }
    $max = 1;
    foreach ($rows as $r) { $max = max($max, (int) $r['c']); }
    foreach ($rows as $r) {
        $label = $r['k'] ?: 'Unspecified';
        echo '<div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">';
        echo '<span style="width:220px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' . htmlspecialchars($label) . '</span>';
        echo '<div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:' . round(((int) $r['c'] / $max) * 100) . '%;background:var(--c-blue);"></div></div>';
        echo '<span style="width:30px;text-align:right;font-size:12px;font-weight:700;">' . (int) $r['c'] . '</span>';
        echo '</div>';
    }
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Get Assistance Analytics</h1>
        <p class="crm-page-subtitle">First-party event log for the header CTA, Quick Enquiry dialogue and floating contact widget. No personal data is tracked here.</p>
    </div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <a href="enquiry-analytics.php?range=7d" class="crm-btn crm-btn-sm <?php echo $range === '7d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">7 Days</a>
    <a href="enquiry-analytics.php?range=30d" class="crm-btn crm-btn-sm <?php echo $range === '30d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">30 Days</a>
    <a href="enquiry-analytics.php?range=90d" class="crm-btn crm-btn-sm <?php echo $range === '90d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">90 Days</a>
</div>

<div class="crm-kpi-grid">
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $clicks; ?></div><div class="crm-kpi-label">Get Assistance Clicks</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $started; ?></div><div class="crm-kpi-label">Forms Started</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $completed; ?></div><div class="crm-kpi-label">Enquiries Generated</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-amber);"><?php echo $abandoned; ?></div><div class="crm-kpi-label">Abandoned</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $conversionRate; ?>%</div><div class="crm-kpi-label">Click → Enquiry Rate</div></div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $whatsapp; ?></div><div class="crm-kpi-label">WhatsApp Clicks</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $call; ?></div><div class="crm-kpi-label">Call Clicks</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $email; ?></div><div class="crm-kpi-label">Email Clicks</div></div>
</div>

<div class="crm-two-col">
    <div class="crm-card"><h3>Service Selected</h3><?php eaBarBlock($byService); ?></div>
    <div class="crm-card"><h3>Get Assistance Clicks by Page</h3><?php eaBarBlock($byPage); ?></div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
