<?php
$page_title = "Upload Partner Documents &ndash; Visa Agency";
$page_description = "Upload your B2B partner application documents.";
require_once __DIR__ . '/includes/b2b-db.php';
include __DIR__ . '/includes/header.php';

$pdo = b2b_db();
$ref = trim($_GET['ref'] ?? '');
$token = trim($_GET['token'] ?? '');
$partner = ($ref !== '' && $token !== '') ? b2b_partner_by_token($pdo, $ref, $token) : null;

$existingDocs = [];
if ($partner) {
    $stmt = $pdo->prepare('SELECT * FROM b2b_partner_documents WHERE partner_id = ? AND id IN (
        SELECT MAX(id) FROM b2b_partner_documents WHERE partner_id = ? GROUP BY doc_type
    )');
    $stmt->execute([$partner['id'], $partner['id']]);
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $d) {
        $existingDocs[$d['doc_type']] = $d;
    }
}
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Partner Documents</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Upload Documents</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="section-padding fix b2b-reg-section">
            <div class="container">
                <div class="b2b-reg-card">
                    <?php if (!$partner): ?>
                    <div style="text-align:center; padding:20px 0;">
                        <div class="b2b-success-icon" style="color:#C0392B;"><i class="fa-solid fa-triangle-exclamation" aria-hidden="true"></i></div>
                        <h2>Link Not Valid</h2>
                        <p class="b2b-reg-sub">This upload link is invalid or has expired. Please use the link from your application confirmation email, or contact your Relationship Manager.</p>
                        <a href="b2b-partners" class="qe-btn-primary">Back to B2B Partners</a>
                    </div>
                    <?php else: ?>
                    <h2>Upload Documents</h2>
                    <p class="b2b-reg-sub"><?php echo htmlspecialchars($partner['company_name']); ?> &middot; Application <strong><?php echo htmlspecialchars($partner['application_ref']); ?></strong></p>

                    <div class="b2b-doc-grid" id="b2bDocGrid">
                        <?php foreach (B2B_DOC_TYPES as $docKey => $docLabel):
                            if ($docKey === 'IATA' && !$partner['iata_registered']) { continue; }
                            $existing = $existingDocs[$docKey] ?? null;
                        ?>
                        <div class="b2b-doc-box" data-doc-type="<?php echo htmlspecialchars($docKey); ?>">
                            <div class="b2b-doc-box-head">
                                <strong><?php echo htmlspecialchars($docLabel); ?></strong>
                                <span class="b2b-doc-badge <?php echo $existing ? b2b_doc_status_class($existing['status']) : 'b2b-doc-pending'; ?>" data-doc-status>
                                    <?php echo $existing ? htmlspecialchars($existing['status']) : 'Not Uploaded'; ?>
                                </span>
                            </div>
                            <?php if ($existing && $existing['status'] === 'Rejected'): ?>
                            <p class="b2b-doc-reject-note"><i class="fa-solid fa-circle-info" aria-hidden="true"></i> <?php echo htmlspecialchars($existing['rejection_reason'] ?: 'Please re-upload.'); ?></p>
                            <?php endif; ?>
                            <div class="b2b-doc-box-body">
                                <?php if ($existing && $existing['stored_filename']): ?>
                                <a href="b2b-document-view.php?id=<?php echo (int) $existing['id']; ?>&amp;token=<?php echo htmlspecialchars($token); ?>" target="_blank" rel="noopener" class="b2b-doc-filename" data-doc-filename>
                                    <i class="fa-solid fa-file-lines" aria-hidden="true"></i> <?php echo htmlspecialchars($existing['original_filename']); ?>
                                </a>
                                <?php else: ?>
                                <span class="b2b-doc-filename-empty" data-doc-filename>No file uploaded yet</span>
                                <?php endif; ?>
                                <label class="b2b-doc-upload-btn">
                                    <?php echo $existing ? 'Replace' : 'Upload'; ?>
                                    <input type="file" class="b2b-doc-file-input" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" hidden>
                                </label>
                            </div>
                            <span class="b2b-doc-progress" hidden></span>
                        </div>
                        <?php endforeach; ?>
                    </div>
                    <p class="b2b-doc-hint">Accepted formats: PDF, JPG, JPEG, PNG, DOC, DOCX. Maximum 10 MB per file.</p>
                    <div class="b2b-success-actions" style="margin-top:24px;">
                        <a href="/" class="qe-btn-primary">Done &mdash; Back to Website</a>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </section>

<?php if ($partner): ?>
<script>
var B2B_DOC_REF = <?php echo json_encode($partner['application_ref']); ?>;
var B2B_DOC_TOKEN = <?php echo json_encode($token); ?>;
</script>
<script src="assets/js/b2b-partner-documents.js"></script>
<?php endif; ?>
<?php include __DIR__ . '/includes/footer.php'; ?>
