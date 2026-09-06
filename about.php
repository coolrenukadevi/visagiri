<?php
$page_title = "About Us &ndash; Visa Agency";
$page_description = "Visa Agency is a Ministry of Tourism recognised, technology-enabled visa consultancy based in Patna, Bihar, serving Patna, Ranchi, Raipur and Bhopal.";
include __DIR__ . '/includes/header.php';
$abCountryCount = count($VISA_AGENCY_COUNTRIES ?? []);

$ab2Board = [
    ['code' => 'DEST', 'label' => 'Destination countries', 'value' => $abCountryCount . '+'],
    ['code' => 'TERM', 'label' => 'City offices',           'value' => '04'],
    ['code' => 'STAT', 'label' => 'Recognition',            'value' => 'MoT RECOGNISED'],
];

$ab2MiniBoard = [
    ['label' => 'Service fee',       'value' => 'Quoted apart from govt. fee'],
    ['label' => 'First consultation','value' => 'Free, no obligation'],
    ['label' => 'Your file',         'value' => 'One caseworker, start to finish'],
];

$ab2Tickets = [
    ['num' => '01', 'title' => 'Start An Enquiry',       'text' => 'Tell us your destination and purpose &mdash; a consultant confirms the right visa category before anything else.', 'href' => 'contact'],
    ['num' => '02', 'title' => 'Book An Appointment',    'text' => 'Pick a date and time for your visa consultation, in person or remotely.',                                          'href' => 'visa-appointment'],
    ['num' => '03', 'title' => 'Meet The Leadership',    'text' => 'The people overseeing case strategy, documentation standards and client experience.',                            'href' => 'leadership'],
];

$ab2Placards = [
    ['title' => 'Eligibility-first',    'text' => 'We check what actually applies to you before recommending a visa category, rather than a one-size-fits-all process.'],
    ['title' => 'Documentation-led',    'text' => 'Most delays come from incomplete or inconsistent documents &mdash; our process is built around catching that early.'],
    ['title' => 'Four-city coverage',   'text' => 'We serve applicants across Patna, Ranchi, Raipur and Bhopal from our Patna base, in person and remotely.'],
    ['title' => 'Plain about outcomes', 'text' => "We're upfront that visa decisions rest solely with the relevant embassy or authority &mdash; we help you present the strongest possible case."],
];

