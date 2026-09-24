<?php
declare(strict_types=1);

/**
 * Standalone B2B Partner page — same treatment as the rest of this
 * family (see pages/about.php's docblock), BUT unlike the purely
 * informational pages in that family, this one wraps a real, working
 * lead-capture form: CSRF, honeypot, rate limiting, a PDO insert into
 * partner_enquiries, notify_enquiry_channels(), and a reference-number
 * success state — all unchanged from the previous version of this
 * page. The uploaded redesign draft's own embedded comment said as
 * much ("WIRE THIS FORM to the existing partner-enquiry endpoint...
 * field names below are placeholders and must match the backend"),
 * so this is a restyle over the real backend, not a replacement of
 * it. Field names (company_name, contact_name, email, mobile,
 * business_type, message) and the PARTNER_BUSINESS_TYPES-driven
 * select are kept exactly as the backend expects, not the draft's
 * placeholder names/hardcoded option text. "Start Onboarding" still
 * links to the real 5-step wizard at /partner/register/.
 */

require __DIR__ . '/../includes/google-sheets.php';

$submitted = false;
$referenceNumber = null;
$errors = [];
$values = ['company_name' => '', 'contact_name' => '', 'email' => '', 'mobile' => '', 'business_type' => '', 'message' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/partners/');
    }

    $values['company_name'] = trim((string) ($_POST['company_name'] ?? ''));
    $values['contact_name'] = trim((string) ($_POST['contact_name'] ?? ''));
    $values['email'] = trim((string) ($_POST['email'] ?? ''));
    $values['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $values['business_type'] = trim((string) ($_POST['business_type'] ?? ''));
    $values['message'] = trim((string) ($_POST['message'] ?? ''));

    if (!rate_limit_check('partner-enquiry:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
    }
    if ($values['company_name'] === '') {
        $errors[] = 'Please enter your company or agency name.';
    }
    if ($values['contact_name'] === '') {
        $errors[] = 'Please enter your name.';
    }
    if (!is_valid_email($values['email'])) {
        $errors[] = 'Please enter a valid email address.';
    }
    if (!is_valid_mobile($values['mobile'])) {
        $errors[] = 'Please enter a valid mobile number.';
    }

    if (!$errors) {
        $submitted = true;
        try {
            for ($attempt = 0; $attempt < 2; $attempt++) {
                $referenceNumber = generate_reference_number('PENQ', 'partner_enquiries', 'reference_number');
                try {
                    db()->prepare(
                        'INSERT INTO partner_enquiries (reference_number, company_name, contact_name, email, mobile, business_type, message, ip_address)
                         VALUES (:ref, :company_name, :contact_name, :email, :mobile, :business_type, :message, :ip)'
                    )->execute([
                        'ref' => $referenceNumber,
                        'company_name' => $values['company_name'],
                        'contact_name' => $values['contact_name'],
                        'email' => $values['email'],
                        'mobile' => $values['mobile'],
                        'business_type' => $values['business_type'] !== '' ? $values['business_type'] : null,
                        'message' => $values['message'] !== '' ? $values['message'] : null,
                        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                    ]);
                    break;
                } catch (PDOException $e) {
                    if ($e->getCode() === '23000' && $attempt === 0) {
                        continue;
                    }
                    throw $e;
                }
            }

            notify_enquiry_channels([
                'reference_number' => $referenceNumber,
                'name' => $values['contact_name'],
                'email' => $values['email'],
                'phone' => $values['mobile'],
                'destination' => $values['company_name'] . (($values['business_type'] ?? '') !== '' ? ' (' . (PARTNER_BUSINESS_TYPES[$values['business_type']] ?? $values['business_type']) . ')' : ''),
                'message' => $values['message'] !== '' ? $values['message'] : 'B2B partner program enquiry — no additional message.',
                'submitted_at' => date('c'),
            ]);
        } catch (Throwable $e) {
            if (APP_DEBUG) {
                error_log('[partners.php] failed to save enquiry: ' . $e->getMessage());
            }
            $submitted = false;
            $errors[] = 'Something went wrong submitting your enquiry. Please try again, or reach us on WhatsApp.';
        }
    }
}

$contactEmail = setting('contact_email', 'info@visagiri.com');
$companyCin = setting('company_cin', 'U63030UP2020PTC128661');
$foundingYear = date('Y', strtotime((string) setting('company_founding_date', '2015-04')));
$whatsappHrefStart = whatsapp_enquiry_href("Hi Visagiri, I'd like to start my visa journey.");
$whatsappHrefPartner = whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about the B2B Partner Program.");

$canonicalUrl = APP_URL . '/partners/';
$ogImage = APP_URL . '/assets/images/og-image.png';
$orgId = APP_URL . '/#organization';
$websiteId = APP_URL . '/#website';

$jsonLd = [
    '@context' => 'https://schema.org',
    '@graph' => [
        [
            '@type' => 'WebSite',
            '@id' => $websiteId,
            'url' => APP_URL . '/',
            'name' => 'Visagiri',
            'publisher' => ['@id' => $orgId],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'Organization',
            '@id' => $orgId,
            'name' => 'Visagiri',
            'url' => APP_URL . '/',
            'logo' => APP_URL . '/assets/images/logo-horizontal.png',
            'description' => 'Visa consultancy, application-management assistance and document-attestation services for travellers, students, professionals and businesses.',
            'foundingDate' => setting('company_founding_date', '2015-04'),
            'parentOrganization' => ['@type' => 'Organization', 'name' => 'Tripgation Pvt Ltd'],
            'email' => $contactEmail,
            'contactPoint' => [
                '@type' => 'ContactPoint',
                'contactType' => 'customer support',
                'telephone' => '+91-' . setting('whatsapp_number', '917844819819'),
            ],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'sameAs' => [
                'https://www.facebook.com/Visagiri',
                'https://www.instagram.com/hi_visagiri/',
                'https://x.com/visagiri',
                'https://www.youtube.com/@visagiri',
            ],
        ],
        [
            '@type' => 'WebPage',
            '@id' => $canonicalUrl . '#webpage',
            'url' => $canonicalUrl,
            'name' => 'Visagiri B2B Partner Program for Travel Agents and Visa Consultants',
            'description' => 'Join the Visagiri B2B Partner Program: register your agency, complete legal verification and refer visa cases through a partner dashboard with tiered commissions.',
            'isPartOf' => ['@id' => $websiteId],
            'about' => ['@id' => $orgId],
            'breadcrumb' => ['@id' => $canonicalUrl . '#breadcrumb'],
            'inLanguage' => 'en-IN',
        ],
        [
            '@type' => 'BreadcrumbList',
            '@id' => $canonicalUrl . '#breadcrumb',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
                ['@type' => 'ListItem', 'position' => 2, 'name' => 'About', 'item' => APP_URL . '/about/'],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Become a partner', 'item' => $canonicalUrl],
            ],
        ],
        [
            '@type' => 'Service',
            '@id' => $canonicalUrl . '#service',
            'name' => 'Visagiri B2B Partner Program',
            'serviceType' => 'B2B visa referral partner program',
            'provider' => ['@id' => $orgId],
            'areaServed' => ['@type' => 'Country', 'name' => 'India'],
            'audience' => [
                '@type' => 'BusinessAudience',
                'audienceType' => 'Travel agencies, tour operators, visa consultants, corporate travel desks, immigration consultants, independent consultants and sub-agents',
            ],
            'url' => $canonicalUrl,
            'description' => 'Refer visa cases to a dedicated visa and attestation team, track each case in a partner dashboard, and earn tiered commissions.',
        ],
        [
            '@type' => 'FAQPage',
            '@id' => $canonicalUrl . '#faq',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'Who is this program for?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Travel agencies, tour operators, visa consultants, corporate travel desks, immigration consultants, freelance or independent consultants and sub-agents who regularly handle visa cases for their customers.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Is GST or PAN mandatory to start onboarding?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'No. You can begin registration without them, but a verified GSTIN or PAN is required before your account is approved for live referrals.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Which documents do I upload?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'PAN card, GST certificate, company registration certificate and trade licence, plus your IATA or TAFI certificate if applicable. You can also add office address proof, an authorised signatory ID and a company profile. Files can be PDF, JPG, PNG or DOC, up to 10 MB each.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'How are commissions calculated?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Every referred application carries a commission calculated against your partner tier. The rate is visible on your dashboard before you submit a case.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'When can I start referring cases?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'After you confirm your email and our team verifies your documents and approves your account. Referrals can start the same day.'],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Can my colleagues have their own logins?',
                    'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Yes. Once your business account is active, you can invite colleagues as team members with their own logins.'],
                ],
            ],
        ],
    ],
];
?>
<!DOCTYPE html>
<html lang="en-IN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Visagiri B2B Partner Program for Travel Agents and Visa Consultants</title>
<meta name="description" content="Join the Visagiri B2B Partner Program: register your agency, complete legal verification and refer visa cases through a partner dashboard with tiered commissions.">
<meta name="robots" content="index, follow">

