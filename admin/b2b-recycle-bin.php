<?php
ob_start();
$ADMIN_PAGE_TITLE = 'Recycle Bin';
$ADMIN_ACTIVE_NAV = 'b2b-recycle-bin';
$ADMIN_BREADCRUMB = ['CRM', 'B2B Partners', 'Recycle Bin'];
require __DIR__ . '/includes/layout-top.php';

if (!b2b_can_manage_enrollment()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to manage the B2B Recycle Bin.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$actionMessage = '';
$actionError = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    b2b_csrf_require_or_403();
    $action = $_POST['action'] ?? '';

    if ($action === 'restore_partner') {
        $id = (int) ($_POST['id'] ?? 0);
        $stmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ? AND archived_at IS NOT NULL');
        $stmt->execute([$id]);
        $p = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($p) {
            $pdo->prepare('UPDATE b2b_partners SET archived_at = NULL, archived_by = NULL WHERE id = ?')->execute([$id]);
            b2b_log_audit($pdo, 'partner', $id, admin_name(), admin_role(), 'Restored partner from Recycle Bin', '', '');
            $actionMessage = "\"{$p['company_name']}\" restored.";
        }
    } elseif ($action === 'delete_partner_permanently') {
        $id = (int) ($_POST['id'] ?? 0);
        $stmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE id = ? AND archived_at IS NOT NULL');
        $stmt->execute([$id]);
        $p = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$p) {
            $actionError = 'Partner not found in the Recycle Bin.';
        } else {
            $hasCasesStmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE partner_id = ?');
            $hasCasesStmt->execute([$id]);
            $hasCases = (int) $hasCasesStmt->fetchColumn();
            $hasQuotesStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_quotations WHERE partner_id = ?');
            $hasQuotesStmt->execute([$id]);
            $hasQuotes = (int) $hasQuotesStmt->fetchColumn();
            $hasInvoicesStmt = $pdo->prepare('SELECT COUNT(*) FROM b2b_invoices WHERE partner_id = ?');
            $hasInvoicesStmt->execute([$id]);
            $hasInvoices = (int) $hasInvoicesStmt->fetchColumn();
            if ($hasCases || $hasQuotes || $hasInvoices) {
                $actionError = "\"{$p['company_name']}\" has visa cases, quotations or invoices on record and can't be permanently deleted — leave it archived instead.";
            } else {
                $pdo->prepare('DELETE FROM b2b_partner_users WHERE partner_id = ?')->execute([$id]);
                $pdo->prepare('DELETE FROM b2b_partner_documents WHERE partner_id = ?')->execute([$id]);
                $pdo->prepare('DELETE FROM b2b_correction_requests WHERE partner_id = ?')->execute([$id]);
                $pdo->prepare('DELETE FROM b2b_wallet_transactions WHERE partner_id = ?')->execute([$id]);
                $pdo->prepare('DELETE FROM b2b_messages WHERE partner_id = ?')->execute([$id]);
                $pdo->prepare('DELETE FROM b2b_partners WHERE id = ?')->execute([$id]);
                $dir = __DIR__ . '/../uploads/b2b-partners/' . $p['application_ref'];
                if (is_dir($dir)) {
                    foreach (glob($dir . '/*') ?: [] as $f) { @unlink($f); }
                    @rmdir($dir);
                }
                b2b_log_audit($pdo, 'partner', null, admin_name(), admin_role(), 'Permanently deleted partner', $p['application_ref'] . ' — ' . $p['company_name'], '');
                $actionMessage = "\"{$p['company_name']}\" permanently deleted.";
            }
        }
    } elseif ($action === 'restore_document') {
        $id = (int) ($_POST['id'] ?? 0);
        $stmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE id = ? AND deleted_at IS NOT NULL');
        $stmt->execute([$id]);
        $d = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($d) {
            $pdo->prepare('UPDATE b2b_partner_documents SET deleted_at = NULL, deleted_by = NULL WHERE id = ?')->execute([$id]);
            b2b_log_audit($pdo, 'partner', $d['partner_id'], admin_name(), admin_role(), 'Restored document from Recycle Bin', '', $d['original_filename']);
            $actionMessage = "\"{$d['original_filename']}\" restored.";
        }
    } elseif ($action === 'delete_document_permanently') {
        $id = (int) ($_POST['id'] ?? 0);
        $stmt = $pdo->prepare('SELECT d.*, p.application_ref FROM b2b_partner_documents d JOIN b2b_partners p ON p.id = d.partner_id WHERE d.id = ? AND d.deleted_at IS NOT NULL');
        $stmt->execute([$id]);
        $d = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$d) {
            $actionError = 'Document not found in the Recycle Bin.';
        } else {
            // Versioning self-FK: an older document this one replaced (or that
            // replaced this one) must not point at a row we're about to remove.
            $pdo->prepare('UPDATE b2b_partner_documents SET replaces_document_id = NULL WHERE replaces_document_id = ?')->execute([$id]);
            if ($d['stored_filename']) {
                $path = __DIR__ . '/../uploads/b2b-partners/' . $d['application_ref'] . '/' . $d['stored_filename'];
                if (is_file($path)) { @unlink($path); }
            }
            $pdo->prepare('DELETE FROM b2b_partner_documents WHERE id = ?')->execute([$id]);
            b2b_log_audit($pdo, 'partner', $d['partner_id'], admin_name(), admin_role(), 'Permanently deleted document', $d['original_filename'], '');
            $actionMessage = "\"{$d['original_filename']}\" permanently deleted.";
        }
    }
}

