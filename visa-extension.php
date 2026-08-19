<?php
$page_title = "Visa Extension Assistance &ndash; Visa Agency";
$page_description = "Visa extension guidance for extending an existing stay abroad &ndash; eligibility checks, timing windows and reason-specific documentation. By Visa Agency, Patna.";
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
$visa_current = 'visa-extension';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Extension</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Extension</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Extending An Existing Stay</span>
                    <h2 class="split-text-right split-text-in-right">Visa Extension Assistance</h2>
                </div>
                <p class="svc-lede">
                    Need more time on a visa you already hold &mdash; for treatment, business, or personal reasons?
                    We help you apply for an extension before your current visa expires, avoiding overstay complications.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">40+</span><span class="lbl">Countries where we assist</span></div>
                    <div><span class="num">1&ndash;3 wks</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Before expiry</span><span class="lbl">Apply ahead, not after</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Eligibility Check To Extended Stay</h2>
                </div>
                <p class="svc-lede">Extension rules and timing windows vary sharply by country and original visa type.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Eligibility &amp; timing check</h3><p>We confirm whether your visa type is extendable, and the window within which you must apply &mdash; often well before expiry.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Reason documentation</h3><p>We guide you through gathering supporting documents for your reason for extension &mdash; continued treatment, business need, or personal circumstance.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your extension application is filed with the relevant immigration authority in the destination country.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Extended visa collection</h3><p>Once approved, we confirm your new validity period and any conditions attached to the extension.</p></div>
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
                <p class="svc-lede">Extension requirements build on your original visa documentation, plus a clear reason for the extension.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Current passport and existing visa</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of reason for extension (medical, business, or personal)</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Updated financial proof covering the extended stay</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of accommodation for the extended period</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Any host, employer or hospital letter supporting the extension</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Timing Is Everything With Extensions</h2>
                </div>
                <p class="svc-lede">Missing the application window is the single biggest risk with visa extensions &mdash; we help you avoid it.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Early-warning tracking</h4><p>We flag your visa expiry date early, so your extension application goes in within the required window.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Reason-specific documentation</h4><p>Medical, business and personal extension reasons each need different supporting proof &mdash; we tailor this to your case.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Overstay risk guidance</h4><p>We explain the consequences of missing an extension deadline in your specific destination, so you can plan accordingly.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Coordinated with related services</h4><p>If your extension is treatment-related, we coordinate with the guidance on our <a href="visa-medical">Medical Visa</a> page for consistent documentation.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Visa Expiring Soon?</h2>
                    <p>Tell us your current visa type, destination and reason for extension &mdash; we'll confirm if and how it can be extended.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Extension Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="extension-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Visa Extension, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Can any visa type be extended? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Not all &mdash; extendability depends on the destination country's rules and your original visa category. We'll confirm whether your specific visa qualifies.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How early should I apply for an extension? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most countries require extension applications before the current visa expires, often several weeks ahead. We'll confirm the exact window for your destination.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What happens if my visa expires before the extension is approved? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This varies by country &mdash; some allow you to remain legally while the extension is pending, others don't. We'll clarify this for your specific case before you apply.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I extend a visa while I'm still in India? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Some extensions must be applied for from within the destination country, while others can be initiated before travel. We'll confirm the correct process for your visa type.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
