<?php
$page_title = "Airport Meet &amp; Assist &ndash; Visa Agency";
$page_description = "Airport meet, assist and transfer support for first-time travellers, elderly passengers and medical travel.";
include __DIR__ . '/includes/header.php';

$travel_siblings = [
    ['slug' => 'travel-services', 'label' => 'Overview'],
    ['slug' => 'travel-insurance', 'label' => 'Travel Insurance'],
    ['slug' => 'flight-hotel', 'label' => 'Flight &amp; Hotel'],
    ['slug' => 'invitation-letter', 'label' => 'Invitation Letters'],
    ['slug' => 'airport-assist', 'label' => 'Airport Assist'],
    ['slug' => 'corporate-travel', 'label' => 'Corporate Travel'],
];
$travel_current = 'airport-assist';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Airport Meet &amp; Assist</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="travel-services">Travel Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Airport Meet &amp; Assist</li>
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
                    <span class="sub-title-2 wow fadeInUp">On The Ground, On Arrival</span>
                    <h2 class="split-text-right split-text-in-right">Airport Meet &amp; Assist</h2>
                </div>
                <p class="svc-lede">
                    First-time travellers, elderly passengers, or anyone travelling for medical treatment can
                    request meet, assist and transfer support at the airport &mdash; on departure from India or on
                    arrival, where the service is available.
                </p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>First-time traveller support</h4><p>Guidance on immigration, customs and transfer procedures for those unfamiliar with the process.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Medical &amp; elderly assistance</h4><p>Coordinated support for patients travelling for treatment or elderly family members travelling alone.</p></div></div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask About Airport Assistance <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
