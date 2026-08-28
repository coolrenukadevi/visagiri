<?php
declare(strict_types=1);

/**
 * Partner invoicing — manual/staff-driven, no payment gateway (same
 * stance as the forex module). An invoice is a snapshot total for a
 * partner over an optional period; its status moves forward only
 * (draft -> issued -> paid), matching the simple linear lifecycles
 * used elsewhere in this codebase (visa_quotes, forex quotations).
 */

require_permission('partners.manage');

$pdo = db();
$action = $_GET['action'] ?? 'list';
$id = isset($_GET['id']) ? (int) $_GET['id'] : (isset($_POST['id']) ? (int) $_POST['id'] : null);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $postAction = $_POST['action'] ?? '';

    if ($postAction === 'save') {
        $partnerId = (int) ($_POST['partner_id'] ?? 0);
        $totalAmount = (float) ($_POST['total_amount'] ?? 0);
        $periodStart = ($_POST['period_start'] ?? '') !== '' ? $_POST['period_start'] : null;
        $periodEnd = ($_POST['period_end'] ?? '') !== '' ? $_POST['period_end'] : null;
        $notes = trim((string) ($_POST['notes'] ?? '')) ?: null;

        if (!$partnerId || $totalAmount <= 0) {
            flash_set('admin_error', 'A partner and a positive total amount are required.');
            redirect('/admin/partner-invoices/?action=create&partner_id=' . $partnerId);
        }

        $ref = generate_reference_number('INV', 'partner_invoices', 'invoice_reference_no');
        $pdo->prepare(
            'INSERT INTO partner_invoices (invoice_reference_no, partner_id, period_start, period_end, total_amount, notes, created_by)
             VALUES (:ref, :partner_id, :start, :end, :total, :notes, :admin)'
        )->execute([
            'ref' => $ref,
            'partner_id' => $partnerId,
            'start' => $periodStart,
            'end' => $periodEnd,
            'total' => $totalAmount,
            'notes' => $notes,
            'admin' => current_admin_id(),
        ]);
        $newId = (int) $pdo->lastInsertId();
        log_action('create', 'partner_invoices', $newId, null, $ref);
        flash_set('admin_notice', "Invoice $ref created.");
        redirect('/admin/partner-invoices/?action=view&id=' . $newId);
    }

    if ($postAction === 'issue' && $id) {
        $pdo->prepare("UPDATE partner_invoices SET status = 'issued', issued_at = NOW() WHERE id = :id AND status = 'draft'")->execute(['id' => $id]);
        log_action('issue', 'partner_invoices', $id);
        flash_set('admin_notice', 'Invoice issued.');
        redirect('/admin/partner-invoices/?action=view&id=' . $id);
    }

    if ($postAction === 'mark_paid' && $id) {
        $pdo->prepare("UPDATE partner_invoices SET status = 'paid', paid_at = NOW() WHERE id = :id AND status = 'issued'")->execute(['id' => $id]);
        log_action('mark_paid', 'partner_invoices', $id);
        flash_set('admin_notice', 'Invoice marked paid.');
        redirect('/admin/partner-invoices/?action=view&id=' . $id);
    }
}

