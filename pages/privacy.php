<?php
declare(strict_types=1);

/**
 * /privacy/ — Privacy Policy. Part of the Legal & Support Centre
 * (includes/legal-layout.php). Content describes only what this
 * codebase actually does — real form fields, real third-party
 * touchpoints (Google Sheets/Drive bridge, embassies/consulates),
 * real security mechanisms (AES-256-GCM field encryption for PAN,
 * access-controlled off-web-root document storage, audit logging) —
 * see includes/encryption.php, includes/documents.php,
 * includes/audit.php, includes/google-sheets.php. Governing-law/
 * registered-office/grievance-officer facts this codebase cannot
 * verify are settings-backed and simply omitted when unset, never
 * fabricated or shown as a placeholder — see admin/pages/settings.php.
 */


$pageTitle = 'Privacy Policy | Visagiri';
$pageDescription = 'How Visagiri collects, uses, protects and manages customer information across our visa, attestation, forex and travel-related services.';
$canonicalUrl = APP_URL . '/privacy/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Privacy Policy', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$registeredAddress = setting('legal_registered_office_address', '');
$governingLaw = setting('legal_governing_law', '');

$sections = [
    'introduction' => 'Introduction',
    'information-we-collect' => 'Information We Collect',
    'how-we-use-information' => 'How We Use Information',
    'document-security' => 'Document Security',
    'data-sharing' => 'Data Sharing',
    'data-retention' => 'Data Retention',
    'your-rights' => 'Your Rights',
    'security' => 'Security',
];
if ($governingLaw !== '' || $registeredAddress !== '') {
    $sections['jurisdiction'] = 'Jurisdiction';
}
$sections['changes'] = 'Changes to This Policy';
$sections['contact'] = 'Contact';

render_legal_hero(
    'privacy',
    'Privacy Policy',
    'Your information, your trust, our responsibility.',
    'legal_privacy_updated_at',
    $sections
);
?>
<section id="introduction">
    <h2>Introduction</h2>
    <p>This Privacy Policy explains how Visagiri, a unit of <?= e(setting('company_parent', 'Tripgation Pvt Ltd')) ?>, collects, uses, shares and protects the personal information you provide when you use our visa consultancy, document attestation, forex assistance and related services, whether through this website, WhatsApp, email or phone.</p>
    <p>By submitting an enquiry or using our services, you agree to the collection and use of information as described in this policy.</p>
</section>

<section id="information-we-collect">
    <h2>Information We Collect</h2>
    <p>We collect only the information needed to respond to your enquiry or deliver the service you've requested. Depending on which service you use, this may include:</p>
    <ul>
        <li>Your name, email address and mobile number</li>
        <li>Travel details — destination country, visa type, purpose of travel and proposed travel dates</li>
        <li>Visa application information you provide through our enquiry, application or partner-referral forms</li>
        <li>Documents you or your referring partner upload in connection with a visa application, attestation request, or general enquiry — for example passport pages, certificates and supporting paperwork, where a service genuinely requires them</li>
        <li>Forex-related information you provide when raising a currency-exchange enquiry, including PAN details where a forex transaction requires it under applicable regulations</li>
        <li>Payment-related information necessary to process service fees (we do not store full card details — see <a href="/payment-policy/">Payment Policy</a>)</li>
        <li>The content of enquiries, messages and support communications you send us</li>
        <li>Basic technical information such as your IP address, submitted automatically when you use our forms, which we use for rate-limiting and fraud prevention</li>
    </ul>
    <p>We do not collect information we have no service reason to process, and we do not ask for sensitive personal data beyond what a specific visa, attestation, or forex service genuinely requires.</p>
</section>

<section id="how-we-use-information">
    <h2>How We Use Information</h2>
    <p>We use the information you provide to:</p>
    <ul>
        <li>Respond to and process visa enquiries and applications</li>
        <li>Assist with document attestation and apostille requests</li>
        <li>Handle forex and currency-exchange enquiries</li>
        <li>Provide customer support and respond to questions or grievances</li>
        <li>Communicate with you by email, WhatsApp or phone about the status of your enquiry, application or request</li>
        <li>Process payments for our services</li>
        <li>Detect and prevent fraud, spam and abuse of our public forms</li>
        <li>Improve our services and website</li>
        <li>Meet legal and regulatory obligations that apply to our business</li>
    </ul>
</section>

<section id="document-security">
    <h2>Document Security</h2>
    <p>Documents you upload — such as passport scans, certificates or supporting paperwork — are stored outside the public web root and are never reachable by a direct URL. Every document download is served through an authenticated staff-only pathway that checks the requesting staff member's permissions before the file is streamed, and each access is logged.</p>
    <p>Where a service requires storing a particularly sensitive field — for example, a PAN number for certain forex transactions — that field is encrypted at rest using industry-standard AES-256-GCM encryption rather than stored as plain text.</p>
</section>

<section id="data-sharing">
    <h2>Data Sharing</h2>
    <p>We do not sell your personal information. We may share the information you provide with:</p>
    <ul>
        <li>Embassies, consulates or immigration authorities, where necessary to process a visa application</li>
        <li>The Ministry of External Affairs or other bodies relevant to an apostille or attestation request</li>
        <li>Payment processors, solely to complete a transaction you've authorized</li>
        <li>A secondary internal record-keeping system (a Google Sheets/Drive bridge) our staff use to track and follow up on enquiries — this is an internal operational tool, not a public or third-party marketing service</li>
    </ul>
    <p>Visagiri is a private consultancy and is not affiliated with, and does not represent, any government, embassy or consular authority. We facilitate and assist with applications; decisions remain solely with the relevant authority.</p>
</section>

<section id="data-retention">
    <h2>Data Retention</h2>
    <p>We retain your information for as long as necessary to provide the service you requested, to maintain records for legitimate business and legal purposes, and to comply with applicable regulatory requirements. Retention periods can vary by service and document type; where a specific retention period applies to your service, our team can confirm it on request.</p>
</section>

<section id="your-rights">
    <h2>Your Rights</h2>
    <p>You may ask us to access, correct or delete the personal information we hold about you, subject to any legal or regulatory obligation that requires us to retain certain records. To make a request, contact us using the details below, or use our <a href="/grievance/">Grievance Redressal</a> process if your request relates to a concern about how your information was handled.</p>
</section>

<section id="security">
    <h2>Security</h2>
    <p>We apply reasonable technical and organizational safeguards to protect your information, including access-controlled document storage, encryption of particularly sensitive fields, and an internal audit trail that records who accessed or changed a record and when. No method of transmission or storage is completely secure, but we take these protections seriously across every service we offer.</p>
</section>

<?php if ($governingLaw !== '' || $registeredAddress !== ''): ?>
<section id="jurisdiction">
    <h2>Jurisdiction</h2>
    <?php if ($governingLaw !== ''): ?><p><?= e($governingLaw) ?></p><?php endif; ?>
    <?php if ($registeredAddress !== ''): ?><p>Registered office: <?= e($registeredAddress) ?></p><?php endif; ?>
</section>
<?php endif; ?>

<section id="changes">
    <h2>Changes to This Policy</h2>
    <p>We may update this Privacy Policy from time to time to reflect changes in our services or applicable requirements. The "Last updated" date at the top of this page shows when it was last revised.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>If you have questions about this Privacy Policy or how we handle your information, contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
