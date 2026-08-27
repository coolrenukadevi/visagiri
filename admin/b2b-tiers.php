<?php
$ADMIN_PAGE_TITLE = 'Tiers & Pricing';
$ADMIN_ACTIVE_NAV = 'b2b-tiers';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Tiers & Pricing'];
require __DIR__ . '/includes/layout-top.php';

if (!b2b_can_manage_tiers_pricing()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage B2B tiers and pricing.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'save_tier') {
        $tierId = (int) ($_POST['tier_id'] ?? 0);
        $name = trim($_POST['name'] ?? '');
        $creditLimit = filter_var($_POST['default_credit_limit'] ?? '', FILTER_VALIDATE_FLOAT);
        $discount = filter_var($_POST['default_discount_percent'] ?? '', FILTER_VALIDATE_FLOAT);
        $slaHours = filter_var($_POST['sla_hours'] ?? '', FILTER_VALIDATE_INT);
        $prioritySupport = !empty($_POST['priority_support']) ? 1 : 0;
        $isActive = !empty($_POST['is_active']) ? 1 : 0;

        if ($name === '' || $creditLimit === false || $discount === false || $slaHours === false) {
            $actionError = 'Please provide valid values for every tier field.';
        } elseif ($tierId) {
            $pdo->prepare('UPDATE b2b_tiers SET name = ?, default_credit_limit = ?, default_discount_percent = ?, sla_hours = ?, priority_support = ?, is_active = ? WHERE id = ?')
                ->execute([$name, $creditLimit, $discount, $slaHours, $prioritySupport, $isActive, $tierId]);
            b2b_log_audit($pdo, 'tier', $tierId, admin_name(), admin_role(), 'Updated tier', '', "$name — {$discount}% discount, {$slaHours}h SLA");
            $actionMessage = "Tier \"$name\" updated.";
        } else {
            $pdo->prepare('INSERT INTO b2b_tiers (name, default_credit_limit, default_discount_percent, sla_hours, priority_support, is_active) VALUES (?, ?, ?, ?, ?, ?)')
                ->execute([$name, $creditLimit, $discount, $slaHours, $prioritySupport, $isActive]);
            $newTierId = (int) $pdo->lastInsertId();
            b2b_log_audit($pdo, 'tier', $newTierId, admin_name(), admin_role(), 'Created tier', '', "$name — {$discount}% discount, {$slaHours}h SLA");
            $actionMessage = "Tier \"$name\" created.";
        }
    } elseif ($action === 'save_pricing_rule') {
        $tierId = filter_var($_POST['tier_id'] ?? '', FILTER_VALIDATE_INT) ?: null;
        $partnerId = filter_var($_POST['partner_id'] ?? '', FILTER_VALIDATE_INT) ?: null;
        $serviceCategory = trim($_POST['service_category'] ?? '');
        $basePrice = filter_var($_POST['base_price'] ?? '', FILTER_VALIDATE_FLOAT);
        $partnerPrice = filter_var($_POST['partner_price'] ?? '', FILTER_VALIDATE_FLOAT);
        $markupAllowed = !empty($_POST['markup_allowed']) ? 1 : 0;

        if ((!$tierId && !$partnerId) || !in_array($serviceCategory, B2B_SERVICES_OFFERED, true) || $basePrice === false || $partnerPrice === false) {
            $actionError = 'Please select a tier or partner, a valid service category, and valid prices.';
        } else {
            $pdo->prepare('INSERT INTO b2b_pricing_rules (partner_id, tier_id, service_category, base_price, partner_price, markup_allowed, effective_from, created_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
                ->execute([$partnerId, $tierId, $serviceCategory, $basePrice, $partnerPrice, $markupAllowed, gmdate('c'), admin_name(), gmdate('c')]);
            $ruleId = (int) $pdo->lastInsertId();
            b2b_log_audit($pdo, 'pricing_rule', $ruleId, admin_name(), admin_role(), 'Created pricing rule', '', "$serviceCategory — partner price ₹$partnerPrice");
            $actionMessage = 'Pricing rule saved.';
        }
    } elseif ($action === 'delete_pricing_rule') {
        $ruleId = (int) ($_POST['rule_id'] ?? 0);
        $pdo->prepare('DELETE FROM b2b_pricing_rules WHERE id = ?')->execute([$ruleId]);
        b2b_log_audit($pdo, 'pricing_rule', $ruleId, admin_name(), admin_role(), 'Deleted pricing rule');
        $actionMessage = 'Pricing rule removed.';
    }
}

