<?php
ob_start();
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/resource-articles-db.php';
resource_articles_db();

$id = (int) ($_GET['id'] ?? 0);
$article = null;
if ($id) {
    $stmt = $pdo->prepare('SELECT * FROM resource_articles WHERE id = ?');
    $stmt->execute([$id]);
    $article = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$article) {
        http_response_code(404);
        echo '<div class="crm-card">Article not found. <a href="resource-articles.php">Back to Resource Articles</a></div>';
        require __DIR__ . '/includes/layout-bottom.php';
        exit;
    }
}

$ADMIN_PAGE_TITLE = $article ? 'Edit Article' : 'New Article';
$ADMIN_ACTIVE_NAV = 'resource-articles';
$ADMIN_BREADCRUMB = ['CRM', 'Resource Articles', $article ? 'Edit' : 'New'];

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_article') {
    $category = $_POST['category'] ?? '';
    $title = trim($_POST['title'] ?? '');
    $status = ($_POST['status'] ?? 'draft') === 'published' ? 'published' : 'draft';
    $excerpt = trim($_POST['excerpt'] ?? '') ?: null;
    $bodyHtml = trim($_POST['body_html'] ?? '') ?: null;
    $sourceName = trim($_POST['source_name'] ?? '') ?: null;
    $sourceUrl = trim($_POST['source_url'] ?? '') ?: null;
    $publishedAt = trim($_POST['published_at'] ?? '') ?: gmdate('Y-m-d');
    $expiresAt = trim($_POST['expires_at'] ?? '') ?: null;

    if (!in_array($category, RESOURCE_ARTICLE_CATEGORIES, true)) { $errors[] = 'Choose a valid category.'; }
    if ($title === '') { $errors[] = 'Title is required.'; }

    if (!$errors) {
        $now = gmdate('c');
        $baseSlug = resource_article_slugify($title);
        $slug = $baseSlug;
        $suffix = 2;
        while (true) {
            $check = $pdo->prepare('SELECT id FROM resource_articles WHERE slug = ? AND id != ?');
            $check->execute([$slug, $id]);
            if (!$check->fetchColumn()) { break; }
            $slug = $baseSlug . '-' . $suffix;
            $suffix++;
        }

        if ($id) {
            $pdo->prepare('UPDATE resource_articles SET category=:category, title=:title, slug=:slug, excerpt=:excerpt, body_html=:body_html, source_name=:source_name, source_url=:source_url, status=:status, published_at=:published_at, expires_at=:expires_at, updated_at=:updated_at WHERE id=:id')
                ->execute([
                    'category' => $category, 'title' => $title, 'slug' => $slug, 'excerpt' => $excerpt,
                    'body_html' => $bodyHtml, 'source_name' => $sourceName, 'source_url' => $sourceUrl,
                    'status' => $status, 'published_at' => $publishedAt, 'expires_at' => $expiresAt,
                    'updated_at' => $now, 'id' => $id,
                ]);
        } else {
            $pdo->prepare('INSERT INTO resource_articles (category, title, slug, excerpt, body_html, source_name, source_url, status, published_at, expires_at, created_by, created_at, updated_at)
                VALUES (:category, :title, :slug, :excerpt, :body_html, :source_name, :source_url, :status, :published_at, :expires_at, :created_by, :now, :now)')
                ->execute([
                    'category' => $category, 'title' => $title, 'slug' => $slug, 'excerpt' => $excerpt,
                    'body_html' => $bodyHtml, 'source_name' => $sourceName, 'source_url' => $sourceUrl,
                    'status' => $status, 'published_at' => $publishedAt, 'expires_at' => $expiresAt,
                    'created_by' => admin_name(), 'now' => $now,
                ]);
            $id = (int) $pdo->lastInsertId();
        }

        header('Location: resource-article-edit.php?id=' . $id . '&saved=1');
        exit;
    }
}

