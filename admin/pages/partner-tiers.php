<?php
declare(strict_types=1);

/**
 * Partner commission tier master data — Bronze/Silver/Gold-style
 * levels, each with a commission rate. Mirrors admin/pages/visa-
 * types.php's simple CRUD pattern. Gated on partners.manage since
 * tiers exist purely to drive partner commission calculations, not a
 * general content-management concern.
 */

require_permission('partners.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        // Partners on this tier fall back to "no tier assigned" rather
        // than the row being blocked from deletion — same ON DELETE
        // SET NULL behavior as assigned_admin_id.
        $pdo->prepare('DELETE FROM partner_tiers WHERE id = :id')->execute(['id' => $id]);
        flash_set('admin_notice', 'Tier deleted. Partners on this tier are now unassigned.');
        redirect('/admin/partner-tiers/');
    }

    if ($postAction === 'toggle' && $id) {
        $pdo->prepare('UPDATE partner_tiers SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
        redirect('/admin/partner-tiers/');
    }

    if ($postAction === 'save') {
        $name = trim((string) ($_POST['name'] ?? ''));
        $commissionType = in_array($_POST['commission_type'] ?? '', ['percentage', 'flat'], true) ? $_POST['commission_type'] : 'percentage';
        $data = [
            'name' => $name,
            'commission_type' => $commissionType,
            'commission_value' => (float) ($_POST['commission_value'] ?? 0),
            'description' => trim((string) ($_POST['description'] ?? '')) ?: null,
            'sort_order' => (int) ($_POST['sort_order'] ?? 0),
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
        ];

        if ($name === '') {
            flash_set('admin_error', 'Tier name is required.');
            redirect($id ? "/admin/partner-tiers/?action=edit&id=$id" : '/admin/partner-tiers/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $pdo->prepare(
                'UPDATE partner_tiers SET name=:name, commission_type=:commission_type, commission_value=:commission_value,
                 description=:description, sort_order=:sort_order, is_active=:is_active WHERE id=:id'
            )->execute($data);
            flash_set('admin_notice', 'Tier updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO partner_tiers (name, commission_type, commission_value, description, sort_order, is_active)
                 VALUES (:name, :commission_type, :commission_value, :description, :sort_order, :is_active)'
            )->execute($data);
            flash_set('admin_notice', 'Tier added.');
        }
        redirect('/admin/partner-tiers/');
    }
}

if ($action === 'create' || $action === 'edit') {
    $tier = ['name' => '', 'commission_type' => 'percentage', 'commission_value' => '', 'description' => '', 'sort_order' => 0, 'is_active' => 1];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM partner_tiers WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Tier not found.');
            redirect('/admin/partner-tiers/');
        }
        $tier = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit Tier' : 'Add Tier', 'partner-tiers');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/partner-tiers/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($tier['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="commission_type">Commission Type</label>
                    <select class="form-select" id="commission_type" name="commission_type">
                        <option value="percentage"<?= $tier['commission_type'] === 'percentage' ? ' selected' : '' ?>>Percentage of service fee</option>
                        <option value="flat"<?= $tier['commission_type'] === 'flat' ? ' selected' : '' ?>>Flat amount per application</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="commission_value">Commission Value</label>
                    <input class="form-input" type="number" step="0.01" id="commission_value" name="commission_value" value="<?= e((string) $tier['commission_value']) ?>" required>
                    <small style="color:var(--text-muted)">Percentage tiers: enter e.g. 10 for 10%. Flat tiers: enter the fixed rupee amount.</small>
                </div>
                <div class="form-group">
                    <label class="form-label" for="sort_order">Sort order</label>
                    <input class="form-input" type="number" id="sort_order" name="sort_order" value="<?= (int) $tier['sort_order'] ?>">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="description">Description</label>
                <textarea class="form-textarea" id="description" name="description" rows="3"><?= e($tier['description'] ?? '') ?></textarea>
            </div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_active" <?= $tier['is_active'] ? 'checked' : '' ?>> Active (selectable when assigning a partner's tier)</label></div>
            <button type="submit" class="btn btn-primary" style="margin-top:var(--space-4)">Save</button>
            <a href="/admin/partner-tiers/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$tiers = $pdo->query(
    'SELECT t.*, (SELECT COUNT(*) FROM partners p WHERE p.tier_id = t.id) AS partner_count
     FROM partner_tiers t ORDER BY t.sort_order'
)->fetchAll();

admin_header_start('Partner Tiers', 'partner-tiers');
?>
<div class="admin-toolbar">
    <div></div>
    <a href="/admin/partner-tiers/?action=create" class="btn btn-primary">+ Add Tier</a>
</div>
<table class="admin-table">
    <thead><tr><th>Name</th><th>Commission</th><th>Partners</th><th>Order</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($tiers as $t): ?>
        <tr>
            <td><?= e($t['name']) ?></td>
            <td><?= $t['commission_type'] === 'percentage' ? e(rtrim(rtrim(number_format((float) $t['commission_value'], 2), '0'), '.')) . '%' : '₹' . e(number_format((float) $t['commission_value'], 2)) . ' flat' ?></td>
            <td><?= (int) $t['partner_count'] ?></td>
            <td><?= (int) $t['sort_order'] ?></td>
            <td>
                <form method="post" action="/admin/partner-tiers/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                <button type="submit" class="badge <?= $t['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $t['is_active'] ? 'Active' : 'Hidden' ?></button></form>
            </td>
            <td class="actions">
                <a href="/admin/partner-tiers/?action=edit&id=<?= (int) $t['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/partner-tiers/" style="display:inline" onsubmit="return confirm('Delete this tier? Partners on it will become unassigned.');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$tiers): ?>
        <tr><td colspan="6"><p class="empty-state">No tiers defined yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
