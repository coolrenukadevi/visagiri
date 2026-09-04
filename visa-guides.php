<?php
$page_title = "Visa Guides &ndash; Country &amp; Visa-Type Guidance | Visa Agency";
$page_description = "Browse visa guidance by country or by visa type &mdash; eligibility, documents, process and requirements for Indian passport holders.";
$page_canonical = 'https://visaagency.in/visa-guides';
include __DIR__ . '/includes/header.php';

$visaTypeLinks = [
    ['href' => 'visa-tourist', 'icon' => 'fa-umbrella-beach', 'name' => 'Tourist Visa'],
    ['href' => 'visa-business', 'icon' => 'fa-briefcase', 'name' => 'Business Visa'],
    ['href' => 'visa-family', 'icon' => 'fa-people-roof', 'name' => 'Family Visa'],
    ['href' => 'visa-transit', 'icon' => 'fa-plane', 'name' => 'Transit Visa'],
    ['href' => 'visa-sports', 'icon' => 'fa-futbol', 'name' => 'Sports Visa'],
    ['href' => 'visa-medical', 'icon' => 'fa-briefcase-medical', 'name' => 'Medical Visa'],
    ['href' => 'visa-crew', 'icon' => 'fa-ship', 'name' => 'Crew Visa'],
    ['href' => 'visa-extension', 'icon' => 'fa-calendar-plus', 'name' => 'Visa Extension'],
];

$popularSlugs = ['usa', 'uk', 'canada', 'australia', 'germany', 'uae', 'singapore', 'thailand', 'japan', 'schengen'];
$popularCountries = [
    ['slug' => 'usa', 'flag' => '🇺🇸', 'name' => 'United States'],
    ['slug' => 'uk', 'flag' => '🇬🇧', 'name' => 'United Kingdom'],
    ['slug' => 'canada', 'flag' => '🇨🇦', 'name' => 'Canada'],
    ['slug' => 'australia', 'flag' => '🇦🇺', 'name' => 'Australia'],
    ['slug' => 'schengen', 'flag' => '🇪🇺', 'name' => 'Schengen (29 Countries)'],
    ['slug' => 'uae', 'flag' => '🇦🇪', 'name' => 'UAE'],
    ['slug' => 'singapore', 'flag' => '🇸🇬', 'name' => 'Singapore'],
    ['slug' => 'thailand', 'flag' => '🇹🇭', 'name' => 'Thailand'],
    ['slug' => 'japan', 'flag' => '🇯🇵', 'name' => 'Japan'],
];
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Guides</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Guides</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Guides</span>
                    <h2 class="split-text-right split-text-in-right">Find The Right Visa Guide</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    Every guide on Visa Agency is organised two ways &mdash; by <strong>visa type</strong> (what kind of
                    trip you're taking) and by <strong>country</strong> (where you're going). Start with whichever you
                    know first; both paths lead to the same eligibility, document and process detail.
                </p>

                <div class="section-title mb-3">
                    <h3 class="split-text-right split-text-in-right">Browse By Visa Type</h3>
                </div>
                <div class="visa-category-grid mb-5">
                    <?php foreach ($visaTypeLinks as $vt): ?>
                    <div class="visa-category-card">
                        <div class="vc-icon"><i class="fa-solid <?php echo $vt['icon']; ?>"></i></div>
                        <h4><?php echo htmlspecialchars($vt['name']); ?></h4>
                        <a href="<?php echo htmlspecialchars($vt['href']); ?>" class="vc-link">View Guide &rarr;</a>
                    </div>
                    <?php endforeach; ?>
                </div>

                <div class="section-title mb-3">
                    <h3 class="split-text-right split-text-in-right">Browse By Country</h3>
                </div>
                <div class="country-explorer-grid country-nav-grid mb-3">
                    <?php foreach ($popularCountries as $pc): ?>
                    <a href="country-<?php echo $pc['slug']; ?>" class="country-chip">
                        <span class="flag"><?php echo $pc['flag']; ?></span>
                        <span><?php echo htmlspecialchars($pc['name']); ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <p class="text-center mb-5"><a href="country-list" class="theme-btn style-2">Browse All Countries <i class="fa-solid fa-arrow-right"></i></a></p>

                <div class="section-title mb-3">
                    <h3 class="split-text-right split-text-in-right">Go Deeper</h3>
                </div>
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4>Requirements &amp; Documents</h4>
                            <p>Passport, financial, photo and eligibility basics that apply across most applications.</p>
                            <a href="visa-requirements-guide" class="vc-link">Visa Requirements &rarr;</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4>Application Process</h4>
                            <p>Step-by-step, from choosing a category through to biometrics and submission.</p>
                            <a href="visa-application-process" class="vc-link">Application Process &rarr;</a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="visa-doc-group" style="height:100%;">
                            <h4>Interview Preparation</h4>
                            <p>What to expect and how to prepare, for the categories that require one.</p>
                            <a href="visa-interview-guide" class="vc-link">Interview Guide &rarr;</a>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-5">
                    <a href="visa-checklist" class="theme-btn style-2">Build Your Document Checklist</a>
                    <a href="contact" class="theme-btn" data-open-enquiry>Talk To A Consultant <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Visa Guides',
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
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Visa Guides', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