$ab2Cities = [
    'PAT' => ['name' => 'Patna',  'role' => 'Base office',   'note' => 'Our head office, where cases are reviewed and filed. Consultations are available in person and remotely.'],
    'RAN' => ['name' => 'Ranchi', 'role' => 'Served remotely','note' => 'Applicants in Ranchi are supported by the same case team, coordinated remotely from our Patna base.'],
    'RAP' => ['name' => 'Raipur', 'role' => 'Served remotely','note' => 'Applicants in Raipur are supported by the same case team, coordinated remotely from our Patna base.'],
    'BHO' => ['name' => 'Bhopal', 'role' => 'Served remotely','note' => 'Applicants in Bhopal are supported by the same case team, coordinated remotely from our Patna base.'],
];
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

        <!-- ============ LEDE + BOARD (navy band) ============ -->
        <section style="background:var(--theme-2); color:var(--white); padding:48px 0 40px;">
            <div class="container">
                <p class="ab-hero-lead" style="color:rgba(255,255,255,.82); font-size:1.05rem; max-width:64ch; margin:0 0 24px;">Visa Agency handles the documentation side of travel: the forms, the appointment slots, the follow-up calls to embassies. We file for tourist, business, family, transit, medical and extension categories across <?php echo $abCountryCount; ?>+ destinations, and tell you exactly where your file stands at every step.</p>
                <div class="ab-hero-actions" style="display:flex; gap:14px; flex-wrap:wrap; margin-bottom:8px;">
                    <a class="theme-btn hr-btn-gold" href="why-choose-us">See how we work</a>
                    <a class="theme-btn style-2" href="leadership" style="border-color:rgba(255,255,255,.5); color:var(--white);">Meet the team</a>
                </div>
                <div class="ab2-board">
                    <?php foreach ($ab2Board as $r): ?>
                    <div class="ab2-board-row">
                        <span class="code"><?php echo htmlspecialchars($r['code']); ?></span>
                        <span class="label"><?php echo htmlspecialchars($r['label']); ?></span>
                        <span class="value"><?php echo htmlspecialchars($r['value']); ?></span>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- ============ ABOUT AGENCY ============ -->
        <section class="section-padding fix">
            <div class="container">
                <div class="ab2-agency-wrap">
                    <div>
                        <div class="section-title" style="margin-bottom:20px;">
                            <span class="sub-title-2 wow fadeInUp">About The Agency</span>
                            <h2 class="split-text-right split-text-in-right">Consultancy, Not Just Paperwork</h2>
                        </div>
                        <p class="svc-lede" style="margin-bottom:20px;">We guide applicants through eligibility checks, documentation, application preparation and appointment support &mdash; across tourist, business, family, transit, medical and extension visa categories, plus apostille and attestation for supporting documents.</p>
                        <ul class="ab2-agency-list">
                            <li>Talk to one of our consultants today</li>
                            <li>We help you find the right visa pathway</li>
                            <li>Government and service fees always shown as two separate lines</li>
                        </ul>
                        <div style="display:flex; align-items:center; gap:22px; flex-wrap:wrap;">
                            <a class="theme-btn hr-btn-gold" href="why-choose-us">More Detail</a>
                            <a href="tel:+917844819819" style="font-family:monospace; font-size:.95rem; color:var(--header); text-decoration:none;">+91 78448 19819</a>
                        </div>
                    </div>
                    <div class="ab2-mini-board">
                        <div class="mb-head">Fee Summary</div>
                        <?php foreach ($ab2MiniBoard as $m): ?>
                        <div class="ab2-mb-row"><span class="k"><?php echo htmlspecialchars($m['label']); ?></span><span class="v"><?php echo htmlspecialchars($m['value']); ?></span></div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ WHO WE ARE: TICKETS ============ -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Who We Are</span>
                    <h2 class="split-text-right split-text-in-right">Three Ways To Get Started</h2>
                </div>
                <div class="ab2-ticket-grid">
                    <?php foreach ($ab2Tickets as $t): ?>
                    <div class="ab2-ticket">
                        <span class="num"><?php echo htmlspecialchars($t['num']); ?></span>
                        <a href="<?php echo htmlspecialchars($t['href']); ?>"><?php echo htmlspecialchars($t['title']); ?></a>
                        <p><?php echo $t['text']; ?></p>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- ============ GET TO KNOW US (sibling pages) ============ -->
        <section class="section-padding fix">
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

        <!-- ============ HOW A FILE MOVES (flow diagram) ============ -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How A File Moves</span>
                    <h2 class="split-text-right split-text-in-right">Four Stages, In Order</h2>
                </div>
                <p class="svc-lede">Eligibility, documentation, filing and appointment support &mdash; handled in sequence, not all at once.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Eligibility check</h3><p>We check what actually applies to your case before naming a visa category.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Documentation</h3><p>Most delays trace to one missing or inconsistent paper &mdash; we catch that early.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Preparation &amp; filing</h3><p>Forms, translations, apostille where needed &mdash; filed correctly the first time.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Appointment &amp; follow-up</h3><p>We track embassy slots and chase updates, so you are not the one on hold.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ TRAITS: PLACARDS ============ -->
        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How We Work</span>
                    <h2 class="split-text-right split-text-in-right">What Clients Tend To Notice</h2>
                </div>
                <div class="ab2-placards">
                    <?php
                    $ab2Icons = [
                        '<circle cx="12" cy="12" r="9"/><path d="M8 12l2.5 2.5L16 9"/>',
                        '<path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/>',
                        '<circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/>',
                        '<path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/>',
                    ];
                    foreach ($ab2Placards as $i => $t): ?>
                    <div class="ab2-placard">
                        <div class="tile"><svg viewBox="0 0 24 24"><?php echo $ab2Icons[$i]; ?></svg></div>
                        <div>
                            <h3><?php echo htmlspecialchars($t['title']); ?></h3>
                            <p><?php echo $t['text']; ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <!-- ============ CITY SELECTOR ============ -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Where We Operate</span>
                    <h2 class="split-text-right split-text-in-right">Four Cities, One Case Team</h2>
                    <p style="margin-top:10px;">Pick a city to see how we support applicants there.</p>
                </div>
                <div class="ab2-city-wrap">
                    <div class="ab2-city-tabs" role="tablist" aria-label="Office cities" id="ab2CityTabs">
                        <?php $first = true; foreach ($ab2Cities as $code => $c): ?>
                        <button type="button" class="ab2-city-tab" role="tab" data-code="<?php echo htmlspecialchars($code); ?>" aria-selected="<?php echo $first ? 'true' : 'false'; ?>">
                            <span><?php echo htmlspecialchars($c['name']); ?></span>
                            <span class="code"><?php echo htmlspecialchars($code); ?></span>
                        </button>
                        <?php $first = false; endforeach; ?>
                    </div>
                    <div class="ab2-city-panel" id="ab2CityPanel"></div>
                </div>
            </div>
        </section>

        <!-- ============ CLOSING ============ -->
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

<script>
(function () {
    var cityData = <?php echo json_encode($ab2Cities); ?>;
    var tabs = document.querySelectorAll('#ab2CityTabs .ab2-city-tab');
    var panel = document.getElementById('ab2CityPanel');
    if (!tabs.length || !panel) { return; }

    function renderCity(code) {
        var c = cityData[code];
        if (!c) { return; }
        panel.style.opacity = 0;
        setTimeout(function () {
            panel.innerHTML = '<span class="role">' + c.role.toUpperCase() + '</span><h3>' + c.name + '</h3><p>' + c.note + '</p>';
            panel.style.opacity = 1;
        }, 120);
    }

    tabs.forEach(function (tab) {
        tab.addEventListener('click', function () {
            tabs.forEach(function (t) { t.setAttribute('aria-selected', 'false'); });
            tab.setAttribute('aria-selected', 'true');
            renderCity(tab.getAttribute('data-code'));
        });
    });

    renderCity(tabs[0].getAttribute('data-code'));
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
