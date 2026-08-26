<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
require_once __DIR__ . '/includes/forex-permissions.php';
admin_require_login();

if (!forex_can_view_all() && !forex_can_export_audit()) {
    http_response_code(403);
    exit('You do not have permission to view Forex reports.');
}

$today = gmdate('Y-m-d');
$range = trim($_GET['range'] ?? '30d');
$customFrom = trim($_GET['from'] ?? '');
$customTo = trim($_GET['to'] ?? '');
switch ($range) {
    case '7d': $from = gmdate('Y-m-d', strtotime('-7 days')); $to = $today; break;
    case '90d': $from = gmdate('Y-m-d', strtotime('-90 days')); $to = $today; break;
    case 'year': $from = gmdate('Y-01-01'); $to = $today; break;
    case 'custom': $from = $customFrom ?: gmdate('Y-m-d', strtotime('-30 days')); $to = $customTo ?: $today; break;
    default: $range = '30d'; $from = gmdate('Y-m-d', strtotime('-30 days')); $to = $today;
}
$dateCond = 'date(r.created_at) BETWEEN :from AND :to';
$dateParams = ['from' => $from, 'to' => $to];

if (($_GET['export'] ?? '') !== '') {
    $pdo = enquiry_db();
    forex_db();
    $export = $_GET['export'];

    if ($export === 'currency') {
        $stmt = $pdo->prepare("SELECT currency_code, COUNT(*) AS cnt, COALESCE(SUM(amount_required),0) AS total_fc, COALESCE(SUM(approx_inr),0) AS total_inr
            FROM forex_requests r WHERE archived_at IS NULL AND $dateCond GROUP BY currency_code ORDER BY total_inr DESC");
        $stmt->execute($dateParams);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="forex-currency-report-' . gmdate('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fputcsv($out, ['Currency', 'Requests', 'Total Foreign Currency', 'Total Approx INR']);
        foreach ($rows as $r) { fputcsv($out, [$r['currency_code'], $r['cnt'], $r['total_fc'], $r['total_inr']]); }
        fclose($out);
        exit;
    }

    if ($export === 'staff') {
        $stmt = $pdo->prepare("SELECT assigned_to AS name, COUNT(*) AS total,
                SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered
            FROM forex_requests r WHERE archived_at IS NULL AND assigned_to IS NOT NULL AND assigned_to != '' AND $dateCond
            GROUP BY assigned_to ORDER BY total DESC");
        $stmt->execute($dateParams);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="forex-staff-report-' . gmdate('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fputcsv($out, ['Employee', 'Requests Handled', 'Delivered', 'Completion Rate %']);
        foreach ($rows as $r) {
            $rate = $r['total'] > 0 ? round(($r['delivered'] / $r['total']) * 100) : 0;
            fputcsv($out, [$r['name'], $r['total'], $r['delivered'], $rate]);
        }
        fclose($out);
        exit;
    }

    if ($export === 'pending') {
        $stmt = $pdo->query("SELECT forex_ref, full_name, status, currency_code, amount_required, assigned_to, created_at,
            CAST(julianday('now') - julianday(created_at) AS INTEGER) AS days_open
            FROM forex_requests WHERE archived_at IS NULL AND status NOT IN ('Delivered','Cancelled','Rejected','Refund / Reversal')
            ORDER BY days_open DESC");
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="forex-pending-report-' . gmdate('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fputcsv($out, ['Ref', 'Customer', 'Status', 'Currency', 'Amount', 'Assigned', 'Created', 'Days Open']);
        foreach ($rows as $r) { fputcsv($out, [$r['forex_ref'], $r['full_name'], $r['status'], $r['currency_code'], $r['amount_required'], $r['assigned_to'], substr($r['created_at'], 0, 10), $r['days_open']]); }
        fclose($out);
        exit;
    }

    if ($export === 'transactions') {
        $stmt = $pdo->prepare("SELECT forex_ref, full_name, country_visit, currency_code, amount_required, approx_inr, status, assigned_to, created_at
            FROM forex_requests r WHERE archived_at IS NULL AND $dateCond ORDER BY created_at DESC");
        $stmt->execute($dateParams);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="forex-transactions-' . gmdate('Ymd-His') . '.csv"');
        $out = fopen('php://output', 'w');
        fputcsv($out, ['Ref', 'Customer', 'Country', 'Currency', 'Amount', 'Approx INR', 'Status', 'Assigned', 'Created']);
        foreach ($rows as $r) { fputcsv($out, [$r['forex_ref'], $r['full_name'], $r['country_visit'], $r['currency_code'], $r['amount_required'], $r['approx_inr'], $r['status'], $r['assigned_to'], $r['created_at']]); }
        fclose($out);
        exit;
    }
}

$ADMIN_PAGE_TITLE = 'Forex Reports';
$ADMIN_ACTIVE_NAV = 'forex-reports';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Reports'];
require __DIR__ . '/includes/layout-top.php';

// 1. Transaction summary
$totalStmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests r WHERE archived_at IS NULL AND $dateCond");
$totalStmt->execute($dateParams);
$totalInRange = (int) $totalStmt->fetchColumn();

$deliveredStmt = $pdo->prepare("SELECT COUNT(*), COALESCE(SUM(approx_inr),0) FROM forex_requests r WHERE archived_at IS NULL AND status = 'Delivered' AND $dateCond");
$deliveredStmt->execute($dateParams);
[$deliveredInRange, $deliveredInrInRange] = $deliveredStmt->fetch(PDO::FETCH_NUM);

$cancelledStmt = $pdo->prepare("SELECT COUNT(*) FROM forex_requests r WHERE archived_at IS NULL AND status IN ('Cancelled','Rejected') AND $dateCond");
$cancelledStmt->execute($dateParams);
$cancelledInRange = (int) $cancelledStmt->fetchColumn();

$conversionRate = $totalInRange > 0 ? round(($deliveredInRange / $totalInRange) * 100, 1) : 0.0;

// 2. Revenue / charges collected
$revStmt = $pdo->prepare("SELECT COALESCE(SUM(q.service_charge),0), COALESCE(SUM(q.markup),0), COALESCE(SUM(q.gst),0), COALESCE(SUM(q.total_inr),0)
    FROM forex_quotations q JOIN forex_requests r ON r.id = q.forex_request_id
    WHERE q.status IN ('Accepted') AND $dateCond");
$revStmt->execute($dateParams);
[$sumService, $sumMarkup, $sumGst, $sumQuotationTotal] = $revStmt->fetch(PDO::FETCH_NUM);

$paidStmt = $pdo->prepare("SELECT COALESCE(SUM(p.amount),0) FROM forex_payments p JOIN forex_requests r ON r.id = p.forex_request_id
    WHERE p.status = 'Paid' AND date(p.payment_date) BETWEEN :from AND :to");
$paidStmt->execute($dateParams);
$totalCollected = (float) $paidStmt->fetchColumn();

// 3. Currency-wise sales
$currencyStmt = $pdo->prepare("SELECT currency_code, COUNT(*) AS cnt, COALESCE(SUM(amount_required),0) AS total_fc, COALESCE(SUM(approx_inr),0) AS total_inr
    FROM forex_requests r WHERE archived_at IS NULL AND $dateCond GROUP BY currency_code ORDER BY total_inr DESC LIMIT 10");
$currencyStmt->execute($dateParams);
$byCurrency = $currencyStmt->fetchAll(PDO::FETCH_ASSOC);

// 4. Country-wise
$countryStmt = $pdo->prepare("SELECT country_visit AS k, COUNT(*) AS c FROM forex_requests r WHERE archived_at IS NULL AND country_visit IS NOT NULL AND country_visit != '' AND $dateCond GROUP BY country_visit ORDER BY c DESC LIMIT 10");
$countryStmt->execute($dateParams);
$byCountry = $countryStmt->fetchAll(PDO::FETCH_ASSOC);

// 5. Document verification status (current, all-time snapshot)
$docStatusStmt = $pdo->query("SELECT status AS k, COUNT(*) AS c FROM forex_documents GROUP BY status ORDER BY c DESC");
$byDocStatus = $docStatusStmt->fetchAll(PDO::FETCH_ASSOC);

// 6. Delivery turnaround (avg days from request creation to delivery, this range)
$turnaroundStmt = $pdo->prepare("SELECT AVG(julianday(d.created_at) - julianday(r.created_at)) FROM forex_deliveries d
    JOIN forex_requests r ON r.id = d.forex_request_id WHERE date(d.created_at) BETWEEN :from AND :to");
$turnaroundStmt->execute($dateParams);
$avgTurnaroundDays = (float) $turnaroundStmt->fetchColumn();

// 7. Staff performance
$staffStmt = $pdo->prepare("SELECT assigned_to AS name, COUNT(*) AS total,
        SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered
    FROM forex_requests r WHERE archived_at IS NULL AND assigned_to IS NOT NULL AND assigned_to != '' AND $dateCond
    GROUP BY assigned_to ORDER BY total DESC");
$staffStmt->execute($dateParams);
$staffPerformance = $staffStmt->fetchAll(PDO::FETCH_ASSOC);

// 8. Pending / aging open requests
$pendingStmt = $pdo->query("SELECT forex_ref, full_name, status, currency_code, amount_required, assigned_to, created_at,
    CAST(julianday('now') - julianday(created_at) AS INTEGER) AS days_open
    FROM forex_requests WHERE archived_at IS NULL AND status NOT IN ('Delivered','Cancelled','Rejected','Refund / Reversal')
    ORDER BY days_open DESC LIMIT 15");
$pendingRequests = $pendingStmt->fetchAll(PDO::FETCH_ASSOC);

function forexBarBlock(array $rows, string $color = 'var(--c-blue)'): void
{
    if (empty($rows)) { echo '<div class="crm-empty">No data in this range.</div>'; return; }
    $max = 1;
    foreach ($rows as $r) { $max = max($max, (int) $r['c']); }
    foreach ($rows as $r) {
        $label = $r['k'] ?: 'Unspecified';
        echo '<div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">';
        echo '<span style="width:150px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' . htmlspecialchars($label) . '</span>';
        echo '<div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:' . round(((int) $r['c'] / $max) * 100) . '%;background:' . $color . ';"></div></div>';
        echo '<span style="width:26px;text-align:right;font-size:12px;font-weight:700;">' . (int) $r['c'] . '</span>';
        echo '</div>';
    }
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Reports</h1>
        <p class="crm-page-subtitle">Transaction, currency, revenue, compliance and staff-performance analytics across the Forex module.</p>
    </div>
    <div class="crm-page-actions">
        <a href="forex-reports.php?export=transactions&range=<?php echo urlencode($range); ?>&from=<?php echo urlencode($from); ?>&to=<?php echo urlencode($to); ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-file-csv"></i> Export Transactions</a>
    </div>
</div>

<form class="crm-card" method="get">
    <div class="crm-filter-bar">
        <a href="forex-reports.php?range=7d" class="crm-btn crm-btn-sm <?php echo $range === '7d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">7 Days</a>
        <a href="forex-reports.php?range=30d" class="crm-btn crm-btn-sm <?php echo $range === '30d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">30 Days</a>
        <a href="forex-reports.php?range=90d" class="crm-btn crm-btn-sm <?php echo $range === '90d' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">90 Days</a>
        <a href="forex-reports.php?range=year" class="crm-btn crm-btn-sm <?php echo $range === 'year' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">This Year</a>
        <span style="color:var(--c-border);">|</span>
        <input type="hidden" name="range" value="custom">
        <input type="date" name="from" value="<?php echo htmlspecialchars($range === 'custom' ? $from : ''); ?>">
        <input type="date" name="to" value="<?php echo htmlspecialchars($range === 'custom' ? $to : ''); ?>">
        <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Custom Range</button>
    </div>
</form>

<div class="crm-kpi-grid">
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $totalInRange; ?></div><div class="crm-kpi-label">Requests in Range</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $conversionRate; ?>%</div><div class="crm-kpi-label">Delivered Rate</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value">₹<?php echo number_format($totalCollected, 2); ?></div><div class="crm-kpi-label">Payments Collected</div></div>
    <div class="crm-kpi" style="cursor:default;"><div class="crm-kpi-value"><?php echo $avgTurnaroundDays > 0 ? round($avgTurnaroundDays, 1) : '—'; ?></div><div class="crm-kpi-label">Avg. Days to Delivery</div></div>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Currency-wise Sales <a href="forex-reports.php?export=currency&range=<?php echo urlencode($range); ?>&from=<?php echo urlencode($from); ?>&to=<?php echo urlencode($to); ?>" class="crm-btn crm-btn-ghost crm-btn-sm" style="float:right;"><i class="fa-solid fa-file-csv"></i> CSV</a></h3>
        <?php if (!$byCurrency): ?><div class="crm-empty">No data in this range.</div><?php else: ?>
        <table class="crm-table">
            <thead><tr><th>Currency</th><th>Requests</th><th>Total FC</th><th>Total Approx INR</th></tr></thead>
            <tbody>
            <?php foreach ($byCurrency as $c): ?>
            <tr><td class="crm-cell-name"><?php echo htmlspecialchars($c['currency_code'] ?: '—'); ?></td><td><?php echo (int) $c['cnt']; ?></td><td><?php echo number_format((float) $c['total_fc'], 2); ?></td><td>₹<?php echo number_format((float) $c['total_inr'], 2); ?></td></tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <?php endif; ?>
    </div>
    <div class="crm-card"><h3>Requests by Destination Country</h3><?php forexBarBlock($byCountry, 'var(--c-indigo)'); ?></div>
</div>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>Document Verification Status (All Time)</h3>
        <?php forexBarBlock($byDocStatus, 'var(--c-teal)'); ?>
    </div>
    <div class="crm-card">
        <h3>Revenue / Charges Breakdown (Accepted Quotations)</h3>
        <table class="crm-table">
            <tbody>
            <tr><td>Service Charges</td><td style="text-align:right;">₹<?php echo number_format((float) $sumService, 2); ?></td></tr>
            <tr><td>Markup / Commission</td><td style="text-align:right;">₹<?php echo number_format((float) $sumMarkup, 2); ?></td></tr>
            <tr><td>GST</td><td style="text-align:right;">₹<?php echo number_format((float) $sumGst, 2); ?></td></tr>
            <tr style="font-weight:700;"><td>Total Quotation Value</td><td style="text-align:right;">₹<?php echo number_format((float) $sumQuotationTotal, 2); ?></td></tr>
            </tbody>
        </table>
    </div>
</div>

<div class="crm-card">
    <h3>Staff Performance <a href="forex-reports.php?export=staff&range=<?php echo urlencode($range); ?>&from=<?php echo urlencode($from); ?>&to=<?php echo urlencode($to); ?>" class="crm-btn crm-btn-ghost crm-btn-sm" style="float:right;"><i class="fa-solid fa-file-csv"></i> CSV</a></h3>
    <?php if (!$staffPerformance): ?><div class="crm-empty">No assigned requests in this range.</div><?php else: ?>
    <table class="crm-table">
        <thead><tr><th>Employee</th><th>Requests</th><th>Delivered</th><th>Completion Rate</th></tr></thead>
        <tbody>
        <?php foreach ($staffPerformance as $s): $rate = $s['total'] > 0 ? round(($s['delivered'] / $s['total']) * 100) : 0; ?>
        <tr><td class="crm-cell-name"><?php echo htmlspecialchars($s['name']); ?></td><td><?php echo (int) $s['total']; ?></td><td><?php echo (int) $s['delivered']; ?></td><td><?php echo $rate; ?>%</td></tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    <?php endif; ?>
</div>

<div class="crm-card">
    <h3>Pending / Aging Requests (open, all time) <a href="forex-reports.php?export=pending" class="crm-btn crm-btn-ghost crm-btn-sm" style="float:right;"><i class="fa-solid fa-file-csv"></i> CSV</a></h3>
    <?php if (!$pendingRequests): ?><div class="crm-empty">No open requests.</div><?php else: ?>
    <table class="crm-table">
        <thead><tr><th>Ref</th><th>Customer</th><th>Status</th><th>Currency</th><th>Assigned</th><th>Days Open</th></tr></thead>
        <tbody>
        <?php foreach ($pendingRequests as $p): ?>
        <tr>
            <td class="crm-cell-name"><a href="forex-request.php?ref=<?php echo urlencode($p['forex_ref']); ?>"><?php echo htmlspecialchars($p['forex_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($p['full_name']); ?></td>
            <td><span class="crm-status-badge <?php echo forex_status_class($p['status']); ?>"><?php echo htmlspecialchars($p['status']); ?></span></td>
            <td><?php echo htmlspecialchars($p['currency_code'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['assigned_to'] ?: '—'); ?></td>
            <td style="<?php echo (int) $p['days_open'] > 7 ? 'color:var(--c-red);font-weight:700;' : ''; ?>"><?php echo (int) $p['days_open']; ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
