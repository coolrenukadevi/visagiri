<?php
$page_title = "Certified Translation &amp; Notary Services &ndash; Visa Agency";
$page_description = "Certified translation and notary assistance so your documents meet language and format requirements for apostille, attestation or visa filing. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille-translation-services';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Translation &amp; Notary Assistance</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="apostille">Apostille &amp; Attestation</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Translation Services</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Certified &amp; Notary-Ready</span>
                    <h2 class="split-text-right split-text-in-right">Translation &amp; Notary Assistance</h2>
                </div>
                <p class="svc-lede">
                    Certified translation and notary assistance so your documents meet the language and format
                    requirements of the destination country, embassy or receiving authority.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">12+</span><span class="lbl">Language pairs supported</span></div>
                    <div><span class="num">100%</span><span class="lbl">Certified &amp; notary-ready</span></div>
                    <div><span class="num">2&ndash;5 days</span><span class="lbl">Typical turnaround*</span></div>
                    <div><span class="num">1</span><span class="lbl">Coordinated with your attestation</span></div>
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
                    <h2 class="split-text-right split-text-in-right">How Our Translation Process Works</h2>
                </div>
                <p class="svc-lede">Translation is often a prerequisite step before apostille or attestation &mdash; we sequence it correctly for you.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Document &amp; language check</h3><p>We confirm the source and target language, and whether the destination authority requires a certified or notarised translation.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Certified translation</h3><p>A qualified translator prepares the translation, retaining the original document's layout and formatting where possible.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Notarisation (where required)</h3><p>If the receiving authority requires it, the translation is notarised alongside or attached to the original document.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Attach to your apostille / attestation chain</h3><p>Where you're also attesting the original, we coordinate the translation into the correct point in that sequence.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Delivery</h3><p>You receive the certified translation, with the original document, ready for submission.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Common Uses</span>
                    <h2 class="split-text-right split-text-in-right">What We Translate</h2>
                </div>
                <p class="svc-lede">Certificate types where certified translation is most often required.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Educational certificates</h3><p>Degrees, diplomas and mark sheets translated for university admissions or work visa applications.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/><path d="M15.5 13.5A4 4 0 0 1 22 17v2"/></svg></div><h3>Personal documents</h3><p>Birth, marriage and identity documents translated for family and dependent visa use.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div><h3>Commercial documents</h3><p>Contracts, MOAs and business certificates translated for trade or corporate submissions.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20l4-1 11-11-3-3L5 16l-1 4z"/></svg></div><h3>Legal &amp; POA documents</h3><p>Power of attorney and legal documents translated with notary support where required.</p></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Coverage</span>
                    <h2 class="split-text-right split-text-in-right">Language Pairs We Handle Most Often</h2>
                </div>
                <p class="svc-lede">Beyond English, our most-requested language pairs &mdash; let us know if yours isn't listed.</p>
                <div class="svc-chip-row" style="justify-content:center;max-width:900px;margin:0 auto;">
                    <span class="chip">Hindi &hArr; English</span>
                    <span class="chip">Arabic &hArr; English</span>
                    <span class="chip">French &hArr; English</span>
                    <span class="chip">German &hArr; English</span>
                    <span class="chip">Spanish &hArr; English</span>
                    <span class="chip">Bengali &hArr; English</span>
                    <span class="chip">Urdu &hArr; English</span>
                    <span class="chip">Mandarin &hArr; English</span>
                    <span class="chip">Russian &hArr; English</span>
                    <span class="chip">Portuguese &hArr; English</span>
                </div>
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
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Certified, not casual</h4><p>Our translations are certified to the standard embassies and receiving institutions expect, not a plain-text conversion.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Sequenced with attestation</h4><p>If your document also needs apostille or embassy attestation, we place translation at the correct point in that chain.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Format preserved</h4><p>Translations mirror the layout of your original certificate, which many authorities specifically require.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Notary support included</h4><p>Where the destination requires a notarised translation, we arrange this alongside the translation itself.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Need A Document Translated For Submission?</h2>
                    <p>Tell us the document, language pair and destination &mdash; we'll confirm the right sequence and turnaround.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About Translation Services <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="translate-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Translation Services, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Should translation happen before or after attestation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>It depends on the destination authority's requirement &mdash; some want the original attested first, then translated; others want the translation notarised together with the original. We confirm the correct order for your specific case.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What's the difference between certified and notarised translation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>A certified translation includes a signed statement from the translator attesting to its accuracy. A notarised translation additionally has that certification witnessed and stamped by a notary public. Some authorities require one, some require both &mdash; we'll confirm which applies.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can you translate documents into languages other than English? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; we support translation between English and several other languages, and can advise on availability for less common language pairs on request.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Will the translation be accepted alongside my original document? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; we provide the translation together with a copy of the original and the required certification, formatted for submission alongside the source document.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
