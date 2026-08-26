<?php
declare(strict_types=1);

require_permission('content.manage');

$pdo = db();
$regions = $pdo->query('SELECT id, name FROM regions ORDER BY name')->fetchAll();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

// --- Handle POST (create, update, delete, toggle) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('DELETE FROM countries WHERE id = :id')->execute(['id' => $id]);
        flash_set('admin_notice', 'Country deleted.');
        redirect('/admin/countries/');
    }

    if ($postAction === 'toggle' && $id) {
        $field = in_array($_POST['field'] ?? '', ['is_active', 'is_popular_destination', 'is_schengen'], true) ? $_POST['field'] : null;
        if ($field) {
            $pdo->prepare("UPDATE countries SET $field = NOT $field WHERE id = :id")->execute(['id' => $id]);
        }
        redirect('/admin/countries/');
    }

    if ($postAction === 'save') {
        $name = trim((string) ($_POST['name'] ?? ''));
        $slug = trim((string) ($_POST['slug'] ?? '')) ?: slugify($name);
        $data = [
            'name' => $name,
            'slug' => $slug,
            'iso2' => strtoupper(trim((string) ($_POST['iso2'] ?? ''))) ?: null,
            'iso3' => strtoupper(trim((string) ($_POST['iso3'] ?? ''))) ?: null,
            'region_id' => (int) ($_POST['region_id'] ?? 0) ?: null,
            'is_popular_destination' => isset($_POST['is_popular_destination']) ? 1 : 0,
            'is_schengen' => isset($_POST['is_schengen']) ? 1 : 0,
            'is_gcc' => isset($_POST['is_gcc']) ? 1 : 0,
            'is_asean' => isset($_POST['is_asean']) ? 1 : 0,
            'is_saarc' => isset($_POST['is_saarc']) ? 1 : 0,
            'is_middle_east' => isset($_POST['is_middle_east']) ? 1 : 0,
            'is_caribbean' => isset($_POST['is_caribbean']) ? 1 : 0,
            'visa_policy_for_indians' => in_array($_POST['visa_policy_for_indians'] ?? '', ['visa_required', 'visa_free', 'visa_on_arrival', 'evisa'], true) ? $_POST['visa_policy_for_indians'] : null,
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
            'meta_title' => trim((string) ($_POST['meta_title'] ?? '')) ?: null,
            'meta_description' => trim((string) ($_POST['meta_description'] ?? '')) ?: null,
        ];

        if ($name === '') {
            flash_set('admin_error', 'Country name is required.');
            redirect($id ? "/admin/countries/?action=edit&id=$id" : '/admin/countries/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $pdo->prepare(
                'UPDATE countries SET name=:name, slug=:slug, iso2=:iso2, iso3=:iso3, region_id=:region_id,
                 is_popular_destination=:is_popular_destination, is_schengen=:is_schengen,
                 is_gcc=:is_gcc, is_asean=:is_asean, is_saarc=:is_saarc, is_middle_east=:is_middle_east, is_caribbean=:is_caribbean,
                 visa_policy_for_indians=:visa_policy_for_indians, is_active=:is_active,
                 meta_title=:meta_title, meta_description=:meta_description WHERE id=:id'
            )->execute($data);
            flash_set('admin_notice', 'Country updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO countries (name, slug, iso2, iso3, region_id, is_popular_destination, is_schengen,
                 is_gcc, is_asean, is_saarc, is_middle_east, is_caribbean, visa_policy_for_indians, is_active, meta_title, meta_description)
                 VALUES (:name, :slug, :iso2, :iso3, :region_id, :is_popular_destination, :is_schengen,
                 :is_gcc, :is_asean, :is_saarc, :is_middle_east, :is_caribbean, :visa_policy_for_indians, :is_active, :meta_title, :meta_description)'
            )->execute($data);
            flash_set('admin_notice', 'Country added.');
        }
        redirect('/admin/countries/');
    }
}

