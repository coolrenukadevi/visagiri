<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Resource Articles';
$ADMIN_ACTIVE_NAV = 'resource-articles';
$ADMIN_BREADCRUMB = ['CRM', 'Resource Articles'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/resource-articles-db.php';
resource_articles_db();

$categoryFilter = trim($_GET['category'] ?? '');
$statusFilter = trim($_GET['status'] ?? '');

$where = [];
$params = [];
if ($categoryFilter && in_array($categoryFilter, RESOURCE_ARTICLE_CATEGORIES, true)) { $where[] = 'category = :category'; $params['category'] = $categoryFilter; }
if ($statusFilter && in_array($statusFilter, ['draft', 'published'], true)) { $where[] = 'status = :status'; $params['status'] = $statusFilter; }
$whereSql = $where ? ('WHERE ' . implode(' AND ', $where)) : '';

$stmt = $pdo->prepare("SELECT * FROM resource_articles $whereSql ORDER BY updated_at DESC");
$stmt->execute($params);
$articles = $stmt->fetchAll(PDO::FETCH_ASSOC);

$statusCounts = $pdo->query("SELECT status, COUNT(*) AS c FROM resource_articles GROUP BY status")->fetchAll(PDO::FETCH_KEY_PAIR);
$totalArticles = array_sum($statusCounts);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Resource Articles</h1>
        <p class="crm-page-subtitle">Powers the Updates column of the site's Resources mega menu (Visa Updates, Embassy News, Visa Alerts, Entry Requirements). Only <strong>Published</strong> articles show publicly &mdash; nothing here is pre-filled with placeholder content.</p>
    </div>
    <div class="crm-page-actions">
        <a href="resource-article-edit.php" class="crm-btn crm-btn-primary"><i class="fa-solid fa-circle-plus"></i> New Article</a>
    </div>
</div>

<div class="crm-kpi-grid" style="grid-template-columns:repeat(3,1fr);">
    <a href="resource-articles.php" class="crm-kpi"><div class="crm-kpi-value"><?php echo $totalArticles; ?></div><div class="crm-kpi-label">Total Articles</div></a>
    <a href="resource-articles.php?status=published" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-green);"><?php echo $statusCounts['published'] ?? 0; ?></div><div class="crm-kpi-label">Published</div></a>
    <a href="resource-articles.php?status=draft" class="crm-kpi"><div class="crm-kpi-value" style="color:var(--c-grey);"><?php echo $statusCounts['draft'] ?? 0; ?></div><div class="crm-kpi-label">Draft</div></a>
</div>

<form method="get" class="crm-filter-bar" style="margin-bottom:16px;">
    <select name="category" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Categories</option>
        <?php foreach (RESOURCE_ARTICLE_CATEGORIES as $cat): ?>
        <option value="<?php echo $cat; ?>" <?php echo $categoryFilter === $cat ? 'selected' : ''; ?>><?php echo htmlspecialchars(resource_article_category_label($cat)); ?></option>
        <?php endforeach; ?>
    </select>
    <select name="status" onchange="this.form.submit()" style="border:1px solid var(--c-border);border-radius:8px;padding:8px 12px;">
        <option value="">All Statuses</option>
        <option value="published" <?php echo $statusFilter === 'published' ? 'selected' : ''; ?>>Published</option>
        <option value="draft" <?php echo $statusFilter === 'draft' ? 'selected' : ''; ?>>Draft</option>
    </select>
    <?php if ($categoryFilter || $statusFilter): ?><a href="resource-articles.php" class="crm-btn crm-btn-ghost crm-btn-sm">Clear</a><?php endif; ?>
</form>

<div class="crm-card" style="padding:0;">
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Title</th><th>Category</th><th>Status</th><th>Published</th><th>Expires</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($articles as $a): ?>
        <tr>
            <td class="crm-cell-name"><?php echo htmlspecialchars($a['title']); ?></td>
            <td><?php echo htmlspecialchars(resource_article_category_label($a['category'])); ?></td>
            <td><span class="crm-status-badge <?php echo $a['status'] === 'published' ? 'status-published' : 'status-draft'; ?>"><?php echo htmlspecialchars(ucfirst($a['status'])); ?></span></td>
            <td class="crm-cell-sub"><?php echo $a['published_at'] ? htmlspecialchars(date('j M Y', strtotime($a['published_at']))) : '—'; ?></td>
            <td class="crm-cell-sub"><?php echo $a['expires_at'] ? htmlspecialchars(date('j M Y', strtotime($a['expires_at']))) : '—'; ?></td>
            <td>
                <a href="resource-article-edit.php?id=<?php echo (int) $a['id']; ?>" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-pen"></i> Edit</a>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$articles): ?>
        <tr><td colspan="6" class="crm-empty">No articles yet. Click "New Article" to publish the first one.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
