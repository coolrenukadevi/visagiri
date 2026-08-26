<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Forex Rates';
$ADMIN_ACTIVE_NAV = 'forex-rates';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Rates'];
require __DIR__ . '/includes/layout-top.php';

if (!forex_can_manage_rates()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage forex rates.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'save_rate') {
        $currencyCode = strtoupper(trim($_POST['currency_code'] ?? ''));
        $buyRate = filter_var($_POST['buy_rate'] ?? '', FILTER_VALIDATE_FLOAT);
        $sellRate = filter_var($_POST['sell_rate'] ?? '', FILTER_VALIDATE_FLOAT);

        if ($currencyCode === '' || $buyRate === false || $sellRate === false) {
            $error = 'Please provide a currency, buy rate and sell rate.';
        } else {
            // Close out any currently-open rate row for this currency before
            // inserting the new one, so "current rate" is always a single
            // unambiguous row per currency (effective_until IS NULL).
            $now = gmdate('c');
            $pdo->prepare('UPDATE forex_rates SET effective_until = ? WHERE currency_code = ? AND effective_until IS NULL')
                ->execute([$now, $currencyCode]);
            $pdo->prepare('INSERT INTO forex_rates (currency_code, buy_rate, sell_rate, source, updated_by, effective_from) VALUES (?, ?, ?, ?, ?, ?)')
                ->execute([$currencyCode, $buyRate, $sellRate, trim($_POST['source'] ?? '') ?: 'Manual', admin_name(), $now]);
            forex_log_audit($pdo, null, admin_name(), admin_role(), "Updated $currencyCode rate", '', "Buy $buyRate / Sell $sellRate");
            header('Location: forex-rates.php');
            exit;
        }
    }
}

$currencies = forex_currencies($pdo);
$currentRates = [];
$rateStmt = $pdo->query('SELECT * FROM forex_rates WHERE effective_until IS NULL ORDER BY currency_code');
foreach ($rateStmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
    $currentRates[$r['currency_code']] = $r;
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Rates</h1>
        <p class="crm-page-subtitle">Master buy/sell rates staff reference when preparing quotations. Every quotation snapshots the rate at the time it was created — updating a rate here never changes an existing quotation.</p>
    </div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Currency</th><th>Buy Rate</th><th>Sell Rate</th><th>Source</th><th>Updated</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($currencies as $cur): $r = $currentRates[$cur] ?? null; ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($cur); ?></td>
            <td><?php echo $r ? number_format((float) $r['buy_rate'], 4) : '<span class="crm-cell-sub">Not set</span>'; ?></td>
            <td><?php echo $r ? number_format((float) $r['sell_rate'], 4) : '<span class="crm-cell-sub">Not set</span>'; ?></td>
            <td class="crm-cell-sub"><?php echo $r ? htmlspecialchars($r['source']) : '—'; ?></td>
            <td class="crm-cell-sub"><?php echo $r ? htmlspecialchars(substr($r['effective_from'], 0, 16)) . ' by ' . htmlspecialchars($r['updated_by']) : '—'; ?></td>
            <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="openRateDrawer('<?php echo htmlspecialchars($cur, ENT_QUOTES); ?>', <?php echo $r ? htmlspecialchars(json_encode($r), ENT_QUOTES) : 'null'; ?>)"><i class="fa-solid fa-pen"></i> Update</button></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmRateDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2 id="crmRateDrawerTitle">Update Rate</h2><button type="button" class="crm-drawer-close" id="crmRateDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmRateForm">
                <input type="hidden" name="action" value="save_rate">
                <div class="crm-form-section">
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Currency *</label><input type="text" name="currency_code" id="rtCurrency" readonly></div>
                        <div class="crm-form-field"><label>Source</label><input type="text" name="source" id="rtSource" placeholder="e.g. RBI reference, bank feed, manual"></div>
                        <div class="crm-form-field"><label>Buy Rate (₹ per unit) *</label><input type="number" step="0.0001" name="buy_rate" id="rtBuyRate" required></div>
                        <div class="crm-form-field"><label>Sell Rate (₹ per unit) *</label><input type="number" step="0.0001" name="sell_rate" id="rtSellRate" required></div>
                    </div>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Save Rate</button>
            </form>
        </div>
    </div>
</div>

<script>
var rateDrawer = document.getElementById('crmRateDrawer');
function openRateDrawer(currency, data) {
    data = data || {};
    document.getElementById('crmRateDrawerTitle').textContent = 'Update ' + currency + ' Rate';
    document.getElementById('rtCurrency').value = currency;
    document.getElementById('rtSource').value = data.source || '';
    document.getElementById('rtBuyRate').value = data.buy_rate || '';
    document.getElementById('rtSellRate').value = data.sell_rate || '';
    rateDrawer.hidden = false;
    requestAnimationFrame(function () { rateDrawer.classList.add('is-open', 'is-visible'); });
}
document.getElementById('crmRateDrawerClose').addEventListener('click', function () {
    rateDrawer.classList.remove('is-visible');
    setTimeout(function () { rateDrawer.classList.remove('is-open'); rateDrawer.hidden = true; }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
