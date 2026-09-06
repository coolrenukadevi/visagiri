<?php
$page_title = "Flight &amp; Hotel Reservation Assistance &ndash; Visa Agency";
$page_description = "Flight and hotel reservation assistance for visa applications &ndash; application-ready itineraries, accommodation proof and refundable ticket options.";
include __DIR__ . '/includes/header.php';

$travel_siblings = [
    ['slug' => 'travel-services', 'label' => 'Overview'],
    ['slug' => 'travel-insurance', 'label' => 'Travel Insurance'],
    ['slug' => 'flight-hotel', 'label' => 'Flight &amp; Hotel'],
    ['slug' => 'invitation-letter', 'label' => 'Invitation Letters'],
    ['slug' => 'airport-assist', 'label' => 'Airport Assist'],
    ['slug' => 'corporate-travel', 'label' => 'Corporate Travel'],
];
$travel_current = 'flight-hotel';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Flight &amp; Hotel Assistance</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="travel-services">Travel Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Flight &amp; Hotel Assistance</li>
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
                    <span class="sub-title-2 wow fadeInUp">Confirmed Itinerary &amp; Accommodation</span>
                    <h2 class="split-text-right split-text-in-right">Flight &amp; Hotel Reservation Assistance</h2>
                </div>
                <p class="svc-lede">
                    Most visa applications need a confirmed or tentative flight itinerary and accommodation
                    proof. We help you put together bookings that satisfy your embassy's requirements &mdash;
                    including refundable or dummy-ticket options where a destination doesn't require a fully
                    paid ticket at application stage.
                </p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Application-ready itineraries</h4><p>We help you get a booking reference in the right format &mdash; matching passenger names and dates exactly to your visa application.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Accommodation proof</h4><p>Hotel booking confirmations or a host's invitation letter, whichever your destination and visa category requires.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Coordinated with your visa timeline</h4><p>Booking dates are checked against your intended visa validity and travel dates before you commit to anything non-refundable.</p></div></div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
                    <div class="faq-item active">
                        <div class="faq-question">Can I get a refundable or dummy flight ticket for my visa application? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Some destinations accept a reservation or hold without full payment; others expect a confirmed, paid ticket. We'll confirm which applies before you book anything.</p></div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask About Flight &amp; Hotel Booking <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
