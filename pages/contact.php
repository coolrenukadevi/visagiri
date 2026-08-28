<?php
declare(strict_types=1);

/**
 * General enquiry form — the site's one non-visa-specific contact
 * channel (alongside the WhatsApp/call/email widget on every page,
 * and the structured /enquire/ form for visa-specific enquiries).
 * Stored in the general_enquiries table, service_type tagged from the
 * "How Can We Help?" selector below; Google Sheets/Drive and an email
 * ping are best-effort secondary notifications — see
 * includes/google-sheets.php.
 *
 * The old single-purpose ?topic=forex boolean (added for the header
 * utility bar's "Get Forex Assistance" CTA) is now one case of a
 * proper 5-way service selector, kept as a backward-compatible alias
 * so that existing link doesn't need to change.
 */

require __DIR__ . '/../includes/google-sheets.php';

const CONTACT_SERVICES = [
    'visa' => [
        'label' => 'Visa Assistance',
        'eyebrow' => 'Visa Assistance',
        'heading' => 'Tell us about your visa requirement and our team will get back to you.',
    ],
    'attestation' => [
        'label' => 'Apostille & Attestation',
        'eyebrow' => 'Apostille & Attestation',
        'heading' => 'Tell us which documents need apostille or attestation and our team will guide you through it.',
    ],
    'forex' => [
        'label' => 'Forex',
        'eyebrow' => 'Forex Assistance',
        'heading' => 'Tell us about your forex or currency exchange requirement and our team will get back to you.',
    ],
    'travel' => [
        'label' => 'Travel Services',
        'eyebrow' => 'Travel Services',
        'heading' => 'Tell us about your travel-document or itinerary-support requirement and our team will get back to you.',
    ],
    'general' => [
        'label' => 'General Enquiry',
        'eyebrow' => 'Get In Touch',
        'heading' => 'Tell us about your visa or document attestation needs and our team will get back to you.',
    ],
];

$requestedService = trim((string) ($_GET['service'] ?? $_POST['service'] ?? ''));
if ($requestedService === '' && trim((string) ($_GET['topic'] ?? $_POST['topic'] ?? '')) === 'forex') {
    $requestedService = 'forex'; // backward-compatible alias for the header utility bar's existing CTA link
}
$serviceType = array_key_exists($requestedService, CONTACT_SERVICES) ? $requestedService : 'general';

$forexPrefill = $serviceType === 'forex' && ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST'
    ? 'I saw the indicative USD to INR rate on your website and would like help with a forex/currency exchange requirement.'
    : '';

