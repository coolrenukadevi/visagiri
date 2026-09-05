<?php
$page_title = "Currency Exchange &ndash; Visa Agency Forex";
$page_description = "Exchange currency for your specific travel or business need, guided through FEMA purpose-code documentation. Forex assistance from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Forex Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
    ['slug' => 'forex-track', 'label' => 'Track Your Request'],
];
$forex_current = 'forex-currency-exchange';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Currency Exchange</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex">Forex Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Currency Exchange</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Exchange For Your Specific Need</span>
                    <h2 class="split-text-right split-text-in-right">Currency Exchange, Documented Correctly</h2>
                </div>
                <p class="svc-lede">
                    Exchange currency for your specific travel or business need, guided through the documentation
                    FEMA purpose codes require &mdash; whether that's leftover currency from a trip, a business
                    remittance, or another declared purpose.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">Purpose-Coded</span><span class="lbl">FEMA-compliant documentation</span></div>
                    <div><span class="num">Multi-Currency</span><span class="lbl">Major travel &amp; business currencies</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Request To Settlement</h2>
                </div>
                <p class="svc-lede">The same quotation-first, document-assisted process, tracked end to end.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us your requirement</h3><p>Currency, amount and purpose of exchange &mdash; submitted via a quick enquiry, no paperwork yet.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a quotation</h3><p>We confirm the applicable exchange rate and charges before you commit.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Submit KYC &amp; purpose documents</h3><p>PAN and the relevant FEMA purpose-code declaration are verified against your stated reason for exchange.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Compliance check</h3><p>Once documents are verified, your exchange is processed against the confirmed rate.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Settlement</h3><p>Funds are handed over or credited as agreed, with a receipt for your records.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Documents You'll Need</span>
                    <h2 class="split-text-right split-text-in-right">Standard KYC For Currency Exchange</h2>
                </div>
                <p class="svc-lede">Exact requirements depend on the amount and purpose &mdash; this is the common baseline we'll confirm against your request.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">PAN card</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport, where the purpose relates to travel</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Purpose-of-exchange declaration (FEMA Form A2)</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Supporting documents for the declared purpose (e.g. return travel proof for leftover currency)</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Documented The Way FEMA Expects</h2>
                </div>
                <p class="svc-lede">Currency exchange is only as smooth as its paperwork &mdash; we get the purpose code and documentation right.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Purpose-code guidance</h4><p>We help you identify and document the correct FEMA purpose code for your exchange.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Quotation before commitment</h4><p>You see the exchange rate and charges before you commit to anything.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Same tracking as your visa</h4><p>Your exchange request gets a reference number, trackable the same way as your visa application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Alongside your visa filing</h4><p>Handle your currency exchange and your visa with the same caseworker and timeline.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Need To Exchange Currency?</h2>
                    <p>Tell us the currency, amount and purpose &mdash; we'll confirm the rate and documentation required.</p>
                    <div class="cta-buttons">
                        <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="forex-track" class="theme-btn style-2">Track Your Forex Request</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="currency-exchange-faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Currency Exchange, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Can I exchange currency left over from a trip? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; leftover foreign currency can usually be exchanged back, subject to the applicable purpose-code documentation and any limits under RBI/FEMA guidelines.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">What is a FEMA purpose code, and why does it matter? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>It's the declared reason for a foreign-exchange transaction, required under RBI/FEMA regulations. We help you identify and document the correct code for your specific exchange.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Is there a limit on how much I can exchange? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Limits depend on the currency and declared purpose under RBI/FEMA guidelines &mdash; we'll confirm the applicable limit for your specific request.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I track my exchange request like a visa application?</div>
                                <div class="faq-answer"><p>Yes &mdash; every forex request gets a reference number you can look up anytime on our <a href="forex-track">Track Your Forex Request</a> page.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
