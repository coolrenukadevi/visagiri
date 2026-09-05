<?php
$page_title = "About Us &ndash; Visa Agency";
$page_description = "Visa Agency is a Ministry of Tourism recognised, technology-enabled visa consultancy based in Patna, Bihar, serving Patna, Ranchi, Raipur and Bhopal.";
include __DIR__ . '/includes/header.php';
$abCountryCount = count($VISA_AGENCY_COUNTRIES ?? []);
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

        <nav class="svc-sibling-nav" aria-label="About Visa Agency">
            <div class="svc-sibling-inner">
                <a href="about#overview" class="current">About Us</a>
                <a href="about#journey">Our Journey</a>
                <a href="about#vision-mission">Vision &amp; Mission</a>
                <a href="about#leadership">Leadership</a>
                <a href="about#our-team">Our Team</a>
                <a href="about#partners">Partners</a>
                <a href="about#why-choose-us">Why Choose Us</a>
                <a href="careers">Careers</a>
                <a href="visa-news">News &amp; Updates</a>
            </div>
        </nav>

        <section class="hr-section" id="overview" style="padding-top:48px;">
            <div class="container ab-hero-grid">
                <div>
                    <p class="hr-eyebrow">Ministry of Tourism Recognised</p>
                    <h2>Getting you across the border, on paper and in practice.</h2>
                    <p class="ab-hero-lead">Visa Agency handles the documentation side of travel: the forms, the appointment slots, the follow-up calls to embassies. We file for tourist, business, family, transit, medical and extension categories across <?php echo $abCountryCount; ?>+ destinations, and tell you exactly where your file stands at every step.</p>
                    <div class="ab-hero-actions">
                        <a class="theme-btn hr-btn-gold" href="about#why-choose-us">See how we work</a>
                        <a class="theme-btn style-2" href="about#leadership">Meet the team</a>
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

        <section class="section-padding fix" id="journey">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Our Journey</p>
                    <h2>How We Got Here</h2>
                </div>
                <div class="data-pending">
                    <i class="fa-solid fa-circle-info"></i>
                    <div>
                        <h4>Our company timeline is coming soon</h4>
                        <p>We're putting together the key milestones in Visa Agency's history &mdash; founding, city expansions and major service launches &mdash; for this section. Check back soon, or read about what we do today above.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="hr-section" id="vision-mission" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
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

        <section class="hr-section" id="leadership">
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

        <section class="section-padding fix" id="our-team">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Our Team</p>
                    <h2>Beyond Leadership</h2>
                    <p>The consultants, documentation specialists and support staff who work your case day to day.</p>
                </div>
                <div class="data-pending">
                    <i class="fa-solid fa-circle-info"></i>
                    <div>
                        <h4>Full team profiles are coming soon</h4>
                        <p>We're building out individual profiles for our visa consultants and documentation specialists. In the meantime, our <a href="about#leadership">leadership team</a> can point you to the right person for your case.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1" id="partners">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Partners</p>
                    <h2>Who We Work With</h2>
                </div>
                <div class="data-pending">
                    <i class="fa-solid fa-circle-info"></i>
                    <div>
                        <h4>Partner details are coming soon</h4>
                        <p>We're finalising the list of partner organisations we work with to bring here. For details on a specific partnership or referral, please <a href="contact">contact us</a> directly.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="hr-section" id="why-choose-us" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
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
