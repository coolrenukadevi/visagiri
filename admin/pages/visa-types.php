<?php
declare(strict_types=1);

require_permission('content.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('content.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $stmt = $pdo->prepare('SELECT name FROM visa_types WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $oldName = $stmt->fetchColumn() ?: null;
        $pdo->prepare('DELETE FROM visa_types WHERE id = :id')->execute(['id' => $id]);
        log_action('delete', 'visa_types', $id, $oldName, null);
        flash_set('admin_notice', 'Visa type deleted.');
        redirect('/admin/visa-types/');
    }

    if ($postAction === 'toggle' && $id) {
        $stmt = $pdo->prepare('SELECT is_active FROM visa_types WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $old = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE visa_types SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
        log_action('update', 'visa_types', $id, "is_active=$old", 'is_active=' . (1 - $old));
        redirect('/admin/visa-types/');
    }

    if ($postAction === 'save') {
        $name = trim((string) ($_POST['name'] ?? ''));
        $slug = trim((string) ($_POST['slug'] ?? '')) ?: slugify($name);
        $data = [
            'name' => $name,
            'slug' => $slug,
            'description' => trim((string) ($_POST['description'] ?? '')) ?: null,
            'icon' => trim((string) ($_POST['icon'] ?? '')) ?: null,
            'sort_order' => (int) ($_POST['sort_order'] ?? 0),
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
            'meta_title' => trim((string) ($_POST['meta_title'] ?? '')) ?: null,
            'meta_description' => trim((string) ($_POST['meta_description'] ?? '')) ?: null,
        ];

        if ($name === '') {
            flash_set('admin_error', 'Visa type name is required.');
            redirect($id ? "/admin/visa-types/?action=edit&id=$id" : '/admin/visa-types/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $oldStmt = $pdo->prepare('SELECT name FROM visa_types WHERE id = :id');
            $oldStmt->execute(['id' => $id]);
            $oldName = $oldStmt->fetchColumn() ?: null;
            $pdo->prepare(
                'UPDATE visa_types SET name=:name, slug=:slug, description=:description, icon=:icon, sort_order=:sort_order, is_active=:is_active,
                 meta_title=:meta_title, meta_description=:meta_description WHERE id=:id'
            )->execute($data);
            log_action('update', 'visa_types', $id, $oldName, $name);
            flash_set('admin_notice', 'Visa type updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO visa_types (name, slug, description, icon, sort_order, is_active, meta_title, meta_description)
                 VALUES (:name, :slug, :description, :icon, :sort_order, :is_active, :meta_title, :meta_description)'
            )->execute($data);
            // New visa type: make it available for every existing country by default.
            $newId = (int) $pdo->lastInsertId();
            $pdo->exec("INSERT INTO country_visa_types (country_id, visa_type_id, is_available) SELECT id, $newId, 1 FROM countries");
            log_action('create', 'visa_types', $newId, null, $name);
            flash_set('admin_notice', 'Visa type added.');
        }
        redirect('/admin/visa-types/');
    }
}

if ($action === 'create' || $action === 'edit') {
    require_permission('content.manage');
    $type = ['name' => '', 'slug' => '', 'description' => '', 'icon' => '', 'sort_order' => 0, 'is_active' => 1, 'meta_title' => '', 'meta_description' => ''];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM visa_types WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Visa type not found.');
            redirect('/admin/visa-types/');
        }
        $type = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit Visa Type' : 'Add Visa Type', 'visa-types');
    admin_subnav('content', 'visa-types');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/visa-types/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($type['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="slug">Slug</label>
                    <input class="form-input" type="text" id="slug" name="slug" value="<?= e($type['slug']) ?>" placeholder="auto-generated if blank">
                </div>
                <div class="form-group">
                    <label class="form-label" for="icon">Icon (emoji)</label>
                    <input class="form-input" type="text" id="icon" name="icon" value="<?= e($type['icon'] ?? '') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="sort_order">Sort order</label>
                    <input class="form-input" type="number" id="sort_order" name="sort_order" value="<?= (int) $type['sort_order'] ?>">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="description">Description</label>
                <textarea class="form-input" id="description" name="description" rows="3"><?= e($type['description'] ?? '') ?></textarea>
            </div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_active" <?= $type['is_active'] ? 'checked' : '' ?>> Active (visible on site)</label></div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="meta_title">SEO meta title</label>
                <input class="form-input" type="text" id="meta_title" name="meta_title" value="<?= e($type['meta_title'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="meta_description">SEO meta description</label>
                <textarea class="form-input" id="meta_description" name="meta_description" rows="2"><?= e($type['meta_description'] ?? '') ?></textarea>
            </div>

            <button type="submit" class="btn btn-primary" style="margin-top:var(--space-4)">Save</button>
            <a href="/admin/visa-types/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$types = $pdo->query('SELECT * FROM visa_types ORDER BY sort_order')->fetchAll();

admin_header_start('Visa Types', 'visa-types');
admin_subnav('content', 'visa-types');
?>
<div class="admin-toolbar">
    <div></div>
    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/visa-types/?action=create" class="btn btn-primary">+ Add Visa Type</a>
    <?php endif; ?>
</div>
<?php if ($types): ?>
<div class="admin-table-scroll" style="margin-top:var(--space-4)">
<table class="admin-table">
    <thead><tr><th>Icon</th><th>Name</th><th>Slug</th><th>Order</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php $canManageContent = has_permission('content.manage'); ?>
    <?php foreach ($types as $t): ?>
        <tr>
            <td><?= $t['icon'] ?? '' ?></td>
            <td><?= e($t['name']) ?></td>
            <td><?= e($t['slug']) ?></td>
            <td><?= (int) $t['sort_order'] ?></td>
            <td>
                <?php if ($canManageContent): ?>
                <form method="post" action="/admin/visa-types/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                <button type="submit" class="badge <?= $t['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $t['is_active'] ? 'Active' : 'Hidden' ?></button></form>
                <?php else: ?>
                <span class="badge <?= $t['is_active'] ? 'badge-success' : 'badge-warning' ?>"><?= $t['is_active'] ? 'Active' : 'Hidden' ?></span>
                <?php endif; ?>
            </td>
            <td class="actions">
                <?php if ($canManageContent): ?>
                <a href="/admin/visa-types/?action=edit&id=<?= (int) $t['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/visa-types/" style="display:inline" onsubmit="return confirm('Delete this visa type?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>
<div class="admin-card-list" style="margin-top:var(--space-4)">
    <?php foreach ($types as $t): ?>
    <div class="admin-record-card">
        <p class="admin-record-card__title"><?= $t['icon'] ? e($t['icon']) . ' ' : '' ?><?= e($t['name']) ?> <span style="font-weight:400;color:var(--text-muted)">&middot; <?= e($t['slug']) ?></span></p>
        <div class="admin-record-card__row"><span>Order</span><strong><?= (int) $t['sort_order'] ?></strong></div>
        <div class="admin-record-card__row"><span>Status</span><strong><span class="badge <?= $t['is_active'] ? 'badge-success' : 'badge-warning' ?>"><?= $t['is_active'] ? 'Active' : 'Hidden' ?></span></strong></div>
        <?php if ($canManageContent): ?>
        <div class="admin-record-card__action">
            <a href="/admin/visa-types/?action=edit&id=<?= (int) $t['id'] ?>" class="btn btn-sm btn-outline">Edit</a>
            <form method="post" action="/admin/visa-types/" style="display:inline" onsubmit="return confirm('Delete this visa type?');">
                <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                <button type="submit" class="btn btn-sm btn-outline">Delete</button>
            </form>
        </div>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
</div>
<?php else: ?>
<p class="admin-empty-state--icon" style="margin-top:var(--space-4)"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No visa types yet.</p>
<?php endif; ?>
<?php
admin_header_end();
