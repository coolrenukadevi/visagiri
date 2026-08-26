                    <nav class="va-footer-columns" aria-label="Footer navigation">
                        <div class="footer-col-brand">
                            <a href="/" class="footer-brand-logo"><img src="assets/img/logo/white-logo.svg" alt="Visa Agency logo"></a>
                            <p class="footer-brand-desc">
                                VisaAgency.in is your trusted partner for international visa solutions&mdash;combining
                                expert guidance, meticulous documentation and end-to-end application support to make
                                global travel simpler, smoother and more confident.
                            </p>
                            <p class="footer-brand-tagline">Global Visa Assistance | Professional Guidance | Transparent Process</p>
                            <div class="social-icon mt-3" role="list" aria-label="Social media">
                                <a href="<?php echo htmlspecialchars($site_social['linkedin']); ?>" target="_blank" rel="noopener" aria-label="LinkedIn"><i class="fa-brands fa-linkedin"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['twitter']); ?>" target="_blank" rel="noopener" aria-label="X (Twitter)"><i class="fa-brands fa-twitter"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['instagram']); ?>" target="_blank" rel="noopener" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['facebook']); ?>" target="_blank" rel="noopener" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                                <span role="listitem" aria-label="YouTube (coming soon)"><i class="fa-brands fa-youtube"></i></span>
                                <a href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener" aria-label="WhatsApp"><i class="fa-brands fa-whatsapp"></i></a>
                            </div>
                        </div>

                        <details class="footer-accordion" open>
                            <summary>Visa Services</summary>
                            <ul>
                                <li><a href="visa-tourist">Tourist Visa</a></li>
                                <li><a href="visa-business">Business Visa</a></li>
                                <li><a href="visa-family">Family Visa</a></li>
                                <li><a href="visa-transit">Transit Visa</a></li>
                                <li><a href="visa-sports">Sports Visa</a></li>
                                <li><a href="visa-medical">Medical Visa</a></li>
                                <li><a href="visa-crew">Crew Visa</a></li>
                                <li><a href="visa-extension">Visa Extension</a></li>
                            </ul>
                            <a href="our-services" class="footer-col-more">View All Visa Services &rarr;</a>
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
                                <li><a href="visa-requirements">Visa Requirements</a></li>
                                <li><a href="visa-checklist">Visa Checklist</a></li>
                                <li><a href="visa-appointment">Visa Appointment</a></li>
                                <li><a href="visa-consultancy-services">Visa Application Guide</a></li>
                                <li><a href="apostille">Travel Documentation</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                <li><a href="/#faq">Visa FAQs</a></li>
                                <li><a href="visa-news">Visa News &amp; Updates</a></li>
                            </ul>
                            <a href="visa-news" class="footer-col-more">Explore Visa Resources &rarr;</a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Company</summary>
                            <ul>
                                <li><a href="contact">Contact Us</a></li>
                                <li><a href="visa-appointment">Book a Consultation</a></li>
                                <li><a href="about">About Us</a></li>
                                <li><a href="careers">Careers</a></li>
                                <li><a href="visa-news">News &amp; Updates</a></li>
                                <li><a href="customer-login">Customer Login</a></li>
                                <li><a href="payment">Payment Link</a></li>
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
