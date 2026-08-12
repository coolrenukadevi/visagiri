<?php
declare(strict_types=1);

$pdo = db();
$countries = $pdo->query('SELECT id, name FROM countries ORDER BY name')->fetchAll();
$visaTypesList = $pdo->query('SELECT id, name FROM visa_types ORDER BY sort_order')->fetchAll();

$countryId = (int) ($_GET['country_id'] ?? $_POST['country_id'] ?? 0);
$visaTypeId = (int) ($_GET['visa_type_id'] ?? $_POST['visa_type_id'] ?? 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    if (($_POST['action'] ?? '') === 'delete' && $countryId && $visaTypeId) {
        $pdo->prepare('DELETE FROM visa_requirements WHERE country_id = :c AND visa_type_id = :v')
            ->execute(['c' => $countryId, 'v' => $visaTypeId]);
        flash_set('admin_notice', 'Requirement removed — the page will show "not yet verified" again.');
        redirect('/admin/visa-requirements/');
    }

    if (($_POST['action'] ?? '') === 'save' && $countryId && $visaTypeId) {
        $data = [
            'country_id' => $countryId,
            'visa_type_id' => $visaTypeId,
            'eligibility' => trim((string) ($_POST['eligibility'] ?? '')) ?: null,
            'documents_required' => trim((string) ($_POST['documents_required'] ?? '')) ?: null,
            'application_process' => trim((string) ($_POST['application_process'] ?? '')) ?: null,
            'processing_time' => trim((string) ($_POST['processing_time'] ?? '')) ?: null,
            'government_fee' => ($_POST['government_fee'] ?? '') !== '' ? (float) $_POST['government_fee'] : null,
            'service_fee' => ($_POST['service_fee'] ?? '') !== '' ? (float) $_POST['service_fee'] : null,
            'currency' => trim((string) ($_POST['currency'] ?? 'INR')) ?: 'INR',
            'validity_period' => trim((string) ($_POST['validity_period'] ?? '')) ?: null,
            'stay_duration' => trim((string) ($_POST['stay_duration'] ?? '')) ?: null,
            'entry_type' => trim((string) ($_POST['entry_type'] ?? '')) ?: null,
            'biometrics_required' => isset($_POST['biometrics_required']) ? 1 : 0,
            'interview_required' => isset($_POST['interview_required']) ? 1 : 0,
            'notes' => trim((string) ($_POST['notes'] ?? '')) ?: null,
            'source_url' => trim((string) ($_POST['source_url'] ?? '')) ?: null,
            'last_verified_at' => date('Y-m-d H:i:s'),
        ];

        $cols = implode(', ', array_keys($data));
        $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
        $updates = implode(', ', array_map(static fn($k) => "$k = VALUES($k)", array_keys($data)));
        $pdo->prepare("INSERT INTO visa_requirements ($cols) VALUES ($placeholders) ON DUPLICATE KEY UPDATE $updates")->execute($data);

        flash_set('admin_notice', 'Requirement saved and marked verified today.');
        redirect("/admin/visa-requirements/?country_id=$countryId&visa_type_id=$visaTypeId");
    }
}

$requirement = null;
if ($countryId && $visaTypeId) {
    $requirement = fetch_visa_requirement($countryId, $visaTypeId);
}

$published = $pdo->query(
    'SELECT r.*, c.name AS country_name, v.name AS visa_type_name FROM visa_requirements r
     JOIN countries c ON c.id = r.country_id JOIN visa_types v ON v.id = r.visa_type_id
     ORDER BY r.updated_at DESC LIMIT 50'
)->fetchAll();

