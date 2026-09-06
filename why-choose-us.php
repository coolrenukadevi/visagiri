<?php
$page_title = "Why Choose Us &ndash; Visa Agency";
$page_description = "Document precision, transparent pricing, country specialists and 24x7 support &ndash; what clients mention when they refer Visa Agency to a friend.";
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
$about_current = 'why-choose-us';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Why Choose Us</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Why Choose Us</li>
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
                    <p class="hr-eyebrow">Why Choose Us</p>
                    <h2>Five things clients mention when they refer a friend</h2>
                    <p>None of this is aspirational copy &mdash; it's the actual process every file goes through before it leaves our office.</p>
                </div>
                <div class="ab-why-list">
                    <div class="ab-why-item">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg>
                        <div>
                            <h3>Document precision</h3>
                            <p>Every file is checked line by line against the destination's exact checklist before it ever reaches an embassy.</p>
                        </div>
                    </div>
                    <div class="ab-why-item">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="10" width="16" height="10" rx="1.5"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/></svg>
                        <div>
                            <h3>Transparent pricing</h3>
                            <p>Government fee and our service fee are always quoted as two separate lines, before you commit &mdash; never a blended or surprise charge.</p>
                        </div>
                    </div>
                    <div class="ab-why-item">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/></svg>
                        <div>
                            <h3>Country specialists</h3>
                            <p>You're assigned one consultant who handles that destination regularly, not a rotating queue that re-reads your file each time.</p>
                        </div>
                    </div>
                    <div class="ab-why-item">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 6h16M4 12h10M4 18h6"/><circle cx="19" cy="18" r="2.4"/></svg>
                        <div>
                            <h3>A file you can watch</h3>
                            <p>Our <a href="track-application">application tracker</a> shows the stage your application is at, from intake to the day it reaches the visa window.</p>
                        </div>
                    </div>
                    <div class="ab-why-item">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l4 2"/></svg>
                        <div>
                            <h3>24&times;7 support when it matters</h3>
                            <p>Reachable outside office hours for appointment days, biometrics, or a last-minute embassy query.</p>
                        </div>
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
