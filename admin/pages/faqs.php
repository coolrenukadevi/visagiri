<?php
declare(strict_types=1);

require_permission('content.view');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$countries = $pdo->query('SELECT id, name FROM countries ORDER BY name')->fetchAll();
$visaTypesList = $pdo->query('SELECT id, name FROM visa_types ORDER BY sort_order')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_permission('content.manage');
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    // Preserves the list's current search/filter/page state across a
    // quick inline action (toggle/delete) — reconstructed only from a
    // fixed whitelist of known param names posted back as hidden
    // fields, never from $_SERVER['HTTP_REFERER'] (no open-redirect
    // risk, no trusting client-supplied URLs).
    $returnQuery = http_build_query(array_filter([
        'q' => trim((string) ($_POST['q'] ?? '')),
        'status' => $_POST['status'] ?? '',
        'country_id' => $_POST['filter_country_id'] ?? '',
        'visa_type_id' => $_POST['filter_visa_type_id'] ?? '',
        'page' => $_POST['return_page'] ?? '',
    ], static fn($v) => $v !== ''));
    $returnUrl = '/admin/faqs/' . ($returnQuery !== '' ? '?' . $returnQuery : '');

    if ($postAction === 'delete' && $id) {
        $stmt = $pdo->prepare('SELECT question FROM visa_faqs WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $oldQuestion = $stmt->fetchColumn() ?: null;
        $pdo->prepare('DELETE FROM visa_faqs WHERE id = :id')->execute(['id' => $id]);
        log_action('delete', 'visa_faqs', $id, $oldQuestion, null);
        flash_set('admin_notice', 'FAQ deleted.');
        redirect($returnUrl);
    }

    if ($postAction === 'toggle' && $id) {
        $stmt = $pdo->prepare('SELECT is_active FROM visa_faqs WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $old = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE visa_faqs SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
        log_action('update', 'visa_faqs', $id, "is_active=$old", 'is_active=' . (1 - $old));
        redirect($returnUrl);
    }

    if ($postAction === 'save') {
        $data = [
            'question' => trim((string) ($_POST['question'] ?? '')),
            'answer' => trim((string) ($_POST['answer'] ?? '')),
            'country_id' => (int) ($_POST['country_id'] ?? 0) ?: null,
            'visa_type_id' => (int) ($_POST['visa_type_id'] ?? 0) ?: null,
            'sort_order' => (int) ($_POST['sort_order'] ?? 0),
            'is_active' => isset($_POST['is_active']) ? 1 : 0,
            'meta_title' => trim((string) ($_POST['meta_title'] ?? '')) ?: null,
            'meta_description' => trim((string) ($_POST['meta_description'] ?? '')) ?: null,
        ];

        if ($data['question'] === '' || $data['answer'] === '') {
            flash_set('admin_error', 'Question and answer are required.');
            redirect($id ? "/admin/faqs/?action=edit&id=$id" : '/admin/faqs/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $oldStmt = $pdo->prepare('SELECT question FROM visa_faqs WHERE id = :id');
            $oldStmt->execute(['id' => $id]);
            $oldQuestion = $oldStmt->fetchColumn() ?: null;
            $pdo->prepare(
                'UPDATE visa_faqs SET question=:question, answer=:answer, country_id=:country_id, visa_type_id=:visa_type_id, sort_order=:sort_order, is_active=:is_active,
                 meta_title=:meta_title, meta_description=:meta_description WHERE id=:id'
            )->execute($data);
            log_action('update', 'visa_faqs', $id, $oldQuestion, $data['question']);
            flash_set('admin_notice', 'FAQ updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active, meta_title, meta_description)
                 VALUES (:question, :answer, :country_id, :visa_type_id, :sort_order, :is_active, :meta_title, :meta_description)'
            )->execute($data);
            log_action('create', 'visa_faqs', (int) $pdo->lastInsertId(), null, $data['question']);
            flash_set('admin_notice', 'FAQ added.');
        }
        redirect('/admin/faqs/');
    }
}

if ($action === 'create' || $action === 'edit') {
    require_permission('content.manage');
    $faq = ['question' => '', 'answer' => '', 'country_id' => null, 'visa_type_id' => null, 'sort_order' => 0, 'is_active' => 1, 'meta_title' => '', 'meta_description' => ''];
    if ($action === 'edit' && $id) {
        $stmt = $pdo->prepare('SELECT * FROM visa_faqs WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $found = $stmt->fetch();
        if (!$found) {
            flash_set('admin_error', 'FAQ not found.');
            redirect('/admin/faqs/');
        }
        $faq = $found;
    }

    admin_header_start($action === 'edit' ? 'Edit FAQ' : 'Add FAQ', 'faqs');
    admin_subnav('content', 'faqs');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/faqs/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <?php if ($action === 'edit'): ?><input type="hidden" name="id" value="<?= (int) $id ?>"><?php endif; ?>
            <div class="form-group">
                <label class="form-label" for="question">Question</label>
                <input class="form-input" type="text" id="question" name="question" value="<?= e($faq['question']) ?>" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="answer">Answer</label>
                <textarea class="form-input" id="answer" name="answer" rows="4" required><?= e($faq['answer']) ?></textarea>
            </div>
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="country_id">Specific to country (optional)</label>
                    <select class="form-select" id="country_id" name="country_id">
                        <option value="">— General —</option>
                        <?php foreach ($countries as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"<?= (int) ($faq['country_id'] ?? 0) === (int) $c['id'] ? ' selected' : '' ?>><?= e($c['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="visa_type_id">Specific to visa type (optional)</label>
                    <select class="form-select" id="visa_type_id" name="visa_type_id">
                        <option value="">— General —</option>
                        <?php foreach ($visaTypesList as $t): ?>
                        <option value="<?= (int) $t['id'] ?>"<?= (int) ($faq['visa_type_id'] ?? 0) === (int) $t['id'] ? ' selected' : '' ?>><?= e($t['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="sort_order">Sort order</label>
                    <input class="form-input" type="number" id="sort_order" name="sort_order" value="<?= (int) $faq['sort_order'] ?>">
                </div>
            </div>
            <div class="admin-checkbox-row"><label><input type="checkbox" name="is_active" <?= $faq['is_active'] ? 'checked' : '' ?>> Active (visible on site)</label></div>

            <div class="form-group" style="margin-top:var(--space-4)">
                <label class="form-label" for="meta_title">SEO meta title</label>
                <input class="form-input" type="text" id="meta_title" name="meta_title" value="<?= e($faq['meta_title'] ?? '') ?>">
            </div>
            <div class="form-group">
                <label class="form-label" for="meta_description">SEO meta description</label>
                <textarea class="form-input" id="meta_description" name="meta_description" rows="2"><?= e($faq['meta_description'] ?? '') ?></textarea>
            </div>

            <button type="submit" class="btn btn-primary" style="margin-top:var(--space-4)">Save</button>
            <a href="/admin/faqs/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

$search = trim((string) ($_GET['q'] ?? ''));
$statusFilter = in_array($_GET['status'] ?? '', ['active', 'hidden'], true) ? $_GET['status'] : null;
$countryFilter = (int) ($_GET['country_id'] ?? 0) ?: null;
$visaTypeFilter = (int) ($_GET['visa_type_id'] ?? 0) ?: null;
$page = max(1, (int) ($_GET['page'] ?? 1));
$perPage = 30;
$offset = ($page - 1) * $perPage;

$conditions = [];
$params = [];
if ($search !== '') {
    $conditions[] = 'f.question LIKE :search';
    $params['search'] = "%$search%";
}
if ($statusFilter === 'active') {
    $conditions[] = 'f.is_active = 1';
} elseif ($statusFilter === 'hidden') {
    $conditions[] = 'f.is_active = 0';
}
if ($countryFilter) {
    $conditions[] = 'f.country_id = :country_id';
    $params['country_id'] = $countryFilter;
}
if ($visaTypeFilter) {
    $conditions[] = 'f.visa_type_id = :visa_type_id';
    $params['visa_type_id'] = $visaTypeFilter;
}
$where = $conditions ? 'WHERE ' . implode(' AND ', $conditions) : '';

$countStmt = $pdo->prepare("SELECT COUNT(*) FROM visa_faqs f $where");
$countStmt->execute($params);
$total = (int) $countStmt->fetchColumn();
$totalPages = max(1, (int) ceil($total / $perPage));
$page = min($page, $totalPages);
$offset = ($page - 1) * $perPage;

$stmt = $pdo->prepare(
    "SELECT f.*, c.name AS country_name, v.name AS visa_type_name FROM visa_faqs f
     LEFT JOIN countries c ON c.id = f.country_id LEFT JOIN visa_types v ON v.id = f.visa_type_id
     $where ORDER BY f.sort_order LIMIT $perPage OFFSET $offset"
);
$stmt->execute($params);
$faqs = $stmt->fetchAll();

// Current filter state, reused for pagination links and as hidden
// fields in the inline toggle/delete forms so those actions redirect
// back to this same filtered/paginated view instead of resetting it.
$filterState = array_filter([
    'q' => $search,
    'status' => $statusFilter ?? '',
    'country_id' => $countryFilter ?: '',
    'visa_type_id' => $visaTypeFilter ?: '',
], static fn($v) => $v !== '' && $v !== null);
$filterQuery = http_build_query($filterState);
$hasFilters = $filterQuery !== '';

admin_header_start('FAQs', 'faqs');
admin_subnav('content', 'faqs');
?>
<div class="admin-toolbar">
    <form method="get" action="/admin/faqs/" style="display:flex;gap:var(--space-2);flex-wrap:wrap;align-items:center">
        <input class="form-input" type="search" name="q" value="<?= e($search) ?>" placeholder="Search questions…" style="min-width:200px">
        <select class="form-select" name="status">
            <option value="">All statuses</option>
            <option value="active" <?= $statusFilter === 'active' ? 'selected' : '' ?>>Active</option>
            <option value="hidden" <?= $statusFilter === 'hidden' ? 'selected' : '' ?>>Hidden</option>
        </select>
        <select class="form-select" name="country_id">
            <option value="">All countries</option>
            <?php foreach ($countries as $c): ?>
            <option value="<?= (int) $c['id'] ?>" <?= $countryFilter === (int) $c['id'] ? 'selected' : '' ?>><?= e($c['name']) ?></option>
            <?php endforeach; ?>
        </select>
        <select class="form-select" name="visa_type_id">
            <option value="">All visa types</option>
            <?php foreach ($visaTypesList as $t): ?>
            <option value="<?= (int) $t['id'] ?>" <?= $visaTypeFilter === (int) $t['id'] ? 'selected' : '' ?>><?= e($t['name']) ?></option>
            <?php endforeach; ?>
        </select>
        <button type="submit" class="btn btn-outline">Filter</button>
        <?php if ($hasFilters): ?>
        <a href="/admin/faqs/" class="btn btn-outline">Reset</a>
        <?php endif; ?>
    </form>
    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/faqs/?action=create" class="btn btn-primary">+ Add FAQ</a>
    <?php endif; ?>
</div>
<p style="color:var(--text-muted);font-size:var(--font-size-sm);margin:var(--space-2) 0 0"><?= (int) $total ?> FAQ<?= $total === 1 ? '' : 's' ?><?= $hasFilters ? ' matching your filters' : '' ?></p>
<?php if ($faqs): ?>
<div class="admin-table-scroll" style="margin-top:var(--space-4)">
<table class="admin-table">
    <thead><tr><th>Question</th><th>Scope</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php $canManageContent = has_permission('content.manage'); ?>
    <?php
    // Hidden fields so an inline toggle/delete from this list redirects
    // back to the same search/filter/page instead of resetting it.
    $returnFieldsHtml = '<input type="hidden" name="q" value="' . e($search) . '">'
        . '<input type="hidden" name="status" value="' . e($statusFilter ?? '') . '">'
        . '<input type="hidden" name="filter_country_id" value="' . (int) ($countryFilter ?? 0) . '">'
        . '<input type="hidden" name="filter_visa_type_id" value="' . (int) ($visaTypeFilter ?? 0) . '">'
        . '<input type="hidden" name="return_page" value="' . (int) $page . '">';
    ?>
    <?php foreach ($faqs as $f): ?>
        <tr>
            <td><?= e($f['question']) ?></td>
            <td><?= e($f['country_name'] ?? $f['visa_type_name'] ?? 'General') ?></td>
            <td>
                <?php if ($canManageContent): ?>
                <form method="post" action="/admin/faqs/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>"><?= $returnFieldsHtml ?>
                <button type="submit" class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></button></form>
                <?php else: ?>
                <span class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></span>
                <?php endif; ?>
            </td>
            <td class="actions">
                <?php if ($canManageContent): ?>
                <a href="/admin/faqs/?action=edit&id=<?= (int) $f['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/faqs/" style="display:inline" onsubmit="return confirm('Delete this FAQ?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>"><?= $returnFieldsHtml ?>
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
                <?php endif; ?>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
</div>
<div class="admin-card-list" style="margin-top:var(--space-4)">
    <?php foreach ($faqs as $f): ?>
    <div class="admin-record-card">
        <p class="admin-record-card__title"><?= e($f['question']) ?></p>
        <div class="admin-record-card__row"><span>Scope</span><strong><?= e($f['country_name'] ?? $f['visa_type_name'] ?? 'General') ?></strong></div>
        <div class="admin-record-card__row"><span>Status</span><strong><span class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></span></strong></div>
        <?php if ($canManageContent): ?>
        <div class="admin-record-card__action">
            <a href="/admin/faqs/?action=edit&id=<?= (int) $f['id'] ?>" class="btn btn-sm btn-outline">Edit</a>
            <form method="post" action="/admin/faqs/" style="display:inline" onsubmit="return confirm('Delete this FAQ?');">
                <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>"><?= $returnFieldsHtml ?>
                <button type="submit" class="btn btn-sm btn-outline">Delete</button>
            </form>
        </div>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
</div>
<?php if ($totalPages > 1): ?>
<div class="button-group" style="margin-top:var(--space-5);align-items:center">
    <?php if ($page > 1): ?>
    <a href="/admin/faqs/?page=<?= $page - 1 ?><?= $filterQuery !== '' ? '&' . $filterQuery : '' ?>" class="btn btn-sm btn-outline">&larr; Prev</a>
    <?php endif; ?>
    <span style="font-size:var(--font-size-sm);color:var(--text-muted);padding:0 var(--space-2)">Page <?= (int) $page ?> of <?= (int) $totalPages ?></span>
    <?php if ($page < $totalPages): ?>
    <a href="/admin/faqs/?page=<?= $page + 1 ?><?= $filterQuery !== '' ? '&' . $filterQuery : '' ?>" class="btn btn-sm btn-outline">Next &rarr;</a>
    <?php endif; ?>
</div>
<?php endif; ?>
<?php else: ?>
<p class="admin-empty-state--icon" style="margin-top:var(--space-4)"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg><?= $hasFilters ? 'No FAQs match your filters.' : 'No FAQs yet.' ?></p>
<?php endif; ?>
<?php
admin_header_end();
