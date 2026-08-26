<?php
$page_title = "Other Services &ndash; Visa Agency";
$page_description = "Travel insurance, forex assistance, flight & hotel reservation, airport assistance and corporate visa support from Visa Agency.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Other Services</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Other Services</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Beyond Visas</span>
                    <h2 class="split-text-right split-text-in-right">Travel &amp; Corporate Support</h2>
                </div>
                <div class="row g-4">
                    <?php
                    $other_services = [
                        ['id' => 'travel-insurance', 'icon' => 'fa-shield-alt', 'title' => 'Travel Insurance', 'desc' => 'Travel insurance assistance to meet embassy and personal safety requirements.'],
                        ['id' => 'forex-assistance', 'icon' => 'fa-money-bill-wave', 'title' => 'Forex Assistance', 'desc' => 'Guidance on foreign exchange for your trip.'],
                        ['id' => 'flight-hotel-assistance', 'icon' => 'fa-plane', 'title' => 'Flight &amp; Hotel Reservation', 'desc' => 'Confirmed itinerary and accommodation booking assistance for visa applications.'],
                        ['id' => 'invitation-letter', 'icon' => 'fa-envelope-open-text', 'title' => 'Invitation Letter Assistance', 'desc' => 'Support in preparing invitation letters where required.'],
                        ['id' => 'airport-assist', 'icon' => 'fa-plane-arrival', 'title' => 'Airport Meet &amp; Assist', 'desc' => 'Airport meet, assist and transfer support.'],
                        ['id' => 'corporate-visa', 'icon' => 'fa-building', 'title' => 'Corporate Visa Assistance', 'desc' => 'Business travel and employee travel documentation support for companies.'],
                    ];
                    foreach ($other_services as $s): ?>
                    <div class="col-lg-4 col-md-6">
                        <div class="how-it-works-step" id="<?php echo $s['id']; ?>" style="scroll-margin-top:110px;">
                            <div class="step-num"><i class="fa-solid <?php echo $s['icon']; ?>" style="font-size:16px;"></i></div>
                            <h4><?php echo $s['title']; ?></h4>
                            <p><?php echo $s['desc']; ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn">Enquire Now <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
