<?php
declare(strict_types=1);

/**
 * Admin-editable country compliance rules — driving the automatic
 * document checklist (section 18). Ships with no rows: this project
 * never asserts a country's visa requirement as fact without it
 * being entered by an authorized user. Until a country has a rule
 * here, forex_delivery_blockers()/forex_document_completion() apply
 * the safe full-checklist default rather than silently requiring
 * nothing — see includes/forex.php.
 */

require_permission('forex.country_rules.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('DELETE FROM forex_country_rules WHERE id = :id')->execute(['id' => $id]);
        flash_set('admin_notice', 'Country rule removed — that country now falls back to the full standard checklist.');
        redirect('/admin/forex-country-rules/');
    }

    if ($postAction === 'save') {
        $data = [
            'country' => trim((string) ($_POST['country'] ?? '')),
            'default_currency_code' => strtoupper(trim((string) ($_POST['default_currency_code'] ?? ''))) ?: null,
            'visa_required' => in_array($_POST['visa_required'] ?? '', ['required', 'not_required', 'visa_on_arrival', 'visa_free', 'evisa', 'other'], true) ? $_POST['visa_required'] : 'required',
            'requires_passport' => isset($_POST['requires_passport']) ? 1 : 0,
            'requires_pan' => isset($_POST['requires_pan']) ? 1 : 0,
            'requires_air_ticket' => isset($_POST['requires_air_ticket']) ? 1 : 0,
            'requires_hotel' => isset($_POST['requires_hotel']) ? 1 : 0,
            'requires_visa_copy' => isset($_POST['requires_visa_copy']) ? 1 : 0,
            'requires_declaration' => isset($_POST['requires_declaration']) ? 1 : 0,
            'special_compliance_notes' => trim((string) ($_POST['special_compliance_notes'] ?? '')) ?: null,
            'updated_by' => current_admin_id(),
        ];
        if ($data['country'] === '') {
            flash_set('admin_error', 'Country name is required.');
            redirect($id ? "/admin/forex-country-rules/?action=edit&id=$id" : '/admin/forex-country-rules/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $setClause = implode(', ', array_map(static fn($k) => "$k = :$k", array_diff(array_keys($data), ['id'])));
            $pdo->prepare("UPDATE forex_country_rules SET $setClause WHERE id = :id")->execute($data);
            log_action('update', 'forex_country_rules', $id);
            flash_set('admin_notice', 'Country rule updated.');
        } else {
            $cols = implode(', ', array_keys($data));
            $placeholders = implode(', ', array_map(static fn($k) => ":$k", array_keys($data)));
            try {
                $pdo->prepare("INSERT INTO forex_country_rules ($cols) VALUES ($placeholders)")->execute($data);
            } catch (PDOException $e) {
                if ($e->getCode() === '23000') {
                    flash_set('admin_error', 'A rule for that country already exists — edit it instead.');
                    redirect('/admin/forex-country-rules/');
                }
                throw $e;
            }
            log_action('create', 'forex_country_rules', (int) $pdo->lastInsertId());
            flash_set('admin_notice', 'Country rule added.');
        }
        redirect('/admin/forex-country-rules/');
    }
}

if ($action === 'create' || $action === 'edit') {
    $rule = [
        'country' => '', 'default_currency_code' => '', 'visa_required' => 'required',
        'requires_passport' => 1, 'requires_pan' => 1, 'requires_air_ticket' => 1, 'requires_hotel' => 1,
        'requires_visa_copy' => 1, 'requires_declaration' => 0, 'special_compliance_notes' => '',
    ];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM forex_country_rules WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'Country rule not found.');
            redirect('/admin/forex-country-rules/');
        }
        $rule = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit Country Rule' : 'Add Country Rule', 'forex-country-rules');
    ?>
    <div class="admin-form-card" style="max-width:700px">
        <form method="post" action="/admin/forex-country-rules/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label">Country</label><input class="form-input" type="text" name="country" value="<?= e($rule['country']) ?>" required<?= $action === 'edit' ? ' readonly' : '' ?>></div>
                <div class="form-group"><label class="form-label">Default Currency</label><input class="form-input" type="text" name="default_currency_code" maxlength="3" value="<?= e($rule['default_currency_code'] ?? '') ?>"></div>
                <div class="form-group">
                    <label class="form-label">Visa Status Category</label>
                    <select class="form-select" name="visa_required">
                        <?php foreach (['required' => 'Visa Required', 'not_required' => 'Not Required', 'visa_on_arrival' => 'Visa on Arrival', 'visa_free' => 'Visa-Free', 'evisa' => 'eVisa', 'other' => 'Other'] as $val => $label): ?>
                        <option value="<?= $val ?>"<?= $rule['visa_required'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="card" style="margin:var(--space-4) 0">
                <div class="card-title">Required Documents</div>
                <?php foreach (['requires_passport' => 'Passport', 'requires_pan' => 'PAN', 'requires_air_ticket' => 'Air Ticket', 'requires_hotel' => 'Hotel Booking', 'requires_visa_copy' => 'Visa Copy', 'requires_declaration' => 'Visa-on-Arrival/Visa-Free Declaration'] as $field => $label): ?>
                <label style="display:flex;gap:var(--space-2);align-items:center;margin-bottom:var(--space-2)"><input type="checkbox" name="<?= $field ?>"<?= (int) $rule[$field] === 1 ? ' checked' : '' ?>> <?= $label ?></label>
                <?php endforeach; ?>
            </div>
            <div class="form-group"><label class="form-label">Special Compliance Notes</label><textarea class="form-input" name="special_compliance_notes" rows="3"><?= e($rule['special_compliance_notes'] ?? '') ?></textarea></div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="/admin/forex-country-rules/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$rules = $pdo->query('SELECT * FROM forex_country_rules ORDER BY country')->fetchAll();

admin_header_start('Forex Country Rules', 'forex-country-rules');
?>
<div class="alert alert-info">These rules drive the automatic document checklist per country. A country with no rule here still gets the full standard checklist (passport, PAN, air ticket, hotel, visa or declaration) — nothing is ever silently skipped for an unconfigured country. This is a record-management tool, not a substitute for the company's own legal/compliance review of applicable FEMA/RBI/visa rules.</div>
<div class="admin-toolbar">
    <a href="/admin/forex-country-rules/?action=create" class="btn btn-primary">+ Add Country Rule</a>
</div>
<table class="admin-table">
    <thead><tr><th>Country</th><th>Visa Status</th><th>Documents Required</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($rules as $r): ?>
        <tr>
            <td><?= e($r['country']) ?></td>
            <td><?= e(ucwords(str_replace('_', ' ', $r['visa_required']))) ?></td>
            <td>
                <?php
                $labels = [];
                foreach (['requires_passport' => 'Passport', 'requires_pan' => 'PAN', 'requires_air_ticket' => 'Air Ticket', 'requires_hotel' => 'Hotel', 'requires_visa_copy' => 'Visa', 'requires_declaration' => 'Declaration'] as $field => $label) {
                    if ((int) $r[$field] === 1) {
                        $labels[] = $label;
                    }
                }
                echo e(implode(', ', $labels) ?: 'None');
                ?>
            </td>
            <td class="actions">
                <a href="/admin/forex-country-rules/?action=edit&id=<?= (int) $r['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/forex-country-rules/" style="display:inline" onsubmit="return confirm('Remove this country rule?');">
                    <?= csrf_field() ?>
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<?= (int) $r['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Remove</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$rules): ?>
        <tr><td colspan="4"><p class="empty-state">No country rules configured yet — every request currently falls back to the full standard checklist.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
