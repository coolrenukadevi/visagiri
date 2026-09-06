<?php
$page_title = "Leadership &ndash; Visa Agency";
$page_description = "The leadership team behind Visa Agency's case strategy, documentation standards and client experience across Patna, Ranchi, Raipur and Bhopal.";
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
$about_current = 'leadership';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Leadership</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Leadership</li>
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
                    <p class="hr-eyebrow">Leadership</p>
                    <h2>The people behind the process</h2>
                    <p>Our leadership team oversees case strategy, documentation standards and client experience across every office we serve.</p>
                </div>
                <div class="ab-team-grid">
                    <div class="ab-team-card">
                        <div class="avatar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></div>
                        <h3>Founder &amp; Director</h3>
                        <span class="ab-team-role">Case Strategy</span>
                        <p class="bio">Sets overall case strategy and oversees relationships with embassy and consular partners.</p>
                    </div>
                    <div class="ab-team-card">
                        <div class="avatar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></div>
                        <h3>Head of Visa Operations</h3>
                        <span class="ab-team-role">Documentation Quality</span>
                        <p class="bio">Leads documentation review and application quality across tourist, business, transit and family visa categories.</p>
                    </div>
                    <div class="ab-team-card">
                        <div class="avatar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></div>
                        <h3>Head of Apostille &amp; Attestation</h3>
                        <span class="ab-team-role">Document Legalisation</span>
                        <p class="bio">Oversees document legalisation casework, including MEA apostille and embassy attestation chains.</p>
                    </div>
                    <div class="ab-team-card">
                        <div class="avatar"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></div>
                        <h3>Client Experience Lead</h3>
                        <span class="ab-team-role">Client Support</span>
                        <p class="bio">Coordinates appointments, communication and support for clients across all four cities we serve.</p>
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
