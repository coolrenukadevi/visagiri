<?php
declare(strict_types=1);

/**
 * National Location SEO CMS — states/UTs and cities, in one file
 * (tabbed by ?type=), cloned from admin/pages/countries.php's
 * list/create/edit/toggle/delete shape. The one thing this file adds
 * beyond that pattern: `is_indexable` is never set anywhere except
 * here, by a human, on purpose — it's the explicit quality gate that
 * keeps a state/city page out of the sitemap and out of search
 * results until real content actually exists for it (see
 * database/schema-location-seo.sql's docblock).
 */

require_permission('content.manage');

$pdo = db();
$requestedType = $_GET['type'] ?? 'state';
$type = in_array($requestedType, ['state', 'city'], true) ? $requestedType : 'state';
$table = $type === 'state' ? 'states' : 'cities';
$states = $pdo->query('SELECT id, name FROM states ORDER BY name')->fetchAll();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

// --- Handle POST (create, update, delete, toggle) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';
    $requestedPostType = $_POST['type'] ?? 'state';
    $postType = in_array($requestedPostType, ['state', 'city'], true) ? $requestedPostType : 'state';
    $postTable = $postType === 'state' ? 'states' : 'cities';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare("DELETE FROM $postTable WHERE id = :id")->execute(['id' => $id]);
        flash_set('admin_notice', ucfirst($postType) . ' deleted.');
        redirect("/admin/locations/?type=$postType");
    }

    if ($postAction === 'toggle' && $id) {
        $field = in_array($_POST['field'] ?? '', ['is_active', 'is_indexable', 'is_major'], true) ? $_POST['field'] : null;
        if ($field && ($field !== 'is_major' || $postType === 'city')) {
            $pdo->prepare("UPDATE $postTable SET $field = NOT $field WHERE id = :id")->execute(['id' => $id]);
        }
        redirect("/admin/locations/?type=$postType");
    }

    if ($postAction === 'save') {
        $name = trim((string) ($_POST['name'] ?? ''));
        $slug = trim((string) ($_POST['slug'] ?? '')) ?: slugify($name);

        if ($name === '') {
            flash_set('admin_error', ucfirst($postType) . ' name is required.');
            redirect($id ? "/admin/locations/?type=$postType&action=edit&id=$id" : "/admin/locations/?type=$postType&action=create");
        }

        $data = [
            'name' => $name,
            'slug' => $slug,
            'intro_content' => trim((string) ($_POST['intro_content'] ?? '')) ?: null,
            'meta_title' => trim((string) ($_POST['meta_title'] ?? '')) ?: null,
            'meta_description' => trim((string) ($_POST['meta_description'] ?? '')) ?: null,
            'is_indexable' => isset($_POST['is_indexable']) ? 1 : 0,
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
            'sort_order' => (int) ($_POST['sort_order'] ?? 0),
        ];

        if ($postType === 'state') {
            $data['type'] = in_array($_POST['location_type'] ?? '', ['state', 'union_territory'], true) ? $_POST['location_type'] : 'state';
            $data['zone'] = in_array($_POST['zone'] ?? '', ['North', 'South', 'East', 'West', 'Central', 'Northeast'], true) ? $_POST['zone'] : null;

            if ($id) {
                $data['id'] = $id;
                $pdo->prepare(
                    'UPDATE states SET name=:name, slug=:slug, type=:type, zone=:zone, intro_content=:intro_content,
                     meta_title=:meta_title, meta_description=:meta_description, is_indexable=:is_indexable,
                     is_active=:is_active, sort_order=:sort_order WHERE id=:id'
                )->execute($data);
                flash_set('admin_notice', 'State updated.');
            } else {
                $pdo->prepare(
                    'INSERT INTO states (name, slug, type, zone, intro_content, meta_title, meta_description, is_indexable, is_active, sort_order)
                     VALUES (:name, :slug, :type, :zone, :intro_content, :meta_title, :meta_description, :is_indexable, :is_active, :sort_order)'
                )->execute($data);
                flash_set('admin_notice', 'State added.');
            }
        } else {
            $data['state_id'] = (int) ($_POST['state_id'] ?? 0) ?: null;
            $data['is_major'] = isset($_POST['is_major']) ? 1 : 0;
            $data['office_address'] = trim((string) ($_POST['office_address'] ?? '')) ?: null;

            if (!$data['state_id']) {
                flash_set('admin_error', 'A city must belong to a state.');
                redirect($id ? "/admin/locations/?type=city&action=edit&id=$id" : '/admin/locations/?type=city&action=create');
            }

            if ($id) {
                $data['id'] = $id;
                $pdo->prepare(
                    'UPDATE cities SET state_id=:state_id, name=:name, slug=:slug, is_major=:is_major,
                     intro_content=:intro_content, office_address=:office_address, meta_title=:meta_title,
                     meta_description=:meta_description, is_indexable=:is_indexable, is_active=:is_active,
                     sort_order=:sort_order WHERE id=:id'
                )->execute($data);
                flash_set('admin_notice', 'City updated.');
            } else {
                $pdo->prepare(
                    'INSERT INTO cities (state_id, name, slug, is_major, intro_content, office_address, meta_title, meta_description, is_indexable, is_active, sort_order)
                     VALUES (:state_id, :name, :slug, :is_major, :intro_content, :office_address, :meta_title, :meta_description, :is_indexable, :is_active, :sort_order)'
                )->execute($data);
                flash_set('admin_notice', 'City added.');
            }
        }
        redirect("/admin/locations/?type=$postType");
    }
}

