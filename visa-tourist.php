<?php
$page_title = "Tourist Visa Consultancy &ndash; Visa Agency";
$page_description = "Tourist visa consultancy for leisure and sightseeing travel &ndash; eligibility, documents, application filing and appointment support across 150+ destinations.";
include __DIR__ . '/includes/header.php';

$visa_siblings = [
    ['slug' => 'visa-services', 'label' => 'Overview'],
    ['slug' => 'visa-tourist', 'label' => 'Tourist'],
    ['slug' => 'visa-business', 'label' => 'Business'],
    ['slug' => 'visa-work', 'label' => 'Work'],
    ['slug' => 'visa-family', 'label' => 'Family'],
    ['slug' => 'visa-transit', 'label' => 'Transit'],
    ['slug' => 'visa-medical', 'label' => 'Medical'],
    ['slug' => 'visa-sports', 'label' => 'Sports'],
    ['slug' => 'visa-crew', 'label' => 'Crew'],
    ['slug' => 'visa-extension', 'label' => 'Extension'],
];
$visa_current = 'visa-tourist';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Tourist Visa</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="visa-services">Visa Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Tourist Visa</li>
                    </ul>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Visa categories">
            <div class="svc-sibling-inner">
                <?php foreach ($visa_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $visa_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Leisure &amp; Sightseeing Travel</span>
                    <h2 class="split-text-right split-text-in-right">Tourist Visa Consultancy</h2>
                </div>
                <p class="svc-lede">
                    Planning a holiday abroad? We help you choose the right tourist visa category, prepare a
                    complete application, and avoid the common documentation gaps that cause delays.
                </p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Destination &amp; eligibility check</h3><p>We confirm your destination's tourist visa requirements, validity options and whether it's e-visa, visa-on-arrival, or requires an embassy application.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Document collection</h3><p>We guide you through gathering passport, photographs, financial and itinerary documents specific to your destination.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Application filing</h3><p>Your application is prepared and filed with the embassy, consulate or online visa portal, as applicable.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Appointment / biometrics (if required)</h3><p>For destinations that require it, we assist with booking and preparing for your visa appointment or biometric submission.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">5</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Visa collection &amp; travel-ready documents</h3><p>Once issued, we hand over your visa along with a checklist of documents to carry while travelling.</p></div>
                    </div>
                </div>
                <h3 style="margin:32px 0 14px; font-size:18px;">Documents you'll typically need</h3>
                <div class="svc-checklist">
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Passport with at least 6 months' validity and blank pages</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Recent passport-size photographs (destination-specific format)</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Bank statements or financial proof of sufficient funds</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Confirmed or tentative travel itinerary</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Hotel booking or accommodation proof</span></div>
                    <div class="svc-checklist-item"><div class="tick"><svg viewBox="0 0 24 24"><path d="M4 12l5 5L20 6"/></svg></div><span class="txt">Proof of employment or business, and leave sanction if applicable</span></div>
                </div>
                <div class="svc-why-grid" style="margin-top:32px;">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Destination-specific checklists</h4><p>We don't use a one-size-fits-all list &mdash; your document checklist is built around your actual destination's requirements.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Application review before filing</h4><p>We check your application and documents for gaps before submission, not after a rejection.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>E-visa &amp; VOA guidance</h4><p>For destinations offering e-visa or visa-on-arrival, we advise on the simpler route where it's genuinely faster.</p></div></div>
                    <div class="svc-why-item"><div class="check">04</div><div><h4>Support through to travel</h4><p>We remain available for questions on travel insurance, forex and other pre-departure needs.</p></div></div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
                    <div class="faq-item active">
                        <div class="faq-question">How far in advance should I apply? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>We recommend starting at least 4&ndash;6 weeks before your planned travel date, longer for destinations with embassy interviews or high seasonal demand.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">Can children travel on their own tourist visa? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Most countries require a visa application for each traveller, including children, with additional documents such as birth certificates and parental consent letters where applicable.</p></div>
                    </div>
                    <div class="faq-item">
                        <div class="faq-question">Can a tourist visa be extended? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Extension rules vary by country and are decided by the destination's immigration authority. See our <a href="visa-extension">Visa Extension</a> page for how we can help if this applies to you.</p></div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Start Your Tourist Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
