<?php
declare(strict_types=1);

/**
 * /terms/ — Terms & Conditions. Part of the Legal & Support Centre.
 * The visa-disclaimer wording here is deliberately identical to
 * includes/footer.php's own disclaimer bar, not a paraphrase — one
 * source of truth for "we don't guarantee visa approval," repeated
 * verbatim rather than risking a drift in meaning between the two.
 */


$pageTitle = 'Terms & Conditions | Visagiri';
$pageDescription = 'Clear terms for a transparent customer experience — the scope of Visagiri\'s visa, attestation, forex and travel-related services, and the terms under which we provide them.';
$canonicalUrl = APP_URL . '/terms/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Terms & Conditions', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$governingLaw = setting('legal_governing_law', '');
$jurisdictionCity = setting('legal_jurisdiction_city', '');

$sections = [
    'about' => 'About Visagiri',
    'service-scope' => 'Service Scope',
    'visa-disclaimer' => 'Visa Disclaimer',
    'customer-responsibilities' => 'Customer Responsibilities',
    'third-party-decisions' => 'Third-Party Decisions',
    'fees' => 'Fees',
    'changes-cancellations' => 'Changes & Cancellations',
    'liability' => 'Limitation of Liability',
    'intellectual-property' => 'Intellectual Property',
    'website-usage' => 'Website Usage',
];
if ($governingLaw !== '') {
    $sections['governing-law'] = 'Governing Law';
}
$sections['contact'] = 'Contact';

render_legal_hero(
    'terms',
    'Terms & Conditions',
    'Clear terms for a transparent customer experience.',
    'legal_terms_updated_at',
    $sections
);
?>
<section id="about">
    <h2>About Visagiri</h2>
    <p>Visagiri, a unit of <?= e(setting('company_parent', 'Tripgation Pvt Ltd')) ?>, is a visa consultancy and document-attestation business. We act as a consultancy and service facilitator — we help you understand requirements, prepare and submit applications, and coordinate with the relevant authorities and service providers on your behalf. We are not a government body, embassy, consulate or immigration authority, and we do not represent one.</p>
</section>

<section id="service-scope">
    <h2>Service Scope</h2>
    <p>Depending on what you engage us for, our services may include:</p>
    <ul>
        <li>Visa consultancy and application-management assistance (Tourist, Business, Student, Work, Family Visit, Dependent, Transit, Medical, Conference and Sports visas, and related visa categories)</li>
        <li>Document apostille and attestation assistance, including MEA, embassy/consular and commercial document services</li>
        <li>Forex and currency-exchange enquiry assistance</li>
        <li>Document preparation and checklist guidance</li>
        <li>General travel-document and itinerary-support enquiries connected to a visa or attestation service</li>
    </ul>
    <p>We only provide the services we actually advertise on this website. If you're unsure whether we offer a particular service, please ask us before proceeding.</p>
</section>

<section id="visa-disclaimer">
    <h2>Visa Disclaimer</h2>
    <p>Disclaimer: Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
    <p>Our role is to help you put forward the strongest possible application — accurate, complete, and correctly documented. The final decision, including any request for additional information or an interview, rests entirely with the relevant authority.</p>
</section>

<section id="customer-responsibilities">
    <h2>Customer Responsibilities</h2>
    <p>To help us help you, you agree to:</p>
    <ul>
        <li>Provide accurate and complete information on every form and application</li>
        <li>Submit genuine, unaltered documents</li>
        <li>Respond to our requests for information or documents in a timely manner</li>
        <li>Provide any documents we or the relevant authority request within the timelines given</li>
    </ul>
    <p>Delays, rejections or additional costs that result from inaccurate information, missing documents, or late responses are outside our control and outside our responsibility.</p>
</section>

<section id="third-party-decisions">
    <h2>Third-Party Decisions</h2>
    <p>Embassies, consulates, immigration authorities, airlines, hotels, insurers and other third-party providers we coordinate with operate under their own rules, timelines and fee structures, which are entirely outside our control. We will do our best to keep you informed of any third-party requirement or decision that affects your service, but we cannot be held responsible for a third party's decision, delay or policy change.</p>
</section>

<section id="fees">
    <h2>Fees</h2>
    <p>Our service fee is separate from any government, embassy or third-party fee (such as an appointment fee, courier charge, or supplier charge) that may apply to your request. See our <a href="/payment-policy/">Payment Policy</a> for how these are billed.</p>
</section>

<section id="changes-cancellations">
    <h2>Changes &amp; Cancellations</h2>
    <p>Changes and cancellations to a booked service are handled under our <a href="/payment-policy/">Payment Policy</a> and <a href="/refund-policy/">Refund &amp; Cancellation Policy</a>, and, where travel is involved, our <a href="/travel-terms/">Travel Terms</a>.</p>
</section>

<section id="liability">
    <h2>Limitation of Liability</h2>
    <p>We provide our services with reasonable care and skill, based on the information you give us and the requirements published by the relevant authority at the time. To the fullest extent permitted by law, Visagiri is not liable for losses arising from a third party's decision (including a visa refusal), from inaccurate or incomplete information you provide, or from circumstances outside our reasonable control. Nothing in these terms is intended to exclude any liability that cannot lawfully be excluded.</p>
</section>

<section id="intellectual-property">
    <h2>Intellectual Property</h2>
    <p>The Visagiri name, logo, and the content, design and code of this website are the property of <?= e(setting('company_parent', 'Tripgation Pvt Ltd')) ?> or its licensors, and may not be copied, reproduced or used without our prior written permission.</p>
</section>

<section id="website-usage">
    <h2>Website Usage</h2>
    <p>You agree to use this website only for its intended purpose — enquiring about and using our services — and not to misuse our forms, attempt to disrupt the website, or submit false or malicious information.</p>
</section>

<?php if ($governingLaw !== ''): ?>
<section id="governing-law">
    <h2>Governing Law</h2>
    <p><?= e($governingLaw) ?><?= $jurisdictionCity !== '' ? ' The courts of ' . e($jurisdictionCity) . ' shall have jurisdiction.' : '' ?></p>
</section>
<?php endif; ?>

<section id="contact">
    <h2>Contact</h2>
    <p>Questions about these terms? Contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
