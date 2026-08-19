<?php
$page_title = "Disclaimer &ndash; Visa Agency";
$page_description = "Important disclaimers about Visa Agency's independent status, visa outcomes, and the information published on visaagency.in.";
include __DIR__ . '/includes/header.php';

$disclaimer_toc = [
    ['id' => 'status', 'n' => '01', 'label' => 'Independent status'],
    ['id' => 'outcomes', 'n' => '02', 'label' => 'No guaranteed outcomes'],
    ['id' => 'content', 'n' => '03', 'label' => 'Website content accuracy'],
    ['id' => 'advice', 'n' => '04', 'label' => 'Not legal or immigration advice'],
    ['id' => 'third-party', 'n' => '05', 'label' => 'Third-party information'],
    ['id' => 'links', 'n' => '06', 'label' => 'External links'],
    ['id' => 'liability', 'n' => '07', 'label' => 'Limitation of liability'],
    ['id' => 'changes', 'n' => '08', 'label' => 'Changes to this notice'],
    ['id' => 'contact', 'n' => '09', 'label' => 'Contact us'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Disclaimer</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Disclaimer</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Effective Date</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Last Reviewed</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Applies To</span><span class="value">visaagency.in &amp; our services</span></div>
                    <div><span class="label">Status</span><span class="value">Independent Consultancy</span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Disclaimer sections">
                        <p class="policy-index-title">In This Notice</p>
                        <ol id="policyToc">
                            <?php foreach ($disclaimer_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="status">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>Independent Status</h2></div>
                            <div class="compliance-note policy-note-warn">VisaAgency.in is an independent visa consultancy and management service, operated by Tripgation Private Limited. We are not a government body and are not affiliated with, endorsed by, or acting as an agent of any embassy, consulate, high commission or immigration authority, unless a specific service page expressly states otherwise.</div>
                            <p>References on our website to "Ministry of Tourism recognised" describe a recognition of our business as a tour and travel-related consultancy, and do not imply any government affiliation with, or endorsement of, our visa advisory services specifically.</p>
                        </section>

                        <section id="outcomes">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>No Guaranteed Outcomes</h2></div>
                            <p>Visa approval, refusal, processing time, and any conditions attached to entry are determined solely by the relevant embassy, consulate or immigration authority, based on their own criteria and discretion. Nothing on visaagency.in, in our marketing material, or in communication from our team constitutes a promise or guarantee that any visa, apostille or attestation application will be approved.</p>
                            <p>Processing timelines quoted on our site or by our team are estimates based on published authority timelines and past experience, and may change without notice due to factors outside our control.</p>
                        </section>

                        <section id="content">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>Website Content Accuracy</h2></div>
                            <p>We aim to keep country guides, checklists, fee information and visa requirements on visaagency.in accurate and current, but immigration rules, fees and documentation requirements change frequently and sometimes without prior notice from the issuing authority. Content on our site is provided for general informational purposes and should be verified against the official embassy, consulate or government source before you rely on it for travel planning or an application.</p>
                        </section>

                        <section id="advice">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Not Legal or Immigration Advice</h2></div>
                            <p>Our guidance is intended to help you prepare and submit a complete application; it does not constitute legal advice, immigration law advice, or a legal opinion on your circumstances. If your situation involves legal complexity &mdash; such as a prior visa refusal, overstay, criminal record, or complex immigration history &mdash; we recommend consulting a licensed immigration lawyer qualified in the relevant jurisdiction in addition to using our consultancy services.</p>
                        </section>

                        <section id="third-party">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Third-Party Information</h2></div>
                            <p>Where our website or team references information from embassies, consulates, airlines, insurers or other third parties, we do so in good faith based on the most recent information available to us. We are not responsible for errors, omissions or changes in third-party information that are outside our knowledge or control at the time it was shared with you.</p>
                        </section>

                        <section id="links">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>External Links</h2></div>
                            <p>Our website may link to external sites, including official embassy portals and appointment systems, for your convenience. We do not control and are not responsible for the content, accuracy or availability of external sites, and linking to them does not imply our endorsement.</p>
                        </section>

                        <section id="liability">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Limitation of Liability</h2></div>
                            <p>To the fullest extent permitted by law, Visa Agency and Tripgation Private Limited disclaim liability for any loss or damage arising from reliance on information published on visaagency.in, or from decisions made by an embassy, consulate or immigration authority. This disclaimer should be read together with the Limitation of Liability clause in our <a href="terms-and-conditions">Terms &amp; Conditions</a>, which governs services you have formally engaged us for.</p>
                        </section>

                        <section id="changes">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Changes to This Notice</h2></div>
                            <p>We may update this Disclaimer from time to time to reflect changes in our services or the information we publish. The "Last Reviewed" date at the top of this page shows when it was most recently updated.</p>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Contact Us</h2></div>
                            <p>If anything on our website is unclear, or you believe published information is out of date, please let us know:</p>
                            <div class="grievance-card">
                                <h3>Visa Agency &mdash; Client Support</h3>
                                <p>A unit of Tripgation Private Limited</p>
                                <div class="grievance-grid">
                                    <div><span class="label">Office</span><span class="value">#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020</span></div>
                                    <div><span class="label">Email</span><span class="value"><a href="mailto:info@visaagency.in">info@visaagency.in</a></span></div>
                                    <div><span class="label">Phone</span><span class="value"><a href="tel:+917844819819">+91 78448 19819</a></span></div>
                                    <div><span class="label">Hours</span><span class="value">Monday &ndash; Friday, 9:00 AM &ndash; 5:00 PM</span></div>
                                </div>
                            </div>
                        </section>

                    </div>
                </div>
            </div>
        </section>

        <section class="final-cta section-padding fix">
            <div class="container text-center">
                <h2 class="mb-3">Want the Current Requirements Confirmed?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Talk to our team before you plan around any figure or timeline you've read online.
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
