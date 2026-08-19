<?php
$page_title = "Terms &amp; Conditions &ndash; Visa Agency";
$page_description = "The terms that govern your use of visaagency.in and our visa consultancy, documentation and travel-assistance services.";
include __DIR__ . '/includes/header.php';

$terms_toc = [
    ['id' => 'acceptance', 'n' => '01', 'label' => 'Acceptance of terms'],
    ['id' => 'services', 'n' => '02', 'label' => 'Our services'],
    ['id' => 'no-guarantee', 'n' => '03', 'label' => 'No guarantee of approval'],
    ['id' => 'obligations', 'n' => '04', 'label' => 'Your obligations'],
    ['id' => 'fees', 'n' => '05', 'label' => 'Fees & payment'],
    ['id' => 'cancellation', 'n' => '06', 'label' => 'Cancellation & refunds'],
    ['id' => 'third-party', 'n' => '07', 'label' => 'Third-party services'],
    ['id' => 'liability', 'n' => '08', 'label' => 'Limitation of liability'],
    ['id' => 'ip', 'n' => '09', 'label' => 'Intellectual property'],
    ['id' => 'website-use', 'n' => '10', 'label' => 'Website use'],
    ['id' => 'termination', 'n' => '11', 'label' => 'Suspension & termination'],
    ['id' => 'governing-law', 'n' => '12', 'label' => 'Governing law & disputes'],
    ['id' => 'amendments', 'n' => '13', 'label' => 'Amendments'],
    ['id' => 'contact', 'n' => '14', 'label' => 'Contact us'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Terms &amp; Conditions</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Terms &amp; Conditions</li>
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
                    <div><span class="label">Governing Law</span><span class="value">Courts of Patna, Bihar</span></div>
                </div>

                <div class="policy-layout">
                    <aside class="policy-index-rail" aria-label="Terms sections">
                        <p class="policy-index-title">In This Agreement</p>
                        <ol id="policyToc">
                            <?php foreach ($terms_toc as $t): ?>
                            <li><a href="#<?php echo $t['id']; ?>"><span class="n"><?php echo $t['n']; ?></span><?php echo $t['label']; ?></a></li>
                            <?php endforeach; ?>
                        </ol>
                    </aside>

                    <div class="policy-content">

                        <section id="acceptance">
                            <div class="clause-head"><span class="clause-num">&sect;01</span><h2>Acceptance of Terms</h2></div>
                            <p>These Terms &amp; Conditions ("Terms") govern your access to visaagency.in and your engagement of any service offered by Visa Agency, a unit of Tripgation Private Limited ("Visa Agency", "we", "us"). By browsing our website, submitting an enquiry, booking an appointment or engaging us for any service, you agree to be bound by these Terms.</p>
                            <p>If you are engaging our services on behalf of another person &mdash; such as a family member, employee or client &mdash; you confirm you are authorised to accept these Terms on their behalf and to share their personal information with us for that purpose.</p>
                        </section>

                        <section id="services">
                            <div class="clause-head"><span class="clause-num">&sect;02</span><h2>Our Services</h2></div>
                            <p>Visa Agency is a visa consultancy and documentation-assistance provider. Depending on what you book, our services may include:</p>
                            <ul class="policy-list">
                                <li>Visa eligibility assessment, application preparation and documentation guidance for tourist, business, work, family, transit and other visa categories.</li>
                                <li>Appointment booking and interview-preparation assistance.</li>
                                <li>Apostille, embassy attestation, certificate attestation, document legalisation and translation services.</li>
                                <li>Travel insurance and forex assistance, flight and hotel reservation support, and airport meet-and-assist arrangements.</li>
                                <li>Corporate visa assistance for employers arranging travel for staff.</li>
                            </ul>
                            <p>We act as a facilitator and consultant. We do not represent, and are not affiliated with, any government, embassy or consulate unless expressly stated for a specific service.</p>
                        </section>

                        <section id="no-guarantee">
                            <div class="clause-head"><span class="clause-num">&sect;03</span><h2>No Guarantee of Approval</h2></div>
                            <div class="compliance-note policy-note-warn">Visa approval, rejection, processing time and conditions of entry are decided solely by the relevant embassy, consulate or immigration authority. Visa Agency does not guarantee approval of any visa, apostille or attestation application, regardless of the service level chosen.</div>
                            <p>Our role is to help you prepare a complete and accurate application based on the information and documents you provide, and current published requirements at the time of filing. Requirements, fees and processing times set by immigration authorities may change without notice, and we are not liable for delays, rejections or additional requirements arising from such changes.</p>
                        </section>

                        <section id="obligations">
                            <div class="clause-head"><span class="clause-num">&sect;04</span><h2>Your Obligations</h2></div>
                            <p>When you engage our services, you agree to:</p>
                            <ol class="policy-list legal-list">
                                <li>Provide true, accurate and complete information and documents, and promptly inform us of any changes.</li>
                                <li>Ensure you hold the legal right to submit any document you provide to us, including documents belonging to family members or dependants included in your application.</li>
                                <li>Attend scheduled appointments, biometric sessions or interviews on time, and carry original documents where required.</li>
                                <li>Make payments for fees, government charges and third-party costs (such as embassy fees, courier or insurance premiums) as agreed, in addition to our consultancy fee.</li>
                                <li>Review application forms and documents prepared on your behalf before submission, since you remain responsible for their accuracy once filed with the authority.</li>
                            </ol>
                            <p>We are not responsible for consequences arising from incomplete, false or misleading information or documents supplied by you or on your behalf.</p>
                        </section>

                        <section id="fees">
                            <div class="clause-head"><span class="clause-num">&sect;05</span><h2>Fees &amp; Payment</h2></div>
                            <p>Our consultancy fees are separate from, and in addition to, statutory embassy or government fees, courier charges, translation costs, insurance premiums and any other third-party charges applicable to your application. Applicable fees will be communicated to you before you confirm a service.</p>
                            <div class="policy-table-wrap">
                                <table class="policy-table">
                                    <thead><tr><th>Fee Type</th><th>Who It Is Payable To</th></tr></thead>
                                    <tbody>
                                        <tr><td>Consultancy / service fee</td><td>Visa Agency, for documentation, guidance and filing assistance</td></tr>
                                        <tr><td>Embassy / consulate / visa fee</td><td>The relevant government or immigration authority</td></tr>
                                        <tr><td>Apostille / attestation fee</td><td>The relevant issuing or attesting authority</td></tr>
                                        <tr><td>Courier, insurance, forex charges</td><td>The respective third-party service provider</td></tr>
                                    </tbody>
                                </table>
                            </div>
                            <p>Consultancy fees are generally non-refundable once work on your application has commenced, except as set out in Section 06.</p>
                        </section>

                        <section id="cancellation">
                            <div class="clause-head"><span class="clause-num">&sect;06</span><h2>Cancellation &amp; Refunds</h2></div>
                            <p>You may request cancellation of a service before we begin substantive work on your file, subject to any non-refundable third-party charges already incurred (such as embassy fees already paid or documents already couriered). Once an application has been filed with an embassy, consulate or attesting authority, government and third-party fees are non-refundable, as they are outside our control.</p>
                            <p>Our detailed Refund Policy sets out applicable timelines and any processing charges for cancellations, and forms part of these Terms by reference.</p>
                        </section>

                        <section id="third-party">
                            <div class="clause-head"><span class="clause-num">&sect;07</span><h2>Third-Party Services</h2></div>
                            <p>Where we facilitate services provided by third parties &mdash; embassies, visa application centres, courier companies, insurance providers, forex partners, airlines or hotels &mdash; those services are subject to the third party's own terms, conditions and policies. Visa Agency is not liable for acts, omissions, delays or losses caused by third parties, though we will assist you in raising and following up on any issue that arises.</p>
                        </section>

                        <section id="liability">
                            <div class="clause-head"><span class="clause-num">&sect;08</span><h2>Limitation of Liability</h2></div>
                            <p>To the maximum extent permitted by law, Visa Agency's liability for any claim arising from our services is limited to the consultancy fee paid by you for the specific service giving rise to the claim. We are not liable for indirect, incidental or consequential losses, including but not limited to lost travel bookings, missed events, or lost income, arising from visa refusal, processing delays, or third-party service failures.</p>
                            <p>Nothing in these Terms excludes liability that cannot be excluded under applicable Indian law.</p>
                        </section>

                        <section id="ip">
                            <div class="clause-head"><span class="clause-num">&sect;09</span><h2>Intellectual Property</h2></div>
                            <p>All content on visaagency.in &mdash; including text, graphics, logos, checklists and guides &mdash; is owned by or licensed to Visa Agency / Tripgation Private Limited and is protected by applicable intellectual property laws. You may view and use this content for personal, non-commercial reference in connection with your own application, but may not reproduce, redistribute or use it commercially without our prior written consent.</p>
                        </section>

                        <section id="website-use">
                            <div class="clause-head"><span class="clause-num">&sect;10</span><h2>Website Use</h2></div>
                            <p>You agree not to misuse visaagency.in, including by attempting unauthorised access to our systems, submitting false information through our forms, or using the site in a way that could disable, overburden or impair it. We may suspend access to any part of the site to protect its security or integrity.</p>
                        </section>

                        <section id="termination">
                            <div class="clause-head"><span class="clause-num">&sect;11</span><h2>Suspension &amp; Termination</h2></div>
                            <p>We may decline, suspend or discontinue a service if we reasonably believe information provided is false, a request is unlawful, fees remain unpaid, or continuing would breach these Terms or applicable law. Where we discontinue a service already in progress for such reasons, we will inform you of the status of your application and any fees that remain payable or refundable under Section 06.</p>
                        </section>

                        <section id="governing-law">
                            <div class="clause-head"><span class="clause-num">&sect;12</span><h2>Governing Law &amp; Disputes</h2></div>
                            <p>These Terms are governed by the laws of India. Subject to any mandatory consumer-protection forum you are entitled to approach, the courts at Patna, Bihar shall have exclusive jurisdiction over any dispute arising out of or relating to these Terms or our services. We encourage you to first raise any concern with our Grievance Officer (Section 14) so we can try to resolve it directly.</p>
                        </section>

                        <section id="amendments">
                            <div class="clause-head"><span class="clause-num">&sect;13</span><h2>Amendments</h2></div>
                            <p>We may update these Terms from time to time to reflect changes in our services, fees or legal requirements. The "Last Reviewed" date at the top of this page shows when it was most recently updated. Continued use of our website or services after an update constitutes acceptance of the revised Terms.</p>
                        </section>

                        <section id="contact">
                            <div class="clause-head"><span class="clause-num">&sect;14</span><h2>Contact Us</h2></div>
                            <p>For questions about these Terms, or any service you have booked with us, please reach out:</p>
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
                <h2 class="mb-3">Ready to Start Your Application?</h2>
                <p class="mb-4" style="max-width:640px;margin-left:auto;margin-right:auto;">
                    Our team will walk you through the process, fees and required documents before you commit.
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
