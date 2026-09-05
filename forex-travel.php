<?php
$page_title = "Travel Forex Guidance &ndash; Visa Agency Forex";
$page_description = "Not sure which forex option fits your trip? Get guidance on currency, amount and format from Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$forex_siblings = [
    ['slug' => 'forex', 'label' => 'Forex Overview'],
    ['slug' => 'forex-foreign-currency', 'label' => 'Foreign Currency'],
    ['slug' => 'forex-card', 'label' => 'Forex Card'],
    ['slug' => 'forex-currency-exchange', 'label' => 'Currency Exchange'],
    ['slug' => 'forex-travel', 'label' => 'Travel Forex'],
    ['slug' => 'forex-track', 'label' => 'Track Your Request'],
];
$forex_current = 'forex-travel';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Travel Forex</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="forex">Forex Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Travel Forex</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Not Sure What You Need?</span>
                    <h2 class="split-text-right split-text-in-right">Travel Forex Guidance, Worked Out With You</h2>
                </div>
                <p class="svc-lede">
                    Unsure whether to carry cash, load a forex card, or split between the two? We work out the
                    currency, amount and format that fits your specific trip, then handle whichever option you
                    choose.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">Cash / Card / Mix</span><span class="lbl">Whichever fits your trip</span></div>
                    <div><span class="num">Destination-Aware</span><span class="lbl">Matched to where you're travelling</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From A Quick Chat To A Confirmed Plan</h2>
                </div>
                <p class="svc-lede">A short conversation to work out what actually suits your trip, then the same quotation-first process for whichever option you pick.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Tell us about your trip</h3><p>Destination, duration and how you'd like to pay for things &mdash; cash-heavy, card-friendly, or a mix.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a recommendation</h3><p>We suggest a currency-notes / forex-card split that fits your destination and spending style.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Get a quotation</h3><p>We confirm the applicable rate and charges for whichever option, or combination, you choose.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Submit KYC documents</h3><p>PAN, passport and travel proof as applicable &mdash; verified against the purpose code for your request.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Collection or delivery</h3><p>Your currency and/or card is handed over or delivered, with a receipt for your records.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Documents You'll Need</span>
                    <h2 class="split-text-right split-text-in-right">Standard KYC For Travel Forex</h2>
                </div>
                <p class="svc-lede">Exact requirements depend on the amount, format and purpose &mdash; this is the common baseline we'll confirm against your request.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">PAN card</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with valid visa or travel proof</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Confirmed flight ticket or travel itinerary</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Purpose-of-travel declaration (FEMA Form A2)</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">One Conversation, The Right Mix</h2>
                </div>
                <p class="svc-lede">Most travellers don't need just cash or just a card &mdash; we help you work out the right combination.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>No guesswork</h4><p>We talk through your itinerary and spending style before recommending an option.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Quotation before commitment</h4><p>Whichever option you choose, you see the rate and charges before you commit.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Same tracking as your visa</h4><p>Your forex request gets a reference number, trackable the same way as your visa application.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Alongside your visa filing</h4><p>Handle your forex and your visa with the same caseworker and timeline.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="final-cta">
                    <h2>Not Sure What Your Trip Needs?</h2>
                    <p>Tell us your destination and travel dates &mdash; we'll recommend a currency and format that fits.</p>
                    <div class="cta-buttons">
                        <a href="forex-enquiry" class="theme-btn">Start Your Forex Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="forex-track" class="theme-btn style-2">Track Your Forex Request</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="travel-forex-faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Travel Forex, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Should I carry cash or use a forex card? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>It depends on your destination and how you like to spend &mdash; many travellers carry a small amount of cash for immediate needs and load the rest on a forex card. We'll recommend a split based on your trip.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I combine currency notes and a forex card in one request? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; we can quote and process both together under a single enquiry, so you get one combined quotation and one point of contact.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">I've never bought forex before &mdash; where do I start? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Start with a quick enquiry describing your destination and travel dates. We'll talk you through the options and documents needed from there.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I track my request like a visa application?</div>
                                <div class="faq-answer"><p>Yes &mdash; every forex request gets a reference number you can look up anytime on our <a href="forex-track">Track Your Forex Request</a> page.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
