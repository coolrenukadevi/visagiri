<?php
/**
 * States directory: /visa-consultant — lists every published state hub.
 * Deliberately lists only the states we've actually built genuine content
 * for, not a placeholder grid of all 28 states + 8 UTs (see brief's own
 * instruction against doorway pages) — this grows as more states/cities
 * are researched and published.
 */
require_once __DIR__ . '/includes/location-db.php';

$pdo = location_db();
$states = $pdo->query("SELECT s.*, (SELECT COUNT(*) FROM cities c WHERE c.state_id = s.id AND c.status = 'published') AS city_count
    FROM states s WHERE s.status = 'published' ORDER BY s.sort_order, s.name")->fetchAll(PDO::FETCH_ASSOC);

$page_title = "Visa Consultant Locations Across India | Visa Agency";
$page_description = "Find visa consultancy and application assistance by state and city across India, from Visa Agency.";
$page_canonical = 'https://visaagency.in/visa-consultant';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Consultant Locations</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Locations</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Where We Serve</span>
                    <h2 class="split-text-right split-text-in-right">Visa Consultant, State by State</h2>
                </div>
                <p class="svc-lede">
                    Our office is in Patna, Bihar &mdash; every other state and city listed here is served remotely,
                    by phone, WhatsApp, email and courier. We publish a location page only once we have genuinely
                    useful, honest information for it, so this list will keep growing rather than covering
                    every state and city at once.
                </p>

                <div class="visa-category-grid mb-5">
                    <?php foreach ($states as $s): ?>
                    <div class="visa-category-card">
                        <div class="vc-icon"><i class="fa-solid fa-map-location-dot"></i></div>
                        <h4>Visa Consultant in <?php echo htmlspecialchars($s['name']); ?></h4>
                        <p><?php echo (int) $s['city_count']; ?> cit<?php echo (int) $s['city_count'] === 1 ? 'y' : 'ies'; ?> covered</p>
                        <a href="<?php echo htmlspecialchars(location_state_url($s['slug'])); ?>" class="vc-link">View Details &rarr;</a>
                    </div>
                    <?php endforeach; ?>
                </div>

                <div class="compliance-note">
                    Don't see your state or city listed? We still help &mdash; <a href="contact">get in touch</a> and our
                    consultants will guide you the same way, remotely.
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
