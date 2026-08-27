<?php
require_once __DIR__ . '/site-contact.php';
?>

        <footer class="footer-section footer-pro fix">
            <div class="container">
<?php include __DIR__ . '/footer-cta.php'; ?>
                <div class="footer-wrapper">
<?php include __DIR__ . '/footer-columns.php'; ?>
                </div>
            </div>
            <div class="footer-bottom-bar">
                <div class="container">
                    <div class="footer-legal-inline">
<?php include __DIR__ . '/footer-legal.php'; ?>
                    </div>
                </div>
            </div>
        </footer>

        <?php
        $qeWhatsappMsg = rawurlencode('Hello VisaGiri, I would like assistance with a travel/visa-related enquiry.');
        ?>
        <div class="qhelp-fab" id="qhelpFab">
            <div class="qhelp-panel" id="qhelpPanel" role="menu" aria-hidden="true">
                <button type="button" class="qhelp-option qhelp-option-primary" data-open-quick-enquiry role="menuitem">
                    <span class="qhelp-option-icon"><i class="fa-solid fa-headset" aria-hidden="true"></i></span>
                    <span class="qhelp-option-text"><strong>Get Assistance</strong><span>Start a quick enquiry</span></span>
                </button>
                <a href="<?php echo $site_whatsapp_url; ?>?text=<?php echo $qeWhatsappMsg; ?>" target="_blank" rel="noopener" class="qhelp-option" role="menuitem" data-track-click="whatsapp_click">
                    <span class="qhelp-option-icon qhelp-icon-whatsapp"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></span>
                    <span class="qhelp-option-text"><strong>WhatsApp Us</strong><span><?php echo $site_phone_display; ?></span></span>
                </a>
                <a href="tel:<?php echo $site_phone_e164; ?>" class="qhelp-option" role="menuitem" data-track-click="call_click">
                    <span class="qhelp-option-icon qhelp-icon-call"><i class="fa-solid fa-phone" aria-hidden="true"></i></span>
                    <span class="qhelp-option-text"><strong>Call Us</strong><span><?php echo $site_phone_display; ?></span></span>
                </a>
                <a href="mailto:info@tripgation.com" class="qhelp-option" role="menuitem" data-track-click="email_click">
                    <span class="qhelp-option-icon qhelp-icon-email"><i class="fa-solid fa-envelope" aria-hidden="true"></i></span>
                    <span class="qhelp-option-text"><strong>Email Us</strong><span>info@tripgation.com</span></span>
                </a>
            </div>
            <button type="button" class="qhelp-toggle" id="qhelpToggle" aria-expanded="false" aria-controls="qhelpPanel">
                <span class="qhelp-toggle-icon"><i class="fa-solid fa-comment-dots qhelp-icon-open" aria-hidden="true"></i><i class="fa-solid fa-xmark qhelp-icon-close" aria-hidden="true"></i></span>
                <span class="qhelp-toggle-label">Need Help?</span>
            </button>
        </div>

        <button type="button" class="back-to-top" id="backToTop" aria-label="Back to top">
            <i class="fa-solid fa-arrow-up"></i>
        </button>

        <?php include __DIR__ . '/enquiry-modal.php'; ?>
        <?php include __DIR__ . '/quick-enquiry-modal.php'; ?>

        <div class="mobile-sticky-cta">
            <a href="tel:<?php echo $site_phone_e164; ?>" data-track-click="call_click"><i class="fa-solid fa-phone"></i> Call</a>
            <a href="<?php echo $site_whatsapp_url; ?>?text=<?php echo $qeWhatsappMsg; ?>" target="_blank" rel="noopener" data-track-click="whatsapp_click"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
            <a href="contact" data-open-quick-enquiry><i class="fa-solid fa-paper-plane"></i> Get Assistance</a>
        </div>


        <!--<< All JS Plugins >>-->
        <script src="assets/js/jquery-3.7.1.min.js"></script>
        <!--<< Viewport Js >>-->
        <script src="assets/js/viewport.jquery.js"></script>
        <!--<< Bootstrap Js >>-->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!--<< nice-selec Js >>-->
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <!--<< Waypoints Js >>-->
        <script src="assets/js/jquery.waypoints.js"></script>
         <!--<< Odometer Js >>-->
        <script src="assets/js/odometer.min.js"></script>
        <!--<< Swiper Slider Js >>-->
        <script src="assets/js/swiper-bundle.min.js"></script>
        <!--<< MeanMenu Js >>-->
        <script src="assets/js/jquery.meanmenu.min.js"></script>
        <!--<< Magnific Popup Js >>-->
        <script src="assets/js/jquery.magnific-popup.min.js"></script>
        <!--<< Wow Animation Js >>-->
        <script src="assets/js/wow.min.js"></script>
         <!--<< circle-progress Js >>-->
        <script src="assets/js/circle-progress.js"></script>
        <!--<< Wow gsap Js >>-->
        <script src="assets/js/gsap.js"></script>
         <!--<< Wow lenis.min. Js >>-->
         <script src="assets/js/lenis.min.js"></script>
         <!--<< Wow ScrollTrigger.min. Js >>-->
         <script src="assets/js/ScrollTrigger.min.js"></script>
         <!--<< Wow SplitText.min. Js >>-->
         <script src="assets/js/SplitText.min.js"></script>
        <!--<< Main.js >>-->
        <script src="assets/js/main.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/enquiry-modal.js"></script>
        <script src="assets/js/quick-enquiry-modal.js"></script>
    </body>
</html>
