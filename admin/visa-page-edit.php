<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'Edit Content Page';
$ADMIN_ACTIVE_NAV = 'visa-pages';
$ADMIN_BREADCRUMB = ['CRM', 'Content Pages', 'Edit'];
require __DIR__ . '/includes/layout-top.php';
require_once __DIR__ . '/../includes/visa-content-db.php';
visa_content_db();

$id = (int) ($_GET['id'] ?? 0);
$pageStmt = $pdo->prepare("SELECT cvp.*, c.name AS country_name, c.slug AS country_slug, c.flag AS country_flag,
        vc.name AS category_name, vc.slug AS category_slug
    FROM country_visa_pages cvp
    JOIN countries c ON c.id = cvp.country_id
    JOIN visa_categories vc ON vc.id = cvp.visa_category_id
    WHERE cvp.id = ?");
$pageStmt->execute([$id]);
$page = $pageStmt->fetch(PDO::FETCH_ASSOC);

if (!$page) {
    http_response_code(404);
    echo '<div class="crm-card">Content page not found. <a href="visa-pages.php">Back to Content Pages</a></div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'save_page') {
    $status = $_POST['status'] ?? 'draft';
    if (!in_array($status, VISA_PAGE_STATUSES, true)) { $status = 'draft'; }

    $scalar = [
        'official_visa_name' => trim($_POST['official_visa_name'] ?? '') ?: null,
        'visa_subclass_code' => trim($_POST['visa_subclass_code'] ?? '') ?: null,
        'intro_html' => trim($_POST['intro_html'] ?? '') ?: null,
        'typical_stay' => trim($_POST['typical_stay'] ?? '') ?: null,
        'entry_type' => trim($_POST['entry_type'] ?? '') ?: null,
        'processing_time_text' => trim($_POST['processing_time_text'] ?? '') ?: null,
        'validity_text' => trim($_POST['validity_text'] ?? '') ?: null,
        'application_method' => trim($_POST['application_method'] ?? '') ?: null,
        'interview_required' => trim($_POST['interview_required'] ?? '') ?: null,
        'biometric_required' => trim($_POST['biometric_required'] ?? '') ?: null,
        'government_fee_text' => trim($_POST['government_fee_text'] ?? '') ?: null,
        'application_centre' => trim($_POST['application_centre'] ?? '') ?: null,
        'authority_name' => trim($_POST['authority_name'] ?? '') ?: null,
        'authority_url' => trim($_POST['authority_url'] ?? '') ?: null,
        'eligibility_html' => trim($_POST['eligibility_html'] ?? '') ?: null,
        'indian_applicant_html' => trim($_POST['indian_applicant_html'] ?? '') ?: null,
        'seo_title' => trim($_POST['seo_title'] ?? '') ?: null,
        'meta_description' => trim($_POST['meta_description'] ?? '') ?: null,
        'og_title' => trim($_POST['og_title'] ?? '') ?: null,
        'og_description' => trim($_POST['og_description'] ?? '') ?: null,
        'canonical_override' => trim($_POST['canonical_override'] ?? '') ?: null,
        'status' => $status,
        'last_reviewed_date' => gmdate('Y-m-d'),
        'reviewed_by' => admin_name(),
        'updated_at' => gmdate('c'),
    ];
    $sets = implode(', ', array_map(fn($k) => "$k = :$k", array_keys($scalar)));
    $scalar['id'] = $id;
    $pdo->prepare("UPDATE country_visa_pages SET $sets WHERE id = :id")->execute($scalar);

    $pdo->prepare('DELETE FROM visa_documents WHERE country_visa_page_id = ?')->execute([$id]);
    $docCats = $_POST['doc_category'] ?? [];
    $docLabels = $_POST['doc_label'] ?? [];
    $docStmt = $pdo->prepare('INSERT INTO visa_documents (country_visa_page_id, category, label, sort_order) VALUES (?, ?, ?, ?)');
    $order = 0;
    foreach ($docLabels as $i => $label) {
        $label = trim($label);
        if ($label === '') { continue; }
        $docStmt->execute([$id, $docCats[$i] ?? 'Basic Documents', $label, $order++]);
    }

    $pdo->prepare('DELETE FROM visa_process_steps WHERE country_visa_page_id = ?')->execute([$id]);
    $stepTitles = $_POST['step_title'] ?? [];
    $stepDescs = $_POST['step_desc'] ?? [];
    $stepStmt = $pdo->prepare('INSERT INTO visa_process_steps (country_visa_page_id, step_number, title, description) VALUES (?, ?, ?, ?)');
    $n = 1;
    foreach ($stepTitles as $i => $title) {
        $title = trim($title);
        if ($title === '') { continue; }
        $stepStmt->execute([$id, $n++, $title, trim($stepDescs[$i] ?? '')]);
    }

    $pdo->prepare('DELETE FROM visa_faqs WHERE country_visa_page_id = ?')->execute([$id]);
    $faqQ = $_POST['faq_question'] ?? [];
    $faqA = $_POST['faq_answer'] ?? [];
    $faqStmt = $pdo->prepare('INSERT INTO visa_faqs (country_visa_page_id, question, answer, sort_order) VALUES (?, ?, ?, ?)');
    $order = 0;
    foreach ($faqQ as $i => $q) {
        $q = trim($q);
        $a = trim($faqA[$i] ?? '');
        if ($q === '' || $a === '') { continue; }
        $faqStmt->execute([$id, $q, $a, $order++]);
    }

    $pdo->prepare('DELETE FROM visa_fees WHERE country_visa_page_id = ?')->execute([$id]);
    $feeLabels = $_POST['fee_label'] ?? [];
    $feeAmounts = $_POST['fee_amount'] ?? [];
    $feeTypes = $_POST['fee_type'] ?? [];
    $feeStmt = $pdo->prepare('INSERT INTO visa_fees (country_visa_page_id, label, amount_display, is_government, sort_order) VALUES (?, ?, ?, ?, ?)');
    $order = 0;
    foreach ($feeLabels as $i => $label) {
        $label = trim($label);
        $amount = trim($feeAmounts[$i] ?? '');
        if ($label === '' || $amount === '') { continue; }
        $feeStmt->execute([$id, $label, $amount, ($feeTypes[$i] ?? 'government') === 'government' ? 1 : 0, $order++]);
    }

    $pdo->prepare('DELETE FROM visa_sources WHERE country_visa_page_id = ?')->execute([$id]);
    $srcAuth = $_POST['source_authority'] ?? [];
    $srcUrl = $_POST['source_url'] ?? [];
    $srcDate = $_POST['source_date_checked'] ?? [];
    $srcNotes = $_POST['source_notes'] ?? [];
    $srcStmt = $pdo->prepare('INSERT INTO visa_sources (country_visa_page_id, source_authority, source_url, date_checked, date_reviewed, notes) VALUES (?, ?, ?, ?, ?, ?)');
    foreach ($srcAuth as $i => $auth) {
        $auth = trim($auth);
        if ($auth === '') { continue; }
        $srcStmt->execute([$id, $auth, trim($srcUrl[$i] ?? '') ?: null, trim($srcDate[$i] ?? '') ?: null, gmdate('Y-m-d'), trim($srcNotes[$i] ?? '') ?: null]);
    }

    header('Location: visa-page-edit.php?id=' . $id . '&saved=1');
    exit;
}

$docsStmt = $pdo->prepare('SELECT * FROM visa_documents WHERE country_visa_page_id = ? ORDER BY sort_order');
$docsStmt->execute([$id]);
$documents = $docsStmt->fetchAll(PDO::FETCH_ASSOC);

$stepsStmt = $pdo->prepare('SELECT * FROM visa_process_steps WHERE country_visa_page_id = ? ORDER BY step_number');
$stepsStmt->execute([$id]);
$steps = $stepsStmt->fetchAll(PDO::FETCH_ASSOC);

$faqsStmt = $pdo->prepare('SELECT * FROM visa_faqs WHERE country_visa_page_id = ? ORDER BY sort_order');
$faqsStmt->execute([$id]);
$faqs = $faqsStmt->fetchAll(PDO::FETCH_ASSOC);

$feesStmt = $pdo->prepare('SELECT * FROM visa_fees WHERE country_visa_page_id = ? ORDER BY sort_order');
$feesStmt->execute([$id]);
$fees = $feesStmt->fetchAll(PDO::FETCH_ASSOC);

$sourcesStmt = $pdo->prepare('SELECT * FROM visa_sources WHERE country_visa_page_id = ? ORDER BY id');
$sourcesStmt->execute([$id]);
$sources = $sourcesStmt->fetchAll(PDO::FETCH_ASSOC);

$titleBase = $page['country_name'] . ' ' . $page['category_name'];
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title"><?php echo htmlspecialchars($page['country_flag'] . ' ' . $titleBase); ?></h1>
        <p class="crm-page-subtitle">
            <span class="crm-status-badge <?php echo visa_page_status_class($page['status']); ?>"><?php echo htmlspecialchars(visa_page_status_label($page['status'])); ?></span>
            &nbsp;/countries/<?php echo htmlspecialchars($page['page_slug']); ?>
            <?php if ($page['status'] === 'published'): ?>
            &nbsp;&middot; <a href="<?php echo htmlspecialchars('/' . visa_country_page_url($page['page_slug'])); ?>" target="_blank">View Live Page <i class="fa-solid fa-arrow-up-right-from-square"></i></a>
            <?php endif; ?>
        </p>
    </div>
    <div class="crm-page-actions">
        <a href="visa-pages.php" class="crm-btn crm-btn-ghost">Back to Content Pages</a>
        <button type="submit" form="crmPageForm" class="crm-btn crm-btn-primary"><i class="fa-solid fa-floppy-disk"></i> Save</button>
    </div>
</div>

<?php if (isset($_GET['saved'])): ?>
<div class="crm-card" style="background:var(--c-green-bg);color:var(--c-green);">Saved. Last Reviewed set to today, reviewed by <?php echo htmlspecialchars(admin_name()); ?>.</div>
<?php endif; ?>

<form method="post" id="crmPageForm">
<input type="hidden" name="action" value="save_page">

<div class="crm-card">
    <div class="crm-form-section">
        <h4><i class="fa-solid fa-circle-info"></i> Status &amp; Review</h4>
        <div class="crm-form-grid">
            <div class="crm-form-field"><label>Status</label>
                <select name="status">
                    <?php foreach (VISA_PAGE_STATUSES as $s): ?>
                    <option value="<?php echo $s; ?>" <?php echo $page['status'] === $s ? 'selected' : ''; ?>><?php echo htmlspecialchars(visa_page_status_label($s)); ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="crm-form-field"><label>Last Reviewed</label><input type="text" value="<?php echo $page['last_reviewed_date'] ? htmlspecialchars(date('j F Y', strtotime($page['last_reviewed_date']))) . ' by ' . htmlspecialchars($page['reviewed_by'] ?: '—') : 'Not yet reviewed'; ?>" disabled></div>
        </div>
        <p class="crm-cell-sub" style="margin-top:8px;">Saving this form always updates Last Reviewed to today, under your name.</p>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section">
        <h4><i class="fa-solid fa-passport"></i> Overview</h4>
        <div class="crm-form-grid">
            <div class="crm-form-field"><label>Official Visa Name</label><input type="text" name="official_visa_name" value="<?php echo htmlspecialchars($page['official_visa_name'] ?? ''); ?>" placeholder="e.g. Visitor visa (subclass 600) — Tourist stream"></div>
            <div class="crm-form-field"><label>Subclass / Category Code</label><input type="text" name="visa_subclass_code" value="<?php echo htmlspecialchars($page['visa_subclass_code'] ?? ''); ?>"></div>
            <div class="crm-form-field crm-form-field-full"><label>Intro Paragraph (HTML allowed)</label><textarea name="intro_html" rows="3"><?php echo htmlspecialchars($page['intro_html'] ?? ''); ?></textarea></div>
        </div>
    </div>

    <div class="crm-form-section">
        <h4><i class="fa-solid fa-table-list"></i> Quick Visa Information</h4>
        <p class="crm-cell-sub" style="margin-bottom:12px;">Leave any field blank to show the honest "varies / check official source" fallback instead of a guess.</p>
        <div class="crm-form-grid">
            <div class="crm-form-field"><label>Typical Stay</label><input type="text" name="typical_stay" value="<?php echo htmlspecialchars($page['typical_stay'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Entry Type</label><input type="text" name="entry_type" value="<?php echo htmlspecialchars($page['entry_type'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Processing Time</label><input type="text" name="processing_time_text" value="<?php echo htmlspecialchars($page['processing_time_text'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Visa Validity</label><input type="text" name="validity_text" value="<?php echo htmlspecialchars($page['validity_text'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Application Method</label><input type="text" name="application_method" value="<?php echo htmlspecialchars($page['application_method'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Interview Required</label><input type="text" name="interview_required" value="<?php echo htmlspecialchars($page['interview_required'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Biometric Requirement</label><input type="text" name="biometric_required" value="<?php echo htmlspecialchars($page['biometric_required'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Approx. Government Fee</label><input type="text" name="government_fee_text" value="<?php echo htmlspecialchars($page['government_fee_text'] ?? ''); ?>" placeholder="Leave blank to show 'check official fee'"></div>
            <div class="crm-form-field"><label>Application Centre</label><input type="text" name="application_centre" value="<?php echo htmlspecialchars($page['application_centre'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Authority Name</label><input type="text" name="authority_name" value="<?php echo htmlspecialchars($page['authority_name'] ?? ''); ?>"></div>
            <div class="crm-form-field crm-form-field-full"><label>Authority Website URL</label><input type="url" name="authority_url" value="<?php echo htmlspecialchars($page['authority_url'] ?? ''); ?>"></div>
        </div>
    </div>

    <div class="crm-form-section">
        <h4><i class="fa-solid fa-user-check"></i> Eligibility &amp; Indian Applicant Information</h4>
        <div class="crm-form-grid">
            <div class="crm-form-field crm-form-field-full"><label>Who Can Apply? (HTML allowed &mdash; &lt;p&gt;/&lt;ul&gt;/&lt;li&gt; etc.)</label><textarea name="eligibility_html" rows="6"><?php echo htmlspecialchars($page['eligibility_html'] ?? ''); ?></textarea></div>
            <div class="crm-form-field crm-form-field-full"><label>For Indian Citizens (HTML allowed)</label><textarea name="indian_applicant_html" rows="6"><?php echo htmlspecialchars($page['indian_applicant_html'] ?? ''); ?></textarea></div>
        </div>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-list-check"></i> Document Checklist</h4>
        <table class="crm-table" id="docTable">
            <thead><tr><th style="width:220px;">Category</th><th>Document</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($documents as $d): ?>
            <tr>
                <td><select name="doc_category[]">
                    <?php foreach (VISA_DOC_GROUPS as $g): ?><option <?php echo $d['category'] === $g ? 'selected' : ''; ?>><?php echo htmlspecialchars($g); ?></option><?php endforeach; ?>
                </select></td>
                <td><input type="text" name="doc_label[]" value="<?php echo htmlspecialchars($d['label']); ?>"></td>
                <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="addDocRow()" style="margin-top:10px;"><i class="fa-solid fa-plus"></i> Add Document</button>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-shoe-prints"></i> Application Process Steps</h4>
        <p class="crm-cell-sub" style="margin-bottom:12px;">Leave empty to fall back to the visa category's default 8-step process.</p>
        <table class="crm-table" id="stepTable">
            <thead><tr><th style="width:220px;">Step Title</th><th>Description</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($steps as $s): ?>
            <tr>
                <td><input type="text" name="step_title[]" value="<?php echo htmlspecialchars($s['title']); ?>"></td>
                <td><input type="text" name="step_desc[]" value="<?php echo htmlspecialchars($s['description']); ?>"></td>
                <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="addStepRow()" style="margin-top:10px;"><i class="fa-solid fa-plus"></i> Add Step</button>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-circle-question"></i> FAQs</h4>
        <table class="crm-table" id="faqTable">
            <thead><tr><th style="width:320px;">Question</th><th>Answer</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($faqs as $f): ?>
            <tr>
                <td><input type="text" name="faq_question[]" value="<?php echo htmlspecialchars($f['question']); ?>"></td>
                <td><textarea name="faq_answer[]" rows="2"><?php echo htmlspecialchars($f['answer']); ?></textarea></td>
                <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="addFaqRow()" style="margin-top:10px;"><i class="fa-solid fa-plus"></i> Add FAQ</button>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-sack-dollar"></i> Visa Fees</h4>
        <table class="crm-table" id="feeTable">
            <thead><tr><th style="width:160px;">Type</th><th>Label</th><th>Amount / Note</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($fees as $f): ?>
            <tr>
                <td><select name="fee_type[]">
                    <option value="government" <?php echo $f['is_government'] ? 'selected' : ''; ?>>Government</option>
                    <option value="service" <?php echo !$f['is_government'] ? 'selected' : ''; ?>>Visa Agency Service</option>
                </select></td>
                <td><input type="text" name="fee_label[]" value="<?php echo htmlspecialchars($f['label']); ?>"></td>
                <td><input type="text" name="fee_amount[]" value="<?php echo htmlspecialchars($f['amount_display']); ?>" placeholder="Amount, or e.g. 'Check official fee estimator'"></td>
                <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="addFeeRow()" style="margin-top:10px;"><i class="fa-solid fa-plus"></i> Add Fee Line</button>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-book"></i> Sources</h4>
        <table class="crm-table" id="sourceTable">
            <thead><tr><th>Authority</th><th>URL</th><th style="width:150px;">Date Checked</th><th>Notes</th><th></th></tr></thead>
            <tbody>
            <?php foreach ($sources as $s): ?>
            <tr>
                <td><input type="text" name="source_authority[]" value="<?php echo htmlspecialchars($s['source_authority']); ?>"></td>
                <td><input type="url" name="source_url[]" value="<?php echo htmlspecialchars($s['source_url'] ?? ''); ?>"></td>
                <td><input type="date" name="source_date_checked[]" value="<?php echo htmlspecialchars($s['date_checked'] ?? ''); ?>"></td>
                <td><input type="text" name="source_notes[]" value="<?php echo htmlspecialchars($s['notes'] ?? ''); ?>"></td>
                <td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>
            </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
        <button type="button" class="crm-btn crm-btn-ghost crm-btn-sm" onclick="addSourceRow()" style="margin-top:10px;"><i class="fa-solid fa-plus"></i> Add Source</button>
    </div>
</div>

<div class="crm-card">
    <div class="crm-form-section" style="border-bottom:none;margin-bottom:0;padding-bottom:0;">
        <h4><i class="fa-solid fa-magnifying-glass"></i> SEO Metadata</h4>
        <div class="crm-form-grid">
            <div class="crm-form-field crm-form-field-full"><label>SEO Title</label><input type="text" name="seo_title" value="<?php echo htmlspecialchars($page['seo_title'] ?? ''); ?>" placeholder="<?php echo htmlspecialchars($titleBase); ?> from India | Requirements, Documents &amp; Application"></div>
            <div class="crm-form-field crm-form-field-full"><label>Meta Description</label><textarea name="meta_description" rows="2"><?php echo htmlspecialchars($page['meta_description'] ?? ''); ?></textarea></div>
            <div class="crm-form-field"><label>Open Graph Title</label><input type="text" name="og_title" value="<?php echo htmlspecialchars($page['og_title'] ?? ''); ?>"></div>
            <div class="crm-form-field"><label>Canonical URL Override</label><input type="url" name="canonical_override" value="<?php echo htmlspecialchars($page['canonical_override'] ?? ''); ?>" placeholder="Leave blank to use the default canonical"></div>
            <div class="crm-form-field crm-form-field-full"><label>Open Graph Description</label><textarea name="og_description" rows="2"><?php echo htmlspecialchars($page['og_description'] ?? ''); ?></textarea></div>
        </div>
    </div>
</div>

<div class="crm-page-actions" style="justify-content:flex-end;margin-top:8px;">
    <button type="submit" class="crm-btn crm-btn-primary"><i class="fa-solid fa-floppy-disk"></i> Save</button>
</div>
</form>

<script>
document.addEventListener('click', function (e) {
    if (e.target.closest('.crm-row-remove')) {
        e.target.closest('tr').remove();
    }
});
function addRow(tableId, html) {
    var tbody = document.querySelector('#' + tableId + ' tbody');
    var tr = document.createElement('tr');
    tr.innerHTML = html;
    tbody.appendChild(tr);
}
function docGroupOptions() {
    return <?php echo json_encode(VISA_DOC_GROUPS); ?>.map(function (g) { return '<option>' + g + '</option>'; }).join('');
}
function addDocRow() {
    addRow('docTable', '<td><select name="doc_category[]">' + docGroupOptions() + '</select></td><td><input type="text" name="doc_label[]"></td><td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>');
}
function addStepRow() {
    addRow('stepTable', '<td><input type="text" name="step_title[]"></td><td><input type="text" name="step_desc[]"></td><td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>');
}
function addFaqRow() {
    addRow('faqTable', '<td><input type="text" name="faq_question[]"></td><td><textarea name="faq_answer[]" rows="2"></textarea></td><td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>');
}
function addFeeRow() {
    addRow('feeTable', '<td><select name="fee_type[]"><option value="government">Government</option><option value="service">Visa Agency Service</option></select></td><td><input type="text" name="fee_label[]"></td><td><input type="text" name="fee_amount[]"></td><td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>');
}
function addSourceRow() {
    addRow('sourceTable', '<td><input type="text" name="source_authority[]"></td><td><input type="url" name="source_url[]"></td><td><input type="date" name="source_date_checked[]"></td><td><input type="text" name="source_notes[]"></td><td><button type="button" class="crm-btn crm-btn-ghost crm-btn-sm crm-row-remove"><i class="fa-solid fa-xmark"></i></button></td>');
}
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
