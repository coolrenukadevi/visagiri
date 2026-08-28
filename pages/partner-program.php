<?php
declare(strict_types=1);

/**
 * Public B2B partner program landing page — the marketing/lead-capture
 * front door for the referral system the rest of this project already
 * built (Phases 1-8). Two paths from here: "Register Now" straight
 * into the real wizard (partner/pages/register.php), or this page's
 * own enquiry form for a prospect not ready to commit yet, captured
 * into partner_enquiries for staff follow-up — same "public form ->
 * staff follow-up" shape as pages/enquire.php, not a stub.
 */

require __DIR__ . '/../includes/google-sheets.php';

$submitted = false;
$referenceNumber = null;
$errors = [];
$values = ['company_name' => '', 'contact_name' => '', 'email' => '', 'mobile' => '', 'business_type' => '', 'message' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/partner-program/');
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
                error_log('[partner-program.php] failed to save enquiry: ' . $e->getMessage());
            }
            $submitted = false;
            $errors[] = 'Something went wrong submitting your enquiry. Please try again, or reach us on WhatsApp.';
        }
    }
}

$pageTitle = 'Become a Visa Partner - B2B Partner Program | Visagiri';
$pageDescription = 'Join the Visagiri B2B Partner Program — refer visa customers, track every case, and earn tiered commissions through a dedicated partner dashboard.';
$canonicalUrl = APP_URL . '/partner-program/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'B2B Partner Program', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:720px;text-align:center">
        <span class="section-eyebrow">B2B Partner Program</span>
        <h1>Grow Your Travel Business With Visagiri</h1>
        <p>Refer your customers' visa applications to Visagiri and earn commission on every case — with a dedicated dashboard to track referrals, applications, documents, and payouts in one place.</p>
        <div style="display:flex;gap:var(--space-3);justify-content:center;flex-wrap:wrap;margin-top:var(--space-5)">
            <a href="/partner/register/" class="btn btn-primary">Register as a Partner</a>
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
                <p>Earn commission on every referred application, with rates that improve as your referral volume grows.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Real-Time Case Tracking</div>
                <p>Follow each referred customer's application status from submission through to completion.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Wallet &amp; Invoicing</div>
                <p>Track your commission balance and invoices in one place — no manual reconciliation.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Team Accounts</div>
                <p>Add colleagues to your partner account with their own logins and role-based access.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Direct Messaging</div>
                <p>Message our team directly on any referred case — no phone tag, everything in writing.</p>
            </div>
            <div class="card service-card">
                <div class="card-title">Document Management</div>
                <p>Upload your business documents once and keep your partner profile verified and up to date.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="section-heading">
            <span class="section-eyebrow">How It Works</span>
            <h2>Four Steps to Your First Referral</h2>
        </div>
        <ol class="hrms-timeline" style="max-width:560px;margin:0 auto">
            <li>Register your business through our partner enrollment wizard.</li>
            <li>Our team verifies your details and approves your account.</li>
            <li>Share your referral link, or submit applications directly on behalf of your customers.</li>
            <li>Track each case to completion and earn commission, visible in your wallet.</li>
        </ol>
    </div>
</section>

<section class="section" id="enquiry-form" style="background:var(--bg-alt, #f7f8fa)">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Have Questions?</span>
            <h2>Tell Us About Your Business</h2>
            <p>Not ready to register yet? Send us a few details and our partnerships team will get in touch.</p>
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
            <form method="post" action="/partner-program/#enquiry-form" novalidate>
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
            Already know you're ready? <a href="/partner/register/">Register as a partner now</a> — or
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about the B2B Partner Program.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
