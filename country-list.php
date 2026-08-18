<?php
$page_title = "Country List &ndash; Visa Agency";
$page_description = "Browse visa assistance by country &ndash; 200+ destinations covered by Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Country List</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Country List</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Popular Destinations Start -->
        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Popular Destinations</span>
                    <h2 class="split-text-right split-text-in-right">Frequently Requested Visa Destinations</h2>
                </div>
                <div class="row g-4">
                    <?php
                    $popular_slugs = ['usa', 'uk', 'canada', 'australia', 'germany', 'uae', 'singapore', 'new-zealand'];
                    $popular = array_filter($VISA_AGENCY_COUNTRIES, function ($c) use ($popular_slugs) {
                        return in_array($c['slug'], $popular_slugs, true);
                    });
                    foreach ($popular as $c): ?>
                    <div class="col-lg-3 col-md-6">
                        <div class="how-it-works-step">
                            <div class="step-num" style="font-size:26px;"><?php echo $c['flag']; ?></div>
                            <h4><?php echo $c['name']; ?></h4>
                            <p><?php echo implode(' &middot; ', $c['types']); ?></p>
                            <a href="country-<?php echo $c['slug']; ?>" class="vc-link">Explore &rarr;</a>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>
        <!-- Popular Destinations End -->

        <!-- All Countries Start -->
        <section class="section-padding fix section-bg-1 country-explorer-section">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title wow fadeInUp">Full Directory</span>
                    <h2 class="split-text-right split-text-in-right">All <?php echo count($VISA_AGENCY_COUNTRIES); ?> Countries We Cover</h2>
                    <p class="text mt-3" style="max-width:700px;margin:0 auto;">
                        Search or filter by region to find visa assistance for your destination. Every country page
                        outlines the visa categories we help with and our general application process.
                    </p>
                </div>
                <div class="country-explorer-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" class="country-nav-search" placeholder="Search country...">
                </div>
                <div class="country-explorer-filters country-nav-filters">
                    <button type="button" class="active" data-region="all">All</button>
                    <button type="button" data-region="Asia">Asia</button>
                    <button type="button" data-region="Europe">Europe</button>
                    <button type="button" data-region="North America">North America</button>
                    <button type="button" data-region="South America">South America</button>
                    <button type="button" data-region="Africa">Africa</button>
                    <button type="button" data-region="Middle East">Middle East</button>
                    <button type="button" data-region="Oceania">Oceania</button>
                </div>
                <div class="country-explorer-grid country-nav-grid">
                    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                    <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                        <span class="flag"><?php echo $c['flag']; ?></span>
                        <span><?php echo $c['name']; ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>
        <!-- All Countries End -->

        <section class="final-cta section-padding fix">
            <div class="container text-center">
                <h2 class="mb-3">Can't Find Your Destination?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    We assist with many more destinations beyond this list. Get in touch and we'll confirm what we
                    can help you with.
                </p>
                <div class="cta-buttons d-flex flex-wrap justify-content-center gap-3">
                    <a href="contact" class="theme-btn">Enquire Now <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
