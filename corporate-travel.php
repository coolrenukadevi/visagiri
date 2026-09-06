<?php
$page_title = "Corporate Travel &amp; Visa Support &ndash; Visa Agency";
$page_description = "Corporate travel and visa support for businesses sending employees abroad &ndash; group intake, company documentation and a single point of contact.";
include __DIR__ . '/includes/header.php';

$travel_siblings = [
    ['slug' => 'travel-services', 'label' => 'Overview'],
    ['slug' => 'travel-insurance', 'label' => 'Travel Insurance'],
    ['slug' => 'flight-hotel', 'label' => 'Flight &amp; Hotel'],
    ['slug' => 'invitation-letter', 'label' => 'Invitation Letters'],
    ['slug' => 'airport-assist', 'label' => 'Airport Assist'],
    ['slug' => 'corporate-travel', 'label' => 'Corporate Travel'],
];
$travel_current = 'corporate-travel';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Corporate Travel</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="travel-services">Travel Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Corporate Travel</li>
                    </ul>
                </div>
            </div>
        </section>

        <nav class="svc-sibling-nav" aria-label="Travel services">
            <div class="svc-sibling-inner">
                <?php foreach ($travel_siblings as $sib): ?>
                <a href="<?php echo $sib['slug']; ?>" class="<?php echo $sib['slug'] === $travel_current ? 'current' : ''; ?>"><?php echo $sib['label']; ?></a>
                <?php endforeach; ?>
            </div>
        </nav>

        <section class="section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">For Businesses Sending Employees Abroad</span>
                    <h2 class="split-text-right split-text-in-right">Corporate Travel &amp; Visa Support</h2>
                </div>
                <p class="svc-lede">
                    Sending one employee or an entire team abroad for business, training or a project? We
                    coordinate visa, travel insurance, flight and hotel bookings for the whole group through a
                    single point of contact, so HR or travel desks aren't chasing multiple vendors.
                </p>
                <div class="svc-steps">
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">1</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Group requirement gathering</h3><p>We collect destination, dates and traveller details for everyone in one intake, rather than separate individual enquiries.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">2</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Company documentation</h3><p>We advise on the company-level documents &mdash; registration, invitation letters, sponsorship &mdash; that support every traveller's application.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">3</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Coordinated filing</h3><p>Visa, insurance and travel bookings for the group are tracked together against one shared timeline.</p></div>
                    </div>
                    <div class="svc-step-row">
                        <div class="svc-step-marker"><div class="svc-step-num">4</div><div class="svc-step-line"></div></div>
                        <div class="svc-step-body"><h3>Single point of contact</h3><p>One caseworker reports status for the whole group, instead of your team following up individually.</p></div>
                    </div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
                    <div class="faq-item active">
                        <div class="faq-question">How does corporate travel support pricing work? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Each traveller's visa and travel costs are quoted individually, with a coordinated group timeline. Contact us with your group size and destination for a specific quote.</p></div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Start A Corporate Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
