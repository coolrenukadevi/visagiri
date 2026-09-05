<?php
$page_title = "Foreign Currency Notes &ndash; Visa Agency Forex";
$page_description = "Buy foreign currency notes for your trip, at a rate confirmed before you commit. Document-assisted, quotation-first forex from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Forex Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
    ['slug' => 'forex-track', 'label' => 'Track Your Request'],
];
$forex_current = 'forex-foreign-currency';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Foreign Currency</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex">Forex Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Foreign Currency</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Currency Notes For Your Trip</span>
                    <h2 class="split-text-right split-text-in-right">Foreign Currency, Quoted Before You Commit</h2>
                </div>
                <p class="svc-lede">
                    Buy foreign currency notes in the currency and amount you need for your trip. We confirm the
                    applicable rate and charges in a quotation before you commit to anything, and handle the KYC
                    paperwork alongside it.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">Multi-Currency</span><span class="lbl">USD, EUR, GBP &amp; more</span></div>
                    <div><span class="num">Quotation-First</span><span class="lbl">Rate confirmed before you commit</span></div>
                    <div><span class="num">Tracked Status</span><span class="lbl">Same reference-based tracking as visas</span></div>
                    <div><span class="num">1:1</span><span class="lbl">Dedicated case handler</span></div>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Forex services">
            <div class="svc-sibling-inner">
                <?php foreach ($forex_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $forex_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How It Works</span>
                    <h2 class="split-text-right split-text-in-right">From Request To Collection</h2>
                </div>
                <p class="svc-lede">The same quotation-first, document-assisted process, tracked end to end.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us your requirement</h3><p>Currency, approximate amount and travel date &mdash; submitted via a quick enquiry, no paperwork yet.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a quotation</h3><p>We confirm the applicable rate and charges for the currency notes you need before you commit.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Submit KYC documents</h3><p>PAN, passport and travel proof as applicable &mdash; verified against the purpose code for your request.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Payment &amp; compliance check</h3><p>Once documents are verified and payment is received, your request moves to processing.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Collection or delivery</h3><p>Your currency notes are handed over or delivered, with a receipt for your records.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Documents You'll Need</span>
                    <h2 class="split-text-right split-text-in-right">Standard KYC For Currency Purchase</h2>
                </div>
                <p class="svc-lede">Exact requirements depend on the amount and purpose &mdash; this is the common baseline we'll confirm against your request.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">PAN card</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with valid visa or travel proof, where applicable</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Confirmed flight ticket or travel itinerary</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Purpose-of-travel declaration (FEMA Form A2)</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">A Rate You See Before You Pay</h2>
                </div>
                <p class="svc-lede">No surprises on the amount you receive &mdash; the rate is confirmed in writing before you commit.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Quotation before commitment</h4><p>You see the exact rate and charges before you pay anything.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Multiple currencies</h4><p>USD, EUR, GBP and other major travel currencies &mdash; tell us your destination and we'll confirm availability.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Same tracking as your visa</h4><p>Your currency request gets a reference number, trackable the same way as your visa application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Alongside your visa filing</h4><p>Handle your currency and your visa with the same caseworker and timeline.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Need Foreign Currency For Your Trip?</h2>
                    <p>Tell us your currency, amount and travel date &mdash; we'll confirm the rate and next steps.</p>
                    <div class="cta-buttons">
                        <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="forex-track" class="theme-btn style-2">Track Your Forex Request</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="currency-faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Foreign Currency, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Which currencies can I buy? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>USD, EUR, GBP and other major travel currencies &mdash; tell us your destination and we'll confirm availability for that currency.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How is the exchange rate decided? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Rates move with the market, so we confirm the applicable rate in a quotation before you commit &mdash; nothing is charged against a rate you haven't seen.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Is there a minimum or maximum amount? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This depends on the currency and purpose of travel under RBI/FEMA guidelines &mdash; we'll confirm the applicable limit for your specific request.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I track my currency request like a visa application?</div>
                                <div class="faq-answer"><p>Yes &mdash; every forex request gets a reference number you can look up anytime on our <a href="forex-track">Track Your Forex Request</a> page.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
