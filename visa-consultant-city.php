<?php
/**
 * City location page: /visa-consultant/{state}/{city}/
 * Dispatched here by .htaccess (production) and router.php (local dev),
 * which populate $_GET['state'] and $_GET['city'].
 */
require_once __DIR__ . '/includes/location-db.php';
require_once __DIR__ . '/includes/visa-content-db.php';

$pdo = location_db();
$stateSlug = trim((string) ($_GET['state'] ?? ''), '/');
$citySlug = trim((string) ($_GET['city'] ?? ''), '/');

if (!preg_match('#^[a-z0-9-]+$#', $stateSlug) || !preg_match('#^[a-z0-9-]+$#', $citySlug)) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$stmt = $pdo->prepare("SELECT * FROM states WHERE slug = ? AND status = 'published'");
$stmt->execute([$stateSlug]);
$state = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$state) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$stmt = $pdo->prepare("SELECT * FROM cities WHERE state_id = ? AND slug = ? AND status = 'published'");
$stmt->execute([$state['id'], $citySlug]);
$city = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$city) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    return;
}

$faqs = location_city_faqs($pdo, $city['id']);
if (!$faqs) {
    $faqs = location_state_faqs($pdo, $state['id']);
}

$otherCities = array_filter(location_cities_for_state($pdo, $state['id']), function ($c) use ($city) {
    return $c['id'] !== $city['id'];
});

$contentDb = visa_content_db();
$popularCountries = $contentDb->query("SELECT name, slug, flag FROM countries WHERE is_active = 1 ORDER BY popularity DESC, name LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);

$cityName = $city['name'];
$stateName = $state['name'];
$page_title = $city['seo_title'] ?: "Visa Consultant in {$cityName} | Visa Agency";
$page_description = $city['meta_description'] ?: "Visa consultancy and application assistance for residents of {$cityName}, {$stateName}, from Visa Agency.";
$page_canonical = 'https://visaagency.in/' . location_city_url($state['slug'], $city['slug']);
$page_og_title = "Visa Consultant in {$cityName} | Visa Agency";
$page_og_description = $page_description;
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Consultant in <?php echo htmlspecialchars($cityName); ?></h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultant">Locations</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="<?php echo htmlspecialchars(location_state_url($state['slug'])); ?>"><?php echo htmlspecialchars($stateName); ?></a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo htmlspecialchars($cityName); ?></li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp"><?php echo htmlspecialchars($stateName); ?></span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultant in <?php echo htmlspecialchars($cityName); ?></h2>
                </div>
                <?php if ($city['intro_html']): ?>
                <div class="svc-lede"><?php echo $city['intro_html']; ?></div>
                <?php endif; ?>
                <?php if ($city['local_notes_html']): ?>
                <div class="compliance-note"><?php echo $city['local_notes_html']; ?></div>
                <?php endif; ?>
                <?php if ($city['is_hq'] && $city['office_address']): ?>
                <div class="compliance-note"><strong>Office address:</strong> <?php echo htmlspecialchars($city['office_address']); ?></div>
                <?php endif; ?>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Popular Destinations</span>
                    <h2 class="split-text-right split-text-in-right">Where <?php echo htmlspecialchars($cityName); ?> Applicants Travel Most</h2>
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
        <section id="faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Visa Consultancy in <?php echo htmlspecialchars($cityName); ?>, Answered</h2>
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

        <?php if ($otherCities): ?>
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Nearby</span>
                    <h2 class="split-text-right split-text-in-right">Also Serving <?php echo htmlspecialchars($stateName); ?></h2>
                </div>
                <div class="country-explorer-grid country-nav-grid mb-5">
                    <?php foreach ($otherCities as $oc): ?>
                    <a href="<?php echo htmlspecialchars(location_city_url($state['slug'], $oc['slug'])); ?>" class="country-chip">
                        <span><?php echo htmlspecialchars($oc['name']); ?></span>
                    </a>
                    <?php endforeach; ?>
                    <a href="<?php echo htmlspecialchars(location_state_url($state['slug'])); ?>" class="country-chip">
                        <span>All of <?php echo htmlspecialchars($stateName); ?> &rarr;</span>
                    </a>
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
    'name' => 'Visa Consultant in ' . $cityName,
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
        ['@type' => 'ListItem', 'position' => 3, 'name' => $stateName, 'item' => 'https://visaagency.in/' . location_state_url($state['slug'])],
        ['@type' => 'ListItem', 'position' => 4, 'name' => $cityName, 'item' => $page_canonical],
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
<?php if ($city['is_hq']): ?>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'LocalBusiness',
    '@id' => $page_canonical . '#localbusiness',
    'name' => 'Visa Agency',
    'image' => 'https://visaagency.in/assets/img/logo/visaagency-badge.png',
    'url' => $page_canonical,
    'address' => ['@type' => 'PostalAddress', 'streetAddress' => $city['office_address'], 'addressLocality' => $cityName, 'addressRegion' => $stateName, 'addressCountry' => 'IN'],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<?php endif; ?>

<?php include __DIR__ . '/includes/footer.php'; ?>
