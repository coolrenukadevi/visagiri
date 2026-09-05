<?php
$page_title = "Work Visa Consultancy &ndash; Visa Agency";
$page_description = "Work visa guidance for employer-sponsored roles abroad &ndash; offer-letter verification, labour-market documentation and dependant visas. By Visa Agency, Patna.";
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
$visa_current = 'visa-work';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Work Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Work Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Employer-Sponsored Roles Abroad</span>
                    <h2 class="split-text-right split-text-in-right">Work Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Moving abroad for a job offer? We help you put together an application that satisfies the
                    destination's labour-market and sponsorship requirements, alongside any dependants travelling
                    with you.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">Employer-Led</span><span class="lbl">Sponsorship-based filing</span></div>
                    <div><span class="num">Solo / Family</span><span class="lbl">Dependant visas handled together</span></div>
                    <div><span class="num">Doc. Review</span><span class="lbl">Contract &amp; certificate checks</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Offer Letter To Departure</h2>
                </div>
                <p class="svc-lede">Work visas hinge on your employer's sponsorship and your own certificates lining up correctly &mdash; we check both before filing.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Offer letter &amp; eligibility check</h3><p>We review your employment contract or offer letter against the destination's work-visa category requirements.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Sponsorship &amp; employer documentation</h3><p>We guide your employer on the sponsorship paperwork and labour-market documentation the destination expects.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Certificate &amp; credential verification</h3><p>Educational certificates and experience letters are checked for completeness, and attested where the destination requires it.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your application, and any accompanying dependant visas, are compiled and filed with the relevant authority.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, we hand over your visa along with the work conditions attached, such as employer tie-in or permitted duration.</p></div>
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
                <p class="svc-lede">Work visas usually require more employer and credential documentation than tourist or business visas &mdash; here's the common baseline.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Signed employment contract or offer letter</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Employer sponsorship documents</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Educational certificates, attested if the destination requires it</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Experience letters from previous employers</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Medical examination report, where required</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Police clearance certificate, where required</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">We Check What Your Employer Can't</h2>
                </div>
                <p class="svc-lede">A work visa application depends on your employer's sponsorship and your own paperwork lining up &mdash; we review both sides.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Sponsorship documentation review</h4><p>We advise your employer on exactly what sponsorship and labour-market documents the destination expects.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Credential &amp; attestation guidance</h4><p>We check whether your certificates need attestation before filing, and coordinate that alongside your visa &mdash; see our <a href="apostille">Apostille &amp; Attestation</a> services.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Dependant visas handled together</h4><p>Where your family is travelling with you, we file their dependant visas alongside your own application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>One caseworker, start to finish</h4><p>A single point of contact tracks your application from offer letter to visa collection &mdash; no re-explaining your case.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Have A Job Offer Abroad?</h2>
                    <p>Share your offer letter and destination &mdash; we'll confirm the documents and sponsorship requirements.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Work Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="work-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Work Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Do I need a job offer before applying? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; almost every work visa route requires a confirmed offer letter or contract, and in most cases employer sponsorship, before an application can be filed.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can my family travel with me? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Many work-visa categories allow accompanying dependants on a linked visa. We'll confirm whether your specific route and destination allow this and file those applications alongside yours.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do my certificates need attestation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Some destinations require educational or experience certificates to be apostilled or attested before they're accepted. We'll confirm this for your destination and can coordinate it through our Apostille &amp; Attestation service.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What's the difference between a business visa and a work visa?</div>
                                <div class="faq-answer"><p>A business visa covers short-term activities like meetings and negotiations and doesn't permit taking up employment. A work visa is required if you'll be employed and paid by a company in the destination country.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
