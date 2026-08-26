<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'Forex Country Rules';
$ADMIN_ACTIVE_NAV = 'forex-country-rules';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Country Rules'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/visa-content-db.php';
visa_content_db();

if (!forex_can_manage_country_rules()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage forex country rules.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'save_rule') {
        $id = (int) ($_POST['id'] ?? 0);
        $country = trim($_POST['country'] ?? '');

        if ($country === '') {
            $error = 'Please select a country.';
        } else {
            $dupStmt = $pdo->prepare('SELECT id FROM forex_country_rules WHERE country = ? AND id != ?');
            $dupStmt->execute([$country, $id]);
            if ($dupStmt->fetchColumn()) {
                $error = 'A rule for that country already exists — edit it instead of creating a duplicate.';
            } else {
                $fields = [
                    'country' => $country,
                    'currency_code' => strtoupper(trim($_POST['currency_code'] ?? '')) ?: null,
                    'visa_required' => isset($_POST['visa_required']) ? 1 : 0,
                    'visa_on_arrival' => isset($_POST['visa_on_arrival']) ? 1 : 0,
                    'visa_free' => isset($_POST['visa_free']) ? 1 : 0,
                    'evisa' => isset($_POST['evisa']) ? 1 : 0,
                    'requires_passport' => isset($_POST['requires_passport']) ? 1 : 0,
                    'requires_pan' => isset($_POST['requires_pan']) ? 1 : 0,
                    'requires_air_ticket' => isset($_POST['requires_air_ticket']) ? 1 : 0,
                    'requires_hotel' => isset($_POST['requires_hotel']) ? 1 : 0,
                    'requires_visa_copy' => isset($_POST['requires_visa_copy']) ? 1 : 0,
                    'requires_declaration' => isset($_POST['requires_declaration']) ? 1 : 0,
                    'compliance_notes' => trim($_POST['compliance_notes'] ?? '') ?: null,
                    'updated_by' => admin_name(),
                    'updated_at' => gmdate('c'),
                ];
                if ($id > 0) {
                    $fields['id'] = $id;
                    $sets = implode(', ', array_map(function ($k) { return "$k = :$k"; }, array_diff(array_keys($fields), ['id'])));
                    $pdo->prepare("UPDATE forex_country_rules SET $sets WHERE id = :id")->execute($fields);
                    forex_log_audit($pdo, null, admin_name(), admin_role(), 'Updated forex country rule: ' . $country);
                } else {
                    $cols = implode(', ', array_keys($fields));
                    $params = implode(', ', array_map(function ($k) { return ":$k"; }, array_keys($fields)));
                    $pdo->prepare("INSERT INTO forex_country_rules ($cols) VALUES ($params)")->execute($fields);
                    forex_log_audit($pdo, null, admin_name(), admin_role(), 'Created forex country rule: ' . $country);
                }
                header('Location: forex-country-rules.php');
                exit;
            }
        }
    } elseif ($action === 'delete_rule') {
        $id = (int) ($_POST['id'] ?? 0);
        $nameStmt = $pdo->prepare('SELECT country FROM forex_country_rules WHERE id = ?');
        $nameStmt->execute([$id]);
        $countryName = $nameStmt->fetchColumn();
        $pdo->prepare('DELETE FROM forex_country_rules WHERE id = ?')->execute([$id]);
        if ($countryName) {
            forex_log_audit($pdo, null, admin_name(), admin_role(), 'Deleted forex country rule: ' . $countryName);
        }
        header('Location: forex-country-rules.php');
        exit;
    }
}

$q = trim($_GET['q'] ?? '');
$where = '';
$params = [];
if ($q !== '') {
    $where = 'WHERE country LIKE :q';
    $params['q'] = '%' . $q . '%';
}
$rules = $pdo->prepare("SELECT * FROM forex_country_rules $where ORDER BY country ASC");
$rules->execute($params);
$rules = $rules->fetchAll(PDO::FETCH_ASSOC);

