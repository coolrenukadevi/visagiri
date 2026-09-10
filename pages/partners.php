<?php
declare(strict_types=1);

/**
 * Public B2B Partner Onboarding page — the canonical marketing + lead
 * capture front door for the referral system built in Phases 1-8
 * (partner/pages/register-*.php, admin/pages/partners.php and
 * friends). Previously a bare render_scaffold_page() stub; this
 * replaces /partner-program/'s role entirely (that URL now redirects
 * here — see pages/partner-program.php) rather than existing
 * alongside it as a near-duplicate second landing page.
 *
 * Two paths from here: "Register Now" straight into the real 5-step
 * wizard, or this page's own enquiry form for a prospect not ready to
 * commit yet, captured into partner_enquiries for staff follow-up —
 * same "public form -> staff follow-up" shape as pages/enquire.php.
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

$pageTitle = 'Become a Visa Partner - B2B Partner Onboarding | Visagiri';
$pageDescription = 'Join the Visagiri B2B Partner Program: register your agency, complete legal verification with GST/PAN/IATA details and document upload, and start referring visa customers through a dedicated partner dashboard with tiered commissions.';
$canonicalUrl = APP_URL . '/partners/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Become a Partner', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px;text-align:center">
        <span class="section-eyebrow">B2B Partner Onboarding</span>
        <h1>Grow Your Travel Business With Visagiri</h1>
        <p>If you run a travel agency, tour operation, or independent consultancy and regularly handle visa cases for your customers, the Visagiri Partner Program lets you refer that work to a dedicated visa and attestation team while staying visible in every step of it. Every application you send us is tracked from submission to decision inside your own partner dashboard, every commission is calculated automatically against your tier, and every document you exchange with us — theirs or yours — moves through the same secure, audit-logged storage the rest of our operations run on. Onboarding is a one-time process: register your business, complete a short legal verification with your registration documents, and once our team approves your account, referrals can start the same day.</p>
        <div style="display:flex;gap:var(--space-3);justify-content:center;flex-wrap:wrap;margin-top:var(--space-5)">
            <a href="/partner/register/" class="btn btn-primary">Start Onboarding</a>
            <a href="#enquiry-form" class="btn btn-outline">Ask a Question First</a>
        </div>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Why Partner With Us</span>
            <h2>Everything You Need to Refer With Confidence</h2>
        </div>
        <div class="card-grid">
            <div class="card service-card">
                <div class="card-title">Tiered Commissions</div>
                <p>Every referred application carries a commission calculated against your partner tier — the more volume you send us over time, the higher the rate on the tiers above yours. There is no manual negotiation on a case-by-case basis: the rate is visible on your dashboard before you submit, so there are no surprises when a case is invoiced.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Real-Time Case Tracking</div>
                <p>Every visa case you refer moves through the same status pipeline our own consultants use internally — document verification, appointment booking, submission, and decision — and each change is reflected on your dashboard the moment it happens on ours, not on a weekly summary email.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Wallet &amp; Invoicing</div>
                <p>Approved commissions are credited to a running wallet balance you can see at any time, and every partner invoice we raise against you (for services rendered on your behalf) is itemized and downloadable — no manual reconciliation against scattered emails or spreadsheets.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Team Accounts</div>
                <p>Once your business account is active, you can invite colleagues as team members with their own logins, so referrals and case follow-ups don't bottleneck through a single person's inbox.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Direct Messaging</div>
                <p>Every referred case has its own message thread with our team, in writing and attached to that specific case — nothing gets lost between a phone call and an email chain, and there's a permanent record if a customer asks what was agreed.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Document Management</div>
                <p>Your own business documents — GST certificate, PAN, IATA/TAFI membership, and the rest — are uploaded once during onboarding and kept on file for your partner profile; you don't re-submit them for every case afterward.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">Legal &amp; Compliance Verification</span>
            <h2>What Onboarding Actually Checks</h2>
            <p>Because referred cases involve real customers' passports, travel plans, and payments, we verify every partner's business identity before their account goes live — this is the part of onboarding most partner programs gloss over, so here it is in full.</p>
        </div>
        <div class="card-grid">
            <div class="card service-card">
                <div class="card-title">Business &amp; Legal Details</div>
                <p>During registration you'll provide your business type, year established, and website, plus your <strong>GST number (GSTIN)</strong> and <strong>PAN</strong> if your business is registered for either. If you're IATA or TAFI accredited, you can record your membership number here too — none of these are mandatory to start, but a verified GSTIN/PAN is required before your account is approved for live referrals.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Supporting Document Attachments</div>
                <p>A short document upload step lets you attach the paperwork that backs up those details: your <strong>PAN Card</strong>, <strong>GST Certificate</strong>, <strong>Company Registration Certificate</strong>, <strong>Trade License</strong>, and — if applicable — your <strong>IATA Certificate</strong> or <strong>TAFI Certificate</strong>. You can also add <strong>Office Address Proof</strong>, an <strong>Authorized Signatory ID</strong>, and a general <strong>Company Profile</strong> document. Everything here is standard PDF/JPG/PNG/DOC upload, capped at 10MB per file — nothing needs to be couriered or scanned to a special format.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Terms Acceptance</div>
                <p>Before your registration is submitted for review, you'll read and accept the Partner Program terms covering commission structure, case-handling responsibilities, and data-handling obligations for any customer information you pass to us.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Admin Verification &amp; Approval</div>
                <p>Once submitted, your business details and documents are reviewed by our partnerships team — the same review process any B2B account goes through internally, not an automated rubber stamp. You'll get an email the moment your account is approved (or if we need something clarified first), and your dashboard shows exactly where you stand at every stage: pending, documents required, or active.</p>
            </div>
        </div>
    </div>
</section>

<section class="section" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">How It Works</span>
            <h2>The Full Onboarding Path, Step by Step</h2>
        </div>
        <ol class="hrms-timeline" style="max-width:680px;margin:0 auto">
            <li><strong>Business &amp; Legal Info.</strong> Tell us what kind of business you run, when it was established, and — if applicable — your GST, PAN, IATA, or TAFI details.</li>
            <li><strong>Contact &amp; Login.</strong> Create your account with your work email (this becomes your login and where your verification link is sent) and a password.</li>
            <li><strong>Business Profile.</strong> Select the services you offer and the visa types you specialize in, and give us a rough sense of your monthly visa volume.</li>
            <li><strong>Document Upload.</strong> Attach your registration certificate, GST/PAN documents, and any accreditation certificates you hold.</li>
            <li><strong>Terms Acceptance.</strong> Read and accept the Partner Program terms.</li>
            <li><strong>Verification &amp; Approval.</strong> Confirm your email, and once our team verifies your documents, your account goes live — your dashboard, referral tools, wallet, and team accounts are all unlocked from that point.</li>
        </ol>
        <p style="text-align:center;margin-top:var(--space-5)"><a href="/partner/register/" class="btn btn-primary">Start Onboarding Now</a></p>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">FAQ</span>
            <h2>Frequently asked questions</h2>
        </div>
        <div class="accordion-item">
            <details>
                <summary>Who is this program for?</summary>
                <div class="accordion-body">Travel agencies, tour operators, visa consultants, corporate travel desks, immigration consultants, freelance/independent consultants, and sub-agents who regularly handle visa cases for their customers.</div>
            </details>
        </div>
        <div class="accordion-item">
            <details>
                <summary>Is GST or PAN mandatory to start onboarding?</summary>
                <div class="accordion-body">No — you can begin registration without them, but a verified GSTIN/PAN is required before your account is approved for live referrals.</div>
            </details>
        </div>
    </div>
</section>

<section class="section" id="enquiry-form">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Have Questions?</span>
            <h2>Tell Us About Your Business</h2>
            <p>Not ready to register yet? Send us a few details and our partnerships team will get in touch before you commit to anything.</p>
        </div>

        <?php if ($submitted && $referenceNumber): ?>
        <div class="alert alert-success" role="status">
            <strong>Thank you.</strong> Your enquiry has been received — reference number <strong><?= e($referenceNumber) ?></strong>. Our partnerships team will get back to you soon.
        </div>
        <?php else: ?>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card">
            <form method="post" action="/partners/#enquiry-form" novalidate>
                <?= csrf_field() ?>
                <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                    <label for="website">Leave this field blank</label>
                    <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
                </div>
                <div class="admin-form-grid">
                    <div class="form-group">
                        <label class="form-label" for="company_name">Company / Agency Name</label>
                        <input class="form-input" type="text" id="company_name" name="company_name" value="<?= e($values['company_name']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="contact_name">Your Name</label>
                        <input class="form-input" type="text" id="contact_name" name="contact_name" value="<?= e($values['contact_name']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="mobile">Mobile Number</label>
                        <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($values['mobile']) ?>" placeholder="e.g. +91 98765 43210" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="business_type">Business Type</label>
                        <select class="form-select" id="business_type" name="business_type">
                            <option value="">Select business type</option>
                            <?php foreach (PARTNER_BUSINESS_TYPES as $key => $label): ?>
                            <option value="<?= e($key) ?>"<?= $values['business_type'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="message">Message (optional)</label>
                    <textarea class="form-input" id="message" name="message" rows="4"><?= e($values['message']) ?></textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%">Submit Enquiry</button>
            </form>
        </div>
        <?php endif; ?>

        <p style="margin-top:var(--space-6);text-align:center">
            Already know you're ready? <a href="/partner/register/">Start onboarding now</a> — or
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about the B2B Partner Program.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
