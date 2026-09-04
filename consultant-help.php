<?php
$page_title = "Consultant Help &ndash; Talk To A Visa Agency Expert | Visa Agency";
$page_description = "Reach a Visa Agency consultant directly &mdash; WhatsApp, call, email or submit an enquiry &mdash; for help with your specific visa application.";
$page_canonical = 'https://visaagency.in/consultant-help';
include __DIR__ . '/includes/header.php';
$chWhatsappMsg = rawurlencode('Hello VisaAgency.in, I would like help from a consultant with my visa application.');
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Consultant Help</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Consultant Help</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Help</span>
                    <h2 class="split-text-right split-text-in-right">Talk To A Consultant, Your Way</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    Guides and tools cover the general case &mdash; for anything specific to your situation, a
                    consultant can look at your actual documents and destination. Reach us however's easiest.
                </p>

                <div class="console-card-grid">
                    <a href="<?php echo htmlspecialchars($site_whatsapp_url); ?>?text=<?php echo $chWhatsappMsg; ?>" target="_blank" rel="noopener" class="console-tcard" style="text-decoration:none;">
                        <div class="icon"><i class="fa-brands fa-whatsapp"></i></div>
                        <h3>WhatsApp Us</h3>
                        <p><?php echo htmlspecialchars($site_phone_display); ?> &mdash; usually the fastest way to reach a consultant during business hours.</p>
                    </a>
                    <a href="tel:<?php echo htmlspecialchars($site_phone_e164); ?>" class="console-tcard" style="text-decoration:none;">
                        <div class="icon"><i class="fa-solid fa-phone"></i></div>
                        <h3>Call Us</h3>
                        <p><?php echo htmlspecialchars($site_phone_display); ?> &mdash; speak directly with a consultant about your application.</p>
                    </a>
                    <a href="mailto:info@tripgation.com" class="console-tcard" style="text-decoration:none;">
                        <div class="icon"><i class="fa-solid fa-envelope"></i></div>
                        <h3>Email Us</h3>
                        <p>info@tripgation.com &mdash; good for sharing documents or a detailed question in writing.</p>
                    </a>
                    <a href="contact" class="console-tcard" style="text-decoration:none;">
                        <div class="icon"><i class="fa-solid fa-paper-plane"></i></div>
                        <h3>Submit An Enquiry</h3>
                        <p>Fill in a short form and a consultant will get back to you with next steps for your destination.</p>
                    </a>
                </div>

                <div class="text-center mt-5">
                    <a href="visa-appointment" class="theme-btn style-2">Book A Consultation</a>
                    <a href="contact" class="theme-btn" data-open-enquiry>Start Your Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Consultant Help',
    'url' => $page_canonical,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => 'https://visaagency.in/resources'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Consultant Help', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
