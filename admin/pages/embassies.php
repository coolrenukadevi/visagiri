<?php
declare(strict_types=1);

/**
 * Manages embassies, consulates, and visa application centres — three
 * structurally identical tables, handled here as one admin page with
 * a "type" selector rather than three near-duplicate pages.
 */

$tables = [
    'embassy' => ['table' => 'embassies', 'label' => 'Embassy'],
    'consulate' => ['table' => 'consulates', 'label' => 'Consulate'],
    'vac' => ['table' => 'visa_application_centres', 'label' => 'Visa Application Centre'],
];

$pdo = db();
$countries = $pdo->query('SELECT id, name FROM countries ORDER BY name')->fetchAll();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : null;
$type = in_array($_GET['type'] ?? '', array_keys($tables), true) ? $_GET['type'] : 'embassy';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postType = in_array($_POST['type'] ?? '', array_keys($tables), true) ? $_POST['type'] : 'embassy';
    $table = $tables[$postType]['table'];
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare("DELETE FROM $table WHERE id = :id")->execute(['id' => $id]);
        flash_set('admin_notice', $tables[$postType]['label'] . ' deleted.');
        redirect('/admin/embassies/?type=' . $postType);
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

        if ($id) {
            $data['id'] = $id;
            $pdo->prepare("UPDATE $table SET " . implode(', ', array_map(
                static fn($k) => "$k = :$k",
                array_diff(array_keys($data), ['id'])
            )) . " WHERE id = :id")->execute($data);
            flash_set('admin_notice', $tables[$postType]['label'] . ' updated.');
        } else {
            $cols = implode(', ', array_keys($data));
            $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
            $pdo->prepare("INSERT INTO $table ($cols) VALUES ($placeholders)")->execute($data);
            flash_set('admin_notice', $tables[$postType]['label'] . ' added.');
        }
        redirect('/admin/embassies/?type=' . $postType);
    }
}

if ($action === 'create' || $action === 'edit') {
    $table = $tables[$type]['table'];
    $entry = ['country_id' => '', 'name' => '', 'city' => '', 'address' => '', 'phone' => '', 'website' => '', 'operating_hours' => ''];
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
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/embassies/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="type" value="<?= e($type) ?>">
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
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/embassies/?type=<?= e($type) ?>" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$table = $tables[$type]['table'];
$entries = $pdo->query("SELECT e.*, c.name AS country_name FROM $table e JOIN countries c ON c.id = e.country_id ORDER BY c.name, e.name")->fetchAll();

admin_header_start('Embassies / Consulates / VACs', 'embassies');
?>
<div class="admin-toolbar">
    <div class="button-group">
        <?php foreach ($tables as $key => $meta): ?>
        <a href="/admin/embassies/?type=<?= $key ?>" class="btn btn-sm <?= $type === $key ? 'btn-primary' : 'btn-outline' ?>"><?= e($meta['label']) ?>s</a>
        <?php endforeach; ?>
    </div>
    <a href="/admin/embassies/?action=create&type=<?= e($type) ?>" class="btn btn-primary">+ Add <?= e($tables[$type]['label']) ?></a>
</div>
<?php if ($entries): ?>
<table class="admin-table">
    <thead><tr><th>Country</th><th>Name</th><th>City</th><th>Phone</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($entries as $entry): ?>
        <tr>
            <td><?= e($entry['country_name']) ?></td>
            <td><?= e($entry['name']) ?></td>
            <td><?= e($entry['city'] ?? '—') ?></td>
            <td><?= e($entry['phone'] ?? '—') ?></td>
            <td class="actions">
                <a href="/admin/embassies/?action=edit&id=<?= (int) $entry['id'] ?>&type=<?= e($type) ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/embassies/" style="display:inline" onsubmit="return confirm('Delete this entry?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="type" value="<?= e($type) ?>"><input type="hidden" name="id" value="<?= (int) $entry['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No <?= strtolower(e($tables[$type]['label'])) ?> entries published yet.</p>
<?php endif; ?>
<?php
admin_header_end();
