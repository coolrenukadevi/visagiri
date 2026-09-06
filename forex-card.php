<?php
$page_title = "Forex Card &ndash; Visa Agency";
$page_description = "Prepaid travel forex card loaded in your destination currency &ndash; a safer alternative to carrying cash, quotation-first and reloadable.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
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
                    <span class="sub-title-2 wow fadeInUp">A Safer Way To Carry Travel Money</span>
                    <h2 class="split-text-right split-text-in-right">Prepaid Forex Card, Loaded And Ready</h2>
                </div>
                <p class="svc-lede">
                    A prepaid travel card loaded in your destination currency &mdash; a safer alternative to
                    carrying large amounts of cash, with the same quotation-first process as our other forex
                    services. Most forex cards can be blocked by calling the issuer's helpline if lost or stolen,
                    unlike cash.
                </p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Safer than cash</h4><p>Avoid carrying large sums of physical currency through airports and abroad.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Quotation before commitment</h4><p>You see the loading rate and any charges before you pay anything.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Reloadable</h4><p>Reload options depend on the card issuer &mdash; we confirm whether your card supports online reload before you travel.</p></div></div>
                </div>
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
                            <h2 class="split-text-right split-text-in-right">Forex Card, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">How is a forex card different from buying cash currency? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>A forex card is a prepaid card loaded in your destination currency, so you're not carrying physical notes. It can typically be reloaded, and lost/stolen cards can usually be blocked, unlike cash.</p></div>
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