$submitted = false;
$success = false;
$errors = [];
$values = [
    'name' => '', 'email' => '', 'phone' => '', 'destination' => '',
    'message' => $forexPrefill,
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    // Honeypot: a real visitor never sees or fills this field (hidden via CSS).
    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/contact/');
    }

    $values['name'] = trim((string) ($_POST['name'] ?? ''));
    $values['email'] = trim((string) ($_POST['email'] ?? ''));
    $values['phone'] = trim((string) ($_POST['phone'] ?? ''));
    $values['destination'] = trim((string) ($_POST['destination'] ?? ''));
    $values['message'] = trim((string) ($_POST['message'] ?? ''));

    if (!rate_limit_check('contact:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
    }
    if ($values['name'] === '') {
        $errors[] = 'Please enter your name.';
    }
    if (!is_valid_email($values['email'])) {
        $errors[] = 'Please enter a valid email address.';
    }
    if ($values['phone'] !== '' && !is_valid_mobile($values['phone'])) {
        $errors[] = 'Please enter a valid phone number, or leave it blank.';
    }
    if ($values['message'] === '') {
        $errors[] = 'Please enter a message.';
    }

    if (!$errors) {
        $submitted = true;
        try {
            // Retry once on the rare chance two submissions in the same
            // instant generate the same COUNT-based reference number —
            // the UNIQUE constraint catches it, we just regenerate.
            for ($attempt = 0; $attempt < 2; $attempt++) {
                $referenceNumber = generate_reference_number('GEN', 'general_enquiries', 'enquiry_reference_no');
                try {
                    $stmt = db()->prepare(
                        'INSERT INTO general_enquiries (enquiry_reference_no, service_type, name, email, phone, subject, description, source_page, ip_address)
                         VALUES (:ref, :service_type, :name, :email, :phone, :subject, :description, :source_page, :ip)'
                    );
                    $stmt->execute([
                        'ref' => $referenceNumber,
                        'service_type' => $serviceType,
                        'name' => $values['name'],
                        'email' => $values['email'],
                        'phone' => $values['phone'] !== '' ? $values['phone'] : null,
                        'subject' => null,
                        'description' => $values['destination'] !== ''
                            ? "Destination: {$values['destination']}\n\n{$values['message']}"
                            : $values['message'],
                        'source_page' => '/contact/',
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
            $success = true;

            notify_enquiry_channels([
                'name' => $values['name'],
                'email' => $values['email'],
                'phone' => $values['phone'],
                'destination' => (CONTACT_SERVICES[$serviceType]['label'] ?? 'General') . ($values['destination'] !== '' ? ' — ' . $values['destination'] : ''),
                'message' => $values['message'],
                'submitted_at' => date('c'),
            ]);

            $values = ['name' => '', 'email' => '', 'phone' => '', 'destination' => '', 'message' => ''];
        } catch (Throwable $e) {
            if (APP_DEBUG) {
                error_log('[contact.php] failed to save message: ' . $e->getMessage());
            }
            $success = false;
        }
    }
}

$pageTitle = ($serviceType === 'general' ? 'Contact Us' : CONTACT_SERVICES[$serviceType]['eyebrow']) . ' | Visagiri';
$pageDescription = 'How can we help? Reach Visagiri for visa assistance, apostille & attestation, forex, or travel-related enquiries — enquiry form, WhatsApp, call, or email.';
$canonicalUrl = APP_URL . '/contact/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:720px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow" id="contact-eyebrow"><?= e(CONTACT_SERVICES[$serviceType]['eyebrow']) ?></span>
            <h1>How Can We Help?</h1>
            <p id="contact-heading"><?= e(CONTACT_SERVICES[$serviceType]['heading']) ?></p>
        </div>

        <div class="contact-service-selector" role="group" aria-label="What do you need help with?">
            <?php foreach (CONTACT_SERVICES as $key => $service): ?>
            <button type="button" class="contact-service-card<?= $serviceType === $key ? ' is-selected' : '' ?>" data-service="<?= e($key) ?>" data-eyebrow="<?= e($service['eyebrow']) ?>" data-heading="<?= e($service['heading']) ?>">
                <?= e($service['label']) ?>
            </button>
            <?php endforeach; ?>
        </div>

        <?php if ($submitted && $success): ?>
        <div class="alert alert-success" role="status">
            <strong>Thank you.</strong> We've received your message and will get back to you soon. For a faster response, you can also
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I just submitted a contact form.")) ?>" target="_blank" rel="noopener noreferrer">message us on WhatsApp</a>.
        </div>
        <?php elseif ($submitted && !$success): ?>
        <div class="alert alert-danger" role="alert">
            <strong>Something went wrong sending your message.</strong> Please try again, or reach us directly on
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get in touch.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp</a>
            or by phone at <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
        </div>
        <?php endif; ?>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card">
            <form method="post" action="/contact/" novalidate>
                <?= csrf_field() ?>
                <input type="hidden" name="service" id="service-field" value="<?= e($serviceType) ?>">
                <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                    <label for="website">Leave this field blank</label>
                    <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
                </div>
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($values['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Phone Number (optional)</label>
                    <input class="form-input" type="tel" id="phone" name="phone" value="<?= e($values['phone']) ?>" placeholder="e.g. +91 98765 43210">
                </div>
                <div class="form-group">
                    <label class="form-label" for="destination">Destination Country (optional)</label>
                    <select class="form-select" id="destination" name="destination">
                        <option value="">Select country</option>
                        <?php foreach (countries_all() as $c): ?>
                        <option value="<?= e($c['name']) ?>"<?= $values['destination'] === $c['name'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="message">Message</label>
                    <textarea class="form-input" id="message" name="message" rows="5" required><?= e($values['message']) ?></textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%">Send Message</button>
            </form>
        </div>

        <div class="contact-cards">
            <div class="contact-card">
                <div class="contact-card__title">WhatsApp</div>
                <p class="contact-card__detail"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></p>
                <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get in touch.")) ?>" class="btn btn-outline btn-sm" target="_blank" rel="noopener noreferrer">WhatsApp Us</a>
            </div>
            <div class="contact-card">
                <div class="contact-card__title">Email</div>
                <p class="contact-card__detail"><?= e(setting('contact_email', 'info@visagiri.com')) ?></p>
                <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>" class="btn btn-outline btn-sm">Email Us</a>
            </div>
            <div class="contact-card">
                <div class="contact-card__title">Call</div>
                <p class="contact-card__detail"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></p>
                <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>" class="btn btn-outline btn-sm">Call Us</a>
            </div>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