$archivedPartners = $pdo->query("SELECT * FROM b2b_partners WHERE archived_at IS NOT NULL ORDER BY archived_at DESC")->fetchAll(PDO::FETCH_ASSOC);
$deletedDocuments = $pdo->query("SELECT d.*, p.company_name, p.application_ref FROM b2b_partner_documents d JOIN b2b_partners p ON p.id = d.partner_id WHERE d.deleted_at IS NOT NULL ORDER BY d.deleted_at DESC")->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Recycle Bin</h1>
        <p class="crm-page-subtitle">Archived partner accounts and deleted documents. Nothing here is visible anywhere else until restored.</p>
    </div>
</div>

<?php if ($actionMessage): ?><div class="crm-alert crm-alert-success"><i class="fa-solid fa-circle-check"></i> <?php echo htmlspecialchars($actionMessage); ?></div><?php endif; ?>
<?php if ($actionError): ?><div class="crm-alert crm-alert-error"><i class="fa-solid fa-circle-exclamation"></i> <?php echo htmlspecialchars($actionError); ?></div><?php endif; ?>

<div class="crm-card" style="padding:0;margin-bottom:20px;">
    <h3 style="margin:0;padding:16px 18px 0;font-size:14px;">Archived Partners (<?php echo count($archivedPartners); ?>)</h3>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Partner ID</th><th>Company</th><th>Archived By</th><th>Archived</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($archivedPartners as $p): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($p['application_ref']); ?>"><?php echo htmlspecialchars($p['application_ref']); ?></a></td>
            <td><?php echo htmlspecialchars($p['company_name']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($p['archived_by'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $p['archived_at'], 0, 10)); ?></td>
            <td style="display:flex;gap:8px;">
                <form method="post"><input type="hidden" name="action" value="restore_partner"><input type="hidden" name="id" value="<?php echo (int) $p['id']; ?>"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Restore</button></form>
                <form method="post" onsubmit="return confirm('Permanently delete this partner? This cannot be undone. Blocked automatically if they have any visa cases, quotations or invoices.');"><input type="hidden" name="action" value="delete_partner_permanently"><input type="hidden" name="id" value="<?php echo (int) $p['id']; ?>"><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Delete Permanently</button></form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$archivedPartners): ?>
        <tr><td colspan="5" class="crm-empty">No archived partners.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<div class="crm-card" style="padding:0;">
    <h3 style="margin:0;padding:16px 18px 0;font-size:14px;">Deleted Documents (<?php echo count($deletedDocuments); ?>)</h3>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>Partner</th><th>Document</th><th>Deleted By</th><th>Deleted</th><th></th></tr></thead>
        <tbody>
        <?php foreach ($deletedDocuments as $d): ?>
        <tr>
            <td class="crm-cell-name"><a href="b2b-partner.php?ref=<?php echo urlencode($d['application_ref']); ?>&tab=documents"><?php echo htmlspecialchars($d['company_name']); ?></a></td>
            <td><?php echo htmlspecialchars(B2B_DOC_TYPES[$d['doc_type']] ?? $d['doc_type']); ?> — <?php echo htmlspecialchars($d['original_filename']); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars($d['deleted_by'] ?: '—'); ?></td>
            <td class="crm-cell-sub"><?php echo htmlspecialchars(substr((string) $d['deleted_at'], 0, 10)); ?></td>
            <td style="display:flex;gap:8px;">
                <form method="post"><input type="hidden" name="action" value="restore_document"><input type="hidden" name="id" value="<?php echo (int) $d['id']; ?>"><button type="submit" class="crm-btn crm-btn-primary crm-btn-sm">Restore</button></form>
                <form method="post" onsubmit="return confirm('Permanently delete this document and its file? This cannot be undone.');"><input type="hidden" name="action" value="delete_document_permanently"><input type="hidden" name="id" value="<?php echo (int) $d['id']; ?>"><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm" style="color:var(--c-red);">Delete Permanently</button></form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (!$deletedDocuments): ?>
        <tr><td colspan="5" class="crm-empty">No deleted documents.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
    </div>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
