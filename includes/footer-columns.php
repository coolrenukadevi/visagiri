                    <nav class="va-footer-columns" aria-label="Footer navigation">
                        <div class="footer-col-brand">
                            <h4>VisaAgency.in</h4>
                            <p class="footer-brand-desc">
                                VisaAgency.in is your trusted partner for international visa solutions&mdash;combining
                                expert guidance, meticulous documentation and end-to-end application support to make
                                global travel simpler, smoother and more confident.
                            </p>
                            <p class="footer-brand-tagline">Global Visa Assistance | Professional Guidance | Transparent Process</p>
                            <div class="social-icon mt-3" role="list" aria-label="Social media (profiles coming soon)">
                                <span role="listitem" aria-label="LinkedIn (coming soon)"><i class="fa-brands fa-linkedin"></i></span>
                                <span role="listitem" aria-label="Twitter (coming soon)"><i class="fa-brands fa-twitter"></i></span>
                                <span role="listitem" aria-label="Instagram (coming soon)"><i class="fa-brands fa-instagram"></i></span>
                                <span role="listitem" aria-label="YouTube (coming soon)"><i class="fa-brands fa-youtube"></i></span>
                                <a href="https://wa.me/917844819819" target="_blank" rel="noopener" aria-label="WhatsApp"><i class="fa-brands fa-whatsapp"></i></a>
                            </div>
                        </div>

                        <details class="footer-accordion" open>
                            <summary>Visa Services</summary>
                            <ul>
                                <li><a href="service-details">Tourist Visa</a></li>
                                <li><a href="service-details">Business Visa</a></li>
                                <li><a href="service-details">Work Visa</a></li>
                                <li><a href="service">Family Visa</a></li>
                                <li><a href="service-details">Transit Visa</a></li>
                                <li><a href="visa-consultancy-services">Conference &amp; Event Visa</a></li>
                                <li><a href="visa-consultancy-services">Sports Visa</a></li>
                                <li><a href="visa-consultancy-services">Medical Visa</a></li>
                                <li><a href="visa-consultancy-services">Crew Visa</a></li>
                                <li><a href="visa-consultancy-services">Visa Extension</a></li>
                            </ul>
                            <a href="visa-consultancy-services" class="footer-col-more">View All Visa Services &rarr;</a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Visa by Country</summary>
                            <ul>
                                <?php
                                $footer_popular_slugs = ['usa', 'uk', 'canada', 'australia', 'germany', 'uae', 'singapore', 'new-zealand'];
                                foreach ($VISA_AGENCY_COUNTRIES as $fc):
                                    if (!in_array($fc['slug'], $footer_popular_slugs, true)) continue;
                                ?>
                                <li><a href="country-<?php echo $fc['slug']; ?>"><?php echo $fc['flag']; ?> <?php echo $fc['name']; ?></a></li>
                                <?php endforeach; ?>
                            </ul>
                            <a href="country-list" class="footer-col-more">Explore <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries &rarr;</a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Visa Resources</summary>
                            <ul>
                                <li><a href="visa-consultancy-services">Visa Requirements</a></li>
                                <li><a href="/#checklist">Visa Checklist</a></li>
                                <li><a href="appointment">Visa Appointment</a></li>
                                <li><a href="visa-consultancy-services">Visa Application Guide</a></li>
                                <li><a href="apostille">Travel Documentation</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                <li><a href="/#faq">Visa FAQs</a></li>
                                <li><a href="news">Visa News &amp; Updates</a></li>
                            </ul>
                            <a href="visa-consultancy-services" class="footer-col-more">Explore Visa Resources &rarr;</a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Company</summary>
                            <ul>
                                <li><a href="about">About Us</a></li>
                                <li><a href="visa-consultancy-services">Our Services</a></li>
                                <li><a href="careers">Careers</a></li>
                                <li><a href="news">News &amp; Updates</a></li>
                                <li><a href="contact">Contact Us</a></li>
                                <li><a href="customer-login">Customer Login</a></li>
                            </ul>
                        </details>
                    </nav>

                    <div class="footer-trust-bar">
                        <div class="trust-item"><i class="fa-solid fa-user-shield"></i> Professional Assistance</div>
                        <div class="trust-item"><i class="fa-solid fa-lock"></i> Secure Enquiry</div>
                        <div class="trust-item"><i class="fa-solid fa-route"></i> Country-Specific Guidance</div>
                        <div class="trust-item"><i class="fa-solid fa-scale-balanced"></i> Transparent Process</div>
                        <div class="trust-item"><i class="fa-solid fa-headset"></i> Expert Support</div>
                        <div class="trust-item"><i class="fa-solid fa-earth-americas"></i> Global Visa Coverage</div>
                    </div>

                    <div class="footer-local-seo">
                        <h4>Visa Assistance in Patna</h4>
                        <p>
                            Looking for professional visa assistance in Patna, Bihar? Connect with our visa experts
                            for country-specific guidance, documentation support and application assistance.
                        </p>
                        <a href="contact">Contact Our Patna Visa Team &rarr;</a>
                    </div>
