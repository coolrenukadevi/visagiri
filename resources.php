<?php
$page_title = "Resources &ndash; Visa Guides, Updates, Tools &amp; Help | Visa Agency";
$page_description = "Visa Agency's resource hub &mdash; guides, requirement checkers, fee and processing-time tools, FAQs and the latest visa updates, all in one place.";
$page_canonical = 'https://visaagency.in/resources';
include __DIR__ . '/includes/header.php';
require_once __DIR__ . '/includes/resource-articles-db.php';
$pdo = resource_articles_db();
$latestArticles = resource_articles_latest($pdo, 3);
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Resources</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Resources</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Resource Hub</span>
                    <h2 class="split-text-right split-text-in-right">Everything You Need, In One Place</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    Guides to get you started, tools to check your own requirements, the latest updates, and direct
                    help when you need a person, not a page.
                </p>

                <div class="row g-4 mb-5">
                    <div class="col-lg-3 col-md-6">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4><i class="fa-solid fa-book-open" style="color:var(--va-royal);margin-right:8px;"></i>Guides</h4>
                            <div class="mega-icon-links-vert" style="gap:8px;">
                                <a href="visa-guides" class="vc-link" style="display:block;">Visa Guides</a>
                                <a href="visa-requirements-guide" class="vc-link" style="display:block;">Visa Requirements</a>
                                <a href="visa-application-process" class="vc-link" style="display:block;">Application Process</a>
                                <a href="visa-interview-guide" class="vc-link" style="display:block;">Interview Guide</a>
                                <a href="visa-refusal" class="vc-link" style="display:block;">Rejection Guide</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4><i class="fa-solid fa-arrows-rotate" style="color:var(--va-royal);margin-right:8px;"></i>Updates</h4>
                            <div class="mega-icon-links-vert" style="gap:8px;">
                                <a href="visa-updates" class="vc-link" style="display:block;">Visa Updates</a>
                                <a href="embassy-news" class="vc-link" style="display:block;">Embassy News</a>
                                <a href="visa-alerts" class="vc-link" style="display:block;">Visa Alerts</a>
                                <a href="entry-requirements" class="vc-link" style="display:block;">Entry Requirements</a>
                                <a href="news" class="vc-link" style="display:block;">Visa Blog</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4><i class="fa-solid fa-toolbox" style="color:var(--va-royal);margin-right:8px;"></i>Tools</h4>
                            <div class="mega-icon-links-vert" style="gap:8px;">
                                <a href="visa-requirements" class="vc-link" style="display:block;">Eligibility Checker</a>
                                <a href="visa-fee-calculator" class="vc-link" style="display:block;">Fee Calculator</a>
                                <a href="visa-processing-time-checker" class="vc-link" style="display:block;">Processing Time Checker</a>
                                <a href="visa-checklist" class="vc-link" style="display:block;">Document Checklist</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4><i class="fa-solid fa-circle-question" style="color:var(--va-royal);margin-right:8px;"></i>Help</h4>
                            <div class="mega-icon-links-vert" style="gap:8px;">
                                <a href="visa-faqs" class="vc-link" style="display:block;">Visa FAQs</a>
                                <a href="visa-tips" class="vc-link" style="display:block;">Visa Tips</a>
                                <a href="consultant-help" class="vc-link" style="display:block;">Consultant Help</a>
                                <a href="downloads" class="vc-link" style="display:block;">Download Center</a>
                            </div>
                        </div>
                    </div>
                </div>

                <?php if ($latestArticles): ?>
                <div class="section-title mb-3">
                    <h3 class="split-text-right split-text-in-right">Latest Updates</h3>
                </div>
                <div class="row g-4 mb-5">
                    <?php foreach ($latestArticles as $art): ?>
                    <div class="col-lg-4 col-md-6">
                        <a href="<?php echo htmlspecialchars(resource_article_public_url($art['category'], $art['slug'])); ?>" class="console-news-card is-linked" style="display:block;height:100%;">
                            <div class="tag-row"><span class="tag"><?php echo htmlspecialchars(resource_article_category_label($art['category'])); ?></span><span class="date"><?php echo $art['published_at'] ? htmlspecialchars(date('j M Y', strtotime($art['published_at']))) : ''; ?></span></div>
                            <h3><?php echo htmlspecialchars($art['title']); ?></h3>
                            <p><?php echo htmlspecialchars($art['excerpt'] ?? ''); ?></p>
                            <span class="read-more">Read More <i class="fa-solid fa-arrow-right"></i></span>
                        </a>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <div class="text-center mt-4">
                    <a href="contact" class="theme-btn" data-open-enquiry>Talk To A Consultant <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Resources',
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
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
