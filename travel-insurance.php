<?php
$page_title = "Travel Insurance Assistance &ndash; Visa Agency";
$page_description = "Travel insurance assistance for visa applications &ndash; destination-specific cover checks, filed alongside your application before submission.";
include __DIR__ . '/includes/header.php';

$travel_siblings = [
    ['slug' => 'travel-services', 'label' => 'Overview'],
    ['slug' => 'travel-insurance', 'label' => 'Travel Insurance'],
    ['slug' => 'flight-hotel', 'label' => 'Flight &amp; Hotel'],
    ['slug' => 'invitation-letter', 'label' => 'Invitation Letters'],
    ['slug' => 'airport-assist', 'label' => 'Airport Assist'],
    ['slug' => 'corporate-travel', 'label' => 'Corporate Travel'],
];
$travel_current = 'travel-insurance';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Travel Insurance</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="travel-services">Travel Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Travel Insurance</li>
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
                    <span class="sub-title-2 wow fadeInUp">Embassy &amp; Personal Safety Requirements</span>
                    <h2 class="split-text-right split-text-in-right">Travel Insurance Assistance</h2>
                </div>
                <p class="svc-lede">
                    Many visa applications, particularly for Schengen and similar destinations, require proof of
                    valid travel insurance before the application can even be filed. We help you understand what
                    cover your destination requires and get the right policy in place before you submit.
                </p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Destination-specific cover check</h4><p>Minimum sum insured, medical cover and validity requirements differ by destination &mdash; we confirm what your embassy actually needs.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Filed alongside your visa</h4><p>Your insurance certificate is checked against your application dates and destination before submission, not after.</p></div></div>
                    <div class="svc-why-item"><div class="check">03</div><div><h4>Group &amp; family cover</h4><p>Travelling as a family or group? We help coordinate a single policy or matching individual policies as needed.</p></div></div>
                </div>
                <div class="faq-accordion" style="margin-top:32px;">
                    <div class="faq-item active">
                        <div class="faq-question">Do I need travel insurance for every destination? <i class="fa-solid fa-plus"></i></div>
                        <div class="faq-answer"><p>Some destinations, notably Schengen countries, make it mandatory for the visa application. Others don't require it for the visa itself, though we generally recommend it. We'll confirm what applies to your destination.</p></div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask About Travel Insurance <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
