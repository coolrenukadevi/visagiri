<?php
/**
 * Country hub page: /countries/{slug}/
 * Expects $pdo (PDO) and $country (assoc array) from countries.php.
 */

$categoriesStmt = $pdo->prepare("SELECT vc.id, vc.name, vc.slug, vc.icon, vc.short_description, cvp.page_slug, cvp.status
    FROM visa_categories vc
    LEFT JOIN country_visa_pages cvp ON cvp.visa_category_id = vc.id AND cvp.country_id = ? AND cvp.status = 'published'
    ORDER BY vc.sort_order ASC");
$categoriesStmt->execute([$country['id']]);
$categories = $categoriesStmt->fetchAll(PDO::FETCH_ASSOC);
$publishedCount = count(array_filter($categories, function ($c) { return $c['page_slug'] !== null; }));

$relatedStmt = $pdo->prepare('SELECT * FROM countries WHERE region = ? AND slug != ? AND is_active = 1 ORDER BY popularity DESC, name ASC LIMIT 6');
$relatedStmt->execute([$country['region'], $country['slug']]);
$relatedCountries = $relatedStmt->fetchAll(PDO::FETCH_ASSOC);

$countryName = $country['name'];
$page_title = "{$countryName} Visa Information &amp; Application Assistance | Visa Agency";
$page_description = "{$countryName} visa information for Indian travellers &ndash; tourist, business, family and other visa categories, requirements, documents and application assistance from Visa Agency.";
$page_canonical = 'https://visaagency.in/' . visa_country_url($country['slug']);
$page_og_title = "{$countryName} Visa &ndash; Visa Agency";
$page_og_description = $page_description;
include __DIR__ . '/../header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title"><?php echo $country['flag'] ? htmlspecialchars($country['flag']) . ' ' : ''; ?><?php echo htmlspecialchars($countryName); ?> Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="country-list">Countries</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><?php echo htmlspecialchars($countryName); ?></li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp"><?php echo htmlspecialchars($country['region'] ?: 'Destination'); ?></span>
                    <h2 class="split-text-right split-text-in-right"><?php echo htmlspecialchars($countryName); ?> Visa Information &amp; Assistance</h2>
                </div>
                <p class="svc-lede">
                    <?php echo htmlspecialchars($countryName); ?> visa information and application assistance for Indian
                    travellers. Select a visa category below for purpose-specific requirements, documents,
                    fees and processing information &mdash; each verified against the relevant immigration
                    authority where information is available.
                </p>

                <div class="visa-category-grid mb-5">
                    <?php foreach ($categories as $cat): ?>
                    <?php if ($cat['page_slug']): ?>
                    <div class="visa-category-card">
                        <div class="vc-icon"><i class="fa-solid <?php echo htmlspecialchars($cat['icon'] ?: 'fa-passport'); ?>"></i></div>
                        <h4><?php echo htmlspecialchars($countryName); ?> <?php echo htmlspecialchars($cat['name']); ?></h4>
                        <p><?php echo htmlspecialchars($cat['short_description'] ?: ''); ?></p>
                        <a href="<?php echo htmlspecialchars(visa_country_page_url($cat['page_slug'])); ?>" class="vc-link">View Details &rarr;</a>
                    </div>
                    <?php else: ?>
                    <div class="visa-category-card" style="opacity:.55;">
                        <div class="vc-icon"><i class="fa-solid <?php echo htmlspecialchars($cat['icon'] ?: 'fa-passport'); ?>"></i></div>
                        <h4><?php echo htmlspecialchars($countryName); ?> <?php echo htmlspecialchars($cat['name']); ?></h4>
                        <p><?php echo htmlspecialchars($cat['short_description'] ?: ''); ?></p>
                        <span class="vc-link" style="color:var(--text);">Content coming soon</span>
                    </div>
                    <?php endif; ?>
                    <?php endforeach; ?>
                </div>

                <?php if ($publishedCount === 0): ?>
                <div class="compliance-note">
                    Detailed visa-category information for <?php echo htmlspecialchars($countryName); ?> is being prepared
                    and reviewed against official sources. In the meantime, our consultants can guide you directly
                    &mdash; use the enquiry button below.
                </div>
                <?php endif; ?>

                <div class="compliance-note">
                    Visa requirements, fees and processing times for <?php echo htmlspecialchars($countryName); ?> are set
                    by the relevant embassy, consulate or immigration authority and can change without notice.
                    Visa Agency provides consultancy and application support only and does not guarantee approval.
                </div>

                <?php if ($relatedCountries): ?>
                <div class="section-title mb-3 mt-5">
                    <h3 class="split-text-right split-text-in-right">Explore More Countries in <?php echo htmlspecialchars($country['region']); ?></h3>
                </div>
                <div class="country-explorer-grid country-nav-grid mb-5">
                    <?php foreach ($relatedCountries as $rc): ?>
                    <a href="<?php echo htmlspecialchars(visa_country_url($rc['slug'])); ?>" class="country-chip">
                        <span class="flag"><?php echo htmlspecialchars($rc['flag'] ?: ''); ?></span>
                        <span><?php echo htmlspecialchars($rc['name']); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry data-country="<?php echo htmlspecialchars($countryName); ?>">Enquire About <?php echo htmlspecialchars($countryName); ?> Visa Services <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => $countryName . ' Visa',
    'url' => $page_canonical,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
    'about' => ['@type' => 'Country', 'name' => $countryName],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Countries', 'item' => 'https://visaagency.in/country-list'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => $countryName, 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/../footer.php'; ?>
