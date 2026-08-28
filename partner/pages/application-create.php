<?php
declare(strict_types=1);

/**
 * Lets an active partner refer a customer and submit a visa
 * application on their behalf — reuses the existing customers/
 * visa_applications tables via customers.referred_by_partner_id
 * (already added in Phase 1), same pattern admin/pages/visa-
 * applications.php's own "create" action uses. No new tables.
 */

$partner = current_partner();

if (!is_partner_active()) {
    redirect('/partner/dashboard/');
}

if (!current_partner_can_manage()) {
    http_response_code(403);
    exit('Your team role (viewer) does not have permission to create applications.');
}

$pdo = db();
$errors = [];
$old = ['first_name' => '', 'last_name' => '', 'email' => '', 'mobile' => '', 'country_id' => '', 'visa_type_id' => '', 'travel_date' => '', 'notes' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $firstName = trim((string) ($_POST['first_name'] ?? ''));
    $lastName = trim((string) ($_POST['last_name'] ?? '')) ?: null;
    $email = trim((string) ($_POST['email'] ?? '')) ?: null;
    $mobile = trim((string) ($_POST['mobile'] ?? '')) ?: null;
    $countryId = (int) ($_POST['country_id'] ?? 0);
    $visaTypeId = (int) ($_POST['visa_type_id'] ?? 0);
    $travelDate = ($_POST['travel_date'] ?? '') !== '' ? $_POST['travel_date'] : null;
    $notes = trim((string) ($_POST['notes'] ?? '')) ?: null;
    $old = ['first_name' => $firstName, 'last_name' => (string) $lastName, 'email' => (string) $email, 'mobile' => (string) $mobile, 'country_id' => (string) $countryId, 'visa_type_id' => (string) $visaTypeId, 'travel_date' => (string) $travelDate, 'notes' => (string) $notes];

    if ($firstName === '') {
        $errors[] = 'Enter the customer\'s first name.';
    }
    if ($email === null && $mobile === null) {
        $errors[] = 'Enter at least one of email or mobile.';
    }
    if (!$countryId) {
        $errors[] = 'Select a destination country.';
    }
    if (!$visaTypeId) {
        $errors[] = 'Select a visa type.';
    }

    // Reuse a customer already referred by this same partner (repeat
    // application for someone they've referred before); otherwise
    // block if the email/mobile belongs to someone else's customer
    // record — a partner should never be able to attach a new
    // application to a customer they don't own the referral for.
    $customerId = null;
    if (!$errors && ($email !== null || $mobile !== null)) {
        $lookup = $pdo->prepare(
            'SELECT id, referred_by_partner_id FROM customers
             WHERE deleted_at IS NULL AND ((email IS NOT NULL AND email = :email) OR (mobile IS NOT NULL AND mobile = :mobile))
             LIMIT 1'
        );
        $lookup->execute(['email' => $email, 'mobile' => $mobile]);
        $existing = $lookup->fetch();
        if ($existing) {
            if ((int) $existing['referred_by_partner_id'] !== (int) $partner['id']) {
                $errors[] = 'A customer with that email or mobile number already exists in our system. Please contact Visagiri support to link this application.';
            } else {
                $customerId = (int) $existing['id'];
            }
        }
    }

    if (!$errors && $customerId === null) {
        $customerRef = generate_reference_number('CUST', 'customers', 'customer_reference_no');
        $pdo->prepare(
            'INSERT INTO customers (customer_reference_no, referred_by_partner_id, first_name, last_name, email, mobile, status)
             VALUES (:ref, :partner_id, :first_name, :last_name, :email, :mobile, "active")'
        )->execute([
            'ref' => $customerRef,
            'partner_id' => $partner['id'],
            'first_name' => $firstName,
            'last_name' => $lastName,
            'email' => $email,
            'mobile' => $mobile,
        ]);
        $customerId = (int) $pdo->lastInsertId();
        log_action('create', 'customers', $customerId, null, $customerRef, null, (int) $partner['id']);
    }

    if (!$errors) {
        $appRef = generate_reference_number('VISA', 'visa_applications', 'application_reference_no');
        $pdo->prepare(
            'INSERT INTO visa_applications (application_reference_no, customer_id, country_id, visa_type_id, travel_date, notes)
             VALUES (:ref, :customer_id, :country_id, :visa_type_id, :travel_date, :notes)'
        )->execute([
            'ref' => $appRef,
            'customer_id' => $customerId,
            'country_id' => $countryId,
            'visa_type_id' => $visaTypeId,
            'travel_date' => $travelDate,
            'notes' => $notes,
        ]);
        $applicationId = (int) $pdo->lastInsertId();
        $pdo->prepare('INSERT INTO visa_application_history (visa_application_id, old_status, new_status, changed_by) VALUES (:id, NULL, "draft", NULL)')
            ->execute(['id' => $applicationId]);
        log_action('create', 'visa_applications', $applicationId, null, $appRef, null, (int) $partner['id']);

        flash_set('notice', "Application $appRef submitted.");
        redirect('/partner/applications/?id=' . $applicationId);
    }
}

$countries = countries_all();
$visaTypesList = visa_types_all();

render_partner_start('applications', 'New Application');
?>
<?php foreach ($errors as $error): ?>
<div class="alert alert-danger"><?= e($error) ?></div>
<?php endforeach; ?>
<div class="admin-form-card" style="max-width:640px">
    <form method="post" action="/partner/application-create/">
        <?= csrf_field() ?>
        <h2 class="country-directory__subheading" style="margin-top:0">Customer Details</h2>
        <div class="admin-form-grid">
            <div class="form-group">
                <label class="form-label" for="first_name">First Name</label>
                <input class="form-input" type="text" id="first_name" name="first_name" value="<?= e($old['first_name']) ?>" required autofocus>
            </div>
            <div class="form-group">
                <label class="form-label" for="last_name">Last Name</label>
                <input class="form-input" type="text" id="last_name" name="last_name" value="<?= e($old['last_name']) ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email</label>
                <input class="form-input" type="email" id="email" name="email" value="<?= e($old['email']) ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="mobile">Mobile</label>
                <input class="form-input" type="text" id="mobile" name="mobile" value="<?= e($old['mobile']) ?>">
            </div>
        </div>
        <small style="color:var(--text-muted)">At least one of email or mobile is required.</small>

        <h2 class="country-directory__subheading">Application Details</h2>
        <div class="admin-form-grid">
            <div class="form-group">
                <label class="form-label" for="country_id">Country</label>
                <select class="form-select" id="country_id" name="country_id" required>
                    <option value="">Select country</option>
                    <?php foreach ($countries as $c): ?>
                    <option value="<?= (int) $c['id'] ?>"<?= $old['country_id'] === (string) $c['id'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="visa_type_id">Visa Type</label>
                <select class="form-select" id="visa_type_id" name="visa_type_id" required>
                    <option value="">Select visa type</option>
                    <?php foreach ($visaTypesList as $t): ?>
                    <option value="<?= (int) $t['id'] ?>"<?= $old['visa_type_id'] === (string) $t['id'] ? ' selected' : '' ?>><?= e($t['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label" for="travel_date">Travel Date</label>
                <input class="form-input" type="date" id="travel_date" name="travel_date" value="<?= e($old['travel_date']) ?>">
            </div>
        </div>
        <div class="form-group">
            <label class="form-label" for="notes">Notes</label>
            <textarea class="form-textarea" id="notes" name="notes" rows="3"><?= e($old['notes']) ?></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Application</button>
        <a href="/partner/applications/" class="btn btn-outline">Cancel</a>
    </form>
</div>
<?php render_partner_end(); ?>
