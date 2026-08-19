<?php
$page_title = "Document Legalisation Services &ndash; Visa Agency";
$page_description = "End-to-end document legalisation &ndash; notarisation through state, MEA and embassy-level clearance, managed for you. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$apostille_siblings = [
    ['slug' => 'apostille', 'label' => 'Overview'],
    ['slug' => 'apostille-mea', 'label' => 'MEA Apostille'],
    ['slug' => 'apostille-embassy-attestation', 'label' => 'Embassy Attestation'],
    ['slug' => 'apostille-certificate-attestation', 'label' => 'Certificate Attestation'],
    ['slug' => 'apostille-document-legalisation', 'label' => 'Document Legalisation'],
    ['slug' => 'apostille-translation-services', 'label' => 'Translation Services'],
];
$apostille_current = 'apostille-document-legalisation';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Document Legalisation</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="apostille">Apostille &amp; Attestation</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Document Legalisation</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">The Full Clearance Chain, Managed For You</span>
                    <h2 class="split-text-right split-text-in-right">Document Legalisation</h2>
                </div>
                <p class="svc-lede">
                    End-to-end legalisation of your documents &mdash; from notarisation through state, MEA and, where
                    needed, embassy-level clearance &mdash; so they're accepted as valid wherever you're submitting them abroad.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">185+</span><span class="lbl">Countries covered</span></div>
                    <div><span class="num">1</span><span class="lbl">Single point of coordination</span></div>
                    <div><span class="num">4</span><span class="lbl">Authorities typically involved</span></div>
                    <div><span class="num">1&ndash;3 wks</span><span class="lbl">Typical turnaround*</span></div>
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
                    <h2 class="split-text-right split-text-in-right">The Legalisation Chain, Coordinated End To End</h2>
                </div>
                <p class="svc-lede">"Legalisation" covers the full sequence &mdash; apostille and embassy attestation are both forms of it, depending on your destination.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Notarisation</h3><p>A notary public certifies the document as the foundation for every stage that follows.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>State / HRD attestation</h3><p>The issuing state's Home Department or HRD department attests the document where required by its type.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>MEA-level clearance</h3><p>The Ministry of External Affairs applies an apostille (Hague countries) or attestation (non-Hague countries), depending on destination.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Embassy attestation (where applicable)</h3><p>For non-Hague destinations, the destination country's embassy or consulate provides the final attestation.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Final verification &amp; handover</h3><p>We check the complete chain of stamps against the requirement before returning your document.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">What We Legalise</span>
                    <h2 class="split-text-right split-text-in-right">Documents We Manage Through The Full Chain</h2>
                </div>
                <p class="svc-lede">The same categories as our other apostille and attestation services, coordinated together where you need more than one step.</p>
                <div class="svc-card-grid">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div><h3>Educational documents</h3><p>Degrees, diplomas and transcripts legalised for study, work or licensing use abroad.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="8" cy="8" r="3"/><circle cx="17" cy="9" r="2.5"/><path d="M2 21v-2a5 5 0 0 1 5-5h2a5 5 0 0 1 5 5v2"/><path d="M15.5 13.5A4 4 0 0 1 22 17v2"/></svg></div><h3>Personal documents</h3><p>Birth, marriage, death and single-status certificates legalised for family and residency purposes.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="7" width="18" height="13" rx="1.5"/><path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></div><h3>Commercial documents</h3><p>Certificates of incorporation, MOAs and trade documents legalised for business use abroad.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 20l4-1 11-11-3-3L5 16l-1 4z"/></svg></div><h3>Power of attorney</h3><p>POA documents legalised for property, banking or business matters overseas.</p></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Terminology</span>
                    <h2 class="split-text-right split-text-in-right">Apostille, Attestation, Legalisation</h2>
                </div>
                <p class="svc-lede">These terms are often used loosely. Here's how we use them.</p>
                <div class="svc-card-grid" style="max-width:900px;margin:0 auto;">
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="9" r="6"/><path d="M8 14l-2 7 6-3 6 3-2-7"/></svg></div><h3>Apostille</h3><p>A single MEA-issued certificate, recognised directly by all Hague Convention member countries.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18"/><path d="M9 8h1M9 12h1M9 16h1M14 8h1M14 12h1M14 16h1"/></svg></div><h3>Attestation</h3><p>A chain of authority sign-offs &mdash; state, MEA and embassy &mdash; used for non-Hague destinations.</p></div>
                    <div class="svc-doc-card"><div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="7" y="3" width="10" height="7" rx="1"/><path d="M9 10v4h6v-4M4 21h16M6 21l1-4h10l1 4"/></svg></div><h3>Legalisation</h3><p>The umbrella term for the whole process of making a document valid abroad &mdash; apostille and attestation are both forms of it.</p></div>
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
                    <div class="svc-why-item"><div class="check">01</div><div><h4>One process, whichever route applies</h4><p>Whether your destination needs apostille or full attestation, we manage it as a single coordinated engagement.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>No missed stages</h4><p>We sequence notary, state, MEA and embassy steps correctly, since an out-of-order submission is a common cause of rejection.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Purpose-aware advice</h4><p>Study, work, marriage or business use can each carry slightly different legalisation requirements &mdash; we account for this upfront.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Clear timeline from day one</h4><p>You'll get a realistic estimate for the full chain before we begin, not stage-by-stage surprises.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Need A Document Made Valid Abroad?</h2>
                    <p>Tell us your document, its purpose and destination &mdash; we'll confirm the full legalisation chain and cost.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Enquire About Document Legalisation <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Document Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="legal-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Document Legalisation, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Is legalisation the same as apostille or attestation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Legalisation is the umbrella term &mdash; it's the process of making an Indian document valid for use in another country. Depending on your destination, that process takes the form of an apostille (Hague countries) or attestation (non-Hague countries).</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Which authorities are typically involved? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most legalisation chains involve a notary, the state Home Department or HRD department, the Ministry of External Affairs, and &mdash; for non-Hague destinations &mdash; the relevant embassy or consulate.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long is a legalised document valid? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>The legalisation itself doesn't expire, but some receiving authorities ask for documents legalised within a recent window (often 6&ndash;12 months). We'll flag this if it applies to your case.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can you legalise documents issued outside Bihar? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; we coordinate state-level attestation with the relevant state's Home Department or HRD department regardless of where your document was issued.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
