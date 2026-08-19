<?php
$page_title = "Privacy Policy &ndash; Visa Agency";
$page_description = "How Visa Agency collects, uses, shares and protects your personal information when you use our visa consultancy services.";
include __DIR__ . '/includes/header.php';

$policy_toc = [
    ['id' => 'overview', 'n' => '01', 'label' => 'Overview'],
    ['id' => 'collect', 'n' => '02', 'label' => 'Information we collect'],
    ['id' => 'how-collect', 'n' => '03', 'label' => 'How we collect it'],
    ['id' => 'use', 'n' => '04', 'label' => 'How we use it'],
    ['id' => 'share', 'n' => '05', 'label' => 'Sharing & disclosure'],
    ['id' => 'retention', 'n' => '06', 'label' => 'Data retention'],
    ['id' => 'cookies', 'n' => '07', 'label' => 'Cookies & tracking'],
    ['id' => 'security', 'n' => '08', 'label' => 'Data security'],
    ['id' => 'rights', 'n' => '09', 'label' => 'Your rights'],
    ['id' => 'children', 'n' => '10', 'label' => "Children's privacy"],
    ['id' => 'links', 'n' => '11', 'label' => 'Third-party links'],
    ['id' => 'changes', 'n' => '12', 'label' => 'Changes to this policy'],
    ['id' => 'contact', 'n' => '13', 'label' => 'Grievance officer'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Privacy Policy</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Privacy Policy</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="policy-meta-strip">
                    <div><span class="label">Effective Date</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Last Reviewed</span><span class="value">19 August 2026</span></div>
                    <div><span class="label">Applies To</span><span class="value">visaagency.in &amp; our office</span></div>
                    <div><span class="label">Jurisdiction</span><span class="value">Patna, Bihar, India</span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Policy sections">
                        <p class="policy-index-title">In This Policy</p>
                        <ol id="policyToc">
                            <?php foreach ($policy_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="overview">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>Overview</h2></div>
                            <p>Visa Agency ("Visa Agency", "we", "us") is a Ministry of Tourism&ndash;recognised visa consultancy operating as a unit of Tripgation Private Limited, based in Patna, Bihar. We help travellers, professionals, families and businesses navigate visa applications, documentation, appointments and related travel formalities.</p>
                            <p>This policy explains what personal information we collect through visaagency.in, our office, phone, WhatsApp and email; why we collect it; who we share it with; and the choices and rights available to you. By submitting an enquiry, booking an appointment or engaging our services, you agree to the practices described here.</p>
                            <div class="compliance-note">We are an independent visa consultancy and are not affiliated with any government, embassy or consulate unless expressly stated. Final visa decisions rest solely with the relevant immigration authority.</div>
                        </section>

                        <section id="collect">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Information We Collect</h2></div>
                            <p>The information we collect depends on the service you request. It typically falls into the following categories:</p>
                            <div class="policy-table-wrap">
                                <table class="policy-table">
                                    <thead><tr><th>Category</th><th>Examples</th></tr></thead>
                                    <tbody>
                                        <tr><td>Identity &amp; contact details</td><td>Full name, date of birth, address, phone number, email, WhatsApp number</td></tr>
                                        <tr><td>Travel &amp; visa documentation</td><td>Passport details, photographs, visa application forms, itineraries, invitation or sponsorship letters</td></tr>
                                        <tr><td>Supporting documents</td><td>Bank statements, employment or business proof, educational certificates, marriage or family certificates submitted for apostille, attestation or visa filing</td></tr>
                                        <tr><td>Payment information</td><td>Billing details and transaction records for consultancy fees, forex or insurance assistance (card numbers are handled by our payment partners, not stored by us)</td></tr>
                                        <tr><td>Enquiry &amp; communication data</td><td>Messages sent through our contact form, appointment preferences</td></tr>
                                        <tr><td>Technical data</td><td>IP address, browser type, device information and pages visited on visaagency.in</td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <p>Please avoid sending highly sensitive information (such as full financial account numbers) over unsecured channels like email where a secure upload option is available.</p>
                        </section>

                        <section id="how-collect">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>How We Collect It</h2></div>
                            <ul class="policy-list">
                                <li>Directly from you &mdash; via our enquiry and appointment forms, in-office visits, phone calls and WhatsApp conversations.</li>
                                <li>Through document submission &mdash; when you upload or hand over documents for visa filing, apostille or attestation.</li>
                                <li>Automatically &mdash; through cookies and similar technologies when you browse visaagency.in (see Cookies &amp; Tracking below).</li>
                                <li>From authorised representatives &mdash; such as a family member, employer or travel agent submitting an application on your behalf, where consent to do so has been confirmed.</li>
                            </ul>
                        </section>

                        <section id="use">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>How We Use It</h2></div>
                            <ul class="policy-list">
                                <li>To assess visa eligibility, prepare and file applications, and track their progress with embassies and consulates.</li>
                                <li>To schedule and manage visa appointments, interviews and document verification.</li>
                                <li>To provide apostille, attestation, translation, forex, travel insurance and related assistance you request.</li>
                                <li>To communicate with you about your application status, required documents, and appointment or payment reminders.</li>
                                <li>To process payments and maintain records required for accounting, tax and audit purposes.</li>
                                <li>To improve our services, website and customer support.</li>
                                <li>To comply with legal, regulatory and immigration-authority requirements applicable to our consultancy.</li>
                            </ul>
                            <p>We do not use your passport, financial or identity documents for any purpose beyond the service you have engaged us for, and we do not sell your personal information.</p>
                        </section>

                        <section id="share">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Sharing &amp; Disclosure</h2></div>
                            <p>We share personal information only where necessary to deliver the service you have requested, including with:</p>
                            <ul class="policy-list">
                                <li><strong>Embassies, consulates and visa application centres</strong> &mdash; to submit and process your visa application, as required by the destination country's immigration authority.</li>
                                <li><strong>Government or attestation bodies</strong> &mdash; such as the Ministry of External Affairs or issuing authorities, for apostille, legalisation or document verification.</li>
                                <li><strong>Service partners</strong> &mdash; courier companies, forex partners, travel insurance providers and airline/hotel booking partners, solely to fulfil the specific assistance you request.</li>
                                <li><strong>Payment processors</strong> &mdash; to securely process consultancy fees and related payments.</li>
                                <li><strong>Professional advisors and authorities</strong> &mdash; where disclosure is required by law, court order, or to protect the rights, property or safety of Visa Agency, our customers or others.</li>
                            </ul>
                            <p>We do not share your information with third parties for their own independent marketing purposes.</p>
                        </section>

                        <section id="retention">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Data Retention</h2></div>
                            <p>We retain personal information for as long as needed to provide the service, satisfy the purpose it was collected for, and meet our legal, accounting and immigration-record-keeping obligations. Retention periods vary by document type and service &mdash; for example, application files are typically retained for a defined period after case closure to handle follow-up queries, refusals or reapplications, after which they are securely deleted or anonymised.</p>
                        </section>

                        <section id="cookies">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Cookies &amp; Tracking</h2></div>
                            <p>visaagency.in uses cookies and similar technologies to keep the site working correctly, remember your preferences, and understand how visitors use our services so we can improve them.</p>
                            <h4>Types of cookies we use</h4>
                            <ul class="policy-list">
                                <li><strong>Essential cookies</strong> &mdash; required for core site functionality such as forms and secure browsing.</li>
                                <li><strong>Analytics cookies</strong> &mdash; help us understand site usage in aggregate, so we can improve navigation and content.</li>
                                <li><strong>Preference cookies</strong> &mdash; remember settings such as previously viewed country pages.</li>
                            </ul>
                            <p>You can control or disable cookies through your browser settings. Disabling essential cookies may affect the functionality of forms and appointment tools on our site.</p>
                        </section>

                        <section id="security">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Data Security</h2></div>
                            <p>We apply administrative, technical and physical safeguards appropriate to the sensitivity of the information we hold, including restricted access to case files, secure storage of physical documents at our Patna office, and access controls on our digital systems.</p>
                            <p>No method of transmission or storage is completely secure. While we work to protect your information, we cannot guarantee absolute security, and we encourage you to safeguard any login credentials and avoid sharing sensitive documents over unverified channels.</p>
                        </section>

                        <section id="rights">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Your Rights</h2></div>
                            <p>As a data principal under India's Digital Personal Data Protection Act, 2023, you may, subject to applicable exceptions, request to:</p>
                            <ul class="policy-list">
                                <li>Access a summary of the personal information we hold about you.</li>
                                <li>Correct or update inaccurate or incomplete information.</li>
                                <li>Withdraw consent for processing that was based on your consent, where this does not affect an application already in progress.</li>
                                <li>Request erasure of information we are no longer required to retain.</li>
                                <li>Nominate another individual to exercise these rights on your behalf in the event of death or incapacity.</li>
                                <li>Lodge a grievance with our Grievance Officer, and subsequently with the Data Protection Board of India if unresolved.</li>
                            </ul>
                            <p>To exercise any of these rights, contact our Grievance Officer using the details in Section 13.</p>
                        </section>

                        <section id="children">
                            <div class="clause-head"><span class="clause-num">&sect;10</span><h2>Children's Privacy</h2></div>
                            <p>Our services are intended for use by adults engaging visa and travel assistance, including on behalf of minors as part of a family or dependent visa application. Where a minor's information is submitted, we treat it as part of the parent or guardian's application and process it only for that purpose, with the parent or guardian's consent.</p>
                        </section>

                        <section id="links">
                            <div class="clause-head"><span class="clause-num">&sect;11</span><h2>Third-Party Links</h2></div>
                            <p>Our website may link to embassy portals, appointment systems, payment gateways or partner websites. We are not responsible for the privacy practices of these third-party sites, and we encourage you to review their policies before sharing information with them.</p>
                        </section>

                        <section id="changes">
                            <div class="clause-head"><span class="clause-num">&sect;12</span><h2>Changes to This Policy</h2></div>
                            <p>We may update this Privacy Policy from time to time to reflect changes in our practices, services or legal requirements. The "Last Reviewed" date at the top of this page indicates when it was most recently updated. Material changes will be reflected on this page; where required, we will notify you through the contact details you have provided.</p>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;13</span><h2>Grievance Officer</h2></div>
                            <p>For any questions, concerns or complaints about this Privacy Policy or how your information has been handled, please reach our Grievance Officer:</p>
                            <div class="grievance-card">
                                <h3>Grievance &amp; Privacy Contact</h3>
                                <p>Visa Agency &mdash; a unit of Tripgation Private Limited</p>
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
                <h2 class="mb-3">Have a Question About Your Data?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Our team can walk you through how your documents are handled during your visa process.
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
