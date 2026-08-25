<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'Countries';
$ADMIN_ACTIVE_NAV = 'countries';
$ADMIN_BREADCRUMB = ['CRM', 'Countries'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/visa-content-db.php';
visa_content_db();

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'save_country') {
        $id = (int) ($_POST['id'] ?? 0);
        $name = trim($_POST['name'] ?? '');
        $slug = strtolower(trim($_POST['slug'] ?? ''));
        $region = trim($_POST['region'] ?? '');

        if ($name === '' || $slug === '' || !preg_match('#^[a-z0-9-]+$#', $slug) || !in_array($region, VISA_COUNTRY_REGIONS, true)) {
            $error = 'Please provide a name, a valid lowercase-hyphen slug, and a region.';
        } else {
            $dupStmt = $pdo->prepare('SELECT id FROM countries WHERE slug = ? AND id != ?');
            $dupStmt->execute([$slug, $id]);
            if ($dupStmt->fetchColumn()) {
                $error = 'That slug is already used by another country.';
            } else {
                $fields = [
                    'name' => $name,
                    'official_name' => trim($_POST['official_name'] ?? '') ?: null,
                    'iso2' => strtoupper(trim($_POST['iso2'] ?? '')) ?: null,
                    'iso3' => strtoupper(trim($_POST['iso3'] ?? '')) ?: null,
                    'slug' => $slug,
                    'capital' => trim($_POST['capital'] ?? '') ?: null,
                    'region' => $region,
                    'sub_region' => trim($_POST['sub_region'] ?? '') ?: null,
                    'currency' => trim($_POST['currency'] ?? '') ?: null,
                    'currency_code' => strtoupper(trim($_POST['currency_code'] ?? '')) ?: null,
                    'flag' => trim($_POST['flag'] ?? '') ?: null,
                    'popularity' => (int) ($_POST['popularity'] ?? 0),
                    'is_active' => isset($_POST['is_active']) ? 1 : 0,
                ];
                if ($id > 0) {
                    $fields['updated_at'] = gmdate('c');
                    $fields['id'] = $id;
                    $sets = implode(', ', array_map(function ($k) { return "$k = :$k"; }, array_diff(array_keys($fields), ['id'])));
                    $pdo->prepare("UPDATE countries SET $sets WHERE id = :id")->execute($fields);
                } else {
                    $fields['created_at'] = gmdate('c');
                    $fields['updated_at'] = $fields['created_at'];
                    $cols = implode(', ', array_keys($fields));
                    $params = implode(', ', array_map(function ($k) { return ":$k"; }, array_keys($fields)));
                    $pdo->prepare("INSERT INTO countries ($cols) VALUES ($params)")->execute($fields);
                }
                header('Location: countries.php');
                exit;
            }
        }
    } elseif ($action === 'toggle_active') {
        $id = (int) ($_POST['id'] ?? 0);
        $pdo->prepare('UPDATE countries SET is_active = 1 - is_active, updated_at = ? WHERE id = ?')->execute([gmdate('c'), $id]);
        header('Location: countries.php' . (isset($_GET['q']) || isset($_GET['region']) ? '?' . http_build_query($_GET) : ''));
        exit;
    }
}

$q = trim($_GET['q'] ?? '');
$regionFilter = trim($_GET['region'] ?? '');
$where = [];
$params = [];
if ($q !== '') {
    $where[] = '(c.name LIKE :q OR c.slug LIKE :q)';
    $params['q'] = '%' . $q . '%';
}
if ($regionFilter !== '') {
    $where[] = 'c.region = :region';
    $params['region'] = $regionFilter;
}
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$sql = "SELECT c.*,
        (SELECT COUNT(*) FROM country_visa_pages cvp WHERE cvp.country_id = c.id AND cvp.status = 'published') AS published_count,
        (SELECT COUNT(*) FROM enquiries e WHERE e.destination_country = c.name AND e.archived_at IS NULL) AS enquiry_count
    FROM countries c
    $whereSql
    ORDER BY c.popularity DESC, c.name ASC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$countries = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalCountries = (int) $pdo->query('SELECT COUNT(*) FROM countries')->fetchColumn();
