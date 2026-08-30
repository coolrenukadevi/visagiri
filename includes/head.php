<?php
/**
 * <head> for every page. Expects $page = [
 *   'title', 'description', 'path' (clean, e.g. '/visa/kenya'), 'jsonld' => [...]
 * ]
 * Canonical / OG / schema URLs are all derived from canonical($page['path']),
 * so they can never contain ".php" or drift from the sitemap.
 */
require_once __DIR__ . '/config.php';
$page += ['title' => SITE['name'], 'description' => '', 'path' => '/', 'jsonld' => []];
$canonical = canonical($page['path']);
?>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= e($page['title']) ?></title>
<meta name="description" content="<?= e($page['description']) ?>">
<link rel="icon" type="image/png" sizes="32x32" href="/images/favicon-32.png">
<link rel="icon" type="image/png" sizes="512x512" href="/images/favicon.png">
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png">
<link rel="stylesheet" href="/css/site.css">
<link rel="canonical" href="<?= e($canonical) ?>">
<?php /* Signed-in surfaces (account, auth callbacks) set noindex — they are
         per-user, never the same page twice, and must not enter the index. */ ?>
<meta name="robots" content="<?= !empty($page['noindex']) ? 'noindex, nofollow' : 'index, follow' ?>">
<meta name="cv-page-title" content="<?= e($page['short_title'] ?? $page['title']) ?>">
<meta property="og:type" content="<?= e($page['og_type'] ?? 'website') ?>">
<meta property="og:site_name" content="<?= e(SITE['name']) ?>">
<meta property="og:title" content="<?= e($page['title']) ?>">
<meta property="og:description" content="<?= e($page['description']) ?>">
<meta property="og:url" content="<?= e($canonical) ?>">
<meta property="og:image" content="<?= e(canonical('/images/logo-full.png')) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="<?= e($page['title']) ?>">
<meta name="twitter:description" content="<?= e($page['description']) ?>">
<meta name="twitter:image" content="<?= e(canonical('/images/logo-full.png')) ?>">
<?php foreach ($page['jsonld'] as $block): ?>
<script type="application/ld+json">
<?= json_encode($block, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE) ?>

</script>
<?php endforeach; ?>
