<?php
$ADMIN_PAGE_TITLE = 'Forex Settings';
$ADMIN_ACTIVE_NAV = 'forex-settings';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Settings'];
require __DIR__ . '/includes/layout-top.php';

if (!forex_can_manage_settings()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage Forex settings.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$message = '';
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'save_general') {
        $prefix = strtoupper(trim($_POST['ref_number_prefix'] ?? 'VG-FX'));
        $serviceCharge = filter_var($_POST['default_service_charge'] ?? '0', FILTER_VALIDATE_FLOAT);
        $markup = filter_var($_POST['default_markup'] ?? '0', FILTER_VALIDATE_FLOAT);
        $gstPercent = filter_var($_POST['default_gst_percent'] ?? '0', FILTER_VALIDATE_FLOAT);
        $validityHours = filter_var($_POST['quotation_validity_hours'] ?? '24', FILTER_VALIDATE_INT);
        $threshold = filter_var($_POST['approval_threshold_inr'] ?? '200000', FILTER_VALIDATE_FLOAT);

        if ($prefix === '' || $serviceCharge === false || $markup === false || $gstPercent === false || $validityHours === false || $validityHours <= 0 || $threshold === false || $threshold < 0) {
            $error = 'Please provide valid values for all fields.';
        } else {
            $before = [
                'ref_number_prefix' => forex_setting($pdo, 'ref_number_prefix', 'VG-FX'),
                'approval_threshold_inr' => forex_setting($pdo, 'approval_threshold_inr', '200000'),
            ];
            forex_set_setting($pdo, 'ref_number_prefix', $prefix);
            forex_set_setting($pdo, 'default_service_charge', (string) $serviceCharge);
            forex_set_setting($pdo, 'default_markup', (string) $markup);
            forex_set_setting($pdo, 'default_gst_percent', (string) $gstPercent);
            forex_set_setting($pdo, 'quotation_validity_hours', (string) $validityHours);
            forex_set_setting($pdo, 'approval_threshold_inr', (string) $threshold);
            forex_log_audit($pdo, null, admin_name(), admin_role(), 'Updated Forex settings',
                'prefix=' . $before['ref_number_prefix'] . ', threshold=' . $before['approval_threshold_inr'],
                'prefix=' . $prefix . ', threshold=' . $threshold);
            $message = 'Settings updated successfully.';
        }
    } elseif ($action === 'add_currency') {
        $code = strtoupper(trim($_POST['new_currency'] ?? ''));
        if (!preg_match('/^[A-Z]{3}$/', $code)) {
            $error = 'Please enter a valid 3-letter currency code (e.g. USD).';
        } else {
            $currencies = forex_currencies($pdo);
            if (!in_array($code, $currencies, true)) {
                $currencies[] = $code;
                sort($currencies);
                forex_set_setting($pdo, 'currencies', json_encode(array_values($currencies)));
                forex_log_audit($pdo, null, admin_name(), admin_role(), 'Added Forex currency', '', $code);
            }
            $message = "Currency $code added.";
        }
    } elseif ($action === 'remove_currency') {
        $code = strtoupper(trim($_POST['currency'] ?? ''));
        $currencies = array_values(array_diff(forex_currencies($pdo), [$code]));
        forex_set_setting($pdo, 'currencies', json_encode($currencies));
        forex_log_audit($pdo, null, admin_name(), admin_role(), 'Removed Forex currency', $code, '');
        $message = "Currency $code removed.";
    } elseif ($action === 'save_sms') {
        $status = trim($_POST['sms_gateway_status'] ?? 'not_connected');
        $apiKey = trim($_POST['sms_gateway_key'] ?? '');
        forex_set_setting($pdo, 'sms_gateway_status', $status);
        forex_set_setting($pdo, 'sms_gateway_key', $apiKey);
        forex_log_audit($pdo, null, admin_name(), admin_role(), 'Updated SMS gateway setting', '', $status);
        $message = 'SMS gateway setting saved.';
    }
}

$currencies = forex_currencies($pdo);
$currentPrefix = forex_setting($pdo, 'ref_number_prefix', 'VG-FX');
$currentServiceCharge = forex_setting($pdo, 'default_service_charge', '0');
$currentMarkup = forex_setting($pdo, 'default_markup', '0');
$currentGstPercent = forex_setting($pdo, 'default_gst_percent', '0');
$currentValidityHours = forex_setting($pdo, 'quotation_validity_hours', '24');
$currentThreshold = forex_setting($pdo, 'approval_threshold_inr', '200000');
$smsStatus = forex_setting($pdo, 'sms_gateway_status', 'not_connected');
$smsKey = forex_setting($pdo, 'sms_gateway_key', '');
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Settings</h1>
        <p class="crm-page-subtitle">Currencies, charges, thresholds and delivery rules — nothing here is hard-coded, all editable by authorised Forex staff.</p>
    </div>