admin_header_start('Visa Requirements', 'countries');
?>
<div class="admin-form-card" style="max-width:900px">
    <h2 class="country-directory__subheading" style="margin-top:0">Select country + visa type</h2>
    <form method="get" action="/admin/visa-requirements/" class="admin-form-grid">
        <div class="form-group">
            <label class="form-label" for="country_id">Country</label>
            <select class="form-select" id="country_id" name="country_id" required>
                <option value="">Select country</option>
                <?php foreach ($countries as $c): ?>
                <option value="<?= (int) $c['id'] ?>"<?= $countryId === (int) $c['id'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="form-group">
            <label class="form-label" for="visa_type_id">Visa Type</label>
            <select class="form-select" id="visa_type_id" name="visa_type_id" required>
                <option value="">Select visa type</option>
                <?php foreach ($visaTypesList as $t): ?>
                <option value="<?= (int) $t['id'] ?>"<?= $visaTypeId === (int) $t['id'] ? ' selected' : '' ?>><?= e($t['name']) ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="form-group" style="align-self:end"><button type="submit" class="btn btn-outline">Load</button></div>
    </form>

    <?php if ($countryId && $visaTypeId): ?>
    <hr style="margin:var(--space-6) 0;border:none;border-top:1px solid var(--border-color)">
    <form method="post" action="/admin/visa-requirements/">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="save">
        <input type="hidden" name="country_id" value="<?= $countryId ?>">
        <input type="hidden" name="visa_type_id" value="<?= $visaTypeId ?>">
        <div class="form-group">
            <label class="form-label" for="eligibility">Eligibility</label>
            <textarea class="form-input" id="eligibility" name="eligibility" rows="2"><?= e($requirement['eligibility'] ?? '') ?></textarea>
        </div>
        <div class="form-group">
            <label class="form-label" for="documents_required">Required Documents</label>
            <textarea class="form-input" id="documents_required" name="documents_required" rows="2"><?= e($requirement['documents_required'] ?? '') ?></textarea>
        </div>
        <div class="form-group">
            <label class="form-label" for="application_process">Application Process</label>
            <textarea class="form-input" id="application_process" name="application_process" rows="2"><?= e($requirement['application_process'] ?? '') ?></textarea>
        </div>
        <div class="admin-form-grid">
            <div class="form-group"><label class="form-label" for="processing_time">Processing Time</label><input class="form-input" type="text" id="processing_time" name="processing_time" value="<?= e($requirement['processing_time'] ?? '') ?>"></div>
            <div class="form-group"><label class="form-label" for="currency">Currency</label><input class="form-input" type="text" id="currency" name="currency" value="<?= e($requirement['currency'] ?? 'INR') ?>"></div>
            <div class="form-group"><label class="form-label" for="government_fee">Government Fee</label><input class="form-input" type="number" step="0.01" id="government_fee" name="government_fee" value="<?= e((string) ($requirement['government_fee'] ?? '')) ?>"></div>
            <div class="form-group"><label class="form-label" for="service_fee">Service Fee</label><input class="form-input" type="number" step="0.01" id="service_fee" name="service_fee" value="<?= e((string) ($requirement['service_fee'] ?? '')) ?>"></div>
            <div class="form-group"><label class="form-label" for="validity_period">Validity Period</label><input class="form-input" type="text" id="validity_period" name="validity_period" value="<?= e($requirement['validity_period'] ?? '') ?>"></div>
            <div class="form-group"><label class="form-label" for="stay_duration">Stay Duration</label><input class="form-input" type="text" id="stay_duration" name="stay_duration" value="<?= e($requirement['stay_duration'] ?? '') ?>"></div>
            <div class="form-group"><label class="form-label" for="entry_type">Entry Type</label><input class="form-input" type="text" id="entry_type" name="entry_type" value="<?= e($requirement['entry_type'] ?? '') ?>" placeholder="e.g. Single, Multiple"></div>
            <div class="form-group"><label class="form-label" for="source_url">Official Source URL</label><input class="form-input" type="url" id="source_url" name="source_url" value="<?= e($requirement['source_url'] ?? '') ?>"></div>
        </div>
        <div class="admin-checkbox-row"><label><input type="checkbox" name="biometrics_required" <?= !empty($requirement['biometrics_required']) ? 'checked' : '' ?>> Biometrics required</label></div>
        <div class="admin-checkbox-row"><label><input type="checkbox" name="interview_required" <?= !empty($requirement['interview_required']) ? 'checked' : '' ?>> Interview required</label></div>
        <div class="form-group" style="margin-top:var(--space-3)">
            <label class="form-label" for="notes">Important Notes</label>
            <textarea class="form-input" id="notes" name="notes" rows="2"><?= e($requirement['notes'] ?? '') ?></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Save (marks verified today)</button>
        <?php if ($requirement): ?>
        <button type="submit" form="delete-requirement-form" class="btn btn-outline">Remove (revert to "not yet verified")</button>
        <?php endif; ?>
    </form>
    <?php if ($requirement): ?>
    <form id="delete-requirement-form" method="post" action="/admin/visa-requirements/" onsubmit="return confirm('Remove this published requirement?');">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="country_id" value="<?= $countryId ?>">
        <input type="hidden" name="visa_type_id" value="<?= $visaTypeId ?>">
    </form>
    <?php endif; ?>
    <?php endif; ?>
</div>

<h2 class="country-directory__subheading">Recently Updated</h2>
<?php if ($published): ?>
<table class="admin-table">
    <thead><tr><th>Country</th><th>Visa Type</th><th>Last Verified</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($published as $p): ?>
        <tr>
            <td><?= e($p['country_name']) ?></td>
            <td><?= e($p['visa_type_name']) ?></td>
            <td><?= e(date('d M Y', strtotime((string) $p['last_verified_at']))) ?></td>
            <td class="actions"><a href="/admin/visa-requirements/?country_id=<?= (int) $p['country_id'] ?>&visa_type_id=<?= (int) $p['visa_type_id'] ?>" class="btn btn-outline btn-sm">Edit</a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php else: ?>
<p class="empty-state">No visa requirements published yet.</p>
<?php endif; ?>
<?php
admin_header_end();
