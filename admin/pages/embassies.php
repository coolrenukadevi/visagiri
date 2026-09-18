<?php
declare(strict_types=1);

/**
 * Manages embassies, consulates, and visa application centres — three
 * structurally identical tables, handled here as one admin page with
 * a "type" selector rather than three near-duplicate pages.
 */

require_permission('content.view');

$tables = [
    'embassy' => ['table' => 'embassies', 'label' => 'Embassy'],
    'consulate' => ['table' => 'consulates', 'label' => 'Consulate'],
    'vac' => ['table' => 'visa_application_centres', 'label' => 'Visa Application Centre'],
];
// SEO fields exist on embassies/consulates (individually meaningful
// destinations) but not visa_application_centres — VACs ship without
// a public detail page of their own to carry meta tags for.
$typesWithSeo = ['embassy', 'consulate'];

$pdo = db();
$countries = $pdo->query('SELECT id, name FROM countries ORDER BY name')->fetchAll();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$type = in_array($_GET['type'] ?? '', array_keys($tables), true) ? $_GET['type'] : 'embassy';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('content.manage');
    csrf_require();
    $postType = in_array($_POST['type'] ?? '', array_keys($tables), true) ? $_POST['type'] : 'embassy';
    $table = $tables[$postType]['table'];
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $stmt = $pdo->prepare("SELECT name FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $oldName = $stmt->fetchColumn() ?: null;
        $pdo->prepare("DELETE FROM $table WHERE id = :id")->execute(['id' => $id]);
        log_action('delete', $table, $id, $oldName, null);
        flash_set('admin_notice', $tables[$postType]['label'] . ' deleted.');
        // Preserves the list's current search/filter state across the
        // delete — reconstructed only from a fixed whitelist of known
        // param names posted back as hidden fields.
        $returnQuery = http_build_query(array_filter([
            'type' => $postType,
            'q' => trim((string) ($_POST['q'] ?? '')),
            'country_id' => $_POST['filter_country_id'] ?? '',
            'city' => trim((string) ($_POST['filter_city'] ?? '')),
        ], static fn($v) => $v !== ''));
        redirect('/admin/embassies/?' . $returnQuery);
    }

    if ($postAction === 'save') {
        $data = [
            'country_id' => (int) ($_POST['country_id'] ?? 0),
            'name' => trim((string) ($_POST['name'] ?? '')),
            'city' => trim((string) ($_POST['city'] ?? '')) ?: null,
            'address' => trim((string) ($_POST['address'] ?? '')) ?: null,
            'phone' => trim((string) ($_POST['phone'] ?? '')) ?: null,
            'website' => trim((string) ($_POST['website'] ?? '')) ?: null,
        ];

        if ($data['name'] === '' || $data['country_id'] === 0) {
            flash_set('admin_error', 'Name and country are required.');
            redirect($id ? "/admin/embassies/?action=edit&id=$id&type=$postType" : "/admin/embassies/?action=create&type=$postType");
        }

        if ($postType === 'vac') {
            $data['operating_hours'] = trim((string) ($_POST['operating_hours'] ?? '')) ?: null;
        }

        if (in_array($postType, $typesWithSeo, true)) {
            $data['meta_title'] = trim((string) ($_POST['meta_title'] ?? '')) ?: null;
            $data['meta_description'] = trim((string) ($_POST['meta_description'] ?? '')) ?: null;
        }

        if ($id) {
            $data['id'] = $id;
            $oldStmt = $pdo->prepare("SELECT name FROM $table WHERE id = :id");
            $oldStmt->execute(['id' => $id]);
            $oldName = $oldStmt->fetchColumn() ?: null;
            $pdo->prepare("UPDATE $table SET " . implode(', ', array_map(
                static fn($k) => "$k = :$k",
                array_diff(array_keys($data), ['id'])
            )) . " WHERE id = :id")->execute($data);
            log_action('update', $table, $id, $oldName, $data['name']);
            flash_set('admin_notice', $tables[$postType]['label'] . ' updated.');
        } else {
            $cols = implode(', ', array_keys($data));
            $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
            $pdo->prepare("INSERT INTO $table ($cols) VALUES ($placeholders)")->execute($data);
            log_action('create', $table, (int) $pdo->lastInsertId(), null, $data['name']);
            flash_set('admin_notice', $tables[$postType]['label'] . ' added.');
        }
        redirect('/admin/embassies/?type=' . $postType);
    }
}

