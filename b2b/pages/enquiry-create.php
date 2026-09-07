<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — New Visa Enquiry. Condensed to one page
 * (Travel Details + Visa Requirements + Applicants, added dynamically
 * via public/assets/js/b2b-enquiry-applicants.js) rather than a
 * separate session-backed multi-step wizard like the signup flow —
 * everything here is real, required data for one atomic transaction,
 * so there's no partial-completion state worth persisting across
 * steps. Document upload happens afterward on the enquiry detail page
 * (pages/enquiries.php), since documents are optional at creation
 * time and can keep arriving after the enquiry is opened.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();

if ($partner['status'] !== 'active') {
    flash_set('b2b_error', 'Your partner account must be active before you can submit visa enquiries. Current status: ' . e(B2B_STATUS_LABELS[$partner['status']] ?? $partner['status']));
    redirect('/b2b/dashboard/');
}

$errors = [];
$countries = countries_all();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $destinationCountryId = (int) ($_POST['destination_country_id'] ?? 0);
    $visaType = $_POST['visa_type'] ?? '';
    $purposeOfTravel = trim((string) ($_POST['purpose_of_travel'] ?? ''));
    $intendedTravelDate = trim((string) ($_POST['intended_travel_date'] ?? ''));
    $specialRequirements = trim((string) ($_POST['special_requirements'] ?? ''));
    $applicantsInput = $_POST['applicants'] ?? [];

    if (!$destinationCountryId || !in_array($destinationCountryId, array_column($countries, 'id'), true)) {
        $errors[] = 'Select a valid destination country.';
    }
    if (!array_key_exists($visaType, B2B_VISA_SERVICES)) {
        $errors[] = 'Select a valid visa type.';
    }
    if ($intendedTravelDate !== '' && !preg_match('/^\d{4}-\d{2}-\d{2}$/', $intendedTravelDate)) {
        $errors[] = 'Enter a valid intended travel date.';
    }

    $applicants = [];
    foreach ((array) $applicantsInput as $row) {
        $name = trim((string) ($row['full_name'] ?? ''));
        if ($name === '') {
            continue;
        }
        $applicants[] = [
            'full_name' => $name,
            'date_of_birth' => (preg_match('/^\d{4}-\d{2}-\d{2}$/', (string) ($row['date_of_birth'] ?? '')) ? $row['date_of_birth'] : null),
            'nationality' => trim((string) ($row['nationality'] ?? '')) ?: null,
            'passport_number' => trim((string) ($row['passport_number'] ?? '')) ?: null,
            'relationship_to_lead' => array_key_exists($row['relationship_to_lead'] ?? '', B2B_APPLICANT_RELATIONSHIPS) ? $row['relationship_to_lead'] : null,
        ];
    }
    if (!$applicants) {
        $errors[] = 'Add at least one applicant.';
    }

    if (!$errors) {
        $pdo = db();
        $pdo->beginTransaction();
        try {
            $reference = b2b_generate_enquiry_reference();
            $pdo->prepare(
                'INSERT INTO b2b_visa_enquiries (enquiry_reference_no, b2b_partner_id, created_by_user_id, destination_country_id, visa_type, purpose_of_travel, intended_travel_date, number_of_applicants, special_requirements, status)
                 VALUES (:ref, :partner_id, :user_id, :country_id, :visa_type, :purpose, :travel_date, :count, :requirements, :status)'
            )->execute([
                'ref' => $reference,
                'partner_id' => $partner['id'],
                'user_id' => $user['id'],
                'country_id' => $destinationCountryId,
                'visa_type' => $visaType,
                'purpose' => $purposeOfTravel ?: null,
                'travel_date' => $intendedTravelDate ?: null,
                'count' => count($applicants),
                'requirements' => $specialRequirements ?: null,
                'status' => 'new',
            ]);
            $enquiryId = (int) $pdo->lastInsertId();

            $applicantStmt = $pdo->prepare(
                'INSERT INTO b2b_enquiry_applicants (b2b_visa_enquiry_id, full_name, date_of_birth, nationality, passport_number_encrypted, relationship_to_lead)
                 VALUES (:enquiry_id, :name, :dob, :nationality, :passport, :relationship)'
            );
            foreach ($applicants as $a) {
                $applicantStmt->execute([
                    'enquiry_id' => $enquiryId,
                    'name' => $a['full_name'],
                    'dob' => $a['date_of_birth'],
                    'nationality' => $a['nationality'],
                    'passport' => $a['passport_number'] !== null ? encrypt_value($a['passport_number']) : null,
                    'relationship' => $a['relationship_to_lead'],
                ]);
            }

            $pdo->prepare('INSERT INTO b2b_enquiry_status_history (b2b_visa_enquiry_id, old_status, new_status, changed_by_partner_user) VALUES (:id, NULL, :status, :user)')
                ->execute(['id' => $enquiryId, 'status' => 'new', 'user' => $user['id']]);

            $pdo->commit();
            flash_set('b2b_notice', 'Enquiry ' . $reference . ' submitted.');
            redirect('/b2b/enquiries/?action=view&id=' . $enquiryId);
        } catch (Throwable $e) {
            $pdo->rollBack();
            $errors[] = 'Something went wrong saving this enquiry. Please try again.';
        }
    }
}

