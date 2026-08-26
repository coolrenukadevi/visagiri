<?php
declare(strict_types=1);

require_permission('content.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);
$countries = $pdo->query('SELECT id, name FROM countries ORDER BY name')->fetchAll();
$visaTypesList = $pdo->query('SELECT id, name FROM visa_types ORDER BY sort_order')->fetchAll();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'delete' && $id) {
        $pdo->prepare('DELETE FROM visa_faqs WHERE id = :id')->execute(['id' => $id]);
        flash_set('admin_notice', 'FAQ deleted.');
        redirect('/admin/faqs/');
    }

    if ($postAction === 'toggle' && $id) {
        $pdo->prepare('UPDATE visa_faqs SET is_active = NOT is_active WHERE id = :id')->execute(['id' => $id]);
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
        ];

        if ($data['question'] === '' || $data['answer'] === '') {
            flash_set('admin_error', 'Question and answer are required.');
            redirect($id ? "/admin/faqs/?action=edit&id=$id" : '/admin/faqs/?action=create');
        }

        if ($id) {
            $data['id'] = $id;
            $pdo->prepare(
                'UPDATE visa_faqs SET question=:question, answer=:answer, country_id=:country_id, visa_type_id=:visa_type_id, sort_order=:sort_order, is_active=:is_active WHERE id=:id'
            )->execute($data);
            flash_set('admin_notice', 'FAQ updated.');
        } else {
            $pdo->prepare(
                'INSERT INTO visa_faqs (question, answer, country_id, visa_type_id, sort_order, is_active) VALUES (:question, :answer, :country_id, :visa_type_id, :sort_order, :is_active)'
            )->execute($data);
            flash_set('admin_notice', 'FAQ added.');
        }
        redirect('/admin/faqs/');
    }
}

if ($action === 'create' || $action === 'edit') {
    $faq = ['question' => '', 'answer' => '', 'country_id' => null, 'visa_type_id' => null, 'sort_order' => 0, 'is_active' => 1];
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
?>
<div class="admin-toolbar">
    <div></div>
    <a href="/admin/faqs/?action=create" class="btn btn-primary">+ Add FAQ</a>
</div>
<table class="admin-table">
    <thead><tr><th>Question</th><th>Scope</th><th>Active</th><th></th></tr></thead>
    <tbody>
    <?php foreach ($faqs as $f): ?>
        <tr>
            <td><?= e($f['question']) ?></td>
            <td><?= e($f['country_name'] ?? $f['visa_type_name'] ?? 'General') ?></td>
            <td>
                <form method="post" action="/admin/faqs/" style="display:inline"><?= csrf_field() ?><input type="hidden" name="action" value="toggle"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>">
                <button type="submit" class="badge <?= $f['is_active'] ? 'badge-success' : 'badge-warning' ?>" style="border:none;cursor:pointer"><?= $f['is_active'] ? 'Active' : 'Hidden' ?></button></form>
            </td>
            <td class="actions">
                <a href="/admin/faqs/?action=edit&id=<?= (int) $f['id'] ?>" class="btn btn-outline btn-sm">Edit</a>
                <form method="post" action="/admin/faqs/" style="display:inline" onsubmit="return confirm('Delete this FAQ?');">
                    <?= csrf_field() ?><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<?= (int) $f['id'] ?>">
                    <button type="submit" class="btn btn-outline btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php
admin_header_end();
