<?php
declare(strict_types=1);

/**
 * Visa Checklist Engine — admin CRUD. Until now every row in
 * visa_checklists/visa_checklist_sections/visa_checklist_documents/
 * visa_fees was written by raw SQL seed files (see AUDIT.md's "Visa
 * Checklist Engine" entry) — this is the first admin UI for that
 * data. Reuses the existing tables/columns exactly as designed
 * (status ENUM draft/published/archived, visa_checklist_revisions,
 * visa_fees/visa_fee_history via includes/visa-checklist.php's
 * set_visa_fee()) — no new schema, per the approved Phase 3 scope.
 *
 * A checklist is looked up here without the status='published' guard
 * that includes/visa-checklist.php's public fetch_visa_checklist()
 * applies — an editor must be able to see and work on a draft.
 */

require_permission('content.view');

// Matches the abbreviation convention already used across all 140+
// seeded checklist references (e.g. "MEX-TOUR-IN-01") — see AUDIT.md.
const CHECKLIST_TYPE_CODES = [
    1 => 'TOUR', 2 => 'BUS', 3 => 'STU', 4 => 'WORK', 5 => 'FAM',
    6 => 'TRANS', 7 => 'MED', 8 => 'CONF', 9 => 'SPORT', 10 => 'DEP',
];
const CHECKLIST_STATUS_BADGES = ['draft' => 'neutral', 'published' => 'success', 'archived' => 'warning'];
const DOCUMENT_TYPE_LABELS = ['original' => 'Original', 'copy' => 'Copy', 'both' => 'Original + Copy', 'if_applicable' => 'If Applicable'];

$pdo = db();
$admin = current_admin();
$adminName = $admin['full_name'] ?? 'Admin';
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$countries = $pdo->query('SELECT id, name, iso3 FROM countries ORDER BY name')->fetchAll();
$visaTypesList = $pdo->query('SELECT id, name FROM visa_types ORDER BY sort_order')->fetchAll();
$visaTypeNames = array_column($visaTypesList, 'name', 'id');

