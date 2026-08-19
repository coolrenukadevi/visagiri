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
                            <span class="mega-cta-hint">Need help choosing?</span>
                            <a href="contact" class="mega-cta">Talk to a Visa Expert <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
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
                            <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                                <span class="flag"><?php echo $c['flag']; ?></span>
                                <span><?php echo $c['name']; ?></span>
                            </a>
                            <?php endforeach; ?>
                        </div>
                        <a href="country-list" class="mega-cta">View All <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries (A&ndash;Z Directory) <i class="fa-solid fa-arrow-right"></i></a>
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
                            <a href="visa-consultancy-services" class="mega-cta">Find the Right Visa <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="apostille"><i class="fa-regular fa-stamp nav-top-icon"></i>Apostille</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col">
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
                            <a href="apostille" class="mega-cta">Explore Attestation Services <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="visa-news"><i class="fa-regular fa-book-open nav-top-icon"></i>Resources</a>
            <ul class="submenu has-homemenu mega-panel">
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
                            <a href="visa-news" class="mega-cta">Visit Visa Resources <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="about"><i class="fa-regular fa-building nav-top-icon"></i>Company</a>
            <ul class="submenu simple-dropdown">
                <li><a href="about"><i class="fa-solid fa-building"></i> About VisaAgency.in</a></li>
                <li><a href="about#leadership"><i class="fa-solid fa-users"></i> Our Team</a></li>
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
