<?php
declare(strict_types=1);

/**
 * General enquiry form — the site's one non-visa-specific contact
 * channel (alongside the WhatsApp/call/email widget on every page,
 * and the structured /enquire/ form for visa-specific enquiries).
 * Stored in the general_enquiries table (service_type = 'general'),
 * the same table used for attestation service enquiries, with a
 * generated reference number; Google Sheets/Drive and an email ping
 * are best-effort secondary notifications — see includes/google-sheets.php.
 */

require __DIR__ . '/../includes/google-sheets.php';

$submitted = false;
$success = false;
$errors = [];
$values = ['name' => '', 'email' => '', 'phone' => '', 'destination' => '', 'message' => ''];

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
                        'service_type' => 'general',
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
                'destination' => $values['destination'],
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

$pageTitle = 'Contact Us - Visagiri';
$pageDescription = "Get in touch with Visagiri for visa consultancy and document attestation assistance — enquiry form, WhatsApp, call, or email.";
$canonicalUrl = APP_URL . '/contact/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Get In Touch</span>
            <h1>Contact Us</h1>
            <p>Tell us about your visa or document attestation needs and our team will get back to you.</p>
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

        <p style="margin-top:var(--space-6);text-align:center">
            Prefer to talk directly? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get in touch.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>,
            call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>, or email <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
