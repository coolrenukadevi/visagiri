<?php
$footerCategories = array_slice($megaCategories ?? [], 0, 5);
$footerCountries = array_slice($megaCountries ?? [], 0, 8);
?>    <footer class="site-footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-about">
                    <?= videshia_logo('sm', 'dark') ?>
                    <p><?= e(SITE_TAGLINE) ?>. Videshia routes every application through AI-driven checks and autonomous agents so travellers, students and enterprises move across borders without the paperwork drag.</p>
                    <div class="social-row" aria-label="Social links">
                        <a href="#" aria-label="LinkedIn"><svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M4.98 3.5a2.5 2.5 0 11-.02 5 2.5 2.5 0 01.02-5zM.5 8.98h9V23.5h-9zM8.5 8.98h8.6v2h.12c1.2-2.1 4.13-2.16 6.03-.5 1.9 1.65 2.02 4.9 2.02 6.62V23.5h-8V17.7c0-1.38-.02-3.16-1.93-3.16-1.93 0-2.22 1.5-2.22 3.06v5.9h-8z"/></svg></a>
                        <a href="#" aria-label="Twitter / X"><svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M18.9 2H22l-7.6 8.7L23.4 22h-7.1l-5.6-6.9L4.3 22H1.2l8.2-9.4L.9 2h7.3l5 6.3L18.9 2zm-1.2 18h1.9L7.4 4H5.4l12.3 16z"/></svg></a>
                        <a href="#" aria-label="Instagram"><svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.2c3.2 0 3.6 0 4.9.07 3.3.15 4.8 1.7 4.96 4.96.06 1.3.07 1.65.07 4.87 0 3.23 0 3.58-.07 4.87-.15 3.25-1.7 4.8-4.96 4.96-1.3.06-1.64.07-4.9.07-3.2 0-3.6 0-4.87-.07-3.28-.15-4.8-1.72-4.96-4.97-.06-1.3-.07-1.64-.07-4.87 0-3.22 0-3.57.07-4.87C2.32 3.97 3.86 2.4 7.13 2.27 8.4 2.2 8.8 2.2 12 2.2zm0 3.55a6.25 6.25 0 100 12.5 6.25 6.25 0 000-12.5zm0 10.3a4.05 4.05 0 110-8.1 4.05 4.05 0 010 8.1zm6.5-10.55a1.46 1.46 0 11-2.92 0 1.46 1.46 0 012.92 0z"/></svg></a>
                    </div>
                </div>

                <div class="footer-col">
                    <h4>Company</h4>
                    <ul>
                        <li><a href="<?= url('about.php') ?>">About Videshia</a></li>
                        <li><a href="<?= url('travel-services.php') ?>">Services</a></li>
                        <li><a href="<?= url('contact.php') ?>">Careers</a></li>
                        <li><a href="<?= url('contact.php') ?>">Partner with us</a></li>
                        <li><a href="<?= url('legal.php') ?>#privacy">Privacy Policy</a></li>
                        <li><a href="<?= url('legal.php') ?>#terms">Terms</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h4>Visa</h4>
                    <ul>
                        <li><a href="<?= url('visa/') ?>">Visa Services</a></li>
                        <li><a href="<?= url('visa/') ?>">Countries</a></li>
                        <?php foreach ($footerCategories as $cat): ?>
                        <li><a href="<?= url('visa/type/' . $cat['slug'] . '/') ?>"><?= e($cat['name']) ?></a></li>
                        <?php endforeach; ?>
                        <li><a href="<?= url('visa/') ?>#faqs">Visa FAQs</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h4>Travel &amp; Forex</h4>
                    <ul>
                        <li><a href="<?= url('travel-services.php') ?>#tours">Tours</a></li>
                        <li><a href="<?= url('travel-services.php') ?>#hotels">Hotels</a></li>
                        <li><a href="<?= url('travel-services.php') ?>#flights">Flights</a></li>
                        <li><a href="<?= url('travel-services.php') ?>#corporate">Corporate Travel</a></li>
                        <li><a href="<?= url('travel-services.php') ?>#forex">Forex</a></li>
                        <li><a href="<?= url('travel-services.php') ?>#insurance">Travel Insurance</a></li>
                    </ul>
                </div>

                <div class="footer-col">
                    <h4>Popular Countries</h4>
                    <ul>
                        <?php foreach ($footerCountries as $c): ?>
                        <li><a href="<?= url('visa/' . $c['slug'] . '/') ?>"><?= e($c['name']) ?> Visa</a></li>
                        <?php endforeach; ?>
                    </ul>
                </div>

                <div class="footer-col">
                    <h4>Get in touch</h4>
                    <ul>
                        <li><a href="mailto:info@tripgation.com">info@tripgation.com</a></li>
                        <li><a href="tel:+911140840000">+91 11 4084 0000</a></li>
                        <li><a href="https://wa.me/917844819819">WhatsApp us</a></li>
                        <li><a href="<?= url('contact.php') ?>">Contact form</a></li>
                        <li>Cyber Hub, Gurugram, India</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <span>&copy; 2015-<?= date('Y') ?>, Videshia - a unit of Tripgation. All rights reserved.</span>
                <div>
                    <a href="<?= url('legal.php') ?>#privacy">Privacy</a>
                    <a href="<?= url('legal.php') ?>#terms">Terms</a>
                    <a href="<?= url('legal.php') ?>#refund">Refund Policy</a>
                </div>
            </div>
        </div>
    </footer>

    <?php require __DIR__ . '/chat-widget.php'; ?>

    <script src="<?= asset('js/main.js') ?>"></script>
</body>
</html>
