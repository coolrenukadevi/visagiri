<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Partner Reports';
$ADMIN_ACTIVE_NAV = 'b2b-reports';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Reports'];
require __DIR__ . '/includes/layout-top.php';

[$scopeSql, $scopeParams] = b2b_scope_sql();
$baseScope = 'archived_at IS NULL' . $scopeSql;
$canViewFinancials = b2b_can_view_financials();

function b2bBarBlock(array $rows): void
{
    if (empty($rows)) { echo '<div class="crm-empty">No data yet.</div>'; return; }
    $max = 1;
    foreach ($rows as $r) { $max = max($max, (int) $r['c']); }
    foreach ($rows as $r) {
        $label = $r['k'] !== '' && $r['k'] !== null ? $r['k'] : 'Unspecified';
        echo '<div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">';
        echo '<span style="width:190px;flex-shrink:0;font-size:12.5px;color:var(--c-text);overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' . htmlspecialchars($label) . '</span>';
        echo '<div style="flex:1;background:var(--c-bg);border-radius:20px;height:9px;overflow:hidden;"><div style="height:100%;border-radius:20px;width:' . round(((int) $r['c'] / $max) * 100) . '%;background:var(--c-blue);"></div></div>';
        echo '<span style="width:34px;text-align:right;font-size:12px;font-weight:700;">' . (int) $r['c'] . '</span>';
        echo '</div>';
    }
}

// ---- KPIs ----
$totalPartners = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partners WHERE $baseScope")->fetchColumn();
$approvedPartners = (int) $pdo->query("SELECT COUNT(*) FROM b2b_partners WHERE status = 'Approved' AND $baseScope")->fetchColumn();
$totalCases = (int) $pdo->query("SELECT COUNT(*) FROM enquiries e JOIN b2b_partners p ON p.id = e.partner_id WHERE p.$baseScope")->fetchColumn();
$totalQuotationsSent = (int) $pdo->query("SELECT COUNT(*) FROM b2b_quotations q JOIN b2b_partners p ON p.id = q.partner_id WHERE q.status != 'Draft' AND p.$baseScope")->fetchColumn();
$totalQuotationsAccepted = (int) $pdo->query("SELECT COUNT(*) FROM b2b_quotations q JOIN b2b_partners p ON p.id = q.partner_id WHERE q.status = 'Accepted' AND p.$baseScope")->fetchColumn();
$conversionRate = $totalQuotationsSent > 0 ? round(($totalQuotationsAccepted / $totalQuotationsSent) * 100, 1) : 0;
$totalRevenue = $canViewFinancials
    ? (float) $pdo->query("SELECT COALESCE(SUM(ip.amount), 0) FROM b2b_invoice_payments ip JOIN b2b_invoices i ON i.id = ip.invoice_id JOIN b2b_partners p ON p.id = i.partner_id WHERE p.$baseScope")->fetchColumn()
    : 0;

// ---- Bar chart data ----
$byStatus = $pdo->query("SELECT status AS k, COUNT(*) AS c FROM b2b_partners WHERE $baseScope GROUP BY status ORDER BY c DESC")->fetchAll(PDO::FETCH_ASSOC);
$byTier = $pdo->query("SELECT COALESCE(NULLIF(tier, ''), 'Unassigned') AS k, COUNT(*) AS c FROM b2b_partners WHERE $baseScope GROUP BY k ORDER BY c DESC")->fetchAll(PDO::FETCH_ASSOC);
$byCountry = $pdo->query("SELECT country AS k, COUNT(*) AS c FROM b2b_partners WHERE $baseScope GROUP BY country ORDER BY c DESC LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);
$topByCases = $pdo->query("SELECT p.company_name AS k, COUNT(e.id) AS c FROM b2b_partners p JOIN enquiries e ON e.partner_id = p.id WHERE p.$baseScope GROUP BY p.id ORDER BY c DESC LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);

$topByRevenue = [];
if ($canViewFinancials) {
    $topByRevenue = $pdo->query("SELECT p.application_ref, p.company_name, COALESCE(SUM(ip.amount), 0) AS revenue
        FROM b2b_partners p
        JOIN b2b_invoices i ON i.partner_id = p.id
        JOIN b2b_invoice_payments ip ON ip.invoice_id = i.id
        WHERE p.$baseScope
        GROUP BY p.id ORDER BY revenue DESC LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Partner Reports</h1>
        <p class="crm-page-subtitle">Aggregate B2B partner performance<?php echo b2b_can_view_all() ? '' : ' for partners assigned to you'; ?>.</p>
    </div>
    <div>
        <a href="b2b-export.php?type=partners" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i> Export Partners CSV</a>
        <a href="b2b-export.php?type=performance" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-download"></i> Export Performance CSV</a>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(<?php echo $canViewFinancials ? 6 : 5; ?>,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalPartners; ?></div><div class="crm-kpi-label">Total Partners</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $approvedPartners; ?></div><div class="crm-kpi-label">Approved Partners</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalCases; ?></div><div class="crm-kpi-label">Visa Cases via B2B</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalQuotationsSent; ?></div><div class="crm-kpi-label">Quotations Sent</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $conversionRate; ?>%</div><div class="crm-kpi-label">Quotation Conversion</div></div>
    <?php if ($canViewFinancials): ?>
    <div class="crm-kpi"><div class="crm-kpi-value">₹<?php echo number_format($totalRevenue, 0); ?></div><div class="crm-kpi-label">Revenue Collected</div></div>
    <?php endif; ?>
</div>

<div class="crm-grid-2" style="display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-top:18px;">
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Partners by Status</h3>
        <?php b2bBarBlock($byStatus); ?>
    </div>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Partners by Tier</h3>
        <?php b2bBarBlock($byTier); ?>
    </div>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Partners by Country (Top 10)</h3>
        <?php b2bBarBlock($byCountry); ?>
    </div>
    <div class="crm-card">
        <h3 style="margin:0 0 14px;font-size:14px;">Top Partners by Visa Case Volume</h3>
        <?php b2bBarBlock($topByCases); ?>
    </div>
</div>

<?php if ($canViewFinancials): ?>
<div class="crm-card" style="margin-top:18px;padding:0;">
    <h3 style="margin:0;padding:22px 22px 14px;font-size:14px;">Top Partners by Revenue Collected</h3>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Partner</th><th>Revenue Collected</th></tr></thead>
        <tbody>
        <?php foreach ($topByRevenue as $r): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($r['application_ref']); ?>"><?php echo htmlspecialchars($r['company_name']); ?></a></td>
            <td>₹<?php echo number_format((float) $r['revenue'], 2); ?></td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$topByRevenue): ?>
        <tr><td colspan="2" class="crm-empty">No payments recorded yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>
<?php endif; ?>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
