<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Announcements';
$ADMIN_ACTIVE_NAV = 'b2b-announcements';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Announcements'];
require __DIR__ . '/includes/layout-top.php';

if (!b2b_can_manage_announcements()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage B2B announcements.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'publish') {
        $title = trim($_POST['title'] ?? '');
        $body = trim($_POST['body'] ?? '');
        $targetType = trim($_POST['target_type'] ?? '');
        $targetValue = trim($_POST['target_value'] ?? '');
        $expiresAt = trim($_POST['expires_at'] ?? '');

        if ($title === '' || $body === '' || !in_array($targetType, B2B_ANNOUNCEMENT_TARGETS, true)) {
            $actionError = 'Please provide a title, body and a valid target.';
        } elseif ($targetType !== 'All' && $targetValue === '') {
            $actionError = 'Please select a value for this target type (tier, country or partner).';
        } else {
            $pdo->prepare('INSERT INTO b2b_announcements (title, body, target_type, target_value, published_by, published_at, expires_at) VALUES (?, ?, ?, ?, ?, ?, ?)')
                ->execute([
                    $title, $body, $targetType, $targetType === 'All' ? null : $targetValue,
                    admin_name(), gmdate('c'), $expiresAt !== '' ? gmdate('c', strtotime($expiresAt . ' 23:59:59')) : null,
                ]);
            $newId = (int) $pdo->lastInsertId();
            b2b_log_audit($pdo, 'announcement', $newId, admin_name(), admin_role(), 'Published announcement', '', "$title ($targetType" . ($targetValue ? ": $targetValue" : '') . ')');
            $actionMessage = "Announcement \"$title\" published.";
        }
    } elseif ($action === 'delete') {
        $id = (int) ($_POST['id'] ?? 0);
        $pdo->prepare('DELETE FROM b2b_announcements WHERE id = ?')->execute([$id]);
        b2b_log_audit($pdo, 'announcement', $id, admin_name(), admin_role(), 'Deleted announcement');
        $actionMessage = 'Announcement removed.';
    }
}

$announcements = $pdo->query('SELECT * FROM b2b_announcements ORDER BY published_at DESC')->fetchAll(PDO::FETCH_ASSOC);
$tiers = $pdo->query('SELECT id, name FROM b2b_tiers WHERE is_active = 1 ORDER BY name')->fetchAll(PDO::FETCH_ASSOC);
$partnersList = $pdo->query("SELECT id, company_name, application_ref FROM b2b_partners WHERE archived_at IS NULL ORDER BY company_name")->fetchAll(PDO::FETCH_ASSOC);
$partnerCountries = $pdo->query("SELECT DISTINCT country FROM b2b_partners WHERE country IS NOT NULL AND country != '' ORDER BY country")->fetchAll(PDO::FETCH_COLUMN);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Announcements</h1>
        <p class="crm-page-subtitle">Broadcast a message to every partner, one tier, one country, or a single partner. Shown on the partner dashboard until it expires.</p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="crm-alert crm-alert-success"><?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="crm-alert crm-alert-error"><?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="crm-card">
    <h3 style="margin:0 0 14px;font-size:14px;">Publish New Announcement</h3>
    <form method="post" class="crm-panel-grid">
        <input type="hidden" name="action" value="publish">
        <div class="crm-panel-item full"><label>Title</label><input type="text" name="title" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
        <div class="crm-panel-item full"><label>Message</label><textarea name="body" rows="3" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;font-family:inherit;"></textarea></div>
        <div class="crm-panel-item">
            <label>Target</label>
            <select name="target_type" id="b2bAnnTargetType" required style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;">
                <?php foreach (B2B_ANNOUNCEMENT_TARGETS as $t): ?><option value="<?php echo htmlspecialchars($t); ?>"><?php echo htmlspecialchars($t); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-panel-item">
            <label>Target Value</label>
            <select name="target_value" id="b2bAnnTargetValue" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;" disabled>
                <option value="">— Applies to all partners —</option>
                <?php foreach ($tiers as $t): ?><option value="<?php echo htmlspecialchars($t['name']); ?>" data-for="Tier"><?php echo htmlspecialchars($t['name']); ?></option><?php endforeach; ?>
                <?php foreach ($partnerCountries as $c): ?><option value="<?php echo htmlspecialchars($c); ?>" data-for="Country"><?php echo htmlspecialchars($c); ?></option><?php endforeach; ?>
                <?php foreach ($partnersList as $p): ?><option value="<?php echo (int) $p['id']; ?>" data-for="Partner"><?php echo htmlspecialchars($p['company_name'] . ' (' . $p['application_ref'] . ')'); ?></option><?php endforeach; ?>
            </select>
        </div>
        <div class="crm-panel-item"><label>Expires On (optional)</label><input type="date" name="expires_at" style="width:100%;border:1px solid var(--c-border);border-radius:8px;padding:7px 10px;"></div>
        <div class="crm-panel-item full"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Publish Announcement</button></div>
    </form>
</div>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Title</th><th>Target</th><th>Published</th><th>Expires</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($announcements as $a): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($a['title']); ?><div class="crm-cell-sub"><?php echo htmlspecialchars(mb_strimwidth($a['body'], 0, 80, '…')); ?></div></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($a['target_type']); ?><?php echo $a['target_value'] ? ': ' . htmlspecialchars($a['target_value']) : ''; ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr($a['published_at'], 0, 10)); ?> &middot; <?php echo htmlspecialchars($a['published_by']); ?></td>
            <td class="crm-cell-sub"><?php echo $a['expires_at'] ? htmlspecialchars(substr($a['expires_at'], 0, 10)) : 'Never'; ?></td>
            <td>
                <form method="post" data-confirm="Delete this announcement?">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<?php echo (int) $a['id']; ?>">
                    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Remove</button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$announcements): ?>
        <tr><td colspan="5" class="crm-empty">No announcements published yet.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<script>
(function () {
    var typeSel = document.getElementById('b2bAnnTargetType');
    var valueSel = document.getElementById('b2bAnnTargetValue');
    function sync() {
        var type = typeSel.value;
        valueSel.disabled = (type === 'All');
        Array.prototype.forEach.call(valueSel.options, function (opt) {
            if (!opt.dataset.for) { opt.hidden = (type !== 'All'); return; }
            opt.hidden = (opt.dataset.for !== type);
        });
        valueSel.value = '';
    }
    typeSel.addEventListener('change', sync);
    sync();
})();
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
