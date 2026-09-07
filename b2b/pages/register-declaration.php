<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 6: Review, Declaration & Submit.
 * Reuses the existing partner-enrollment.js "disable submit until
 * every required checkbox is checked" behavior via the same
 * #enrollment-terms-form/#enrollment-terms-submit ids it already
 * looks for — that script is generic front-end progressive
 * enhancement, not part of the other partner system itself.
 */

$partner = current_b2b_partner();
$user = current_b2b_partner_user();

if ($partner['status'] !== 'draft') {
    redirect('/b2b/register-complete/');
}

$servicesStmt = db()->prepare('SELECT service_key FROM b2b_partner_services WHERE b2b_partner_id = :id');
$servicesStmt->execute(['id' => $partner['id']]);
$services = $servicesStmt->fetchAll(PDO::FETCH_COLUMN);

$countriesStmt = db()->prepare(
    'SELECT c.name FROM b2b_partner_countries pc JOIN countries c ON c.id = pc.country_id WHERE pc.b2b_partner_id = :id ORDER BY c.name'
);
$countriesStmt->execute(['id' => $partner['id']]);
$countryNames = $countriesStmt->fetchAll(PDO::FETCH_COLUMN);

$documentsStmt = db()->prepare('SELECT document_type FROM b2b_partner_documents WHERE b2b_partner_id = :id AND deleted_at IS NULL');
$documentsStmt->execute(['id' => $partner['id']]);
$uploadedDocumentTypes = $documentsStmt->fetchAll(PDO::FETCH_COLUMN);

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $declaration = ($_POST['declaration'] ?? '') === '1';
    $terms = ($_POST['terms'] ?? '') === '1';
    $privacy = ($_POST['privacy'] ?? '') === '1';
    $consent = ($_POST['consent'] ?? '') === '1';

    if (!$declaration || !$terms || !$privacy || !$consent) {
        $errors[] = 'Please accept the declaration and all required agreements to submit your application.';
    }

    if (!$errors) {
        $now = date('Y-m-d H:i:s');
        $ip = $_SERVER['REMOTE_ADDR'] ?? null;
        db()->prepare(
            'UPDATE b2b_partners SET status = "submitted", submitted_at = NOW(),
                declaration_accepted_at = :now1, terms_accepted_at = :now2, privacy_accepted_at = :now3, verification_consent_at = :now4, declaration_ip = :ip
             WHERE id = :id'
        )->execute(['now1' => $now, 'now2' => $now, 'now3' => $now, 'now4' => $now, 'ip' => $ip, 'id' => $partner['id']]);

        b2b_change_status((int) $partner['id'], 'under_review', null, 'Auto: application submitted by partner.');

        send_mail(
            $partner['business_email'],
            'Visagiri B2B Partner Application Received - ' . $partner['partner_reference_no'],
            '<p>Dear ' . e($user['full_name']) . ',</p><p>Thank you for registering <strong>' . e($partner['legal_business_name']) . '</strong> as a Visagiri B2B Travel Partner.</p>'
                . '<p><strong>Application Reference:</strong> ' . e($partner['partner_reference_no']) . '<br><strong>Status:</strong> Under Review</p>'
                . '<p>Our B2B onboarding team will review your application and documents, and will contact you if anything further is required.</p>'
                . '<p>Regards,<br>Visagiri B2B Partnerships Team</p>',
            $partner['legal_business_name']
        );

        redirect('/b2b/register-complete/');
    }
}

$pageTitle = 'Become a B2B Travel Partner - Step 6 - Visagiri';
$canonicalUrl = APP_URL . '/b2b/register-declaration/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:680px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(6); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card" style="padding:var(--space-6);margin-bottom:var(--space-5)">
            <h2 style="margin-top:0">Review Your Application</h2>
            <p><strong>Company Details</strong><br>
            <?= e($partner['legal_business_name']) ?><?= $partner['trade_name'] ? ' (' . e($partner['trade_name']) . ')' : '' ?><br>
            <?= e(B2B_BUSINESS_TYPES[$partner['business_type']] ?? $partner['business_type']) ?><br>
            <?= e($partner['office_address']) ?>, <?= e($partner['city']) ?>, <?= e($partner['state']) ?> <?= e($partner['pincode']) ?></p>

            <p><strong>Authorized Contact</strong><br>
            <?= e($user['full_name']) ?> (<?= e(B2B_DESIGNATIONS[$user['designation']] ?? $user['designation']) ?>)<br>
            <?= e($user['email']) ?> &middot; <?= e($user['mobile_country_code'] . ' ' . $user['mobile_number']) ?></p>

            <p><strong>Services Selected</strong><br>
            <?= $services ? e(implode(', ', array_map(static fn($k) => B2B_VISA_SERVICES[$k] ?? $k, $services))) : 'None selected' ?></p>

            <p><strong>Preferred Countries</strong><br>
            <?= $countryNames ? e(implode(', ', $countryNames)) : 'None selected' ?></p>

            <p><strong>Documents Uploaded</strong><br>
            <?= $uploadedDocumentTypes ? e(implode(', ', array_map(static fn($k) => B2B_DOCUMENT_TYPES[$k] ?? $k, $uploadedDocumentTypes))) : 'None uploaded yet' ?></p>

            <p style="margin-bottom:0"><a href="/b2b/register/">Edit business information</a> &middot; <a href="/b2b/register-documents/">Edit documents</a> &middot; <a href="/b2b/register-services/">Edit services &amp; countries</a></p>
        </div>

        <form method="post" action="/b2b/register-declaration/" class="card" style="padding:var(--space-6)" id="enrollment-terms-form">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Declaration</h2>
            <p>I hereby confirm that the information and documents submitted are true and accurate and that I am authorized to register this business as a B2B Partner with Visagiri.</p>
            <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular);margin-bottom:var(--space-3)">
                <input type="checkbox" name="declaration" value="1" required>
                <span>I confirm the information and documents submitted are true and accurate, and that I am authorized to register this business.</span>
            </label>
            <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular);margin-bottom:var(--space-3)">
                <input type="checkbox" name="terms" value="1" required>
                <span>I agree to the <a href="/terms/" target="_blank" rel="noopener noreferrer">B2B Partner Terms &amp; Conditions</a>.</span>
            </label>
            <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular);margin-bottom:var(--space-3)">
                <input type="checkbox" name="privacy" value="1" required>
                <span>I agree to the <a href="/privacy/" target="_blank" rel="noopener noreferrer">Privacy Policy</a>.</span>
            </label>
            <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular);margin-bottom:var(--space-4)">
                <input type="checkbox" name="consent" value="1" required>
                <span>I consent to verification of the submitted business information and documents.</span>
            </label>
            <button type="submit" class="btn btn-primary" style="width:100%" id="enrollment-terms-submit" disabled>Submit Partner Application</button>
        </form>
    </div>
</section>
<script src="<?= e(asset_url('/assets/js/partner-enrollment.js')) ?>"></script>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
