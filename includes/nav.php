<?php require_once __DIR__ . '/countries-data.php'; ?>
<nav id="mobile-menu">
    <ul>
        <li class="has-dropdown">
            <a href="our-services">Services</a>
            <ul class="submenu has-homemenu mega-panel">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5>Visa Types</h5>
                            <ul class="mega-links">
                                <li><a href="visa-tourist">Tourist Visa</a></li>
                                <li><a href="visa-business">Business Visa</a></li>
                                <li><a href="visa-work">Work Visa</a></li>
                                <li><a href="visa-family">Family Visa</a></li>
                                <li><a href="visa-transit">Transit Visa</a></li>
                                <li><a href="visa-medical">Medical Visa</a></li>
                                <li><a href="visa-sports">Sports Visa</a></li>
                                <li><a href="visa-crew">Crew Visa</a></li>
                                <li><a href="visa-extension">Visa Extension</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5>Application Support</h5>
                            <ul class="mega-links">
                                <li><a href="contact">Visa Consultation</a></li>
                                <li><a href="visa-consultancy-services">Visa Assistance</a></li>
                                <li><a href="visa-appointment">Embassy Appointment Assistance</a></li>
                                <li><a href="visa-checklist">Document Checklist</a></li>
                                <li><a href="visa-refusal">Refusal &amp; Re-Application Guidance</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Need help choosing?</strong>Get a free 10-minute expert consultation.</div>
                        <a href="contact" class="mega-cta-btn">Talk to a Visa Expert <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="country-list">Countries</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-countries">
                <li>
                    <div class="country-explorer-menu">
                        <div class="country-explorer-search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <input type="text" class="country-nav-search" placeholder="Search country or visa destination...">
                        </div>
                        <div class="country-explorer-filters country-nav-filters">
                            <button type="button" class="active" data-region="all">All</button>
                            <button type="button" data-region="Asia">Asia</button>
                            <button type="button" data-region="Europe">Europe</button>
                            <button type="button" data-region="North America">North America</button>
                            <button type="button" data-region="South America">South America</button>
                            <button type="button" data-region="Africa">Africa</button>
                            <button type="button" data-region="Middle East">Middle East</button>
                            <button type="button" data-region="Oceania">Oceania</button>
                        </div>
                        <div class="country-explorer-grid country-nav-grid">
                            <a href="country-schengen" class="country-chip" data-name="schengen schengen countries 29" data-slug="schengen" data-region="Europe">
                                <span class="flag">&#127466;&#127482;</span>
                                <span>Schengen Countries (29)</span>
                            </a>
                            <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                            <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-slug="<?php echo strtolower(str_replace('-', ' ', $c['slug'])); ?>" data-region="<?php echo $c['region']; ?>">
                                <span class="flag"><?php echo $c['flag']; ?></span>
                                <span><?php echo $c['name']; ?></span>
                            </a>
                            <?php endforeach; ?>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Explore more</strong>Browse the complete country directory.</div>
                        <a href="country-list" class="mega-cta-btn">View All <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="visa-consultancy-services">Visa Solutions</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5>Know Before You Apply</h5>
                            <ul class="mega-links">
                                <li><a href="visa-requirements">Visa Requirements Checker</a></li>
                                <li><a href="visa-checklist">Document Checklist</a></li>
                                <li><a href="visa-consultancy-services">Visa Application Guide</a></li>
                                <li><a href="visa-refusal">Visa Refusal &amp; Rejection Reasons</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5>Tools</h5>
                            <ul class="mega-links">
                                <li><a href="country-list">Country-Wise Requirements</a></li>
                                <li><a href="visa-appointment">Book an Appointment</a></li>
                                <li><a href="track-application">Track Your Application</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Not sure what you need?</strong>We'll match you to the right visa category and documents.</div>
                        <a href="visa-consultancy-services" class="mega-cta-btn">Talk To A Visa Expert <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="apostille">Apostille</a>
            <ul class="submenu simple-dropdown">
                <li><a href="apostille">Apostille Overview</a></li>
                <li><a href="apostille-mea">MEA Apostille</a></li>
                <li><a href="apostille-certificate-attestation">Certificate Attestation</a></li>
                <li><a href="apostille-embassy-attestation">Embassy Attestation</a></li>
                <li><a href="apostille-document-legalisation">Document Legalisation</a></li>
                <li><a href="apostille-translation-services">Translation &amp; Notary Assistance</a></li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="forex">Forex</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-forex">
                <li>
                    <div class="mega-panel-inner-icons">
                        <a href="forex#foreign-currency" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-money-bill-wave"></i></span>
                            <span class="mega-icon-text"><strong>Foreign Currency</strong><small>Buy currency notes for your trip</small></span>
                        </a>
                        <a href="forex#forex-card" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-credit-card"></i></span>
                            <span class="mega-icon-text"><strong>Forex Card</strong><small>Prepaid travel card, loaded &amp; ready</small></span>
                        </a>
                        <a href="forex#currency-exchange" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-right-left"></i></span>
                            <span class="mega-icon-text"><strong>Currency Exchange</strong><small>Exchange for your specific need</small></span>
                        </a>
                        <a href="forex#travel-forex" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-earth-americas"></i></span>
                            <span class="mega-icon-text"><strong>Travel Forex</strong><small>Not sure what fits? We'll guide you</small></span>
                        </a>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Already have a request?</strong>Track its status, or log in to see all your requests.</div>
                        <div class="mega-bottom-actions">
                            <a href="forex-my-requests" class="mega-cta-btn mega-cta-btn-ghost">My Requests</a>
                            <a href="forex-track" class="mega-cta-btn">Track Forex Request <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="resources">Resources</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-resources mega-align-right">
                <li>
                    <div class="mega-panel-inner-resources">
                        <div class="mega-col-icons">
                            <h5><i class="fa-solid fa-book-open"></i> Guides</h5>
                            <div class="mega-icon-links-vert">
                                <a href="visa-guides" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-passport"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa Guides</strong><small>By country or visa type</small></span>
                                </a>
                                <a href="visa-requirements-guide" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-clipboard-check"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa Requirements</strong><small>Documents &amp; basics</small></span>
                                </a>
                                <a href="visa-application-process" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-file-signature"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Application Process</strong><small>Step-by-step guide</small></span>
                                </a>
                                <a href="visa-interview-guide" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-comments"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Interview Guide</strong><small>Prep &amp; common Qs</small></span>
                                </a>
                                <a href="visa-refusal" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-file-circle-xmark"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Rejection Guide</strong><small>Reasons &amp; reapplying</small></span>
                                </a>
                            </div>
                        </div>
                        <div class="mega-col-icons">
                            <h5><i class="fa-solid fa-arrows-rotate"></i> Updates</h5>
                            <div class="mega-icon-links-vert">
                                <a href="visa-updates" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-arrows-rotate"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa Updates</strong><small>Policy &amp; fee changes</small></span>
                                </a>
                                <a href="embassy-news" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-building-columns"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Embassy News</strong><small>News &amp; closures</small></span>
                                </a>
                                <a href="visa-alerts" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-bell"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa Alerts</strong><small>Urgent changes</small></span>
                                </a>
                                <a href="entry-requirements" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-plane-arrival"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Entry Requirements</strong><small>Arrival rules</small></span>
                                </a>
                            </div>
                        </div>
                        <div class="mega-col-icons mega-col-tools">
                            <h5><i class="fa-solid fa-toolbox"></i> Tools</h5>
                            <div class="mega-icon-links-vert">
                                <a href="visa-requirements" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-circle-check"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Eligibility Checker</strong><small>By destination</small></span>
                                </a>
                                <a href="visa-fee-calculator" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-calculator"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Fee Calculator</strong><small>Govt &amp; service fees</small></span>
                                </a>
                                <a href="visa-processing-time-checker" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-clock"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Processing Time</strong><small>Typical timelines</small></span>
                                </a>
                                <a href="visa-checklist" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-clipboard-list"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Document Checklist</strong><small>Personalised list</small></span>
                                </a>
                            </div>
                        </div>
                        <div class="mega-col-icons">
                            <h5><i class="fa-solid fa-circle-question"></i> Help</h5>
                            <div class="mega-icon-links-vert">
                                <a href="visa-faqs" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-circle-question"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa FAQs</strong><small>Common questions</small></span>
                                </a>
                                <a href="visa-tips" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-lightbulb"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Visa Tips</strong><small>Practical tips</small></span>
                                </a>
                                <a href="consultant-help" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-headset"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Consultant Help</strong><small>Talk to an expert</small></span>
                                </a>
                                <a href="downloads" class="mega-icon-link-sm">
                                    <span class="mega-icon-badge-sm"><i class="fa-solid fa-download"></i></span>
                                    <span class="mega-icon-text-sm"><strong>Download Center</strong><small>Templates &amp; lists</small></span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>New to visa applications?</strong>Start with our guides, or talk to a consultant directly.</div>
                        <a href="resources" class="mega-cta-btn">Explore All Resources <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="about">Company</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-forex mega-panel-company mega-align-right">
                <li>
                    <div class="mega-panel-inner-icons">
                        <a href="about#overview" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-building"></i></span>
                            <span class="mega-icon-text"><strong>About Us</strong><small>Our story &amp; approach</small></span>
                        </a>
                        <a href="why-us" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-star"></i></span>
                            <span class="mega-icon-text"><strong>Why Us?</strong><small>What sets us apart</small></span>
                        </a>
                        <a href="vision-mission" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-compass"></i></span>
                            <span class="mega-icon-text"><strong>Vision &amp; Mission</strong><small>Why we do this work</small></span>
                        </a>
                        <a href="leadership" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-user-tie"></i></span>
                            <span class="mega-icon-text"><strong>Leadership</strong><small>Meet our team</small></span>
                        </a>
                        <a href="payment" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-money-check-dollar"></i></span>
                            <span class="mega-icon-text"><strong>Payment Link</strong><small>Pay an invoice securely</small></span>
                        </a>
                        <a href="contact" class="mega-icon-link">
                            <span class="mega-icon-badge"><i class="fa-solid fa-headset"></i></span>
                            <span class="mega-icon-text"><strong>Support</strong><small>Reach us directly</small></span>
                        </a>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Want to know more about us?</strong>Read our story, or talk to a consultant directly.</div>
                        <a href="contact" class="mega-cta-btn">Talk To Us <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>
    </ul>
</nav>
