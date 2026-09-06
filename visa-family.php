<?php
$page_title = "Family Visa Consultancy &ndash; Visa Agency";
$page_description = "Family visa consultancy for reunification with a sponsor &ndash; relationship documentation, sponsor financials and application filing.";
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
                        <li><a href="visa-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Family Visa</li>
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
                    <span class="sub-title-2 wow fadeInUp">Reunification &amp; Dependants</span>
                    <h2 class="split-text-right split-text-in-right">Family Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Reuniting with a spouse, parent, child or other dependant abroad involves proving both your
                    relationship and your sponsor's ability to support you. We help you build that case clearly.
                </p>
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
                <h3 style="margin:32px 0 14px; font-size:18px;">Documents you'll typically need</h3>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Marriage, birth or relationship certificate, as applicable</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Sponsor's proof of status in the destination country</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Sponsor's proof of income and accommodation</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Invitation or sponsorship letter from the sponsor</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Photographs meeting the destination's specific format</span></div>
                </div>
                <div class="svc-why-grid" style="margin-top:32px;">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Category clarity</h4><p>Spouse, dependent child, parent and other family categories each have different requirements &mdash; we confirm the right one before you apply.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Sponsor coordination</h4><p>We work with both the applicant and the sponsor abroad, so documentation on both sides stays consistent.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Certificate attestation coordinated</h4><p>Where your marriage or birth certificate needs apostille or attestation first, we coordinate this as part of the same process &mdash; see our <a href="apostille">Apostille &amp; Attestation</a> services.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Sensitive handling</h4><p>Original family documents are logged, tracked and returned securely &mdash; see our <a href="data-security">Data Security</a> page for detail.</p></div></div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
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
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Start Your Family Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