$existingCountries = array_column($pdo->query('SELECT country FROM forex_country_rules')->fetchAll(PDO::FETCH_ASSOC), 'country');
$countryOptions = $pdo->query('SELECT name, flag FROM countries WHERE is_active = 1 ORDER BY name ASC')->fetchAll(PDO::FETCH_ASSOC);
$currencies = forex_currencies($pdo);
$totalRules = count($rules);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Country Rules</h1>
        <p class="crm-page-subtitle">Drives the automatic document checklist on new Forex requests — visa status, required documents and declaration requirements per destination. Admin-editable so compliance rules can be updated without a code change.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenAddRule"><i class="fa-solid fa-plus"></i> Add Country Rule</button>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalRules; ?></div><div class="crm-kpi-label">Countries With Rules</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo count($countryOptions); ?></div><div class="crm-kpi-label">Countries Available</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo count($countryOptions) - $totalRules; ?></div><div class="crm-kpi-label">Without a Rule Yet</div></div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search country..." style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:220px;">
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($q): ?><a href="forex-country-rules.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Country</th><th>Currency</th><th>Visa Status</th><th>Required Documents</th><th>Declaration</th><th>Updated</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($rules as $r): ?>
        <?php
        $visaBits = [];
        if ($r['visa_required']) $visaBits[] = 'Visa Required';
        if ($r['visa_on_arrival']) $visaBits[] = 'Visa on Arrival';
        if ($r['visa_free']) $visaBits[] = 'Visa-Free';
        if ($r['evisa']) $visaBits[] = 'eVisa';
        $docBits = [];
        if ($r['requires_passport']) $docBits[] = 'Passport';
        if ($r['requires_pan']) $docBits[] = 'PAN';
        if ($r['requires_air_ticket']) $docBits[] = 'Air Ticket';
        if ($r['requires_hotel']) $docBits[] = 'Hotel';
        if ($r['requires_visa_copy']) $docBits[] = 'Visa Copy';
        ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($r['country']); ?></td>
            <td><?php echo htmlspecialchars($r['currency_code'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($visaBits ? implode(', ', $visaBits) : '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($docBits ? implode(', ', $docBits) : '—'); ?></td>
            <td><?php echo $r['requires_declaration'] ? '<span class="crm-status-badge status-published">Required</span>' : '<span class="crm-cell-sub">—</span>'; ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($r['updated_at'], 0, 10)); ?><?php echo $r['updated_by'] ? ' by ' . htmlspecialchars($r['updated_by']) : ''; ?></td>
            <td style="white-space:nowrap;">
                <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="openRuleDrawer(<?php echo htmlspecialchars(json_encode($r), ENT_QUOTES); ?>)"><i class="fa-solid fa-pen"></i></button>
                <form method="post" style="display:inline;" data-confirm="Delete the forex country rule for <?php echo htmlspecialchars(addslashes($r['country'])); ?>?">
                    <input type="hidden" name="action" value="delete_rule">
                    <input type="hidden" name="id" value="<?php echo (int) $r['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);"><i class="fa-solid fa-trash"></i></button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$rules): ?>
        <tr><td colspan="7" class="crm-empty">No country rules yet. Add one so the Forex request form can auto-build its document checklist.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmRuleDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2 id="crmRuleDrawerTitle">Add Country Rule</h2><button type="button" class="crm-drawer-close" id="crmRuleDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmRuleForm">
                <input type="hidden" name="action" value="save_rule">
                <input type="hidden" name="id" id="rfId" value="">
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-earth-americas"></i> Country</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field crm-form-field-full"><label>Country *</label>
                            <select name="country" id="rfCountry" required>
                                <option value="">Select country</option>
                                <?php foreach ($countryOptions as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars(($c['flag'] ? $c['flag'] . ' ' : '') . $c['name']); ?></option><?php endforeach; ?>
                            </select>
                        </div>
                        <div class="crm-form-field"><label>Currency Code</label>
                            <select name="currency_code" id="rfCurrencyCode">
                                <option value="">—</option>
                                <?php foreach ($currencies as $cur): ?><option value="<?php echo htmlspecialchars($cur); ?>"><?php echo htmlspecialchars($cur); ?></option><?php endforeach; ?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-passport"></i> Visa Status</h4>
                    <div class="crm-form-grid">
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="visa_required" id="rfVisaRequired" style="width:auto;" checked> Visa Required</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="visa_on_arrival" id="rfVisaOnArrival" style="width:auto;"> Visa on Arrival</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="visa_free" id="rfVisaFree" style="width:auto;"> Visa-Free</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="evisa" id="rfEvisa" style="width:auto;"> eVisa</label>
                    </div>
                </div>
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-file-lines"></i> Required Documents</h4>
                    <div class="crm-form-grid">
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_passport" id="rfReqPassport" style="width:auto;" checked> Passport</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_pan" id="rfReqPan" style="width:auto;" checked> PAN</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_air_ticket" id="rfReqAirTicket" style="width:auto;" checked> Air Ticket</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_hotel" id="rfReqHotel" style="width:auto;" checked> Hotel</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_visa_copy" id="rfReqVisaCopy" style="width:auto;" checked> Visa Copy</label>
                        <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="requires_declaration" id="rfReqDeclaration" style="width:auto;"> VoA/Visa-Free Declaration</label>
                    </div>
                </div>
                <div class="crm-form-field crm-form-field-full" style="margin-bottom:16px;">
                    <label>Compliance Notes</label>
                    <textarea name="compliance_notes" id="rfComplianceNotes" rows="3" placeholder="Internal notes for staff — special conditions, recent rule changes, etc."></textarea>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Save Rule</button>
            </form>
        </div>
    </div>
</div>

<script>
var ruleDrawer = document.getElementById('crmRuleDrawer');
function openRuleDrawer(data) {
    data = data || {};
    document.getElementById('crmRuleDrawerTitle').textContent = data.id ? 'Edit Country Rule' : 'Add Country Rule';
    document.getElementById('rfId').value = data.id || '';
    document.getElementById('rfCountry').value = data.country || '';
    document.getElementById('rfCurrencyCode').value = data.currency_code || '';
    document.getElementById('rfVisaRequired').checked = data.id ? !!parseInt(data.visa_required, 10) : true;
    document.getElementById('rfVisaOnArrival').checked = !!parseInt(data.visa_on_arrival || 0, 10);
    document.getElementById('rfVisaFree').checked = !!parseInt(data.visa_free || 0, 10);
    document.getElementById('rfEvisa').checked = !!parseInt(data.evisa || 0, 10);
    document.getElementById('rfReqPassport').checked = data.id ? !!parseInt(data.requires_passport, 10) : true;
    document.getElementById('rfReqPan').checked = data.id ? !!parseInt(data.requires_pan, 10) : true;
    document.getElementById('rfReqAirTicket').checked = data.id ? !!parseInt(data.requires_air_ticket, 10) : true;
    document.getElementById('rfReqHotel').checked = data.id ? !!parseInt(data.requires_hotel, 10) : true;
    document.getElementById('rfReqVisaCopy').checked = data.id ? !!parseInt(data.requires_visa_copy, 10) : true;
    document.getElementById('rfReqDeclaration').checked = !!parseInt(data.requires_declaration || 0, 10);
    document.getElementById('rfComplianceNotes').value = data.compliance_notes || '';
    ruleDrawer.hidden = false;
    requestAnimationFrame(function () { ruleDrawer.classList.add('is-open', 'is-visible'); });
}
document.getElementById('crmOpenAddRule').addEventListener('click', function () { openRuleDrawer(null); });
document.getElementById('crmRuleDrawerClose').addEventListener('click', function () {
    ruleDrawer.classList.remove('is-visible');
    setTimeout(function () { ruleDrawer.classList.remove('is-open'); ruleDrawer.hidden = true; }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