if ($action === 'create') {
    $partners = $pdo->query("SELECT id, company_name FROM partners WHERE deleted_at IS NULL ORDER BY company_name")->fetchAll();
    $preselectedPartnerId = (int) ($_GET['partner_id'] ?? 0);

    $suggestedTotal = null;
    if ($preselectedPartnerId) {
        $balanceStmt = $pdo->prepare(
            "SELECT COALESCE(SUM(CASE WHEN type = 'credit' THEN amount ELSE -amount END), 0) FROM partner_wallet_transactions WHERE partner_id = :id"
        );
        $balanceStmt->execute(['id' => $preselectedPartnerId]);
        $suggestedTotal = (float) $balanceStmt->fetchColumn();
    }

    admin_header_start('New Invoice', 'partner-invoices');
    ?>
    <div class="admin-form-card">
        <form method="post" action="/admin/partner-invoices/">
            <?= csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <div class="admin-form-grid">
                <div class="form-group">
                    <label class="form-label" for="partner_id">Partner</label>
                    <select class="form-select" id="partner_id" name="partner_id" required>
                        <option value="">Select partner</option>
                        <?php foreach ($partners as $p): ?>
                        <option value="<?= (int) $p['id'] ?>"<?= $preselectedPartnerId === (int) $p['id'] ? ' selected' : '' ?>><?= e($p['company_name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="total_amount">Total Amount</label>
                    <input class="form-input" type="number" step="0.01" id="total_amount" name="total_amount" value="<?= $suggestedTotal !== null ? e(number_format($suggestedTotal, 2, '.', '')) : '' ?>" required>
                    <?php if ($suggestedTotal !== null): ?>
                    <small style="color:var(--text-muted)">Pre-filled from the partner's current wallet balance — edit if this invoice covers a different amount.</small>
                    <?php endif; ?>
                </div>
                <div class="form-group">
                    <label class="form-label" for="period_start">Period Start</label>
                    <input class="form-input" type="date" id="period_start" name="period_start">
                </div>
                <div class="form-group">
                    <label class="form-label" for="period_end">Period End</label>
                    <input class="form-input" type="date" id="period_end" name="period_end">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="notes">Notes</label>
                <textarea class="form-textarea" id="notes" name="notes" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary" style="margin-top:var(--space-4)">Create Invoice</button>
            <a href="/admin/partner-invoices/" class="btn btn-outline">Cancel</a>
        </form>
    </div>
    <?php
    admin_header_end();
    exit;
}

if ($action === 'view' && $id) {
    $stmt = $pdo->prepare(
        'SELECT i.*, p.company_name, p.partner_reference_no, a.full_name AS created_by_name
         FROM partner_invoices i
         JOIN partners p ON p.id = i.partner_id
         LEFT JOIN admin_users a ON a.id = i.created_by
         WHERE i.id = :id'
    );
    $stmt->execute(['id' => $id]);
    $invoice = $stmt->fetch();
    if (!$invoice) {
        flash_set('admin_error', 'Invoice not found.');
        redirect('/admin/partner-invoices/');
    }

    admin_header_start($invoice['invoice_reference_no'], 'partner-invoices');
    ?>
    <div class="admin-form-card" style="max-width:640px">
        <p><strong>Reference:</strong> <?= e($invoice['invoice_reference_no']) ?></p>
        <p><strong>Partner:</strong> <a href="/admin/partners/?action=view&id=<?= (int) $invoice['partner_id'] ?>"><?= e($invoice['company_name']) ?></a> (<?= e($invoice['partner_reference_no']) ?>)</p>
        <p><strong>Period:</strong> <?= $invoice['period_start'] ? e(date('d M Y', strtotime((string) $invoice['period_start']))) . ' – ' . e(date('d M Y', strtotime((string) $invoice['period_end']))) : '—' ?></p>
        <p><strong>Amount:</strong> <?= e(number_format((float) $invoice['total_amount'], 2)) ?> <?= e($invoice['currency']) ?></p>
        <p><strong>Status:</strong> <span class="badge <?= $invoice['status'] === 'paid' ? 'badge-success' : ($invoice['status'] === 'issued' ? 'badge-info' : 'badge-neutral') ?>"><?= e(ucfirst($invoice['status'])) ?></span></p>
        <p><strong>Created:</strong> <?= e(date('d M Y', strtotime((string) $invoice['created_at']))) ?><?= $invoice['created_by_name'] ? ' by ' . e($invoice['created_by_name']) : '' ?></p>
        <?php if ($invoice['issued_at']): ?><p><strong>Issued:</strong> <?= e(date('d M Y', strtotime((string) $invoice['issued_at']))) ?></p><?php endif; ?>
        <?php if ($invoice['paid_at']): ?><p><strong>Paid:</strong> <?= e(date('d M Y', strtotime((string) $invoice['paid_at']))) ?></p><?php endif; ?>
        <?php if ($invoice['notes']): ?><p><strong>Notes:</strong> <?= nl2br(e($invoice['notes'])) ?></p><?php endif; ?>

        <div style="display:flex;gap:var(--space-2);margin-top:var(--space-4)">
            <?php if ($invoice['status'] === 'draft'): ?>
            <form method="post" action="/admin/partner-invoices/"><?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="issue">
                <button type="submit" class="btn btn-primary btn-sm">Mark Issued</button>
            </form>
            <?php elseif ($invoice['status'] === 'issued'): ?>
            <form method="post" action="/admin/partner-invoices/"><?= csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="action" value="mark_paid">
                <button type="submit" class="btn btn-primary btn-sm">Mark Paid</button>
            </form>
            <?php else: ?>
            <p style="color:var(--text-muted);font-size:var(--font-size-sm)">This invoice is paid — no further actions available.</p>
            <?php endif; ?>
        </div>
    </div>
    <p style="margin-top:var(--space-6)"><a href="/admin/partner-invoices/">&larr; Back to all invoices</a></p>
    <?php
    admin_header_end();
    exit;
}

// --- List ---
$invoices = $pdo->query(
    "SELECT i.*, p.company_name FROM partner_invoices i JOIN partners p ON p.id = i.partner_id ORDER BY i.created_at DESC"
)->fetchAll();

admin_header_start('Partner Invoices', 'partner-invoices');
?>
<div class="admin-toolbar">
    <div></div>
    <a href="/admin/partner-invoices/?action=create" class="btn btn-primary">+ New Invoice</a>
</div>
<table class="admin-table">
    <thead><tr><th>Reference</th><th>Partner</th><th>Period</th><th>Amount</th><th>Status</th><th>Created</th></tr></thead>
    <tbody>
    <?php foreach ($invoices as $inv): ?>
        <tr>
            <td><a href="/admin/partner-invoices/?action=view&id=<?= (int) $inv['id'] ?>"><?= e($inv['invoice_reference_no']) ?></a></td>
            <td><?= e($inv['company_name']) ?></td>
            <td><?= $inv['period_start'] ? e(date('d M Y', strtotime((string) $inv['period_start']))) . ' – ' . e(date('d M Y', strtotime((string) $inv['period_end']))) : '—' ?></td>
            <td><?= e(number_format((float) $inv['total_amount'], 2)) ?></td>
            <td><span class="badge <?= $inv['status'] === 'paid' ? 'badge-success' : ($inv['status'] === 'issued' ? 'badge-info' : 'badge-neutral') ?>"><?= e(ucfirst($inv['status'])) ?></span></td>
            <td><?= e(date('d M Y', strtotime((string) $inv['created_at']))) ?></td>
        </tr>
    <?php endforeach; ?>
    <?php if (!$invoices): ?>
        <tr><td colspan="6"><p class="empty-state">No invoices yet.</p></td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php
admin_header_end();
