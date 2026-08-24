<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'Content Pages';
$ADMIN_ACTIVE_NAV = 'visa-pages';
$ADMIN_BREADCRUMB = ['CRM', 'Content Pages'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/visa-content-db.php';
visa_content_db();

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'create_page') {
    $countryId = (int) ($_POST['country_id'] ?? 0);
    $categoryId = (int) ($_POST['visa_category_id'] ?? 0);

    $existing = $pdo->prepare('SELECT id FROM country_visa_pages WHERE country_id = ? AND visa_category_id = ?');
    $existing->execute([$countryId, $categoryId]);
    $existingId = $existing->fetchColumn();

    if ($existingId) {
        header('Location: visa-page-edit.php?id=' . (int) $existingId);
        exit;
    }

    $country = $pdo->prepare('SELECT slug FROM countries WHERE id = ?');
    $country->execute([$countryId]);
    $countrySlug = $country->fetchColumn();
    $category = $pdo->prepare('SELECT slug FROM visa_categories WHERE id = ?');
    $category->execute([$categoryId]);
    $categorySlug = $category->fetchColumn();

    if ($countrySlug && $categorySlug) {
        $now = gmdate('c');
        $pdo->prepare('INSERT INTO country_visa_pages (country_id, visa_category_id, page_slug, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?)')
            ->execute([$countryId, $categoryId, visa_page_slug($countrySlug, $categorySlug), 'draft', $now, $now]);
        header('Location: visa-page-edit.php?id=' . (int) $pdo->lastInsertId());
        exit;
    }
}

$countryFilter = (int) ($_GET['country'] ?? 0);
$categoryFilter = (int) ($_GET['category'] ?? 0);
$statusFilter = trim($_GET['status'] ?? '');

