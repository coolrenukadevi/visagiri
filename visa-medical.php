<?php
$page_title = "Medical Visa Consultancy &ndash; Visa Agency";
$page_description = "Medical visa guidance for treatment abroad &ndash; hospital documentation and accompanying attendant applications. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$visa_siblings = [
    ['slug' => 'visa-tourist', 'label' => 'Tourist Visa'],
    ['slug' => 'visa-business', 'label' => 'Business Visa'],
    ['slug' => 'visa-family', 'label' => 'Family Visa'],
    ['slug' => 'visa-transit', 'label' => 'Transit Visa'],
    ['slug' => 'visa-sports', 'label' => 'Sports Visa'],
    ['slug' => 'visa-medical', 'label' => 'Medical Visa'],
    ['slug' => 'visa-crew', 'label' => 'Crew Visa'],
    ['slug' => 'visa-extension', 'label' => 'Visa Extension'],
];
$visa_current = 'visa-medical';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Medical Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Medical Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Treatment &amp; Attendant Travel</span>
                    <h2 class="split-text-right split-text-in-right">Medical Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Travelling abroad for treatment is stressful enough without visa uncertainty. We help you and
                    an accompanying attendant put together a complete, hospital-backed application.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">60+</span><span class="lbl">Destinations covered</span></div>
                    <div><span class="num">1&ndash;3 wks</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Patient + Attendant</span><span class="lbl">Applications supported together</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Hospital Appointment To Travel</h2>
                </div>
                <p class="svc-lede">A medical visa depends on clear documentation from the treating hospital abroad.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Hospital &amp; eligibility check</h3><p>We confirm the destination's medical visa requirements and whether the treating hospital is recognised for visa purposes.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Medical documentation</h3><p>We guide you through gathering medical reports, referral letters and the hospital's appointment or treatment-acceptance letter.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Attendant application (if applicable)</h3><p>Where an attendant is travelling with you, we prepare their application alongside yours, referencing the same medical documentation.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Patient and attendant applications are filed together where the destination allows joint processing.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, we hand over your visa along with guidance on any extension process for continued treatment.</p></div>
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
                <p class="svc-lede">Medical visas rely on hospital-issued documentation more than any other category.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Treatment acceptance or appointment letter from the destination hospital</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Medical reports and referral letter from your treating doctor in India</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of sufficient funds to cover treatment and stay</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Attendant's passport and relationship proof, if travelling together</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Return or onward travel itinerary</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Handled With The Sensitivity It Deserves</h2>
                </div>
                <p class="svc-lede">We understand that a medical visa application often comes at a difficult time.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Hospital documentation guidance</h4><p>We advise on exactly what a treatment acceptance letter needs to include to satisfy embassy requirements.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Attendant coordination</h4><p>We prepare the accompanying attendant's application alongside the patient's, keeping both consistent and complete.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Priority handling</h4><p>Medical visa applications are time-sensitive &mdash; we prioritise document review and filing accordingly.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Extension guidance included</h4><p>If treatment runs longer than expected, we advise on the extension process &mdash; see our <a href="visa-extension">Visa Extension</a> service.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Need To Travel For Treatment?</h2>
                    <p>Share your treatment destination and hospital details &mdash; we'll confirm the visa route for you and your attendant.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Medical Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="medical-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Medical Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Can an attendant travel with me on a medical visa? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most countries allow one or more attendants to apply alongside the patient, usually with proof of relationship. We'll confirm the specific allowance for your destination.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What if my treatment takes longer than my visa validity? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Many countries allow medical visa extensions with updated hospital documentation. See our <a href="visa-extension">Visa Extension</a> service, or ask your case handler once you're abroad.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Does the hospital need to be on an approved list? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Some countries require treatment at a hospital or clinic recognised for medical visa purposes. We'll confirm this before you finalise your hospital choice, where possible.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How quickly can a medical visa be processed? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Many destinations prioritise medical visa applications given their time-sensitive nature. We'll give you a specific estimate once we have your hospital documentation.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