$activeCountries = (int) $pdo->query('SELECT COUNT(*) FROM countries WHERE is_active = 1')->fetchColumn();
$countriesWithContent = (int) $pdo->query("SELECT COUNT(DISTINCT country_id) FROM country_visa_pages WHERE status = 'published'")->fetchColumn();
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Countries</h1>
        <p class="crm-page-subtitle">Master list backing the /countries/ SEO pages, the mega-menu and the enquiry form.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenAddCountry"><i class="fa-solid fa-earth-americas"></i> Add Country</button>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalCountries; ?></div><div class="crm-kpi-label">Total Countries</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $activeCountries; ?></div><div class="crm-kpi-label">Active</div></div>
    <div class="crm-kpi"><div class="crm-kpi-value"><?php echo $countriesWithContent; ?></div><div class="crm-kpi-label">With Published Visa Content</div></div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>" placeholder="Search name or slug..." class="crm-btn-sm" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;min-width:220px;">
    <select name="region" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Regions</option>
        <?php foreach (VISA_COUNTRY_REGIONS as $r): ?>
        <option value="<?php echo htmlspecialchars($r); ?>" <?php echo $regionFilter === $r ? 'selected' : ''; ?>><?php echo htmlspecialchars($r); ?></option>
        <?php endforeach; ?>
    </select>
    <button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm">Filter</button>
    <?php if ($q || $regionFilter): ?><a href="countries.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Country</th><th>Region</th><th>Slug</th><th>Popularity</th><th>Published Pages</th><th>Enquiries</th><th>Status</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($countries as $c): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($c['flag'] ?: ''); ?> <?php echo htmlspecialchars($c['name']); ?></td>
            <td><?php echo htmlspecialchars($c['region'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($c['slug']); ?></td>
            <td><?php echo (int) $c['popularity']; ?></td>
            <td><?php echo (int) $c['published_count'] > 0 ? '<a href="visa-pages.php?country=' . (int) $c['id'] . '">' . (int) $c['published_count'] . '</a>' : '<span class="crm-cell-sub">0</span>'; ?></td>
            <td><?php echo (int) $c['enquiry_count'] > 0 ? '<a href="enquiries.php?country=' . urlencode($c['name']) . '">' . (int) $c['enquiry_count'] . '</a>' : '<span class="crm-cell-sub">0</span>'; ?></td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="toggle_active">
                    <input type="hidden" name="id" value="<?php echo (int) $c['id']; ?>">
                    <button type="submit" class="crm-status-badge <?php echo $c['is_active'] ? 'status-published' : 'status-archived'; ?>" style="border:none;cursor:pointer;"><?php echo $c['is_active'] ? 'Active' : 'Inactive'; ?></button>
                </form>
            </td>
            <td>
                <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="openCountryDrawer(<?php echo htmlspecialchars(json_encode($c), ENT_QUOTES); ?>)"><i class="fa-solid fa-pen"></i></button>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$countries): ?>
        <tr><td colspan="8" class="crm-empty">No countries match these filters.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmCountryDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header"><h2 id="crmCountryDrawerTitle">Add Country</h2><button type="button" class="crm-drawer-close" id="crmCountryDrawerClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post" id="crmCountryForm">
                <input type="hidden" name="action" value="save_country">
                <input type="hidden" name="id" id="cfId" value="">
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-flag"></i> Identity</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Name *</label><input type="text" name="name" id="cfName" required></div>
                        <div class="crm-form-field"><label>Official Name</label><input type="text" name="official_name" id="cfOfficialName"></div>
                        <div class="crm-form-field"><label>Slug *</label><input type="text" name="slug" id="cfSlug" pattern="[a-z0-9-]+" required></div>
                        <div class="crm-form-field"><label>Flag Emoji</label><input type="text" name="flag" id="cfFlag" maxlength="8"></div>
                        <div class="crm-form-field"><label>ISO2</label><input type="text" name="iso2" id="cfIso2" maxlength="2"></div>
                        <div class="crm-form-field"><label>ISO3</label><input type="text" name="iso3" id="cfIso3" maxlength="3"></div>
                    </div>
                </div>
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-earth-asia"></i> Geography</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Region *</label>
                            <select name="region" id="cfRegion" required>
                                <option value="">Select region</option>
                                <?php foreach (VISA_COUNTRY_REGIONS as $r): ?><option value="<?php echo htmlspecialchars($r); ?>"><?php echo htmlspecialchars($r); ?></option><?php endforeach; ?>
                            </select>
                        </div>
                        <div class="crm-form-field"><label>Sub-region</label><input type="text" name="sub_region" id="cfSubRegion"></div>
                        <div class="crm-form-field"><label>Capital</label><input type="text" name="capital" id="cfCapital"></div>
                        <div class="crm-form-field"><label>Popularity (0&ndash;100)</label><input type="number" name="popularity" id="cfPopularity" min="0" max="100" value="0"></div>
                    </div>
                </div>
                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-coins"></i> Currency</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Currency Name</label><input type="text" name="currency" id="cfCurrency"></div>
                        <div class="crm-form-field"><label>Currency Code</label><input type="text" name="currency_code" id="cfCurrencyCode" maxlength="3"></div>
                    </div>
                </div>
                <div class="crm-form-field" style="margin-bottom:16px;">
                    <label style="display:flex;align-items:center;gap:8px;"><input type="checkbox" name="is_active" id="cfIsActive" checked style="width:auto;"> Active (visible on the site)</label>
                </div>
                <button type="submit" class="crm-btn crm-btn-primary">Save Country</button>
            </form>
        </div>
    </div>
</div>

<script>
var countryDrawer = document.getElementById('crmCountryDrawer');
function openCountryDrawer(data) {
    data = data || {};
    document.getElementById('crmCountryDrawerTitle').textContent = data.id ? 'Edit Country' : 'Add Country';
    document.getElementById('cfId').value = data.id || '';
    document.getElementById('cfName').value = data.name || '';
    document.getElementById('cfOfficialName').value = data.official_name || '';
    document.getElementById('cfSlug').value = data.slug || '';
    document.getElementById('cfFlag').value = data.flag || '';
    document.getElementById('cfIso2').value = data.iso2 || '';
    document.getElementById('cfIso3').value = data.iso3 || '';
    document.getElementById('cfRegion').value = data.region || '';
    document.getElementById('cfSubRegion').value = data.sub_region || '';
    document.getElementById('cfCapital').value = data.capital || '';
    document.getElementById('cfPopularity').value = data.popularity || 0;
    document.getElementById('cfCurrency').value = data.currency || '';
    document.getElementById('cfCurrencyCode').value = data.currency_code || '';
    document.getElementById('cfIsActive').checked = data.id ? !!parseInt(data.is_active, 10) : true;
    countryDrawer.hidden = false;
    requestAnimationFrame(function () { countryDrawer.classList.add('is-open', 'is-visible'); });
}
document.getElementById('crmOpenAddCountry').addEventListener('click', function () { openCountryDrawer(null); });
document.getElementById('crmCountryDrawerClose').addEventListener('click', function () {
    countryDrawer.classList.remove('is-visible');
    setTimeout(function () { countryDrawer.classList.remove('is-open'); countryDrawer.hidden = true; }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