$pageTitle = 'New Visa Enquiry - Visagiri B2B Travel Partner Portal';
$canonicalUrl = APP_URL . '/b2b/enquiry-create/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>New Visa Enquiry</h1>
        </div>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <form method="post" action="/b2b/enquiry-create/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>

            <h2 class="country-directory__subheading" style="margin-top:0">Travel Details</h2>
            <div class="form-group">
                <label class="form-label" for="destination_country_id">Destination Country</label>
                <select class="form-select" id="destination_country_id" name="destination_country_id" required>
                    <option value="">Select country</option>
                    <?php foreach ($countries as $c): ?>
                    <option value="<?= (int) $c['id'] ?>"<?= (int) ($_POST['destination_country_id'] ?? 0) === (int) $c['id'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="visa_type">Visa Type</label>
                <select class="form-select" id="visa_type" name="visa_type" required>
                    <option value="">Select visa type</option>
                    <?php foreach (B2B_VISA_SERVICES as $key => $label): ?>
                    <option value="<?= e($key) ?>"<?= ($_POST['visa_type'] ?? '') === $key ? ' selected' : '' ?>><?= e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="purpose_of_travel">Purpose of Travel</label>
                <input class="form-input" type="text" id="purpose_of_travel" name="purpose_of_travel" value="<?= e($_POST['purpose_of_travel'] ?? '') ?>" placeholder="e.g. Client meeting, family visit, conference">
            </div>
            <div class="form-group">
                <label class="form-label" for="intended_travel_date">Intended Travel Date</label>
                <input class="form-input" type="date" id="intended_travel_date" name="intended_travel_date" value="<?= e($_POST['intended_travel_date'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="special_requirements">Special Requirements / Notes</label>
                <textarea class="form-textarea" id="special_requirements" name="special_requirements" rows="3"><?= e($_POST['special_requirements'] ?? '') ?></textarea>
            </div>

            <h2 class="country-directory__subheading">Applicants</h2>
            <div id="applicant-rows">
                <div class="admin-form-card" data-applicant-row style="margin-bottom:var(--space-3)">
                    <p style="font-weight:600" data-row-label>Applicant 1</p>
                    <div class="form-group"><label class="form-label">Full Name</label><input class="form-input" type="text" data-field="full_name" required></div>
                    <div class="form-group"><label class="form-label">Date of Birth</label><input class="form-input" type="date" data-field="date_of_birth"></div>
                    <div class="form-group"><label class="form-label">Nationality</label><input class="form-input" type="text" data-field="nationality"></div>
                    <div class="form-group"><label class="form-label">Passport Number</label><input class="form-input" type="text" data-field="passport_number"></div>
                    <div class="form-group">
                        <label class="form-label">Relationship</label>
                        <select class="form-select" data-field="relationship_to_lead">
                            <?php foreach (B2B_APPLICANT_RELATIONSHIPS as $key => $label): ?>
                            <option value="<?= e($key) ?>"><?= e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <button type="button" class="btn btn-outline btn-sm" data-remove-applicant hidden>Remove</button>
                </div>
            </div>
            <template id="applicant-row-template">
                <div class="admin-form-card" data-applicant-row style="margin-bottom:var(--space-3)">
                    <p style="font-weight:600" data-row-label>Applicant</p>
                    <div class="form-group"><label class="form-label">Full Name</label><input class="form-input" type="text" data-field="full_name" required></div>
                    <div class="form-group"><label class="form-label">Date of Birth</label><input class="form-input" type="date" data-field="date_of_birth"></div>
                    <div class="form-group"><label class="form-label">Nationality</label><input class="form-input" type="text" data-field="nationality"></div>
                    <div class="form-group"><label class="form-label">Passport Number</label><input class="form-input" type="text" data-field="passport_number"></div>
                    <div class="form-group">
                        <label class="form-label">Relationship</label>
                        <select class="form-select" data-field="relationship_to_lead">
                            <?php foreach (B2B_APPLICANT_RELATIONSHIPS as $key => $label): ?>
                            <option value="<?= e($key) ?>"><?= e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <button type="button" class="btn btn-outline btn-sm" data-remove-applicant>Remove</button>
                </div>
            </template>
            <button type="button" id="add-applicant-btn" class="btn btn-outline btn-sm" style="margin-bottom:var(--space-5)">+ Add Applicant</button>

            <div>
                <button type="submit" class="btn btn-primary">Submit Enquiry</button>
                <a href="/b2b/dashboard/" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</section>
<script src="<?= e(asset_url('/assets/js/b2b-enquiry-applicants.js')) ?>"></script>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
