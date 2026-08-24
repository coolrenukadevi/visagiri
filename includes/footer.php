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

        <div class="floating-fab" id="floatingFab">
            <div class="floating-fab-options" role="menu" aria-hidden="true">
                <a href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener" class="floating-fab-option" role="menuitem">
                    <span class="floating-fab-label">WhatsApp Me</span>
                    <span class="floating-fab-icon fab-icon-whatsapp"><i class="fa-brands fa-whatsapp"></i></span>
                </a>
                <a href="mailto:<?php echo $site_email; ?>" class="floating-fab-option" role="menuitem">
                    <span class="floating-fab-label">Email Me</span>
                    <span class="floating-fab-icon fab-icon-email"><i class="fa-solid fa-envelope"></i></span>
                </a>
                <a href="contact" class="floating-fab-option" role="menuitem">
                    <span class="floating-fab-label">Fill Enquiry Form</span>
                    <span class="floating-fab-icon fab-icon-form"><i class="fa-solid fa-file-pen"></i></span>
                </a>
            </div>
            <button type="button" class="floating-fab-toggle" id="floatingFabToggle" aria-expanded="false" aria-label="Contact us">
                <i class="fa-solid fa-comment-dots floating-fab-icon-open"></i>
                <i class="fa-solid fa-xmark floating-fab-icon-close"></i>
            </button>
        </div>

        <button type="button" class="back-to-top" id="backToTop" aria-label="Back to top">
            <i class="fa-solid fa-arrow-up"></i>
        </button>

        <?php include __DIR__ . '/enquiry-modal.php'; ?>

        <div class="mobile-sticky-cta">
            <a href="tel:<?php echo $site_phone_e164; ?>"><i class="fa-solid fa-phone"></i> Call</a>
            <a href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
            <a href="contact"><i class="fa-solid fa-paper-plane"></i> Enquire</a>
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
    </body>
</html>
