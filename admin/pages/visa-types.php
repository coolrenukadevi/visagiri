<?php
declare(strict_types=1);

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('DELETE FROM visa_types WHERE id = :id')->execute(['id' => $id]);
        flash_set('admin_notice', 'Visa type deleted.');
        redirect('/admin/visa-types/');
    }

    if ($postAction === 'toggle' && $id) {
        $pdo->prepare('UPDATE visa_types SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
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
        ];

        if ($name === '') {
            flash_set('admin_error', 'Visa type name is required.');
            redirect($id ? "/admin/visa-types/?action=edit&id=$id" : '/admin/visa-types/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $pdo->prepare(
                'UPDATE visa_types SET name=:name, slug=:slug, description=:description, icon=:icon, sort_order=:sort_order, is_active=:is_active WHERE id=:id'
            )->execute($data);
            flash_set('admin_notice', 'Visa type updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO visa_types (name, slug, description, icon, sort_order, is_active) VALUES (:name, :slug, :description, :icon, :sort_order, :is_active)'
            )->execute($data);
            // New visa type: make it available for every existing country by default.
            $newId = (int) $pdo->lastInsertId();
            $pdo->exec("INSERT INTO country_visa_types (country_id, visa_type_id, is_available) SELECT id, $newId, 1 FROM countries");
            flash_set('admin_notice', 'Visa type added.');
        }
        redirect('/admin/visa-types/');
    }
}

if ($action === 'create' || $action === 'edit') {
    $type = ['name' => '', 'slug' => '', 'description' => '', 'icon' => '', 'sort_order' => 0, 'is_active' => 1];
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
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/visa-types/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
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
?>
<div class="admin-toolbar">
    <div></div>
    <a href="/admin/visa-types/?action=create" class="btn btn-primary">+ Add Visa Type</a>
</div>
<table class="admin-table">
    <thead><tr><th>Icon</th><th>Name</th><th>Slug</th><th>Order</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($types as $t): ?>
        <tr>
            <td><?= $t['icon'] ?? '' ?></td>
            <td><?= e($t['name']) ?></td>
            <td><?= e($t['slug']) ?></td>
            <td><?= (int) $t['sort_order'] ?></td>
            <td>
                <form method="post" action="/admin/visa-types/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                <button type="submit" class="badge <?= $t['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $t['is_active'] ? 'Active' : 'Hidden' ?></button></form>
            </td>
            <td class="actions">
                <a href="/admin/visa-types/?action=edit&id=<?= (int) $t['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/visa-types/" style="display:inline" onsubmit="return confirm('Delete this visa type?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $t['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php
admin_header_end();
