<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 5: Banking / Billing. Bank name,
 * account holder, account number and IFSC are encrypted at rest with
 * the project's existing AES-256-GCM helper (includes/encryption.php)
 * — same pattern already used for passport numbers and Forex PAN
 * elsewhere in this codebase. Decryption for display is gated by
 * current_b2b_partner_can_view_billing() / the
 * b2b_travel_partners.billing.view admin permission, never shown to
 * every role that can merely view a partner record.
 */

$partner = current_b2b_partner();

$existingStmt = db()->prepare('SELECT * FROM b2b_partner_billing WHERE b2b_partner_id = :id');
$existingStmt->execute(['id' => $partner['id']]);
$existing = $existingStmt->fetch();

$old = [
    'billing_name' => $existing['billing_name'] ?? $partner['legal_business_name'],
    'billing_address' => $existing['billing_address'] ?? $partner['office_address'],
    'gstin' => $existing['gstin'] ?? $partner['gstin'] ?? '',
    'pan' => $existing['pan'] ?? $partner['pan'] ?? '',
    'bank_name' => $existing ? (decrypt_value($existing['bank_name_encrypted']) ?? '') : '',
    'account_holder' => $existing ? (decrypt_value($existing['account_holder_encrypted']) ?? '') : '',
    'account_number' => '',
    'ifsc' => $existing ? (decrypt_value($existing['ifsc_encrypted']) ?? '') : '',
    'swift_bic' => $existing['swift_bic'] ?? '',
    'payment_terms' => $existing['payment_terms'] ?? '',
    'preferred_currency' => $existing['preferred_currency'] ?? 'INR',
];
$hasStoredAccountNumber = $existing !== false && $existing['account_number_encrypted'] !== null;
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    foreach (['billing_name', 'billing_address', 'gstin', 'pan', 'bank_name', 'account_holder', 'account_number', 'ifsc', 'swift_bic', 'payment_terms', 'preferred_currency'] as $key) {
        $old[$key] = trim((string) ($_POST[$key] ?? ''));
    }

    if (!$errors) {
        $accountNumberEncrypted = $old['account_number'] !== '' ? encrypt_value($old['account_number']) : ($existing['account_number_encrypted'] ?? null);
        $accountNumberHash = $old['account_number'] !== '' ? searchable_hash($old['account_number']) : ($existing['account_number_hash'] ?? null);

        db()->prepare(
            'INSERT INTO b2b_partner_billing (b2b_partner_id, billing_name, billing_address, gstin, pan, bank_name_encrypted, account_holder_encrypted, account_number_encrypted, account_number_hash, ifsc_encrypted, swift_bic, payment_terms, preferred_currency)
             VALUES (:id, :billing_name, :billing_address, :gstin, :pan, :bank_name, :account_holder, :account_number, :account_hash, :ifsc, :swift, :terms, :currency)
             ON DUPLICATE KEY UPDATE billing_name = VALUES(billing_name), billing_address = VALUES(billing_address), gstin = VALUES(gstin), pan = VALUES(pan),
                bank_name_encrypted = VALUES(bank_name_encrypted), account_holder_encrypted = VALUES(account_holder_encrypted),
                account_number_encrypted = VALUES(account_number_encrypted), account_number_hash = VALUES(account_number_hash),
                ifsc_encrypted = VALUES(ifsc_encrypted), swift_bic = VALUES(swift_bic), payment_terms = VALUES(payment_terms), preferred_currency = VALUES(preferred_currency)'
        )->execute([
            'id' => $partner['id'],
            'billing_name' => $old['billing_name'] !== '' ? $old['billing_name'] : null,
            'billing_address' => $old['billing_address'] !== '' ? $old['billing_address'] : null,
            'gstin' => $old['gstin'] !== '' ? strtoupper($old['gstin']) : null,
            'pan' => $old['pan'] !== '' ? strtoupper($old['pan']) : null,
            'bank_name' => $old['bank_name'] !== '' ? encrypt_value($old['bank_name']) : ($existing['bank_name_encrypted'] ?? null),
            'account_holder' => $old['account_holder'] !== '' ? encrypt_value($old['account_holder']) : ($existing['account_holder_encrypted'] ?? null),
            'account_number' => $accountNumberEncrypted,
            'account_hash' => $accountNumberHash,
            'ifsc' => $old['ifsc'] !== '' ? encrypt_value($old['ifsc']) : ($existing['ifsc_encrypted'] ?? null),
            'swift' => $old['swift_bic'] !== '' ? $old['swift_bic'] : null,
            'terms' => $old['payment_terms'] !== '' ? $old['payment_terms'] : null,
            'currency' => $old['preferred_currency'] !== '' ? $old['preferred_currency'] : 'INR',
        ]);

        redirect('/b2b/register-declaration/');
    }
}

$pageTitle = 'Become a B2B Travel Partner - Step 5 - Visagiri';
$canonicalUrl = APP_URL . '/b2b/register-billing/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:640px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(5); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <div class="alert alert-info">Banking details are encrypted and visible only to authorized finance/admin staff — never shown in plain text anywhere else in the system. This step is optional; you can add it later from your dashboard.</div>
        <form method="post" action="/b2b/register-billing/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Billing Details</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="billing_name">Billing Name</label>
                    <input class="form-input" type="text" id="billing_name" name="billing_name" value="<?= e($old['billing_name']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="gstin">GST Number</label>
                    <input class="form-input" type="text" id="gstin" name="gstin" value="<?= e($old['gstin']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="pan">PAN</label>
                    <input class="form-input" type="text" id="pan" name="pan" value="<?= e($old['pan']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="preferred_currency">Preferred Currency</label>
                    <input class="form-input" type="text" id="preferred_currency" name="preferred_currency" value="<?= e($old['preferred_currency']) ?>" maxlength="3" style="text-transform:uppercase">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="billing_address">Billing Address</label>
                <textarea class="form-input" id="billing_address" name="billing_address" rows="2"><?= e($old['billing_address']) ?></textarea>
            </div>

            <h2>Bank Account</h2>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="bank_name">Bank Name</label>
                    <input class="form-input" type="text" id="bank_name" name="bank_name" value="<?= e($old['bank_name']) ?>" autocomplete="off">
                </div>
                <div class="form-group">
                    <label class="form-label" for="account_holder">Account Holder Name</label>
                    <input class="form-input" type="text" id="account_holder" name="account_holder" value="<?= e($old['account_holder']) ?>" autocomplete="off">
                </div>
                <div class="form-group">
                    <label class="form-label" for="account_number">Account Number<?= $hasStoredAccountNumber ? ' (leave blank to keep existing)' : '' ?></label>
                    <input class="form-input" type="text" id="account_number" name="account_number" value="" autocomplete="off" placeholder="<?= $hasStoredAccountNumber ? '••••••••••••' : '' ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="ifsc">IFSC</label>
                    <input class="form-input" type="text" id="ifsc" name="ifsc" value="<?= e($old['ifsc']) ?>" autocomplete="off">
                </div>
                <div class="form-group">
                    <label class="form-label" for="swift_bic">SWIFT / BIC (international partners)</label>
                    <input class="form-input" type="text" id="swift_bic" name="swift_bic" value="<?= e($old['swift_bic']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="payment_terms">Payment Terms</label>
                    <input class="form-input" type="text" id="payment_terms" name="payment_terms" value="<?= e($old['payment_terms']) ?>" placeholder="e.g. Net 15">
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-4)">Continue &rarr;</button>
            <p style="text-align:center;margin-top:var(--space-3)"><a href="/b2b/register-declaration/">Skip for now</a></p>
        </form>
    </div>
</section>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