$tiers = $pdo->query('SELECT * FROM b2b_tiers ORDER BY default_credit_limit ASC')->fetchAll(PDO::FETCH_ASSOC);
$pricingRules = $pdo->query("SELECT pr.*, t.name AS tier_name, p.company_name
    FROM b2b_pricing_rules pr LEFT JOIN b2b_tiers t ON t.id = pr.tier_id LEFT JOIN b2b_partners p ON p.id = pr.partner_id
    ORDER BY pr.created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
$partners = $pdo->query("SELECT id, company_name, application_ref FROM b2b_partners WHERE archived_at IS NULL ORDER BY company_name")->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Tiers &amp; Pricing</h1>
        <p class="crm-page-subtitle">Partner tiers set default credit/SLA; pricing rules drive quotation-builder suggestions. Internal base price is never shown to partners.</p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="crm-alert crm-alert-success"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="crm-alert crm-alert-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="crm-card">
    <h3 style="margin:0 0 14px;font-size:14px;">Tiers</h3>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Name</th><th>Default Credit Limit</th><th>Default Discount</th><th>SLA (hours)</th><th>Priority Support</th><th>Active</th></tr></thead>
        <tbody>
        <?php foreach ($tiers as $t): ?>
        <tr>
            <form method="post">
            <input type="hidden" name="action" value="save_tier">
            <input type="hidden" name="tier_id" value="<?php echo (int) $t['id']; ?>">
            <td class="crm-cell-name"><input type="text" name="name" value="<?php echo htmlspecialchars($t['name']); ?>" style="border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;width:110px;"></td>
            <td>₹<input type="number" name="default_credit_limit" value="<?php echo (float) $t['default_credit_limit']; ?>" step="0.01" min="0" style="border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;width:110px;"></td>
            <td><input type="number" name="default_discount_percent" value="<?php echo (float) $t['default_discount_percent']; ?>" step="0.1" min="0" max="100" style="border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;width:70px;">%</td>
            <td><input type="number" name="sla_hours" value="<?php echo (int) $t['sla_hours']; ?>" min="1" style="border:1px solid var(--c-border);border-radius:6px;padding:5px 8px;width:70px;"></td>
            <td><input type="checkbox" name="priority_support" value="1" <?php echo $t['priority_support'] ? 'checked' : ''; ?>></td>
            <td><input type="checkbox" name="is_active" value="1" <?php echo $t['is_active'] ? 'checked' : ''; ?>></td>
            <td><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Save</button></td>
            </form>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>

    <details style="margin-top:14px;">
        <summary style="cursor:pointer;font-size:12.5px;font-weight:600;color:var(--c-blue);">+ Add a new tier</summary>
        <form method="post" class="crm-panel-grid" style="margin-top:12px;">
            <input type="hidden" name="action" value="save_tier">
            <input type="hidden" name="tier_id" value="0">
            <div class="crm-panel-item"><label>Name</label><input type="text" name="name" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item"><label>Default Credit Limit (₹)</label><input type="number" name="default_credit_limit" value="0" step="0.01" min="0" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item"><label>Default Discount (%)</label><input type="number" name="default_discount_percent" value="0" step="0.1" min="0" max="100" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item"><label>SLA (hours)</label><input type="number" name="sla_hours" value="48" min="1" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
            <div class="crm-panel-item"><label><input type="checkbox" name="priority_support" value="1"> Priority Support</label></div>
            <div class="crm-panel-item"><label><input type="checkbox" name="is_active" value="1" checked> Active</label></div>
            <div class="crm-panel-item full"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Add Tier</button></div>
        </form>
    </details>
</div>

<div class="crm-card">
    <h3 style="margin:0 0 14px;font-size:14px;">New Pricing Rule</h3>
    <p class="crm-cell-sub" style="margin:-6px 0 12px;">Applies to a tier (every partner on that tier) or one specific partner (overrides the tier default for them). Base Price is your internal cost — it is never shown to any partner.</p>
    <form method="post" class="crm-panel-grid">
        <input type="hidden" name="action" value="save_pricing_rule">
        <div class="crm-panel-item">
            <label>Applies To</label>
            <select name="tier_id" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <option value="">— Select a tier —</option>
                <?php foreach ($tiers as $t): ?><option value="<?php echo (int) $t['id']; ?>"><?php echo htmlspecialchars($t['name']); ?> (tier default)</option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-panel-item">
            <label>Or Specific Partner</label>
            <select name="partner_id" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <option value="">— None (tier-level only) —</option>
                <?php foreach ($partners as $p): ?><option value="<?php echo (int) $p['id']; ?>"><?php echo htmlspecialchars($p['company_name'] . ' (' . $p['application_ref'] . ')'); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-panel-item">
            <label>Service Category</label>
            <select name="service_category" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <?php foreach (B2B_SERVICES_OFFERED as $svc): ?><option value="<?php echo htmlspecialchars($svc); ?>"><?php echo htmlspecialchars($svc); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-panel-item"><label>Base Price / Internal Cost (₹)</label><input type="number" name="base_price" step="0.01" min="0" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
        <div class="crm-panel-item"><label>Partner Price (₹)</label><input type="number" name="partner_price" step="0.01" min="0" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
        <div class="crm-panel-item"><label><input type="checkbox" name="markup_allowed" value="1"> Partner may mark this up for their own end customer</label></div>
        <div class="crm-panel-item full"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Save Pricing Rule</button></div>
    </form>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Applies To</th><th>Service</th><th>Base Price (internal)</th><th>Partner Price</th><th>Markup Allowed</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($pricingRules as $r): ?>
        <tr>
            <td class="crm-cell-name"><?php echo $r['partner_id'] ? htmlspecialchars($r['company_name']) . ' <span class="crm-cell-sub">(partner)</span>' : htmlspecialchars($r['tier_name']) . ' <span class="crm-cell-sub">(tier)</span>'; ?></td>
            <td><?php echo htmlspecialchars($r['service_category']); ?></td>
            <td class="crm-cell-sub">₹<?php echo number_format((float) $r['base_price'], 2); ?></td>
            <td>₹<?php echo number_format((float) $r['partner_price'], 2); ?></td>
            <td class="crm-cell-sub"><?php echo $r['markup_allowed'] ? 'Yes' : 'No'; ?></td>
            <td>
                <form method="post" data-confirm="Delete this pricing rule?">
                    <input type="hidden" name="action" value="delete_pricing_rule">
                    <input type="hidden" name="rule_id" value="<?php echo (int) $r['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Remove</button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$pricingRules): ?>
        <tr><td colspan="6" class="crm-empty">No pricing rules yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