<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Visagiri">
<meta property="og:locale" content="en_IN">
<meta property="og:title" content="Visagiri B2B Partner Program for Travel Agents and Visa Consultants">
<meta property="og:description" content="Join the Visagiri B2B Partner Program: register your agency, complete legal verification and refer visa cases through a partner dashboard with tiered commissions.">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600&family=Source+Serif+4:opsz,wght@8..60,500;8..60,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/assets/css/pages-standalone.css">
<link rel="stylesheet" href="/assets/css/company-page-kit.css">

<script type="application/ld+json"><?= json_encode($jsonLd, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT) ?></script>
</head>

<body>
<a class="skip" href="#main">Skip to content</a>

<header class="site-header">
  <div class="wrap bar">
    <a class="brand" href="/"><img src="/assets/images/logo-horizontal.png" alt="Visagiri" height="34"></a>
    <button class="menu-btn" type="button" aria-expanded="false" aria-controls="site-nav">Menu</button>
    <nav class="nav" id="site-nav" aria-label="Main">
      <ul>
        <li><a href="/visa-type/">Visa services</a></li>
        <li><a href="/attestation/">Attestation</a></li>
        <li><a href="/countries/">Countries</a></li>
        <li><a href="/forex/">Forex</a></li>
        <li><a href="/resources/">Resources</a></li>
        <li><a href="/about/" aria-current="page">Company</a></li>
      </ul>
      <a class="btn primary" href="/enquire/">Enquire now</a>
    </nav>
  </div>
