<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Declaration Templates';
$ADMIN_ACTIVE_NAV = 'forex-declaration-templates';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'Declaration Templates'];
require __DIR__ . '/includes/layout-top.php';

if (!forex_can_manage_settings()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage declaration templates.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'save_template') {
        $name = trim($_POST['name'] ?? '');
        $bodyHtml = trim($_POST['body_html'] ?? '');
        if ($name === '' || $bodyHtml === '') {
            $error = 'Please provide a name and template body.';
        } else {
            // Editing a template creates a NEW version rather than
            // overwriting — historical declarations reference the exact
            // template_id + version that was active when they were signed,
            // so past records must never change retroactively.
            $maxVersionStmt = $pdo->prepare('SELECT MAX(version) FROM forex_declaration_templates WHERE name = ?');
            $maxVersionStmt->execute([$name]);
            $nextVersion = ((int) $maxVersionStmt->fetchColumn()) + 1;

            $pdo->prepare('UPDATE forex_declaration_templates SET is_active = 0 WHERE name = ?')->execute([$name]);
            $pdo->prepare('INSERT INTO forex_declaration_templates (name, body_html, version, is_active, created_by, created_at) VALUES (?, ?, ?, 1, ?, ?)')
                ->execute([$name, $bodyHtml, $nextVersion, admin_name(), gmdate('c')]);
            forex_log_audit($pdo, null, admin_name(), admin_role(), "Created declaration template version: $name v$nextVersion");
            header('Location: forex-declaration-templates.php');
            exit;
        }
    } elseif ($action === 'activate') {
        $id = (int) ($_POST['id'] ?? 0);
        $nameStmt = $pdo->prepare('SELECT name FROM forex_declaration_templates WHERE id = ?');
        $nameStmt->execute([$id]);
        $name = $nameStmt->fetchColumn();
        if ($name) {
            $pdo->prepare('UPDATE forex_declaration_templates SET is_active = 0 WHERE name = ?')->execute([$name]);
            $pdo->prepare('UPDATE forex_declaration_templates SET is_active = 1 WHERE id = ?')->execute([$id]);
            forex_log_audit($pdo, null, admin_name(), admin_role(), "Reactivated declaration template: $name (id $id)");
        }
        header('Location: forex-declaration-templates.php');
        exit;
    }
}

$templates = $pdo->query('SELECT * FROM forex_declaration_templates ORDER BY name, version DESC')->fetchAll(PDO::FETCH_ASSOC);
$byName = [];
foreach ($templates as $t) {
    $byName[$t['name']][] = $t;
}
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Forex Declaration Templates</h1>
        <p class="crm-page-subtitle">Admin-editable Visa-on-Arrival / Visa-Free declaration text. Editing creates a new version rather than overwriting — historical declarations keep referencing the exact version that was active when they were signed.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenNewTemplate"><i class="fa-solid fa-plus"></i> New Template</button>
    </div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<div class="compliance-note" style="margin-bottom:16px;">
    Available placeholders: <code>{{customer_name}}</code> <code>{{passport_number}}</code> <code>{{country}}</code> <code>{{forex_reference}}</code> <code>{{travel_date}}</code> <code>{{currency}}</code> <code>{{amount}}</code> <code>{{declaration_date}}</code>
</div>

<?php foreach ($byName as $name => $versions): ?>
<div class="crm-card">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;">
        <h3 style="margin:0;"><?php echo htmlspecialchars($name); ?></h3>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick='openTemplateDrawer(<?php echo htmlspecialchars(json_encode($versions[0]), ENT_QUOTES); ?>)'><i class="fa-solid fa-pen"></i> Edit (creates v<?php echo (int) $versions[0]['version'] + 1; ?>)</button>
    </div>
    <?php foreach ($versions as $v): ?>
    <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-top:1px solid var(--c-border);">
        <div>
            <strong>v<?php echo (int) $v['version']; ?></strong>
            <?php if ($v['is_active']): ?><span class="crm-status-badge status-published" style="margin-left:8px;">Active</span><?php endif; ?>
            <span class="crm-cell-sub" style="margin-left:8px;"><?php echo htmlspecialchars($v['created_by']); ?> &middot; <?php echo htmlspecialchars(substr($v['created_at'], 0, 10)); ?></span>
        </div>
        <div style="display:flex;gap:8px;">
            <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick='previewTemplate(<?php echo htmlspecialchars(json_encode($v['body_html']), ENT_QUOTES); ?>)'>Preview</button>
            <?php if (!$v['is_active']): ?>
            <form method="post" style="display:inline;" data-confirm="Reactivate v<?php echo (int) $v['version']; ?> of <?php echo htmlspecialchars(addslashes($name)); ?>? Future declarations will use this version.">
                <input type="hidden" name="action" value="activate">
                <input type="hidden" name="id" value="<?php echo (int) $v['id']; ?>">
                <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Reactivate</button>
            </form>
            <?php endif; ?>
        </div>
    </div>
    <?php endforeach; ?>
</div>
<?php endforeach; ?>
<?php if (!$templates): ?><div class="crm-empty">No declaration templates yet.</div><?php endif; ?>

<div class="crm-drawer-overlay" id="crmTemplateDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2 id="crmTemplateDrawerTitle">New Template</h2><button type="button" class="crm-drawer-close" id="crmTemplateDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmTemplateForm">
                <input type="hidden" name="action" value="save_template">
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Template Name *</label><input type="text" name="name" id="tplName" required></div>
                <div class="crm-form-field" style="margin-bottom:14px;"><label>Template Body (HTML) *</label><textarea name="body_html" id="tplBody" rows="16" required style="font-family:monospace;font-size:12px;"></textarea></div>
                <button type="submit" class="crm-btn crm-btn-primary">Save as New Version</button>
            </form>
        </div>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmPreviewDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2>Preview</h2><button type="button" class="crm-drawer-close" id="crmPreviewDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body"><div id="tplPreviewBody" style="border:1px solid var(--c-border);border-radius:8px;padding:16px;"></div></div>
    </div>
</div>

<script>
var tplDrawer = document.getElementById('crmTemplateDrawer');
function openTemplateDrawer(data) {
    data = data || {};
    document.getElementById('crmTemplateDrawerTitle').textContent = data.name ? 'Edit ' + data.name : 'New Template';
    document.getElementById('tplName').value = data.name || '';
    document.getElementById('tplName').readOnly = !!data.name;
    document.getElementById('tplBody').value = data.body_html || '';
    tplDrawer.hidden = false;
    requestAnimationFrame(function () { tplDrawer.classList.add('is-open', 'is-visible'); });
}
document.getElementById('crmOpenNewTemplate').addEventListener('click', function () { openTemplateDrawer(null); });
document.getElementById('crmTemplateDrawerClose').addEventListener('click', function () {
    tplDrawer.classList.remove('is-visible');
    setTimeout(function () { tplDrawer.classList.remove('is-open'); tplDrawer.hidden = true; }, 250);
});

var previewDrawer = document.getElementById('crmPreviewDrawer');
function previewTemplate(html) {
    document.getElementById('tplPreviewBody').innerHTML = html;
    previewDrawer.hidden = false;
    requestAnimationFrame(function () { previewDrawer.classList.add('is-open', 'is-visible'); });
}
document.getElementById('crmPreviewDrawerClose').addEventListener('click', function () {
    previewDrawer.classList.remove('is-visible');
    setTimeout(function () { previewDrawer.classList.remove('is-open'); previewDrawer.hidden = true; }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
