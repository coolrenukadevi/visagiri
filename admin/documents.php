<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'Documents';
$ADMIN_ACTIVE_NAV = 'documents';
$ADMIN_BREADCRUMB = ['CRM', 'Documents'];
require __DIR__ . '/includes/layout-top.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $docId = (int) ($_POST['doc_id'] ?? 0);
    $decision = trim($_POST['decision'] ?? '');
    if (in_array($decision, ['Verified', 'Rejected'], true)) {
        $pdo->prepare('UPDATE enquiry_documents SET status = ?, verified_by = ?, verified_at = ? WHERE id = ?')
            ->execute([$decision, admin_name(), gmdate('c'), $docId]);
        $row = $pdo->prepare('SELECT enquiry_id, category FROM enquiry_documents WHERE id = ?');
        $row->execute([$docId]);
        $r = $row->fetch(PDO::FETCH_ASSOC);
        if ($r) crm_log_activity($pdo, (int) $r['enquiry_id'], admin_name(), strtolower($decision) . ' document: ' . $r['category']);
    }
    header('Location: documents.php' . (isset($_GET['status']) ? '?status=' . urlencode($_GET['status']) : ''));
    exit;
}

$statusFilter = trim($_GET['status'] ?? '');
$scopeSql = admin_can_view_all() ? '' : ' AND e.assigned_to = :me';
$scopeParams = admin_can_view_all() ? [] : ['me' => admin_name()];

$sql = "SELECT d.*, e.enquiry_ref, e.full_name FROM enquiry_documents d
    JOIN enquiries e ON e.id = d.enquiry_id WHERE e.archived_at IS NULL $scopeSql";
$params = $scopeParams;
if ($statusFilter !== '') { $sql .= ' AND d.status = :status'; $params['status'] = $statusFilter; }
$sql .= ' ORDER BY d.uploaded_at DESC LIMIT 300';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$docs = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">Documents</h1>
        <p class="crm-page-subtitle">All customer documents uploaded across every enquiry, ready for review.</p>
    </div>
</div>

<div class="crm-filter-bar" style="margin-bottom:16px;">
    <a href="documents.php" class="crm-btn crm-btn-sm <?php echo $statusFilter === '' ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>">All</a>
    <?php foreach (CRM_DOC_STATUSES as $s): ?>
    <a href="documents.php?status=<?php echo urlencode($s); ?>" class="crm-btn crm-btn-sm <?php echo $statusFilter === $s ? 'crm-btn-primary' : 'crm-btn-ghost'; ?>"><?php echo $s; ?></a>
    <?php endforeach; ?>
</div>

<div class="crm-card" style="padding:0;">
    <?php if (empty($docs)): ?>
    <div class="crm-empty">No documents found.</div>
    <?php else: ?>
    <div class="crm-table-wrap">
    <table class="crm-table">
        <thead><tr><th>File</th><th>Category</th><th>Customer</th><th>Enquiry</th><th>Size</th><th>Status</th><th>Uploaded</th><th>Actions</th></tr></thead>
        <tbody>
        <?php foreach ($docs as $doc): ?>
        <tr>
            <td><a href="document.php?id=<?php echo (int) $doc['id']; ?>"><?php echo htmlspecialchars($doc['original_filename']); ?></a></td>
            <td><?php echo htmlspecialchars($doc['category']); ?></td>
            <td><?php echo htmlspecialchars($doc['full_name']); ?></td>
            <td><a href="enquiry.php?ref=<?php echo urlencode($doc['enquiry_ref']); ?>#documents"><?php echo htmlspecialchars($doc['enquiry_ref']); ?></a></td>
            <td><?php echo round($doc['file_size'] / 1024); ?> KB</td>
            <td><span class="crm-doc-status doc-<?php echo strtolower($doc['status']); ?>"><?php echo htmlspecialchars($doc['status']); ?></span></td>
            <td class="crm-cell-sub"><?php echo substr($doc['uploaded_at'], 0, 10); ?></td>
            <td>
                <form method="post" style="display:inline;"><input type="hidden" name="doc_id" value="<?php echo (int) $doc['id']; ?>"><input type="hidden" name="decision" value="Verified"><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-check" style="color:var(--c-green);"></i></button></form>
                <form method="post" style="display:inline;"><input type="hidden" name="doc_id" value="<?php echo (int) $doc['id']; ?>"><input type="hidden" name="decision" value="Rejected"><button type="submit" class="crm-btn crm-btn-ghost crm-btn-sm"><i class="fa-solid fa-xmark" style="color:var(--c-red);"></i></button></form>
            </td>
        </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
    </div>
    <?php endif; ?>
</div>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
