<?php
$footerCountrySlugs = ['usa', 'uk', 'canada', 'australia', 'new-zealand', 'france', 'germany', 'italy', 'spain', 'switzerland', 'netherlands', 'singapore', 'malaysia', 'thailand', 'uae', 'saudi-arabia', 'japan', 'china', 'south-korea', 'brazil', 'south-africa', 'egypt'];
$countryNameBySlug = array_column($megaCountries ?? [], 'name', 'slug');
$footerCategories = $megaCategories ?? [];
$visaInfoTopics = $visaInfoTopics ?? ['visa-requirements' => 'Visa Requirements', 'visa-documents' => 'Visa Documents', 'visa-checklist' => 'Visa Checklist', 'visa-fees' => 'Visa Fees', 'processing-time' => 'Processing Time', 'visa-appointment' => 'Visa Appointment', 'visa-faqs' => 'Visa FAQs'];
?>    <footer class="site-footer">

        <div class="footer-cta">
            <div class="container">
                <div class="cta-band">
                    <div>
                        <h2>Need Help With Your Visa Application?</h2>
                        <p>Get professional guidance on visa requirements, documentation and application support.</p>
                    </div>
                    <div class="cta-actions">
                        <a href="<?= url('enquiry/') ?>" class="btn btn-light btn-lg">Start Visa Enquiry</a>
                        <a href="<?= url('contact/') ?>" class="btn btn-outline-light btn-lg">Talk to a Consultant</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="footer-grid-top">
                <div class="footer-about">
                    <?= videshia_logo('sm', 'dark') ?>
                    <p>Videshia is a professional visa consultancy and travel documentation assistance platform providing visa support, documentation guidance and application assistance for travellers.</p>
                    <div class="footer-contact-mini">
                        <span style="font-weight:600;color:#fff">24&times;7 Support</span>
                        <a href="https://wa.me/917844819819" target="_blank" rel="noopener"><svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 00-8.6 15L2 22l5.2-1.4A10 10 0 1012 2zm5.8 14.3c-.3.7-1.4 1.3-2 1.4-.5.1-1.2.1-1.9-.1-.4-.1-1-.3-1.7-.6-3-1.3-4.9-4.3-5.1-4.5-.1-.2-1.2-1.6-1.2-3.1s.8-2.2 1.1-2.5c.3-.3.6-.4.8-.4h.6c.2 0 .4 0 .6.5.2.5.8 1.9.8 2 .1.2.1.3 0 .5-.1.2-.1.3-.3.5l-.4.5c-.1.2-.3.3-.1.6.2.3.9 1.4 1.9 2.3 1.3 1.1 2.3 1.5 2.7 1.7.3.1.5.1.6-.1.2-.2.7-.8.9-1.1.2-.3.4-.2.6-.1l1.8.9c.2.1.4.2.4.3.1.3.1.9-.2 1.5z"/></svg> WhatsApp: +91 78448 19819</a>
                        <a href="tel:+917844819819"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3.1 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3.1-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 2.9a2 2 0 01-.5 2.1L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012.1-.5c.9.3 1.9.5 2.9.6a2 2 0 011.7 2z"/></svg> Phone: +91 78448 19819</a>
                        <a href="mailto:info@tripgation.com"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16v16H4z"/><path d="M22 6l-10 7L2 6"/></svg> info@tripgation.com</a>
                    </div>
                    <a href="<?= url('enquiry/') ?>" class="btn btn-primary">Start Your Visa Enquiry</a>
                    <div class="social-row" aria-label="Social links" style="margin-top:22px">
                        <a href="#" target="_blank" rel="noopener noreferrer" aria-label="Facebook"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M22 12a10 10 0 10-11.6 9.9v-7H7.9V12h2.5V9.8c0-2.5 1.5-3.9 3.8-3.9 1.1 0 2.2.2 2.2.2v2.5h-1.3c-1.2 0-1.6.8-1.6 1.6V12h2.8l-.4 2.9h-2.4v7A10 10 0 0022 12z"/></svg></a>
                        <a href="#" target="_blank" rel="noopener noreferrer" aria-label="Instagram"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.2c3.2 0 3.6 0 4.9.07 3.3.15 4.8 1.7 4.96 4.96.06 1.3.07 1.65.07 4.87 0 3.23 0 3.58-.07 4.87-.15 3.25-1.7 4.8-4.96 4.96-1.3.06-1.64.07-4.9.07-3.2 0-3.6 0-4.87-.07-3.28-.15-4.8-1.72-4.96-4.97-.06-1.3-.07-1.64-.07-4.87 0-3.22 0-3.57.07-4.87C2.32 3.97 3.86 2.4 7.13 2.27 8.4 2.2 8.8 2.2 12 2.2zm0 3.55a6.25 6.25 0 100 12.5 6.25 6.25 0 000-12.5zm0 10.3a4.05 4.05 0 110-8.1 4.05 4.05 0 010 8.1zm6.5-10.55a1.46 1.46 0 11-2.92 0 1.46 1.46 0 012.92 0z"/></svg></a>
                        <a href="#" target="_blank" rel="noopener noreferrer" aria-label="LinkedIn"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M4.98 3.5a2.5 2.5 0 11-.02 5 2.5 2.5 0 01.02-5zM.5 8.98h9V23.5h-9zM8.5 8.98h8.6v2h.12c1.2-2.1 4.13-2.16 6.03-.5 1.9 1.65 2.02 4.9 2.02 6.62V23.5h-8V17.7c0-1.38-.02-3.16-1.93-3.16-1.93 0-2.22 1.5-2.22 3.06v5.9h-8z"/></svg></a>
                        <a href="#" target="_blank" rel="noopener noreferrer" aria-label="YouTube"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M23 12s0-3.5-.45-5.2a3 3 0 00-2.1-2.1C18.7 4.2 12 4.2 12 4.2s-6.7 0-8.45.5a3 3 0 00-2.1 2.1C1 8.5 1 12 1 12s0 3.5.45 5.2a3 3 0 002.1 2.1c1.75.5 8.45.5 8.45.5s6.7 0 8.45-.5a3 3 0 002.1-2.1C23 15.5 23 12 23 12zM9.8 15.5v-7l6 3.5z"/></svg></a>
                        <a href="#" target="_blank" rel="noopener noreferrer" aria-label="X / Twitter"><svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M18.9 2H22l-7.6 8.7L23.4 22h-7.1l-5.6-6.9L4.3 22H1.2l8.2-9.4L.9 2h7.3l5 6.3L18.9 2zm-1.2 18h1.9L7.4 4H5.4l12.3 16z"/></svg></a>
                    </div>
                </div>

                <details class="footer-col footer-col-accordion" open>
                    <summary>Visa Services</summary>
                    <ul>
                        <?php foreach ($footerCategories as $cat): ?>
                        <li><a href="<?= url('visa-services/' . $cat['slug'] . '/') ?>"><?= e($cat['name']) ?></a></li>
                        <?php endforeach; ?>
                        <li><a href="<?= url('visa-services/') ?>#support-services">Visa Extension</a></li>
                        <li><a href="<?= url('visa-services/') ?>#support-services">Visa Renewal</a></li>
                        <li><a href="<?= url('visa-services/') ?>#support-services">Visa Documentation</a></li>
                        <li><a href="<?= url('visa-services/') ?>#support-services">Visa Application Support</a></li>
                    </ul>
                </details>

                <details class="footer-col footer-col-accordion" open>
                    <summary>Visa by Country</summary>
                    <ul class="two-col">
                        <?php foreach ($footerCountrySlugs as $slug): if (!isset($countryNameBySlug[$slug])) continue; ?>
                        <li><a href="<?= url('visa-by-country/' . $slug . '/') ?>"><?= e($countryNameBySlug[$slug]) ?> Visa</a></li>
                        <?php endforeach; ?>
                    </ul>
                    <a class="footer-view-all" href="<?= url('visa-by-country/') ?>">View All Countries &rarr;</a>
                </details>
            </div>

            <div class="footer-grid-bottom">
                <details class="footer-col footer-col-accordion" open>
                    <summary>Visa Information</summary>
                    <ul>
                        <?php foreach ($visaInfoTopics as $slug => $label): ?>
                        <li><a href="<?= url('visa-information/' . $slug . '/') ?>"><?= e($label) ?></a></li>
                        <?php endforeach; ?>
                        <li><a href="<?= url('track-application/') ?>">Visa Tracking</a></li>
                    </ul>
                </details>

                <details class="footer-col footer-col-accordion" open>
                    <summary>Company</summary>
                    <ul>
                        <li><a href="<?= url('about-us/') ?>">About Us</a></li>
                        <li><a href="<?= url('leadership/') ?>">Leadership</a></li>
                        <li><a href="<?= url('why-choose-us/') ?>">Why Choose Us?</a></li>
                        <li><a href="<?= url('careers/') ?>">Career</a></li>
                        <li><a href="<?= url('partners/') ?>">Partners</a></li>
                        <li><a href="<?= url('support-24x7/') ?>">Support 24&times;7</a></li>
                        <li><a href="<?= url('contact/') ?>">Contact</a></li>
                    </ul>
                </details>

                <details class="footer-col footer-col-accordion" open>
                    <summary>Resources</summary>
                    <ul>
                        <li><a href="<?= url('blog/') ?>">Visa Blog</a></li>
                        <li><a href="<?= url('blog/') ?>#news">Visa News</a></li>
                        <li><a href="<?= url('blog/') ?>#guides">Travel Guides</a></li>
                        <li><a href="<?= url('blog/') ?>#tips">Visa Tips</a></li>
                        <li><a href="<?= url('visa-information/visa-faqs/') ?>">Visa FAQs</a></li>
                        <li><a href="<?= url('visa-by-country/') ?>">Country Guides</a></li>
                        <li><a href="<?= url('blog/') ?>#updates">Embassy Updates</a></li>
                        <li><a href="<?= url('visa-consultants-india/') ?>">Visa Consultants Across India</a></li>
                    </ul>
                </details>

                <details class="footer-col-accordion" open style="grid-column:span 1">
                    <summary style="color:#fff;font-size:14px;margin-bottom:16px">Support</summary>
                    <div class="footer-support-panel" style="border:none;background:none;padding:0">
                        <p>Need Visa Assistance? Our support team is available 24&times;7.</p>
                        <div class="support-links">
                            <a href="https://wa.me/917844819819" target="_blank" rel="noopener">WhatsApp Us</a>
                            <a href="tel:+917844819819">Call Us</a>
                            <a href="mailto:info@tripgation.com">Email Us</a>
                            <a href="<?= url('track-application/') ?>">Track Application</a>
                            <a href="<?= url('login.php') ?>">Login</a>
                        </div>
                    </div>
                </details>
            </div>

            <div class="newsletter-band">
                <div class="newsletter-band-inner">
                    <div>
                        <h4>Stay Updated on Visa &amp; Travel Requirements</h4>
                        <p>Occasional updates only — no spam. Unsubscribe any time.</p>
                    </div>
                    <form class="newsletter-form" method="post" action="<?= url('newsletter-subscribe.php') ?>">
                        <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
                        <input type="text" name="name" placeholder="Name" required>
                        <input type="email" name="email" placeholder="Email address" required>
                        <button type="submit">Subscribe</button>
                    </form>
                </div>
            </div>

            <div class="trust-row">
                <span><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3 7h7l-5.5 4.5L18 21l-6-4-6 4 1.5-7.5L2 9h7z"/></svg> Professional Visa Assistance</span>
                <span><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0110 0v4"/></svg> Secure Document Handling</span>
                <span><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg> 24&times;7 Customer Support</span>
                <span><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/></svg> Experienced Visa Consultants</span>
                <span><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 11l3 3L22 4"/><path d="M21 12v7a2 2 0 01-2 2H5a2 2 0 01-2-2V5a2 2 0 012-2h11"/></svg> Transparent Process</span>
            </div>

            <div class="footer-legal-bar">
                <a href="<?= url('privacy-policy/') ?>">Privacy Policy</a>
                <a href="<?= url('terms-and-conditions/') ?>">Terms &amp; Conditions</a>
                <a href="<?= url('refund-policy/') ?>">Refund Policy</a>
                <a href="<?= url('cookie-policy/') ?>">Cookie Policy</a>
                <a href="<?= url('disclaimer/') ?>">Disclaimer</a>
                <a href="<?= url('accessibility/') ?>">Accessibility</a>
            </div>

            <div class="footer-bottom">
                <span>&copy; 2015-<?= date('Y') ?>, Videshia — a unit of Tripgation. All rights reserved. Visa Consultancy &amp; Travel Documentation Assistance.</span>
            </div>
        </div>
    </footer>

    <?php require __DIR__ . '/chat-widget.php'; ?>

    <script src="<?= asset('js/main.js') ?>"></script>
</body>
</html>
