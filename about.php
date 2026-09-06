<?php
$page_title = "About Us &ndash; Visa Agency";
$page_description = "Visa Agency is a Ministry of Tourism recognised, technology-enabled visa consultancy based in Patna, Bihar, serving Patna, Ranchi, Raipur and Bhopal.";
include __DIR__ . '/includes/header.php';
$abCountryCount = count($VISA_AGENCY_COUNTRIES ?? []);

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
$about_current = 'about';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">About Us</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>About Us</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="hr-section" style="padding-top:48px;">
            <div class="container ab-hero-grid">
                <div>
                    <p class="hr-eyebrow">Ministry of Tourism Recognised</p>
                    <h2>Getting you across the border, on paper and in practice.</h2>
                    <p class="ab-hero-lead">Visa Agency handles the documentation side of travel: the forms, the appointment slots, the follow-up calls to embassies. We file for tourist, business, family, transit, medical and extension categories across <?php echo $abCountryCount; ?>+ destinations, and tell you exactly where your file stands at every step.</p>
                    <div class="ab-hero-actions">
                        <a class="theme-btn hr-btn-gold" href="why-choose-us">See how we work</a>
                        <a class="theme-btn style-2" href="leadership">Meet the team</a>
                    </div>
                    <div class="ab-stat-row">
                        <div class="ab-stat"><span class="num"><?php echo $abCountryCount; ?>+</span><span class="lbl">Destination countries</span></div>
                        <div class="ab-stat"><span class="num">4</span><span class="lbl">City offices</span></div>
                        <div class="ab-stat"><span class="num">MoT</span><span class="lbl">Recognised entity</span></div>
                    </div>
                </div>
                <div class="ab-stamp-frame">
                    <svg class="ab-stamp-svg" viewBox="0 0 260 260">
                        <circle class="ring-dash" cx="130" cy="130" r="118"/>
                        <circle class="ring" cx="130" cy="130" r="98"/>
                        <path id="abCurveTop" d="M 32,130 A 98,98 0 1,1 228,130" fill="none"/>
                        <path id="abCurveBottom" d="M 228,132 A 98,98 0 1,1 32,132" fill="none"/>
                        <text><textPath href="#abCurveTop" startOffset="50%" text-anchor="middle">VISA AGENCY</textPath></text>
                        <text><textPath href="#abCurveBottom" startOffset="50%" text-anchor="middle">MINISTRY OF TOURISM RECOGNISED</textPath></text>
                        <g class="mark" transform="translate(130,130)">
                            <path d="M-28,6 L28,6 M-18,6 L-28,-14 L-20,-14 L-6,6 M18,6 L28,-14 L20,-14 L6,6"/>
                            <circle r="3" fill="currentColor" stroke="none"/>
                        </g>
                    </svg>
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

        <section class="hr-section" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">What We Do</p>
                    <h2>Consultancy, not just paperwork</h2>
                    <p>We guide applicants through eligibility checks, documentation, application preparation and appointment support &mdash; across tourist, business, family, transit, medical and extension visa categories, plus apostille and attestation for supporting documents.</p>
                </div>
                <div class="hr-svc-grid">
                    <div class="hr-svc-card">
                        <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="var(--brand-blue)" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M8 12l2.5 2.5L16 9"/></svg>
                        <h3>Eligibility-first</h3>
                        <p>We check what actually applies to you before recommending a visa category, rather than a one-size-fits-all process.</p>
                    </div>
                    <div class="hr-svc-card">
                        <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="var(--brand-blue)" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg>
                        <h3>Documentation-led</h3>
                        <p>Most delays come from incomplete or inconsistent documents &mdash; our process is built around catching that early.</p>
                    </div>
                    <div class="hr-svc-card">
                        <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="var(--brand-blue)" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/></svg>
                        <h3>Multi-city coverage</h3>
                        <p>We serve applicants across Patna, Ranchi, Raipur and Bhopal from our Patna base, in person and remotely.</p>
                    </div>
                    <div class="hr-svc-card">
                        <svg viewBox="0 0 24 24" width="40" height="40" fill="none" stroke="var(--brand-blue)" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg>
                        <h3>No guaranteed outcomes, said plainly</h3>
                        <p>We're upfront that visa decisions rest solely with the relevant embassy or authority &mdash; we help you present the strongest possible case.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Get To Know Us</span>
                    <h2 class="split-text-right split-text-in-right">More About Visa Agency</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div><h3>Why Choose Us</h3><p>Five things clients mention when they refer a friend &mdash; document precision, transparent pricing and more.</p><a class="tcard-link" href="why-choose-us">Read more &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg></div><h3>Vision &amp; Mission</h3><p>What we're working toward, and how we handle every file to get there.</p><a class="tcard-link" href="vision-mission">Read more &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></div><h3>Leadership</h3><p>The people behind case strategy, documentation standards and client experience.</p><a class="tcard-link" href="leadership">Meet the team &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12h18M3 6h18M3 18h18"/></svg></div><h3>Our Journey</h3><p>Founding, city expansions and major service launches &mdash; our story so far.</p><a class="tcard-link" href="our-journey">Read more &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="9" r="3"/><circle cx="16" cy="9" r="3"/><path d="M2 20c0-3 2.7-5 6-5s6 2 6 5M14 20c0-2.2 1.5-4 4-4.5"/></svg></div><h3>Our Team</h3><p>The consultants and documentation specialists who work your case day to day.</p><a class="tcard-link" href="our-team">Read more &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M8 21h8M12 17v4M4 4h16v9a8 8 0 0 1-16 0V4z"/></svg></div><h3>Partners</h3><p>Organisations we work with to serve clients better.</p><a class="tcard-link" href="partners">Read more &rarr;</a></div>
                    <div class="console-tcard"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M3 11h18"/></svg></div><h3>Careers</h3><p>Open roles across our Patna, Ranchi, Raipur and Bhopal offices.</p><a class="tcard-link" href="careers">View openings &rarr;</a></div>
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