</div>

<?php if ($message): ?><div style="background:var(--c-green-bg);color:var(--c-green);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($message); ?></div><?php endif; ?>
<?php if ($error): ?><div style="background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:14px;"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<div class="crm-two-col">
    <div class="crm-card">
        <h3>General &amp; Charges</h3>
        <form method="post">
            <input type="hidden" name="action" value="save_general">
            <div class="crm-form-grid">
                <div class="crm-form-field"><label>Reference Number Prefix</label><input type="text" name="ref_number_prefix" value="<?php echo htmlspecialchars($currentPrefix); ?>" maxlength="12" required>
                    <small style="color:var(--c-muted);">Format: PREFIX-YEAR-000001. Existing reference numbers are never changed retroactively.</small>
                </div>
                <div class="crm-form-field"><label>Approval Threshold (₹)</label><input type="number" step="0.01" name="approval_threshold_inr" value="<?php echo htmlspecialchars($currentThreshold); ?>" required>
                    <small style="color:var(--c-muted);">Quotations above this total require a second approver before being sent.</small>
                </div>
                <div class="crm-form-field"><label>Default Service Charge (₹)</label><input type="number" step="0.01" name="default_service_charge" value="<?php echo htmlspecialchars($currentServiceCharge); ?>"></div>
                <div class="crm-form-field"><label>Default Markup (₹)</label><input type="number" step="0.01" name="default_markup" value="<?php echo htmlspecialchars($currentMarkup); ?>"></div>
                <div class="crm-form-field"><label>Default GST (%)</label><input type="number" step="0.01" name="default_gst_percent" value="<?php echo htmlspecialchars($currentGstPercent); ?>">
                    <small style="color:var(--c-muted);">Pre-fills the GST amount on new quotations against the suggested base amount; staff can adjust per quotation.</small>
                </div>
                <div class="crm-form-field"><label>Quotation Validity (hours)</label><input type="number" step="1" min="1" name="quotation_validity_hours" value="<?php echo htmlspecialchars($currentValidityHours); ?>"></div>
            </div>
            <button type="submit" class="crm-btn crm-btn-primary" style="margin-top:10px;">Save Settings</button>
        </form>
    </div>

    <div class="crm-card">
        <h3>Supported Currencies</h3>
        <div style="display:flex;flex-wrap:wrap;gap:8px;margin-bottom:14px;">
            <?php foreach ($currencies as $c): ?>
            <form method="post" style="display:inline;">
                <input type="hidden" name="action" value="remove_currency">
                <input type="hidden" name="currency" value="<?php echo htmlspecialchars($c); ?>">
                <span style="display:inline-flex;align-items:center;gap:6px;background:var(--c-bg);border:1px solid var(--c-border);border-radius:20px;padding:5px 10px 5px 14px;font-size:12.5px;">
                    <?php echo htmlspecialchars($c); ?>
                    <button type="submit" style="border:none;background:none;color:var(--c-muted);cursor:pointer;font-size:13px;" title="Remove <?php echo htmlspecialchars($c); ?>" onclick="return confirm('Remove <?php echo htmlspecialchars($c); ?> from supported currencies?');"><i class="fa-solid fa-xmark"></i></button>
                </span>
            </form>
            <?php endforeach; ?>
            <?php if (!$currencies): ?><span class="crm-empty">No currencies configured.</span><?php endif; ?>
        </div>
        <form method="post" style="display:flex;gap:8px;">
            <input type="hidden" name="action" value="add_currency">
            <input type="text" name="new_currency" placeholder="e.g. AED" maxlength="3" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;width:120px;text-transform:uppercase;" required>
            <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Add Currency</button>
        </form>
    </div>
</div>

<div class="crm-card">
    <h3>SMS Gateway</h3>
    <p class="crm-page-subtitle" style="margin-top:-4px;">No SMS gateway is connected. WhatsApp click-to-chat and email are used for customer communication today. Once a gateway is procured, its API key can be stored here — SMS sending is not simulated or faked in the meantime.</p>
    <form method="post">
        <input type="hidden" name="action" value="save_sms">
        <div class="crm-form-grid">
            <div class="crm-form-field">
                <label>Status</label>
                <select name="sms_gateway_status">
                    <option value="not_connected" <?php echo $smsStatus === 'not_connected' ? 'selected' : ''; ?>>Not Connected</option>
                    <option value="connected" <?php echo $smsStatus === 'connected' ? 'selected' : ''; ?>>Connected</option>
                </select>
            </div>
            <div class="crm-form-field"><label>Gateway API Key</label><input type="text" name="sms_gateway_key" value="<?php echo htmlspecialchars($smsKey); ?>" placeholder="Not configured" autocomplete="off"></div>
        </div>
        <button type="submit" class="crm-btn crm-btn-ghost" style="margin-top:10px;">Save</button>
    </form>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