// --- Create/Edit form ---
if ($action === 'create' || $action === 'edit') {
    $country = [
        'name' => '', 'slug' => '', 'iso2' => '', 'iso3' => '', 'region_id' => '',
        'is_popular_destination' => 0, 'is_schengen' => 0,
        'is_gcc' => 0, 'is_asean' => 0, 'is_saarc' => 0, 'is_middle_east' => 0, 'is_caribbean' => 0,
        'visa_policy_for_indians' => null, 'is_active' => 1, 'meta_title' => '', 'meta_description' => '',
    ];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM countries WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Country not found.');
            redirect('/admin/countries/');
        }
        $country = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit Country' : 'Add Country', 'countries');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/countries/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($country['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="slug">Slug</label>
                    <input class="form-input" type="text" id="slug" name="slug" value="<?= e($country['slug']) ?>" placeholder="auto-generated if blank">
                </div>
                <div class="form-group">
                    <label class="form-label" for="iso2">ISO2</label>
                    <input class="form-input" type="text" id="iso2" name="iso2" maxlength="2" value="<?= e($country['iso2'] ?? '') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="iso3">ISO3</label>
                    <input class="form-input" type="text" id="iso3" name="iso3" maxlength="3" value="<?= e($country['iso3'] ?? '') ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="region_id">Region</label>
                    <select class="form-select" id="region_id" name="region_id">
                        <option value="">— None —</option>
                        <?php foreach ($regions as $r): ?>
                        <option value="<?= (int) $r['id'] ?>"<?= (int) $country['region_id'] === (int) $r['id'] ? ' selected' : '' ?>><?= e($r['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_popular_destination" <?= $country['is_popular_destination'] ? 'checked' : '' ?>> Popular destination</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_schengen" <?= $country['is_schengen'] ? 'checked' : '' ?>> Schengen member</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_gcc" <?= $country['is_gcc'] ? 'checked' : '' ?>> GCC member</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_asean" <?= $country['is_asean'] ? 'checked' : '' ?>> ASEAN member</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_saarc" <?= $country['is_saarc'] ? 'checked' : '' ?>> SAARC member</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_middle_east" <?= $country['is_middle_east'] ? 'checked' : '' ?>> Middle East</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_caribbean" <?= $country['is_caribbean'] ? 'checked' : '' ?>> Caribbean</label></div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_active" <?= $country['is_active'] ? 'checked' : '' ?>> Active (visible on site)</label></div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="visa_policy_for_indians">Visa policy for Indian passport holders</label>
                <select class="form-select" id="visa_policy_for_indians" name="visa_policy_for_indians">
                    <option value="">— Not yet verified —</option>
                    <option value="visa_required" <?= $country['visa_policy_for_indians'] === 'visa_required' ? 'selected' : '' ?>>Visa Required</option>
                    <option value="visa_free" <?= $country['visa_policy_for_indians'] === 'visa_free' ? 'selected' : '' ?>>Visa Free</option>
                    <option value="visa_on_arrival" <?= $country['visa_policy_for_indians'] === 'visa_on_arrival' ? 'selected' : '' ?>>Visa on Arrival</option>
                    <option value="evisa" <?= $country['visa_policy_for_indians'] === 'evisa' ? 'selected' : '' ?>>eVisa</option>
                </select>
                <p style="color:var(--text-muted);font-size:var(--font-size-sm);margin-top:var(--space-1)">
                    Only set this once you've verified it from an authoritative source — it controls whether this country appears in the public Visa Status directories.
                </p>
            </div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="meta_title">SEO meta title</label>
                <input class="form-input" type="text" id="meta_title" name="meta_title" value="<?= e($country['meta_title'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="meta_description">SEO meta description</label>
                <textarea class="form-input" id="meta_description" name="meta_description" rows="2"><?= e($country['meta_description'] ?? '') ?></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/countries/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$search = trim((string) ($_GET['q'] ?? ''));
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 30;
$offset = ($page - 1) * $perPage;

$where = '';
$params = [];
if ($search !== '') {
    $where = 'WHERE c.name LIKE :search';
    $params['search'] = "%$search%";
}

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM countries c $where");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));

$stmt = $pdo->prepare(
    "SELECT c.*, r.name AS region_name FROM countries c LEFT JOIN regions r ON r.id = c.region_id
     $where ORDER BY c.name LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$countries = $stmt->fetchAll();

admin_header_start('Countries', 'countries');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/countries/" style="display:flex;gap:var(--space-2)">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search countries…">
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
    <a href="/admin/countries/?action=create" class="btn btn-primary">+ Add Country</a>
</div>
<table class="admin-table">
    <thead><tr><th>Name</th><th>Region</th><th>Popular</th><th>Schengen</th><th>Visa Policy (India)</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($countries as $c): ?>
        <tr>
            <td><?= e($c['name']) ?> <span style="color:var(--text-muted)">(<?= e($c['slug']) ?>)</span></td>
            <td><?= e($c['region_name'] ?? '—') ?></td>
            <td>
                <form method="post" action="/admin/countries/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="field" value="is_popular_destination"><input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
                <button type="submit" class="badge <?= $c['is_popular_destination'] ? 'badge-success' : 'badge-neutral' ?>" style="border:none;cursor:pointer"><?= $c['is_popular_destination'] ? 'Yes' : 'No' ?></button></form>
            </td>
            <td>
                <form method="post" action="/admin/countries/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="field" value="is_schengen"><input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
                <button type="submit" class="badge <?= $c['is_schengen'] ? 'badge-success' : 'badge-neutral' ?>" style="border:none;cursor:pointer"><?= $c['is_schengen'] ? 'Yes' : 'No' ?></button></form>
            </td>
            <td>
                <?php $policyLabels = ['visa_required' => 'Visa Required', 'visa_free' => 'Visa Free', 'visa_on_arrival' => 'On Arrival', 'evisa' => 'eVisa']; ?>
                <span class="badge <?= $c['visa_policy_for_indians'] ? 'badge-info' : 'badge-neutral' ?>"><?= e($policyLabels[$c['visa_policy_for_indians']] ?? 'Not verified') ?></span>
            </td>
            <td>
                <form method="post" action="/admin/countries/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="field" value="is_active"><input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
                <button type="submit" class="badge <?= $c['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $c['is_active'] ? 'Active' : 'Hidden' ?></button></form>
            </td>
            <td class="actions">
                <a href="/admin/countries/?action=edit&id=<?= (int) $c['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/countries/" style="display:inline" onsubmit="return confirm('Delete this country? This also removes its visa requirements and contact points.');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $c['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5)">
    <?php for ($p = 1; $p <= $totalPages; $p++): ?>
    <a href="/admin/countries/?page=<?= $p ?><?= $search !== '' ? '&q=' . urlencode($search) : '' ?>" class="btn btn-sm <?= $p === $page ? 'btn-primary' : 'btn-outline' ?>"><?= $p ?></a>
    <?php endfor; ?>
</div>
<?php endif; ?>
<?php
admin_header_end();
