<?php
$page_title = "MEA Apostille Services &ndash; Visa Agency";
$page_description = "MEA apostille from India's Ministry of External Affairs for Hague Convention countries &ndash; educational, personal, commercial and POA documents. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille-mea';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">MEA Apostille</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="apostille">Apostille &amp; Attestation</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>MEA Apostille</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">For Hague Convention Countries</span>
                    <h2 class="split-text-right split-text-in-right">MEA Apostille</h2>
                </div>
                <p class="svc-lede">
                    An apostille from India's Ministry of External Affairs is a single-step authentication accepted
                    directly by all 125+ countries under the Hague Convention &mdash; no embassy visit required.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">125+</span><span class="lbl">Hague member countries</span></div>
                    <div><span class="num">1 step</span><span class="lbl">MEA-only, no embassy visit</span></div>
                    <div><span class="num">5&ndash;10 days</span><span class="lbl">Typical turnaround*</span></div>
                    <div><span class="num">3</span><span class="lbl">Document categories covered</span></div>
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
                    <h2 class="split-text-right split-text-in-right">How MEA Apostille Works</h2>
                </div>
                <p class="svc-lede">A streamlined, single-authority process for Hague Convention destinations.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Document verification</h3><p>We check your certificate is eligible for apostille and confirm any state-level clearance it needs first.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>State / HRD attestation (if required)</h3><p>Educational certificates typically need State HRD attestation before MEA will apostille them; we arrange this on your behalf.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>MEA apostille</h3><p>The document is submitted to an MEA-authorised apostille centre, where the apostille sticker and stamp are affixed.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Quality check &amp; return</h3><p>We verify the apostille details against your document before returning the original to you securely.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">What We Apostille</span>
                    <h2 class="split-text-right split-text-in-right">Document Categories We Handle</h2>
                </div>
                <p class="svc-lede">Each category follows a slightly different pre-clearance path before MEA apostille.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Educational certificates</h3><p>Degrees, diplomas, mark sheets and transfer certificates for study or work visas abroad.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/><path d="M15.5 13.5A4 4 0 0 1 22 17v2"/></svg></div><h3>Personal documents</h3><p>Birth, marriage, death and single-status certificates for family and dependent visa applications.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div><h3>Commercial documents</h3><p>Invoices, certificates of origin, MOAs and other business documents for trade and corporate use.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20l4-1 11-11-3-3L5 16l-1 4z"/></svg></div><h3>Power of attorney</h3><p>Apostille support for power of attorney documents used for property or business matters abroad.</p></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Coverage</span>
                    <h2 class="split-text-right split-text-in-right">Popular Hague Convention Destinations</h2>
                </div>
                <p class="svc-lede">A sample of countries that accept an MEA apostille directly &mdash; see our full country list for others.</p>
                <div class="svc-chip-row" style="justify-content:center;max-width:900px;margin:0 auto;">
                    <span class="chip">🇩🇪 Germany</span>
                    <span class="chip">🇫🇷 France</span>
                    <span class="chip">🇮🇹 Italy</span>
                    <span class="chip">🇪🇸 Spain</span>
                    <span class="chip">🇳🇱 Netherlands</span>
                    <span class="chip">🇺🇸 United States</span>
                    <span class="chip">🇦🇺 Australia</span>
                    <span class="chip">🇬🇧 United Kingdom</span>
                    <span class="chip">🇯🇵 Japan</span>
                    <span class="chip">🇿🇦 South Africa</span>
                    <span class="chip">🇧🇷 Brazil</span>
                    <span class="chip">🇰🇷 South Korea</span>
                </div>
                <p class="text-center mt-4"><a href="country-list" class="theme-btn style-2">View Full Country List</a></p>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Handled With Care, Start To Finish</h2>
                </div>
                <p class="svc-lede">Documents like these can't be easily replaced &mdash; we treat every certificate that passes through our office accordingly.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>MEA-authorised routing</h4><p>We submit only through MEA-authorised apostille centres, avoiding delays from misrouted applications.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Pre-clearance handled</h4><p>State and HRD attestation, where required, is arranged before MEA submission &mdash; one less thing for you to track.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Category-aware process</h4><p>Educational, personal and commercial documents each follow their correct pre-clearance path from day one.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Transparent status updates</h4><p>You'll know exactly which stage your document is at, without needing to call multiple offices yourself.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Ready To Get Your Document Apostilled?</h2>
                    <p>Send us your document type and destination country and we'll confirm the exact steps and timeline.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About MEA Apostille <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="mea-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">MEA Apostille, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Is an apostille the same as attestation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>No. An apostille is a single MEA-issued certification recognised by all Hague Convention members. Attestation is a longer, multi-authority chain used for non-Hague countries. If your destination is a Hague member, apostille alone is usually sufficient.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Does my educational certificate need State HRD attestation first? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>In most states, yes &mdash; HRD or state-level attestation is a prerequisite before MEA will apostille an educational certificate. We check this for your specific state and document.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long is an apostille valid for? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>An apostille itself doesn't expire, but some receiving institutions or embassies ask for one issued within a recent window (commonly 6&ndash;12 months) &mdash; we'll flag this if it applies to your case.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can commercial documents be apostilled? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes, subject to the document being executed and, where needed, notarised correctly beforehand. We'll review your commercial document and confirm the exact pre-requisites.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
