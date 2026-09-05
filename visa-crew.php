<?php
$page_title = "Crew Visa Consultancy &ndash; Visa Agency";
$page_description = "Crew visa guidance for seafarers and airline crew &ndash; employer-backed documentation for sign-on and sign-off. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$visa_siblings = [
    ['slug' => 'visa-tourist', 'label' => 'Tourist Visa'],
    ['slug' => 'visa-business', 'label' => 'Business Visa'],
    ['slug' => 'visa-work', 'label' => 'Work Visa'],
    ['slug' => 'visa-family', 'label' => 'Family Visa'],
    ['slug' => 'visa-transit', 'label' => 'Transit Visa'],
    ['slug' => 'visa-sports', 'label' => 'Sports Visa'],
    ['slug' => 'visa-medical', 'label' => 'Medical Visa'],
    ['slug' => 'visa-crew', 'label' => 'Crew Visa'],
    ['slug' => 'visa-extension', 'label' => 'Visa Extension'],
];
$visa_current = 'visa-crew';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Crew Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Crew Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Seafarers &amp; Airline Crew</span>
                    <h2 class="split-text-right split-text-in-right">Crew Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Joining a vessel or signing off in a foreign port? We help seafarers and airline crew put
                    together the employer-backed documentation that crew visas depend on.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">50+</span><span class="lbl">Ports &amp; destinations covered</span></div>
                    <div><span class="num">3&ndash;10 days</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Sign-on / Sign-off</span><span class="lbl">Both journey types supported</span></div>
                    <div><span class="num">1:1</span><span class="lbl">Dedicated case handler</span></div>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Visa services">
            <div class="svc-sibling-inner">
                <?php foreach ($visa_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $visa_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How It Works</span>
                    <h2 class="split-text-right split-text-in-right">From Employer Letter To Sign-On</h2>
                </div>
                <p class="svc-lede">Crew visas move on tight timelines tied to vessel or flight schedules &mdash; we prioritise accordingly.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Role &amp; eligibility check</h3><p>We confirm the visa category based on whether you're signing on, signing off, or in transit as crew.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Employer &amp; vessel documentation</h3><p>We guide you through gathering your employment contract, CDC/seaman's book and the shipping company or airline's letter.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your application is filed with the relevant embassy, consulate or port authority, matched to your sign-on schedule.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, we hand over your visa along with any conditions tied to vessel or flight movement.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Documents You'll Need</span>
                    <h2 class="split-text-right split-text-in-right">What You'll Typically Need</h2>
                </div>
                <p class="svc-lede">Crew visas rely on employer and vessel documentation more than personal travel documents.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Continuous Discharge Certificate (CDC) or seaman's book, where applicable</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Employment contract with the shipping company or airline</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Letter from the employer confirming vessel/flight, port and sign-on date</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Seafarer's or crew identity document, where issued</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of onward or return travel, where required</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">We Work To Your Vessel's Schedule</h2>
                </div>
                <p class="svc-lede">Crew visa timelines are dictated by sailing and flight schedules, not the other way around.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Schedule-aware processing</h4><p>We prioritise crew visa applications against your actual sign-on or sign-off date, not a generic queue.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Employer document guidance</h4><p>We advise your shipping company or airline on the exact letter format embassies expect for crew visas.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Port &amp; transit knowledge</h4><p>We understand which ports and countries require crew visas even for short transit calls.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Fast turnaround</h4><p>Given the operational nature of crew travel, we prioritise document review and submission for these cases.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Joining A Vessel Or Flight Soon?</h2>
                    <p>Share your sign-on date, port and employer details &mdash; we'll confirm the documents and timeline.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Crew Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="crew-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Crew Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Is a crew visa the same for sign-on and sign-off? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>The category can differ depending on whether you're joining a vessel/flight or leaving one at a foreign port &mdash; we'll confirm the correct type for your situation.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need a CDC or seaman's book? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>For seafarers, yes &mdash; this is typically required alongside your passport and employment contract. Airline crew will need airline-issued crew identification instead.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How quickly can a crew visa be processed? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Given the operational nature of vessel and flight schedules, many crew visas are processed on an expedited basis &mdash; we'll confirm a specific timeline once we have your documents.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Does a crew visa allow transit through other countries en route? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This depends on your routing and the transit country's own rules &mdash; see our <a href="visa-transit">Transit Visa</a> service if your journey includes connecting stops.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
