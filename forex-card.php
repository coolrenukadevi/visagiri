<?php
$page_title = "Forex Card &ndash; Visa Agency Forex";
$page_description = "Load a prepaid travel forex card in your destination currency, a safer alternative to carrying cash. Document-assisted forex from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Forex Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
    ['slug' => 'forex-track', 'label' => 'Track Your Request'],
];
$forex_current = 'forex-card';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Forex Card</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex">Forex Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Forex Card</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">A Safer Way To Carry Travel Money</span>
                    <h2 class="split-text-right split-text-in-right">Prepaid Forex Card, Loaded And Ready</h2>
                </div>
                <p class="svc-lede">
                    A prepaid travel card loaded in your destination currency &mdash; a safer alternative to
                    carrying large amounts of cash, with the same quotation-first process as our other forex
                    services.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">Prepaid</span><span class="lbl">Loaded before you travel</span></div>
                    <div><span class="num">Multi-Currency</span><span class="lbl">Load in your destination currency</span></div>
                    <div><span class="num">Quotation-First</span><span class="lbl">Rate confirmed before you commit</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Request To A Loaded Card</h2>
                </div>
                <p class="svc-lede">The same quotation-first, document-assisted process, tracked end to end.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us your requirement</h3><p>Currency, approximate load amount and travel date &mdash; submitted via a quick enquiry, no paperwork yet.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a quotation</h3><p>We confirm the applicable rate and any card issuance charges before you commit.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Submit KYC documents</h3><p>PAN, passport and travel proof as applicable &mdash; verified against the purpose code for your request.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Payment &amp; compliance check</h3><p>Once documents are verified and payment is received, your card is issued and loaded.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Collection or delivery</h3><p>Your loaded card is handed over or delivered, with a receipt and top-up instructions for your trip.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Documents You'll Need</span>
                    <h2 class="split-text-right split-text-in-right">Standard KYC For A Forex Card</h2>
                </div>
                <p class="svc-lede">Exact requirements depend on the load amount and purpose &mdash; this is the common baseline we'll confirm against your request.</p>
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
                    <h2 class="split-text-right split-text-in-right">Load It, Lock The Rate, Travel</h2>
                </div>
                <p class="svc-lede">A card loaded before departure, with the rate fixed at loading time.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Safer than cash</h4><p>Avoid carrying large sums of physical currency through airports and abroad.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Quotation before commitment</h4><p>You see the loading rate and any charges before you pay anything.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Same tracking as your visa</h4><p>Your card request gets a reference number, trackable the same way as your visa application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Alongside your visa filing</h4><p>Handle your forex card and your visa with the same caseworker and timeline.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Want A Forex Card For Your Trip?</h2>
                    <p>Tell us your currency, approximate load amount and travel date &mdash; we'll confirm the rate and next steps.</p>
                    <div class="cta-buttons">
                        <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="forex-track" class="theme-btn style-2">Track Your Forex Request</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="forex-card-faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Forex Card, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">How is a forex card different from buying cash currency? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>A forex card is a prepaid card loaded in your destination currency, so you're not carrying physical notes. It can typically be reloaded, and lost/stolen cards can usually be blocked, unlike cash.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I reload the card while travelling? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Reload options depend on the card issuer &mdash; we'll confirm whether your card supports online reload before you travel.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What happens if the card is lost or stolen? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most forex cards can be blocked by calling the issuer's helpline. We'll share the relevant contact details when your card is issued.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I track my card request like a visa application?</div>
                                <div class="faq-answer"><p>Yes &mdash; every forex request gets a reference number you can look up anytime on our <a href="forex-track">Track Your Forex Request</a> page.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