if ($action === 'create' || $action === 'edit') {
    require_permission('content.manage');
    $table = $tables[$type]['table'];
    $entry = ['country_id' => '', 'name' => '', 'city' => '', 'address' => '', 'phone' => '', 'website' => '', 'operating_hours' => '', 'meta_title' => '', 'meta_description' => ''];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare("SELECT * FROM $table WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Entry not found.');
            redirect('/admin/embassies/?type=' . $type);
        }
        $entry = $found;
    }

    admin_header_start(($action === 'edit' ? 'Edit ' : 'Add ') . $tables[$type]['label'], 'embassies');
    admin_subnav('content', 'embassies');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/embassies/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="type" value="<?= e($type) ?>">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="country_id">Country</label>
                    <select class="form-select" id="country_id" name="country_id" required>
                        <option value="">Select country</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"<?= (int) ($entry['country_id'] ?? 0) === (int) $c['id'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="name">Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($entry['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="city">City</label>
                    <input class="form-input" type="text" id="city" name="city" value="<?= e($entry['city'] ?? '') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Phone</label>
                    <input class="form-input" type="text" id="phone" name="phone" value="<?= e($entry['phone'] ?? '') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="website">Website</label>
                    <input class="form-input" type="url" id="website" name="website" value="<?= e($entry['website'] ?? '') ?>">
                </div>
                <?php if ($type === 'vac'): ?>
                <div class="form-group">
                    <label class="form-label" for="operating_hours">Operating hours</label>
                    <input class="form-input" type="text" id="operating_hours" name="operating_hours" value="<?= e($entry['operating_hours'] ?? '') ?>">
                </div>
                <?php endif; ?>
            </div>
            <div class="form-group">
                <label class="form-label" for="address">Address</label>
                <textarea class="form-input" id="address" name="address" rows="2"><?= e($entry['address'] ?? '') ?></textarea>
            </div>
            <?php if (in_array($type, $typesWithSeo, true)): ?>
            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="meta_title">SEO meta title</label>
                <input class="form-input" type="text" id="meta_title" name="meta_title" value="<?= e($entry['meta_title'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="meta_description">SEO meta description</label>
                <textarea class="form-input" id="meta_description" name="meta_description" rows="2"><?= e($entry['meta_description'] ?? '') ?></textarea>
            </div>
            <?php endif; ?>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/embassies/?type=<?= e($type) ?>" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$table = $tables[$type]['table'];

$search = trim((string) ($_GET['q'] ?? ''));
$countryFilter = (int) ($_GET['country_id'] ?? 0) ?: null;
$cityFilter = trim((string) ($_GET['city'] ?? ''));

$conditions = [];
$params = [];
if ($search !== '') {
    $conditions[] = 'e.name LIKE :search';
    $params['search'] = "%$search%";
}
if ($countryFilter) {
    $conditions[] = 'e.country_id = :country_id';
    $params['country_id'] = $countryFilter;
}
if ($cityFilter !== '') {
    $conditions[] = 'e.city LIKE :city';
    $params['city'] = "%$cityFilter%";
}
$where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';

$stmt = $pdo->prepare("SELECT e.*, c.name AS country_name FROM $table e JOIN countries c ON c.id = e.country_id $where ORDER BY c.name, e.name");
$stmt->execute($params);
$entries = $stmt->fetchAll();

$filterState = array_filter([
    'q' => $search,
    'country_id' => $countryFilter ?: '',
    'city' => $cityFilter,
], static fn($v) => $v !== '' && $v !== null);
$hasFilters = $filterState !== [];

admin_header_start('Embassies / Consulates / VACs', 'embassies');
admin_subnav('content', 'embassies');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <?php foreach ($tables as $key => $meta): ?>
        <a href="/admin/embassies/?type=<?= $key ?>" class="btn btn-sm <?= $type === $key ? 'btn-primary' : 'btn-outline' ?>"><?= e($meta['label']) ?>s</a>
        <?php endforeach; ?>
    </div>
    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/embassies/?action=create&type=<?= e($type) ?>" class="btn btn-primary">+ Add <?= e($tables[$type]['label']) ?></a>
    <?php endif; ?>
</div>
<form method="get" action="/admin/embassies/" style="display:flex;gap:var(--space-2);flex-wrap:wrap;align-items:center;margin-top:var(--space-3)">
    <input type="hidden" name="type" value="<?= e($type) ?>">
    <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search by name…" style="min-width:200px">
    <select class="form-select" name="country_id">
        <option value="">All countries</option>
        <?php foreach ($countries as $c): ?>
        <option value="<?= (int) $c['id'] ?>" <?= $countryFilter === (int) $c['id'] ? 'selected' : '' ?>><?= e($c['name']) ?></option>
        <?php endforeach; ?>
    </select>
    <input class="form-input" type="text" name="city" value="<?= e($cityFilter) ?>" placeholder="City…" style="max-width:160px">
    <button type="submit" class="btn btn-outline">Filter</button>
    <?php if ($hasFilters): ?>
    <a href="/admin/embassies/?type=<?= e($type) ?>" class="btn btn-outline">Reset</a>
    <?php endif; ?>
</form>
<?php if ($entries): ?>
<table class="admin-table" style="margin-top:var(--space-4)">
    <thead><tr><th>Country</th><th>Name</th><th>City</th><th>Phone</th><th></th></tr></thead>
    <tbody>
    <?php $canManageContent = has_permission('content.manage'); ?>
    <?php $returnFieldsHtml = '<input type="hidden" name="q" value="' . e($search) . '"><input type="hidden" name="filter_country_id" value="' . (int) ($countryFilter ?? 0) . '"><input type="hidden" name="filter_city" value="' . e($cityFilter) . '">'; ?>
    <?php foreach ($entries as $entry): ?>
        <tr>
            <td><?= e($entry['country_name']) ?></td>
            <td><?= e($entry['name']) ?></td>
            <td><?= e($entry['city'] ?? '—') ?></td>
            <td><?= e($entry['phone'] ?? '—') ?></td>
            <td class="actions">
                <?php if ($canManageContent): ?>
                <a href="/admin/embassies/?action=edit&id=<?= (int) $entry['id'] ?>&type=<?= e($type) ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/embassies/" style="display:inline" onsubmit="return confirm('Delete this entry?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="type" value="<?= e($type) ?>"><input type="hidden" name="id" value="<?= (int) $entry['id'] ?>"><?= $returnFieldsHtml ?>
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state" style="margin-top:var(--space-4)"><?= $hasFilters ? 'No ' . strtolower(e($tables[$type]['label'])) . ' entries match your filters.' : 'No ' . strtolower(e($tables[$type]['label'])) . ' entries published yet.' ?></p>
<?php endif; ?>
<?php
admin_header_end();
