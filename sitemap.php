<?php
$page_title = "Sitemap &ndash; Visa Agency";
$page_description = "A full index of every page on visaagency.in &ndash; visa services, countries, apostille, resources and company pages.";
include __DIR__ . '/includes/header.php';

$sitemap_toc = [
    ['id' => 'main', 'n' => '01', 'label' => 'Main pages'],
    ['id' => 'services', 'n' => '02', 'label' => 'Visa services'],
    ['id' => 'apostille', 'n' => '03', 'label' => 'Apostille & other services'],
    ['id' => 'countries', 'n' => '04', 'label' => 'Countries'],
    ['id' => 'company', 'n' => '05', 'label' => 'Company & resources'],
    ['id' => 'legal', 'n' => '06', 'label' => 'Legal'],
    ['id' => 'xml', 'n' => '07', 'label' => 'XML sitemap'],
];

$sitemap_region_picks = [
    'Asia' => ['japan', 'singapore', 'china', 'thailand', 'malaysia', 'south-korea'],
    'Europe' => ['uk', 'germany', 'france', 'italy', 'spain', 'switzerland'],
    'North America' => ['usa', 'canada', 'mexico'],
    'Middle East' => ['uae', 'saudi-arabia', 'qatar', 'oman'],
    'Oceania' => ['australia', 'new-zealand', 'fiji'],
];
$country_by_slug = [];
foreach ($VISA_AGENCY_COUNTRIES as $c) {
    $country_by_slug[$c['slug']] = $c;
}
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Sitemap</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Sitemap</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Last Updated</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Pages Indexed</span><span class="value"><?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Country Pages &amp; Services</span></div>
                    <div><span class="label">For Search Engines</span><span class="value"><a href="sitemap.xml">sitemap.xml</a></span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Sitemap sections">
                        <p class="policy-index-title">Jump To</p>
                        <ol id="policyToc">
                            <?php foreach ($sitemap_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="main">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>Main Pages</h2></div>
                            <div class="policy-link-grid">
                                <div class="policy-link-col">
                                    <ul>
                                        <li><a href="/">Home</a></li>
                                        <li><a href="about">About Us</a></li>
                                        <li><a href="contact">Contact Us</a></li>
                                        <li><a href="appointment">Book an Appointment</a></li>
                                        <li><a href="customer-login">Customer Login</a></li>
                                        <li><a href="employee-login">Employee Login</a></li>
                                    </ul>
                                </div>
                            </div>
                        </section>

                        <section id="services">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Visa Services</h2></div>
                            <div class="policy-link-grid">
                                <div class="policy-link-col">
                                    <h3>Visa Categories</h3>
                                    <ul>
                                        <li><a href="visa-tourist">Tourist Visa</a></li>
                                        <li><a href="visa-business">Business Visa</a></li>
                                        <li><a href="service-details">Work Visa</a></li>
                                        <li><a href="visa-family">Family Visa</a></li>
                                        <li><a href="visa-transit">Transit Visa</a></li>
                                    </ul>
                                </div>
                                <div class="policy-link-col">
                                    <h3>More Categories</h3>
                                    <ul>
                                        <li><a href="visa-sports">Sports Visa</a></li>
                                        <li><a href="visa-medical">Medical Visa</a></li>
                                        <li><a href="visa-crew">Crew Visa</a></li>
                                        <li><a href="visa-extension">Visa Extension</a></li>
                                        <li class="more"><a href="visa-consultancy-services">Explore all visa services</a></li>
                                    </ul>
                                </div>
                                <div class="policy-link-col">
                                    <h3>Visa Assistance</h3>
                                    <ul>
                                        <li><a href="appointment">Visa Eligibility Check</a></li>
                                        <li><a href="/#checklist">Document Checklist</a></li>
                                        <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                    </ul>
                                </div>
                            </div>
                        </section>

                        <section id="apostille">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>Apostille &amp; Other Services</h2></div>
                            <div class="policy-link-grid">
                                <div class="policy-link-col">
                                    <h3>Apostille &amp; Attestation</h3>
                                    <ul>
                                        <li><a href="apostille">Overview</a></li>
                                        <li><a href="apostille-mea">MEA Apostille</a></li>
                                        <li><a href="apostille-embassy-attestation">Embassy Attestation</a></li>
                                        <li><a href="apostille-certificate-attestation">Certificate Attestation</a></li>
                                        <li><a href="apostille-document-legalisation">Document Legalisation</a></li>
                                        <li><a href="apostille-translation-services">Translation Services</a></li>
                                    </ul>
                                </div>
                                <div class="policy-link-col">
                                    <h3>Other Services</h3>
                                    <ul>
                                        <li><a href="other-services">Travel Insurance</a></li>
                                        <li><a href="other-services">Forex Assistance</a></li>
                                        <li><a href="other-services">Flight &amp; Hotel Reservation</a></li>
                                        <li><a href="other-services">Corporate Visa Assistance</a></li>
                                    </ul>
                                </div>
                            </div>
                        </section>

                        <section id="countries">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Countries</h2></div>
                            <p class="section-note" style="font-size:14px;color:var(--text);margin:0 0 18px;">We cover <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ destinations. A selection of popular ones is listed below &mdash; see the full country list for everything else.</p>

                            <?php foreach ($sitemap_region_picks as $region => $slugs): ?>
                            <p class="policy-region-label"><?php echo $region; ?></p>
                            <div class="policy-country-grid">
                                <?php foreach ($slugs as $slug):
                                    if (!isset($country_by_slug[$slug])) continue;
                                    $c = $country_by_slug[$slug];
                                ?>
                                <a href="country-<?php echo $c['slug']; ?>"><?php echo $c['flag']; ?> <?php echo $c['name']; ?></a>
                                <?php endforeach; ?>
                            </div>
                            <?php endforeach; ?>

                            <div class="policy-xml-card" style="margin-top:22px;">
                                <div>
                                    <p>View All <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ Countries</p>
                                    <span>Browse the complete, searchable country directory</span>
                                </div>
                                <a class="btn-small" href="country-list">Open country list &rarr;</a>
                            </div>
                        </section>

                        <section id="company">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Company &amp; Resources</h2></div>
                            <div class="policy-link-grid">
                                <div class="policy-link-col">
                                    <h3>Company</h3>
                                    <ul>
                                        <li><a href="about">About Us</a></li>
                                        <li><a href="careers">Careers</a></li>
                                        <li><a href="news">News &amp; Blog</a></li>
                                        <li><a href="contact">Contact Us</a></li>
                                    </ul>
                                </div>
                                <div class="policy-link-col">
                                    <h3>Resources</h3>
                                    <ul>
                                        <li><a href="news">Blog</a></li>
                                        <li><a href="news-grid">Visa Guides</a></li>
                                        <li><a href="/#checklist">Document Checklist</a></li>
                                        <li><a href="visa-refusal">Visa Refusal Guidance</a></li>
                                        <li><a href="/#faq">FAQs</a></li>
                                    </ul>
                                </div>
                            </div>
                        </section>

                        <section id="legal">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Legal</h2></div>
                            <div class="policy-link-grid">
                                <div class="policy-link-col">
                                    <ul>
                                        <li><a href="privacy-policy">Privacy Policy</a></li>
                                        <li><a href="terms-and-conditions">Terms &amp; Conditions</a></li>
                                        <li><a href="cookie-policy">Cookie Policy</a></li>
                                        <li><a href="disclaimer">Disclaimer</a></li>
                                        <li><a href="refund-policy">Refund Policy</a></li>
                                        <li><a href="data-security">Data Security</a></li>
                                    </ul>
                                </div>
                            </div>
                        </section>

                        <section id="xml">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>XML Sitemap</h2></div>
                            <p>This page is the human-readable index. Search engines use our machine-readable sitemap instead.</p>
                            <div class="policy-xml-card">
                                <div>
                                    <p>sitemap.xml</p>
                                    <span>Auto-generated index for search engine crawlers</span>
                                </div>
                                <a class="btn-small" href="sitemap.xml">Open sitemap.xml &rarr;</a>
                            </div>
                        </section>

                    </div>
                </div>
            </div>
        </section>

        <section class="final-cta section-padding fix">
            <div class="container text-center">
                <h2 class="mb-3">Can't Find What You're Looking For?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Our team can point you to the right page, or answer it directly.
                </p>
                <div class="cta-buttons d-flex flex-wrap justify-content-center gap-3">
                    <a href="contact" class="theme-btn">Start Your Visa Enquiry <i class="fa-solid fa-arrow-right"></i></a>
                    <a href="tel:+917844819819" class="theme-btn style-outline">Talk to a Visa Expert <i class="fa-solid fa-phone"></i></a>
                </div>
            </div>
        </section>

        <script>
        (function () {
            var links = Array.prototype.slice.call(document.querySelectorAll('#policyToc a'));
            var sections = links.map(function (l) { return document.querySelector(l.getAttribute('href')); }).filter(Boolean);
            if (!('IntersectionObserver' in window) || !sections.length) return;
            var map = {};
            sections.forEach(function (sec, i) { map[sec.id] = links[i]; });
            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    var link = map[entry.target.id];
                    if (!link) return;
                    if (entry.isIntersecting) {
                        links.forEach(function (l) { l.classList.remove('active'); });
                        link.classList.add('active');
                    }
                });
            }, { rootMargin: '-15% 0px -70% 0px', threshold: 0 });
            sections.forEach(function (sec) { observer.observe(sec); });
        })();
        </script>

<?php include __DIR__ . '/includes/footer.php'; ?>