</header>

<main id="main">

  <nav class="wrap crumbs" aria-label="Breadcrumb">
    <ol>
      <li><a href="/">Home</a></li><li><a href="/about/">About</a></li>
      <li aria-current="page">Become a partner</li>
    </ol>
  </nav>

  <section class="page-hero" aria-labelledby="h1">
    <div class="wrap">
      <h1 id="h1">Grow your travel business with the Visagiri partner program</h1>
      <p class="lede">If you run a travel agency, tour operation or independent consultancy and regularly handle visa cases, you can refer that work to a dedicated visa and attestation team and follow every step in your own partner dashboard.</p>
      <p style="max-width:62ch">Onboarding is a one-time process: register your business, complete a short legal verification with your registration documents and, once our team approves your account, start referring the same day.</p>
      <div class="actions">
        <a class="btn primary" href="/partner/register/">Start onboarding</a>
        <a class="btn ghost" href="#enquiry">Ask a question first</a>
      </div>
    </div>
  </section>

  <section class="section tint" id="who" aria-labelledby="who-h">
    <div class="wrap">
      <h2 id="who-h">Who the program is for</h2>
      <ul class="linklist">
        <?php foreach (['Travel agencies', 'Tour operators', 'Visa consultants', 'Corporate travel desks', 'Immigration consultants', 'Freelance or independent consultants', 'Sub-agents'] as $audience): ?>
        <li><span style="display:inline-block;padding:7px 12px;border:1px solid var(--line);border-radius:999px;background:var(--paper);font-size:.95rem"><?= e($audience) ?></span></li>
        <?php endforeach; ?>
      </ul>
    </div>
  </section>

  <section class="section" id="benefits" aria-labelledby="ben-h">
    <div class="wrap">
      <h2 id="ben-h">What the program includes</h2>
      <dl class="commit" style="margin-top:28px">
        <div><dt>Tiered commissions</dt><dd>Every referred application carries a commission calculated against your partner tier. Higher volume over time moves you to higher-rate tiers, and the rate is visible on your dashboard before you submit a case.</dd></div>
        <div><dt>Real-time case tracking</dt><dd>Every case you refer moves through the same status pipeline our consultants use: document verification, appointment booking, submission and decision. Each change shows on your dashboard as it happens.</dd></div>
        <div><dt>Wallet and invoicing</dt><dd>Approved commissions are credited to a wallet balance you can see at any time. Every partner invoice we raise for services on your behalf is itemised and downloadable.</dd></div>
        <div><dt>Team accounts</dt><dd>Once your business account is active, invite colleagues as team members with their own logins, so referrals and follow-ups do not depend on one person's inbox.</dd></div>
        <div><dt>Direct messaging</dt><dd>Every referred case has its own written message thread with our team, kept as a permanent record of what was agreed.</dd></div>
        <div><dt>Document management</dt><dd>Your business documents, such as GST certificate, PAN and IATA or TAFI membership, are uploaded once during onboarding and kept on file. Documents you exchange with us move through secure, audit-logged storage.</dd></div>
      </dl>
    </div>
  </section>

  <section class="section tint" id="verification" aria-labelledby="ver-h">
    <div class="wrap">
      <h2 id="ver-h">What onboarding checks</h2>
      <p class="lede" style="margin-bottom:32px">Referred cases involve real customers' passports, travel plans and payments, so we verify every partner's business identity before their account goes live.</p>
      <div class="reasons">
        <div class="reason">
          <h3>Business and legal details</h3>
          <div>
            <p>During registration you provide your business type, year established and website, plus your GST number (GSTIN) and PAN if your business is registered for either. If you are IATA or TAFI accredited, you can record your membership number too.</p>
            <p>None of these is mandatory to start, but a verified GSTIN or PAN is required before your account is approved for live referrals.</p>
          </div>
        </div>
        <div class="reason">
          <h3>Supporting documents</h3>
          <div>
            <p>A short upload step lets you attach the paperwork behind those details:</p>
            <ul class="checks">
              <li>PAN card, GST certificate, company registration certificate and trade licence</li>
              <li>IATA or TAFI certificate, if applicable</li>
              <li>Office address proof, authorised signatory ID and a company profile document</li>
            </ul>
            <p>Files can be PDF, JPG, PNG or DOC, up to 10 MB each.</p>
          </div>
        </div>
        <div class="reason">
          <h3>Terms acceptance</h3>
          <div><p>Before your registration is submitted for review, you read and accept the Partner Program terms covering commission structure, case-handling responsibilities and data-handling obligations for any customer information you pass to us.</p></div>
        </div>
        <div class="reason">
          <h3>Review and approval</h3>
          <div><p>Our partnerships team reviews your details and documents. You get an email when your account is approved, or if we need something clarified first, and your dashboard shows whether you are pending, need to send documents, or are active.</p></div>
        </div>
      </div>
    </div>
  </section>

  <section class="section" id="how" aria-labelledby="how-h">
    <div class="wrap">
      <h2 id="how-h">The onboarding path</h2>
      <ol class="steps" style="margin-top:28px">
        <li><div><h3>Business and legal info</h3><p>Tell us what kind of business you run, when it was established and, if applicable, your GST, PAN, IATA or TAFI details.</p></div></li>
        <li><div><h3>Contact and login</h3><p>Create your account with your work email, which becomes your login and where your verification link is sent, and a password.</p></div></li>
        <li><div><h3>Business profile</h3><p>Select the services you offer and the visa types you specialise in, and give us a rough sense of your monthly visa volume.</p></div></li>
        <li><div><h3>Document upload</h3><p>Attach your registration certificate, GST and PAN documents and any accreditation certificates you hold.</p></div></li>
        <li><div><h3>Terms acceptance</h3><p>Read and accept the Partner Program terms.</p></div></li>
        <li><div><h3>Verification and approval</h3><p>Confirm your email. Once our team verifies your documents, your account goes live, with your dashboard, referral tools, wallet and team accounts unlocked.</p></div></li>
      </ol>
      <p style="margin-top:32px"><a class="btn primary" href="/partner/register/">Start onboarding</a></p>
    </div>
  </section>

  <section class="section tint" id="faq" aria-labelledby="faq-h">
    <div class="wrap">
      <h2 id="faq-h">Frequently asked questions</h2>
      <div class="faq">
        <details>
          <summary>Who is this program for?</summary>
          <div><p>Travel agencies, tour operators, visa consultants, corporate travel desks, immigration consultants, freelance or independent consultants and sub-agents who regularly handle visa cases for their customers.</p></div>
        </details>
        <details>
          <summary>Is GST or PAN mandatory to start onboarding?</summary>
          <div><p>No. You can begin registration without them, but a verified GSTIN or PAN is required before your account is approved for live referrals.</p></div>
        </details>
        <details>
          <summary>Which documents do I upload?</summary>
          <div><p>PAN card, GST certificate, company registration certificate and trade licence, plus your IATA or TAFI certificate if applicable. You can also add office address proof, an authorised signatory ID and a company profile. Files can be PDF, JPG, PNG or DOC, up to 10 MB each.</p></div>
        </details>
        <details>
          <summary>How are commissions calculated?</summary>
          <div><p>Every referred application carries a commission calculated against your partner tier. The rate is visible on your dashboard before you submit a case.</p></div>
        </details>
        <details>
          <summary>When can I start referring cases?</summary>
          <div><p>After you confirm your email and our team verifies your documents and approves your account. Referrals can start the same day.</p></div>
        </details>
        <details>
          <summary>Can my colleagues have their own logins?</summary>
          <div><p>Yes. Once your business account is active, you can invite colleagues as team members with their own logins.</p></div>
        </details>
      </div>
    </div>
  </section>

  <section class="section" id="enquiry" aria-labelledby="enq-h">
    <div class="wrap">
      <h2 id="enq-h">Not ready to register yet?</h2>
      <p class="lede" style="margin-bottom:24px">Send a few details and the partnerships team will get in touch before you commit to anything.</p>

      <?php if ($submitted && $referenceNumber): ?>
      <div class="notice" role="status" style="max-width:640px">
        <h3>Thank you.</h3>
        <p>Your enquiry has been received — reference number <strong><?= e($referenceNumber) ?></strong>. Our partnerships team will get back to you soon.</p>
      </div>
      <?php else: ?>

      <?php foreach ($errors as $error): ?>
      <div class="notice" style="max-width:640px;border-color:#C4342F;background:#FCEAEA"><p><?= e($error) ?></p></div>
      <?php endforeach; ?>

      <form class="form" method="post" action="/partners/#enquiry" novalidate>
        <?= csrf_field() ?>
        <div class="hp" aria-hidden="true"><label for="website">Leave this field blank<input type="text" id="website" name="website" tabindex="-1" autocomplete="off"></label></div>
        <div class="form-row">
          <div><label for="company_name">Company or agency name</label><input id="company_name" name="company_name" value="<?= e($values['company_name']) ?>" required></div>
          <div><label for="contact_name">Your name</label><input id="contact_name" name="contact_name" value="<?= e($values['contact_name']) ?>" required autocomplete="name"></div>
        </div>
        <div class="form-row">
          <div><label for="email">Email address</label><input id="email" name="email" type="email" value="<?= e($values['email']) ?>" required autocomplete="email"></div>
          <div><label for="mobile">Mobile number</label><input id="mobile" name="mobile" type="tel" value="<?= e($values['mobile']) ?>" placeholder="e.g. +91 98765 43210" required autocomplete="tel"></div>
        </div>
        <div>
          <label for="business_type">Business type</label>
          <select id="business_type" name="business_type">
            <option value="">Select business type</option>
            <?php foreach (PARTNER_BUSINESS_TYPES as $key => $label): ?>
            <option value="<?= e($key) ?>"<?= $values['business_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
            <?php endforeach; ?>
          </select>
        </div>
        <div><label for="message">Message <span class="opt">(optional)</span></label><textarea id="message" name="message"><?= e($values['message']) ?></textarea></div>
        <div><button class="btn primary" type="submit">Submit enquiry</button></div>
      </form>
      <?php endif; ?>

      <p style="margin-top:20px">Already sure? <a href="/partner/register/">Start onboarding</a>, or <a href="<?= e($whatsappHrefPartner) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>.</p>
    </div>
  </section>

  <!-- CTA -->
  <section class="cta" aria-labelledby="cta-h">
    <div class="wrap">
      <div>
        <h2 id="cta-h">Ready to start your visa journey?</h2>
        <p>Tell us where you are travelling and why. A consultant will take it from there.</p>
      </div>
      <div class="actions">
        <a class="btn go" href="<?= e($whatsappHrefStart) ?>" target="_blank" rel="noopener noreferrer">Chat on WhatsApp</a>
        <a class="btn ghost" style="color:#fff;border-color:#fff" href="/enquire/">Send an enquiry</a>
      </div>
    </div>
  </section>
</main>

<footer class="site-footer">
  <div class="wrap">
    <div class="fgrid">
      <div class="fbrand">
        <img src="/assets/images/logo-horizontal-white.png" alt="Visagiri" height="32" loading="lazy">
        <p>Visa consultancy, application management and document attestation for travellers, professionals, families and businesses from India.</p>
        <div class="social">
          <a href="https://www.facebook.com/Visagiri" rel="noopener">Facebook</a>
          <a href="https://www.instagram.com/hi_visagiri/" rel="noopener">Instagram</a>
          <a href="https://x.com/visagiri" rel="noopener">X</a>
          <a href="https://www.youtube.com/@visagiri" rel="noopener">YouTube</a>
        </div>
      </div>
      <div>
        <h2>Visa services</h2>
        <ul>
          <li><a href="/visa-type/tourist/">Tourist visa</a></li>
          <li><a href="/visa-type/business/">Business visa</a></li>
          <li><a href="/visa-type/student/">Student visa</a></li>
          <li><a href="/visa-type/work/">Work visa</a></li>
          <li><a href="/visa-type/dependent/">Dependent visa</a></li>
          <li><a href="/visa-type/family/">Family visit visa</a></li>
          <li><a href="/visa-type/transit/">Transit visa</a></li>
          <li><a href="/visa-type/medical/">Medical visa</a></li>
          <li><a href="/visa-type/conference/">Conference visa</a></li>
          <li><a href="/visa-type/sports/">Sports visa</a></li>
        </ul>
      </div>
      <div>
        <h2>Attestation</h2>
        <ul>
          <li><a href="/attestation/mea-apostille/">MEA apostille</a></li>
          <li><a href="/attestation/mea-attestation/">MEA attestation</a></li>
          <li><a href="/attestation/embassy-attestation/">Embassy attestation</a></li>
          <li><a href="/attestation/educational-document-attestation/">Educational</a></li>
          <li><a href="/attestation/commercial-document-attestation/">Commercial</a></li>
          <li><a href="/attestation/document-legalization/">Document legalization</a></li>
          <li><a href="/attestation/">All attestation services</a></li>
        </ul>
      </div>
      <div>
        <h2>Offices</h2>
        <ul>
          <li><a href="/offices/patna/">Patna</a></li>
          <li><a href="/offices/ranchi/">Ranchi</a></li>
          <li><a href="/offices/raipur/">Raipur</a></li>
          <li><a href="/offices/bhopal/">Bhopal</a></li>
          <li><a href="/contact/">Contact us</a></li>
        </ul>
      </div>
      <div>
        <h2>Company</h2>
        <ul>
          <li><a href="/about/">About us</a></li>
          <li><a href="/why-visagiri/">Why Visagiri</a></li>
          <li><a href="/our-story/">Our story</a></li>
          <li><a href="/leadership/">Leadership</a></li>
          <li><a href="/our-team/">Our team</a></li>
          <li><a href="/careers/">Careers</a></li>
          <li><a href="/partners/">Become a partner</a></li>
          <li><a href="/affiliations/">Affiliations</a></li>
        </ul>
      </div>
    </div>

    <div class="legal">
      <ul>
        <li><a href="/countries/">Countries</a></li>
        <li><a href="/resources/">Resources</a></li>
        <li><a href="/forex/">Forex</a></li>
        <li><a href="/faq/">Visa FAQs</a></li>
        <li><a href="/track-visa/">Track application</a></li>
        <li><a href="/blog/">Visa updates</a></li>
        <li><a href="/login/">Customer login</a></li>
        <li><a href="/partner/login/">Partner login</a></li>
        <li><a href="/admin/login/">Employee login</a></li>
      </ul>
      <ul>
        <li><a href="/privacy/">Privacy policy</a></li>
        <li><a href="/terms/">Terms and conditions</a></li>
        <li><a href="/travel-terms/">Travel terms</a></li>
        <li><a href="/payment-policy/">Payment policy</a></li>
        <li><a href="/refund-policy/">Refund policy</a></li>
        <li><a href="/cookie-policy/">Cookie policy</a></li>
        <li><a href="/grievance/">Grievance redressal</a></li>
        <li><a href="/sitemap/">Sitemap</a></li>
      </ul>
      <p>Disclaimer: Visa decisions are made solely by the relevant embassy, consulate or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
      <p>&copy; <?= e(date('Y')) ?> Visagiri. Serving visa and travel-related requirements since April <?= e($foundingYear) ?>. CIN: <?= e($companyCin) ?>. All rights reserved.</p>
    </div>
  </div>
</footer>

<script src="/assets/js/pages-standalone.js"></script>
</body>
</html>
