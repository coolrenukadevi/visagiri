<?php
$page_title = "Download Center &ndash; Checklists &amp; Letter Templates | Visa Agency";
$page_description = "Printable visa document checklist recap, cover letter template and NOC template &mdash; free to use and adapt for your application.";
$page_canonical = 'https://visaagency.in/downloads';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Download Center</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Download Center</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="service-section section-padding fix">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">Help</span>
                    <h2 class="split-text-right split-text-in-right">Templates You Can Print Or Save As PDF</h2>
                </div>
                <p class="text text-center mb-5" style="max-width:760px;margin-left:auto;margin-right:auto;">
                    Each template below is ready to use on-screen &mdash; click <strong>Print / Save as PDF</strong> on
                    any card to print it or save it as a PDF from your browser's print dialog. Adapt the bracketed
                    placeholders to your own details before submitting anything.
                </p>

                <div class="dl-template-card">
                    <div class="dl-template-head no-print">
                        <div><h3 style="margin:0;"><i class="fa-solid fa-clipboard-list" style="color:var(--va-royal);margin-right:8px;"></i>Visa Document Checklist</h3><p class="text" style="margin:4px 0 0;">A general starting checklist &mdash; for one tailored to your destination and category, use the interactive tool.</p></div>
                        <div style="display:flex;gap:10px;flex-wrap:wrap;">
                            <a href="visa-checklist" class="theme-btn style-2" style="white-space:nowrap;">Personalised Checklist Tool</a>
                            <button type="button" class="dl-print-btn" onclick="window.print()"><i class="fa-solid fa-print"></i> Print / Save as PDF</button>
                        </div>
                    </div>
                    <div class="dl-template-body">Passport (valid, with blank pages)
Recent passport-size photographs
Visa application form (completed &amp; signed)
Financial documents (bank statements, income proof)
Purpose-of-travel evidence (invitation, bookings, itinerary)
Travel/medical insurance, where required
Sponsorship documents, if applicable
Employment/business documents, if applicable
Previous visas/passports, if applicable
Visa fee payment receipt</div>
                </div>

                <div class="dl-template-card">
                    <div class="dl-template-head no-print">
                        <div><h3 style="margin:0;"><i class="fa-solid fa-file-signature" style="color:var(--va-royal);margin-right:8px;"></i>Cover Letter Template</h3><p class="text" style="margin:4px 0 0;">A general-purpose visa cover letter structure &mdash; fill in the bracketed placeholders.</p></div>
                        <button type="button" class="dl-print-btn" onclick="window.print()"><i class="fa-solid fa-print"></i> Print / Save as PDF</button>
                    </div>
                    <div class="dl-template-body">[Your Full Name]
[Your Address]
[Your Phone Number] | [Your Email]

[Date]

The Visa Officer
[Embassy / Consulate / Visa Application Centre Name]
[Address]

Subject: Cover Letter for [Visa Category] Visa Application

Dear Sir/Madam,

I, [Your Full Name], holder of Indian passport number [Passport Number], am submitting this application for a [Visa Category] visa to [Destination Country].

Purpose of Travel: [Briefly explain &mdash; tourism, business meeting, family visit, etc.]
Planned Travel Dates: [Start Date] to [End Date]
Duration of Stay: [Number] days

I am currently employed as [Job Title] at [Company Name], where I have worked since [Start Date]. [Or: I run [Business Name], a [type] business established in [Year].] I have enclosed my financial and employment documents in support of this application.

I confirm that I intend to return to India on or before [Return Date] and resume my [employment/business/studies].

I have enclosed all supporting documents as per the checklist provided. Please let me know if any further information is required.

Yours faithfully,
[Your Signature]
[Your Full Name]</div>
                </div>

                <div class="dl-template-card">
                    <div class="dl-template-head no-print">
                        <div><h3 style="margin:0;"><i class="fa-solid fa-building" style="color:var(--va-royal);margin-right:8px;"></i>No Objection Certificate (NOC) Template</h3><p class="text" style="margin:4px 0 0;">For an employer to confirm leave approval and continued employment.</p></div>
                        <button type="button" class="dl-print-btn" onclick="window.print()"><i class="fa-solid fa-print"></i> Print / Save as PDF</button>
                    </div>
                    <div class="dl-template-body">[Company Letterhead]

Date: [Date]

TO WHOM IT MAY CONCERN

Subject: No Objection Certificate for Visa Application

This is to certify that [Employee Full Name], holding designation [Job Title], has been employed with [Company Name] since [Joining Date].

We have no objection to [Mr./Ms.] [Employee Full Name] travelling to [Destination Country] from [Start Date] to [End Date] for the purpose of [tourism/business/conference, etc.].

[He/She] has been granted leave for this period and is expected to resume duties at [Company Name] on [Return-to-Work Date].

This certificate is issued at the request of the employee for visa application purposes.

For [Company Name]

[Authorised Signatory Name]
[Designation]
[Company Seal]
[Contact Number / Email]</div>
                </div>

                <div class="compliance-note mt-2">
                    These are general-purpose starting templates, not legal documents &mdash; always adapt them to
                    your specific situation and the exact format requested by your destination's embassy, consulate
                    or visa application centre.
                </div>

                <div class="text-center mt-5">
                    <a href="visa-guides" class="theme-btn style-2">More Visa Guides</a>
                    <a href="contact" class="theme-btn" data-open-enquiry>Get Help With Your Documents <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Download Center',
    'url' => $page_canonical,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => 'https://visaagency.in/resources'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Download Center', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
