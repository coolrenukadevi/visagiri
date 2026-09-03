<?php require_once __DIR__ . '/countries-data.php'; ?>
<nav id="mobile-menu">
    <ul>
        <li>
            <a href="/">Home</a>
        </li>

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
            <a href="visa-news">Resources</a>
            <ul class="submenu simple-dropdown">
                <li><a href="news">Visa Blog</a></li>
                <li><a href="visa-news">Visa News &amp; Updates</a></li>
                <li><a href="contact">Contact Us</a></li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="about">Company</a>
            <ul class="submenu simple-dropdown">
                <li><a href="about">About VisaAgency.in</a></li>
                <li><a href="about#our-team">Our Team</a></li>
                <li><a href="careers">Careers</a></li>
            </ul>
        </li>
    </ul>
</nav>
