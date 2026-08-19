<?php
$page_title = "Certificate Attestation Services &ndash; Visa Agency";
$page_description = "Educational, marriage, birth, commercial and personal certificate attestation, matched to your document type. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille-certificate-attestation';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Certificate Attestation</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="apostille">Apostille &amp; Attestation</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Certificate Attestation</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Matched To Your Certificate Type</span>
                    <h2 class="split-text-right split-text-in-right">Certificate Attestation</h2>
                </div>
                <p class="svc-lede">
                    Educational, marriage, birth, commercial and personal document attestation &mdash; each handled
                    according to the specific chain of authorities your certificate type requires.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">4</span><span class="lbl">Certificate categories</span></div>
                    <div><span class="num">125+</span><span class="lbl">Destination countries supported</span></div>
                    <div><span class="num">1&ndash;3 wks</span><span class="lbl">Typical turnaround*</span></div>
                    <div><span class="num">100%</span><span class="lbl">Originals tracked &amp; returned</span></div>
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
                    <h2 class="split-text-right split-text-in-right">How Certificate Attestation Works</h2>
                </div>
                <p class="svc-lede">The chain depends on your certificate category and destination country &mdash; we confirm the exact path before you send anything.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Category check</h3><p>We identify your certificate type &mdash; educational, marriage/birth, commercial or POA &mdash; since each has its own attestation route.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Notary &amp; state-level clearance</h3><p>Notarisation and, where applicable, State HRD or Home Department attestation is completed first.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>MEA apostille or attestation</h3><p>Depending on your destination, the certificate goes through MEA apostille or MEA attestation.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Embassy attestation (if required)</h3><p>For non-Hague destinations, we take the certificate on to the relevant embassy for their final stamp.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Return</h3><p>Your original certificate is verified and returned to you by secure, trackable courier.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Certificate Categories</span>
                    <h2 class="split-text-right split-text-in-right">Attestation Matched To Your Certificate</h2>
                </div>
                <p class="svc-lede">Each category is handled with its specific requirements in mind.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Educational Certificate Attestation</h3><p>Degree, diploma and mark-sheet attestation for study or work abroad.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/><path d="M15.5 13.5A4 4 0 0 1 22 17v2"/></svg></div><h3>Marriage &amp; Birth Certificate Attestation</h3><p>Attestation for family visa, dependent visa and residency applications.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div><h3>Commercial Document Attestation</h3><p>Attestation of business and commercial documents for trade and corporate use.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20l4-1 11-11-3-3L5 16l-1 4z"/></svg></div><h3>Power of Attorney Attestation</h3><p>Attestation support for power of attorney documents used abroad.</p></div>
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
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Right chain, first time</h4><p>We route each certificate type through its correct sequence, avoiding rejections from an incomplete or wrong-order chain.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>State-specific knowledge</h4><p>HRD and Home Department requirements vary by the state that issued your certificate &mdash; we account for this from the start.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Purpose-matched guidance</h4><p>Family visa, work visa and business use often need slightly different supporting steps &mdash; we tailor the process to your purpose.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>One handler, full visibility</h4><p>A single case handler tracks your certificate through every authority in the chain.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Have A Certificate Ready To Attest?</h2>
                    <p>Share the certificate type and destination country &mdash; we'll confirm the exact attestation chain for you.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About Certificate Attestation <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="cert-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Certificate Attestation, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Do I need the original certificate, or is a copy enough? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Attestation authorities require original certificates. A photocopy alone cannot be attested; we'll advise if a certified true copy is acceptable for any specific step.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long does attestation take by certificate type? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Educational certificates typically take longer due to HRD verification; marriage and birth certificates are usually quicker. We'll give you a specific estimate once we know your certificate and destination.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Will my certificate need translation as well? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>If your certificate isn't in English or the destination country's official language, translation is usually required before attestation. See our <a href="apostille-translation-services">Translation Services</a> page for how this fits into the sequence.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What if my certificate has a name mismatch across documents? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Name mismatches (e.g., between a passport and a marriage certificate) can delay attestation. Flag this to us early so we can advise on any affidavit or gazette notification needed before submission.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
