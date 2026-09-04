<?php
/**
 * State location hub: /visa-consultant/{state}/
 * Dispatched here by .htaccess (production) and router.php (local dev),
 * which populate $_GET['state']. Mirrors countries.php's front-controller
 * shape (real 404 for an unknown/unpublished slug, no soft-404).
 */
require_once __DIR__ . '/includes/location-db.php';
require_once __DIR__ . '/includes/visa-content-db.php';

$pdo = location_db();
$slug = trim((string) ($_GET['state'] ?? ''), '/');

if (!preg_match('#^[a-z0-9-]+$#', $slug)) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$stmt = $pdo->prepare("SELECT * FROM states WHERE slug = ? AND status = 'published'");
$stmt->execute([$slug]);
$state = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$state) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$cities = location_cities_for_state($pdo, $state['id']);
$faqs = location_state_faqs($pdo, $state['id']);

$contentDb = visa_content_db();
$popularCountries = $contentDb->query("SELECT name, slug, flag FROM countries WHERE is_active = 1 ORDER BY popularity DESC, name LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);

$stateName = $state['name'];
$page_title = $state['seo_title'] ?: "Visa Consultant in {$stateName} | Visa Agency";
$page_description = $state['meta_description'] ?: "Visa consultancy and application assistance for residents of {$stateName}, from Visa Agency.";
$page_canonical = 'https://visaagency.in/' . location_state_url($state['slug']);
$page_og_title = "Visa Consultant in {$stateName} | Visa Agency";
$page_og_description = $page_description;
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Consultant in <?php echo htmlspecialchars($stateName); ?></h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultant">Locations</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo htmlspecialchars($stateName); ?></li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Visa Consultancy</span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultant in <?php echo htmlspecialchars($stateName); ?></h2>
                </div>
                <?php if ($state['intro_html']): ?>
                <div class="svc-lede"><?php echo $state['intro_html']; ?></div>
                <?php endif; ?>
                <?php if ($state['service_model_html']): ?>
                <div class="compliance-note"><?php echo $state['service_model_html']; ?></div>
                <?php endif; ?>
            </div>
        </section>

        <?php if ($cities): ?>
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Cities We Serve</span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultancy Across <?php echo htmlspecialchars($stateName); ?></h2>
                </div>
                <div class="visa-category-grid mb-5">
                    <?php foreach ($cities as $c): ?>
                    <div class="visa-category-card">
                        <div class="vc-icon"><i class="fa-solid fa-location-dot"></i></div>
                        <h4>Visa Consultant in <?php echo htmlspecialchars($c['name']); ?></h4>
                        <p><?php echo $c['is_hq'] ? 'Our main office, with in-person consultations available.' : 'Served remotely — phone, WhatsApp, email and courier.'; ?></p>
                        <a href="<?php echo htmlspecialchars(location_city_url($state['slug'], $c['slug'])); ?>" class="vc-link">View Details &rarr;</a>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>
        <?php endif; ?>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Popular Destinations</span>
                    <h2 class="split-text-right split-text-in-right">Where <?php echo htmlspecialchars($stateName); ?> Applicants Travel Most</h2>
                </div>
                <div class="country-explorer-grid country-nav-grid mb-5">
                    <?php foreach ($popularCountries as $pc): ?>
                    <a href="<?php echo htmlspecialchars(visa_country_url($pc['slug'])); ?>" class="country-chip">
                        <span class="flag"><?php echo htmlspecialchars($pc['flag'] ?: ''); ?></span>
                        <span><?php echo htmlspecialchars($pc['name']); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <div class="text-center">
                    <a href="country-list" class="theme-btn style-2">Browse All Countries <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

        <?php if ($faqs): ?>
        <section id="faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Visa Consultancy in <?php echo htmlspecialchars($stateName); ?>, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <?php foreach ($faqs as $i => $faq): ?>
                            <div class="faq-item<?php echo $i === 0 ? ' active' : ''; ?>">
                                <div class="faq-question"><?php echo htmlspecialchars($faq['question']); ?> <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><?php echo $faq['answer_html']; ?></div>
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <?php endif; ?>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Talk To A Visa Consultant Today</h2>
                    <p>Tell us where you're travelling and why &mdash; we'll confirm the right visa category and next steps.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn" data-open-quick-enquiry>Enquire Now <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="track-application" class="theme-btn style-2">Track Application</a>
                    </div>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Visa Consultant in ' . $stateName,
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
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Locations', 'item' => 'https://visaagency.in/visa-consultant'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $stateName, 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<?php if ($faqs): ?>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'FAQPage',
    'mainEntity' => array_map(function ($f) {
        return [
            '@type' => 'Question',
            'name' => $f['question'],
            'acceptedAnswer' => ['@type' => 'Answer', 'text' => strip_tags($f['answer_html'])],
        ];
    }, $faqs),
], JSON_UNESCAPED_SLASHES); ?>
</script>
<?php endif; ?>

<?php include __DIR__ . '/includes/footer.php'; ?>
