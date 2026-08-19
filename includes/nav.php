<?php require_once __DIR__ . '/countries-data.php'; ?>
<nav id="mobile-menu">
    <ul>
        <li class="has-dropdown">
            <a href="about">Company</a>
            <ul class="submenu simple-dropdown">
                <li><a href="about"><i class="fa-solid fa-building"></i> About Us</a></li>
                <li><a href="about#why-choose-us"><i class="fa-solid fa-circle-check"></i> Why Choose Us</a></li>
                <li><a href="careers"><i class="fa-solid fa-briefcase"></i> Careers</a></li>
                <li><a href="news"><i class="fa-solid fa-newspaper"></i> News &amp; Updates</a></li>
                <li><a href="contact"><i class="fa-solid fa-envelope"></i> Contact Us</a></li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="visa-consultancy-services">Services</a>
            <ul class="submenu has-homemenu mega-panel">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-passport"></i>Visa Services</h5>
                            <ul class="mega-links">
                                <li><a href="visa-tourist">Tourist Visa</a></li>
                                <li><a href="visa-business">Business Visa</a></li>
                                <li><a href="service-details">Work Visa</a></li>
                                <li><a href="visa-family">Family Visa</a></li>
                                <li><a href="visa-transit">Transit Visa</a></li>
                                <li><a href="visa-consultancy-services">Immigration / PR Assistance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-file-lines"></i>Documentation Services</h5>
                            <ul class="mega-links">
                                <li><a href="/#checklist">Visa Documentation</a></li>
                                <li><a href="appointment">Document Verification</a></li>
                                <li><a href="contact">Invitation Letter Assistance</a></li>
                                <li><a href="other-services">Travel Insurance</a></li>
                                <li><a href="other-services">Hotel &amp; Flight Reservation</a></li>
                                <li><a href="appointment">Appointment Assistance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-stamp"></i>Specialized Services</h5>
                            <ul class="mega-links">
                                <li><a href="apostille">Apostille &amp; Attestation</a></li>
                                <li><a href="apostille-embassy-attestation">Embassy Legalization</a></li>
                                <li><a href="apostille-translation-services">Translation Services</a></li>
                                <li><a href="other-services">Corporate Visa Services</a></li>
                            </ul>
                            <span class="mega-cta-hint">Need help choosing?</span>
                            <a href="contact" class="mega-cta">Talk to a Visa Expert <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
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
                            <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                                <span class="flag"><?php echo $c['flag']; ?></span>
                                <span><?php echo $c['name']; ?></span>
                            </a>
                            <?php endforeach; ?>
                        </div>
                        <a href="country-list" class="mega-cta">View All <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="visa-consultancy-services">Visa</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-passport"></i>Visa Categories</h5>
                            <ul class="mega-links">
                                <li><a href="visa-tourist">Tourist Visa</a></li>
                                <li><a href="visa-business">Business Visa</a></li>
                                <li><a href="service-details">Work Visa</a></li>
                                <li><a href="visa-family">Family Visa</a></li>
                                <li><a href="visa-transit">Transit Visa</a></li>
                                <li><a href="visa-medical">Medical Visa</a></li>
                                <li><a href="visa-consultancy-services">E-Visa</a></li>
                                <li><a href="visa-consultancy-services">Immigration / PR</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-toolbox"></i>Visa Tools</h5>
                            <ul class="mega-links">
                                <li><a href="visa-consultancy-services">Visa Requirements</a></li>
                                <li><a href="/#checklist">Document Checklist</a></li>
                                <li><a href="appointment">Visa Appointment</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                <li><a href="/#faq">Visa FAQs</a></li>
                            </ul>
                            <a href="/#visa-search" class="mega-cta">Find Your Visa Requirements <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="apostille">Apostille</a>
            <ul class="submenu has-homemenu mega-panel mega-panel-2col">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-stamp"></i>Apostille Services</h5>
                            <ul class="mega-links">
                                <li><a href="apostille-mea">MEA Apostille</a></li>
                                <li><a href="apostille-certificate-attestation">Educational Certificate Apostille</a></li>
                                <li><a href="apostille-certificate-attestation">Birth &amp; Marriage Certificate Apostille</a></li>
                                <li><a href="apostille-certificate-attestation">Commercial Document Apostille</a></li>
                                <li><a href="apostille-certificate-attestation">Power of Attorney Attestation</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-building-columns"></i>Related Services</h5>
                            <ul class="mega-links">
                                <li><a href="apostille-embassy-attestation">Embassy Attestation</a></li>
                                <li><a href="apostille-certificate-attestation">Certificate Attestation</a></li>
                                <li><a href="apostille-document-legalisation">Document Legalisation</a></li>
                                <li><a href="apostille-translation-services">Translation &amp; Notary Assistance</a></li>
                            </ul>
                            <a href="contact" class="mega-cta">Get Document Assistance <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li class="has-dropdown">
            <a href="news">Resources</a>
            <ul class="submenu has-homemenu mega-panel">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-book-open"></i>Visa Resources</h5>
                            <ul class="mega-links">
                                <li><a href="news-grid">Visa Guides</a></li>
                                <li><a href="country-list">Country Guides</a></li>
                                <li><a href="/#checklist">Visa Checklists</a></li>
                                <li><a href="/#faq">Visa FAQs</a></li>
                                <li><a href="news">Visa News</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-toolbox"></i>Useful Tools</h5>
                            <ul class="mega-links">
                                <li><a href="/#visa-search">Visa Finder</a></li>
                                <li><a href="/#checklist">Document Checklist</a></li>
                                <li><a href="country-list">Country Search</a></li>
                                <li><a href="appointment">Appointment Assistance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5><i class="fa-solid fa-newspaper"></i>Content</h5>
                            <ul class="mega-links">
                                <li><a href="news">Blog</a></li>
                                <li><a href="news-grid">Travel Tips</a></li>
                                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                            </ul>
                            <a href="news" class="mega-cta">Visit Resources <i class="fa-solid fa-arrow-right"></i></a>
                        </div>
                    </div>
                </li>
            </ul>
        </li>

        <li>
            <a href="contact">Contact</a>
        </li>
    </ul>
</nav>
