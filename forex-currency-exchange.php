<?php
$page_title = "Currency Exchange &ndash; Visa Agency";
$page_description = "Currency exchange for travel or business need, guided through FEMA purpose-code documentation, with limits confirmed against your specific request.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
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
                    <span class="sub-title-2 wow fadeInUp">Exchange For Your Specific Need</span>
                    <h2 class="split-text-right split-text-in-right">Currency Exchange, Documented Correctly</h2>
                </div>
                <p class="svc-lede">
                    Exchange currency for your specific travel or business need, guided through the documentation
                    FEMA purpose codes require &mdash; whether that's leftover currency from a trip, a business
                    remittance, or another declared purpose. Limits depend on the currency and declared purpose
                    under RBI/FEMA guidelines &mdash; we confirm the applicable limit for your specific request.
                </p>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">How It Works</span>
                    <h2 class="split-text-right split-text-in-right">From Request To Delivery</h2>
                </div>
                <p class="svc-lede">The same quotation-first, document-assisted process for every forex request, tracked end to end.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us your requirement</h3><p>Currency, approximate amount and travel date &mdash; submitted via a quick enquiry, no paperwork yet.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a quotation</h3><p>We confirm the applicable rate and charges before you commit.</p></div>
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
                        <div class="svc-step-body"><h3>Collection or delivery</h3><p>Your currency or forex card is handed over or delivered, with a receipt for your records.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section id="faq" class="section-padding fix">
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
                                <div class="faq-question">Is there a minimum or maximum amount? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This depends on the currency and purpose of travel under RBI/FEMA guidelines &mdash; we'll confirm the applicable limit for your specific request.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I exchange currency left over from a trip? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; leftover foreign currency can usually be exchanged back, subject to the applicable purpose-code documentation and any limits under RBI/FEMA guidelines.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Ready To Get A Forex Quotation?</h2>
                    <p>Tell us your currency, amount and travel date &mdash; we'll confirm the rate and next steps.</p>
                    <div class="cta-buttons">
                        <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="forex-track" class="theme-btn style-2">Track Your Forex Request</a>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
