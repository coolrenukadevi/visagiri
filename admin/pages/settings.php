<?php
declare(strict_types=1);

require_permission('settings.manage');

$pdo = db();

$fields = [
    'contact_phone_display' => 'Contact phone (display)',
    'contact_phone_dial' => 'Contact phone (dial, e.g. +917065819819)',
    'whatsapp_number' => 'WhatsApp number (digits only, e.g. 917065819819)',
    'contact_email' => 'Contact email',
    'mail_from_name' => 'Mail "From" name',
    'mail_from_address' => 'Mail "From" address',
    'mail_enquiry_recipients' => 'Enquiry notification recipients (comma-separated)',
    'google_apps_script_url' => 'Google Apps Script Web App URL (Sheets/Drive bridge)',
    'company_name' => 'Company name',
    'company_tagline' => 'Company tagline',
    'company_founding_date' => 'Founding date (YYYY-MM)',
    'company_cin' => 'CIN',
    'company_parent' => 'Parent company',
    'grievance_sla_hours' => 'Grievance SLA (hours to first resolution target)',
    'legal_registered_office_address' => 'Registered office address (shown on legal pages when set)',
    'legal_governing_law' => 'Governing law clause (shown on legal pages when set)',
    'legal_jurisdiction_city' => 'Jurisdiction city (shown on legal pages when set)',
    'legal_grievance_officer_name' => 'Grievance officer name (shown on Grievance page when set)',
    'legal_grievance_officer_email' => 'Grievance officer email (shown on Grievance page when set)',
    'legal_privacy_updated_at' => 'Privacy Policy — last updated (YYYY-MM-DD)',
    'legal_terms_updated_at' => 'Terms & Conditions — last updated (YYYY-MM-DD)',
    'legal_travel_terms_updated_at' => 'Travel Terms — last updated (YYYY-MM-DD)',
    'legal_payment_policy_updated_at' => 'Payment Policy — last updated (YYYY-MM-DD)',
    'legal_refund_policy_updated_at' => 'Refund Policy — last updated (YYYY-MM-DD)',
    'legal_cookie_policy_updated_at' => 'Cookie Policy — last updated (YYYY-MM-DD)',
    'legal_grievance_updated_at' => 'Grievance Redressal — last updated (YYYY-MM-DD)',
];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $stmt = $pdo->prepare('INSERT INTO site_settings (setting_key, setting_value) VALUES (:k, :v) ON DUPLICATE KEY UPDATE setting_value = :v');
    foreach (array_keys($fields) as $key) {
        $stmt->execute(['k' => $key, 'v' => trim((string) ($_POST[$key] ?? ''))]);
    }
    flash_set('admin_notice', 'Settings saved.');
    redirect('/admin/settings/');
}

$current = site_settings();

admin_header_start('Settings', 'settings');
?>
<div class="admin-form-card" style="max-width:900px">
    <form method="post" action="/admin/settings/">
        <?= csrf_field() ?>
        <div class="admin-form-grid">
            <?php foreach ($fields as $key => $label): ?>
            <div class="form-group">
                <label class="form-label" for="<?= e($key) ?>"><?= e($label) ?></label>
                <input class="form-input" type="text" id="<?= e($key) ?>" name="<?= e($key) ?>" value="<?= e($current[$key] ?? '') ?>">
            </div>
            <?php endforeach; ?>
        </div>
        <button type="submit" class="btn btn-primary" style="margin-top:var(--space-4)">Save Settings</button>
    </form>
</div>
<?php
admin_header_end();
