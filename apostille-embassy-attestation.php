<?php
$page_title = "Embassy Attestation Services &ndash; Visa Agency";
$page_description = "Embassy attestation for non-Hague Convention countries including UAE, Qatar, Saudi Arabia and more. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille-embassy-attestation';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Embassy Attestation</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="apostille">Apostille &amp; Attestation</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Embassy Attestation</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">For Non-Hague Convention Countries</span>
                    <h2 class="split-text-right split-text-in-right">Embassy Attestation</h2>
                </div>
                <p class="svc-lede">
                    For countries that haven't joined the Hague Convention, your documents need attestation from the
                    destination country's own embassy or consulate in India &mdash; after state and MEA-level clearance.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">60+</span><span class="lbl">Non-Hague countries covered</span></div>
                    <div><span class="num">4 stages</span><span class="lbl">Notary &rarr; State &rarr; MEA &rarr; Embassy</span></div>
                    <div><span class="num">2&ndash;3 wks</span><span class="lbl">Typical turnaround*</span></div>
                    <div><span class="num">GCC</span><span class="lbl">Common destination region</span></div>
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
                    <h2 class="split-text-right split-text-in-right">How Embassy Attestation Works</h2>
                </div>
                <p class="svc-lede">A longer chain than apostille, since each authority in the sequence must clear the document before the next will accept it.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Notarisation</h3><p>Your document is first notarised, establishing the base level of certification everything else builds on.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>State / HRD attestation</h3><p>The relevant State Home Department or HRD department attests the document, depending on its type.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>MEA attestation</h3><p>The Ministry of External Affairs attests the document centrally, a required step before any embassy will accept it.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Embassy / consulate attestation</h3><p>We submit to the destination country's embassy or consulate in India for their final attestation stamp.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Verification &amp; return</h3><p>We check every stamp against the embassy's own checklist before returning your original document to you.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">What We Attest</span>
                    <h2 class="split-text-right split-text-in-right">Document Categories We Handle</h2>
                </div>
                <p class="svc-lede">Each moves through the same four authorities, but with category-specific pre-requisites.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Educational certificates</h3><p>Degrees, diplomas and mark sheets for work visas and further study in non-Hague countries.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/><path d="M15.5 13.5A4 4 0 0 1 22 17v2"/></svg></div><h3>Personal documents</h3><p>Birth, marriage and single-status certificates for family and dependent visa applications.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div><h3>Commercial documents</h3><p>Trade licenses, MOAs and invoices for business set-up or trade with non-Hague countries.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20l4-1 11-11-3-3L5 16l-1 4z"/></svg></div><h3>Power of attorney</h3><p>Embassy attestation support for POA documents used for property or business abroad.</p></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Coverage</span>
                    <h2 class="split-text-right split-text-in-right">Countries That Require Embassy Attestation</h2>
                </div>
                <p class="svc-lede">Non-Hague destinations we handle regularly &mdash; see our full country list for others.</p>
                <div class="svc-chip-row" style="justify-content:center;max-width:900px;margin:0 auto;">
                    <span class="chip">🇦🇪 UAE</span>
                    <span class="chip">🇶🇦 Qatar</span>
                    <span class="chip">🇸🇦 Saudi Arabia</span>
                    <span class="chip">🇰🇼 Kuwait</span>
                    <span class="chip">🇧🇭 Bahrain</span>
                    <span class="chip">🇴🇲 Oman</span>
                    <span class="chip">🇪🇬 Egypt</span>
                    <span class="chip">🇮🇩 Indonesia</span>
                    <span class="chip">🇨🇦 Canada</span>
                    <span class="chip">🇨🇳 China</span>
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
                    <div class="svc-why-item"><div class="check">01</div><div><h4>GCC experience</h4><p>Regular attestation for UAE, Qatar, Saudi Arabia and Kuwait means we know each embassy's current checklist.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Sequenced correctly</h4><p>Skipping a stage is a common cause of embassy rejection &mdash; we ensure state and MEA clearance happen first, in order.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Embassy liaison</h4><p>We track embassy processing directly, rather than leaving you to follow up on your own.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Full chain in one enquiry</h4><p>Notary through embassy attestation is coordinated as a single engagement, not four separate bookings.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Applying To A Non-Hague Country?</h2>
                    <p>Tell us your destination and document type &mdash; we'll map the exact attestation chain and timeline.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About Embassy Attestation <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="embassy-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Embassy Attestation, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Which countries require embassy attestation instead of apostille? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Any country outside the Hague Convention &mdash; commonly the UAE, Qatar, Saudi Arabia, Kuwait, Bahrain, Oman, Egypt, Canada and China, among others. We'll confirm the exact requirement for your destination.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need to visit the embassy myself? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>No &mdash; we submit and collect on your behalf through the embassy's authorised attestation process, so you don't need to visit in person.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Why does embassy attestation take longer than apostille? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Because it involves four sequential authorities (notary, state, MEA, embassy) instead of one. Each stage depends on the previous one being complete, and embassy processing times vary by country.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I skip MEA attestation and go straight to the embassy? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>No &mdash; nearly all embassies in India require MEA attestation to be completed first, and will reject documents submitted out of sequence.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