// --- POST handling ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('content.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'create_checklist') {
        $countryId = (int) ($_POST['country_id'] ?? 0);
        $visaTypeId = (int) ($_POST['visa_type_id'] ?? 0);
        $reference = trim((string) ($_POST['reference'] ?? ''));
        $version = trim((string) ($_POST['version'] ?? '')) ?: date('Y.m');

        if (!$countryId || !$visaTypeId || $reference === '') {
            flash_set('admin_error', 'Country, visa type, and reference are required.');
            redirect('/admin/visa-checklists/?action=create');
        }

        $dupStmt = $pdo->prepare('SELECT id FROM visa_checklists WHERE country_id = :c AND visa_type_id = :v');
        $dupStmt->execute(['c' => $countryId, 'v' => $visaTypeId]);
        if ($dupStmt->fetchColumn()) {
            flash_set('admin_error', 'A checklist for this country + visa type already exists.');
            redirect('/admin/visa-checklists/?action=create');
        }

        $pdo->prepare(
            "INSERT INTO visa_checklists (country_id, visa_type_id, reference, version, status, source, source_url, disclaimer)
             VALUES (:country_id, :visa_type_id, :reference, :version, 'draft', :source, :source_url, :disclaimer)"
        )->execute([
            'country_id' => $countryId,
            'visa_type_id' => $visaTypeId,
            'reference' => $reference,
            'version' => $version,
            'source' => trim((string) ($_POST['source'] ?? '')) ?: null,
            'source_url' => trim((string) ($_POST['source_url'] ?? '')) ?: null,
            'disclaimer' => trim((string) ($_POST['disclaimer'] ?? '')) ?: null,
        ]);
        $newId = (int) $pdo->lastInsertId();
        $pdo->prepare('INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (:id, :version, :summary, :who)')
            ->execute(['id' => $newId, 'version' => $version, 'summary' => 'Checklist created (draft)', 'who' => $adminName]);
        log_action('create', 'visa_checklists', $newId, null, $reference);
        flash_set('admin_notice', "Checklist $reference created as a draft.");
        redirect('/admin/visa-checklists/?action=view&id=' . $newId);
    }

    if ($postAction === 'delete_checklist' && $id) {
        $stmt = $pdo->prepare('SELECT reference FROM visa_checklists WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $oldRef = $stmt->fetchColumn() ?: null;
        $pdo->prepare('DELETE FROM visa_checklists WHERE id = :id')->execute(['id' => $id]);
        log_action('delete', 'visa_checklists', $id, $oldRef, null);
        flash_set('admin_notice', 'Checklist deleted (sections and documents removed with it).');
        redirect('/admin/visa-checklists/');
    }

    if ($postAction === 'update_checklist_meta' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM visa_checklists WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $old = $stmt->fetch();
        if (!$old) {
            flash_set('admin_error', 'Checklist not found.');
            redirect('/admin/visa-checklists/');
        }

        $status = in_array($_POST['status'] ?? '', ['draft', 'published', 'archived'], true) ? $_POST['status'] : $old['status'];
        $version = trim((string) ($_POST['version'] ?? '')) ?: $old['version'];
        $changeSummary = trim((string) ($_POST['change_summary'] ?? ''));

        $data = [
            'id' => $id,
            'version' => $version,
            'status' => $status,
            'source' => trim((string) ($_POST['source'] ?? '')) ?: null,
            'source_url' => trim((string) ($_POST['source_url'] ?? '')) ?: null,
            'disclaimer' => trim((string) ($_POST['disclaimer'] ?? '')) ?: null,
            'last_reviewed_at' => trim((string) ($_POST['last_reviewed_at'] ?? '')) ?: null,
        ];
        $pdo->prepare(
            'UPDATE visa_checklists SET version=:version, status=:status, source=:source, source_url=:source_url,
             disclaimer=:disclaimer, last_reviewed_at=:last_reviewed_at WHERE id=:id'
        )->execute($data);

        // A revision entry every time the meta form is saved — never a
        // silent overwrite of a checklist's history — using the admin's
        // note when given, otherwise a factual summary of what changed.
        $summary = $changeSummary !== '' ? $changeSummary : "Status: {$old['status']} \u{2192} $status, Version: {$old['version']} \u{2192} $version";
        $pdo->prepare('INSERT INTO visa_checklist_revisions (checklist_id, version, change_summary, updated_by) VALUES (:id, :version, :summary, :who)')
            ->execute(['id' => $id, 'version' => $version, 'summary' => $summary, 'who' => $adminName]);
        log_action('update', 'visa_checklists', $id, $old['status'] . '/' . $old['version'], $status . '/' . $version);
        flash_set('admin_notice', 'Checklist updated.');
        redirect('/admin/visa-checklists/?action=view&id=' . $id);
    }

    if ($postAction === 'update_fee' && $id) {
        $stmt = $pdo->prepare('SELECT country_id, visa_type_id FROM visa_checklists WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $checklist = $stmt->fetch();
        if (!$checklist) {
            flash_set('admin_error', 'Checklist not found.');
            redirect('/admin/visa-checklists/');
        }
        $amount = ($_POST['amount'] ?? '') !== '' ? (float) $_POST['amount'] : null;
        set_visa_fee(
            (int) $checklist['country_id'],
            (int) $checklist['visa_type_id'],
            $amount,
            trim((string) ($_POST['currency'] ?? 'USD')) ?: 'USD',
            trim((string) ($_POST['label'] ?? '')) ?: null,
            trim((string) ($_POST['note'] ?? '')) ?: null,
            trim((string) ($_POST['effective_date'] ?? '')) ?: null,
            trim((string) ($_POST['fee_source_url'] ?? '')) ?: null,
            $adminName,
            'Updated via Visa Checklists admin'
        );
        log_action('update', 'visa_fees', $id, null, $amount !== null ? (string) $amount : null);
        flash_set('admin_notice', 'Fee updated.');
        redirect('/admin/visa-checklists/?action=view&id=' . $id);
    }

    if ($postAction === 'add_section' && $id) {
        $title = trim((string) ($_POST['title'] ?? ''));
        if ($title !== '') {
            $pdo->prepare('INSERT INTO visa_checklist_sections (checklist_id, title, description, display_order) VALUES (:id, :title, :description, :order)')
                ->execute(['id' => $id, 'title' => $title, 'description' => trim((string) ($_POST['description'] ?? '')) ?: null, 'order' => (int) ($_POST['display_order'] ?? 0)]);
            log_action('create', 'visa_checklist_sections', (int) $pdo->lastInsertId(), null, $title);
            flash_set('admin_notice', 'Section added.');
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $id);
    }

    if ($postAction === 'update_section') {
        $sectionId = (int) ($_POST['section_id'] ?? 0);
        $checklistId = (int) ($_POST['checklist_id'] ?? 0);
        if ($sectionId && $checklistId) {
            $title = trim((string) ($_POST['title'] ?? ''));
            $pdo->prepare('UPDATE visa_checklist_sections SET title=:title, description=:description, display_order=:order WHERE id=:id AND checklist_id=:checklist_id')
                ->execute(['title' => $title, 'description' => trim((string) ($_POST['description'] ?? '')) ?: null, 'order' => (int) ($_POST['display_order'] ?? 0), 'id' => $sectionId, 'checklist_id' => $checklistId]);
            log_action('update', 'visa_checklist_sections', $sectionId, null, $title);
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $checklistId);
    }

    if ($postAction === 'delete_section') {
        $sectionId = (int) ($_POST['section_id'] ?? 0);
        $checklistId = (int) ($_POST['checklist_id'] ?? 0);
        if ($sectionId) {
            $pdo->prepare('DELETE FROM visa_checklist_sections WHERE id = :id')->execute(['id' => $sectionId]);
            log_action('delete', 'visa_checklist_sections', $sectionId, null, null);
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $checklistId);
    }

    if ($postAction === 'add_document') {
        $sectionId = (int) ($_POST['section_id'] ?? 0);
        $checklistId = (int) ($_POST['checklist_id'] ?? 0);
        $name = trim((string) ($_POST['name'] ?? ''));
        if ($sectionId && $name !== '') {
            $pdo->prepare(
                'INSERT INTO visa_checklist_documents (section_id, name, description, document_type, mandatory, conditional, is_public, source_note, display_order)
                 VALUES (:section_id, :name, :description, :document_type, :mandatory, :conditional, :is_public, :source_note, :order)'
            )->execute([
                'section_id' => $sectionId,
                'name' => $name,
                'description' => trim((string) ($_POST['description'] ?? '')) ?: null,
                'document_type' => in_array($_POST['document_type'] ?? '', array_keys(DOCUMENT_TYPE_LABELS), true) ? $_POST['document_type'] : 'copy',
                'mandatory' => isset($_POST['mandatory']) ? 1 : 0,
                'conditional' => isset($_POST['conditional']) ? 1 : 0,
                'is_public' => isset($_POST['is_public']) ? 1 : 0,
                'source_note' => trim((string) ($_POST['source_note'] ?? '')) ?: null,
                'order' => (int) ($_POST['display_order'] ?? 0),
            ]);
            log_action('create', 'visa_checklist_documents', (int) $pdo->lastInsertId(), null, $name);
            flash_set('admin_notice', 'Document added.');
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $checklistId);
    }

    if ($postAction === 'update_document') {
        $docId = (int) ($_POST['doc_id'] ?? 0);
        $checklistId = (int) ($_POST['checklist_id'] ?? 0);
        if ($docId) {
            $name = trim((string) ($_POST['name'] ?? ''));
            $pdo->prepare(
                'UPDATE visa_checklist_documents SET name=:name, description=:description, document_type=:document_type,
                 mandatory=:mandatory, conditional=:conditional, is_public=:is_public, source_note=:source_note, display_order=:order WHERE id=:id'
            )->execute([
                'name' => $name,
                'description' => trim((string) ($_POST['description'] ?? '')) ?: null,
                'document_type' => in_array($_POST['document_type'] ?? '', array_keys(DOCUMENT_TYPE_LABELS), true) ? $_POST['document_type'] : 'copy',
                'mandatory' => isset($_POST['mandatory']) ? 1 : 0,
                'conditional' => isset($_POST['conditional']) ? 1 : 0,
                'is_public' => isset($_POST['is_public']) ? 1 : 0,
                'source_note' => trim((string) ($_POST['source_note'] ?? '')) ?: null,
                'order' => (int) ($_POST['display_order'] ?? 0),
                'id' => $docId,
            ]);
            log_action('update', 'visa_checklist_documents', $docId, null, $name);
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $checklistId);
    }

    if ($postAction === 'delete_document') {
        $docId = (int) ($_POST['doc_id'] ?? 0);
        $checklistId = (int) ($_POST['checklist_id'] ?? 0);
        if ($docId) {
            $pdo->prepare('DELETE FROM visa_checklist_documents WHERE id = :id')->execute(['id' => $docId]);
            log_action('delete', 'visa_checklist_documents', $docId, null, null);
        }
        redirect('/admin/visa-checklists/?action=view&id=' . $checklistId);
    }
}

// --- Create form ---
if ($action === 'create') {
    require_permission('content.manage');
    admin_header_start('New Visa Checklist', 'visa-checklists');
    admin_subnav('content', 'visa-checklists');
    ?>
    <div class="admin-form-card" style="max-width:760px">
        <p style="color:var(--text-muted);margin-top:0">
            Country + visa type together identify the checklist — exactly one checklist can exist per pair.
            The reference and version are suggested from your selection but can be edited before saving.
        </p>
        <form method="post" action="/admin/visa-checklists/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="create_checklist">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="country_id">Country</label>
                    <select class="form-select" id="country_id" name="country_id" required>
                        <option value="">Select country</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= (int) $c['id'] ?>" data-iso3="<?= e($c['iso3'] ?? '') ?>"><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="visa_type_id">Visa Type</label>
                    <select class="form-select" id="visa_type_id" name="visa_type_id" required>
                        <option value="">Select visa type</option>
                        <?php foreach ($visaTypesList as $t): ?>
                        <option value="<?= (int) $t['id'] ?>"><?= e($t['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="reference">Reference</label>
                    <input class="form-input" type="text" id="reference" name="reference" placeholder="e.g. MEX-TOUR-IN-01" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="version">Version</label>
                    <input class="form-input" type="text" id="version" name="version" value="<?= e(date('Y.m')) ?>" placeholder="e.g. 2026.09">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="source">Source</label>
                <input class="form-input" type="text" id="source" name="source" placeholder="e.g. Embassy of Mexico in India — official visa page">
            </div>
            <div class="form-group">
                <label class="form-label" for="source_url">Source URL</label>
                <input class="form-input" type="url" id="source_url" name="source_url">
            </div>
            <div class="form-group">
                <label class="form-label" for="disclaimer">Disclaimer (optional — falls back to the standard disclaimer when blank)</label>
                <textarea class="form-input" id="disclaimer" name="disclaimer" rows="2"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Create Checklist (as Draft)</button>
            <a href="/admin/visa-checklists/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

// --- View / edit ---
if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT vc.*, c.name AS country_name, v.name AS visa_type_name
         FROM visa_checklists vc JOIN countries c ON c.id = vc.country_id JOIN visa_types v ON v.id = vc.visa_type_id
         WHERE vc.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $checklist = $stmt->fetch();
    if (!$checklist) {
        flash_set('admin_error', 'Checklist not found.');
        redirect('/admin/visa-checklists/');
    }

    $sectionsStmt = $pdo->prepare('SELECT * FROM visa_checklist_sections WHERE checklist_id = :id ORDER BY display_order, id');
    $sectionsStmt->execute(['id' => $id]);
    $sections = $sectionsStmt->fetchAll();

    $docsBySection = [];
    if ($sections) {
        $sectionIds = array_column($sections, 'id');
        $placeholders = implode(',', array_fill(0, count($sectionIds), '?'));
        $docsStmt = $pdo->prepare("SELECT * FROM visa_checklist_documents WHERE section_id IN ($placeholders) ORDER BY display_order, id");
        $docsStmt->execute($sectionIds);
        foreach ($docsStmt->fetchAll() as $doc) {
            $docsBySection[(int) $doc['section_id']][] = $doc;
        }
    }

    $fee = fetch_visa_fee((int) $checklist['country_id'], (int) $checklist['visa_type_id']);

    $revisionsStmt = $pdo->prepare('SELECT * FROM visa_checklist_revisions WHERE checklist_id = :id ORDER BY updated_at DESC LIMIT 25');
    $revisionsStmt->execute(['id' => $id]);
    $revisions = $revisionsStmt->fetchAll();

    $canManageContent = has_permission('content.manage');

    admin_header_start($checklist['reference'], 'visa-checklists');
    admin_subnav('content', 'visa-checklists');
    ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <div class="admin-panel__head">
            <div>
                <h2 class="country-directory__subheading" style="margin:0"><?= e($checklist['country_name']) ?> — <?= e($checklist['visa_type_name']) ?></h2>
                <p style="color:var(--text-muted);margin:2px 0 0"><?= e($checklist['reference']) ?> &middot; Version <?= e($checklist['version']) ?></p>
            </div>
            <?= status_badge($checklist['status'], CHECKLIST_STATUS_BADGES) ?>
        </div>

        <?php if ($canManageContent): ?>
        <form method="post" action="/admin/visa-checklists/" style="margin-top:var(--space-4)">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="update_checklist_meta">
            <input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="draft" <?= $checklist['status'] === 'draft' ? 'selected' : '' ?>>Draft</option>
                        <option value="published" <?= $checklist['status'] === 'published' ? 'selected' : '' ?>>Published</option>
                        <option value="archived" <?= $checklist['status'] === 'archived' ? 'selected' : '' ?>>Archived</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="version">Version</label>
                    <input class="form-input" type="text" id="version" name="version" value="<?= e($checklist['version']) ?>">
                </div>
                <div class="form-group">
                    <label class="form-label" for="last_reviewed_at">Last reviewed</label>
                    <input class="form-input" type="date" id="last_reviewed_at" name="last_reviewed_at" value="<?= e((string) ($checklist['last_reviewed_at'] ?? '')) ?>">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="source">Source</label>
                <input class="form-input" type="text" id="source" name="source" value="<?= e($checklist['source'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="source_url">Source URL</label>
                <input class="form-input" type="url" id="source_url" name="source_url" value="<?= e($checklist['source_url'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="disclaimer">Disclaimer</label>
                <textarea class="form-input" id="disclaimer" name="disclaimer" rows="2"><?= e($checklist['disclaimer'] ?? '') ?></textarea>
            </div>
            <div class="form-group">
                <label class="form-label" for="change_summary">Change summary (recorded in version history below)</label>
                <input class="form-input" type="text" id="change_summary" name="change_summary" placeholder="e.g. Added biometrics requirement per updated embassy guidance">
            </div>
            <button type="submit" class="btn btn-primary btn-sm">Save</button>
        </form>
        <form method="post" action="/admin/visa-checklists/" style="margin-top:var(--space-3)" onsubmit="return confirm('Delete this entire checklist, including all sections and documents?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete_checklist"><input type="hidden" name="id" value="<?= (int) $id ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete Checklist</button>
        </form>
        <?php else: ?>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Source: <?= e($checklist['source'] ?? '—') ?><?php if ($checklist['last_reviewed_at']): ?> &middot; Last reviewed <?= e(date('d M Y', strtotime((string) $checklist['last_reviewed_at']))) ?><?php endif; ?></p>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Fee</h2>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <?php if ($fee): ?>
        <p style="margin-top:0"><strong><?= e($fee['currency']) ?> <?= $fee['amount'] !== null ? number_format((float) $fee['amount'], 2) : '—' ?></strong><?php if ($fee['label']): ?> — <?= e($fee['label']) ?><?php endif; ?></p>
        <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Last updated <?= e(date('d M Y', strtotime((string) $fee['last_updated']))) ?> by <?= e($fee['updated_by'] ?? '—') ?></p>
        <?php else: ?>
        <p class="empty-state" style="padding:0 0 var(--space-3)">No fee set yet.</p>
        <?php endif; ?>
        <?php if ($canManageContent): ?>
        <form method="post" action="/admin/visa-checklists/">
            <?= csrf_field() ?><input type="hidden" name="action" value="update_fee"><input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <div class="form-group"><label class="form-label" for="amount">Amount</label><input class="form-input" type="number" step="0.01" id="amount" name="amount" value="<?= e((string) ($fee['amount'] ?? '')) ?>"></div>
                <div class="form-group"><label class="form-label" for="currency">Currency</label><input class="form-input" type="text" id="currency" name="currency" value="<?= e($fee['currency'] ?? 'USD') ?>"></div>
                <div class="form-group"><label class="form-label" for="label">Label</label><input class="form-input" type="text" id="label" name="label" value="<?= e($fee['label'] ?? '') ?>" placeholder="e.g. Current Consular Fee"></div>
                <div class="form-group"><label class="form-label" for="effective_date">Effective date</label><input class="form-input" type="date" id="effective_date" name="effective_date" value="<?= e((string) ($fee['effective_date'] ?? '')) ?>"></div>
                <div class="form-group"><label class="form-label" for="fee_source_url">Source URL</label><input class="form-input" type="url" id="fee_source_url" name="fee_source_url" value="<?= e($fee['source_url'] ?? '') ?>"></div>
            </div>
            <div class="form-group"><label class="form-label" for="note">Note</label><input class="form-input" type="text" id="note" name="note" value="<?= e($fee['note'] ?? '') ?>"></div>
            <button type="submit" class="btn btn-outline btn-sm">Save Fee</button>
        </form>
        <?php endif; ?>
    </div>

    <h2 class="country-directory__subheading">Sections &amp; Documents</h2>
    <?php if (!$sections): ?>
    <p class="admin-empty-state--icon"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No sections yet — add one below.</p>
    <?php else: foreach ($sections as $section): $sectionDocs = $docsBySection[(int) $section['id']] ?? []; ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-4)">
        <div class="admin-panel__head">
            <h3 class="admin-panel__title"><?= e($section['title']) ?><?php if ($section['description']): ?> <span style="font-weight:400;color:var(--text-muted);font-size:var(--font-size-sm)">— <?= e($section['description']) ?></span><?php endif; ?></h3>
        </div>
        <?php if ($sectionDocs): ?>
        <div class="admin-table-scroll">
        <table class="admin-table">
            <thead><tr><th>Document</th><th>Type</th><th>Required</th><th>Public</th><th>Note</th><?php if ($canManageContent): ?><th></th><?php endif; ?></tr></thead>
            <tbody>
            <?php foreach ($sectionDocs as $doc): ?>
            <tr>
                <td><?= e($doc['name']) ?><?php if ($doc['description']): ?><br><span style="color:var(--text-muted);font-size:var(--font-size-xs)"><?= e($doc['description']) ?></span><?php endif; ?></td>
                <td><span class="badge badge-info"><?= e(DOCUMENT_TYPE_LABELS[$doc['document_type']] ?? $doc['document_type']) ?></span></td>
                <td><span class="badge <?= $doc['mandatory'] ? 'badge-danger' : ($doc['conditional'] ? 'badge-warning' : 'badge-neutral') ?>"><?= $doc['mandatory'] ? 'Mandatory' : ($doc['conditional'] ? 'Conditional' : 'Optional') ?></span></td>
                <td><span class="badge <?= $doc['is_public'] ? 'badge-success' : 'badge-neutral' ?>"><?= $doc['is_public'] ? 'Public' : 'After enquiry' ?></span></td>
                <td><?= e($doc['source_note'] ?? '—') ?></td>
                <?php if ($canManageContent): ?>
                <td class="actions">
                    <form method="post" action="/admin/visa-checklists/" style="display:inline" onsubmit="return confirm('Delete this document?');">
                        <?= csrf_field() ?><input type="hidden" name="action" value="delete_document"><input type="hidden" name="checklist_id" value="<?= (int) $id ?>"><input type="hidden" name="doc_id" value="<?= (int) $doc['id'] ?>">
                        <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                    </form>
                </td>
                <?php endif; ?>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        </div>
        <?php endif; ?>

        <?php if ($canManageContent): ?>
        <form method="post" action="/admin/visa-checklists/" style="margin-top:var(--space-4)">
            <?= csrf_field() ?><input type="hidden" name="action" value="add_document"><input type="hidden" name="checklist_id" value="<?= (int) $id ?>"><input type="hidden" name="section_id" value="<?= (int) $section['id'] ?>">
            <div class="admin-form-grid">
                <input class="form-input" type="text" name="name" placeholder="Document name" required>
                <select class="form-select" name="document_type">
                    <?php foreach (DOCUMENT_TYPE_LABELS as $dtKey => $dtLabel): ?>
                    <option value="<?= e($dtKey) ?>"><?= e($dtLabel) ?></option>
                    <?php endforeach; ?>
                </select>
                <input class="form-input" type="text" name="source_note" placeholder="Source note (optional)">
                <input class="form-input" type="number" name="display_order" placeholder="Order" value="0">
            </div>
            <div class="admin-checkbox-row" style="margin-top:var(--space-2)">
                <label><input type="checkbox" name="mandatory" checked> Mandatory</label>
                <label><input type="checkbox" name="conditional"> Conditional</label>
                <label><input type="checkbox" name="is_public"> Show before enquiry (public)</label>
            </div>
            <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">+ Add Document</button>
        </form>
        <form method="post" action="/admin/visa-checklists/" style="margin-top:var(--space-3)" onsubmit="return confirm('Delete this section and every document in it?');">
            <?= csrf_field() ?><input type="hidden" name="action" value="delete_section"><input type="hidden" name="checklist_id" value="<?= (int) $id ?>"><input type="hidden" name="section_id" value="<?= (int) $section['id'] ?>">
            <button type="submit" class="btn btn-outline btn-sm">Delete Section</button>
        </form>
        <?php endif; ?>
    </div>
    <?php endforeach; endif; ?>

    <?php if ($canManageContent): ?>
    <div class="admin-form-card" style="margin-bottom:var(--space-6)">
        <h3 class="admin-panel__title" style="margin-top:0">Add Section</h3>
        <form method="post" action="/admin/visa-checklists/">
            <?= csrf_field() ?><input type="hidden" name="action" value="add_section"><input type="hidden" name="id" value="<?= (int) $id ?>">
            <div class="admin-form-grid">
                <input class="form-input" type="text" name="title" placeholder="Section title, e.g. Identity Documents" required>
                <input class="form-input" type="text" name="description" placeholder="Description (optional)">
                <input class="form-input" type="number" name="display_order" placeholder="Order" value="<?= count($sections) ?>">
            </div>
            <button type="submit" class="btn btn-outline btn-sm" style="margin-top:var(--space-2)">+ Add Section</button>
        </form>
    </div>
    <?php endif; ?>

    <h2 class="country-directory__subheading">Version History</h2>
    <?php if ($revisions): ?>
    <div class="admin-table-scroll">
    <table class="admin-table">
        <thead><tr><th>Version</th><th>Change</th><th>By</th><th>When</th></tr></thead>
        <tbody>
        <?php foreach ($revisions as $rev): ?>
        <tr>
            <td><?= e($rev['version']) ?></td>
            <td><?= e($rev['change_summary'] ?? '—') ?></td>
            <td><?= e($rev['updated_by'] ?? '—') ?></td>
            <td><?= e(date('d M Y H:i', strtotime((string) $rev['updated_at']))) ?></td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php else: ?>
    <p class="empty-state">No revisions recorded yet.</p>
    <?php endif; ?>

    <p style="margin-top:var(--space-6)"><a href="/admin/visa-checklists/">&larr; Back to all checklists</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$statusFilter = in_array($_GET['status'] ?? '', ['draft', 'published', 'archived'], true) ? $_GET['status'] : null;
$search = trim((string) ($_GET['q'] ?? ''));

$where = ['1=1'];
$params = [];
if ($statusFilter) {
    $where[] = 'vc.status = :status';
    $params['status'] = $statusFilter;
}
if ($search !== '') {
    $where[] = '(c.name LIKE :search OR vc.reference LIKE :search2)';
    $params['search'] = "%$search%";
    $params['search2'] = "%$search%";
}
$whereSql = implode(' AND ', $where);

$checklists = $pdo->prepare(
    "SELECT vc.id, vc.reference, vc.version, vc.status, vc.last_reviewed_at, c.name AS country_name, v.name AS visa_type_name,
            (SELECT COUNT(*) FROM visa_checklist_sections s WHERE s.checklist_id = vc.id) AS section_count,
            (SELECT COUNT(*) FROM visa_checklist_documents d JOIN visa_checklist_sections s2 ON s2.id = d.section_id WHERE s2.checklist_id = vc.id) AS document_count
     FROM visa_checklists vc
     JOIN countries c ON c.id = vc.country_id
     JOIN visa_types v ON v.id = vc.visa_type_id
     WHERE $whereSql
     ORDER BY c.name, v.sort_order
     LIMIT 200"
);
$checklists->execute($params);
$checklists = $checklists->fetchAll();

$activeFilterCount = ($statusFilter ? 1 : 0) + ($search !== '' ? 1 : 0);

admin_header_start('Visa Checklists', 'visa-checklists');
admin_subnav('content', 'visa-checklists');
?>
<p style="color:var(--text-muted);max-width:75ch;margin-bottom:var(--space-4)">
    The document checklist shown on each visa page — sections, required documents, and fees, all admin-curated
    per country + visa type. A checklist must be <strong>Published</strong> to appear on the public site.
</p>
<div class="admin-toolbar">
    <form method="get" action="/admin/visa-checklists/" style="display:flex;gap:var(--space-2)">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search country or reference…">
        <button type="submit" class="btn btn-outline">Search</button>
    </form>
    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/visa-checklists/?action=create" class="btn btn-primary">+ New Checklist</a>
    <?php endif; ?>
</div>
<div class="admin-quick-filters">
    <a href="/admin/visa-checklists/<?= $search !== '' ? '?q=' . urlencode($search) : '' ?>" class="<?= !$statusFilter ? 'is-active' : '' ?>">All</a>
    <a href="/admin/visa-checklists/?status=draft<?= $search !== '' ? '&q=' . urlencode($search) : '' ?>" class="<?= $statusFilter === 'draft' ? 'is-active' : '' ?>">Draft</a>
    <a href="/admin/visa-checklists/?status=published<?= $search !== '' ? '&q=' . urlencode($search) : '' ?>" class="<?= $statusFilter === 'published' ? 'is-active' : '' ?>">Published</a>
    <a href="/admin/visa-checklists/?status=archived<?= $search !== '' ? '&q=' . urlencode($search) : '' ?>" class="<?= $statusFilter === 'archived' ? 'is-active' : '' ?>">Archived</a>
</div>
<?php if ($checklists): ?>
<div class="admin-table-scroll" style="margin-top:var(--space-4)">
<table class="admin-table">
    <thead><tr><th>Country</th><th>Visa Type</th><th>Reference</th><th>Version</th><th>Sections / Docs</th><th>Status</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($checklists as $cl): ?>
        <tr>
            <td><?= e($cl['country_name']) ?></td>
            <td><?= e($cl['visa_type_name']) ?></td>
            <td><?= e($cl['reference']) ?></td>
            <td><?= e($cl['version']) ?></td>
            <td><?= (int) $cl['section_count'] ?> / <?= (int) $cl['document_count'] ?></td>
            <td><?= status_badge($cl['status'], CHECKLIST_STATUS_BADGES) ?></td>
            <td class="actions"><a href="/admin/visa-checklists/?action=view&id=<?= (int) $cl['id'] ?>" class="btn btn-outline btn-sm"><?= has_permission('content.manage') ? 'Edit' : 'View' ?></a></td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>
<div class="admin-card-list" style="margin-top:var(--space-4)">
    <?php foreach ($checklists as $cl): ?>
    <div class="admin-record-card">
        <p class="admin-record-card__title"><?= e($cl['country_name']) ?> — <?= e($cl['visa_type_name']) ?> <span style="font-weight:400;color:var(--text-muted)">&middot; <?= e($cl['reference']) ?></span></p>
        <div class="admin-record-card__row"><span>Version</span><strong><?= e($cl['version']) ?></strong></div>
        <div class="admin-record-card__row"><span>Sections / Docs</span><strong><?= (int) $cl['section_count'] ?> / <?= (int) $cl['document_count'] ?></strong></div>
        <div class="admin-record-card__row"><span>Status</span><strong><?= status_badge($cl['status'], CHECKLIST_STATUS_BADGES) ?></strong></div>
        <div class="admin-record-card__action"><a href="/admin/visa-checklists/?action=view&id=<?= (int) $cl['id'] ?>" class="btn btn-sm btn-outline"><?= has_permission('content.manage') ? 'Edit' : 'View' ?></a></div>
    </div>
    <?php endforeach; ?>
</div>
<?php else: ?>
<p class="admin-empty-state--icon" style="margin-top:var(--space-4)"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg><?= $activeFilterCount > 0 ? 'No checklists match this search.' : 'No checklists yet.' ?></p>
<?php endif; ?>
<?php
admin_header_end();
