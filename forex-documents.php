<?php
$page_title = "Upload Forex Documents &ndash; Visa Agency";
$page_description = "Upload your supporting documents for your VisaAgency.in forex request.";
require_once __DIR__ . '/includes/forex-db.php';
include __DIR__ . '/includes/header.php';

$pdo = forex_db();
$ref = trim($_GET['ref'] ?? '');
$token = trim($_GET['token'] ?? '');
$request = ($ref !== '' && $token !== '') ? forex_request_by_token($pdo, $ref, $token) : null;

$existingDocs = [];
$requiredDocs = [];
if ($request) {
    $requiredDocs = forex_required_docs_for_country($pdo, $request['country_visit']);
    $stmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = ? AND id IN (
        SELECT MAX(id) FROM forex_documents WHERE forex_request_id = ? GROUP BY doc_type
    )');
    $stmt->execute([$request['id'], $request['id']]);
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $d) {
        $existingDocs[$d['doc_type']] = $d;
    }
}
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Forex Documents</h1>
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
                    <?php if (!$request): ?>
                    <div style="text-align:center; padding:20px 0;">
                        <div class="b2b-success-icon" style="color:#C0392B;"><i class="fa-solid fa-triangle-exclamation" aria-hidden="true"></i></div>
                        <h2>Link Not Valid</h2>
                        <p class="b2b-reg-sub">This upload link is invalid or has expired. Please use the link from your enquiry confirmation email, or start a new enquiry.</p>
                        <a href="forex-enquiry" class="qe-btn-primary">Start a Forex Enquiry</a>
                    </div>
                    <?php else: ?>
                    <h2>Upload Documents</h2>
                    <p class="b2b-reg-sub"><?php echo htmlspecialchars($request['full_name']); ?> &middot; Forex Reference <strong><?php echo htmlspecialchars($request['forex_ref']); ?></strong></p>

                    <div class="b2b-doc-grid" id="fxDocGrid">
                        <?php foreach (FOREX_DOC_TYPES as $docKey => $docLabel):
                            if (empty($requiredDocs[$docKey])) { continue; }
                            $existing = $existingDocs[$docKey] ?? null;
                        ?>
                        <div class="b2b-doc-box" data-doc-type="<?php echo htmlspecialchars($docKey); ?>">
                            <div class="b2b-doc-box-head">
                                <strong><?php echo htmlspecialchars($docLabel); ?></strong>
                                <span class="b2b-doc-badge <?php echo $existing ? forex_doc_status_class($existing['status']) : 'b2b-doc-pending'; ?>" data-doc-status>
                                    <?php echo $existing ? htmlspecialchars($existing['status']) : 'Not Uploaded'; ?>
                                </span>
                            </div>
                            <?php if ($existing && $existing['status'] === 'Rejected'): ?>
                            <p class="b2b-doc-reject-note"><i class="fa-solid fa-circle-info" aria-hidden="true"></i> <?php echo htmlspecialchars($existing['rejection_reason'] ?: 'Please re-upload.'); ?></p>
                            <?php endif; ?>
                            <div class="b2b-doc-box-body">
                                <?php if ($existing && $existing['stored_filename']): ?>
                                <span class="b2b-doc-filename" data-doc-filename><i class="fa-solid fa-file-lines" aria-hidden="true"></i> <?php echo htmlspecialchars($existing['original_filename']); ?></span>
                                <?php else: ?>
                                <span class="b2b-doc-filename-empty" data-doc-filename>No file uploaded yet</span>
                                <?php endif; ?>
                                <label class="b2b-doc-upload-btn">
                                    <?php echo $existing && $existing['stored_filename'] ? 'Replace' : 'Upload'; ?>
                                    <input type="file" class="b2b-doc-file-input" accept=".pdf,.jpg,.jpeg,.png" hidden>
                                </label>
                            </div>
                            <span class="b2b-doc-progress" hidden></span>
                        </div>
                        <?php endforeach; ?>
                    </div>
                    <p class="b2b-doc-hint">Accepted formats: PDF, JPG, JPEG, PNG. Maximum 5 MB per file.</p>
                    <div class="b2b-success-actions" style="margin-top:24px;">
                        <a href="forex-track?ref=<?php echo urlencode($request['forex_ref']); ?>" class="qe-btn-primary">Track This Request</a>
                    </div>
                    <?php endif; ?>
                </div>
            </div>
        </section>

<?php if ($request): ?>
<script>
var FX_DOC_REF = <?php echo json_encode($request['forex_ref']); ?>;
var FX_DOC_TOKEN = <?php echo json_encode($token); ?>;
</script>
<script src="assets/js/forex-documents.js"></script>
<?php endif; ?>
<?php include __DIR__ . '/includes/footer.php'; ?>
