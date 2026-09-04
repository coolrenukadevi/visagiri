<?php
/**
 * Master locations directory (brief section 19): India -> States -> Cities,
 * plus links out to the existing Countries and Services hubs. A link
 * directory, not new content of its own — avoids duplicating the state/
 * city/country pages it points to.
 */
require_once __DIR__ . '/includes/location-db.php';

$pdo = location_db();
$states = $pdo->query("SELECT * FROM states WHERE status = 'published' ORDER BY sort_order, name")->fetchAll(PDO::FETCH_ASSOC);
foreach ($states as &$s) {
    $s['cities'] = location_cities_for_state($pdo, $s['id']);
}
unset($s);

$page_title = "India Visa Consultant Locations &ndash; States, Cities &amp; Countries | Visa Agency";
$page_description = "Browse Visa Agency's visa consultancy coverage across Indian states and cities, and every destination country we cover.";
$page_canonical = 'https://visaagency.in/locations';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Locations Directory</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Locations</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">India</span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultancy By State &amp; City</h2>
                </div>
                <div class="row g-4 mb-5">
                    <?php foreach ($states as $s): ?>
                    <div class="col-md-6 col-lg-3">
                        <div class="location-dir-card">
                            <h4><a href="<?php echo htmlspecialchars(location_state_url($s['slug'])); ?>"><?php echo htmlspecialchars($s['name']); ?></a></h4>
                            <ul>
                                <?php foreach ($s['cities'] as $c): ?>
                                <li><a href="<?php echo htmlspecialchars(location_city_url($s['slug'], $c['slug'])); ?>"><?php echo htmlspecialchars($c['name']); ?></a></li>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mb-5">
                    <a href="visa-consultant" class="theme-btn style-2">Full State Directory <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Explore More</span>
                    <h2 class="split-text-right split-text-in-right">Countries &amp; Services</h2>
                </div>
                <div class="row g-4 text-center">
                    <div class="col-md-6">
                        <div class="location-dir-card">
                            <h4><a href="country-list">Visa Countries</a></h4>
                            <p>Requirements and application assistance for every destination country we cover.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="location-dir-card">
                            <h4><a href="our-services">Visa Services</a></h4>
                            <p>Tourist, business, family, transit, medical and other visa categories we assist with.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Locations', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
