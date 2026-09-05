<?php
$page_title = "Transit Visa Consultancy &ndash; Visa Agency";
$page_description = "Transit visa guidance for connecting flights and layovers &ndash; route and nationality checks, and fast turnaround filing. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';

$visa_siblings = [
    ['slug' => 'visa-tourist', 'label' => 'Tourist Visa'],
    ['slug' => 'visa-business', 'label' => 'Business Visa'],
    ['slug' => 'visa-work', 'label' => 'Work Visa'],
    ['slug' => 'visa-family', 'label' => 'Family Visa'],
    ['slug' => 'visa-transit', 'label' => 'Transit Visa'],
    ['slug' => 'visa-sports', 'label' => 'Sports Visa'],
    ['slug' => 'visa-medical', 'label' => 'Medical Visa'],
    ['slug' => 'visa-crew', 'label' => 'Crew Visa'],
    ['slug' => 'visa-extension', 'label' => 'Visa Extension'],
];
$visa_current = 'visa-transit';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Transit Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Transit Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Connecting Flights &amp; Layovers</span>
                    <h2 class="split-text-right split-text-in-right">Transit Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Connecting through a country on your way to your final destination? Some layovers require a
                    transit visa even if you never leave the airport &mdash; we help you confirm what's needed before you fly.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">80+</span><span class="lbl">Transit routes covered</span></div>
                    <div><span class="num">2&ndash;10 days</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Direct / Landside</span><span class="lbl">Transit types checked</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Layover Check To Boarding</h2>
                </div>
                <p class="svc-lede">Getting this wrong can mean being denied boarding at check-in &mdash; we confirm the requirement early.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Route &amp; nationality check</h3><p>We confirm whether your specific layover country requires a transit visa for your nationality and transit type.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Document collection</h3><p>We guide you through gathering your onward ticket, final-destination visa (if required) and other supporting documents.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your transit visa application is filed with the relevant embassy, consulate or online portal.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, we hand over your transit visa along with any conditions, such as maximum layover duration.</p></div>
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
                <p class="svc-lede">Requirements depend on whether you'll leave the airport during your layover, and your final destination.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Confirmed onward flight ticket showing your final destination</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Valid visa for your final destination, where required</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of layover duration and connecting flight times</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Photographs meeting the transit country's specific format</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">We Check Before You Book</h2>
                </div>
                <p class="svc-lede">Transit rules are easy to overlook and vary sharply by country and nationality.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Route-specific checks</h4><p>We verify transit visa requirements against your specific layover country, nationality and transit type &mdash; direct or landside.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Multi-leg itinerary support</h4><p>For journeys with more than one connecting flight, we check requirements for every leg, not just the final destination.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Fast turnaround</h4><p>Transit visas are often needed on a tighter timeline than other categories &mdash; we prioritise these applications accordingly.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Booked alongside your main visa</h4><p>If you're also applying for a tourist, business or work visa, we coordinate the transit visa as part of the same engagement.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Have A Layover Coming Up?</h2>
                    <p>Share your full itinerary and nationality &mdash; we'll confirm which legs, if any, need a transit visa.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Transit Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="transit-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Transit Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Do I need a transit visa if I'm not leaving the airport? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>It depends on the country. Some allow airside transit without a visa for eligible nationalities; others require one regardless. We'll confirm this for your specific layover country and nationality.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long can I stay on a transit visa? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>This varies by country, typically ranging from a few hours to a few days. We'll confirm the exact permitted duration once your visa is issued.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Does my nationality affect the transit visa requirement? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; transit visa exemptions are usually nationality-specific. We check this against your passport before advising you either way.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can I combine transit visa processing with my main visa application? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; if you're already applying for a visa to your final destination, we can process your transit visa as part of the same engagement.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
