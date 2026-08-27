<?php require_once __DIR__ . '/countries-data.php'; ?>
<nav id="mobile-menu">
    <ul>
        <li class="has-dropdown">
            <a href="our-services"><i class="fa-regular fa-briefcase nav-top-icon"></i>Services</a>
            <ul class="submenu has-homemenu mega-panel">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-comments"></i>Application Support</h5>
                            <ul class="mega-links">
                                <li><a href="contact">Visa Consultation</a></li>
                                <li><a href="visa-checklist">Document Checklist</a></li>
                                <li><a href="visa-appointment">Appointment Assistance</a></li>
                                <li><a href="visa-consultancy-services">Visa Application Guide</a></li>
                                <li><a href="visa-refusal">Refusal &amp; Re-Application Guidance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-star"></i>Specialized Services</h5>
                            <ul class="mega-links">
                                <li><a href="other-services">Corporate Visa Services</a></li>
                                <li><a href="other-services">Travel Insurance</a></li>
                                <li><a href="other-services">Hotel &amp; Flight Reservation</a></li>
                                <li><a href="visa-consultancy-services">Immigration / PR Assistance</a></li>
                                <li><a href="contact">Invitation Letter Assistance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-grip"></i>Explore</h5>
                            <ul class="mega-links">
                                <li><a href="our-services">All Services &mdash; Directory</a></li>
                                <li><a href="visa-consultancy-services">Visa Consultancy Overview</a></li>
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
            <a href="country-list"><i class="fa-regular fa-globe nav-top-icon"></i>Countries</a>
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
            <a href="visa-consultancy-services"><i class="fa-regular fa-passport nav-top-icon"></i>Visa Solutions</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-suitcase-rolling"></i>By Purpose</h5>
                            <ul class="mega-links">
                                <li><a href="visa-tourist">Tourist Visa</a></li>
                                <li><a href="visa-business">Business Visa</a></li>
                                <li><a href="visa-family">Family Visa</a></li>
                                <li><a href="visa-transit">Transit Visa</a></li>
                                <li><a href="visa-sports">Sports Visa</a></li>
                                <li><a href="visa-medical">Medical Visa</a></li>
                                <li><a href="visa-crew">Crew Visa</a></li>
                                <li><a href="visa-extension">Visa Extension</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-toolbox"></i>Application Support</h5>
                            <ul class="mega-links">
                                <li><a href="visa-requirements">Visa Requirements Checker</a></li>
                                <li><a href="visa-checklist">Document Checklist</a></li>
                                <li><a href="visa-appointment">Appointment / Interview Support</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                <li><a href="/#faq">Visa FAQs</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Not sure which visa fits?</strong>We'll match you to the right visa category.</div>
                        <a href="visa-consultancy-services" class="mega-cta-btn">Find the Right Visa <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="apostille"><i class="fa-regular fa-stamp nav-top-icon"></i>Apostille</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col mega-align-right">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-stamp"></i>Apostille Services</h5>
                            <ul class="mega-links">
                                <li><a href="apostille">Apostille Overview</a></li>
                                <li><a href="apostille-mea">MEA Apostille</a></li>
                                <li><a href="apostille-certificate-attestation">Certificate Attestation</a></li>
                                <li><a href="apostille-document-legalisation">Document Legalisation</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-building-columns"></i>Related Services</h5>
                            <ul class="mega-links">
                                <li><a href="apostille-embassy-attestation">Embassy Attestation</a></li>
                                <li><a href="apostille-translation-services">Translation &amp; Notary Assistance</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Need document attestation?</strong>Get your documents apostilled and legalised end-to-end.</div>
                        <a href="apostille" class="mega-cta-btn">Explore Attestation Services <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="visa-news"><i class="fa-regular fa-book-open nav-top-icon"></i>Resources</a>
            <ul class="submenu has-homemenu mega-panel mega-align-right">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-book-open"></i>Travel &amp; Visa Information</h5>
                            <ul class="mega-links">
                                <li><a href="news-grid">Visa Guides</a></li>
                                <li><a href="country-list">Country Guides</a></li>
                                <li><a href="visa-requirements">Visa Requirements</a></li>
                                <li><a href="visa-checklist">Document Checklists</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-toolbox"></i>Tools</h5>
                            <ul class="mega-links">
                                <li><a href="visa-requirements">Visa Requirements Checker</a></li>
                                <li><a href="country-list">Country Search</a></li>
                                <li><a href="visa-checklist">Visa Checklist</a></li>
                                <li><a href="visa-appointment">Book an Appointment</a></li>
                                <li><a href="/#faq">FAQs</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-newspaper"></i>Content</h5>
                            <ul class="mega-links">
                                <li><a href="news">Blog</a></li>
                                <li><a href="visa-news">Visa News &amp; Updates</a></li>
                                <li><a href="news-grid">Travel Tips</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mega-bottom">
                        <div class="mega-bottom-text"><strong>Looking for guidance?</strong>Browse guides, checklists and FAQs in one place.</div>
                        <a href="visa-news" class="mega-cta-btn">Visit Visa Resources <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="b2b-partners"><i class="fa-regular fa-handshake nav-top-icon"></i>B2B Partners</a>
            <ul class="submenu simple-dropdown">
                <?php if ($b2bPartnerLoggedIn): ?>
                <li><a href="b2b-dashboard"><i class="fa-solid fa-gauge-high"></i> Dashboard</a></li>
                <li><a href="b2b-applications"><i class="fa-solid fa-passport"></i> Visa Applications</a></li>
                <li><a href="b2b-quotations"><i class="fa-solid fa-file-invoice-dollar"></i> Quotations</a></li>
                <li><a href="b2b-invoices"><i class="fa-solid fa-file-invoice"></i> Invoices &amp; Payments</a></li>
                <li><a href="b2b-messages"><i class="fa-solid fa-comments"></i> Messages</a></li>
                <li><a href="b2b-logout"><i class="fa-solid fa-right-from-bracket"></i> Log Out</a></li>
                <?php else: ?>
                <li><a href="b2b-partner-register"><i class="fa-solid fa-handshake"></i> Become a B2B Partner</a></li>
                <li><a href="b2b-login"><i class="fa-solid fa-right-to-bracket"></i> Partner Login</a></li>
                <li><a href="b2b-partners#benefits"><i class="fa-solid fa-star"></i> Why Partner With Us</a></li>
                <li><a href="b2b-partners#faq"><i class="fa-solid fa-circle-question"></i> FAQs</a></li>
                <?php endif; ?>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="about"><i class="fa-regular fa-building nav-top-icon"></i>Company</a>
            <ul class="submenu simple-dropdown">
                <li><a href="about"><i class="fa-solid fa-building"></i> About VisaAgency.in</a></li>
                <li><a href="about#our-team"><i class="fa-solid fa-users"></i> Our Team</a></li>
                <li><a href="our-services"><i class="fa-solid fa-list-check"></i> Our Services</a></li>
                <li><a href="careers"><i class="fa-solid fa-briefcase"></i> Careers</a></li>
                <li><a href="visa-news"><i class="fa-solid fa-newspaper"></i> News &amp; Updates</a></li>
                <li><a href="contact"><i class="fa-solid fa-envelope"></i> Contact Us</a></li>
            </ul>
        </li>

        <li>
            <a href="contact"><i class="fa-regular fa-headset nav-top-icon"></i>Contact</a>
        </li>
    </ul>
</nav>