// --- Create/Edit form ---
if ($action === 'create' || $action === 'edit') {
    $row = $type === 'state'
        ? ['name' => '', 'slug' => '', 'type' => 'state', 'zone' => null, 'intro_content' => '', 'meta_title' => '', 'meta_description' => '', 'is_indexable' => 0, 'is_active' => 1, 'sort_order' => 0]
        : ['name' => '', 'slug' => '', 'state_id' => '', 'is_major' => 0, 'intro_content' => '', 'office_address' => '', 'meta_title' => '', 'meta_description' => '', 'is_indexable' => 0, 'is_active' => 1, 'sort_order' => 0];

    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare("SELECT * FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', ucfirst($type) . ' not found.');
            redirect("/admin/locations/?type=$type");
        }
        $row = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit ' . ucfirst($type) : 'Add ' . ucfirst($type), 'locations');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/locations/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="type" value="<?= e($type) ?>">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($row['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="slug">Slug</label>
                    <input class="form-input" type="text" id="slug" name="slug" value="<?= e($row['slug']) ?>" placeholder="auto-generated if blank">
                </div>
                <?php if ($type === 'state'): ?>
                <div class="form-group">
                    <label class="form-label" for="location_type">Type</label>
                    <select class="form-select" id="location_type" name="location_type">
                        <option value="state" <?= $row['type'] === 'state' ? 'selected' : '' ?>>State</option>
                        <option value="union_territory" <?= $row['type'] === 'union_territory' ? 'selected' : '' ?>>Union Territory</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="zone">Zone</label>
                    <select class="form-select" id="zone" name="zone">
                        <option value="">— None —</option>
                        <?php foreach (['North', 'South', 'East', 'West', 'Central', 'Northeast'] as $z): ?>
                        <option value="<?= e($z) ?>" <?= $row['zone'] === $z ? 'selected' : '' ?>><?= e($z) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <?php else: ?>
                <div class="form-group">
                    <label class="form-label" for="state_id">State</label>
                    <select class="form-select" id="state_id" name="state_id" required>
                        <option value="">— Select —</option>
                        <?php foreach ($states as $s): ?>
                        <option value="<?= (int) $s['id'] ?>" <?= (int) ($row['state_id'] ?? 0) === (int) $s['id'] ? 'selected' : '' ?>><?= e($s['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <?php endif; ?>
                <div class="form-group">
                    <label class="form-label" for="sort_order">Sort order</label>
                    <input class="form-input" type="number" id="sort_order" name="sort_order" value="<?= (int) $row['sort_order'] ?>">
                </div>
            </div>
            <?php if ($type === 'city'): ?>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_major" <?= $row['is_major'] ? 'checked' : '' ?>> Major city (shown first in "cities served" lists)</label></div>
            <?php endif; ?>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_active" <?= $row['is_active'] ? 'checked' : '' ?>> Active</label></div>
            <div class="admin-checkbox-row">
                <label><input type="checkbox" name="is_indexable" <?= $row['is_indexable'] ? 'checked' : '' ?>> Indexable (live, in sitemap, visible to search engines)</label>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-top:var(--space-1)">
                    Only enable this once real, unique content is written below — an indexable page with no content is exactly the kind of thin page this system is designed to prevent.
                </p>
            </div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="intro_content">Page content</label>
                <textarea class="form-input" id="intro_content" name="intro_content" rows="8"><?= e($row['intro_content'] ?? '') ?></textarea>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-top:var(--space-1)">Plain text, blank line between paragraphs.</p>
            </div>
            <?php if ($type === 'city'): ?>
            <div class="form-group">
                <label class="form-label" for="office_address">Physical office address</label>
                <textarea class="form-input" id="office_address" name="office_address" rows="2"><?= e($row['office_address'] ?? '') ?></textarea>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-top:var(--space-1)">
                    Leave blank unless there is a genuine walk-in office in this city — filling this in adds LocalBusiness/PostalAddress schema and "visit us" language to the public page.
                </p>
            </div>
            <?php endif; ?>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="meta_title">SEO meta title</label>
                <input class="form-input" type="text" id="meta_title" name="meta_title" value="<?= e($row['meta_title'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="meta_description">SEO meta description</label>
                <textarea class="form-input" id="meta_description" name="meta_description" rows="2"><?= e($row['meta_description'] ?? '') ?></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/locations/?type=<?= e($type) ?>" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));

if ($type === 'state') {
    $where = $search !== '' ? 'WHERE name LIKE :search' : '';
    $stmt = $pdo->prepare("SELECT * FROM states $where ORDER BY zone, name");
} else {
    $where = $search !== '' ? 'WHERE c.name LIKE :search' : '';
    $stmt = $pdo->prepare("SELECT c.*, s.name AS state_name FROM cities c JOIN states s ON s.id = c.state_id $where ORDER BY s.name, c.name");
}
if ($search !== '') {
    $stmt->execute(['search' => "%$search%"]);
} else {
    $stmt->execute();
}
$rows = $stmt->fetchAll();

admin_header_start('Locations', 'locations');
?>
<div class="admin-toolbar" style="justify-content:space-between">
    <div class="button-group">
        <a href="/admin/locations/?type=state" class="btn btn-sm <?= $type === 'state' ? 'btn-primary' : 'btn-outline' ?>">States &amp; UTs</a>
        <a href="/admin/locations/?type=city" class="btn btn-sm <?= $type === 'city' ? 'btn-primary' : 'btn-outline' ?>">Cities</a>
    </div>
    <a href="/admin/locations/?type=<?= e($type) ?>&action=create" class="btn btn-primary">+ Add <?= $type === 'state' ? 'State/UT' : 'City' ?></a>
</div>
<form method="get" action="/admin/locations/" style="display:flex;gap:var(--space-2);margin-bottom:var(--space-4)">
    <input type="hidden" name="type" value="<?= e($type) ?>">
    <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search <?= $type === 'state' ? 'states' : 'cities' ?>…">
    <button type="submit" class="btn btn-outline">Search</button>
</form>
<table class="admin-table">
    <thead><tr><th>Name</th><th><?= $type === 'state' ? 'Zone' : 'State' ?></th><th>Indexable</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($rows as $r): ?>
        <tr>
            <td><?= e($r['name']) ?> <span style="color:var(--text-muted)">(<?= e($r['slug']) ?>)</span></td>
            <td><?= e($type === 'state' ? ($r['zone'] ?? '—') : $r['state_name']) ?></td>
            <td>
                <form method="post" action="/admin/locations/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="type" value="<?= e($type) ?>"><input type="hidden" name="action" value="toggle"><input type="hidden" name="field" value="is_indexable"><input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                <button type="submit" class="badge <?= $r['is_indexable'] ? 'badge-success' : 'badge-neutral' ?>" style="border:none;cursor:pointer"><?= $r['is_indexable'] ? 'Live' : 'Draft' ?></button></form>
            </td>
            <td>
                <form method="post" action="/admin/locations/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="type" value="<?= e($type) ?>"><input type="hidden" name="action" value="toggle"><input type="hidden" name="field" value="is_active"><input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                <button type="submit" class="badge <?= $r['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $r['is_active'] ? 'Active' : 'Hidden' ?></button></form>
            </td>
            <td class="actions">
                <a href="/admin/locations/?type=<?= e($type) ?>&action=edit&id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/locations/" style="display:inline" onsubmit="return confirm('Delete this <?= e($type) ?>?<?= $type === 'state' ? ' This also removes its cities and FAQs.' : '' ?>');">
                    <?= csrf_field() ?><input type="hidden" name="type" value="<?= e($type) ?>"><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php
admin_header_end();
