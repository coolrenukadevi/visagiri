<?php
$page_title = "Sports Visa Consultancy &ndash; Visa Agency";
$page_description = "Sports visa guidance for athletes, teams and officials &ndash; federation-backed applications and group booking coordination. By Visa Agency, Patna.";
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
$visa_current = 'visa-sports';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Sports Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-consultancy-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Sports Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Athletes, Teams &amp; Officials</span>
                    <h2 class="split-text-right split-text-in-right">Sports Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Travelling for a tournament, training camp or sporting event? We help athletes, coaches and
                    support staff put together federation-backed applications that hold up to embassy scrutiny.
                </p>
                <div class="svc-stat-strip">
                    <div><span class="num">70+</span><span class="lbl">Destinations covered</span></div>
                    <div><span class="num">1&ndash;4 wks</span><span class="lbl">Typical processing*</span></div>
                    <div><span class="num">Individual / Team</span><span class="lbl">Applications supported</span></div>
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
                    <h2 class="split-text-right split-text-in-right">From Federation Letter To Competition</h2>
                </div>
                <p class="svc-lede">Sports visas depend heavily on official backing from your sports body or the event organiser.</p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Event &amp; eligibility check</h3><p>We confirm the visa category for your event type &mdash; tournament, training camp, trial, or officiating assignment.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Federation &amp; organiser documentation</h3><p>We guide you and your sports federation or event organiser on preparing an invitation and participation letter that meets embassy standards.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Individual or team applications are compiled and filed together where the destination allows group processing.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Appointment support (if required)</h3><p>Where an in-person appointment is needed, we help you and your team prepare.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection</h3><p>Once issued, visas are handed over along with any conditions tied to the event dates.</p></div>
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
                <p class="svc-lede">Requirements are similar to a business visa, with sport-specific backing documents added.</p>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Invitation letter from the event organiser or host federation</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">No-objection or participation letter from your national sports federation</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of accommodation and travel dates tied to the event</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of sufficient funds for the trip</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Team list and role details, for group applications</span></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Why Visa Agency</span>
                    <h2 class="split-text-right split-text-in-right">Team Logistics, Handled Together</h2>
                </div>
                <p class="svc-lede">Group applications carry their own coordination challenges &mdash; we manage them as one process.</p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Federation liaison</h4><p>We work directly with your sports federation to ensure invitation and no-objection letters meet embassy format expectations.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Group application coordination</h4><p>For teams, we compile and track all applications together, so no single traveller's paperwork holds up the group.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Event-date alignment</h4><p>Visa validity is aligned to your actual competition or training dates, avoiding gaps or unnecessary short stays.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Equipment documentation guidance</h4><p>Where sporting equipment needs its own customs or carnet documentation, we point you to the right process alongside your visa.</p></div></div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="final-cta">
                    <h2>Heading Abroad For A Competition?</h2>
                    <p>Share your event, dates and team size &mdash; we'll confirm the visa category and documents needed.</p>
                    <div class="cta-buttons">
                        <a href="contact" class="theme-btn">Start Your Sports Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                        <a href="tel:+917844819819" class="theme-btn style-2">Talk to a Visa Expert</a>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ -->
        <section id="sports-faq" class="section-padding fix section-bg-1">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">FAQs</span>
                            <h2 class="split-text-right split-text-in-right">Sports Visa, Answered</h2>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <div class="faq-item active">
                                <div class="faq-question">Does this apply to individual athletes or only teams? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Both &mdash; we handle individual athlete applications as well as coordinated team applications for tournaments and training camps.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Do I need a letter from my sports federation? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Most sports visa categories require a no-objection or participation letter from your national or state sports federation, alongside the event invitation.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">How long is a sports visa valid for? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Validity is typically tied to your event or camp dates, plus a short buffer &mdash; we'll confirm the exact terms once your visa is issued.</p></div>
                            </div>
                            <div class="faq-item">
                                <div class="faq-question">Can coaching or support staff apply under the same category? <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p>Coaches, physiotherapists and other support staff often qualify under the same or a closely related category &mdash; we'll confirm the right one for each role on your team.</p></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
