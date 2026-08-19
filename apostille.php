<?php
$page_title = "Apostille &amp; Attestation Services &ndash; Visa Agency";
$page_description = "Apostille, MEA attestation, embassy attestation, certificate attestation, document legalisation and translation services from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Apostille &amp; Attestation</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Overview</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Document Legalisation</span>
                    <h2 class="split-text-right split-text-in-right">Apostille &amp; Attestation Services</h2>
                </div>
                <p class="svc-lede">
                    Many countries require your Indian certificates to be apostilled or attested before they can be
                    used abroad &mdash; for education, employment, marriage or business. We guide you through the
                    correct process for each document type, start to finish.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">125+</span><span class="lbl">Hague countries covered</span></div>
                    <div><span class="num">60+</span><span class="lbl">Non-Hague countries covered</span></div>
                    <div><span class="num">10+</span><span class="lbl">Document types handled</span></div>
                    <div><span class="num">5&ndash;10 days</span><span class="lbl">Typical turnaround*</span></div>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Apostille services">
            <div class="svc-sibling-inner">
                <?php foreach ($apostille_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $apostille_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How It Works</span>
                    <h2 class="split-text-right split-text-in-right">One Process, Tailored To Your Document</h2>
                </div>
                <p class="svc-lede">The exact chain depends on your document type and destination country, but every case follows the same broad path.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us your document &amp; destination</h3><p>Share the certificate type and the country you're submitting it to &mdash; we confirm whether it needs an apostille, embassy attestation, or both.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Notarisation &amp; state-level clearance</h3><p>We arrange notary and, where required, State Home Department or HRD attestation before the document goes further.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>MEA apostille or embassy attestation</h3><p>Depending on whether the destination is a Hague Convention country, we route your document through MEA apostille or the relevant embassy.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Verification &amp; delivery</h3><p>Once cleared, we verify every stamp and page, then return your original document to you by secure courier or in person.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Our Services</span>
                    <h2 class="split-text-right split-text-in-right">Six Services, One Enquiry</h2>
                </div>
                <p class="svc-lede">Each of the following is available as a standalone service, or bundled together for a single application.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="9" r="6"/><path d="M8 14l-2 7 6-3 6 3-2-7"/></svg></div><h3>MEA Apostille</h3><p>Apostille from the Ministry of External Affairs for the 125+ countries under the Hague Convention.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18"/><path d="M9 8h1M9 12h1M9 16h1M14 8h1M14 12h1M14 16h1"/></svg></div><h3>Embassy Attestation</h3><p>Attestation from the destination country's embassy or consulate, for countries outside the Hague Convention.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Certificate Attestation</h3><p>Educational, marriage, birth, commercial and personal document attestation, matched to your purpose.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="7" y="3" width="10" height="7" rx="1"/><path d="M9 10v4h6v-4M4 21h16M6 21l1-4h10l1 4"/></svg></div><h3>Document Legalisation</h3><p>The full legalisation chain &mdash; notary through state, MEA and embassy-level clearance &mdash; managed end to end.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 5h9M7 3v2M11 5c-.5 4-3 7-7 9M6 10c1.5 2 4 3.5 6 4"/><path d="M14 21l4-9 4 9M15.5 18h5"/></svg></div><h3>Translation Services</h3><p>Certified translation and notary assistance so your documents meet language and format requirements.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg></div><h3>Power of Attorney Attestation</h3><p>Attestation support for power of attorney documents used for property, business or family matters abroad.</p></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Handled With Care, Start To Finish</h2>
                </div>
                <p class="svc-lede">Documents like these can't be easily replaced &mdash; we treat every certificate that passes through our office accordingly.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Document-type expertise</h4><p>We handle educational, personal and commercial documents differently, because each has its own attestation chain.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Country-specific routing</h4><p>We know which countries need MEA apostille alone, and which also require embassy attestation.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Originals handled securely</h4><p>Every physical document is logged, tracked and returned by trackable courier &mdash; see our <a href="data-security">Data Security</a> page for detail.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>One point of contact</h4><p>A single case handler manages your document through every stage, so you're never chasing multiple departments.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Not Sure Which Service You Need?</h2>
                    <p>Tell us your document and destination country &mdash; we'll map out the exact steps and cost before you commit.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About Apostille Services <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="apostille-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Apostille &amp; Attestation, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">What's the difference between apostille and attestation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>An apostille is a single-step certification recognised by all 125+ Hague Convention member countries. Attestation is a multi-step process &mdash; typically state, MEA and embassy-level &mdash; required for countries that haven't joined the Hague Convention.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How do I know which one my document needs? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>It depends on your destination country. Hague Convention members (most of Europe, the Americas, and several parts of Asia) generally accept an apostille. Countries like the UAE, Qatar and Saudi Arabia typically require embassy attestation instead. Tell us your destination and we'll confirm the exact requirement.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long does the process take? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Typical turnaround is 5&ndash;10 working days for MEA apostille, and can extend to 2&ndash;3 weeks for embassy attestation depending on the embassy's own processing time. We'll give you a specific estimate once we know your document and destination.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need to send original documents? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; apostille and attestation are applied to original certificates, not photocopies. We provide secure document handling and trackable return courier; see our <a href="data-security">Data Security</a> page for how originals are protected.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
