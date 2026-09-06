<?php
$page_title = "Invitation Letter Assistance &ndash; Visa Agency";
$page_description = "Invitation letter assistance for business, family and tourist visas &ndash; format guidance for hosts and consistency checks before filing.";
include __DIR__ . '/includes/header.php';

$travel_siblings = [
    ['slug' => 'travel-services', 'label' => 'Overview'],
    ['slug' => 'travel-insurance', 'label' => 'Travel Insurance'],
    ['slug' => 'flight-hotel', 'label' => 'Flight &amp; Hotel'],
    ['slug' => 'invitation-letter', 'label' => 'Invitation Letters'],
    ['slug' => 'airport-assist', 'label' => 'Airport Assist'],
    ['slug' => 'corporate-travel', 'label' => 'Corporate Travel'],
];
$travel_current = 'invitation-letter';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Invitation Letters</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="travel-services">Travel Services</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Invitation Letters</li>
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
                    <span class="sub-title-2 wow fadeInUp">Where A Host Or Company Is Inviting You</span>
                    <h2 class="split-text-right split-text-in-right">Invitation Letter Assistance</h2>
                </div>
                <p class="svc-lede">
                    Business, family and some tourist visas rely on an invitation letter from a host, employer or
                    company abroad. We advise the person or organisation inviting you on the format and content
                    embassies expect, so the letter holds up under scrutiny.
                </p>
                <div class="svc-why-grid">
                    <div class="svc-why-item"><div class="check">01</div><div><h4>Format guidance for your host</h4><p>We tell your host or inviting company exactly what details and supporting documents the letter needs to include.</p></div></div>
                    <div class="svc-why-item"><div class="check">02</div><div><h4>Consistency check</h4><p>We check the invitation letter's dates, purpose and details match the rest of your application before filing.</p></div></div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask About Invitation Letters <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
