<?php
declare(strict_types=1);

/**
 * Structured visa enquiry form — name, mobile, email, destination
 * country, visa type, purpose of travel, travel date, number of
 * travellers, message. Distinct from the general /contact/ form:
 * this one is what "Enquire" CTAs on visa detail pages link to,
 * pre-filled with the country/visa type the visitor was looking at.
 * Stored in the enquiries table with a generated reference number
 * the visitor can quote when following up; Google Sheets/Drive +
 * email are best-effort secondary notifications.
 */

require __DIR__ . '/../includes/google-sheets.php';

$prefillCountry = trim((string) ($_GET['country'] ?? $_POST['country'] ?? ''));
$prefillVisaType = trim((string) ($_GET['visa_type'] ?? $_POST['visa_type'] ?? ''));

$submitted = false;
$referenceNumber = null;
$errors = [];
$values = [
    'name' => '', 'mobile' => '', 'email' => '', 'country' => $prefillCountry,
    'visa_type' => $prefillVisaType, 'purpose' => '', 'travel_date' => '',
    'travellers' => '1', 'message' => '',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (trim((string) ($_POST['website'] ?? '')) !== '') {
        redirect('/enquire/');
    }

    $values['name'] = trim((string) ($_POST['name'] ?? ''));
    $values['mobile'] = trim((string) ($_POST['mobile'] ?? ''));
    $values['email'] = trim((string) ($_POST['email'] ?? ''));
    $values['country'] = trim((string) ($_POST['country'] ?? ''));
    $values['visa_type'] = trim((string) ($_POST['visa_type'] ?? ''));
    $values['purpose'] = trim((string) ($_POST['purpose'] ?? ''));
    $values['travel_date'] = trim((string) ($_POST['travel_date'] ?? ''));
    $values['travellers'] = trim((string) ($_POST['travellers'] ?? '1'));
    $values['message'] = trim((string) ($_POST['message'] ?? ''));

    if (!rate_limit_check('enquire:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
        $errors[] = 'Too many submissions. Please try again later, or reach us directly on WhatsApp.';
    }
    if ($values['name'] === '') {
        $errors[] = 'Please enter your name.';
    }
    if (!is_valid_mobile($values['mobile'])) {
        $errors[] = 'Please enter a valid mobile number.';
    }
    if (!is_valid_email($values['email'])) {
        $errors[] = 'Please enter a valid email address.';
    }
    $travellersCount = max(1, (int) $values['travellers']);
    $travelDate = null;
    if ($values['travel_date'] !== '') {
        $ts = strtotime($values['travel_date']);
        if ($ts === false) {
            $errors[] = 'Please enter a valid travel date.';
        } else {
            $travelDate = date('Y-m-d', $ts);
        }
    }

    $country = $values['country'] !== '' ? country_by_slug($values['country']) : null;
    $visaType = $values['visa_type'] !== '' ? visa_type_by_slug($values['visa_type']) : null;

    if (!$errors) {
        $submitted = true;
        try {
            // Retry once on the rare chance two submissions in the same
            // instant generate the same COUNT-based reference number —
            // the UNIQUE constraint catches it, we just regenerate.
            for ($attempt = 0; $attempt < 2; $attempt++) {
                $referenceNumber = generate_enquiry_reference();
                try {
                    $stmt = db()->prepare(
                        'INSERT INTO enquiries (reference_number, name, mobile, email, country_id, visa_type_id, purpose_of_travel, travel_date, travellers_count, message, ip_address)
                         VALUES (:ref, :name, :mobile, :email, :country_id, :visa_type_id, :purpose, :travel_date, :travellers, :message, :ip)'
                    );
                    $stmt->execute([
                        'ref' => $referenceNumber,
                        'name' => $values['name'],
                        'mobile' => $values['mobile'],
                        'email' => $values['email'],
                        'country_id' => $country['id'] ?? null,
                        'visa_type_id' => $visaType['id'] ?? null,
                        'purpose' => $values['purpose'] !== '' ? $values['purpose'] : null,
                        'travel_date' => $travelDate,
                        'travellers' => $travellersCount,
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
                'name' => $values['name'],
                'email' => $values['email'],
                'phone' => $values['mobile'],
                'destination' => $country['name'] ?? $values['country'],
                'message' => trim(($visaType['name'] ?? '') . ' — ' . ($values['purpose'] !== '' ? $values['purpose'] . ' — ' : '') . $values['message']),
                'submitted_at' => date('c'),
            ]);
        } catch (Throwable $e) {
            if (APP_DEBUG) {
                error_log('[enquire.php] failed to save enquiry: ' . $e->getMessage());
            }
            $submitted = false;
            $errors[] = 'Something went wrong submitting your enquiry. Please try again, or reach us on WhatsApp.';
        }
    }
}

$pageTitle = 'Submit a Visa Enquiry - Visagiri';
$pageDescription = 'Tell us your destination, visa type, and travel plans — our team will confirm eligibility, documents, and next steps.';
$canonicalUrl = APP_URL . '/enquire/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Visa Enquiry</span>
            <h1>Submit a Visa Enquiry</h1>
            <p>Tell us your destination, visa type, and travel plans — our team will confirm eligibility, documents, and next steps.</p>
        </div>

        <?php if ($submitted && $referenceNumber): ?>
        <div class="alert alert-success" role="status">
            <strong>Thank you.</strong> Your enquiry has been received — reference number <strong><?= e($referenceNumber) ?></strong>. Our team will get back to you soon.
        </div>
        <?php else: ?>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card">
            <form method="post" action="/enquire/" novalidate>
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
                        <label class="form-label" for="mobile">Mobile Number</label>
                        <input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($values['mobile']) ?>" placeholder="e.g. +91 98765 43210" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="country">Destination Country</label>
                        <select class="form-select" id="country" name="country">
                            <option value="">Select country</option>
                            <?php foreach (countries_all() as $c): ?>
                            <option value="<?= e($c['slug']) ?>"<?= $values['country'] === $c['slug'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="visa_type">Visa Type</label>
                        <select class="form-select" id="visa_type" name="visa_type">
                            <option value="">Select visa type</option>
                            <?php foreach (visa_types_all() as $t): ?>
                            <option value="<?= e($t['slug']) ?>"<?= $values['visa_type'] === $t['slug'] ? ' selected' : '' ?>><?= e($t['name']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="purpose">Purpose of Travel</label>
                        <input class="form-input" type="text" id="purpose" name="purpose" value="<?= e($values['purpose']) ?>" placeholder="e.g. Vacation, higher studies, job offer">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="travel_date">Proposed Travel Date</label>
                        <input class="form-input" type="date" id="travel_date" name="travel_date" value="<?= e($values['travel_date']) ?>">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="travellers">Number of Travellers</label>
                        <input class="form-input" type="number" id="travellers" name="travellers" min="1" value="<?= e($values['travellers']) ?>">
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
            Prefer to talk directly? <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to get in touch.")) ?>" target="_blank" rel="noopener noreferrer">WhatsApp us</a>
            or call <a href="tel:<?= e(setting('contact_phone_dial', '+917065819819')) ?>"><?= e(setting('contact_phone_display', '+91 7065 819 819')) ?></a>.
        </p>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
