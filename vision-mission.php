<?php
$page_title = "Vision &amp; Mission &ndash; Visa Agency";
$page_description = "Visa Agency's vision and mission &ndash; making the paperwork stage of travel ordinary, with a tracked, transparent process handled by one caseworker per file.";
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
$about_current = 'vision-mission';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Vision &amp; Mission</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Vision &amp; Mission</li>
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

        <section class="hr-section" style="padding-top:48px;">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Vision &amp; Mission</p>
                    <h2>Two pages, one booklet</h2>
                </div>
                <div class="ab-spread">
                    <div>
                        <span class="tag">Vision</span>
                        <h3>A border that isn't the hardest part of the trip.</h3>
                        <p>We want the paperwork stage of travel to feel ordinary &mdash; something you complete quickly and stop thinking about, not the part of the trip you dread. Every process we build works toward that, replacing guesswork with a tracked, transparent process, city by city.</p>
                    </div>
                    <div>
                        <span class="tag">Mission</span>
                        <h3>Handle every file with the same precision, start to finish.</h3>
                        <p>We review, format and check every document against the exact standard each consulate expects, and assign one caseworker who stays with your application from intake to appointment &mdash; while being upfront that final decisions rest with the relevant embassy or authority.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want To Talk To The Team Directly?</h3>
                            <p>Book a consultation or send us your case details &mdash; we'll get back to you promptly.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Start Your Visa Enquiry</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Call +91 78448 19819</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
