<?php
$page_title = "Business Visa Consultancy &ndash; Visa Agency";
$page_description = "Business visa guidance for meetings, conferences and trade &ndash; invitation letters, corporate documentation and appointment support. By Visa Agency, Patna.";
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
$visa_current = 'visa-business';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Business Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Business Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Meetings, Conferences &amp; Trade</span>
                    <h2 class="split-text-right split-text-in-right">Business Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Travelling abroad for meetings, conferences, negotiations or trade? We help you put together an
                    invitation-backed application that clearly demonstrates the business purpose of your trip.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">120+</span><span class="lbl">Destinations covered</span></div>
                    <div><span class="num">1&ndash;3 wks</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Solo / Corp.</span><span class="lbl">Individual &amp; corporate bookings</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Invitation To Boarding</h2>
                </div>
                <p class="svc-lede">Business visas hinge on clearly documenting the purpose of your trip &mdash; we help you build that case correctly.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Purpose &amp; eligibility check</h3><p>We confirm whether your trip qualifies as business travel and what supporting documents the destination expects.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Invitation &amp; company documentation</h3><p>We guide you and your host/employer on preparing an invitation letter and company documents that meet embassy standards.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your application is compiled and filed with the embassy, consulate or business-visa portal.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Appointment / interview support</h3><p>Where an in-person appointment is required, we help you prepare for questions about your business purpose.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, we hand over your visa along with any conditions attached, such as permitted activities or duration.</p></div>
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
                <p class="svc-lede">Business visas usually require more corporate documentation than tourist visas &mdash; here's the common baseline.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Invitation letter from the host company or event organiser</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Letter from your employer confirming purpose and sponsorship of travel</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Company registration and financial documents (for business owners)</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of sufficient funds for the trip</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Confirmed flight and accommodation details</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">We Know What Embassies Look For</h2>
                </div>
                <p class="svc-lede">A business visa application lives or dies on how clearly the purpose is documented.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Invitation letter guidance</h4><p>We advise your host or employer on exactly what an invitation letter needs to include to satisfy embassy requirements.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Corporate document review</h4><p>We check company registration, financials and letters for completeness before they go into your application.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Event &amp; conference support</h4><p>For trade shows and conferences, we help align your documents with the event's own visa-support letter, where offered.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Corporate booking support</h4><p>Companies sending multiple employees can coordinate applications through a single point of contact &mdash; see our <a href="other-services">Corporate Visa Assistance</a>.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Travelling For Business?</h2>
                    <p>Share your destination and the purpose of your trip &mdash; we'll confirm the documents and invitation requirements.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Business Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="business-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Business Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">What's the difference between a business visa and a work visa? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>A business visa covers short-term activities like meetings, negotiations and conferences. It does not permit taking up employment or being paid by a company in the destination country &mdash; that requires a work visa.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need an invitation letter? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most business visas require one, either from the company you're visiting or the event organiser. We'll advise on the exact format the destination expects.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can my company book visas for multiple employees at once? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Yes &mdash; we offer corporate visa assistance for businesses sending several employees, coordinated through a single case handler.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long can I stay on a business visa? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Duration and entry conditions vary by destination and are set by the issuing authority &mdash; we'll confirm the specific terms once your visa is granted.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
