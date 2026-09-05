<?php
$page_title = "Family Visa Consultancy &ndash; Visa Agency";
$page_description = "Family visa guidance for reunification with a spouse, parent or child abroad &ndash; relationship documentation and sponsor coordination. By Visa Agency, Patna.";
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
$visa_current = 'visa-family';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Family Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Family Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Reunification &amp; Dependants</span>
                    <h2 class="split-text-right split-text-in-right">Family Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Reuniting with a spouse, parent, child or other dependant abroad involves proving both your
                    relationship and your sponsor's ability to support you. We help you build that case clearly.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">100+</span><span class="lbl">Destinations covered</span></div>
                    <div><span class="num">2&ndash;8 wks</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Spouse / Child / Parent</span><span class="lbl">Relationship types supported</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Relationship Proof To Reunion</h2>
                </div>
                <p class="svc-lede">Family visas depend on clear, consistent documentation across both the applicant and sponsor.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Relationship &amp; sponsor eligibility check</h3><p>We confirm which family visa category applies and whether your sponsor meets the destination's income and status requirements.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Relationship documentation</h3><p>We guide you through gathering marriage, birth or other certificates that establish your relationship to the sponsor.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Sponsor financial documentation</h3><p>We help your sponsor prepare proof of income, accommodation and ability to support you, as required by the destination.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your application, along with the sponsor's supporting documents, is compiled and filed.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Appointment &amp; visa collection</h3><p>We assist with any required appointment, then hand over your visa once issued.</p></div>
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
                <p class="svc-lede">Requirements depend on the relationship type and destination &mdash; here's the common baseline.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Marriage, birth or relationship certificate, as applicable</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Sponsor's proof of status in the destination country</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Sponsor's proof of income and accommodation</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Invitation or sponsorship letter from the sponsor</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Photographs meeting the destination's specific format</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Relationship Documentation, Handled With Care</h2>
                </div>
                <p class="svc-lede">Family visas are personal &mdash; we treat the process, and your documents, accordingly.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Category clarity</h4><p>Spouse, dependent child, parent and other family categories each have different requirements &mdash; we confirm the right one before you apply.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Sponsor coordination</h4><p>We work with both the applicant and the sponsor abroad, so documentation on both sides stays consistent.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Certificate attestation coordinated</h4><p>Where your marriage or birth certificate needs apostille or attestation first, we coordinate this as part of the same process &mdash; see our <a href="apostille">Apostille &amp; Attestation</a> services.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Sensitive handling</h4><p>Original family documents are logged, tracked and returned securely &mdash; see our <a href="data-security">Data Security</a> page for detail.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Reuniting With Family Abroad?</h2>
                    <p>Tell us your relationship to the sponsor and destination country &mdash; we'll confirm the exact requirements.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Family Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="family-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Family Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Which family members can I sponsor or be sponsored by? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This depends entirely on the destination country's rules &mdash; most permit spouses and dependent children, with some allowing parents or other relatives. We'll confirm what applies to your situation.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Does my sponsor need to meet an income requirement? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Many countries set a minimum income or savings threshold for the sponsor. We'll advise on the specific figure for your destination and help prepare the proof.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do my certificates need to be attested before I apply? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Some destinations require marriage or birth certificates to be apostilled or attested first. We'll confirm this and coordinate it as part of your application if needed.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long does a family visa take to process? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Timelines vary widely by destination and category, from a few weeks to a few months. We'll give you a specific estimate once we know your case.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