$where = [];
$params = [];
if ($countryFilter) { $where[] = 'cvp.country_id = :country'; $params['country'] = $countryFilter; }
if ($categoryFilter) { $where[] = 'cvp.visa_category_id = :category'; $params['category'] = $categoryFilter; }
if ($statusFilter && in_array($statusFilter, VISA_PAGE_STATUSES, true)) { $where[] = 'cvp.status = :status'; $params['status'] = $statusFilter; }
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$pagesStmt = $pdo->prepare("SELECT cvp.id, cvp.page_slug, cvp.status, cvp.official_visa_name, cvp.last_reviewed_date, cvp.reviewed_by,
        c.name AS country_name, c.flag, vc.name AS category_name
    FROM country_visa_pages cvp
    JOIN countries c ON c.id = cvp.country_id
    JOIN visa_categories vc ON vc.id = cvp.visa_category_id
    $whereSql
    ORDER BY c.name ASC, vc.sort_order ASC");
$pagesStmt->execute($params);
$pages = $pagesStmt->fetchAll(PDO::FETCH_ASSOC);

$statusCounts = $pdo->query('SELECT status, COUNT(*) AS c FROM country_visa_pages GROUP BY status')->fetchAll(PDO::FETCH_KEY_PAIR);
$totalPages = array_sum($statusCounts);
$publishedCount = $statusCounts['published'] ?? 0;

$allCountries = $pdo->query('SELECT id, name, flag FROM countries WHERE is_active = 1 ORDER BY name ASC')->fetchAll(PDO::FETCH_ASSOC);
$allCategories = $pdo->query('SELECT id, name FROM visa_categories ORDER BY sort_order ASC')->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Content Pages</h1>
        <p class="crm-page-subtitle">Every country &times; visa-category page. Only <strong>Published</strong> pages are live on the site &mdash; everything else 404s publicly.</p>
    </div>
    <div class="crm-page-actions">
        <button type="button" class="crm-btn crm-btn-primary" id="crmOpenNewPage"><i class="fa-solid fa-file-circle-plus"></i> New Content Page</button>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(5,1fr);">
    <a href="visa-pages.php" class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalPages; ?></div><div class="crm-kpi-label">Total Pages</div></a>
    <a href="visa-pages.php?status=published" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $publishedCount; ?></div><div class="crm-kpi-label">Published</div></a>
    <a href="visa-pages.php?status=draft" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-grey);"><?php echo $statusCounts['draft'] ?? 0; ?></div><div class="crm-kpi-label">Draft</div></a>
    <a href="visa-pages.php?status=under_review" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-amber);"><?php echo $statusCounts['under_review'] ?? 0; ?></div><div class="crm-kpi-label">Under Review</div></a>
    <a href="visa-pages.php?status=needs_update" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-orange);"><?php echo $statusCounts['needs_update'] ?? 0; ?></div><div class="crm-kpi-label">Needs Update</div></a>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <select name="country" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Countries</option>
        <?php foreach ($allCountries as $c): ?>
        <option value="<?php echo (int) $c['id']; ?>" <?php echo $countryFilter === (int) $c['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($c['flag'] . ' ' . $c['name']); ?></option>
        <?php endforeach; ?>
    </select>
    <select name="category" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Categories</option>
        <?php foreach ($allCategories as $cat): ?>
        <option value="<?php echo (int) $cat['id']; ?>" <?php echo $categoryFilter === (int) $cat['id'] ? 'selected' : ''; ?>><?php echo htmlspecialchars($cat['name']); ?></option>
        <?php endforeach; ?>
    </select>
    <select name="status" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Statuses</option>
        <?php foreach (VISA_PAGE_STATUSES as $s): ?>
        <option value="<?php echo $s; ?>" <?php echo $statusFilter === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars(visa_page_status_label($s)); ?></option>
        <?php endforeach; ?>
    </select>
    <?php if ($countryFilter || $categoryFilter || $statusFilter): ?><a href="visa-pages.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Country</th><th>Visa Category</th><th>Official Visa Name</th><th>Status</th><th>Last Reviewed</th><th>Reviewed By</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($pages as $p): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($p['flag'] . ' ' . $p['country_name']); ?></td>
            <td><?php echo htmlspecialchars($p['category_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['official_visa_name'] ?: '—'); ?></td>
            <td><span class="crm-status-badge <?php echo visa_page_status_class($p['status']); ?>"><?php echo htmlspecialchars(visa_page_status_label($p['status'])); ?></span></td>
            <td class="crm-cell-sub"><?php echo $p['last_reviewed_date'] ? htmlspecialchars(date('j M Y', strtotime($p['last_reviewed_date']))) : '—'; ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['reviewed_by'] ?: '—'); ?></td>
            <td>
                <a href="visa-page-edit.php?id=<?php echo (int) $p['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-pen"></i> Edit</a>
                <?php if ($p['status'] === 'published'): ?>
                <a href="<?php echo htmlspecialchars('/' . visa_country_page_url($p['page_slug'])); ?>" target="_blank" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-arrow-up-right-from-square"></i></a>
                <?php endif; ?>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$pages): ?>
        <tr><td colspan="7" class="crm-empty">No content pages match these filters.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-drawer-overlay" id="crmNewPageDrawer">
    <div class="crm-drawer" style="max-width:440px;">
        <div class="crm-drawer-header"><h2>New Content Page</h2><button type="button" class="crm-drawer-close" id="crmNewPageClose"><i class="fa-solid fa-xmark"></i></button></div>
        <div class="crm-drawer-body">
            <form method="post">
                <input type="hidden" name="action" value="create_page">
                <div class="crm-form-field" style="margin-bottom:14px;">
                    <label>Country</label>
                    <select name="country_id" required>
                        <?php foreach ($allCountries as $c): ?>
                        <option value="<?php echo (int) $c['id']; ?>"><?php echo htmlspecialchars($c['flag'] . ' ' . $c['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="crm-form-field" style="margin-bottom:14px;">
                    <label>Visa Category</label>
                    <select name="visa_category_id" required>
                        <?php foreach ($allCategories as $cat): ?>
                        <option value="<?php echo (int) $cat['id']; ?>"><?php echo htmlspecialchars($cat['name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <p class="crm-cell-sub" style="margin-bottom:14px;">If this combination already has a page, you'll be taken straight to editing it.</p>
                <button type="submit" class="crm-btn crm-btn-primary">Create / Open</button>
            </form>
        </div>
    </div>
</div>
<script>
document.getElementById('crmOpenNewPage').addEventListener('click', function () {
    var d = document.getElementById('crmNewPageDrawer');
    d.hidden = false;
    requestAnimationFrame(function () { d.classList.add('is-open', 'is-visible'); });
});
document.getElementById('crmNewPageClose').addEventListener('click', function () {
    var d = document.getElementById('crmNewPageDrawer');
    d.classList.remove('is-visible');
    setTimeout(function () { d.classList.remove('is-open'); d.hidden = true; }, 250);
});
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
