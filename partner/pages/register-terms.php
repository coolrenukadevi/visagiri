<?php
declare(strict_types=1);

/**
 * Enrollment wizard step 5 — Terms & Declaration, the final step.
 * Only two of the six policies referenced by the client's spec have a
 * real published page today (Terms & Conditions, Privacy Policy —
 * both existing, real /terms/ and /privacy/ routes); the three
 * B2B-specific ones (Partner Agreement, Commission Terms, Document
 * Handling Policy) don't have drafted content yet, so this
 * deliberately says so honestly rather than linking to or fabricating
 * legal text that doesn't exist — same "never fabricate" discipline
 * this project applies everywhere else, extended here to contract
 * language specifically, where it matters even more.
 */

$partner = current_partner();

if ($partner['enrollment_completed_at'] !== null) {
    redirect('/partner/register-complete/');
}

$requiredCheckboxes = ['terms_conditions', 'privacy_policy', 'partner_agreement', 'commission_terms', 'document_handling', 'data_protection'];
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $allChecked = true;
    foreach ($requiredCheckboxes as $key) {
        if (($_POST[$key] ?? '') !== '1') {
            $allChecked = false;
        }
    }
    $declarationChecked = ($_POST['declaration'] ?? '') === '1';

    if (!$allChecked || !$declarationChecked) {
        $errors[] = 'Please review and accept every item below to submit your application.';
    }

    if (!$errors) {
        db()->prepare(
            'UPDATE partners SET terms_accepted_at = NOW(), terms_version = :version, enrollment_completed_at = NOW() WHERE id = :id'
        )->execute(['version' => PARTNER_TERMS_VERSION, 'id' => $partner['id']]);

        log_action('complete_enrollment', 'partners', (int) $partner['id'], null, null, null, (int) $partner['id']);

        send_mail(
            $partner['email'],
            'Application received — ' . $partner['partner_reference_no'] . ' — Visagiri B2B Partner Program',
            '<p>Hi ' . e($partner['contact_name']) . ',</p>'
            . '<p>Thanks for completing your Visagiri B2B partner application. Your application number is <strong>' . e($partner['partner_reference_no']) . '</strong>.</p>'
            . '<p>Our team will review your application and documents; you can check your status anytime by signing in to your partner dashboard.</p>',
            $partner['contact_name']
        );

        redirect('/partner/register-complete/');
    }
}

$pageTitle = 'Become a B2B Partner - Step 5 - Visagiri';
$canonicalUrl = APP_URL . '/partner/register-terms/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Partner Program</span>
            <h1>Become a Visagiri Partner</h1>
        </div>
        <?php render_partner_enrollment_steps(5); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/partner/register-terms/" class="card" style="padding:var(--space-6)" id="enrollment-terms-form">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Terms &amp; Declaration</h2>

            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="terms_conditions" value="1" required>
                    <span>I have read and accept the <a href="/terms/" target="_blank" rel="noopener">Terms &amp; Conditions</a>.</span>
                </label>
            </div>
            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="privacy_policy" value="1" required>
                    <span>I have read and accept the <a href="/privacy/" target="_blank" rel="noopener">Privacy Policy</a>.</span>
                </label>
            </div>
            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="partner_agreement" value="1" required>
                    <span>I accept the B2B Partner Agreement (detailed terms will be shared by your Relationship Manager after approval).</span>
                </label>
            </div>
            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="commission_terms" value="1" required>
                    <span>I accept that commission rates and payout terms will be confirmed individually once my account is approved.</span>
                </label>
            </div>
            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="document_handling" value="1" required>
                    <span>I accept Visagiri's document handling policy — documents I upload are stored securely and used only to process my application and my referred customers' visa cases.</span>
                </label>
            </div>
            <div class="form-group">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="data_protection" value="1" required>
                    <span>I consent to Visagiri processing my personal and business data as described in the Privacy Policy.</span>
                </label>
            </div>
            <div class="form-group" style="border-top:1px solid var(--border);padding-top:var(--space-4);margin-top:var(--space-4)">
                <label style="display:flex;align-items:flex-start;gap:var(--space-2);font-weight:var(--font-weight-semibold)">
                    <input type="checkbox" name="declaration" value="1" required>
                    <span>I confirm that the information and documents provided are genuine and accurate.</span>
                </label>
            </div>

            <button type="submit" class="btn btn-primary" id="enrollment-terms-submit" style="width:100%;margin-top:var(--space-4)">Submit Partner Application</button>
        </form>
    </div>
</section>
<script src="<?= e(asset_url('/assets/js/partner-enrollment.js')) ?>"></script>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
