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

    if ($postAction === 'delete' && $id) {
        $stmt = $pdo->prepare('SELECT question FROM visa_faqs WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $oldQuestion = $stmt->fetchColumn() ?: null;
        $pdo->prepare('DELETE FROM visa_faqs WHERE id = :id')->execute(['id' => $id]);
        log_action('delete', 'visa_faqs', $id, $oldQuestion, null);
        flash_set('admin_notice', 'FAQ deleted.');
        redirect('/admin/faqs/');
    }

    if ($postAction === 'toggle' && $id) {
        $stmt = $pdo->prepare('SELECT is_active FROM visa_faqs WHERE id = :id');
        $stmt->execute(['id' => $id]);
        $old = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE visa_faqs SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
        log_action('update', 'visa_faqs', $id, "is_active=$old", 'is_active=' . (1 - $old));
        redirect('/admin/faqs/');
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

$faqs = $pdo->query(
    'SELECT f.*, c.name AS country_name, v.name AS visa_type_name FROM visa_faqs f
     LEFT JOIN countries c ON c.id = f.country_id LEFT JOIN visa_types v ON v.id = f.visa_type_id
     ORDER BY f.sort_order'
)->fetchAll();

admin_header_start('FAQs', 'faqs');
admin_subnav('content', 'faqs');
?>
<div class="admin-toolbar">
    <div></div>
    <?php if (has_permission('content.manage')): ?>
    <a href="/admin/faqs/?action=create" class="btn btn-primary">+ Add FAQ</a>
    <?php endif; ?>
</div>
<?php if ($faqs): ?>
<div class="admin-table-scroll" style="margin-top:var(--space-4)">
<table class="admin-table">
    <thead><tr><th>Question</th><th>Scope</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php $canManageContent = has_permission('content.manage'); ?>
    <?php foreach ($faqs as $f): ?>
        <tr>
            <td><?= e($f['question']) ?></td>
            <td><?= e($f['country_name'] ?? $f['visa_type_name'] ?? 'General') ?></td>
            <td>
                <?php if ($canManageContent): ?>
                <form method="post" action="/admin/faqs/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>">
                <button type="submit" class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></button></form>
                <?php else: ?>
                <span class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></span>
                <?php endif; ?>
            </td>
            <td class="actions">
                <?php if ($canManageContent): ?>
                <a href="/admin/faqs/?action=edit&id=<?= (int) $f['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/faqs/" style="display:inline" onsubmit="return confirm('Delete this FAQ?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>">
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
                <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>">
                <button type="submit" class="btn btn-sm btn-outline">Delete</button>
            </form>
        </div>
        <?php endif; ?>
    </div>
    <?php endforeach; ?>
</div>
<?php else: ?>
<p class="admin-empty-state--icon" style="margin-top:var(--space-4)"><svg width="28" height="28" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 10.5 8 14.5 16 5.5"/></svg>No FAQs yet.</p>
<?php endif; ?>
<?php
admin_header_end();
