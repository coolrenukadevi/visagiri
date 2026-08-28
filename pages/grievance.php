<?php
declare(strict_types=1);

/**
 * /grievance/ — Grievance Redressal. Part of the Legal & Support
 * Centre. Same public-form skeleton as pages/contact.php/enquire.php
 * (honeypot, csrf_require(), rate_limit_check(), generate_reference_
 * number() with retry-on-collision, notify_enquiry_channels()) writing
 * into the new standalone `grievances` table (schema-legal-phase1.sql)
 * rather than general_enquiries, since grievances carry SLA/escalation
 * columns general enquiries don't. The public response-time statement
 * below reads setting('grievance_sla_hours') live rather than
 * hardcoding a number, so it can never drift from what the admin side
 * actually enforces. Escalation-officer contact is settings-gated per
 * the "omit when unconfirmed" decision — see includes/legal-layout.php.
 */

require_once __DIR__ . '/../includes/google-sheets.php';

$submitted = false;
$referenceNumber = null;
$errors = [];
$values = [
    'name' => '', 'email' => '', 'phone' => '', 'category' => '',
    'related_reference_no' => '', 'description' => '', 'preferred_contact_method' => 'email',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/grievance/');
    }

    $values['name'] = trim((string) ($_POST['name'] ?? ''));
    $values['email'] = trim((string) ($_POST['email'] ?? ''));
    $values['phone'] = trim((string) ($_POST['phone'] ?? ''));
    $values['category'] = trim((string) ($_POST['category'] ?? ''));
    $values['related_reference_no'] = trim((string) ($_POST['related_reference_no'] ?? ''));
    $values['description'] = trim((string) ($_POST['description'] ?? ''));
    $values['preferred_contact_method'] = trim((string) ($_POST['preferred_contact_method'] ?? 'email'));

    if (!rate_limit_check('grievance:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
    }
    if ($values['name'] === '') {
        $errors[] = 'Please enter your name.';
    }
    if (!is_valid_email($values['email'])) {
        $errors[] = 'Please enter a valid email address.';
    }
    if ($values['phone'] !== '' && !is_valid_mobile($values['phone'])) {
        $errors[] = 'Please enter a valid mobile number, or leave it blank.';
    }
    if (!array_key_exists($values['category'], GRIEVANCE_CATEGORIES)) {
        $errors[] = 'Please select what your grievance relates to.';
    }
    if ($values['description'] === '') {
        $errors[] = 'Please describe your grievance.';
    }
    if (!array_key_exists($values['preferred_contact_method'], GRIEVANCE_CONTACT_METHODS)) {
        $values['preferred_contact_method'] = 'email';
    }

    $hasAttachment = ($_FILES['attachment']['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
    if ($hasAttachment) {
        $attachmentError = validate_document_upload($_FILES['attachment']);
        if ($attachmentError) {
            $errors[] = $attachmentError;
        }
    }

    if (!$errors) {
        $submitted = true;
        try {
            $slaHours = (int) setting('grievance_sla_hours', '72');
            for ($attempt = 0; $attempt < 2; $attempt++) {
                $referenceNumber = generate_reference_number('GRV', 'grievances', 'grievance_reference_no');
                try {
                    $stmt = db()->prepare(
                        'INSERT INTO grievances (grievance_reference_no, category, name, email, phone, related_reference_no, description, preferred_contact_method, source_page, ip_address, sla_due_at)
                         VALUES (:ref, :category, :name, :email, :phone, :related, :description, :contact_method, :source_page, :ip, DATE_ADD(NOW(), INTERVAL :hours HOUR))'
                    );
                    $stmt->execute([
                        'ref' => $referenceNumber,
                        'category' => $values['category'],
                        'name' => $values['name'],
                        'email' => $values['email'],
                        'phone' => $values['phone'] !== '' ? $values['phone'] : null,
                        'related' => $values['related_reference_no'] !== '' ? $values['related_reference_no'] : null,
                        'description' => $values['description'],
                        'contact_method' => $values['preferred_contact_method'],
                        'source_page' => '/grievance/',
                        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                        'hours' => $slaHours,
                    ]);
                    break;
                } catch (PDOException $e) {
                    if ($e->getCode() === '23000' && $attempt === 0) {
                        continue;
                    }
                    throw $e;
                }
            }

            $grievanceId = (int) db()->lastInsertId();

            if ($hasAttachment) {
                store_grievance_document_upload($_FILES['attachment'], GRIEVANCE_CATEGORIES[$values['category']] ?? null, $grievanceId);
            }

            notify_enquiry_channels([
                'reference_number' => $referenceNumber,
                'name' => $values['name'],
                'email' => $values['email'],
                'phone' => $values['phone'],
                'destination' => GRIEVANCE_CATEGORIES[$values['category']] ?? $values['category'],
                'message' => $values['description'],
                'submitted_at' => date('c'),
            ]);
        } catch (Throwable $e) {
            if (APP_DEBUG) {
                error_log('[grievance.php] failed to save grievance: ' . $e->getMessage());
            }
            $submitted = false;
            $errors[] = 'Something went wrong submitting your grievance. Please try again, or reach us on WhatsApp.';
        }
    }
}

$pageTitle = 'Grievance Redressal | Visagiri';
$pageDescription = 'Have a concern about a Visagiri service? Submit a grievance and get a tracked reference number — we take customer concerns seriously.';
$canonicalUrl = APP_URL . '/grievance/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Grievance Redressal', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$slaHours = (int) setting('grievance_sla_hours', '72');
$officerName = setting('legal_grievance_officer_name', '');
$officerEmail = setting('legal_grievance_officer_email', '');

$sections = [
    'our-commitment' => 'Our Commitment',
    'how-it-works' => 'How It Works',
    'submit-a-grievance' => 'Submit a Grievance',
];

render_legal_hero(
    'grievance',
    'Grievance Redressal',
    'We take customer concerns seriously.',
    'legal_grievance_updated_at',
    $sections
);
?>
<section id="our-commitment">
    <h2>Our Commitment</h2>
    <p>If something about your experience with Visagiri didn't meet your expectations — a delay, a miscommunication, or a concern about how a service was handled — we want to know, and we want to put it right. Every grievance is logged, tracked with a reference number, and followed up by our team.</p>
    <p>We aim to give every grievance a first response within <?= (int) $slaHours ?> hours of submission.</p>
</section>

<section id="how-it-works">
    <h2>How It Works</h2>
    <ol>
        <li><strong>Submit your complaint</strong> using the form below.</li>
        <li><strong>Receive an acknowledgement</strong> — a grievance reference number you can quote in any follow-up.</li>
        <li><strong>Internal review</strong> — your grievance is assigned to a member of our team for review.</li>
        <li><strong>Resolution or update</strong> — we'll update you on the outcome, or on progress if it needs more time.</li>
        <li><strong>Escalation if required</strong> — if your grievance needs more senior attention, we escalate it internally to keep it moving.</li>
    </ol>
    <?php if ($officerName !== '' || $officerEmail !== ''): ?>
    <p>You can also reach our grievance officer<?= $officerName !== '' ? ', ' . e($officerName) . ',' : '' ?> directly<?= $officerEmail !== '' ? ' at <a href="mailto:' . e($officerEmail) . '">' . e($officerEmail) . '</a>' : '' ?>.</p>
    <?php endif; ?>
</section>

<section id="submit-a-grievance">
    <h2>Submit a Grievance</h2>

    <?php if ($submitted && $referenceNumber): ?>
    <div class="alert alert-success" role="status">
        <strong>Thank you.</strong> Your grievance has been received — reference number <strong><?= e($referenceNumber) ?></strong>. Please quote this reference in any follow-up. Our team will be in touch within <?= (int) $slaHours ?> hours.
    </div>
    <?php else: ?>

    <?php foreach ($errors as $error): ?>
    <div class="alert alert-danger"><?= e($error) ?></div>
    <?php endforeach; ?>

    <div class="card">
        <form method="post" action="/grievance/" enctype="multipart/form-data" novalidate>
            <?= csrf_field() ?>
            <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                <label for="website">Leave this field blank</label>
                <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
            </div>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input class="form-input" type="text" id="name" name="name" value="<?= e($values['name']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Mobile Number (optional)</label>
                    <input class="form-input" type="tel" id="phone" name="phone" value="<?= e($values['phone']) ?>" placeholder="e.g. +91 98765 43210">
                </div>
                <div class="form-group">
                    <label class="form-label" for="category">This Grievance Relates To</label>
                    <select class="form-select" id="category" name="category" required>
                        <option value="">Select a category</option>
                        <?php foreach (GRIEVANCE_CATEGORIES as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $values['category'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="related_reference_no">Enquiry / Booking Reference (optional)</label>
                    <input class="form-input" type="text" id="related_reference_no" name="related_reference_no" value="<?= e($values['related_reference_no']) ?>" placeholder="e.g. VG-ENQ-2026-000123">
                </div>
                <div class="form-group">
                    <label class="form-label" for="preferred_contact_method">Preferred Response Method</label>
                    <select class="form-select" id="preferred_contact_method" name="preferred_contact_method">
                        <?php foreach (GRIEVANCE_CONTACT_METHODS as $key => $label): ?>
                        <option value="<?= e($key) ?>"<?= $values['preferred_contact_method'] === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="description">Describe Your Grievance</label>
                <textarea class="form-input" id="description" name="description" rows="5" required><?= e($values['description']) ?></textarea>
            </div>
            <div class="form-group">
                <label class="form-label" for="attachment">Attachment (optional)</label>
                <input class="form-input" type="file" id="attachment" name="attachment" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx">
            </div>
            <button type="submit" class="btn btn-primary" style="width:100%">Submit Grievance</button>
        </form>
    </div>
    <?php endif; ?>

    <p style="margin-top:var(--space-6);text-align:center">
        Prefer to talk directly? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to raise a grievance.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
        or call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
    </p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
