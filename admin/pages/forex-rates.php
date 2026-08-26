<?php
declare(strict_types=1);

require_permission('forex.rates.manage');

$pdo = db();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'save') {
        $code = strtoupper(trim((string) ($_POST['currency_code'] ?? '')));
        $name = trim((string) ($_POST['currency_name'] ?? ''));
        $buy = (float) ($_POST['buy_rate'] ?? 0);
        $sell = (float) ($_POST['sell_rate'] ?? 0);
        if ($code === '' || $name === '' || $buy <= 0 || $sell <= 0) {
            flash_set('admin_error', 'Currency code, name, buy rate, and sell rate are all required.');
            redirect('/admin/forex-rates/');
        }
        // Deactivate any previously active rate for this currency —
        // a new rate is a new row, never an in-place edit, so any
        // quotation created against the old rate is unaffected.
        $pdo->prepare('UPDATE forex_rates SET is_active = 0, effective_until = NOW() WHERE currency_code = :code AND is_active = 1')
            ->execute(['code' => $code]);
        $pdo->prepare(
            'INSERT INTO forex_rates (currency_code, currency_name, buy_rate, sell_rate, source, updated_by)
             VALUES (:code, :name, :buy, :sell, :source, :updated_by)'
        )->execute([
            'code' => $code, 'name' => $name, 'buy' => $buy, 'sell' => $sell,
            'source' => trim((string) ($_POST['source'] ?? '')) ?: 'Manual entry',
            'updated_by' => current_admin_id(),
        ]);
        log_action('rate_update', 'forex_rates', null, null, "$code buy=$buy sell=$sell");
        flash_set('admin_notice', "Rate for $code saved.");
        redirect('/admin/forex-rates/');
    }

    if ($postAction === 'deactivate') {
        $rateId = (int) ($_POST['rate_id'] ?? 0);
        $pdo->prepare('UPDATE forex_rates SET is_active = 0, effective_until = NOW() WHERE id = :id')->execute(['id' => $rateId]);
        log_action('rate_deactivated', 'forex_rates', $rateId);
        flash_set('admin_notice', 'Rate deactivated.');
        redirect('/admin/forex-rates/');
    }
}

$activeRates = $pdo->query("SELECT r.*, u.full_name AS updated_by_name FROM forex_rates r LEFT JOIN admin_users u ON u.id = r.updated_by WHERE r.is_active = 1 ORDER BY r.currency_code")->fetchAll();

admin_header_start('Forex Exchange Rates', 'forex-rates');
?>
<div class="admin-form-card" style="max-width:700px;margin-bottom:var(--space-6)">
    <div class="card-title">Add / Update Rate</div>
    <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Saving a new rate does not change any quotation already created — every quotation permanently snapshots the rate used at the time.</p>
    <form method="post" action="/admin/forex-rates/">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="save">
        <div class="admin-form-grid">
            <div class="form-group"><label class="form-label">Currency Code</label><input class="form-input" type="text" name="currency_code" maxlength="3" placeholder="USD" required></div>
            <div class="form-group"><label class="form-label">Currency Name</label><input class="form-input" type="text" name="currency_name" placeholder="US Dollar" required></div>
            <div class="form-group"><label class="form-label">Buy Rate (₹)</label><input class="form-input" type="number" step="0.0001" name="buy_rate" required></div>
            <div class="form-group"><label class="form-label">Sell Rate (₹)</label><input class="form-input" type="number" step="0.0001" name="sell_rate" required></div>
            <div class="form-group"><label class="form-label">Source</label><input class="form-input" type="text" name="source" placeholder="e.g. RBI reference, bank rate card"></div>
        </div>
        <button type="submit" class="btn btn-primary">Save Rate</button>
    </form>
</div>

<table class="admin-table">
    <thead><tr><th>Currency</th><th>Buy Rate</th><th>Sell Rate</th><th>Source</th><th>Updated By</th><th>Effective From</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($activeRates as $r): ?>
        <tr>
            <td><?= e($r['currency_code']) ?> — <?= e($r['currency_name']) ?></td>
            <td>₹<?= e(number_format((float) $r['buy_rate'], 4)) ?></td>
            <td>₹<?= e(number_format((float) $r['sell_rate'], 4)) ?></td>
            <td><?= e($r['source'] ?? '—') ?></td>
            <td><?= e($r['updated_by_name'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $r['effective_from']))) ?></td>
            <td class="actions">
                <form method="post" action="/admin/forex-rates/" style="display:inline" onsubmit="return confirm('Deactivate this rate?');">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="deactivate">
                    <input type="hidden" name="rate_id" value="<?= (int) $r['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Deactivate</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$activeRates): ?>
        <tr><td colspan="7"><p class="empty-state">No active rates yet. Add one above.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
