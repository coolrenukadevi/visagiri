<?php
$page_title = "Our Journey &ndash; Visa Agency";
$page_description = "Visa Agency's company timeline &mdash; founding, city expansions and major service launches.";
$page_noindex = true;
include __DIR__ . '/includes/header.php';

$about_siblings = [
    ['slug' => 'about', 'label' => 'About Us'],
    ['slug' => 'why-choose-us', 'label' => 'Why Choose Us'],
    ['slug' => 'vision-mission', 'label' => 'Vision &amp; Mission'],
    ['slug' => 'leadership', 'label' => 'Leadership'],
    ['slug' => 'our-journey', 'label' => 'Our Journey'],
    ['slug' => 'our-team', 'label' => 'Our Team'],
    ['slug' => 'partners', 'label' => 'Partners'],
    ['slug' => 'careers', 'label' => 'Careers'],
];
$about_current = 'our-journey';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Our Journey</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Our Journey</li>
                    </ul>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Company pages">
            <div class="svc-sibling-inner">
                <?php foreach ($about_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $about_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Our Journey</p>
                    <h2>How We Got Here</h2>
                </div>
                <div class="data-pending">
                    <i class="fa-solid fa-circle-info"></i>
                    <div>
                        <h4>Our company timeline is coming soon</h4>
                        <p>We're putting together the key milestones in Visa Agency's history &mdash; founding, city expansions and major service launches &mdash; for this section. Check back soon, or read about <a href="about">what we do today</a>.</p>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
