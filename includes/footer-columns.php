                    <nav class="va-footer-columns" aria-label="Footer navigation">
                        <div class="footer-col-brand">
                            <a href="/" class="footer-brand-logo"><img src="assets/img/logo/visaagency-logo-dark.png" alt="Visa Agency logo"></a>
                            <p class="footer-brand-desc">
                                Your trusted partner for Visa, Apostille, Travel &amp; Documentation Services.
                            </p>
                            <ul class="footer-trust-mini" aria-label="Why choose us">
                                <li><i class="fa-solid fa-user-shield" aria-hidden="true"></i> Professional Visa Assistance</li>
                                <li><i class="fa-solid fa-location-dot" aria-hidden="true"></i> India-based Support</li>
                                <li><i class="fa-solid fa-lock" aria-hidden="true"></i> Secure Enquiry Processing</li>
                                <li><i class="fa-solid fa-headset" aria-hidden="true"></i> Expert Assistance</li>
                            </ul>
                            <p class="footer-connect-label">Connect With Us</p>
                            <div class="social-icon mt-3" role="list" aria-label="Social media">
                                <a href="<?php echo htmlspecialchars($site_social['linkedin']); ?>" target="_blank" rel="noopener" aria-label="Visit our LinkedIn page"><i class="fa-brands fa-linkedin" aria-hidden="true"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['twitter']); ?>" target="_blank" rel="noopener" aria-label="Visit our X (Twitter) page"><i class="fa-brands fa-twitter" aria-hidden="true"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['instagram']); ?>" target="_blank" rel="noopener" aria-label="Visit our Instagram page"><i class="fa-brands fa-instagram" aria-hidden="true"></i></a>
                                <a href="<?php echo htmlspecialchars($site_social['facebook']); ?>" target="_blank" rel="noopener" aria-label="Visit our Facebook page"><i class="fa-brands fa-facebook-f" aria-hidden="true"></i></a>
                                <span role="listitem" aria-label="YouTube page coming soon"><i class="fa-brands fa-youtube" aria-hidden="true"></i></span>
                                <a href="<?php echo $site_whatsapp_url; ?>" target="_blank" rel="noopener" aria-label="Message us on WhatsApp"><i class="fa-brands fa-whatsapp" aria-hidden="true"></i></a>
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
                            <a href="our-services" class="footer-col-more">View All Visa Services <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Popular Destinations</summary>
                            <ul>
                                <?php
                                $footer_popular_slugs = ['usa', 'uk', 'canada', 'australia', 'germany', 'uae', 'singapore', 'thailand', 'japan', 'hong-kong'];
                                foreach ($VISA_AGENCY_COUNTRIES as $fc):
                                    if (!in_array($fc['slug'], $footer_popular_slugs, true)) continue;
                                ?>
                                <li><a href="country-<?php echo $fc['slug']; ?>"><span aria-hidden="true"><?php echo $fc['flag']; ?></span> <?php echo $fc['name']; ?></a></li>
                                <?php endforeach; ?>
                            </ul>
                            <a href="country-list" class="footer-col-more">Explore All <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></a>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Services &amp; Support</summary>
                            <ul>
                                <li><a href="contact" data-open-enquiry>Visa Enquiry</a></li>
                                <li><a href="apostille">Apostille &amp; Attestation</a></li>
                                <li><a href="other-services#travel-insurance">Travel Insurance</a></li>
                                <li><a href="forex">Forex Services</a></li>
                                <li><a href="other-services#flight-hotel-assistance">Flight &amp; Hotel Assistance</a></li>
                                <li><a href="visa-checklist">Document Checklist</a></li>
                                <li><a href="track-application">Track Your Enquiry</a></li>
                            </ul>
                        </details>

                        <details class="footer-accordion" open>
                            <summary>Company</summary>
                            <ul>
                                <li><a href="contact">Contact Us</a></li>
                                <li><a href="visa-appointment">Book a Consultation</a></li>
                                <li><a href="about">About Us</a></li>
                                <li><a href="locations">Locations</a></li>
                                <li><a href="careers">Careers</a></li>
                                <li><a href="visa-news">Visa News &amp; Updates</a></li>
                                <li><a href="customer-login">Customer Login</a></li>
                                <li><a href="payment">Payment Link</a></li>
                                <li><a href="b2b-partners">Become a B2B Partner</a></li>
                                <li><a href="b2b-login">B2B Partner Login</a></li>
                            </ul>
                        </details>
                    </nav>

                    <div class="footer-action-row">
                        <div class="footer-quick-enquiry">
                            <div class="fqe-icon" aria-hidden="true"><i class="fa-solid fa-headset"></i></div>
                            <div class="fqe-text">
                                <strong>Need help with your visa?</strong>
                                <span>Talk to our visa experts.</span>
                            </div>
                            <a href="contact" class="fqe-btn" data-open-enquiry>Enquire Now <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></a>
                        </div>

                        <form class="footer-newsletter-form" id="footerNewsletterForm" novalidate>
                            <div class="fnl-text">
                                <strong>Visa &amp; Travel Updates</strong>
                                <span>Get important visa updates, travel alerts and destination news.</span>
                            </div>
                            <div class="fnl-field-row">
                                <label for="footerNewsletterEmail" class="visually-hidden">Email address</label>
                                <input type="email" id="footerNewsletterEmail" name="email" placeholder="Enter your email address" required autocomplete="email">
                                <button type="submit" id="footerNewsletterSubmit">
                                    <span class="fnl-btn-label">Subscribe</span>
                                    <span class="fnl-btn-spinner" hidden></span>
                                </button>
                            </div>
                            <div class="footer-newsletter-honeypot" aria-hidden="true">
                                <label for="footerNewsletterWebsite">Leave this field empty</label>
                                <input type="text" id="footerNewsletterWebsite" name="website" tabindex="-1" autocomplete="off">
                            </div>
                            <p class="fnl-consent">By subscribing, you agree to receive email updates from VisaAgency.in. See our <a href="privacy-policy">Privacy Policy</a>. Unsubscribe anytime.</p>
                            <p class="fnl-status" id="footerNewsletterStatus" role="status" aria-live="polite" hidden></p>
                        </form>
                    </div>

                    <div class="footer-trust-bar">
                        <div class="trust-item"><i class="fa-solid fa-user-shield" aria-hidden="true"></i> Professional Assistance</div>
                        <div class="trust-item"><i class="fa-solid fa-lock" aria-hidden="true"></i> Secure Enquiry</div>
                        <div class="trust-item"><i class="fa-solid fa-route" aria-hidden="true"></i> Country-Specific Guidance</div>
                        <div class="trust-item"><i class="fa-solid fa-scale-balanced" aria-hidden="true"></i> Transparent Process</div>
                        <div class="trust-item"><i class="fa-solid fa-headset" aria-hidden="true"></i> Expert Support</div>
                        <div class="trust-item"><i class="fa-solid fa-earth-americas" aria-hidden="true"></i> Global Visa Coverage</div>
                    </div>
