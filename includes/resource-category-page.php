<?php
/**
 * Shared list+detail template for the 4 "Updates" column pages
 * (visa-updates.php, embassy-news.php, visa-alerts.php,
 * entry-requirements.php). Each wrapper sets $resourceCategory,
 * $resourcePageTitle, $resourcePageIntro, $resourceBreadcrumbLabel and
 * $resourceIcon, then includes this file. Reads only from
 * resource_articles — nothing here is ever hardcoded/fabricated, so a
 * category with no published articles yet shows an honest empty state.
 */
require_once __DIR__ . '/resource-articles-db.php';
$pdo = resource_articles_db();

$requestedSlug = trim($_GET['a'] ?? '');
$detail = $requestedSlug ? resource_article_by_slug($pdo, $requestedSlug) : null;
if ($detail && $detail['category'] !== $resourceCategory) {
    $detail = null;
}

$page_canonical = 'https://visaagency.in/' . basename($_SERVER['SCRIPT_NAME'], '.php');
if ($detail) {
    $page_title = htmlspecialchars($detail['title']) . ' | Visa Agency';
    $page_description = htmlspecialchars($detail['excerpt'] ?: $resourcePageIntro);
    $page_canonical .= '?a=' . rawurlencode($detail['slug']);
} else {
    $page_title = $resourcePageTitle . ' | Visa Agency';
    $page_description = $resourcePageIntro;
}
include __DIR__ . '/header.php';

$articles = resource_articles_published($pdo, $resourceCategory, 100);
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title"><?php echo htmlspecialchars($detail ? $detail['title'] : $resourcePageTitle); ?></h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <?php if ($detail): ?>
                        <li><a href="<?php echo htmlspecialchars(basename($_SERVER['SCRIPT_NAME'], '.php')); ?>"><?php echo htmlspecialchars($resourceBreadcrumbLabel); ?></a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo htmlspecialchars($detail['title']); ?></li>
                        <?php else: ?>
                        <li><?php echo htmlspecialchars($resourceBreadcrumbLabel); ?></li>
                        <?php endif; ?>
                    </ul>
                </div>
            </div>
        </section>

        <?php if ($detail): ?>
        <section class="service-section section-padding fix">
            <div class="container">
                <p class="svc-lede" style="text-align:left;max-width:820px;margin:0 auto;">
                    <?php if ($detail['published_at']): ?><span style="color:var(--text);font-size:13px;">Published <?php echo htmlspecialchars(date('j F Y', strtotime($detail['published_at']))); ?></span><br><?php endif; ?>
                </p>
                <div class="svc-lede" style="text-align:left;max-width:820px;margin:0 auto;">
                    <?php echo $detail['body_html'] ?: '<p>' . htmlspecialchars($detail['excerpt'] ?? '') . '</p>'; ?>
                </div>
                <?php if ($detail['source_name']): ?>
                <p class="visa-info-note" style="max-width:820px;margin:20px auto 0;">
                    Source: <?php if ($detail['source_url']): ?><a href="<?php echo htmlspecialchars($detail['source_url']); ?>" target="_blank" rel="noopener nofollow"><?php echo htmlspecialchars($detail['source_name']); ?></a><?php else: echo htmlspecialchars($detail['source_name']); endif; ?>
                </p>
                <?php endif; ?>
                <div class="text-center mt-5">
                    <a href="<?php echo htmlspecialchars(basename($_SERVER['SCRIPT_NAME'], '.php')); ?>" class="theme-btn style-2">&larr; Back to <?php echo htmlspecialchars($resourceBreadcrumbLabel); ?></a>
                    <a href="contact" class="theme-btn" data-open-enquiry>Talk to a Consultant <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>
        <?php else: ?>
        <section class="service-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Resources</span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($resourcePageTitle); ?></h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    <?php echo htmlspecialchars($resourcePageIntro); ?>
                </p>

                <?php if ($articles): ?>
                <div class="row g-4">
                    <?php foreach ($articles as $art): ?>
                    <div class="col-lg-4 col-md-6">
                        <a href="<?php echo htmlspecialchars(resource_article_public_url($art['category'], $art['slug'])); ?>" class="console-news-card is-linked" style="display:block;height:100%;">
                            <div class="tag-row"><span class="tag"><?php echo htmlspecialchars($resourceBreadcrumbLabel); ?></span><span class="date"><?php echo $art['published_at'] ? htmlspecialchars(date('j M Y', strtotime($art['published_at']))) : ''; ?></span></div>
                            <h3><?php echo htmlspecialchars($art['title']); ?></h3>
                            <p><?php echo htmlspecialchars($art['excerpt'] ?? ''); ?></p>
                            <span class="read-more">Read More <i class="fa-solid fa-arrow-right"></i></span>
                        </a>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php else: ?>
                <div class="compliance-note" style="max-width:720px;margin:0 auto;text-align:center;">
                    <i class="<?php echo htmlspecialchars($resourceIcon); ?>" style="font-size:22px;display:block;margin-bottom:10px;"></i>
                    No <?php echo htmlspecialchars(strtolower($resourceBreadcrumbLabel)); ?> published yet &mdash; check back soon, or ask a consultant directly for the current position on your destination.
                </div>
                <?php endif; ?>

                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask A Consultant <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="resources" class="theme-btn style-2">All Resources</a>
                </div>
            </div>
        </section>
        <?php endif; ?>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => $detail ? $detail['title'] : $resourcePageTitle,
    'url' => $page_canonical,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => 'https://visaagency.in/resources'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $resourceBreadcrumbLabel, 'item' => 'https://visaagency.in/' . basename($_SERVER['SCRIPT_NAME'], '.php')],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/footer.php'; ?>
