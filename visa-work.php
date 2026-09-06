<?php
$page_title = "Work Visa Consultancy &ndash; Visa Agency";
$page_description = "Work visa consultancy for employer-sponsored roles abroad &ndash; sponsorship documentation, credential verification and dependant visas.";
include __DIR__ . '/includes/header.php';

$visa_siblings = [
    ['slug' => 'visa-services', 'label' => 'Overview'],
    ['slug' => 'visa-tourist', 'label' => 'Tourist'],
    ['slug' => 'visa-business', 'label' => 'Business'],
    ['slug' => 'visa-work', 'label' => 'Work'],
    ['slug' => 'visa-family', 'label' => 'Family'],
    ['slug' => 'visa-transit', 'label' => 'Transit'],
    ['slug' => 'visa-medical', 'label' => 'Medical'],
    ['slug' => 'visa-sports', 'label' => 'Sports'],
    ['slug' => 'visa-crew', 'label' => 'Crew'],
    ['slug' => 'visa-extension', 'label' => 'Extension'],
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
                        <li><a href="visa-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Work Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Visa categories">
            <div class="svc-sibling-inner">
                <?php foreach ($visa_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $visa_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
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
                <h3 style="margin:32px 0 14px; font-size:18px;">Documents you'll typically need</h3>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Signed employment contract or offer letter</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Employer sponsorship documents</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Educational certificates, attested if the destination requires it</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Experience letters from previous employers</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Medical examination report, where required</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Police clearance certificate, where required</span></div>
                </div>
                <div class="svc-why-grid" style="margin-top:32px;">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Sponsorship documentation review</h4><p>We advise your employer on exactly what sponsorship and labour-market documents the destination expects.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Credential &amp; attestation guidance</h4><p>We check whether your certificates need attestation before filing, and coordinate that alongside your visa &mdash; see our <a href="apostille">Apostille &amp; Attestation</a> services.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Dependant visas handled together</h4><p>Where your family is travelling with you, we file their dependant visas alongside your own application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>One caseworker, start to finish</h4><p>A single point of contact tracks your application from offer letter to visa collection &mdash; no re-explaining your case.</p></div></div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
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
                        <div class="faq-answer"><p>Some destinations require educational or experience certificates to be apostilled or attested before they're accepted. We'll confirm this and can coordinate it through our Apostille &amp; Attestation service.</p></div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Start Your Work Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