$a = $article ?: ['category' => 'visa-update', 'title' => '', 'excerpt' => '', 'body_html' => '', 'source_name' => '', 'source_url' => '', 'status' => 'draft', 'published_at' => gmdate('Y-m-d'), 'expires_at' => '', 'slug' => ''];
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title"><?php echo $article ? htmlspecialchars($article['title']) : 'New Article'; ?></h1>
        <?php if ($article): ?>
        <p class="crm-page-subtitle">
            <span class="crm-status-badge <?php echo $article['status'] === 'published' ? 'status-published' : 'status-draft'; ?>"><?php echo htmlspecialchars(ucfirst($article['status'])); ?></span>
            &nbsp;&middot; <?php echo htmlspecialchars(resource_article_category_label($article['category'])); ?>
            <?php if ($article['status'] === 'published'): ?>
            &nbsp;&middot; <a href="<?php echo htmlspecialchars('/' . resource_article_public_url($article['category'], $article['slug'])); ?>" target="_blank">View Live <i class="fa-solid fa-arrow-up-right-from-square"></i></a>
            <?php endif; ?>
        </p>
        <?php endif; ?>
    </div>
    <div class="crm-page-actions">
        <a href="resource-articles.php" class="crm-btn crm-btn-ghost">Back to Resource Articles</a>
    </div>
</div>

<?php if (isset($_GET['saved'])): ?>
<div class="crm-card" style="background:var(--c-green-bg);color:var(--c-green);">Saved.</div>
<?php endif; ?>
<?php if ($errors): ?>
<div class="crm-card" style="background:var(--c-red-bg,#fdecea);color:var(--c-red,#c0392b);"><?php echo htmlspecialchars(implode(' ', $errors)); ?></div>
<?php endif; ?>

<form method="post">
<input type="hidden" name="action" value="save_article">
<div class="crm-card">
    <h3>Article</h3>
    <div class="crm-form-grid">
        <div class="crm-form-field"><label>Category</label>
            <select name="category">
                <?php foreach (RESOURCE_ARTICLE_CATEGORIES as $cat): ?>
                <option value="<?php echo $cat; ?>" <?php echo $a['category'] === $cat ? 'selected' : ''; ?>><?php echo htmlspecialchars(resource_article_category_label($cat)); ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="crm-form-field"><label>Status</label>
            <select name="status">
                <option value="draft" <?php echo $a['status'] === 'draft' ? 'selected' : ''; ?>>Draft</option>
                <option value="published" <?php echo $a['status'] === 'published' ? 'selected' : ''; ?>>Published</option>
            </select>
        </div>
        <div class="crm-form-field crm-form-field-full"><label>Title</label><input type="text" name="title" value="<?php echo htmlspecialchars($a['title']); ?>" required></div>
        <div class="crm-form-field crm-form-field-full"><label>Excerpt (one line, shown on the list page)</label><textarea name="excerpt" rows="2"><?php echo htmlspecialchars($a['excerpt'] ?? ''); ?></textarea></div>
        <div class="crm-form-field crm-form-field-full"><label>Body (HTML allowed &mdash; &lt;p&gt;/&lt;ul&gt;/&lt;li&gt; etc.)</label><textarea name="body_html" rows="8"><?php echo htmlspecialchars($a['body_html'] ?? ''); ?></textarea></div>
        <div class="crm-form-field"><label>Source Name (optional)</label><input type="text" name="source_name" value="<?php echo htmlspecialchars($a['source_name'] ?? ''); ?>" placeholder="e.g. Embassy of Japan, New Delhi"></div>
        <div class="crm-form-field"><label>Source URL (optional)</label><input type="url" name="source_url" value="<?php echo htmlspecialchars($a['source_url'] ?? ''); ?>"></div>
        <div class="crm-form-field"><label>Published Date</label><input type="date" name="published_at" value="<?php echo htmlspecialchars($a['published_at'] ?? gmdate('Y-m-d')); ?>"></div>
        <div class="crm-form-field"><label>Expires Date (optional &mdash; stops showing publicly after this date)</label><input type="date" name="expires_at" value="<?php echo htmlspecialchars($a['expires_at'] ?? ''); ?>"></div>
    </div>
</div>
<div class="crm-page-actions" style="margin-top:16px;">
    <button type="submit" class="crm-btn crm-btn-primary"><i class="fa-solid fa-floppy-disk"></i> Save Article</button>
</div>
</form>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
