<?php require_once __DIR__ . '/countries-data.php'; ?>
<nav id="mobile-menu">
    <ul>
        <li class="has-dropdown">
            <a href="visa-consultancy-services">Visa</a>
            <ul class="submenu has-homemenu mega-panel">
                <li>
                    <div class="mega-panel-inner">
                        <div class="mega-col">
                            <h5>Visa Services</h5>
                            <ul class="mega-links">
                                <li><a href="service-details">Tourist Visa</a></li>
                                <li><a href="service-details">Business Visa</a></li>
                                <li><a href="service-details">Visitor Visa</a></li>
                                <li><a href="service-details">Family Visit Visa</a></li>
                                <li><a href="service-details">Transit Visa</a></li>
                                <li><a href="service-details">Work Visa</a></li>
                                <li><a href="service-details">Employment Visa</a></li>
                                <li><a href="service-details">Immigration / PR Assistance</a></li>
                                <li><a href="service-details">E-Visa</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5>Visa Assistance</h5>
                            <ul class="mega-links">
                                <li><a href="appointment">Visa Eligibility Check</a></li>
                                <li><a href="/#checklist">Document Checklist</a></li>
                                <li><a href="appointment">Appointment Assistance</a></li>
                                <li><a href="service-details">Interview Preparation</a></li>
                                <li><a href="service-details">Visa Application Tracking</a></li>
                                <li><a href="service-details">Visa Documentation Assistance</a></li>
                            </ul>
                        </div>
                        <div class="mega-col">
                            <h5>Popular Destinations</h5>
                            <ul class="mega-links mega-links-flags">
                                <?php foreach (array_slice($VISA_AGENCY_COUNTRIES, 0, 6) as $c): ?>
                                <li><a href="country-list"><span><?php echo $c['flag']; ?></span> <?php echo $c['name']; ?></a></li>
                                <?php endforeach; ?>
                            </ul>
                            <a href="visa-consultancy-services" class="mega-cta">Explore All Visa Services <i class="fa-solid fa-arrow-right"></i></a>
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
                        <a href="country-list" class="mega-cta">View All Countries <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </li>
            </ul>
        </li>
        <li class="has-dropdown">
            <a href="apostille">Apostille</a>
            <ul class="submenu">
                <li><a href="apostille">Overview</a></li>
                <li><a href="apostille">MEA Apostille</a></li>
                <li><a href="apostille">Embassy Attestation</a></li>
                <li><a href="apostille">Certificate Attestation</a></li>
                <li><a href="apostille">Document Legalisation</a></li>
                <li><a href="apostille">Translation Services</a></li>
            </ul>
        </li>
        <li class="has-dropdown">
            <a href="other-services">Services</a>
            <ul class="submenu">
                <li><a href="other-services">Travel Insurance</a></li>
                <li><a href="other-services">Forex Assistance</a></li>
                <li><a href="other-services">Flight &amp; Hotel Reservation</a></li>
                <li><a href="other-services">Airport Meet &amp; Assist</a></li>
                <li><a href="other-services">Corporate Visa Assistance</a></li>
            </ul>
        </li>
        <li class="has-dropdown">
            <a href="about">Company</a>
            <ul class="submenu">
                <li><a href="about">About Us</a></li>
                <li><a href="careers">Careers</a></li>
                <li><a href="news">News &amp; Blog</a></li>
                <li><a href="contact">Contact Us</a></li>
            </ul>
        </li>
        <li class="has-dropdown">
            <a href="news">Resources</a>
            <ul class="submenu">
                <li><a href="news">Blog</a></li>
                <li><a href="news-grid">Visa Guides</a></li>
                <li><a href="/#checklist">Document Checklist</a></li>
                <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                <li><a href="/#faq">FAQs</a></li>
            </ul>
        </li>
        <li>
            <a href="contact">Contact</a>
        </li>
    </ul>
</nav>
